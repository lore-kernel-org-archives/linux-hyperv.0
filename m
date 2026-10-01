Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AA36D9EB;
	Thu,  1 Oct 2026 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818895; cv=none; b=Svcoje85Vi3lrdfntFhKv6rrw6he52BX6qlecJY/81ympx0epTLzLb2fdmv6p2NLZ2nKoobk2JlqttdDs5KmD8X4ynbDAoIElxY+aNPBfJrJJ9Mk6O6XZx8PjGYFq2b0ryW7AT44kcDDj/QJMO9Cm8dh7f6IhQL1DmeUlyqhbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818895; c=relaxed/simple;
	bh=yWSgJYMmNM26CbqbfyEiL8sgM4xmaqhfZAG7UozIqBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkqrvhuwnVbBeVox/ZYhJFArkfLp8qD2LqAf0akBBXnJU6Non3IF58z7KRv7QEKfW9jt93Y4SPtTJkJm20rfBRTfl71D5Zqu2b22OCRal/T9h0LVc3pr5gfKGwwM57uekhFEuJOKuirblQXQe1Y4rOA8gwn4k3OI2Z7IpR9Q6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2rXIO+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2rXIO+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B017A1F00898;
	Thu,  1 Oct 2026 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818894;
	bh=U+h71nieCa2Y+wf83pJzbfGlJJQQlauxbW2ormLYBVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2rXIO+qn0wDGr1WMbP+8Y7xDVxd+r9A9pxJFIqS2hcO19yhRyQ1d3o8CHDEm6gR1
	 V/mnso8dOz7XT7bSEYIKpGankJPhe4qh6QVtZ6MMjLdDofyludGUG3W1dfdHR3xRZ0
	 d6RpDmA8mxFplrSVKqHrVGRdGow6AkyGAI86bNBJqdnDxOp2a4P7VkwrAIy6SRBhNP
	 pSudjfM06RC1DB14aNNqbadw8ruwaRW5Un9JN3rSoUZ4vVndmE8OvzLJ7gMvrNP1O/
	 06pdIibAavLxcNMlVRcZ1zSHqZkHJrIzUW1A1Dy5id1QIhXC3BLcxcmGtwsqWS7Jva
	 M1PhHjDqF+vBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	hawk@kernel.org,
	andriin@fb.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH net-next 1/5] hv_netvsc: fix the program refcount when the VF refuses XDP
Date: Wed, 30 Sep 2026 18:41:27 -0700
Message-ID: <20261001014131.310771-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001014131.310771-1-kuba@kernel.org>
References: <20261001014131.310771-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndo_bpf() takes over the reference it is passed only on success, the
caller puts it back itself on failure. netvsc_xdp_set() takes that one
plus num_chn - 1 more for its channels, and the rollback after the VF
refuses the program clears the channels again, putting all num_chn of
them. dev_xdp_install() then puts the one it passed in a second time,
and the program can be freed while the fd which loaded it still points
at it.

The VF refuses a program netvsc has already committed to when the
program is single-buffer and the VF has header-data split enabled, when
the VF has a memory provider bound, or when the VF's driver has
conditions of its own.

Reported by Sashiko during core rework. Unverified and untested.

Cc: stable+noautosel@kernel.org # untested fix to unlikely driver error path
Fixes: 184367dce4f7 ("hv_netvsc: Fix XDP refcnt for synthetic and VF NICs")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/hyperv/netvsc_bpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 1dd3755d9e6d..731bb7721fe2 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -216,6 +216,13 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 			netdev_err(dev, "vf_setxdp failed:%d\n", ret);
 			NL_SET_ERR_MSG_MOD(extack, "vf_setxdp failed");
 
+			/* Since we haven't completed the installation
+			 * of bpf->prog the reference core implicitly
+			 * transfers to us on success isn't ours.
+			 * Take a reference to balance the accounting.
+			 */
+			if (bpf->prog)
+				bpf_prog_inc(bpf->prog);
 			netvsc_xdp_set(dev, NULL, extack, nvdev);
 		}
 
-- 
2.55.0

