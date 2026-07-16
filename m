Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E22E62AC
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172622; cv=none; b=SuaX4m9EsIlT5pamjlsy416b1YtHhbxmrZUAXcqo+fEW3XKDXURgUPeG+f2jP8f7Tx7gfGA3Q5g3tVZp3GXJOrPbd6TtHTe3hZVlttws8OqFOOE7cqO8GTE4ZRQWAuDJ3wvKHOWuTOC8kFQl1cSvCdRz8JjePOoxxXjjHdN0zrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172622; c=relaxed/simple;
	bh=IMcSK1GCW9meV31lF0Gc9ySfVvzaTRVAJrnMC//5Esw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tZJgnw3fMw5ycC2ohaK1h5Q99hn/g+yuUMjff509O9AC3o9qRm/49AWsx8xqlHFXe99+L4evcr2VMBONAnXC17JmTYOft8UC6e5lwYVL63DJ4lur1GdeKsMyh1QoBi2QIrh18GT4ntW3IY1IpZ7EEJNF1qKsqz2Aov/rRRF7Mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP8a/XD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP8a/XD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724921F00A3A;
	Thu, 16 Jul 2026 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784172621;
	bh=OJ5Brr66RSgz1jyFIPvVxTgzzv7a5dvJDI1mMuHGWBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP8a/XD7wzQ33lPC+t3gKIs2y5d1qvtchk2AhzzqjTwSzDeYKS1bv4fb1ZPFMJy2A
	 p8iyQrl0FQuYu5T4BLG9gjxNKi0+iq9x7vdvZTeed3ZeL2Rd7yZu1utniyipBDvscG
	 j9TdyYu+IWLU9p7qxVSPkV1eCYYGJmWsgL6EdjELDatAbTdtpKDE+FuSnUtAVRcffY
	 sVk+t/N5nAS9dpj5psNEMitiQykb1OoUv/oNjrQ5s+0jAUi9nbMqp5VMqQTwl4lPsa
	 kSeiC1nmY3m3sOd7CdbCn3zFzWoizCI1uPgOq/u5saLjD3nnyMtjWdjVLdHP3YbyMq
	 qLxG4KLSRp0bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/7] net: mana: fix HWC teardown safety with
 setup_active flag and destroy ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260715032942.3945317-6-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
 <20260715032942.3945317-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:30:21 +0000
Message-Id: <20260716033021.724921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing teardown synchronization for dynamically allocated service=
 tasks leads to Use-After-Free during device removal.
--

--- Patch [5]: [PATCH net-next 5/7] net: mana: fix HWC teardown safety with=
 setup_active flag and destroy ordering ---
commit d335b5db9ecdafc6371e77ac2bb32f6aa7467088
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC teardown safety with setup_active flag and destroy order=
ing

Two teardown hazards let the hardware touch memory the driver freed.
First, if establish_channel fails, the caller had no reliable way to know
teardown was required and could free buffers while mappings were still live.
Second, destroy_channel freed TXQ/RXQ buffers while the HWC EQ was still on
the interrupt dispatch list.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network A=
dapter (MANA)")

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 68236727aee8b..b26c2122ebf52 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -878,11 +902,62 @@ void mana_hwc_destroy_channel(struct gdma_context *=
gc)
>  	if (!hwc)
>  		return;
> =20
> -	/* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
> -	 * non-zero, the HWC worked and we should tear down the HWC here.
> +	/* Tear down the HWC if setup_hwc previously activated MST entries.
> +	 * This is the definitive flag =E2=80=94 unlike max_num_cqs which depen=
ds
> +	 * on the init EQE arriving.
>  	 */
> -	if (gc->max_num_cqs > 0)
> -		mana_smc_teardown_hwc(&gc->shm_channel, false);
> +	if (hwc->setup_active) {
> +		int td_err =3D mana_smc_teardown_hwc(&gc->shm_channel, false);

[Severity: High]
This is a pre-existing issue, but is there a missing synchronization step f=
or
dynamically allocated service tasks during device teardown?

When a hardware event (like GDMA_EQE_HWC_RESET_REQUEST) occurs, the EQ
interrupt handler calls mana_schedule_serv_work(), which allocates a
mana_serv_work structure and schedules it on the system workqueue:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_schedule_serv_work() {
    ...
    mns_wk =3D kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
    ...
    INIT_WORK(&mns_wk->serv_work, mana_serv_func);
    schedule_work(&mns_wk->serv_work);
}

If a device unbind or module removal occurs concurrently, mana_gd_remove()
is called, which frees the context without flushing or canceling these
dynamically allocated tasks:

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_remove() {
    ...
    vfree(gc);
}

When the scheduled mana_serv_func() eventually executes, it accesses the
freed gdma_context (gc) and hw_channel_context (hwc):

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_serv_reset() {
    ...
    struct gdma_context *gc =3D pci_get_drvdata(pdev);
    struct hw_channel_context *hwc;
    ...
    hwc =3D gc->hwc.driver_data;
}

Could this race condition result in a Use-After-Free during teardown?

> +
> +		if (td_err) {
> +			dev_err(gc->dev, "HWC teardown failed: %d, issuing FLR\n",
> +				td_err);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715032942.3945=
317-1-longli@microsoft.com?part=3D5
