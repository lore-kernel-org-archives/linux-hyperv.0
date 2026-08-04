Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885463DA7CA
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887080; cv=none; b=DppZVwwlc44t1HcHs9dohb+kxo2NglPdF9CQBUtx85O4C7ezn/QdH9p4rqjtNqKMXVlCO3+lUx/kZDYuFeN5lYcNYzAXzzqWd6UUA1kzPQ1uA+rthmCVKpqVtHw6UqAfZKBrFHCzZEK/dv6/HDDAv0joEEOHch/dBFFyBQtcIM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887080; c=relaxed/simple;
	bh=HKzDbfefbRqhE7uECb43JsllqeTFqUkl8A5Acvzo8Fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwSiWFp67OltSho3qGgVLpjqrHqC+babLTZsrmLQg5CZZOXBmGWAoAvb0tX9vrmaj2NICuANKVACabrxQqhnSHTR8IJAk7asXMLmR4iXY6WwfOrfrTCwhVwnKaf2nuQaTxievGj5MRKCyqdfBH+mUpgyKZZEQprlB/S85zJejYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDW07V+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDW07V+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8211F000E9;
	Tue,  4 Aug 2026 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887079;
	bh=DTYXWZjUYgOFZ0/5qOkB0bt1eN+Ll7KidaMTpva5XSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDW07V+NciylEayKb/7+sP0YALEvP0PGdv/FAcL6/PFQhSG7j+JD1MA2VX34eQcb1
	 uugx2/PDaC8gKj8u97KPwsdr9HoUQjQV3EVI1VWThA7c/d0PwN7Rk+mFb5EHwbMpWr
	 1bvmtBHdj+2/plhAAHk6PCywIxUcW/Hell4mPIrJHjriAHjyKqbZzPE7BA6zVTDkAh
	 gO+bGcebTq6R1nXfrN+Xm1T2bd5YrvFh5FSkb69ErIyXuFpbgwxPb8Z/KNx4WkMMX9
	 yIAv3Rj1ITu+Y8oMKu3X6qAMrmuimNUa2dO+DMZU3MaFQ/nxZubHb/OgiglG1Y7Ap+
	 xZMUh874W/Peg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/6] net: mana: fix HWC RQ/SQ buffer size swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-3-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:39 +0000
Message-Id: <20260804234439.4C8211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-Bounds Memory Read due to unvalidated `inline_oob_size_div4=
` from untrusted DMA memory.
- [High] Use-After-Free during hardware channel teardown due to incorrect d=
estruction order and premature freeing of buffers.
- [High] Race condition / UAF in `mana_hwc_send_request` due to uncoordinat=
ed timeout handling.
--

--- Patch [2]: [PATCH net v3 2/6] net: mana: fix HWC RQ/SQ buffer size swap=
 ---
commit 2b43add14b8efbca0def0e3777e0b101884e1da7
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC RQ/SQ buffer size swap

This commit fixes an issue where the HWC RQ and SQ buffer sizes were
swapped during initialization. It ensures the RQ is sized with
max_resp_msg_size and the SQ with max_req_msg_size. The commit also
reorders the assignment of these queue dimensions before creating the CQ,
as the RX completion handler depends on them being set.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 409e20caeccdc..cbb56c7647876 100644
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
This is a pre-existing issue, but does this function have an out-of-bounds
memory read when parsing the WQE?

Looking at the code just before this modification in
mana_hwc_rx_event_handler():

	dma_oob =3D (struct gdma_wqe *)wqe;
	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);
	...
	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;

Because inline_oob_size_div4 is read directly from the untrusted DMA buffer
without validation, could a compromised hypervisor provide a large value
that causes the sge pointer to point past the end of the mapped buffer,
resulting in a kernel panic when sge->address is dereferenced?

> =20
>  	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
>  		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during
hardware channel teardown?

In mana_hwc_destroy_channel():

	if (hwc->txq)
		mana_hwc_destroy_wq(hwc, hwc->txq);

	if (hwc->rxq)
		mana_hwc_destroy_wq(hwc, hwc->rxq);

	if (hwc->cq)
		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

The queues (txq and rxq) are destroyed and their memory is freed before the
CQ's RCU synchronization barrier is reached.

Inside mana_hwc_destroy_cq():

	kfree(hwc_cq->comp_buf);

	if (hwc_cq->gdma_cq)
		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);

The comp_buf array is freed immediately, but the synchronize_rcu() barrier
sits inside mana_gd_destroy_queue(). Does this allow in-flight IRQ handlers
to access freed memory (txq, rxq, and comp_buf) before the RCU barrier
completes?

[Severity: High]
This is a pre-existing issue, but is there a race condition between the
timeout path and the response handler that could cause stack corruption?

In mana_hwc_send_request():

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

The timeout path exits and frees the message ID without synchronizing with
the receiver thread or clearing ctx->output_buf.

Meanwhile, in mana_hwc_handle_resp():

	if (!test_bit(msg_id, hwc->inflight_msg_res.map)) {
		...
	ctx =3D hwc->caller_ctx + msg_id;
	...
	memcpy(ctx->output_buf, resp_msg, resp_len);

The test_bit() check is done locklessly. If a timeout occurs right after
test_bit() succeeds, mana_hwc_send_request() will return and pop the
caller's stack frame. Will the response handler then memcpy() into a
dangling stack pointer (ctx->output_buf), corrupting the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D2
