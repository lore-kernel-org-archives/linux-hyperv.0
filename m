Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505C3E5EF3
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887079; cv=none; b=QnVP5eSlLZqSSBwE6BeyXNrjJQ7/TVr5XduVZ+DmQfyQnxXm1+p1Li/hs0dG8mtzUcGv+5sciu2HHGHkkTy61zb44yGiMC1h1oeDkWeVebvi/SgKxHhM+t5YjqvwbkV4aQvQcdgSTUkvdFhdRf/Y9xZxPcvbRUWRbBhDXZ3x3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887079; c=relaxed/simple;
	bh=yFVqgMtyEJeG07W/WwB7DPhIUT2V5mng9efeNFASuZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kHl9EemIBfBFbQvvWardHCLuzSk7FuuupAsnr+Ph1iBtTBaVnWMPZPqQwMj10auVkRkH+xI5pZYdcFK7JvJecJ9aHJk38lo3TCwz7x8jd4uvBQgO6JVnn/5ou19F9CNewTqYQNX8suPxtITkKL+QNyi/koQOF+soXBoTvcWMXpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqg+3KqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqg+3KqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304FE1F00A3A;
	Tue,  4 Aug 2026 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887077;
	bh=JNshL5oddC4FAlb1OlJPZPrYATCjD/0AgrDREmMTtfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qqg+3KqDvcpQ/KKMD1edf3u64C+dAPjtZISkWaW/XydlnmxQHXYRjK9f6P7riBzCp
	 hw6UEieMZHsOEPIP6zdlD1XWImXRlpS1bbdflabnos4PzW8zvEBkiJs2pnx8jWqx5v
	 2cHJGxqGiSOolzfMXO3tCinK4BWSvdRJJJsOEremMsxEihVB5H6/IuzOXbhnXFNZhz
	 y0oftTLx2b6WrN2Ey6q0VaR1DHBc1D0NEjkAL7XEgDvQWnVCMxZsyiBso64viRn7p/
	 WL+KH9JBzUVtG9iE7RR1u9VMFf3nXgGT0YBgCO+9vmjboNoPtAt3w7CmA9S4FVuSKO
	 68vh4Wj+g03UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/6] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-4-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:36 +0000
Message-Id: <20260804234437.304FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Destroying the TX and RX queues before the CQ and EQ in mana_hwc_d=
estroy_channel() causes a use-after-free if a late completion interrupt is =
processed.
--

--- Patch [3]: [PATCH net v3 3/6] net: mana: free HWC comp_buf after destro=
ying the EQ ---
commit 7a0285e343813287658afb74760a65202a46b1ba
Author: Long Li <longli@microsoft.com>

net: mana: free HWC comp_buf after destroying the EQ

This commit fixes a use-after-free by destroying the CQ and EQ before
freeing the hwc_cq->comp_buf buffer. The EQ teardown deregisters the IRQ
and fences in-flight handlers, preventing late handlers from touching
freed memory.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index cbb56c7647876..d701c427fe47b 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -384,14 +384,20 @@ static void mana_hwc_comp_event(void *ctx, struct g=
dma_queue *q_self)
> =20
>  static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *=
hwc_cq)
>  {
> -	kfree(hwc_cq->comp_buf);
> -
>  	if (hwc_cq->gdma_cq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
> =20
> +	/* comp_buf is reached only by mana_hwc_comp_event(), which the
> +	 * EQ handler invokes via cq_table[id].  The CQ destroy above
> +	 * already cleared that slot and ran synchronize_rcu(), so no
> +	 * handler can reach comp_buf once it returns.  Destroying the EQ
> +	 * here additionally tears down the IRQ (defense in depth) before
> +	 * comp_buf and hwc_cq are freed below.
> +	 */
>  	if (hwc_cq->gdma_eq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> =20
> +	kfree(hwc_cq->comp_buf);
>  	kfree(hwc_cq);
>  }

[Severity: High]
This is a pre-existing issue, but does the same use-after-free race still
exist for the TX and RX queues during channel teardown?

While this commit fixes the free order for comp_buf,
mana_hwc_destroy_channel() still frees the WQs before the CQ and EQ:

mana_hwc_destroy_channel()
{
        if (hwc->txq)
                mana_hwc_destroy_wq(hwc, hwc->txq);

        if (hwc->rxq)
                mana_hwc_destroy_wq(hwc, hwc->rxq);

        if (hwc->cq)
                mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
}

If a late EQ interrupt arrives or is already running in the window between
WQ destruction and CQ destruction, won't mana_gd_process_eqe() still find
the CQ in cq_table and invoke mana_hwc_comp_event()?

This would then call into mana_hwc_rx_event_handler() or
mana_hwc_tx_event_handler() and dereference the already-freed hwc->rxq
or hwc->txq memory:

mana_hwc_rx_event_handler()
{
        struct hwc_wq *hwc_rxq =3D hwc->rxq;
        ...
        if (WARN_ON_ONCE(hwc_rxq->gdma_wq->id !=3D gdma_rxq_id))
                return;
        ...
}

Could the WQ destruction in mana_hwc_destroy_channel() be moved after the
CQ and EQ are destroyed to ensure all in-flight handlers are fenced before
the WQ memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D3
