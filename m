Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33454908BF
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729402; cv=none; b=tJGCZ31uScdLYlIk2O9ACRPLXrT8Ls757ce058KF5V5hNwXA4Z7PvlgehQcCt1OgJuXOB/ndyN8Aq09/zKLOhkpMUZHQNVjUXEmbB+6M8WoMiwE+z1kABJuYcx/sLPve4ED/hJZthWZxPo1FkPKhvmJkTmJj2e9Gj0kb+2RNFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729402; c=relaxed/simple;
	bh=bM9Iv1CVlKxc+kCnRnbWQYnT/XgaSxUlmQcEgVTycnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMWB05aOe9leTkK+fqaPKCd/FBPgZKZ23UN66ijl0/QkbWbTybE+C3Ekqf+TFA3rd+dk4ChrnruQXWt1CElbNgVqBCkVsPnYw7qvFOkPUtasqhv0eDKK7OjcIQhWMgNdeSL+ebtoFMqWuyfDZEHlVPU31zU1Gd9EKYYYS/PaIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ4x423l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ4x423l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A76B1F000E9;
	Fri, 14 Aug 2026 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729401;
	bh=whz2hULmIMXs9gfKaN+leaq2OGImIeBgycS3Ellib3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQ4x423liwylhK8NyYpD7MBsS0xOmbRMt4Gp3PzKTQFDwLtdXpq/+KDnkVs8ho8Y0
	 N/o+HyGvgFAuNgvOmBVvLX6X6eyWDplnFWcRVGxOJJ7PIDD1cHg0RGLgIi+2HMdQw9
	 loKA4x6jBGo4n5UZn+dwiH2V5+cRbJpL4rxoYFjDTNt/Xjw939viyCy6gWJ4bB8YIP
	 U9t4d0RCj66EUK7TihvKczMORb9QgEcYNgBQpdaub3QweQcTYFwZkIk35cOPyCLfn0
	 BopnfSc5I0z8ntNMnpgVCrfgDq666nBh/OcaUbHQqwn2GQ3A6yWdrFhzRDf8jPXbRV
	 tMtufhKOuQhHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 4/7] net: mana: validate hardware-supplied values
 in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-5-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:21 +0000
Message-Id: <20260814174321.6A76B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Unprotected concurrent modification of `hwc->hwc_timeout` across=
 hardirq and process contexts.

Pre-existing issues:
- [Critical] A race condition exists between `mana_hwc_send_request` timeou=
ts and delayed hardware completions, leading to Use-After-Free and stack co=
rruption of reused message slots.
- [High] Short or malformed hardware responses abort unrelated in-flight re=
quests due to reading stale `msg_id` data from the DMA buffer.
--

--- Patch [4]: [PATCH net v7 4/7] net: mana: validate hardware-supplied val=
ues in the HWC RX path ---
commit 77109d87fe60b75679f5bdbcf384cc1fe90785bf
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit adds validation for lengths and indices received from device DMA
in the HWC RX path. It ensures OOB sizes, SGE addresses, response lengths,
and message IDs are within expected bounds before processing to prevent
out-of-bounds access or processing wrong requests.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 7e01596df11b6..2691d60945912 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -83,13 +83,29 @@ static void mana_hwc_handle_resp(struct hw_channel_co=
ntext *hwc, u32 resp_len,
>  	struct hwc_caller_ctx *ctx;
>  	int err;
> =20
[ ... ]
>  	ctx =3D hwc->caller_ctx + msg_id;
> +
> +	/* An oversized resp_len cannot fit the RX buffer: reject it. */
> +	if (resp_len > rx_req->buf_len) {
> +		dev_err_ratelimited(hwc->dev, "HWC RX: resp_len %u > buf_len %u\n",
> +				    resp_len, rx_req->buf_len);
> +		resp_len =3D 0;
> +	}
> +
>  	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);

[Severity: Critical]
This isn't a bug introduced by this patch, but does a race condition exist
between mana_hwc_send_request timeouts and delayed hardware completions?

If mana_hwc_send_request times out, it releases the msg_id back to the pool
without synchronizing with the asynchronous response handler, abandoning the
request and destroying its stack frame.

If a delayed hardware completion triggers mana_hwc_handle_resp() later, cou=
ld
this lead to a use-after-free and stack memory corruption when it copies da=
ta
into the newly reused ctx->output_buf?

[ ... ]
> @@ -237,18 +253,37 @@ static void mana_hwc_init_event_handler(void *ctx, =
struct gdma_queue *q_self,
>  	}
>  }
> =20
> +/* Drop an RX WQE with an untrusted SGE rather than repost it, which cou=
ld
> + * double-post a buffer the device still owns.  This lowers the RQ depth;
> + * once it is exhausted the channel can no longer receive, so log it and
> + * shorten the timeout to fail callers fast.
> + */
> +static void mana_hwc_rx_leak_wqe(struct hw_channel_context *hwc)
> +{
> +	if (++hwc->rx_leaked_wqe =3D=3D hwc->rxq->queue_depth) {
> +		dev_err(hwc->dev,
> +			"HWC RX: RQ exhausted after %u leaked WQEs; channel unusable\n",
> +			hwc->rx_leaked_wqe);
> +		if (hwc->hwc_timeout > 1)
> +			hwc->hwc_timeout =3D 1;

[Severity: Medium]
Is this modification of hwc->hwc_timeout safe from concurrent access?

This function introduces an unprotected modification to the shared timeout
state. Since it modifies hwc->hwc_timeout without locks or WRITE_ONCE() from
hardirq context, could this cause unpredictable timeout evaluations if it
races with process context readers or writers?

> +	}
> +}
> +
[ ... ]
> @@ -259,28 +294,58 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
[ ... ]
> -	/* Read msg_id once from DMA buffer to prevent TOCTOU:
> -	 * DMA memory is shared/unencrypted in CVMs - host can
> -	 * modify it between reads.
> +	/* Read msg_id once: it is host-writable DMA memory.  A short response
> +	 * is left for mana_hwc_handle_resp() to reject, so it cannot stall
> +	 * the channel.
>  	 */
>  	msg_id =3D READ_ONCE(resp->response.hwc_msg_id);

[Severity: High]
This is a pre-existing issue, but can reading msg_id from DMA memory here
cause unrelated in-flight requests to be aborted?

If a short or malformed hardware response is received, the code reads a
potentially stale msg_id directly from the DMA buffer and delegates rejecti=
on
to mana_hwc_handle_resp().

Could a malicious host or buggy hardware force the completion and abortion =
of
an unrelated in-flight request using this unverified msg_id?

>  	if (msg_id >=3D hwc->num_inflight_msg) {
> -		dev_err(hwc->dev, "HWC RX: wrong msg_id=3D%u\n", msg_id);
> +		dev_err_ratelimited(hwc->dev, "HWC RX: wrong msg_id=3D%u\n", msg_id);
> +		mana_hwc_post_rx_wqe(hwc_rxq, rx_req);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D4
