Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B91531E8
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242905; cv=none; b=WgWadIEOTZZITjlU+Hletlg6DbSbyTUJD0jxcCR3gAe49WJtjc+Q+kV1gVOquqcTDzkQkVPjdKbP/C2LbKnXfD0qE/sNrDw93ORzi+A57R87SDIo33JeJSWtGeKj/ENhUN53CZSITIDwIGtIHadCVcbVN08UF2skPIaSvT+Jf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242905; c=relaxed/simple;
	bh=JH2eRH7icsfCF9al+qNDXCgDMRvlvuNakX31EZe/Gb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e9avkrq/OSyrd266zkYyNfvvOh/SDaxMc4dVDizfoz6Xooeo52nF600CvKM+UeK340E8X6LwXhnbfwh+uBbyBHYg/i7LWmX2Qy0RzkW/7vu/e6mJ+Q56NQWkW27v+4gd1Q7N/RmjUUFIBWQ5k8uj5uzMzRChkIAwd+W1nDnCN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6/d0r2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6/d0r2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B331F00A3A;
	Sun,  9 Aug 2026 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242904;
	bh=2Sk4MWX75Orr3feCtieUVYdWUgRgQlzcKe30HIPpalM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6/d0r2Yc0vtbJkBmYEGACf8iS0DEr1qo9jj7nbnTo615S5wOLWBLHi2vjwWtSTO3
	 lbxgpqwr5yPBKmNq3LAyx9zATNkxM6qsHb75UBfgTd6B5oW+7ch6nU4yVsde2dqfoZ
	 HgLeZIhRvRdiHli2lmpPSPkiGXmdJYZDR8rRCLBVvoCLBrpQsPczkUfaw66DtVVL3b
	 mXwZK/2Tzr41snjc9dgWtdnnupAej4pD34uaG1XdygSN8KTxPN8DYbRc2l/7foQhVr
	 3nCat5rSfUM/rAMBS3VbLy8i0ODi2sYZc+HhdZ6YRMnkvojsSWUrCSUHu6mWarViRy
	 xL1GvP/NkWS1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/7] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-4-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:35:03 +0000
Message-Id: <20260809023504.83B331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] DMA-after-free and memory corruption due to skipped hardware t=
eardown on timeout.
- [High] Use-After-Free of `hwc->txq` and `hwc->rxq` in Event Queue handler=
s.
--

--- Patch [3]: [PATCH net v4 3/7] net: mana: free HWC comp_buf after destro=
ying the EQ ---
commit 3b2de5d23ee69b3df0c657484fe10e47ed38e264
Author: Long Li <longli@microsoft.com>

net: mana: free HWC comp_buf after destroying the EQ

mana_hwc_destroy_cq() freed hwc_cq->comp_buf and destroyed the CQ before
the EQ. That was unsafe while the EQ was still registered because a late
EQE dispatched after the free could touch freed memory. Destroy the EQ firs=
t,
which deregisters its IRQ and waits out in-flight handlers, fencing all
EQE dispatch.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 3f011ebbe7b3e..19896bb5ce1a4 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -384,14 +384,24 @@ static void mana_hwc_comp_event(void *ctx, struct g=
dma_queue *q_self)
> =20
>  static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *=
hwc_cq)
>  {
> -	kfree(hwc_cq->comp_buf);
> +	/* Destroy the EQ before the CQ.  mana_gd_destroy_queue() on the EQ
> +	 * deregisters its IRQ and waits out in-flight handlers, fencing all
> +	 * EQE dispatch =E2=80=94 both the completion path and HWC init/reconfig
> +	 * events.  Freeing the CQ first would leave the EQ live and able to
> +	 * dispatch an event that dereferences hwc->cq->gdma_cq (e.g.
> +	 * mana_hwc_init_event_handler()) after it has been freed.
> +	 */
> +	if (hwc_cq->gdma_eq)
> +		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);

[Severity: High]
This isn't a bug introduced by this patch, but I see a similar vulnerability
unpatched in mana_hwc_destroy_channel() in the same file.

While this patch ensures the EQ is destroyed before the CQ,
mana_hwc_destroy_channel() calls mana_hwc_destroy_wq() for the TX and
RX queues before calling mana_hwc_destroy_cq().

If an interrupt fires between the WQ frees and the EQ fence inside
mana_hwc_destroy_cq(), the EQ handler can process completion or init events
that dereference the freed WQs:

mana_hwc_tx_event_handler() {
    ...
    struct hwc_wq *hwc_txq =3D hwc->txq;

    WARN_ON_ONCE(!hwc_txq || hwc_txq->gdma_wq->id !=3D gdma_txq_id);
    ...
}

Could this order of operations leave a window where active EQ interrupts
can access freed WQ memory?


[Severity: Critical]
This is another pre-existing issue, but it looks like there might be a flaw
in the teardown logic when a timeout occurs.

In mana_hwc_establish_channel(), mana_smc_setup_hwc() provides the DMA
addresses to the hardware. If the wait for the init event times out, the
driver calls mana_hwc_destroy_channel().

However, mana_hwc_destroy_channel() will skip the hardware teardown if
the initialization didn't complete:

mana_hwc_destroy_channel() {
    ...
    /* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
     * non-zero, the HWC worked and we should tear down the HWC here.
     */
    if (gc->max_num_cqs > 0)
        mana_smc_teardown_hwc(&gc->shm_channel, false);
    ...
}

Because max_num_cqs is 0, it skips mana_smc_teardown_hwc(), but then
proceeds to free all queue DMA buffers. Since the hardware channel was
established, can it write to the freed DMA addresses if it processes
the delayed events later, corrupting whatever reused those pages?

> =20
> +	/* comp_buf is reached only by mana_hwc_comp_event(), invoked from
> +	 * the now-fenced EQ handler, so it is safe to free once the EQ and
> +	 * CQ are gone.
> +	 */
>  	if (hwc_cq->gdma_cq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
> =20
> -	if (hwc_cq->gdma_eq)
> -		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> -
> +	kfree(hwc_cq->comp_buf);
>  	kfree(hwc_cq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D3
