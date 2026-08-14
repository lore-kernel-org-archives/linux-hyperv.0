Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CC48D893
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729402; cv=none; b=gjS2+3ZlXbwApXDEZSsz5Dneae1kJ270oRMy8w9wAS/dHFIIX8rWG4e1oWxDdjEDRamxGLSlyxuXyou6UhkwnYFYWsHjeSaEcz6F51bPJe66u+jxdVHcsNnLe7MnL8HzTClLhd71NwGBOI+I1/S5vP0wJP9W2O2pyrPQEi4DFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729402; c=relaxed/simple;
	bh=Ta7qeQONtCi9h/0VQfcDA8WTkmeHfbxxvKouSELCPuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KhFl3+afF4eUW3Zh+c3XHBoSa1DKxBkJiHoc/nUDG6HfA3Z1y8UfKp4dFed4FeZXJwf+Xfg2eGgGxkcv7KWQbP9BDKmApdjpJaj0gQLMXu2bd40c1QGzn1zXUAjs5Iqb7qxCvzTkQVV9BjzxH02ABvq0HxUoiAEBQopv9nh0y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mncNYWiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mncNYWiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C026C1F00A3A;
	Fri, 14 Aug 2026 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729400;
	bh=xkp3MeuHzL8S306FwWicD6OPb0ZVpNSlSc8HmzTY2gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mncNYWiHC9pcbbs7VrvvJa6xZQjwDeNYDQp1asnF3+vObtzxGSy1EV2BANTBBGIVe
	 e6iMEp+4eQzdwQO7PcgZ2X7khyJJlvljcT2E8sSIcgn6J0kKySy3PoJmhgHwgBS5SU
	 GsQvS4dzLo70dyRWMLga3REGmq7SPbvFEflwENpjyMA1B4upfaJ1h1yKQzAFnxOp6c
	 XeDCEjiDYLsPjLi6fNVtP7imuYAqbHGBGmE2rXLVn1+nqfdLXh2pvIBnwUZTmPa7SP
	 7HRu5o5lIY9igSPhehUjlNbiJlQh5+0R9Vh9DoV59Rvqg76km7v5v95Tlut8d91qGr
	 bflCK4KOPddLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 5/7] net: mana: fix HWC teardown safety with
 setup_active flag and destroy ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-6-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:20 +0000
Message-Id: <20260814174320.C026C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A timed-out HWC request recycles its msg_id immediately, which can=
 cause a delayed hardware response to corrupt the memory of a subsequent re=
quest that reused the same msg_id.
- [High] The dynamically allocated `mana_serv_work` item is not cancelled d=
uring device removal, leading to a race condition where the work item can a=
ccess a freed `gdma_context` (`gc`).
--

--- Patch [5]: [PATCH net v7 5/7] net: mana: fix HWC teardown safety with s=
etup_active flag and destroy ordering ---
commit f7262210dd3ba2257a4ad8d7840cc3065a491ae1
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC teardown safety with setup_active flag and destroy order=
ing

This patch addresses teardown hazards that could allow the hardware to acce=
ss
freed memory. It introduces a setup_active flag to ensure teardowns only oc=
cur
when necessary, reorders queue destruction to prevent interrupts from acces=
sing
freed buffers, and intentionally leaks resources if the teardown itself fai=
ls.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -837,6 +844,16 @@ int mana_hwc_create_channel(struct gdma_context *gc)
>  	u16 q_depth_max;
>  	int err;
> =20
> +	/* A previous teardown may have failed and left the old context
> +	 * reachable.  Retry it before building a new channel; if it still
> +	 * fails, return an error so mana_serv_reset() does a full PCI rescan.
> +	 */

[Severity: High]
This isn't a bug introduced by this patch, but since mana_serv_reset() is
mentioned here, is there a use-after-free risk during device removal?

If an error triggers mana_schedule_serv_work(), it schedules a dynamically
allocated work item on the system workqueue:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_schedule_serv_work() {
    ...
    INIT_WORK(&mns_wk->serv_work, mana_serv_func);
    schedule_work(&mns_wk->serv_work);
    ...
}

If the driver is unbound concurrently, mana_gd_remove() frees the gdma_cont=
ext
without waiting for or cancelling this work item:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_remove() {
    ...
    vfree(gc);
    ...
}

Could the pending work item then execute mana_serv_reset(), read the context
via pci_get_drvdata(), and dereference the freed gc pointer?

[ ... ]

> @@ -914,6 +953,12 @@ void mana_hwc_destroy_channel(struct gdma_context *g=
c)
>  	 */
>  	gc->max_num_cqs =3D 0;
> =20
> +	if (hwc->txq)
> +		mana_hwc_destroy_wq(hwc, hwc->txq);
> +
> +	if (hwc->rxq)
> +		mana_hwc_destroy_wq(hwc, hwc->rxq);
> +
>  	kfree(hwc->caller_ctx);
>  	hwc->caller_ctx =3D NULL;

[Severity: High]
This is a pre-existing issue, but while reviewing the caller context cleanu=
p,
is there a memory corruption risk if a hardware channel request times out?

If a request times out in mana_hwc_send_request(), the msg_id is immediately
recycled:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request() {
    ...
out:
    mana_hwc_put_msg_index(hwc, msg_id);
    return err;
}

If another thread allocates the same msg_id, and the hardware later sends a
delayed response for the original timed-out request, could
mana_hwc_handle_resp() overwrite the new request's memory?

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_handle_resp() {
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
    ...
    complete(&ctx->comp_event);
}

Could this delayed response blindly overwrite the newly allocated caller's
output_buf and prematurely wake it up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D5
