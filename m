Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD9338936
	for <linux-hyperv@vger.kernel.org>; Sun, 12 Jul 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868797; cv=none; b=IAAMgJ/Tq1m3WpH7GYBbxaN+C/mDSpks4vTAehH8DdcrwLrjhbK1rtSa0+1BCEfVpDqp/XcXarQOqQ4AYgKbEKmiNq3GRUgzxk7tdwyXzZ8qClK3FK8D7ryvDgwaGh/9+Xr73jtGDim98sCHKGKpYc1+rADaBjZhnAJBHMsWrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868797; c=relaxed/simple;
	bh=RpNITpNuRe/eaoKPkOK1EinmVMVX/OBRx2bZnstPQxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tvnl3g28PMpRAoHC/xFFyKRmhinlAYSaigC36mCPhVF4EBFDE6/B2vmF705ofDlQDRpgKC8QkGfDzVJu3pqhxLL5NoHK8jyM8K8pT0WGGkgWdI4OligBGQFqWq8DbZlBEVRW93d9kZLLrxlkNjuvb5rrFkxKEYClSAkJs9zF738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXamQVHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXamQVHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB96B1F00A3A;
	Sun, 12 Jul 2026 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783868796;
	bh=WuYW9XXImFwmg6b/HnuA+qnz8tTGtOitXrA/YzRiVqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXamQVHPV9kDB77ueg5HlrG56K3LxEOFaDpfyF9DZReEMqLkV4EmEDDLuhrdnDHbF
	 4cXsPprxTADuihgKpgRx457p+8UP7MtJ77aOh54ZfMzmWndDhcPowoi9vPfs91GsUU
	 w9FcuxVUn5wDVlP/wPW9Mw3IsIE/1YIYhMVaEJOb37nX8G5IYeop30DNeF28fCIqfZ
	 kbWx5VAtJD+C0YeffCPn3SlqqAppUaKoPRtOUGawL/AtU3g/RZwguYYXYXOPBJt1mW
	 aPiLuyPEU6q53te8BEAsCx0cZQL81wUSN3klppZWP3vhOwt4r7NreW5Ed2MUNGqEBq
	 g+o4JdfdQVIbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: mana: cap HWC init max message size to
 HW_CHANNEL_MAX_REQUEST_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260711150628.2914205-1-michael.bommarito@gmail.com>
References: <20260711150628.2914205-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 15:06:35 +0000
Message-Id: <20260712150635.CB96B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message describes an integer overflow vulnerability i=
n `mana_hwc_alloc_dma_buf()` caused by using unbounded device-advertised me=
ssage sizes, but this vulnerability is entirely hallucinated and the modifi=
ed variables are dead code.
- [Low] The patch incorrectly clamps `HWC_INIT_DATA_MAX_RESPONSE` using `HW=
_CHANNEL_MAX_REQUEST_SIZE` instead of `HW_CHANNEL_MAX_RESPONSE_SIZE`.

Pre-existing issues:
- [High] An unchecked `eq_db.doorbell` index from a hardware event causes a=
n out-of-bounds MMIO write during doorbell ringing.
- [High] An unchecked `max_num_cqs` value retrieved from the hardware event=
 allows a malicious device to trigger enormous kernel memory allocations.
--

--- Patch [1]: [PATCH] net: mana: cap HWC init max message size to HW_CHANN=
EL_MAX_REQUEST_SIZE ---
commit ea80048daa839e9f12f06618139e15fddebc0ac5
Author: Michael Bommarito <michael.bommarito@gmail.com>

net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE

The commit adds bounds checking for max message size during HWC initializat=
ion.
It claims this prevents an out-of-bounds DMA buffer write in
mana_hwc_alloc_dma_buf().

>    mana_hwc_init_event_handler() in hw_channel.c stores device-advertised
>    HWC_INIT_DATA_MAX_REQUEST and HWC_INIT_DATA_MAX_RESPONSE values
>    without bounds checking. mana_hwc_alloc_dma_buf() later computes the
>    DMA buffer size as MANA_PAGE_ALIGN(q_depth * max_msg_size) in 32-bit
>    arithmetic. A malicious device returning a large max_msg_size causes
>    the product to wrap, allocating a small buffer while laying out
>    q_depth request slots at the unwrapped stride, placing slots outside
>    the allocation.

[Severity: Medium]
Is this description accurate?

The modified variables (hwc->hwc_init_max_req_msg_size and
hwc->hwc_init_max_resp_msg_size) appear to be dead code that do not affect
memory allocation. mana_hwc_alloc_dma_buf() is invoked before the event
handler runs (via mana_hwc_init_queues()) using hardcoded sizes (4096),
not the hardware-provided ones.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index e3c24d50dad07..94594fba112f9 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -150,10 +150,14 @@ static void mana_hwc_init_event_handler(void *ctx, =
struct gdma_queue *q_self,
>  			break;
> =20
>  		case HWC_INIT_DATA_MAX_REQUEST:
> +			if (val =3D=3D 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val =3D HW_CHANNEL_MAX_REQUEST_SIZE;
>  			hwc->hwc_init_max_req_msg_size =3D val;
>  			break;
> =20
>  		case HWC_INIT_DATA_MAX_RESPONSE:
> +			if (val =3D=3D 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val =3D HW_CHANNEL_MAX_REQUEST_SIZE;

[Severity: Low]
Does this incorrectly clamp HWC_INIT_DATA_MAX_RESPONSE using
HW_CHANNEL_MAX_REQUEST_SIZE instead of HW_CHANNEL_MAX_RESPONSE_SIZE?

>  			hwc->hwc_init_max_resp_msg_size =3D val;
>  			break;
> =20

[Severity: High]
This is a pre-existing issue, but is it possible for a malicious device
to trigger an out-of-bounds MMIO write via an unchecked doorbell index?

Earlier in mana_hwc_init_event_handler():

	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
		eq_db.as_uint32 =3D event->details[0];
		hwc->cq->gdma_eq->id =3D eq_db.eq_id;
		gd->doorbell =3D eq_db.doorbell;

When the driver posts WQEs and rings the doorbell via mana_gd_ring_doorbell=
():

drivers/net/ethernet/microsoft/mana/gdma_main.c:mana_gd_ring_doorbell() {
    ...
    void __iomem *addr =3D gc->db_page_base + gc->db_page_size * db_index;
    ...
    writeq(e.as_uint64, addr);
    ...
}

If eq_db.doorbell is excessively large, could it calculate a memory-mapped
address that exceeds gc->bar0_size, resulting in an out-of-bounds writeq()
that corrupts adjacent mappings?


[Severity: High]
This is a pre-existing issue, but does the unchecked max_num_cqs value
allow a malicious device to exhaust system memory?

Later in mana_hwc_init_event_handler():

		case HWC_INIT_DATA_MAX_NUM_CQS:
			gd->gdma_context->max_num_cqs =3D val;
			break;

This unbounded max_num_cqs value is later used for memory allocation:

drivers/net/ethernet/microsoft/mana/hw_channel.c:mana_hwc_establish_channel=
() {
    ...
	gc->cq_table =3D vcalloc(gc->max_num_cqs, sizeof(struct gdma_queue *));
    ...
}

If max_num_cqs is an exceptionally large 32-bit value (e.g., 0x1FFFFFFF),
could vcalloc() attempt to allocate multiple gigabytes of memory and cause a
host-level denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711150628.2914=
205-1-michael.bommarito@gmail.com?part=3D1
