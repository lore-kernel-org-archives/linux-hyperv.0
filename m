Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962396;
	b=ykNHrtBepYnCxotF4lhYLwrnzN66tFXqiF9VVpgMz8xrgNNYAWuOtJ0As3vMdD3MUcja
	 vqXwv91wUizEK+Bf+n6tzFYtqWtDnpReGJ4TZXYgxv5eUBDQKvlt4ml36s0pYK6t6K2uh
	 8jEQaWXp8k6+MrhGVpyDXPVbjqriRJtWi/gAKcJ/g+N/pAq+wcTDxBTfgU9o4p/lWF0gf
	 08+q3cpsmFsW/zHGSu5Rtazry2SdevJexYIbvx8A9dqdf1dlnsB4BCNrIA66SivLSNfG3
	 HCUjGikI09S2yNGyDvBowOgggTEjkR7nQ/wvCPOPqHXYaN8UQA0/rXUO7edmBjKU1GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962396;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=VWRzHZisTKFuvIW/bz2nwtPUBJRPppjOU+MvS3dSz9A=;
	b=hpoi8LffV2k/aGzYj3qUSMMSDU1BO1rPhEhK/dxQtbNGlvTqv69MeDtCEPfZzW0jez3W
	 4j0mQfV7krZn12lCLsnvoFy2K7t8AjCcJ0XrcukiUR/EZg+dk48X70SsSY8dRNwlymdNZ
	 rZKwdvtjlxmRwO4pnf48jPZ507Ef+3H2RbD0bycWOurS2wUKwQgBiULVw1YNKdaX+/Fka
	 XxQ/BHJwSP0WY/fsz2gR/TBr8erhpcNGviq9MI1La9UCLa2Zc76QD5iApcNYqewV6Zd2P
	 OAMG0OFaOPuGOyw14zoE/2/hvxwhtbOX6WFUGNrTKtpjMqiLe+Ktx8zK5egOkX4sG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=WGNDFW6h;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BE6606A886;
	Wed, 18 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BE6606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=WGNDFW6h
Received: from [10.4.158.9] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 604B220B7169;
	Tue, 17 Nov 2026 16:39:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 604B220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794962392;
	bh=VWRzHZisTKFuvIW/bz2nwtPUBJRPppjOU+MvS3dSz9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WGNDFW6hqQdiF0SHyfjp75RtfxwwRi6iicLcOM4zUPSA0lYp/8+si3Ys+pTOC74qj
	 +cbulApSLigarrgBVCr/r36dvTyYwxab2NMllactcDE3olK0i4a5BkdLtb4YykpmDN
	 1yC/Jxs+tWKWpu90I9ef6urUZB64c6Y8RpC3rlY0=
Message-ID: <dc137a5c-66ee-429e-944a-58a802ebfb97@linux.microsoft.com>
Date: Tue, 17 Nov 2026 16:39:48 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] hv_netvsc: treat the VF's XDP program the
 way bonding treats a slave's
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 ernis@linux.microsoft.com,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20261109194843.1353592-1-kuba@kernel.org>
 <20261109194843.1353592-4-kuba@kernel.org>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261109194843.1353592-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/2026 11:48 AM, Jakub Kicinski wrote:
> netvsc_register_vf() pushes netvsc's XDP state down to every VF it
> takes over - its program, or NULL if it has none - once the VF has
> joined, and ignores the result. A VF which refuses the program leaves
> netvsc running XDP on its channels while traffic through the VF
> bypasses it, with nothing in the logs to say so. The core won't install
> a single-buffer program on a device with tcp-data-split enabled, nor
> any program on one with a memory provider, and the VF's driver has
> conditions of its own. A VF which can't run XDP at all isn't even
> asked, and netvsc_bpf() reports success for it too. A VF which runs a
> program of its own gets it replaced or removed behind the back of
> whoever attached it, when it joins as well as when netvsc gets a
> program later.
> 
> Nothing takes netvsc's program back when the VF stops being netvsc's
> either. netvsc_unregister_vf() runs when the VF is unregistered, when
> either device moves to another netns (netvsc drags the VF along when it
> moves itself), when netvsc is unbound or hot-removed, and on rmmod
> hv_netvsc, where unregistering the notifier replays NETDEV_UNREGISTER
> before netvsc_remove() ever runs. In all but the first case the VF
> stays, running netvsc's program with no upper left to own it. We will
> soon track in the core if the program is installed from upper; a
> leftover would then become the VF's own, and netvsc would refuse to
> take the VF back until someone removed it. netvsc_unregister_vf() used
> to propagate NULL to the VF, until commit 3ec523304976 ("hv_netvsc: fix
> potential deadlock in netvsc_vf_setxdp()") dropped the call on the
> grounds that the core cleans up through dev_xdp_uninstall(). That only
> runs when the VF itself is unregistered, and doesn't know about
> propagated programs at all, so even then the VF's driver keeps its
> reference to netvsc's program; mana, for one, leaks it on every VF
> removal while netvsc runs XDP.
> 
> Do what bonding does with its slaves instead. With no program on netvsc
> there is nothing to push down, so leave the VF's program alone. With a
> program on netvsc, don't take over a VF which runs one of its own, in
> any mode, or which can't or won't run netvsc's, and say why in the log.
> netvsc then keeps its traffic on the synthetic path, where the program
> runs, and doesn't use the VF. Nothing retries taking the VF over until
> it registers again, just as bonding doesn't retry an enslave it refused.
> For a VF already in use fail attaching the program to netvsc instead, as
> netvsc_bpf() already did when the VF refused it, but don't fail a
> removal over the VF's own program, leave that program be. Install the
> program before joining the VF, so that a refusal needs no unwinding and
> nothing reaches netvsc through the VF without having been through the
> program, and sync the VF's features ahead of it, as LRO may keep the VF
> from taking XDP; a VF which refuses the program all the same is left
> with netvsc's features. Take the program back when the VF leaves, under
> the VF's lock, which none of the paths into netvsc_unregister_vf() hold,
> once netvsc's rx handler is gone, and warn if the VF won't let go of it,
> as bonding does, but leave a program of the VF's own be, as on removal.
> Key that on the program on netvsc's channels, the way bonding keys its
> release on bond->xdp_prog; a generic program on netvsc never reached the
> VF. Let the VF go in netvsc_remove() before the channels are cleared.
> 
> The two halves only work together. The NULL pushed at registration was
> all that cleared a program an earlier netvsc instance left on the VF,
> and taking the program back without the refusal would strip a VF of its
> own program after it was joined despite refusing netvsc's.
> 
> A VF netvsc uses now always runs netvsc's program when netvsc has one.
> Update netvsc's documentation, which still said that a program on the
> VF may get overwritten, and describe the VFs netvsc doesn't use.
> 
> Reported by Sashiko during core rework. Unverified and untested.
> 
> Cc: stable+noautosel@kernel.org # LLM report + LLM fix, untested
> Fixes: 351e1581395f ("hv_netvsc: Add XDP support")
> Fixes: 3ec523304976 ("hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - refuse a VF which can't run XDP while netvsc has a program, and fail
>    attaching a program to netvsc while such a VF is in use (Sashiko)
>  - fail attaching a program to netvsc while the VF in use runs one of
>    its own, rather than leave that to the core series, but leave the
>    VF's program be on removal, and when the VF leaves (Sashiko)
>  - warn when the VF won't give netvsc's program back (Sashiko)
>  - move the documentation update here from the core series, and don't
>    claim that the refused VF's traffic stays on the synthetic path
>    (Vennela)
>  - commit msg: say that nothing retries a refused VF, and that it keeps
>    netvsc's features (Sashiko)
>  - Tested-by tags from v1 not carried over, the behavior changed
> v1: https://lore.kernel.org/20261001014131.310771-4-kuba@kernel.org
> ---
>  .../ethernet/microsoft/netvsc.rst             | 11 +++-
>  drivers/net/hyperv/netvsc_bpf.c               | 15 ++++-
>  drivers/net/hyperv/netvsc_drv.c               | 65 +++++++++++++++----
>  3 files changed, 76 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
> index 0d464706a59a..7f1731a819f9 100644
> --- a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
> +++ b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
> @@ -109,8 +109,15 @@ XDP support
>  
>    Setting / unsetting XDP program on synthetic NIC (netvsc) propagates to
>    VF NIC automatically. Setting / unsetting XDP program on VF NIC directly
> -  is not recommended, also not propagated to synthetic NIC, and may be
> -  overwritten by setting of synthetic NIC.
> +  is not recommended, and not propagated to synthetic NIC. If the
> +  synthetic NIC has a program when a VF NIC shows up, a VF NIC which runs
> +  a program of its own, or which can't or won't run the synthetic NIC's,
> +  is not used until it is registered again. The synthetic NIC then keeps
> +  its traffic on the synthetic data path; what the VF NIC receives if it
> +  is brought up on its own is outside of the synthetic NIC's control.
> +  For a VF NIC already in use which runs a program of its own, or can't
> +  or won't run the synthetic NIC's, setting the program on the synthetic
> +  NIC fails instead.
>  
>    XDP program cannot run with LRO (RSC) enabled, so you need to disable LRO
>    before running XDP::
> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index ec8edfaebf0b..143fc0c12841 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -176,8 +176,9 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
>  
>  	netdev_assert_locked_ops_compat(vf_netdev);
>  
> +	/* as with bonding, a VF which can't run XDP can't carry ours */
>  	if (!vf_netdev->netdev_ops->ndo_bpf)
> -		return 0;
> +		return prog ? -EOPNOTSUPP : 0;
>  
>  	memset(&xdp, 0, sizeof(xdp));
>  
> @@ -210,6 +211,18 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  
>  	switch (bpf->command) {
>  	case XDP_SETUP_PROG:
> +		/* The VF's own program is not ours: refuse to install over
> +		 * it, as bonding does, and leave it be on removal.
> +		 */
> +		if (vf_netdev && dev_xdp_prog_count(vf_netdev)) {
> +			if (bpf->prog) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "VF has an XDP program of its own");
> +				return -EOPNOTSUPP;
> +			}
> +			vf_netdev = NULL;
> +		}
> +
>  		/* Hold on to the old program, to put it back on the channels
>  		 * if the VF refuses the change.
>  		 */
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1d43c73fd73f..61109ff9927f 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2331,6 +2331,13 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
>  		return NOTIFY_DONE;
>  
> +	prog = netvsc_xdp_get(netvsc_dev);
> +	if (prog && dev_xdp_prog_count(vf_netdev)) {
> +		netdev_warn(ndev, "not using VF %s, it has an XDP program attached\n",
> +			    vf_netdev->name);
> +		return NOTIFY_DONE;
> +	}
> +
>  	/* if synthetic interface is a different namespace,
>  	 * then move the VF to that namespace; join will be
>  	 * done again in that context.
> @@ -2349,10 +2356,31 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  		return NOTIFY_DONE;
>  	}
>  
> +	/* Install netvsc's program before joining, so that a VF which
> +	 * refuses it never gets used. Syncing the features first turns
> +	 * off LRO, which the VF may not run XDP with.
> +	 */
> +	if (prog) {
> +		vf_netdev->wanted_features = ndev->features;
> +		netdev_update_features(vf_netdev);
> +
> +		ret = netvsc_vf_setxdp(vf_netdev, prog);
> +		if (ret) {
> +			netdev_warn(ndev, "not using VF %s, it refused netvsc's XDP program: %d\n",
> +				    vf_netdev->name, ret);
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
>  	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
>  
> -	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
> +	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
> +		ret = prog ? netvsc_vf_setxdp(vf_netdev, NULL) : 0;
> +		if (ret)
> +			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
> +				    vf_netdev->name, ret);
>  		return NOTIFY_DONE;
> +	}

If netvsc_vf_join() fails here, did we potentially just
netdev_update_features() a VF we don't own? Can we restore the old
features on failure? And / or reject VFs with a busy RX handler before
making feature changes?

>  
>  	dev_hold(vf_netdev);
>  	rcu_assign_pointer(net_device_ctx->vf_netdev, vf_netdev);
> @@ -2363,9 +2391,6 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  	vf_netdev->wanted_features = ndev->features;
>  	netdev_update_features(vf_netdev);
>  
> -	prog = netvsc_xdp_get(netvsc_dev);
> -	netvsc_vf_setxdp(vf_netdev, prog);

I think Sashiko has a point that this patch might introduce edge case
issues when netvsc_detach() fails.

I wonder if moving the netvsc_xdp_set() after netif_device_detach() in
netvsc_detach() fixes some of the faiure paths (RNDIS close or ring
drain fails)? I haven't yet fully thought through all the scenarios
Sashiko brought up.

I understand improving XDP accounting is the end goal, but I hope we can
get there without introducing new bugs.

-- 
Regards,
Kameron

> -
>  	return NOTIFY_OK;
>  }
>  
> @@ -2441,6 +2466,8 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  {
>  	struct net_device *ndev;
>  	struct net_device_context *net_device_ctx;
> +	struct netvsc_device *nvdev;
> +	int ret;
>  
>  	ndev = get_netvsc_byref(vf_netdev);
>  	if (!ndev)
> @@ -2453,6 +2480,20 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  
>  	reinit_completion(&net_device_ctx->vf_add);
>  	netdev_rx_handler_unregister(vf_netdev);
> +
> +	/* Take our program back now that frames from the VF no longer
> +	 * reach netvsc, but leave a program of the VF's own be.
> +	 */
> +	nvdev = rtnl_dereference(net_device_ctx->nvdev);
> +	if (nvdev && netvsc_xdp_get(nvdev) && !dev_xdp_prog_count(vf_netdev)) {
> +		netdev_lock_ops(vf_netdev);
> +		ret = netvsc_vf_setxdp(vf_netdev, NULL);
> +		netdev_unlock_ops(vf_netdev);
> +		if (ret)
> +			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
> +				    vf_netdev->name, ret);
> +	}
> +
>  	netdev_upper_dev_unlink(vf_netdev, ndev);
>  	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
>  	dev_put(vf_netdev);
> @@ -2664,21 +2705,21 @@ static void netvsc_remove(struct hv_device *dev)
>  	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
>  
>  	nvdev = rtnl_dereference(ndev_ctx->nvdev);
> -	if (nvdev) {
> +	if (nvdev)
>  		cancel_work_sync(&nvdev->subchan_work);
> -		netvsc_xdp_set(net, NULL, NULL, nvdev);
> -	}
> +
> +	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
> +	if (vf_netdev)
> +		netvsc_unregister_vf(vf_netdev);
>  
>  	/*
>  	 * Call to the vsc driver to let it know that the device is being
>  	 * removed. Also blocks mtu and channel changes.
>  	 */
> -	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
> -	if (vf_netdev)
> -		netvsc_unregister_vf(vf_netdev);
> -
> -	if (nvdev)
> +	if (nvdev) {
> +		netvsc_xdp_set(net, NULL, NULL, nvdev);
>  		rndis_filter_device_remove(dev, nvdev);
> +	}
>  
>  	unregister_netdevice(net);
>  	list_del(&ndev_ctx->list);

