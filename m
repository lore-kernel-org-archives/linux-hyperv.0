Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E23372ECF;
	Thu,  1 Oct 2026 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818896; cv=none; b=mLpIJ7/ZT20HCo1iEjUHSAx+16AtA3cvmL/m/zy7aEVmB7TljQfWhXoEJK0m/jwNh5YJBJskCOsL6WM9Ft2a4ZK6mPQdFlY8sUOLLli4HG2j+sAhDQuMTWGOEJx11oiL0wwHN/t1FKcZmQMW2iG7qGSPiJlzaAyfZgsP6DPg9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818896; c=relaxed/simple;
	bh=trdGWZPjutV/oM+Pbz+ehOcxJxOdiNgfq4MtdaYN06o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeqFZnn139cg9WaqeEQVOrYkPSYVnoe/oFk/0HNw0IRt43BO5ZNxIILAvCvAMwwkrwKSkSX4oE/fgRr+ZXBI2Q3p7UrPHkkQbQ1eK27DxKb96w0DwNUXQShh0j5Dy+mknr0Dd4EyIlGugaFtzgoEycreoXUrHlDjMPZMEtb4akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3IElsyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3IElsyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497331F0089D;
	Thu,  1 Oct 2026 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818894;
	bh=0zzPbZgiTXaBIOgonEb2QGUgSTefMn6iFVXvXY/A/gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3IElsyd8pUKCmCTdSb+cKUBKMxVVaxJ7rIu1BcsWTSS3Wt5kuMmWBMsDjyHnIl10
	 73B2JWR9tjddMmiyHleGuf3JXUwR0dabNdzzjmRfhQib2xPCe86CVXSZQvisrA27Gj
	 iAanuNd9mBo7pwTqfnccWgoSn5+RLdyqwxHMis5obCvXNXcXb+AoLagGYIDrBOQuqN
	 24JcvTGVDQ2VtwpNh5A2R4abE5dNbgOjSrzlBncLcd2/2NvgZQ9/9Pishynsbj15Em
	 7vliLV/5YnS41AzO9sV3yfejXQi/d3zIq5gIPiwi0D2ynWmqVWI2xPjsqtgWrzh5W0
	 cjTd/qpSZILoA==
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
Subject: [PATCH net-next 2/5] hv_netvsc: hold the VF's instance lock when installing XDP on it
Date: Wed, 30 Sep 2026 18:41:28 -0700
Message-ID: <20261001014131.310771-3-kuba@kernel.org>
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

netvsc_vf_setxdp() has two kinds of callers. netvsc_register_vf() runs
with the VF's instance lock already held, either by the NETDEV_REGISTER
notifier or by netvsc_probe() taking it, which is why the propagation
moved to the caller-locked netif_xdp_propagate(). netvsc_bpf() runs with
just RTNL, so the VF's ndo_bpf() gets called unlocked. For a VF with an
ops lock that trips the lockdep assertion in
dev_get_min_mp_channel_count(), which netif_xdp_propagate() calls, and
races with binding a memory provider, which takes only the instance
lock.

Take the VF's lock in netvsc_bpf().

Reported by Sashiko during core rework. Unverified and untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/hyperv/netvsc_bpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 731bb7721fe2..951c19ce15eb 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -14,6 +14,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/kernel.h>
+#include <net/netdev_lock.h>
 #include <net/xdp.h>
 
 #include <linux/mutex.h>
@@ -162,6 +163,7 @@ int netvsc_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return 0;
 }
 
+/* Caller holds the VF's lock, see netdev_lock_ops() */
 int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 {
 	struct netdev_bpf xdp;
@@ -172,6 +174,8 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	if (!vf_netdev)
 		return 0;
 
+	netdev_assert_locked_ops_compat(vf_netdev);
+
 	if (!vf_netdev->netdev_ops->ndo_bpf)
 		return 0;
 
@@ -210,7 +214,15 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		if (ret)
 			return ret;
 
-		ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
+		/* Unlike netvsc_register_vf() we don't get the VF's lock
+		 * handed to us here.
+		 */
+		ret = 0;
+		if (vf_netdev) {
+			netdev_lock_ops(vf_netdev);
+			ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
+			netdev_unlock_ops(vf_netdev);
+		}
 
 		if (ret) {
 			netdev_err(dev, "vf_setxdp failed:%d\n", ret);
-- 
2.55.0

