Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFB13957E;
	Sun,  4 Oct 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129777; cv=none; b=q1hdWE5YsafV8sEipOcG5dhnYxE8oL/4iYmOVTptmEpWifcis23ahrhOMJLgPyJJ0PWND97Q6+g76vpnTxZC4I/0NlJnQuxVtH+IXM9ufQesjB95ScYrtabfhqisGlPk0t3M0Hnrux/cOE9FCOalvC2VvFsL6/mx43ups2nB4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129777; c=relaxed/simple;
	bh=TioErjBOQgPIvSjtDvoQqS83aIH9gGdgoT7ydLG5/ck=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSgFw8n3elXMP5J79hd0iOcL0gGxjVhRMQukp1GHD4FDd2215u/IC/CUPPPZW9mZ7G37goE5vC5p3ar3kFHBSmlYVcy/ooQ6Jl/nPGvqTiOYLpE4zo1ODPWhjs0NWADvEv6/nAufuifTcPEWHkFPYA3YMSn4+Ts93moAa0FxnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFf1hpg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFf1hpg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FE91F000FF;
	Sun,  4 Oct 2026 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129775;
	bh=bLa+bTVm0GxiAuRV6EfNI6blogX8z2hZllhocp8QPX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RFf1hpg1BIfMYy1A6285SU9bmaDLGGqE0QHq2XL/hSiBXyJoiMjFh/HE8cdgc3arl
	 3pTZCijhE9tB90kCinxPEEOrfbmKE+W8jdjU5DLLGQENrqwKa63cPcw81Gewv6Hxid
	 kPe+15LddC5KLy9WTrhDOGakUXKuTeqynbDwjRxUMl5rZz1NE6nAOAdJjiwmFIMnti
	 VUcBUMvXDtVd7me0JuCfH1cOMeYvbuy5BxNAMkOwjw0qbYvZaFeG7dFo2svQH6WLhd
	 kKuTLt/fW/lU7dLEPGBTkG1AjGDwYbQZvDLhB3usHx1CVmdQyq/q4tuMY9c/0CRzUw
	 OLhezTT+y44AQ==
Subject: Re: [PATCH net-next 3/5] hv_netvsc: treat the VF's XDP program the
 way bonding treats a slave's
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, linux-hyperv@vger.kernel.org, hawk@kernel.org,
 andriin@fb.com, stable+noautosel@kernel.org
Date: Sun, 04 Oct 2026 16:02:54 +0000
Message-ID: <179112977410.434549.14725947364276122328@kernel.org>
In-Reply-To: <20261001014131.310771-4-kuba@kernel.org>
References: <20261001014131.310771-4-kuba@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netvsc_vf_setxdp() returns 0 without installing anything when
  the VF has no ndo_bpf (drivers/net/hyperv/netvsc_bpf.c:180-181, `if…
- [Medium] netvsc_unregister_vf() only takes the program back from the VF
  when `nvdev && netvsc_xdp_get(nvdev)`, that is, when netvsc's channels…
- [Medium] Two calls to netvsc_vf_setxdp(vf_netdev, NULL) drop their
  result without logging: the new take-back in netvsc_unregister_vf()…
- [Medium] netvsc_register_vf() now refuses a VF with its own program
  (dev_xdp_prog_count(vf_netdev) != 0), but only at join time and only…
- [Medium] Once netvsc refuses a VF at registration, nothing retries the
  takeover.
- [Low] Before installing the program, netvsc_register_vf() now sets
  `vf_netdev->wanted_features = ndev->features;…

Pre-existing issues:
- [High] At this commit, netvsc_register_vf() still calls
  dev_change_net_namespace(vf_netdev, dev_net(ndev), "eth%d") directly…

--

hv_netvsc: treat the VF's XDP program the way bonding treats a slave's

When netvsc has an XDP program, netvsc_register_vf() now refuses a VF
that has its own program or that refuses netvsc's. It also installs
netvsc's program before joining the VF. netvsc_unregister_vf() now takes
netvsc's program back from the VF when the VF leaves, and
netvsc_remove() releases the VF before clearing the channel program.

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1d43c73fd73f1..17c86e7493577 100644
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

[Severity: Medium]
A VF with its own program is only refused here, at join time, and only
when netvsc already has a program. Does netvsc_bpf() need the same
check? It still propagates onto a joined VF without looking at the VF's
own program:

drivers/net/hyperv/netvsc_bpf.c:netvsc_bpf() {
    ...
		if (vf_netdev) {
			netdev_lock_ops(vf_netdev);
			ret = netvsc_vf_setxdp(vf_netdev, bpf->prog);
			netdev_unlock_ops(vf_netdev);
		}
    ...
}

A joined VF can get its own program while netvsc has none.
dev_xdp_attach() on the VF only refuses when an upper has a program,
and nothing checks the lowers when a program is attached to netvsc.
Here is one sequence:

  netvsc has no program, VF joins
  admin attaches P to the VF (allowed, the upper has no program)
  admin attaches Q to netvsc
    netvsc_bpf()->netvsc_vf_setxdp()->netif_xdp_propagate()
      VF driver now runs Q, VF xdp_state still records P
  VF leaves
    netvsc_unregister_vf()->netvsc_vf_setxdp(vf_netdev, NULL)
      VF driver runs nothing, VF xdp_state still reports P

After that, the next netvsc_register_vf() refuses the VF because of a
program that is not running.

Bonding repeats the check for every slave in bond_xdp_set():

		if (dev_xdp_prog_count(slave_dev) > 0) {
			SLAVE_NL_ERR(dev, slave_dev, extack,
				     "Slave has XDP program loaded, please unload before enslaving");

The commit message names this as one of the problems being fixed: "A VF
which runs a program of its own gets it replaced or removed behind the
back of whoever attached it". The core change it mentions ("the core is
about to refuse propagating over a device's own program") is not part
of this series.

> +
>  	/* if synthetic interface is a different namespace,
>  	 * then move the VF to that namespace; join will be
>  	 * done again in that context.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
netns branch here still calls dev_change_net_namespace() directly from
the VF's NETDEV_REGISTER notifier:

	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
		ret = dev_change_net_namespace(vf_netdev,
					       dev_net(ndev), "eth%d");

Since commit 4c975fd70002, register_netdevice() holds the VF's instance
lock across NETDEV_REGISTER. __dev_change_net_namespace() then calls
netdev_lock_ops() on the same VF again.

Can this self-deadlock with RTNL held for ops-locked VFs such as mana or
mlx5? That would happen when netvsc is in a non-init netns and the VF
is hot-added into init_net.

The later patch in this series, "hv_netvsc: move a new VF to netvsc's
netns from a work item", replaces the direct call with a hand-off to
vfns_work, so this is resolved by the end of the series.

[ ... ]

> @@ -2349,10 +2356,29 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
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

[Severity: Low]
This replaces the VF's entire wanted feature set, not only LRO, before
netvsc knows whether it will use the VF. If the VF then refuses the
program, or netvsc_vf_join() fails below, netvsc returns NOTIFY_DONE
and the original wanted_features are not restored.

Is it intended that offloads the user or driver enabled on the VF, and
that netvsc doesn't carry, stay off on a device netvsc doesn't own?
The commit message only mentions LRO: "a VF which refuses the program
all the same keeps LRO off". Before this patch, the full sync only ran
after a successful join.

Would clearing only NETIF_F_LRO here avoid the side effect?

> +
> +		ret = netvsc_vf_setxdp(vf_netdev, prog);

[Severity: High]
Can netvsc_vf_setxdp() return 0 here without installing anything? It
returns early when the VF has no ndo_bpf, before netif_xdp_propagate()
gets the chance to return -EOPNOTSUPP:

drivers/net/hyperv/netvsc_bpf.c:netvsc_vf_setxdp() {
    ...
	if (!vf_netdev->netdev_ops->ndo_bpf)
		return 0;
    ...
}

Suppose netvsc has a native program and the matched VF has no ndo_bpf
(iavf, for example). The refusal branch is then skipped and the VF is
joined. netvsc_vf_handle_frame() hands the VF's frames to netvsc, and
they never go through netvsc's program, which only runs on the synthetic
channels. Nothing is logged.

netvsc_bpf() has the same early return, so attaching a program to
netvsc while such a VF is joined also appears to succeed.

That seems to contradict two statements in the commit message: "nothing
reaches netvsc through the VF without having been through the program"
and "a VF netvsc uses now always runs netvsc's program when netvsc has
one".

Bonding, which this patch follows, refuses such a slave in
bond_enslave():

	if (!slave_dev->netdev_ops->ndo_bpf ||
	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
		if (bond->xdp_prog) {
			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
				     "Slave does not support XDP");

> +		if (ret) {
> +			netdev_warn(ndev, "not using VF %s, it refused netvsc's XDP program: %d\n",
> +				    vf_netdev->name, ret);
> +			return NOTIFY_DONE;
> +		}
> +	}

[Severity: Medium]
Once a VF is refused here, or by the dev_xdp_prog_count() check above,
what brings it back later?

netvsc_register_vf() is only called from netvsc_probe() and from the
VF's NETDEV_REGISTER notifier. The later patch "hv_netvsc: move a new VF
to netvsc's netns from a work item" adds a netns-move path.

netvsc_vf_changed() finds netvsc through get_netvsc_byref(), which needs
the master upper link that a refused VF never gets:

drivers/net/hyperv/netvsc_drv.c:get_netvsc_byref() {
    ...
	dev = netdev_master_upper_dev_get(vf_netdev);
	if (!dev || dev->netdev_ops != &device_ops)
		return NULL;
    ...
}

netvsc_bpf() only touches vf_netdev when a VF is already joined.

So detaching netvsc's program, or removing the VF's own program, does
not retry the takeover. The accelerated datapath stays off until the VF
registers again, for example on a host remove/re-add or a manual netns
round-trip.

The handling is also asymmetric. If the VF is already joined, attaching
a program it refuses fails the attach and the VF is kept. If the program
was there first, the VF is lost until it re-registers.

The commit message only says "traffic then stays on the synthetic path,
where the program runs". Bonding refuses a user-initiated enslave that
can be retried, but netvsc's takeover is automatic.

Should something retry the takeover when the program goes away, or
should the commit message at least mention this?

> +
>  	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
>  
> -	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
> +	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
> +		if (prog)
> +			netvsc_vf_setxdp(vf_netdev, NULL);
>  		return NOTIFY_DONE;
> +	}

[ ... ]

> @@ -2453,6 +2477,15 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  
>  	reinit_completion(&net_device_ctx->vf_add);
>  	netdev_rx_handler_unregister(vf_netdev);
> +
> +	/* Only once frames from the VF no longer reach netvsc */
> +	nvdev = rtnl_dereference(net_device_ctx->nvdev);
> +	if (nvdev && netvsc_xdp_get(nvdev)) {

[Severity: Medium]
The take-back depends on netvsc's channels carrying a program right
now. Can the channel program be cleared while nvdev stays installed and
the VF still holds netvsc's propagated program, along with the reference
netvsc_vf_setxdp() took for it?

One case is a failed replace in netvsc_bpf(). P1 runs on netvsc and the
VF. Attaching P2 calls netvsc_xdp_set(P2), and then the VF refuses P2.
For example, mana_xdp_set() restores apc->bpf_prog = old_prog when
mana_pre_alloc_rxbufs() fails, and netif_xdp_propagate() returns -EBUSY
with tcp-data-split or a memory provider. The rollback then leaves the
channels empty:

drivers/net/hyperv/netvsc_bpf.c:netvsc_bpf() {
    ...
			if (bpf->prog)
				bpf_prog_inc(bpf->prog);
			netvsc_xdp_set(dev, NULL, extack, nvdev);
    ...
}

The VF keeps P1, and because the install failed, dev_xdp_attach() keeps
P1 in netvsc's xdp_state.

Another case is netvsc_detach(). It calls netvsc_xdp_set(ndev, NULL,
NULL, nvdev) first, and can then return early when rndis_filter_close()
or netvsc_wait_until_empty() fails, with nvdev still installed.
netvsc_set_channels(), for one, just bails out:

	ret = netvsc_detach(net, nvdev);
	if (ret)
		goto out;

In both states, the VF can later leave: VF unregister, netns move,
netvsc unbind or hot-remove, or the rmmod notifier replay. This check is
then false.

Does the VF keep running P1 with no upper, and does its driver's
reference to P1 leak?

The patch also removes the unconditional push at registration. The
commit message says that push "was all that cleared a program an earlier
netvsc instance left on the VF". A VF in this state that rejoins a
netvsc with no program, for example after reloading hv_netvsc, would
keep the stale program. dev_xdp_prog_count() cannot see it.

The nvdev == NULL paths, such as both netvsc_attach() attempts failing
or suspend, don't reach this check. get_netvsc_byref() already returns
NULL when nvdev is NULL, and that behaviour predates this patch.

> +		netdev_lock_ops(vf_netdev);
> +		netvsc_vf_setxdp(vf_netdev, NULL);

[Severity: Medium]
The return value of netvsc_vf_setxdp(vf_netdev, NULL) is dropped here.
The VF is then unlinked and released as though the program had been
removed. Can the removal fail?

netif_xdp_propagate() returns -EBUSY whenever a memory provider is
bound, even for a NULL program:

	if (dev_get_min_mp_channel_count(dev)) {
		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
		return -EBUSY;
	}

A memory provider can be bound to a joined VF that runs netvsc's
program. __net_mp_open_rxq() only checks dev_xdp_prog_count(dev), and
that count doesn't include propagated programs.

mana_xdp_set(NULL) on an up port can also fail in mana_pre_alloc_rxbufs(),
mana_detach() or mana_attach(). Each of those paths restores
apc->bpf_prog = old_prog and returns before bpf_prog_put(old_prog).

After such a failure, the VF keeps netvsc's program and the reference,
with no upper left to clean them up, and nothing is logged. The rollback
after a failed netvsc_vf_join() in netvsc_register_vf() also ignores the
result.

Bonding at least warns in __bond_release_one():

		if (dev_xdp_propagate(slave_dev, &xdp))
			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");

Should these two calls at least log a failure?

> +		netdev_unlock_ops(vf_netdev);
> +	}
> +
>  	netdev_upper_dev_unlink(vf_netdev, ndev);
>  	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
>  	dev_put(vf_netdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001014131.310771-1-kuba%40kernel.org
