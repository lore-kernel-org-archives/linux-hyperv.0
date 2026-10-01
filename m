Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2ED375ADC;
	Thu,  1 Oct 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818897; cv=none; b=jdxiW50ync44teuV88YgShsEqSZVl2CA6HLJcyEFOmp50IXYEdUtIPYQBRc0N3dRq2ITjcJiuABDpFykv9z5VCj8Opc5chfjQXUbavBGjy2GULSbeo/LRUnSzwkXWp5YD80B2l6YwmOv2nu6+Pttd5bMOBri2ovA2Dpm2mAuy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818897; c=relaxed/simple;
	bh=GbjDCOwZBg/3ou9sV3Vs6nl2D5PazXu/CBDAHh8wc5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm7FTKQTobxRwB+3Mg4Yp3b2ta45LjPG1mjApqg1w46KOxKK+Q7E+jPtcmyoLWqQomQluBsuJLaH3x6GusptMdtNMThNfKSnKfR6Jt+zaUh1KHcHPg/5Ze1LTqfiklyfRpikmzzOf2fYn8jwM0EFcJclL2Ilon9YxjzZ7G6qa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvCzPz40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvCzPz40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D421F0089A;
	Thu,  1 Oct 2026 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790818895;
	bh=UcxDIxF8bGbaw6fKz/6k+MxQOXw9RmOat4MyuXsgaPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvCzPz40bUInx+3+17iOUtkgx5NikWh20gSuzvJI6+p9+LUOXkhwqf7zmAsiCvApx
	 ganrah0gPp4oUnb/zfZ2sMF8Yg4tW+utD3UV6FrKwHFR+mojpqFYR00+CRrYih44Uv
	 /Z4ZbnYnhXsJ1ch6WcENu3qRrIwQ/MA7KXTPB+4I2mUII/tq+kADSIl2XVRIwyc8Ph
	 ZKB3fUwvTAliGa8Ev3xbF3QDtqTLmyFnN5TpfWMWS704WbykAttsb55j6TznIjEhb7
	 cQPoaW00Rwn6QfYVT2TxuNmjZJiVwGTDCBgo6ss56N1GFEnXxTRwWhc5rk4sihuAC6
	 sE02nFCZzOZMg==
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
Subject: [PATCH net-next 3/5] hv_netvsc: treat the VF's XDP program the way bonding treats a slave's
Date: Wed, 30 Sep 2026 18:41:29 -0700
Message-ID: <20261001014131.310771-4-kuba@kernel.org>
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

netvsc_register_vf() pushes netvsc's XDP state down to every VF it
takes over - its program, or NULL if it has none - once the VF has
joined, and ignores the result. A VF which refuses the program leaves
netvsc running XDP on its channels while traffic through the VF
bypasses it, with nothing in the logs to say so. The core won't install
a single-buffer program on a device with tcp-data-split enabled, nor
any program on one with a memory provider, and the VF's driver has
conditions of its own. A VF which runs a program of its own gets it
replaced or removed behind the back of whoever attached it, and the
core is about to refuse propagating over a device's own program anyway.

Nothing takes netvsc's program back when the VF stops being netvsc's
either. netvsc_unregister_vf() runs when the VF is unregistered, when
either device moves to another netns (netvsc drags the VF along when it
moves itself), when netvsc is unbound or hot-removed, and on rmmod
hv_netvsc, where unregistering the notifier replays NETDEV_UNREGISTER
before netvsc_remove() ever runs. In all but the first case the VF
stays, running netvsc's program with no upper left to own it. We will
soon track in the core if the program is installed from upper; a
leftover would then become the VF's own, and netvsc would refuse to
take the VF back until someone removed it. netvsc_unregister_vf() used
to propagate NULL to the VF, until commit 3ec523304976 ("hv_netvsc: fix
potential deadlock in netvsc_vf_setxdp()") dropped the call on the
grounds that the core cleans up through dev_xdp_uninstall(). That only
runs when the VF itself is unregistered, and doesn't know about
propagated programs at all, so even then the VF's driver keeps its
reference to netvsc's program; mana, for one, leaks it on every VF
removal while netvsc runs XDP.

Do what bonding does with its slaves instead. With no program on netvsc
there is nothing to push down, so leave the VF's program alone. With a
program on netvsc, don't take over a VF which runs one of its own, in
any mode, or which refuses netvsc's; traffic then stays on the synthetic
path, where the program runs, and the log says why. Install the program
before joining the VF, so that a refusal needs no unwinding and nothing
reaches netvsc through the VF without having been through the program,
and sync the VF's features ahead of it, as LRO may keep the VF from
taking XDP; a VF which refuses the program all the same keeps LRO off.
Take the program back when the VF leaves, under the VF's lock, which
none of the paths into netvsc_unregister_vf() hold, once netvsc's rx
handler is gone. Key that on the program on netvsc's channels, the way
bonding keys its release on bond->xdp_prog; a generic program on netvsc
never reached the VF. Let the VF go in netvsc_remove() before the
channels are cleared.

The two halves only work together. The NULL pushed at registration was
all that cleared a program an earlier netvsc instance left on the VF,
and taking the program back without the refusal would strip a VF of its
own program after it was joined despite refusing netvsc's.

netvsc_bpf() already fails attaching a program the VF refuses, so a VF
netvsc uses now always runs netvsc's program when netvsc has one.

Reported by Sashiko during core rework. Unverified and untested.

Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
Fixes: 351e1581395f ("hv_netvsc: Add XDP support")
Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 57 ++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1d43c73fd73f..17c86e749357 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2331,6 +2331,13 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
 		return NOTIFY_DONE;
 
+	prog = netvsc_xdp_get(netvsc_dev);
+	if (prog && dev_xdp_prog_count(vf_netdev)) {
+		netdev_warn(ndev, "not using VF %s, it has an XDP program attached\n",
+			    vf_netdev->name);
+		return NOTIFY_DONE;
+	}
+
 	/* if synthetic interface is a different namespace,
 	 * then move the VF to that namespace; join will be
 	 * done again in that context.
@@ -2349,10 +2356,29 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 		return NOTIFY_DONE;
 	}
 
+	/* Install netvsc's program before joining, so that a VF which
+	 * refuses it never gets used. Syncing the features first turns
+	 * off LRO, which the VF may not run XDP with.
+	 */
+	if (prog) {
+		vf_netdev->wanted_features = ndev->features;
+		netdev_update_features(vf_netdev);
+
+		ret = netvsc_vf_setxdp(vf_netdev, prog);
+		if (ret) {
+			netdev_warn(ndev, "not using VF %s, it refused netvsc's XDP program: %d\n",
+				    vf_netdev->name, ret);
+			return NOTIFY_DONE;
+		}
+	}
+
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
+	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
+		if (prog)
+			netvsc_vf_setxdp(vf_netdev, NULL);
 		return NOTIFY_DONE;
+	}
 
 	dev_hold(vf_netdev);
 	rcu_assign_pointer(net_device_ctx->vf_netdev, vf_netdev);
@@ -2363,9 +2389,6 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 	vf_netdev->wanted_features = ndev->features;
 	netdev_update_features(vf_netdev);
 
-	prog = netvsc_xdp_get(netvsc_dev);
-	netvsc_vf_setxdp(vf_netdev, prog);
-
 	return NOTIFY_OK;
 }
 
@@ -2441,6 +2464,7 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 {
 	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
+	struct netvsc_device *nvdev;
 
 	ndev = get_netvsc_byref(vf_netdev);
 	if (!ndev)
@@ -2453,6 +2477,15 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Only once frames from the VF no longer reach netvsc */
+	nvdev = rtnl_dereference(net_device_ctx->nvdev);
+	if (nvdev && netvsc_xdp_get(nvdev)) {
+		netdev_lock_ops(vf_netdev);
+		netvsc_vf_setxdp(vf_netdev, NULL);
+		netdev_unlock_ops(vf_netdev);
+	}
+
 	netdev_upper_dev_unlink(vf_netdev, ndev);
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
@@ -2664,21 +2697,21 @@ static void netvsc_remove(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
-	if (nvdev) {
+	if (nvdev)
 		cancel_work_sync(&nvdev->subchan_work);
-		netvsc_xdp_set(net, NULL, NULL, nvdev);
-	}
+
+	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
+	if (vf_netdev)
+		netvsc_unregister_vf(vf_netdev);
 
 	/*
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed. Also blocks mtu and channel changes.
 	 */
-	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
-	if (vf_netdev)
-		netvsc_unregister_vf(vf_netdev);
-
-	if (nvdev)
+	if (nvdev) {
+		netvsc_xdp_set(net, NULL, NULL, nvdev);
 		rndis_filter_device_remove(dev, nvdev);
+	}
 
 	unregister_netdevice(net);
 	list_del(&ndev_ctx->list);
-- 
2.55.0

