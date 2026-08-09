Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EC2288D5
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242900; cv=none; b=fzBNIRqDId5vkbpBD3odRImXhLmxaiYPGpFxvanK6OwGAO57X0mzIb9gsUBYEVK2YsPk8WZcn1NlgdOS+aO7Nvrju56asHw4rJGn7yxz0L6SX4D55YF6EhIICNXIsXu+t7zbYZMPZ7IB42iD1DekpCIaEjX3DaSLJXHI4YUq0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242900; c=relaxed/simple;
	bh=28K5tdu6u9CY0S/HBi0/qk98le/CYuM+FGudNjTsX10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVAi/dWd7vNsTtAnq4B+yqo0AQbaohVP2Qq8bWgfrR0JpnU8lbAikhKotoD8ZtI6YuwW9fH2Cl3XmQmBAYtnRwlUewQNPfqPpUKKbkc1ds6uc0+LqZ0sYvjE0/QwJiQzNdAO4P2lV2wBk+GHWOQdo1Fsk0/jkE2bl5OhlrTGgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zocnv1VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zocnv1VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D1F1F00A3A;
	Sun,  9 Aug 2026 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242899;
	bh=EU7FrtJrxvrTuu8VV3VEsfkBPQpH27r1EazV3gB/Myw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zocnv1VCx/AzB7rBygo5p0T8OIRRpxGPUWOaxZqSEl61K6rKq8Jn9e3L+AcOsF1ks
	 +WGC4KU/gyFMECpzHsMqHwkoQ+JGwSPqI86ESGLVptyzrRyvKCZ66RSK9danfj/i/0
	 fNm7pDKTPYKY8THKTXpKMimyhx/9J4T6IOne++Y1RhyAo5Zgvh9k5yqzY8e4UNS6pN
	 PYrOI/rCLoaDfVPFsr10bDY4V2BV1EgzK5ex3jKtyCmNijPCwj4fYr1sAsM6/16SPV
	 iOHwtSfbu/Zunr+VfZVlIP1AUC2RY/yAL4SdPB1R6DgBaQcjJObCqaNcJz8sgBqzPY
	 ycOZ2kWVxoKHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 6/7] net: mana: fix stale HWC response after
 command timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260808023417.1746886-7-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260808023417.1746886-7-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 02:34:58 +0000
Message-Id: <20260809023459.38D1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data race due to publishing the message slot before context initia=
lization
- [High] Flawed early response mitigation causes premature sender completio=
n and cascading slot corruption
--

--- Patch [6]: [PATCH net v4 6/7] net: mana: fix stale HWC response after c=
ommand timeout ---
commit f9387b68b6c4ace004d0fe502f200e95cf110776
Author: Long Li <longli@microsoft.com>

net: mana: fix stale HWC response after command timeout

This commit fixes an issue where a hardware command timeout leaves a stale
response in the channel, potentially corrupting subsequent requests. It
introduces a per-slot lock, refcount, and a responded flag to safely track
slot ownership between the sender and the CQ interrupt handler.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index adc7ad98ca8d8..2f0dae3539552 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -7,25 +7,58 @@
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
> =20
> +/* Acquire a free message slot from the inflight bitmap.  Returns
> + * -ETIMEDOUT if a prior HWC command has timed out (preserving the
> + * error code callers expect).
> + */
>  static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *m=
sg_id)
>  {
>  	struct gdma_resource *r =3D &hwc->inflight_msg_res;
>  	unsigned long flags;
>  	u32 index;
> =20
> -	down(&hwc->sema);
> +	for (;;) {
> +		spin_lock_irqsave(&r->lock, flags);
> =20
> -	spin_lock_irqsave(&r->lock, flags);
> +		if (hwc->hwc_timed_out) {
> +			spin_unlock_irqrestore(&r->lock, flags);
> +			return -ETIMEDOUT;
> +		}
> =20
> -	index =3D find_first_zero_bit(hwc->inflight_msg_res.map,
> -				    hwc->inflight_msg_res.size);
> +		index =3D find_first_zero_bit(r->map, r->size);
> +		if (index < r->size) {
> +			struct hwc_caller_ctx *ctx;
> +
> +			bitmap_set(r->map, index, 1);
> +			ctx =3D &hwc->caller_ctx[index];
> +			reinit_completion(&ctx->comp_event);

[Severity: High]
Could this publish the message slot before the context is fully initialized?

The slot is marked active in the bitmap with bitmap_set() before the
caller_ctx fields (comp_event, refcnt, responded, error) are initialized.

Since mana_hwc_handle_resp() checks the bitmap locklessly via test_bit():

mana_hwc_handle_resp() {
        ...
        if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
                dev_err(hwc->dev, "hwc_rx: invalid msg_id =3D %u\n", msg_id=
);
                ...
        }
        ctx =3D hwc->caller_ctx + msg_id;
        spin_lock(&ctx->lock);
        ...
}

If a stale or duplicate hardware response arrives at this exact moment,
can the interrupt handler observe the published bit and interact with the
partially initialized ctx fields?

> +			/* Take the response-side reference here, under
> +			 * r->lock and together with the slot bitmap bit,
> +			 * so a stale or duplicate response that lands
> +			 * before mana_hwc_send_request() posts the request
> +			 * cannot drop the refcount to zero and free the
> +			 * slot under the sender.  One reference is the
> +			 * sender's; the other is released by
> +			 * mana_hwc_handle_resp().
> +			 */
> +			refcount_set(&ctx->refcnt, 2);
> +			ctx->responded =3D false;
> +			ctx->msg_id =3D index;
> +			ctx->error =3D -EINPROGRESS;
> +			spin_unlock_irqrestore(&r->lock, flags);
> +			break;
> +		}

[ ... ]

> @@ -1039,6 +1119,10 @@ int mana_hwc_send_request(struct hw_channel_contex=
t *hwc, u32 req_len,
>  		dest_vrcq =3D hwc->pf_dest_vrcq_id;
>  	}
> =20
> +	/* handle_resp()'s reference was taken in mana_hwc_get_msg_index(),
> +	 * so hardware responding immediately after the doorbell ring cannot
> +	 * release the slot before this sender is done with it.
> +	 */
>  	err =3D mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {
>  		dev_err(hwc->dev, "HWC: Failed to post send WQE: %d\n", err);

[Severity: High]
Does this early response mitigation handle the sender's completion correctl=
y?

If a stale response arrives before mana_hwc_send_request() posts its WQE,
mana_hwc_handle_resp() processes it and calls complete(&ctx->comp_event).

When the sender then reaches wait_for_completion_timeout() right below the
WQE posting step, the completion is already signaled, so it will return
immediately as if successful.=20

The sender then drops its reference and frees the slot, even though the new=
ly
posted WQE is still actively being processed by the hardware.

If another thread reuses this slot, it will reset ctx->responded =3D false.
When the hardware later delivers the real response for the original request,
will mana_hwc_handle_resp() accept it and use it to complete the new thread=
's
request with incorrect data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D6
