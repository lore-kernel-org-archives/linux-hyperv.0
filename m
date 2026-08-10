Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6343DA49
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388497; cv=none; b=o1gR0eFtbKogyhZMoP9uZtDUtUX6XySemBkLQMSj30pWNlnTvJhtxdCKC6BKum1vNsWb7Ga4Tg8LXyhfeGKaT2NDxRxlur0GCSmsaylm0ErN0ez1Loi/0wwOSVNNrem3J0bQOFLsgy3qaMnbA7wNaEA21Q7CKsQ0uCT0jxNWUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388497; c=relaxed/simple;
	bh=eGdloks+N4qiaUETucv4M6LEw6fLnn7KX6y5V2k40iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=avh1VBcFAjTrPbzzluj8U/+usSg8Fq74aVQMN3IRddaVhCg/WbvQBanyC/vWxxNNfEOY0y4ew1DlLUIIfMZloHm6IK4ak5UgKq0EZQtcMeOSRy/RRe5XtWWAnjIxDqDGBwIrI3KBQEpD5DXXJInUhvS8yjAWqV+Kn1z7jAGQPfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4AM0bsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4AM0bsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B831F00A3A;
	Mon, 10 Aug 2026 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388495;
	bh=RQx/c6XVXTOQ5uwcMEPt2IVbEIbj7+otxbdMJLuQKj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O4AM0bsBkQhdetxkdbAKd3s5NRb1njVVRNvtx3UEwkgk59suz1EKTOQLTJg7Q8x24
	 H6axUZ/etp7h25DUVlEMI0fH7/S7SCo6tBWjnGkOi5IarHaIr7sjLd8AfdbXusyAnh
	 dUa5XDZKcATezr9zY6QgEA/MuGUIjbl9MGrlIYT3Si14Xagjxewqg+X25oYZu7F6yQ
	 zHirczXVS5L4VMsOrvE9z7zgX/uXEyjp+Y3JzfMmK6FesWxSx02hWRNcZSQlINCN/8
	 ErolSYxSIouHmmgTwnN8p9jri5RPPGYebzEa9NVdrfaVCaFWQxFzzl4ThuW1ICVz05
	 eQDe7Pd7YCbkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/7] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-4-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:34 +0000
Message-Id: <20260810190135.62B831F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A TOCTOU race condition between the HWC request timeout path a=
nd the response interrupt handler allows the handler to perform a `memcpy` =
into a deallocated stack frame.
- [High] Pre-existing use-after-free risk in `mana_hwc_destroy_channel` due=
 to WQs (`txq` and `rxq`) being destroyed before the EQ is safely fenced.
- [High] If HWC channel establishment times out, hardware teardown is skipp=
ed, allowing the hardware to DMA into freed queue memory.
--

--- Patch [3]: [PATCH net v5 3/7] net: mana: free HWC comp_buf after destro=
ying the EQ ---
commit 20a39692a14893099232cb3a9085ec258236f7dc
Author: Long Li <longli@microsoft.com>

net: mana: free HWC comp_buf after destroying the EQ

mana_hwc_destroy_cq() freed hwc_cq->comp_buf and destroyed the CQ before
the EQ. That was unsafe while the EQ was still registered: the EQ
interrupt handler reaches comp_buf via mana_hwc_comp_event() and the CQ
object (hwc->cq->gdma_cq) via mana_hwc_init_event_handler(), so a late
EQE dispatched after the free could touch freed memory.

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
This isn't a bug introduced by this patch, but while checking the teardown
ordering, could there be a similar use-after-free risk for the WQs?

In mana_hwc_destroy_channel(), the WQs are destroyed before the EQ is
safely fenced by mana_hwc_destroy_cq():

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_destroy_channel()=
 {
    ...
    mana_hwc_destroy_wq(hwc, hwc->rxq);
    mana_hwc_destroy_wq(hwc, hwc->txq);
    mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
    ...
}

If an in-flight EQ interrupt handler runs during this window, it will invoke
mana_hwc_comp_event(), which calls mana_hwc_rx_event_handler(). The handler
blindly dereferences the freed hwc->rxq:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_rx_event_handler(=
) {
    ...
    if (WARN_ON_ONCE(hwc_rxq->gdma_wq->id !=3D gdma_rxq_id))
    ...
}

Will this cause a use-after-free if an interrupt arrives after the WQs are
freed but before mana_hwc_destroy_cq() fences the EQ?

[Severity: High]
This is a pre-existing issue, but does skipping hardware teardown on a time=
out
lead to DMA into freed memory?

In mana_hwc_establish_channel(), if hardware initialization times out:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_establish_channel=
() {
    ...
    if (!wait_for_completion_timeout(&hwc->hwc_init_eqe_comp, 60 * HZ))
        return -ETIMEDOUT;
    ...
}

The hardware channel remains active while gc->max_num_cqs remains 0. When t=
he
error path calls mana_hwc_destroy_channel(), the teardown is skipped:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_destroy_channel()=
 {
    ...
    if (gc->max_num_cqs > 0)
        mana_smc_teardown_hwc(&gc->shm_channel, false);
    ...
}

Since the hardware is still active but the queue memory is subsequently fre=
ed,
can the device DMA into the freed queue memory?

[Severity: Critical]
This is a pre-existing issue, but could a race condition cause stack corrup=
tion
if a request times out?

In mana_hwc_send_request(), if wait_for_completion_timeout() times out, the
function clears the msg_id and returns, destroying the stack frame containi=
ng
ctx->output_buf:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request() {
    ...
    if (!wait_for_completion_timeout(&ctx->comp_event, 40 * HZ)) {
        ...
        mana_hwc_put_msg_index(hwc, msg_id);
        return err;
    }
    ...
}

Concurrently, the interrupt handler does a lockless check of the inflight m=
ap:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_handle_resp() {
    ...
    if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
    ...
}

If the handler observes the bit as set just before the timeout clears it, it
will execute the memcpy(). Since the request function has already returned,
doesn't this write arbitrary device-controlled data into a deallocated stack
frame?

> +
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D3
