Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59784369D4A;
	Sun,  4 Oct 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129779; cv=none; b=DG5fIExLwYd2zgX38YlhqXwKX0pIsc5c4X6j4Kn77oiLIEtLrgVLudt330i+5jUBtbQSIXvkBGQ639LbOAIcUQpTrb4deZjpK2pUWW+WzsD0pfFq0OiTqa764tSMszhZzcQ36LxqqgLcoV9iITcY9bmFOv7LoV8CZL/Qm85p214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129779; c=relaxed/simple;
	bh=5hlhdfTYDhRJBR3smWk7TuxzZLkde3K2fj5nUX6XO6k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFudG6tdzgZqyDlCK1STAfVyuE2TibFRAgV6eCKTw75V4iG4KQ0095iBW6uQVNKENgxLaVCU1RbMEKGyX5StR03RZJFtpal5CCLvWltZVeIkK+lKigeF203W9p6ux0bfC1v31RfQgMhWvXQrm35WVlGzXE9kRm8FgiYIBpQXvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXmsEzmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXmsEzmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EF1F00898;
	Sun,  4 Oct 2026 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129778;
	bh=WjS4aUEzoXoabvArkYPhbhiVegpeiFFThfHmZhXKFOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FXmsEzmES5+9V7VZq/lq3dQq9NNsScZW6LzROEJi01qA8Tgr06x+Wiz1CEP7alzcU
	 StX71eeiPakT5CLnazXd5AWr1/p4ooe0MHRLyMz8l2Rp0pbepNpJx2oyHhmWaF6vI0
	 1AjjrlQomDkeO0sft0zFkmYSykAa3j5rca3g7uj9R9BfkCIMmTw1i6gS6sHYpw3af+
	 3iRajGocf1l5bDiqpP59rFjSniMcxru/RX0RBKGrwlH59iVBkiqGq4tXrd7WeChvEl
	 lxlmmeiIS/29YsRbvT1ceLrOlP7LFPuMnca1fbKtMn68bMsul7TKmG5F13dI3JC9No
	 /hZ4Ozltl8QgQ==
Subject: Re: [PATCH net-next 5/5] hv_netvsc: let the core take XDP off a
 netvsc device that is going away
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, linux-hyperv@vger.kernel.org, hawk@kernel.org,
 andriin@fb.com, stable+noautosel@kernel.org
Date: Sun, 04 Oct 2026 16:02:57 +0000
Message-ID: <179112977709.434549.14979338946585736323@kernel.org>
In-Reply-To: <20261001014131.310771-6-kuba@kernel.org>
References: <20261001014131.310771-6-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new branch in netvsc_bpf()
  (drivers/net/hyperv/netvsc_bpf.c:206-213) returns success for…
- [Medium] The fix treats a non-NULL ndev_ctx->saved_netvsc_dev_info as
  meaning 'suspend parked the program and netvsc_resume() will put it…

--

hv_netvsc: let the core take XDP off a netvsc device that is going away

With this patch, netvsc_bpf() returns success for an XDP program removal
when nvdev is gone, no VF is linked and suspend has not saved its config.
The aim is to stop dev_xdp_uninstall() from hitting its WARN_ON() on
unbind or hot-remove of a netvsc device running native XDP. It also lets
the program be dropped from the XDP dispatcher.

> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index 951c19ce15ebc..7fe38574f66f6 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -204,6 +204,12 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  	int ret;
>  
>  	if (!nvdev || nvdev->destroy) {
> +		/* The channels and the VF are gone, and so is the program,
> +		 * unless suspend parked it for netvsc_resume() to put back.
> +		 */
> +		if (bpf->command == XDP_SETUP_PROG && !bpf->prog && !vf_netdev &&
> +		    !ndevctx->saved_netvsc_dev_info)
> +			return 0;

[Severity: Medium]
Does !vf_netdev here guarantee that the program is gone from the VF?

netvsc_unregister_vf() takes netvsc's program back from the VF only while
nvdev exists and the channels still have a program. It clears vf_netdev
in every case:

drivers/net/hyperv/netvsc_drv.c:netvsc_unregister_vf() {
    ...
	nvdev = rtnl_dereference(net_device_ctx->nvdev);
	if (nvdev && netvsc_xdp_get(nvdev)) {
		netdev_lock_ops(vf_netdev);
		netvsc_vf_setxdp(vf_netdev, NULL);
		netdev_unlock_ops(vf_netdev);
	}

	netdev_upper_dev_unlink(vf_netdev, ndev);
	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
    ...
}

nvdev can be NULL while the VF is still linked and still runs netvsc's
program. netvsc_detach() clears XDP only on the channels:

drivers/net/hyperv/netvsc_drv.c:netvsc_detach() {
    ...
	netvsc_xdp_set(ndev, NULL, NULL, nvdev);
    ...
}

Both attaches can then fail in netvsc_set_channels().
netvsc_change_mtu() and netvsc_set_ringparam() follow the same pattern:

drivers/net/hyperv/netvsc_drv.c:netvsc_set_channels() {
    ...
	ret = netvsc_attach(net, device_info);
	if (ret) {
		device_info->num_chn = orig;
		if (netvsc_attach(net, device_info))
			netdev_err(net, "restoring channel setting failed\n");
	}
    ...
}

After that, nvdev stays NULL. The VF still holds the program, along with
the reference that netvsc_vf_setxdp() took through
netif_xdp_propagate().

A later unbind, hot-remove, rmmod or netns move would then do this:

netvsc_unregister_vf()
    nvdev == NULL, so netvsc_vf_setxdp(vf_netdev, NULL) is skipped
    vf_netdev = NULL
dev_xdp_uninstall()->dev_xdp_install(NULL)->netvsc_bpf()
    nvdev == NULL, vf_netdev == NULL, saved_netvsc_dev_info == NULL
    return 0

At that point the core treats the program as gone. The former VF keeps
running netvsc's XDP program on its traffic, and nothing records the
program in the VF's xdp_state.

Before this patch, this state at least triggered the WARN in
dev_xdp_uninstall(). The gating in netvsc_unregister_vf() comes from the
earlier commit in the series, "hv_netvsc: treat the VF's XDP program the
way bonding treats a slave's". The new guard and comment assume that
gating covers every case.

Could the take-back in netvsc_unregister_vf() check what netvsc has
recorded, for example dev_xdp_prog_count(ndev), instead of the channel
state? Alternatively, should the guard here stop treating !vf_netdev as
proof that the program was removed?

[Severity: Medium]
Can saved_netvsc_dev_info be non-NULL here even though netvsc_resume()
will never run to put the program back?

netvsc_suspend() saves the config, which takes a bprog reference through
netvsc_devinfo_get(), and only then calls netvsc_detach():

drivers/net/hyperv/netvsc_drv.c:netvsc_suspend() {
    ...
	ndev_ctx->saved_netvsc_dev_info = netvsc_devinfo_get(nvdev);
	...
	ret = netvsc_detach(net, nvdev);
    ...
}

netvsc_detach() clears the channel programs first and can fail after
that:

drivers/net/hyperv/netvsc_drv.c:netvsc_detach() {
    ...
	netvsc_xdp_set(ndev, NULL, NULL, nvdev);
	...
		ret = rndis_filter_close(nvdev);
		if (ret) {
			...
			return ret;
		}

		ret = netvsc_wait_until_empty(nvdev);
		if (ret) {
			...
			return ret;
		}
    ...
}

The error goes back through vmbus_suspend(), the noirq callback. Because
the callback failed, device_suspend_noirq() does not set
is_noirq_suspended. device_resume_noirq() then skips the device, so
netvsc_resume() never runs. netvsc_resume() is the only code that puts
and clears saved_netvsc_dev_info, and netvsc_remove() does not touch it.

A later unbind or hot-remove with native XDP still attached would then
go like this:

netvsc_remove()
    netvsc_xdp_set(net, NULL, NULL, nvdev)
    rndis_filter_device_remove()    /* nvdev becomes NULL */
    unregister_netdevice()
        dev_xdp_uninstall()
            dev_xdp_install(NULL)->netvsc_bpf()
                saved_netvsc_dev_info != NULL
                return -ENODEV
            WARN_ON(...)

On this path the WARN_ON() in dev_xdp_uninstall() that this patch is
meant to remove still fires. bpf_prog_change_xdp() is also skipped, so
the XDP dispatcher keeps its reference to the program.

The commit message gives the reason for the exclusion as:

  "unless suspend parked the program for resume to put back, as the core
  would then lose track of it"

dev_xdp_uninstall() drops xdp_state and the core's reference no matter
what the driver returns. Does that reason still hold on this path?

The leaked devinfo and its bprog reference predate this patch, but the
fix now depends on that stale pointer. Should saved_netvsc_dev_info be
put and cleared on the netvsc_suspend() error path, and in
netvsc_remove() before unregister_netdevice()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001014131.310771-1-kuba%40kernel.org
