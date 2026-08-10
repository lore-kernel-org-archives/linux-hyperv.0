Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F043BDC1
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388501; cv=none; b=HXG+7Jjje2B/uYCf1NTtLhHxmRAtAno/DIFSnSCTYK1jhkzbuDWzhtysnemF8t1Cl7VrDu+KQw2GmnwY4FajqY9seD3uJuDiI1zUjfhv2nZhtXw3+4/CpwUuLsn+70EDpnfGQhlVxlMSmmwdtaRoEWZQuLrzL9tvekBIuRoEVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388501; c=relaxed/simple;
	bh=ARoqofLIwv14oJAH88zHz/YImYucjzhwVr1uCNbdoME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aemKwyko56C8x3nOfyqJNgT3s7k3B15iLlOKz1g5VP0Qf9jrB/7xzmJVKcDUor46Zwu/O5DKwTzMkaC8Rd+/mPid6WAibnXqIKHgipLzMQCelS61PHo9tZxpyPfjIzWzhJY+QUVhncbueP0Dhz29B4oIUXk3EJcuwpMSlSONhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULBiu20x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULBiu20x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599B1F000E9;
	Mon, 10 Aug 2026 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388499;
	bh=DMkEmSMchFJzoB1YWaRFhde9F8kK64iOFs8TzLG0Bnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULBiu20xYOa5zH00Zx/rDY/ChT5t9LKKXfV8YWV0NyOqpG3JAEd7XkH/TQo98a/Gh
	 hhNxhxu7pw0jC9e9fY3LfNAtD4Xk7wF7numZuK5z9CIUGkfj1iGE+wVTHqCYSEA50C
	 gNR6n0GlVHpzkUL/W7tlItV3zX5VMf70ZIdL2VW6c9g5eIYAHLb513dkfoMmTWxoVO
	 OD41cBWLoqL7D6I0E7BPXxTrYownrM+1eaQh7S1LApvDxmOMlEs2rFSnE1ZVKHgkyO
	 5Yxz/QNKK9VIM2POe4rmZFs7BZFvN6kalUBBhWquD5h7uKhmgw4gD/rOZAQoV7c2a8
	 synUrPBJhgkCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/7] net: mana: fix HWC RQ/SQ buffer size swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260809190047.2086368-3-longli@microsoft.com>
References: <20260809190047.2086368-1-longli@microsoft.com>
 <20260809190047.2086368-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:01:38 +0000
Message-Id: <20260810190139.A599B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-after-free on stack buffer due to missing synchronization =
between timeout handler and RX completion.
- [High] Teardown sequence in mana_hwc_destroy_channel() frees WQs before q=
uiescing the CQ, causing a UAF if an in-flight EQ handler runs concurrently.
- [High] In a Confidential VM setup, a malicious host can modify the unencr=
ypted DMA memory field `inline_oob_size_div4` in the receive queue ring buf=
fer to cause the guest to read past the end of the ring buffer allocation, =
resulting in a kernel panic.
--

--- Patch [2]: [PATCH net v5 2/7] net: mana: fix HWC RQ/SQ buffer size swap=
 ---
commit b0ce57145f46d4e8a027e81baea5f74199a24b8e
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC RQ/SQ buffer size swap

The HWC RQ receives responses and the SQ sends requests, but
mana_hwc_init_queues() sized the RQ with max_req_msg_size and the SQ with
max_resp_msg_size -- backwards.  mana_hwc_rx_event_handler() also
recovered the RX slot index by dividing by max_req_msg_size instead of
the response size that strides the RQ buffer.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 409e20caeccdc..3f011ebbe7b3e 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -263,7 +263,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 =
gdma_rxq_id,
> =20
>  	/* Select the RX work request for virtual address and for reposting. */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
> -	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;
> +	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;

[Severity: High]
This isn't a bug introduced by this patch, but does mana_hwc_destroy_channe=
l()
in hw_channel.c free the WQs before quiescing the CQ?

In mana_hwc_destroy_channel():
	if (hwc->rxq)
		mana_hwc_destroy_wq(hwc, hwc->rxq);
	if (hwc->cq)
		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

If an EQ interrupt fires concurrently before mana_hwc_destroy_cq() is calle=
d,=20
can mana_gd_process_eq_events() look up the still-published CQ, invoking=20
mana_hwc_rx_event_handler() which dereferences the freed hwc->rxq here?


[Severity: High]
This is a pre-existing issue, but can a malicious host cause an out-of-boun=
ds
dereference when we read sge->address here?

Earlier in mana_hwc_rx_event_handler():
	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);

If this is a Confidential VM, dma_oob resides in unencrypted DMA memory
shared with the host. Can the host supply an arbitrarily large
inline_oob_size_div4, forcing the guest kernel to dereference unmapped memo=
ry
when reading sge->address?


[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free on the stack
buffer if mana_hwc_send_request() times out?

If mana_hwc_send_request() times out, it clears the inflight bit and return=
s,
leaving ctx->output_buf pointing to an invalid stack frame.=20

Concurrently, mana_hwc_rx_event_handler() calls mana_hwc_handle_resp() which
does a lockless test_bit():

	if (!test_bit(msg_id, hwc->inflight_msg_res.map))
		return;

	...
	memcpy(ctx->output_buf, resp_msg, resp_len);

If the timeout thread clears the bit and returns just after the test_bit()
check in mana_hwc_handle_resp(), will we copy the response data into a popp=
ed
stack frame?

> =20
>  	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
>  		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809190047.2086=
368-1-longli@microsoft.com?part=3D2
