Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40C4908BF
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729405; cv=none; b=ou9sd8gCiGTQP+t9BuEgt0BW0T6ZNlRjde4kZ/RY1hBE8jR0jbDmsf5mp6auppTaQgqI7xsgcPcJXqnTQ903jkgf5QxBIVSa2dGgm8vvbzq6P+TBkP9uoO3EIJSwuEpGMLA27h8yBhaZ8CB1ML11C25N+Vfser1l82Cq0oreHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729405; c=relaxed/simple;
	bh=K0YMLe+OMoHwEUyXNwiE2GLsNRXPt6sPeW5Z20HsYIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RltOGIEjrUeEx3K6IESvABnRwxIfZoTIK3Uju+pfP531SHBowfuvHtFjiC6BLXXk4it1/xbAQ/TflNW6MxO6AL2W3RCWDN1I/3M2lboCqJQnletyjREUC08bnOiwBiAJSQiZmqyhhFK6OXpm8bt23DRw+NuMpM69vZEkJEpwkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuudrGBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuudrGBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354161F00A3D;
	Fri, 14 Aug 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729404;
	bh=8udgr8MQoEni37t8fZuHx46Q+LH+pWgaNMfMTpwjBwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XuudrGBDThfjMfXijAIT0bCLVYviCy+AeEgYEk4FJ8J/AWHQqksp8+y67h+6fS14/
	 fA0P+Q9iuAeL8NAiPM4muVc64bNaJpEADXrGB3GZDZ1ysO13GHz9vK9QVT5jQd/kh9
	 odx40jDqrzUcPP7sZQN4iHnmpCE6mEqY5Slf+iwd5vi8+2Cs00ZwV9C2TE/adNc3ow
	 hViWZJEBavaJBwaIBf2rnr3p3NTg1gpSt6ISX0QcdFAKDhHVxk0hnJF05zOw73FfXB
	 CgrCKyBdU34ffuBIkdmtyP0oRAkur2lWfx8hQ6mZBpLrcol1vlhniRwSfum8SJ5h20
	 G9wOMIMMxzKKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 2/7] net: mana: fix HWC RQ/SQ buffer size swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813174243.3044348-3-longli@microsoft.com>
References: <20260813174243.3044348-1-longli@microsoft.com>
 <20260813174243.3044348-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:43:23 +0000
Message-Id: <20260814174324.354161F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A timed-out HWC request prematurely releases its msg_id slot w=
ithout hardware cancellation, allowing a delayed hardware response to corru=
pt the memory of a subsequent request.
- [High] mana_hwc_send_request() does not reinitialize the completion event=
 before waiting, making it vulnerable to duplicate hardware responses.
- [High] The asynchronous work item `mana_serv_func` is scheduled on the gl=
obal system workqueue but never canceled during device removal, leading to =
a race condition and UAF on `gc`.
- [High] Untrusted inline_oob_size_div4 from DMA memory causes an out-of-bo=
unds read when parsing the WQE.
- [High] The HWC RX event handler drops RX WQEs and permanently drains the =
receive queue if the device returns a bogus msg_id or rx_req_idx.
--

--- Patch [2]: [PATCH net v7 2/7] net: mana: fix HWC RQ/SQ buffer size swap=
 ---
commit 55639f5c7ee6bd080a63d387fa6ec19ca3c639a4
Author: Long Li <longli@microsoft.com>
net: mana: fix HWC RQ/SQ buffer size swap

This patch corrects the buffer sizes used for the hardware channel (HWC)
queues. It sizes the receive queue (RQ) with max_resp_msg_size and the send
queue (SQ) with max_req_msg_size, fixing a latent bug where these sizes
were incorrectly swapped during queue initialization.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index b5ed2dbce6ceb..ccef9bf9c6bfd 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -263,7 +263,7 @@ static void mana_hwc_rx_event_handler(void *ctx, u32 =
gdma_rxq_id,
> =20
>  	/* Select the RX work request for virtual address and for reposting. */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
> -	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;
> +	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;
> =20
>  	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
>  		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",

[Severity: High]
This isn't a bug introduced by this patch, but does this code properly
bound-check inline_oob_size_div4?

In mana_hwc_rx_event_handler():

	wqe =3D mana_gd_get_wqe_ptr(rq, rx_oob->wqe_offset / GDMA_WQE_BU_SIZE);
	dma_oob =3D (struct gdma_wqe *)wqe;

	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);

If the host returns a maliciously large inline_oob_size_div4 in the DMA buf=
fer,
could this cause an out-of-bounds memory read when dereferencing sge->addre=
ss
on the line modified above?

[Severity: High]
This is also a pre-existing issue, but does this error path permanently
leak the RX WQE?

By returning early on an invalid rx_req_idx (or msg_id further down), this
skips reposting the RX WQE back to the hardware via mana_hwc_post_rx_wqe().

Could a malicious host repeatedly send invalid responses to completely drain
the receive queue and halt control message processing?

> @@ -737,14 +737,14 @@ static int mana_hwc_init_queues(struct hw_channel_c=
ontext *hwc, u16 q_depth,
>  		goto out;
>  	}
> =20
> -	err =3D mana_hwc_create_wq(hwc, GDMA_RQ, q_depth, max_req_msg_size,
> +	err =3D mana_hwc_create_wq(hwc, GDMA_RQ, q_depth, max_resp_msg_size,
>  				 hwc->cq, &hwc->rxq);
>  	if (err) {
>  		dev_err(hwc->dev, "Failed to create HWC RQ: %d\n", err);
>  		goto out;
>  	}
> =20
> -	err =3D mana_hwc_create_wq(hwc, GDMA_SQ, q_depth, max_resp_msg_size,
> +	err =3D mana_hwc_create_wq(hwc, GDMA_SQ, q_depth, max_req_msg_size,
>  				 hwc->cq, &hwc->txq);
>  	if (err) {
>  		dev_err(hwc->dev, "Failed to create HWC SQ: %d\n", err);
> @@ -753,6 +753,7 @@ static int mana_hwc_init_queues(struct hw_channel_con=
text *hwc, u16 q_depth,
> =20
>  	hwc->num_inflight_msg =3D q_depth;
>  	hwc->max_req_msg_size =3D max_req_msg_size;
> +	hwc->max_resp_msg_size =3D max_resp_msg_size;
> =20
>  	return 0;
>  out:

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but does the timeout handling in
mana_hwc_send_request() allow a delayed hardware response to corrupt memory?

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request() {
	if (!wait_for_completion_timeout(&ctx->comp_event, ...)) {
		...
		err =3D -ETIMEDOUT;
		goto out;
	}
...
out:
	mana_hwc_put_msg_index(hwc, msg_id);
	return err;
}

The timeout path jumps to out: and releases the msg_id back to the bitmap
without waiting for or canceling the hardware operation.

If a new request reuses this msg_id, and the hardware subsequently delivers
a delayed response for the original request, could mana_hwc_handle_resp()
blindly memcpy() the delayed response into the new request's output_buf?

[Severity: High]
This is a pre-existing issue, but is ctx->comp_event properly reinitialized
when a msg_id is reused?

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request() {
	ctx =3D hwc->caller_ctx + msg_id;
	ctx->output_buf =3D resp;
	ctx->output_buflen =3D resp_len;
	...
	if (!wait_for_completion_timeout(&ctx->comp_event, ...)) {
...
}

Because reinit_completion() is never called before wait_for_completion_time=
out(),
a previous delayed response could cause mana_hwc_handle_resp() to call comp=
lete().

If that happens, could wait_for_completion_timeout() return immediately for
a new request?

This would cause the caller to process uninitialized data from ctx->output_=
buf.

[Severity: High]
This is a pre-existing issue, but can the global serv_work cause a
use-after-free during device removal?

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_schedule_serv_work() {
	INIT_WORK(&mns_wk->serv_work, mana_serv_func);
	schedule_work(&mns_wk->serv_work);
}

The work item is scheduled on the global system workqueue. During device
removal, mana_gd_remove() frees the gdma context (gc):

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_remove() {
	...
	vfree(gc);
}

Since the driver does not wait for or cancel this asynchronous work item,
could mana_serv_func() execute after mana_gd_remove() and dereference the
freed gc pointer in mana_serv_reset()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174243.3044=
348-1-longli@microsoft.com?part=3D2
