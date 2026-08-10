Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1843B490
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388503; cv=none; b=DJhwXHxyG19Nguw2iYvOciMHcsX9Hm6mPPj2qUsSjIm3gAQ1wcBfFRSjWP0ZsHVLVpuEqiLf4JZXDqm4hYbhvzGoHR8Z67p/10OSEXPqciCeZmJmQfiw6zIMMQg7uJATtfSMR4L6bNLohxOQNW/S1jJIx24aKzsVCxmRcVRRieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388503; c=relaxed/simple;
	bh=ZJA5niTldJpS3tBWxktgC151sVwICXCYJUmoxbYMLqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pj7xD7TFpXCC9xmCs1mTf9XGo+05YOgeWei0qomrkoBFZmmjAWpP1fdlQK+6MhgVkkGoEz2URXNPppPEye0bU6aAbKl4SC+jH8KYrFUEaMyjNDP56L5zRbI6+o8RRXCQksu5zAbKTgttzULmWi/qSdqz1Uj/EN+ALfv//trtEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQxx9Rkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQxx9Rkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E13C1F00A3A;
	Mon, 10 Aug 2026 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388502;
	bh=bN/h/Xe8sVFeUp7iefR7ZU1iHlAdjRwbeop7i/edJCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQxx9Rknpk9H6PdjhINGOuJnjLTCLNbb2z5fQZw6b4YK4gbFspmbcw0igUquevxH8
	 LI0GAsrnozeTX0QKHyd8EqtlARUsRSBGdLtQa8t85uWSOQMpHEhrQ8IfeMpxkZgY5C
	 hw5kjWrCVjskAQmNnKPRBxjI9ieJ8buoW+nfHvw6Y1qAt9rjf+7J7ZeezCG9p5rY7d
	 0SPzEp2Dcw20gwx3pJAUMphW+Nb0lwi3Jz/PuvKS4k8CHyyBPOtWdQQ887SG1iAkEw
	 IZgzNdcmelX3m1JF6l8cbs/i9/fCvPlsddhXc3sICAaXacYNkHHIYbYMZllNY3767H
	 ETwZ/R14xsraA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 6/7] net: mana: fix stale HWC response after
 command timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-7-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-7-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:40 +0000
Message-Id: <20260810190141.8E13C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logic flaw in handling stale/duplicate responses causes premature =
request failure and slot reuse.
- [High] Data race: message slot is published to the inflight bitmap before=
 context initialization is complete.
--

--- Patch [6]: [PATCH net v5 6/7] net: mana: fix stale HWC response after c=
ommand timeout ---
commit 7b87368dbc534bab9b5a48c46518ecb9efb9318e
Author: Long Li <longli@microsoft.com>

net: mana: fix stale HWC response after command timeout

This commit attempts to fix a race condition where an HWC response
arrives after a command timeout by giving each caller context a spinlock
and a refcount. It prevents reusing slots whose responses are still
outstanding.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -7,25 +7,58 @@
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
Can a concurrent stale response observe the bitmap before the context is
fully initialized?

If a stale response arrives for this index on another CPU,
mana_hwc_handle_resp() could see the bit set in the inflight bitmap via
test_bit() and proceed to locklessly read and modify context fields while
they are still being initialized here.=20

Because ctx->lock is not held during this initialization,
mana_hwc_handle_resp() might observe an uninitialized state, such as an
empty refcnt. This could cause a refcount underflow when hwc_ctx_put()
is called, or race with reinit_completion().

> +			/* Take the response-side reference here, under
> +			 * r->lock and together with the slot bitmap bit,

[ ... ]

> @@ -116,22 +156,44 @@ static void mana_hwc_handle_resp(struct hw_channel_=
context *hwc, u32 resp_len,
>  		resp_len =3D 0;
>  	}
> =20
> -	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
> -	if (err)
> -		goto out;
> +	spin_lock(&ctx->lock);
> =20
> -	ctx->status_code =3D resp_msg->status;
> +	if (ctx->responded) {
> +		/* A response for this slot was already delivered; this is a
> +		 * duplicate or replayed one.  Drop it so the hwc_ctx_put()
> +		 * a first response performs is not done twice, which would
> +		 * over-release the slot while the sender still owns it.
> +		 */
> +		spin_unlock(&ctx->lock);
> +		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> +		return;
> +	}
> +	ctx->responded =3D true;
> =20
> -	memcpy(ctx->output_buf, resp_msg, resp_len);
> -out:
> -	ctx->error =3D err;
> +	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
> +
> +	if (!err && ctx->output_buf) {
> +		ctx->status_code =3D resp_msg->status;
> +		memcpy(ctx->output_buf, resp_msg, resp_len);
> +		ctx->error =3D 0;
> +	} else if (ctx->output_buf) {
> +		/* Record the error only while the sender still owns the
> +		 * request: a non-NULL output_buf means it is still waiting.
> +		 * Once it has timed out (or been force-completed by destroy)
> +		 * it clears output_buf and takes its own error, so a late
> +		 * response must not write ctx->error or the buffer here.
> +		 */
> +		ctx->error =3D err;
> +	}
> =20
> -	/* Must post rx wqe before complete(), otherwise the next rx may
> -	 * hit no_wqe error.
> +	/* Post RX WQE before completing =E2=80=94 the next response may arrive
> +	 * immediately and needs a posted buffer.
>  	 */
>  	mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> -
>  	complete(&ctx->comp_event);

[Severity: High]
Could a stale response that arrives before the sender sets output_buf cause
the new request to fail prematurely?

If a stale response arrives after a message slot is allocated, but before
mana_hwc_send_request() sets output_buf to a non-NULL value,
mana_hwc_handle_resp() will execute this path. Because output_buf is NULL,
ctx->error remains -EINPROGRESS.=20

It then sets ctx->responded =3D true and signals ctx->comp_event.=20

When mana_hwc_send_request() subsequently sets output_buf, posts the new
WQE, and waits on the completion event, wait_for_completion_timeout()
will return immediately because it was already completed.=20

The sender will then read -EINPROGRESS from ctx->error, assume a failure,
and free the message slot while its newly posted WQE is still actively in
flight. This could potentially lead to data corruption when the real respon=
se
arrives and corrupts the next request's buffer.

> +	spin_unlock(&ctx->lock);
> +
> +	hwc_ctx_put(hwc, ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D6
