Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165223BD05
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887084; cv=none; b=C0AfxLvNvSylH4rNq1Mv2Nulx3aCqKojHaPaa7a+6wbHmYGGLoetxYYwrKfUo1aGh9DPwRXjNuPSswfrJxIelneHCH616uLnBjn9P0eestHYG0nUtY4RDv437qFuhb8wAWswBDC80NjtCfjMhE3XGKifjSy6YXB+LUeJpmVNgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887084; c=relaxed/simple;
	bh=qJuY8io3dNEFpvwRFN2QxrACH/na7ZPeg7yXg4N/rI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZEky1vWJeuv5F0v/tJ1chh2yiwk5tZRNDKuAA8w3GORbigGTnJolHtZNabzgLPMt3CpgdCjWQhRvYKaZArjowNFf2LyFx5157Kmgix9BDKnDQe3xBg9+28c52R1JWWaAZUWOn6zDDdoehM8eoT8xWPfLwIf3frvWeP/qUJc/LvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpJeMTbc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpJeMTbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E0B1F00A3A;
	Tue,  4 Aug 2026 23:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887082;
	bh=eAJ6FBhXaSVQBRl+ydnPAyKQECCZwqxZjIOY8V7nM0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpJeMTbcB7nviP7P26sxnw2Mys84rBliURxfcSZUgNJlr2XxsiIUEyH7j8jrWflar
	 ke9xH40tFPL4BnWGlZ3jUFZExbzwkta9WfsI+mKkkTM6EmJJJF45yolFcqck2cC3tG
	 L3GbYKRg2rY20/aQIL3/hpKm+o7a6rAZcK2vyVo70n0POjDHDA47ManonMOwIkkB1N
	 4qSmg+gLJrtDlQJJeiov5oCuMAtiTZafdkSLsfO5rWqaDjvCV7pmrfHJ9Ec9hV/vXa
	 nHH8WRLf6sAgYskW8ZM8CwZSmr3FebyNvsJMHsrhCkaX4UBsWQfDrddDPVGYrcqPuT
	 xL0f8KMSy6YfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/6] net: mana: validate hardware-supplied values
 in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-5-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:42 +0000
Message-Id: <20260804234442.86E0B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A timeout in mana_hwc_send_request() can lead to stack corrupt=
ion and use-after-free if the hardware response arrives concurrently or is =
delayed.
--

--- Patch [4]: [PATCH net v3 4/6] net: mana: validate hardware-supplied val=
ues in the HWC RX path ---
commit c5cc55c1f3f3c4968b8391ae19f32c3ab101adc9
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit validates lengths and indices from the device DMA in the HWC RX
path. It adds bounds checks and address matching to prevent out-of-bounds
accesses or reading stale responses. A reposting mechanism is added for
rejected responses to maintain posted RQ depth.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index d701c427fe47b..e378b8ec97c9a 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -83,6 +83,17 @@ static void mana_hwc_handle_resp(struct hw_channel_con=
text *hwc, u32 resp_len,
>  	struct hwc_caller_ctx *ctx;
>  	int err;
> =20
[ ... ]
>  	ctx =3D hwc->caller_ctx + msg_id;
> +
> +	/* Reject responses larger than the RX DMA buffer =E2=80=94 the SGE
> +	 * limits what hardware can DMA, so an oversized resp_len
> +	 * indicates a firmware bug.  Fail rather than silently
> +	 * truncating.
> +	 */
> +	if (resp_len > rx_req->buf_len) {
> +		dev_err(hwc->dev, "HWC RX: resp_len %u > buf_len %u\n",
> +			resp_len, rx_req->buf_len);
> +		resp_len =3D 0;
> +	}
> +
>  	err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
>  	if (err)
>  		goto out;

[Severity: Critical]
This is a pre-existing issue, but I have a question about how timeouts are
handled when processing these contexts.

If a thread times out in mana_hwc_send_request() while waiting for
ctx->comp_event, does it return and free the stack frame where the
response buffer (ctx->output_buf) might be allocated?

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request() {
    ...
	if (!wait_for_completion_timeout(&ctx->comp_event,
					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
    ...
		err =3D -ETIMEDOUT;
		goto out;
	}
    ...
out:
	mana_hwc_put_msg_index(hwc, msg_id);
	return err;
}

Because the sender doesn't clear ctx->output_buf or synchronize with the RX
handler when returning on a timeout, could a delayed hardware response arri=
ving
later lead to stack corruption when mana_hwc_handle_resp() executes the
memcpy() into the now-dangling ctx->output_buf pointer?

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_handle_resp() {
    ...
	if (!err && ctx->output_buf) {
		ctx->status_code =3D resp_msg->status;
		memcpy(ctx->output_buf, resp_msg, resp_len);
		ctx->error =3D 0;
	}
    ...
}

Additionally, since there is no reinit_completion() call when allocating a
message slot, could a newly reused slot immediately consume a stale complet=
ion
token from a delayed response and return prematurely?

Could a malicious host or firmware in a Confidential VM environment exploit
this by intentionally delaying responses to overwrite the guest kernel stac=
k?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D4
