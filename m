Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8137757A;
	Thu,  1 Oct 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818897; cv=none; b=rxMYBJHz4J7SneVUQioHLv8yLBKJluhhuE3KVKu6SW3m7l/yGiZ4kHbgyU7bndRtJqnpH1qUmLrZWVybLGlNR2x5AzhstAH6SrUxrk1gzERrnOBuo4lx8uyT3MSlSe3sGh6jzkaZg6XAnuSBQUVe/UOebEkuspyBznqGUmDuGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818897; c=relaxed/simple;
	bh=ZohQSylFdRjIMAGijAGdOeA+SsDj/B0BUxOw1ZiV7HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDMoLI9TZ3JhGRQS3QKfpK3DA3LdXRX45+V93XNTlJky3/hq/XJUsxfPAR/dNG2+V3eMAsYb5AObHovDiBFR2yM7K97G7AlctsiN7euS4FIXPkGG2kh6uOdftMGzazzxRqtTwedzjCmrSRjkI3HGv2cH0GVYhBD8Di9fVijoxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy95WR+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy95WR+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7134A1F0089E;
	Thu,  1 Oct 2026 01:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818895;
	bh=L7jSBi4kxjm4OYvSdaKKEPSayUy767obEfXfQVSc0qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iy95WR+6acYHmP4W4hw75lrPBfL7THaWtUlzerjrfArtPObv9vnZagTumVkYbY4ve
	 Sm8z0yxYBf4n6H92bMNEYpci2oljFyNlHFY6Mm3wn55vNGb0n5trfheciUA9MJA5So
	 aKtnyNhpO5/70let93crxTccRJACJCmfpX0GBj47MtwojF8unkdBRoQSbZ2EX/sbF8
	 9ZUTBrBKV61hS1Rh/1LpLPmVpb7gFTz9jTZd5RhUlvvvZEYghV3PR8aPgmANpIOwGc
	 iX64TOtzs0IxMIQRTt+un6vAg+gQjpZdfsoAzPJxptO5NFpx4xCHXqBRoyqXPL2uUW
	 Hi9EumYOYyHGQ==
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
Subject: [PATCH net-next 4/5] hv_netvsc: move a new VF to netvsc's netns from a work item
Date: Wed, 30 Sep 2026 18:41:30 -0700
Message-ID: <20261001014131.310771-5-kuba@kernel.org>
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

When the VF registers in a different netns than netvsc, for example
because it was hot-added into init_net while netvsc lives in a container
netns, netvsc_register_vf() moves it over with dev_change_net_namespace()
straight from the VF's NETDEV_REGISTER notifier. Since commit
4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP") that
notifier runs under the VF's instance lock, which the netns change takes
again. For a VF with an ops lock the registration then deadlocks with
RTNL held, taking the networking of the whole VM down with it. mana
always has an ops lock, as it selects NET_SHAPER, and so does mlx5 for
its queue management ops, so every VF hot-add or servicing event hangs a
VM running netvsc in a netns, as does moving the VF out by hand.

netvsc already leaves moving its VF to vfns_work when netvsc itself
changes netns. Hand the new VF to the same work, holding a reference
until it runs. The VF still joins netvsc when it registers again in
netvsc's netns. If netvsc gets to the VF's netns before the work runs,
for example because netvsc's netns went away, there is no move to
register the VF again, so have the work take the VF over itself.

Spotted by AI while reviewing the XDP propagation series.
Not verified, and untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/hyperv/hyperv_net.h |  3 +++
 drivers/net/hyperv/netvsc_drv.c | 41 +++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 4841367fdab2..5c771fe8d766 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1064,6 +1064,9 @@ struct net_device_context {
 	struct netvsc_vf_pcpu_stats __percpu *vf_stats;
 	struct delayed_work vf_takeover;
 	struct delayed_work vfns_work;
+	/* VF for vfns_work to move to our netns, see netvsc_register_vf() */
+	struct net_device *vfns_dev;
+	netdevice_tracker vfns_dev_tracker;
 
 	/* 1: allocated, serial number is valid. 0: not allocated */
 	u32 vf_alloc;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 17c86e749357..10c05809c065 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2311,6 +2311,12 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	return NOTIFY_DONE;
 }
 
+static void netvsc_vfns_dev_put(struct net_device_context *ndev_ctx)
+{
+	netdev_put(ndev_ctx->vfns_dev, &ndev_ctx->vfns_dev_tracker);
+	ndev_ctx->vfns_dev = NULL;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 {
 	struct net_device_context *net_device_ctx;
@@ -2340,19 +2346,17 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 
 	/* if synthetic interface is a different namespace,
 	 * then move the VF to that namespace; join will be
-	 * done again in that context.
+	 * done again in that context. The VF's lock is held
+	 * for its registration, so leave the move to vfns_work.
 	 */
 	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
-		ret = dev_change_net_namespace(vf_netdev,
-					       dev_net(ndev), "eth%d");
-		if (ret)
-			netdev_err(vf_netdev,
-				   "could not move to same namespace as %s: %d\n",
-				   ndev->name, ret);
-		else
-			netdev_info(vf_netdev,
-				    "VF moved to namespace with: %s\n",
-				    ndev->name);
+		if (net_device_ctx->vfns_dev != vf_netdev) {
+			netvsc_vfns_dev_put(net_device_ctx);
+			netdev_hold(vf_netdev, &net_device_ctx->vfns_dev_tracker,
+				    GFP_KERNEL);
+			net_device_ctx->vfns_dev = vf_netdev;
+		}
+		schedule_delayed_work(&net_device_ctx->vfns_work, 0);
 		return NOTIFY_DONE;
 	}
 
@@ -2695,6 +2699,7 @@ static void netvsc_remove(struct hv_device *dev)
 
 	rtnl_lock();
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
+	netvsc_vfns_dev_put(ndev_ctx);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev)
@@ -2738,6 +2743,7 @@ static int netvsc_suspend(struct hv_device *dev)
 
 	rtnl_lock();
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
+	netvsc_vfns_dev_put(ndev_ctx);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev == NULL) {
@@ -2815,7 +2821,9 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 
 	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
 	if (!vf_netdev)
-		return;
+		vf_netdev = ndev_ctx->vfns_dev;
+	if (!vf_netdev || vf_netdev->reg_state != NETREG_REGISTERED)
+		goto out;
 
 	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
 		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
@@ -2828,7 +2836,16 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 			netdev_info(vf_netdev,
 				    "Moved VF to namespace with: %s\n",
 				    ndev->name);
+	} else if (!rtnl_dereference(ndev_ctx->vf_netdev)) {
+		/* netvsc got to the VF's netns first, so no move will
+		 * register the VF again, take it over from here
+		 */
+		netdev_lock_ops(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_NOTIFIER);
+		netdev_unlock_ops(vf_netdev);
 	}
+out:
+	netvsc_vfns_dev_put(ndev_ctx);
 }
 
 void netvsc_vfns_work(struct work_struct *w)
-- 
2.55.0

