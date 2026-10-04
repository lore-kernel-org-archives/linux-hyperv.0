Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602292F60CC;
	Sun,  4 Oct 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129778; cv=none; b=iSoUH1wWVvUPJUFGDzLHcAhbZ37C+jP6UL/ql47pJFqBnLJKuPWKsAki1EImSyZXe2e1AlnFZPT9SRK/rZtUyhMrHnhTUTCxFvIYIQXCw6/c8qEDDwIO7o3A7RTaGaB1Cc3x2dhvCwxcR3nwdNoHh7nu8QGu9w2j2XIs9m20Rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129778; c=relaxed/simple;
	bh=YMwAY9rZJNnExbmxS6n2nB8ImrW3h9ipz5p02CSUSpg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/5lRlM5XXCRirZq2HxKa+e73ip1qJgTm9a649Qrrdl+7KOoFEK2Cx5a8v5VcGl7ofS7UMzDfC8ctlmjT8MyBO+A5ahgVDUyHYOxYQFyBtlsi8a7fUiDHMBUBP+qdvuamTM2Owv3YeaxpUNN1oxm2wOzcpWzobFTGfMgCieku8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkF6xbAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkF6xbAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6B81F00893;
	Sun,  4 Oct 2026 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129776;
	bh=ECdKz6Fbss+2S23DYqslGl1oYCMzfgsGdTrHN2/IUhY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dkF6xbApRpzjnfdl3Q15fYU8hTktmsixf7V7UqOLlBI6B25N3lyWwxWg/Lb+uuORi
	 1nCaOK68N+Tfpc37XRdd1pKBECyQsmy0eGv4r19jmxbHqqY1AYvBvLsTnTcB9WjYR/
	 j+29TNkBxgYJ6NI2vY+PC7JSX2xhs3CI/DbsfeTMD+bx6xgPaH1lEs+xIIf7uG9PVg
	 lQvwvqrUt7DLlbbQ9HF1qURl3Ydzp+rUGWIB8OhXktebr7OicLroTc95ksDWqJFJiT
	 V6hT2I68wirCA4Z2lQJEYXUaJw6WHczWdl8ugizoP//+ZQM3NF8BsdfqV/YQabDGkX
	 nroeXbH687wQw==
Subject: Re: [PATCH net-next 4/5] hv_netvsc: move a new VF to netvsc's netns
 from a work item
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, linux-hyperv@vger.kernel.org, hawk@kernel.org,
 andriin@fb.com, stable+noautosel@kernel.org
Date: Sun, 04 Oct 2026 16:02:55 +0000
Message-ID: <179112977554.434549.8142232996286708901@kernel.org>
In-Reply-To: <20261001014131.310771-5-kuba@kernel.org>
References: <20261001014131.310771-5-kuba@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new takeover branch in netvsc_event_set_vf_ns()
  (drivers/net/hyperv/netvsc_drv.c:2839-2846) can enslave a VF without…
- [Medium] netvsc_suspend() now drops a pending VF netns move or
  takeover, and nothing restores it.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but netvsc_probe()
  can free a net_device whose vfns_work is still pending, which is a…

--

hv_netvsc: move a new VF to netvsc's netns from a work item

The patch stops netvsc_register_vf() from calling
dev_change_net_namespace() from inside the VF's NETDEV_REGISTER notifier.
That call deadlocks on the instance lock of ops-locked VFs. The patch
instead takes a reference on the VF in ndev_ctx->vfns_dev and leaves the
move to vfns_work. If netvsc is already in the VF's netns when the work
runs, the work takes the VF over itself.

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 17c86e7493577..10c05809c0659 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c

[ ... ]

> @@ -2695,6 +2699,7 @@ static void netvsc_remove(struct hv_device *dev)
>  
>  	rtnl_lock();
>  	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
> +	netvsc_vfns_dev_put(ndev_ctx);
>  
>  	nvdev = rtnl_dereference(ndev_ctx->nvdev);
>  	if (nvdev)

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Does the
register_failed path in netvsc_probe() also need to cancel vfns_work, the
way netvsc_remove() does here?

register_netdevice() runs the NETDEV_REGISTER chain. netvsc's own handler
queues the work before anyone knows whether registration will succeed:

netvsc_netdev_event() {
	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
		ndev_ctx = netdev_priv(event_dev);
		schedule_delayed_work(&ndev_ctx->vfns_work, 0);
		return NOTIFY_DONE;
	}
	...
}

A later notifier in the chain can fail, for example addrconf_notify()
when ipv6_add_dev() fails to allocate. register_netdevice() then unwinds
and returns an error, and netvsc_probe() runs:

register_failed:
	rndis_filter_device_remove(dev, nvdev);
rndis_failed:
	rtnl_unlock();
	...
	hv_set_drvdata(dev, NULL);
	free_netdev(net);

Probe holds RTNL the whole time. netvsc_vfns_work() therefore fails
rtnl_trylock() and keeps re-arming itself with
schedule_delayed_work(&ndev_ctx->vfns_work, 1).

Can that timer or work then run on the freed net_device priv area, where
netvsc_vfns_work() reads ndev_ctx->device_ctx?

The new vfns_dev reference cannot leak on this path. ndev_ctx is only
added to netvsc_dev_list after registration succeeds, so
get_netvsc_byslot() never finds it.

> @@ -2738,6 +2743,7 @@ static int netvsc_suspend(struct hv_device *dev)
>  
>  	rtnl_lock();
>  	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
> +	netvsc_vfns_dev_put(ndev_ctx);
>  
>  	nvdev = rtnl_dereference(ndev_ctx->nvdev);
>  	if (nvdev == NULL) {

[Severity: Medium]
Could this lose a pending VF move for good?

Before this patch the move ran synchronously in the VF's NETDEV_REGISTER
notifier. Now netvsc_register_vf() only records the VF in
ndev_ctx->vfns_dev and queues vfns_work. If netvsc_suspend() takes RTNL
before netvsc_vfns_work() wins rtnl_trylock(), this code throws away both
the request and the VF reference.

netvsc_resume() only resets data_path_is_vf and calls netvsc_attach().
Nothing queues vfns_work again.

The suspend error paths don't restore the request either. Those are the
nvdev == NULL check and a NULL return from the GFP_ATOMIC
netvsc_devinfo_get(). Resume is not called after a failed suspend.

A VF that survives suspend sends no new NETDEV_REGISTER. netvsc_vf_changed()
notes that mlx5 keeps the interface and sends only CHANGE.
NETDEV_UP/CHANGE can't recover the VF, because get_netvsc_byref() needs a
master link that was never set up.

Would the VF then stay in the other netns and never be joined? The last
patch in the series does not change this code.

> @@ -2815,7 +2821,9 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
>  
>  	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
>  	if (!vf_netdev)
> -		return;
> +		vf_netdev = ndev_ctx->vfns_dev;
> +	if (!vf_netdev || vf_netdev->reg_state != NETREG_REGISTERED)
> +		goto out;
>  
>  	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
>  		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
> @@ -2828,7 +2836,16 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
>  			netdev_info(vf_netdev,
>  				    "Moved VF to namespace with: %s\n",
>  				    ndev->name);
> +	} else if (!rtnl_dereference(ndev_ctx->vf_netdev)) {
> +		/* netvsc got to the VF's netns first, so no move will
> +		 * register the VF again, take it over from here
> +		 */
> +		netdev_lock_ops(vf_netdev);
> +		netvsc_register_vf(vf_netdev, VF_REG_IN_NOTIFIER);
> +		netdev_unlock_ops(vf_netdev);
>  	}
> +out:
> +	netvsc_vfns_dev_put(ndev_ctx);
>  }

[Severity: Medium]
Does this takeover path ever switch the data path to the VF if netvsc and
the VF are both already up?

netvsc_register_vf() joins the VF and schedules vf_takeover. That work
runs __netvsc_vf_setup():

__netvsc_vf_setup() {
	...
	dev_change_flags(vf_netdev, ndev->flags | IFF_SLAVE, NULL);
	...
	if (netif_running(ndev)) {
		ret = dev_open(vf_netdev, NULL);
	...
}

If both devices already have IFF_UP set, dev_change_flags() does not
change IFF_UP. __dev_notify_flags() then emits neither NETDEV_UP nor
NETDEV_CHANGE, and dev_open() on a running device emits nothing.

netvsc_switch_datapath() is only called from netvsc_vf_changed(), which
only runs on the VF's UP/DOWN/CHANGE/GOING_DOWN events.

Would data_path_is_vf then stay false? That would keep netvsc_start_xmit()
and host RX on the synthetic path until some later event on the VF.

One sequence that gets here:

- The VF registers in netns A while netvsc is in netns B.
- netvsc is moved to A.
- Both devices are brought up in A before vfns_work wins rtnl_trylock().

The normal re-register path doesn't have this gap.
dev_change_net_namespace() closes the VF, so the later open always produces
NETDEV_UP. The commit message treats the takeover as equivalent to that
path, which doesn't seem to hold in this case.

The later patch in the series ("hv_netvsc: let the core take XDP off a
netvsc device that is going away") only touches netvsc_bpf.c, so this gap
is still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001014131.310771-1-kuba%40kernel.org
