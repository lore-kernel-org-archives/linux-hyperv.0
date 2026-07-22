Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6638422F
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763979; cv=none; b=spIahr+qJ8Rk3VSzmHWRdIUZYmxOnHRsLiMuxpA+FMgV0prgm8MitWx31KqnWjBduKKJW8d8gVSdLh209TV0RZpYZfVP6dwJR9OtwwbvmHHjmzy4bD4jqQU0JW9Oo5eFrMajpj91WZp8Pk+hXka54yyOz1Eko2IVqJEPzxwY3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763979; c=relaxed/simple;
	bh=1Se3DoekFVHP46waw2GKBkCv7gbXfbsqyApsTPc+/Sw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDzlCTn/ulDyCIfX5HpE2u0MONoM9kyfQmgYLydwSljmiykxgKx213X0Twl9hEicNYhWQ6UBvCJd4T62uAEnJmC3dSd7OTSdWtQMEo0NnJUG/XL1s1OELGCRHcf9d/s5hGEeLDyAFQwj2dGk26BiQ3klCGMwc9YPXF/KvsIyIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYwRLO98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYwRLO98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765F1F000E9;
	Wed, 22 Jul 2026 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763978;
	bh=PLuVASTxTrOJyAvhoG7kMAAT2BubO4VhKePCwFhpwbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYwRLO98HMDsh5HeClACSP5yxB7X6nHOTWMUaKjALIlFiYng6JRR8kj0WkbLsN2O+
	 pxgi/8gvFUgRyPEdWublebtUnPt10PgCE1l2vkhu/FFhPKUjXVexjbb+pDIRyprxyx
	 XbYfMD5R/HuE7qiU88iPl8Xcd65EJzwkyjhY12n6CWbX43SNPyakhZBgvWUHuna9eD
	 y9j+4dv7J2+GetAU3k1oOezZx8OEOv2o8mcTaByEWQ88BfDxS8YCLq3yWQQN+KOLeF
	 VGkoEcISopp4Kfu6pCcwEBJbhT+Nd7b5nm7lMnMXsEC7FfBdJ1Yk7+NNc82qgMlrgF
	 Ezw9MAyS/YreA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: mana: validate hardware-supplied
 values in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721234339.1476932-5-longli@microsoft.com>
References: <20260721234339.1476932-1-longli@microsoft.com>
 <20260721234339.1476932-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:46:18 +0000
Message-Id: <20260722234618.6765F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but a race condi=
tion between the timeout path in `mana_hwc_send_request` and the hardware r=
esponse handler leads to use-after-free stack corruption or tag reuse.
--

--- Patch [4]: [PATCH net-next v2 4/7] net: mana: validate hardware-supplie=
d values in the HWC RX path ---
commit 20acf32024b20aecf06a023b18198388ad46e67f
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit adds validation to the hardware-supplied values in the MANA HWC
RX path. It prevents out-of-bounds access and stale response processing by
checking the SGE pointer, address, and response length against posted buffe=
rs.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 2239fdeda57cb..515c45c4a890f 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -83,6 +83,17 @@ static void mana_hwc_handle_resp(struct hw_channel_con=
text *hwc, u32 resp_len,
>  	struct hwc_caller_ctx *ctx;
>  	int err;
> =20
> +	/* Validate msg_id is in range before using it to index bitmap
> +	 * and caller_ctx array.  Malicious firmware could send
> +	 * out-of-range msg_id causing out-of-bounds access.
> +	 */
> +	if (msg_id >=3D hwc->num_inflight_msg) {
> +		dev_err(hwc->dev, "hwc_rx: msg_id %u >=3D max %u\n",
> +			msg_id, hwc->num_inflight_msg);
> +		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> +		return;
> +	}
> +
>  	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
>  		dev_err(hwc->dev, "hwc_rx: invalid msg_id =3D %u\n", msg_id);
>  		mana_hwc_post_rx_wqe(hwc->rxq, rx_req);
> @@ -90,6 +101,18 @@ static void mana_hwc_handle_resp(struct hw_channel_co=
ntext *hwc, u32 resp_len,
>  	}
> =20
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

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for a delayed
hardware response to corrupt the stack here?

If a request times out in mana_hwc_send_request(), wait_for_completion_time=
out()
expires and the function jumps to the "out" label where it calls
mana_hwc_put_msg_index(hwc, msg_id). This releases the msg_id for reuse wit=
hout
clearing ctx->output_buf (which points to a buffer on the caller's stack).

If another thread subsequently allocates this same msg_id, it will set the
in-flight bit. If the delayed hardware response for the original request ar=
rives
at this exact moment, mana_hwc_handle_resp() will pass the test_bit() check
above.

It will then proceed to copy the response data into ctx->output_buf:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_handle_resp() {
    ...
    if (!err && ctx->output_buf) {
        ctx->status_code =3D resp_msg->status;
        memcpy(ctx->output_buf, resp_msg, resp_len);
        ctx->error =3D 0;
    }
    ...
}

If the new thread hasn't yet updated ctx->output_buf, wouldn't this memcpy()
write DMA data directly into the timed-out caller's freed stack frame, caus=
ing
a use-after-free stack corruption?

Alternatively, if the new thread has already updated ctx->output_buf, could=
 this
prematurely complete the new sender's request with stale data from the dela=
yed
response?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721234339.1476=
932-1-longli@microsoft.com?part=3D4
