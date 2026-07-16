Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691B26ED59
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172623; cv=none; b=tU44kyrVxEX3nj+0srXXdaqdjGdUGJLhBycL2puuwtEGFixKKhp85FQwQG8tkBwSVs9oEYSuMU2OcaXz3bJ3PHMYBH7eR/iS6BiJAewUPmbytkhcHnAdbpnHRC3m03l5zG9kXgaXNRI0mZG+Sa6aMmBE2Mt7on0XEfEMTGoO34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172623; c=relaxed/simple;
	bh=Z5I/rrkPvsaYd6u6DnQ/Ec5mOeBOoxQ66ylr2ZA7c6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nr8qLYQ5/0Y9fgbphJeBtRdgLZCDf6f1NwXiq8vQAh5KlV5X7JLunc19DZ/AbavwAHmiOzOxftjpw6qqMGU/6CQ0TtdTZZVtejFoHgZn2VuMVpcBHAi7gbH4xI5GaT8EkDpGKgaOXoGbMmbS21YRr2219giKoSv4pQvbEN/hN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfGWlXBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfGWlXBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C681F00A3D;
	Thu, 16 Jul 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784172622;
	bh=YjNOB+dvs+kCQoxmKLLTe2NVfqUtIlvTfzC8k40JgJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EfGWlXBOcFTbjFKpp6/nwAr97pPxcAzav2EgAtPEPJcD6qpFY5QNtvgBUcB+pRlMW
	 TtNkLSfJx1ecf+pDGmR3pzx+Fj1ogjJCjcoKh0ORKLIu5pe/JIYWVvJYdzL/kQCG2O
	 rnYDv5X4Fyu3Yvw5Lh5NhXSr29Bgw0YEkEBhAm5TILqS4AZT52BbWKxkivi+N6g3K4
	 +8QEcnQdqNrLUzuw7BdJjuAzMSZ2ImdMujEE8YYexLQ2TLbIWSImekwLF7ixrjygAX
	 dsC0Nipcnv7I8+meL1uaKuO9DRaruH65ZwH+njU8VSu36lfy08JeR+zwRhURgD+Z5q
	 3uz5on5W8xHnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/7] net: mana: fix HWC RQ/SQ buffer size swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260715032942.3945317-3-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
 <20260715032942.3945317-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:30:21 +0000
Message-Id: <20260716033022.32C681F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free and data corruption due to premature timeout return=
 in mana_hwc_send_request without canceling hardware transaction.
- [High] Missing locking allows concurrent WQE ring corruption in mana_hwc_=
send_request.
--

--- Patch [2]: [PATCH net-next 2/7] net: mana: fix HWC RQ/SQ buffer size sw=
ap ---
commit a1baa394548fbd57903fe3f07805307884c7c9c0
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC RQ/SQ buffer size swap

The HWC RQ receives responses and the SQ sends requests, but
mana_hwc_init_queues() sized the RQ with max_req_msg_size and the SQ with
max_resp_msg_size -- backwards. A response larger than the undersized RQ
buffer could overflow it, and mana_hwc_rx_event_handler() recovered the
RX slot index by dividing by the wrong size.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 409e20caeccdc..3f011ebbe7b3e 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -749,6 +749,7 @@ static int mana_hwc_init_queues(struct hw_channel_con=
text *hwc, u16 q_depth,
> =20
>  	hwc->num_inflight_msg =3D q_depth;
>  	hwc->max_req_msg_size =3D max_req_msg_size;
> +	hwc->max_resp_msg_size =3D max_resp_msg_size;
> =20
>  	return 0;
>  out:

[Severity: High]
This isn't a bug introduced by this patch, but could this timeout path lead
to a use-after-free and data corruption?

If a caller invokes mana_hwc_send_request() and it times out, it frees the
msg_id slot and returns without canceling the hardware transaction:

mana_hwc_send_request() {
    if (!wait_for_completion_timeout(&ctx->comp_event, ...)) {
        err =3D -ETIMEDOUT;
        goto out;
    }
    ...
out:
    mana_hwc_put_msg_index(hwc, msg_id);
}

If the caller provided a stack-allocated response buffer, its stack frame
will be popped when mana_hwc_send_request() returns. When the delayed
hardware response eventually arrives, will mana_hwc_handle_resp() blindly
accept it and overwrite the now-freed stack address?

mana_hwc_handle_resp() {
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
}

Alternatively, if another thread reuses the freed msg_id, could it receive
this delayed response instead of its own?

[Severity: High]
This is also a pre-existing issue, but does this code allow concurrent
WQE ring corruption?

Multiple threads can concurrently invoke mana_hwc_send_request(), such as
from parallel InfiniBand requests. This leads to mana_hwc_post_tx_wqe(),
which appears to call mana_gd_post_and_ring() locklessly:

mana_hwc_post_tx_wqe() {
    ...
    err =3D mana_gd_post_and_ring(hwc_txq->gdma_wq, &req->wqe_req, NULL);
}

If multiple threads execute this concurrently, won't they read the same
wq->head in mana_gd_post_work_request(), overwrite the exact same WQE
slots, and corrupt the shared queue state?

mana_gd_post_work_request() {
    wqe_ptr =3D mana_gd_get_wqe_ptr(wq, wq->head);
    ...
    mana_gd_write_sgl(wq, wqe_ptr, wqe_req);
    wq->head +=3D wqe_size / GDMA_WQE_BU_SIZE;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715032942.3945=
317-1-longli@microsoft.com?part=3D2
