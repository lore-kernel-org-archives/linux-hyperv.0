Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B543CE72
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388499; cv=none; b=d6WzdF9RVMlsfDpvqwM0Cf1b9iXIha147j3cBCkuQ53RrxqoOK/gWy6Lfag/iDgBUSTLUo9M8yc05Q6n2x5lcK8OJTgN1Aciexa64y6YiY3oiN/otB6s6KLHVUDi/8YCd8ceApAdv58E7GmdXw9Mibo7gqSonIGcFzRF9UgcFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388499; c=relaxed/simple;
	bh=EreocK2e0aV5l8enA2SMzKaTKTpFCDxNokd76n1qUwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=th9H4nx8nu4kqwfO5cfbnYpeUxyIlghkNVXu4F2BJvo4vJKPc9WtOWJrpXcyK9xR/FzkMmh+pgXjUadZI7M29k3sU90Zaf93X24Ml1OCosX1rpag7fmS7zNHHXzhLfv+F0NHKGYtjyEPYD8XZdUqKp1+40Ser5sMkVMKetQRKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euGO7J6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euGO7J6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09931F00A3D;
	Mon, 10 Aug 2026 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388498;
	bh=zYKRK56jAxC7x9E9OL3wCWXUMPCtDo5xk9Slir1sjcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=euGO7J6TkT7rxGpHKbcbV4EM7UBx0qPwfCi4JmLGhwHGT5l8049rQvgJwlNeKsgZ0
	 dldbtsHStzibBKGQQUqGUc+z7NNaTcTm74a0lLZrUWXg63a6takbY/QUv6S4TEg7xr
	 0pun9ernUPXSY3R2tYvGFTIchuDfzyuSLWg8F6pp7z8xpE0Jk1ciiGVopRCQMtQjVk
	 muOaixe24JpHxBy5wvtGpTEVGIU4N8SoMDQLIPZRhjWwXn1C8l1n/L+6C5MSMQ0G6p
	 zjwDpKUuoDF6YLAq0pF0lf8jhftsQzunZfl8elr8f315zNTH+3mDnYj+5WrG3CJAIs
	 8GsCzl4hiT/Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 4/7] net: mana: validate hardware-supplied values
 in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-5-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:37 +0000
Message-Id: <20260810190137.E09931F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition between timeout path and RX interrupt handler l=
eading to kernel stack corruption and cross-request data corruption.
- [High] Missing length check before reading DMA response payload causes st=
ale message IDs to incorrectly complete unrelated requests.
--

--- Patch [4]: [PATCH net v5 4/7] net: mana: validate hardware-supplied val=
ues in the HWC RX path ---
commit 74a56502856c8211c5e1df5ca5d7019fd74fb6b6
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit adds validation for lengths, indices, and sizes taken from devi=
ce
DMA in the HWC RX path. It aims to protect against buggy firmware or
malicious hosts by snapshotting values and performing bounds checks. It also
drops the early return for short responses, deferring to mana_hwc_handle_re=
sp()
to handle them.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 19896bb5ce1a4..5db8cfe2d8443 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -90,6 +103,18 @@ static void mana_hwc_handle_resp(struct hw_channel_co=
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
This is a pre-existing issue, but is there a race condition between the
timeout path and the RX interrupt handler leading to kernel stack
corruption?

If a slow hardware response causes wait_for_completion_timeout() to
expire in mana_hwc_send_request(), the timeout path frees the msg_id
and returns:

mana_hwc_send_request() {
        err =3D wait_for_completion_timeout(...);
        if (!err) {
                err =3D -ETIMEDOUT;
                goto out;
        }
        ...
out:
        mana_hwc_put_msg_index(hwc, msg_id);
        return err;
}

Returning here pops the stack frame pointed to by ctx->output_buf.

If the interrupt handler is concurrently running and passes the bounds
checks, it could then execute memcpy() directly into this deallocated
stack frame:

mana_hwc_handle_resp() {
        ...
        memcpy(ctx->output_buf, resp_msg, resp_len);
        ...
}

Can this cause memory corruption, especially if the timed-out msg_id
is quickly reallocated to a new request which then gets overwritten
with the stale response?

>  	if (err)
>  		goto out;

[ ... ]

> @@ -259,28 +305,76 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
>  	resp =3D (struct gdma_resp_hdr *)rx_req->buf_va;
> =20
> -	/* Read msg_id once from DMA buffer to prevent TOCTOU:
> -	 * DMA memory is shared/unencrypted in CVMs - host can
> -	 * modify it between reads.
> +	/* Read msg_id once from the DMA buffer to prevent TOCTOU: DMA memory
> +	 * is shared/unencrypted in CVMs, so the host can modify it between
> +	 * reads.  A short response is not rejected here; it is handed to
> +	 * mana_hwc_handle_resp() below, whose mana_hwc_verify_resp_msg()
> +	 * fails it with -EPROTO and completes the waiting sender, so one
> +	 * malformed response cannot stall the whole channel.
>  	 */
>  	msg_id =3D READ_ONCE(resp->response.hwc_msg_id);

[Severity: High]
This isn't a bug introduced by this patch, but does reading the DMA
response payload without a length check cause stale message IDs to
incorrectly complete unrelated requests?

If the hardware or a malicious host provides an RX response with
tx_oob_data_size smaller than the offset required to contain the
hwc_msg_id field, it will not overwrite the hwc_msg_id field in the
persistent DMA ring buffer.

The driver then reads this stale msg_id in mana_hwc_rx_event_handler(),
which likely belongs to a previously completed request that has since
been re-allocated to a new, unrelated active request.

The driver subsequently fails this unrelated active request with -EPROTO
in mana_hwc_handle_resp():

mana_hwc_handle_resp() {
        ...
        err =3D mana_hwc_verify_resp_msg(ctx, resp_msg, resp_len);
        if (err)
                goto out;
        ...
out:
        ctx->error =3D err;
        ...
        complete(&ctx->comp_event);
}

Could a malicious host forge short DMA responses to intentionally abort
unrelated active requests?

>  	if (msg_id >=3D hwc->num_inflight_msg) {
>  		dev_err(hwc->dev, "HWC RX: wrong msg_id=3D%u\n", msg_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D4
