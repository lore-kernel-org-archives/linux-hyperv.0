Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784C40DB52
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763980; cv=none; b=ulCo4af96qQUZgs91y1/E4FT2+Kn8G+uZKcdwzU3kJ/hsZWqTsffExZdKVOBGkkX3xOlRiR/FjAPkiMTgiFDGz4Go1/gh4ZDHjbPplIgeSBtRHQ0kyGVB0KnlPIh4tIq3OKzb8m2yk3dSGKNRt53ZcEgp7KmHtb0C6LQpM8JJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763980; c=relaxed/simple;
	bh=Nxa+4OzIODsoTa6yc9RLOTT2GiOm6Amh0+XbwqErOls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6p4aipxFSp/czmIRtS3RnBA3UdNuelIdmNm57mRRstHDqYJhcmUwYUZPcCeNuHy11ffSAHphod+lsQsF15Zx30YNL2lNY3rhIOaTxBPa/hOMyVzhhnAwGNBYCV7o0DQc6D5O9stB5h4EJzSsLQwjpiNytEwYqzY4hTOCdWL1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrJXMFG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrJXMFG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9861F00A3A;
	Wed, 22 Jul 2026 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763979;
	bh=aHdwsPXHBGNI7s0emDKIQIkiYFYwF/6z/7OcTrn39+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrJXMFG6jsSpWsNegAZM1wSVquqfUqn0nA979GlTpEGoN2jty6cv+1yUC9twBO80A
	 7aTCam5wRrvhuOED9adsY1d1qV8vZGA95eQ/KKQ9J364d1ZMoui1XVzLkn4kV6MLK7
	 3U1N14SyaDgkUsHgXVoLsK6J49Si9ChQEMwIyBfaeFKluQxSOWHYmuYM540kprWQvn
	 s46G8bg6k7XmeJMXkx/Tr80rYXSiS4JGUUt/aHnnE/+loVwIZp/APMMV8hQyApMJJj
	 nG5N7zw1rBII5jW3/09PyxbCBLqudOIMZK07Xw5S0I7q6fzLcLqJLy1nXALzLKyomp
	 J285NJClFJrMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/7] net: mana: fix HWC RQ/SQ buffer size
 swap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721234339.1476932-3-longli@microsoft.com>
References: <20260721234339.1476932-1-longli@microsoft.com>
 <20260721234339.1476932-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:46:18 +0000
Message-Id: <20260722234619.1A9861F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hardware teardown on HWC establishment timeout leaves hard=
ware with dangling DMA pointers, leading to Use-After-Free and Memory Corru=
ption.
- [High] A malicious host/hypervisor can trigger an out-of-bounds read of k=
ernel memory via a TOCTOU vulnerability in `mana_hwc_rx_event_handler`, lea=
ding to an information leak in Confidential VMs.
--

--- Patch [2]: [PATCH net-next v2 2/7] net: mana: fix HWC RQ/SQ buffer size=
 swap ---
commit 1cb6d6f825cbbe1634272e9bfe16cb7adaa2c6b1
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC RQ/SQ buffer size swap

The commit fixes a bug where mana_hwc_init_queues() sized the RQ and SQ
using the incorrect maximum message size variables. It swaps them to correct
the buffer sizes, stores max_resp_msg_size in the hardware channel context,
and uses it properly as the RX slot stride.

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
> =20
>  	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
>  		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",

[Severity: High]
This is a pre-existing issue, but could this function be vulnerable to an
out-of-bounds read if the hypervisor provides a malicious
inline_oob_size_div4?

In mana_hwc_rx_event_handler(), the dma_oob pointer and its
inline_oob_size_div4 field are read from shared, unencrypted DMA memory:

    wqe =3D mana_gd_get_wqe_ptr(rq, rx_oob->wqe_offset / GDMA_WQE_BU_SIZE);
    dma_oob =3D (struct gdma_wqe *)wqe;
    sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4=
);

If a malicious hypervisor sends a CQE pointing to the last WQE slot in
the ring buffer and sets the 3-bit inline_oob_size_div4 field to 7, the
calculated sge pointer would point 4 bytes past the end of the 32-byte
WQE buffer allocation.

The driver then reads sge->address (an 8-byte out-of-bounds read) to
compute rx_req_idx. Since this value is derived from out-of-bounds
memory, it will likely exceed num_reqs and be logged to the kernel ring
buffer.

Could an untrusted hypervisor use this paravirtualized serial console log
to reverse the math and recover leaked encrypted guest memory plaintext
in a Confidential VM setup?

[ ... ]

> @@ -733,14 +733,14 @@ static int mana_hwc_init_queues(struct hw_channel_c=
ontext *hwc, u16 q_depth,
>  		goto out;
>  	}
> =20
> -	err =3D mana_hwc_create_wq(hwc, GDMA_RQ, q_depth, max_req_msg_size,
> +	err =3D mana_hwc_create_wq(hwc, GDMA_RQ, q_depth, max_resp_msg_size,
>  				 hwc->cq, &hwc->rxq);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing hardware
teardown when channel establishment times out?

In mana_hwc_establish_channel(), mana_smc_setup_hwc() hands the DMA
addresses of the queues to the hardware. If the driver then times out
waiting for the hwc_init_eqe_comp completion, it returns -ETIMEDOUT.

On the error path, this leads to mana_hwc_destroy_channel(), where the
teardown is gated by the number of completion queues:

    if (gc->max_num_cqs > 0)
        mana_smc_teardown_hwc(&gc->shm_channel, false);

Because the initialization event was never processed due to the timeout,
gc->max_num_cqs is still 0, causing the teardown to be skipped. The
driver then immediately frees the DMA queue memory.

If the hardware later wakes up and processes the setup request, could it
write to the freed DMA memory, resulting in memory corruption?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721234339.1476=
932-1-longli@microsoft.com?part=3D2
