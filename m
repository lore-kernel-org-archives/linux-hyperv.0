Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7E490BEE
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729403; cv=none; b=JjkIUAlkcb5mG1qYt6ExL2XHHy3THfn3q2YN7v2wrYVGI8M7JCwNE/AwJvTmO85yhwoRE76qv7kafIFKwrvQpx1ROyMh6yAL+OApaNzxPkMWY8byIvgzFJXRsiUDlICe6oakilsaN/X6noIy/+QLQuc0yt01JpJ32bOR8aEJXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729403; c=relaxed/simple;
	bh=ZkRGYkcLK3tJJSpz3BsWHtE9dobEqFoAGINNd+xwW6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gEXXjbUk9iMByo2f3yL9Tbu/DV4XQnamtXnyQzQKkbIp7++S1xtbfhBgV7vwvG58l3n9ejRRpPlNnymfaJOvLiGfpIK1TuaqRJ4qlP+lPMmfvTcZrukSPo1M0PsfVPMzaa5Lqrsa0WogIpaQm849mUVj6aa/XB77jB5fJTcsPU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaKgdoDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaKgdoDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174DB1F00A3D;
	Fri, 14 Aug 2026 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729402;
	bh=0aTFhG7lXr16lNUZRblRzWGsQfaIz48c3rFRMDbt8hA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AaKgdoDIIz75BDu1b5cUJRoE7mtRL5NDTGbcG+RQk2qEOEL3M5RLdY5vUu9s55v9c
	 JN/ByI6jlfjDT698DCIhZ+6i/3UUekXSuucBYiQ+cO17HqCUPigA/15PHw0FB5HSyJ
	 Eug9pcKZ/ATGty2e77CKruOWNQ1koZvP8FnOCagf+/O6+XAWO6Ju+B7TsgmHZzNXMU
	 6hD0Q5O/B5ErcHDV6o0ZRUcP0A0oY7ZIUe4azWeVbytXvayVDFlqsm1grQm7jmBL9O
	 ICU6Oiy5J6Hytf3be90BjRzhnlwgxImt7yr7AzhMZOrzF1joCWekzPgXdrunhc3It3
	 5wdIqYFj+Dbqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 3/7] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-4-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:21 +0000
Message-Id: <20260814174322.174DB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Use-After-Free of WQ structures due to incorrect =
channel teardown order.
- [High] Stack Memory Corruption and Logic Error due to missing reinitializ=
ation after request timeout.
- [High] Hardware DMA Use-After-Free when channel establishment times out.
--

--- Patch [3]: [PATCH net v7 3/7] net: mana: free HWC comp_buf after destro=
ying the EQ ---
commit 6875abc2fe553564a7ca5aa77824fb5ca62feda6
Author: Long Li <longli@microsoft.com>

net: mana: free HWC comp_buf after destroying the EQ

mana_hwc_destroy_cq() freed comp_buf and the CQ before the EQ. While the
EQ was still registered its handler could reach comp_buf and the CQ, so
a late EQE could touch freed memory. This commit fixes the teardown order.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index ccef9bf9c6bfd..7e01596df11b6 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -384,14 +384,17 @@ static void mana_hwc_comp_event(void *ctx, struct g=
dma_queue *q_self)
> =20
>  static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *=
hwc_cq)
>  {
> -	kfree(hwc_cq->comp_buf);
> +	/* Destroy the EQ first: it deregisters the IRQ and drains in-flight
> +	 * handlers, so none can touch the CQ after it is freed.
> +	 */
> +	if (hwc_cq->gdma_eq)
> +		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> =20
> +	/* Safe to free now that the EQ handler is fenced. */
>  	if (hwc_cq->gdma_cq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
> =20
> -	if (hwc_cq->gdma_eq)
> -		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> -
> +	kfree(hwc_cq->comp_buf);
>  	kfree(hwc_cq);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown order in
mana_hwc_destroy_channel() leave a use-after-free for the WQ structures?

In mana_hwc_destroy_channel(), the txq and rxq wrappers are destroyed
before mana_hwc_destroy_cq() fences the EQ:

mana_hwc_destroy_channel() {
    ...
    if (hwc->txq)
        mana_hwc_destroy_wq(hwc, hwc->txq);
       =20
    if (hwc->rxq)
        mana_hwc_destroy_wq(hwc, hwc->rxq);
       =20
    if (hwc->cq)
        mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
    ...
}

Since mana_hwc_destroy_wq() frees the wq structure, can an unfenced EQ=20
handler dereference the freed hwc->rxq pointer in=20
mana_hwc_rx_event_handler() while the EQ is still active?

[Severity: High]
This is a pre-existing issue, but does mana_hwc_send_request() have a stack
corruption bug if a request times out?

If wait_for_completion_timeout() times out, the function jumps to out and=20
releases the msg_id:

mana_hwc_send_request() {
    ...
    if (!wait_for_completion_timeout(&ctx->comp_event, ...)) {
        err =3D -ETIMEDOUT;
        goto out;
    }
    ...
}

A new request could then allocate the same msg_id without reinitializing
ctx->comp_event. If a late response arrives for the original request,=20
mana_hwc_handle_resp() will copy the stale payload into the new caller's=20
stack buffer and complete the event:

mana_hwc_handle_resp() {
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
out:
    ctx->error =3D err;
    ...
    complete(&ctx->comp_event);
}

Could this cause the new request to receive stale data and continue=20
prematurely?

[Severity: High]
This is a pre-existing issue, but does a timeout during channel=20
establishment result in a DMA use-after-free?

In mana_hwc_establish_channel(), if the hardware takes too long to reply:

mana_hwc_establish_channel() {
    ...
    if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ))
        return -ETIMEDOUT;
    ...
}

The error path calls mana_hwc_destroy_channel(), which checks max_num_cqs
before tearing down the hardware channel:

mana_hwc_destroy_channel() {
    ...
    if (gc->max_num_cqs > 0)
        mana_smc_teardown_hwc(&gc->shm_channel, false);
    ...
}

Since max_num_cqs remains 0 during an init timeout, mana_smc_teardown_hwc()=
=20
is skipped. Are the DMA buffers then freed while the hardware channel is=20
still active and capable of writing to them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D3
