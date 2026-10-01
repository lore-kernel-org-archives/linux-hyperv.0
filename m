Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0E37B032;
	Thu,  1 Oct 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818898; cv=none; b=hiPOv5QG03AXRD5PUSYvvF7hTO5N56NzpL+QOQifvDXiw2CIbuGGpB8ggH40wt8pJcDxL+oEk55t+goipdJKBj9qXILDgluWyGfyyJ/gRDrd6XlnlKkGb3ht8Jjsr5N9N14GAGCW6Rt0lwyTrvVee6ObqAH6kSalj4I4Lp6KPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818898; c=relaxed/simple;
	bh=7JOUnVxrEtg1WnysAcWzFxPZIgqkXpEQZMuvIMobJXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB02fdd6tV7HImNhByDPOXaeUQFeiXJFYYw2wza0DSOlSOGfXHz/+b9DH2PD3yeVQXNHdCnkqC7/vTXTH5Mk2DEjcOBZBI7imuYxWpikK6WOdRoFIQfgxY02DdBxHH5rX+vUI8S74AsfC3q5AExqG7VhC++i4HqJnv1D/8Pqlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obldfnSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obldfnSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A65F1F000FF;
	Thu,  1 Oct 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818896;
	bh=nFZyFKQATgL/5G1YMrE+c4NdfXKe6jBagFWFsoL3hnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obldfnSYh12bKZEmnLFalnYRd6uz9gXQP3YR0PEbEAW6cMYfD4B5iP2LfM824rZJK
	 yCVrZP9TnvOzbCj/S8x1q21dPN0LB09upRvq5CvLglwHMe9bG/AIhM9INyJoYf+60m
	 5YhowKU+rpoVViUiVlyn0MsyVIZ1Y64GvKUguvv2RppbMpfoE/hsa9y6jNuTCUbxmc
	 05LaNWasa+gbp2WIrgC//CNQJy/j1Zrxi7xVe+lRkPP9BjbUC7bTnFJdCzoqMCt/I7
	 SDA1zcLM7D9Sh/FEUNBqKSOrrmIimKJ5cR72gkuEKXmK2sI3+m2YWYvNQh+QGTIWKW
	 PKWFV8mUVqYUg==
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
Subject: [PATCH net-next 5/5] hv_netvsc: let the core take XDP off a netvsc device that is going away
Date: Wed, 30 Sep 2026 18:41:31 -0700
Message-ID: <20261001014131.310771-6-kuba@kernel.org>
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

netvsc_remove() lets the VF go, taking the XDP program back from it,
takes the program off the channels, then frees the channels and clears
nvdev, and only then unregisters the netdev. dev_xdp_uninstall() still
finds the program in netvsc's xdp_state[] at that point and asks
netvsc_bpf() to remove it, which fails with -ENODEV for the lack of
nvdev. That trips the WARN_ON() in dev_xdp_uninstall() on every unbind
or hot-remove of a netvsc device running native XDP, and returns before
the program is dropped from the XDP dispatcher, which then holds on to
it for good. The core used to ask netvsc for its program first, and
netvsc reported none once nvdev was gone, until commit 7f0a838254bd
("bpf, xdp: Maintain info on attached XDP BPF programs in net_device").

Accept the removal once there are no channels and no VF left to take the
program off, unless suspend parked the program for resume to put back,
as the core would then lose track of it. The core is about to record
the programs uppers propagate as well, which would bring the same to a
netvsc device enslaved to a bond running XDP.

Spotted by AI while reviewing the XDP propagation series. Untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs in net_device")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/hyperv/netvsc_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 951c19ce15eb..7fe38574f66f 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -204,6 +204,12 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	int ret;
 
 	if (!nvdev || nvdev->destroy) {
+		/* The channels and the VF are gone, and so is the program,
+		 * unless suspend parked it for netvsc_resume() to put back.
+		 */
+		if (bpf->command == XDP_SETUP_PROG && !bpf->prog && !vf_netdev &&
+		    !ndevctx->saved_netvsc_dev_info)
+			return 0;
 		return -ENODEV;
 	}
 
-- 
2.55.0

