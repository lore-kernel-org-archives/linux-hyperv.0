Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F923EAA6
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763978; cv=none; b=eiuPqb5PRk4/oUwbv+dTku0l8WjAnls1T8rzHp+sje6Zo4SB6vCltHsv3YRNagZacPq9miuF6AZVzOrzheiNjqyeX1PinCDrgAE9Ek4oZIem43yBJIk8YZGVgeVu8qVSA0HDm4HzqJ24J8ZHitL7fwu2iKzHIBsdLO9/gDdbJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763978; c=relaxed/simple;
	bh=C9IaCnt5xnO1UsipBHxTj2TtEe3RDFYJqfPjlzWYdcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuNxcILAmpzjcs3i7kOeZ9/sv9UwyBcd7H0Y5e3bIXNbTeyreXaX8knae3/b49CQA50qD+8gR4yj6jlsNM4R+RsKf86pBFZfcUq6HtMS4lhI9TiglmdFaU8q9HHxcUPpRI/BAoq2wjwTP0fmgRbz14sbFNGa1ylK6o+2GP8Vo8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZPF88cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZPF88cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E24B1F000E9;
	Wed, 22 Jul 2026 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763976;
	bh=SntpZD+BE8RuULjXM8xPT5zWSo0PzP+XW77myoGJgXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZPF88cQKwFfaxLGAdJ6zL6Z19hDVwXJGBsAt5XWLrhQqLW9n7JuruoL1wGsfW0sT
	 Huvk3qV4XHL7sESO9UDb4wF8Jp87LWHqYtM1ZFVaxcQkT99DwLRg176Dc3y4yUeCop
	 uj6yXvBNWwCz7QAqnPENy9mVAhrD5s4s92t/iMRMX5pbCKhr7VvBtwG3j2Q8Vlughq
	 /6eZnE+hJUc5iSBvaerxDR8mtMu8sAeetoecY08AJt/C4Kk+/1Fl+6akiSljiYg5JW
	 3lontEHo769+Tns6qmAoyFLV+TCNc+GKcelMxwtYY/FQnv/MG6kf2fZihk1P3iF31f
	 kOub1DfW4hx2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/7] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721234339.1476932-4-longli@microsoft.com>
References: <20260721234339.1476932-1-longli@microsoft.com>
 <20260721234339.1476932-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:46:15 +0000
Message-Id: <20260722234616.4E24B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of WQs during HWC channel destruction because WQs a=
re destroyed before the EQ and CQ.
- [High] Immediate reuse of `msg_id` after a timeout leads to cross-request=
 stack corruption.
- [High] Pending `mana_serv_work` items on the global workqueue are not can=
celed during device removal, causing a Use-After-Free.
- [High] Missing bounds check on untrusted `inline_oob_size_div4` allows ou=
t-of-bounds memory read.
- [High] Missing length check on `tx_oob_data_size` allows spoofed completi=
ons via stale DMA buffer data.
- [Medium] Destroying the CQ before the EQ triggers a `WARN_ON_ONCE(!cq)` s=
plat if an EQ interrupt fires during the race window.
--

--- Patch [3]: [PATCH net-next v2 3/7] net: mana: free HWC comp_buf after d=
estroying the EQ ---
commit 6326f43efebe30510f1377a79fcf8a92f5abb2b7
Author: Long Li <longli@microsoft.com>

net: mana: free HWC comp_buf after destroying the EQ

This commit changes mana_hwc_destroy_cq() to free hwc_cq->comp_buf after
destroying the CQ and EQ. This prevents a use-after-free where a late EQ
interrupt handler could touch comp_buf while the EQ was still registered.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 3f011ebbe7b3e..2239fdeda57cb 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -384,14 +384,20 @@ static void mana_hwc_comp_event(void *ctx, struct g=
dma_queue *q_self)
> =20
>  static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *=
hwc_cq)
>  {
> -	kfree(hwc_cq->comp_buf);
> -
>  	if (hwc_cq->gdma_cq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);

[Severity: Medium]
This isn't a bug introduced by this patch, but destroying the CQ before the
EQ appears to leave a race window for EQ interrupts. If a hardware interrupt
fires for the EQ, could mana_gd_process_eqe() read a completion event, look
up the CQ ID in the table, find NULL, and trigger the WARN_ON_ONCE(!cq) spl=
at?

> =20
> +	/* comp_buf is reached only by mana_hwc_comp_event(), which the
[ ... ]
>  	if (hwc_cq->gdma_eq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> =20
> +	kfree(hwc_cq->comp_buf);
>  	kfree(hwc_cq);
>  }

I also noticed some pre-existing issues in related code:

> drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_destroy_channel=
()
>=20
> 	if (hwc->txq)
> 		mana_hwc_destroy_wq(hwc, hwc->txq);
>=20
> 	if (hwc->rxq)
> 		mana_hwc_destroy_wq(hwc, hwc->rxq);
>=20
> 	if (hwc->cq)
> 		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

[Severity: High]
This is a pre-existing issue, but WQs are destroyed and freed here before
the CQ/EQ. Since the EQ and CQ are not yet destroyed and their interrupts
are still active, could an in-flight EQ interrupt process a late completion,
call mana_hwc_rx_event_handler(), and dereference hwc->rxq which points to
freed memory?

> drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_send_request()
>=20
> 	if (!wait_for_completion_timeout(&ctx->comp_event,
> 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
[ ... ]
> 		err =3D -ETIMEDOUT;
> 		goto out;
> 	}
> out:
> 	mana_hwc_put_msg_index(hwc, msg_id);

[Severity: High]
This is a pre-existing issue, but does the timeout path prematurely release
the msg_id without cancelling the request in hardware? If a second thread
allocates the same msg_id and the hardware sends a late response for the
first request, could mana_hwc_handle_resp() copy the response data into
the second thread's stack buffer?

> drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_rx_event_handle=
r()
>=20
> 	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);
>=20
> 	/* Select the RX work request for virtual address and for reposting. */
> 	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
> 	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_resp_msg_size;

[Severity: High]
This is a pre-existing issue, but is there a missing bounds check on the
untrusted inline_oob_size_div4 before it is used to calculate the sge point=
er?
If a malicious hypervisor supplies an arbitrarily large value, could this
lead to an out-of-bounds memory read when sge->address is dereferenced?

> drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_rx_event_handle=
r()
>=20
> 	resp =3D (struct gdma_resp_hdr *)rx_req->buf_va;
>=20
> 	/* Read msg_id once from DMA buffer to prevent TOCTOU:
> 	 * DMA memory is shared/unencrypted in CVMs - host can
> 	 * modify it between reads.
> 	 */
> 	msg_id =3D READ_ONCE(resp->response.hwc_msg_id);
> 	if (msg_id >=3D hwc->num_inflight_msg) {
[ ... ]
> 	mana_hwc_handle_resp(hwc, rx_oob->tx_oob_data_size, rx_req, msg_id);

[Severity: High]
This is a pre-existing issue, but does this code read msg_id from the DMA
buffer before verifying that the response size (rx_oob->tx_oob_data_size)
is large enough to contain it? If the hardware sends a small completion,
could the buffer retain stale data containing an old msg_id, causing
mana_hwc_handle_resp() to route the response to an active, unrelated reques=
t?

> drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_schedule_serv_work()
>=20
> 	INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> 	schedule_work(&mns_wk->serv_work);

[Severity: High]
This is a pre-existing issue, but the work item is queued on the global
workqueue here. During device unbind, mana_gd_remove() frees the gc
structure via vfree(gc) but does not track or cancel pending work items.
When the delayed work item executes, could mana_serv_func() retrieve the
stale gc pointer via pci_get_drvdata(pdev) and dereference it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721234339.1476=
932-1-longli@microsoft.com?part=3D3
