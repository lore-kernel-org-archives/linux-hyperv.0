Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E31A316E
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172620; cv=none; b=CNe95TbIB0WkdULdVSxBihUonORLgZXZZ3CfXGHpej4sLnqUGQgf+28gRnu7wUw/XpOMHqz0ZSL8Kgo4qbRy1d5X5inTQKql4GqIdJaoXcKTc54dwp1AAHZqo5plfSJCZ4+BcTr6b5ZVyaKhLviTFphalGEqpIGr4H62/9yUzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172620; c=relaxed/simple;
	bh=zaPdsBN/MkaOUNjVxHEkB89o+BVrrbAmHj9dTokE2gc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oU6dT4wEjJ8/+kNDimvOTACcCoCEW9vZnYueKvXIggjbXnlM5rwue6dDNFC1/Xp7rjNCkP444hVKfsztioD8hGUfr8ptbmvk0aKKnXDvJVBj1z4ledI9tDX9q87xMbvjf2XrP0G+mIdJbLXXmk14D1ehrSdCXvF6QIjLr54DKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgwdQwJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgwdQwJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3D41F000E9;
	Thu, 16 Jul 2026 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784172619;
	bh=I50k+toDGQ/4wcM4jyjkT1OjwsY7LOrxEwvcbJh0cWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UgwdQwJkPlgB+tlHbf+Bq0TyWFUnl7MrbiIBY6/Gl1CCK5wOEIl2ILkhh+eNFV9MF
	 QTV7JsbA0XQ/NGWZZsE6NZX1hDoWzctI5YDWMQw9NQ21Y+AziVc3dQ8vxPioISkdg4
	 8gXGcjrjWVDqg143ukC3/wsiCJmbBPhmCv8QMyV0FFfWrAtp5uRDw4mC+GIxScyAVp
	 p88I8xVFfXWapr6subZvP3e61JqJ49icarBY3zcIgUJFhiyFpo9fF4M86SuFlnQXG6
	 9Y2muvRiQ57XR3N+wKlmKFYHZZ3kP8oMRU3RGrg6keiCg/tEPfKHhbkrRIe1fzqSAQ
	 brJ3uhB8kXqRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/7] net: mana: validate hardware-supplied
 values in the HWC RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260715032942.3945317-5-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
 <20260715032942.3945317-5-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:30:18 +0000
Message-Id: <20260716033018.DB3D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A lack of synchronization between the request timeout path and=
 the interrupt response handler leads to severe stack memory corruption and=
 data leakage due to reused message IDs.
- [High] An unvalidated `inline_oob_size_div4` value read from shared DMA m=
emory is used to calculate the `sge` pointer, leading to an out-of-bounds r=
ead and kernel panic.
--

--- Patch [4]: [PATCH net-next 4/7] net: mana: validate hardware-supplied v=
alues in the HWC RX path ---
commit 2b4c8935e9727b2b08f9773b13a4caaa94f11d99
Author: Long Li <longli@microsoft.com>

net: mana: validate hardware-supplied values in the HWC RX path

This commit adds validation for lengths and indices received from device DMA
in the hardware channel receive path. It verifies the SGE address matches
the posted slot, ensures the response covers the header, bounds checks the
message ID, and rejects oversized responses to prevent out of bounds access.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 2239fdeda57cb..68236727aee8b 100644
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
>  	if (err)
>  		goto out;

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a race condition
between the request timeout path and this interrupt response handler?

If wait_for_completion_timeout() expires in mana_hwc_send_request(), the
function clears the message ID bit and returns. This leaves ctx->output_buf
dangling, pointing to the caller's stack frame.

If the hardware response arrives immediately after, or if the message ID is
reused by a new thread, could mana_hwc_handle_resp() read the ID and
execute memcpy() into the dangling output_buf? Since no lock is held to
verify the sender thread is still waiting, it seems this could lead to stack
memory corruption and cross-request data leakage.

[ ... ]

> @@ -261,19 +284,45 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
> =20
>  	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4=
);

[Severity: High]
This is a pre-existing issue, but does this calculation lack bounds checking
for the sge pointer?

The inline_oob_size_div4 field is read directly from the untrusted DMA WQE,
multiplied by 4, and added to the WQE pointer. If the WQE is located at the
very end of the page-aligned DMA ring buffer (for example, at offset 4064
in a 4096-byte page), could this unchecked addition cause the resulting sge
pointer to exceed the queue buffer boundary?

This could lead to an out-of-bounds read and kernel panic when sge->address
is later dereferenced, which might be reachable by a malicious host in a
confidential VM environment.

> -	/* Select the RX work request for virtual address and for reposting. */
> +	/* Recover the originating RX slot from the SGE address.  Of the three
> +	 * terms here only sge->address lives in device-accessible RQ memory;
> +	 * rq_base_addr and max_resp_msg_size are driver-private constants.  An
> +	 * in-range but wrong/unaligned SGE (corrupted WQE, or a malicious host
> +	 * in a CVM) would otherwise truncate onto a neighbouring slot, letting
> +	 * us read a stale response that could complete the wrong, reused
> +	 * in-flight request.  Require the index to be in range AND the address
> +	 * to exactly match the value the driver posted for that slot.
> +	 */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
>  	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715032942.3945=
317-1-longli@microsoft.com?part=3D4
