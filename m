Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC8262FF8
	for <linux-hyperv@vger.kernel.org>; Thu, 16 Jul 2026 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172621; cv=none; b=QnOdSUUcBdzTDjWXykWsaJhSI0pArgdFNBqKDvFEmRU1ar0b3EFQhVRKN/Vy8Y+weoiDdXcjExT+JXjy/ZzGpVxhpEnA6TnvtpF4ig72+EmmzyId5651bA2Z5pzQb2ISNisy6UfVZuKMdLbpxZP3sOgntlvUZtHKJoofZpKY2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172621; c=relaxed/simple;
	bh=9fBEi2CcihVl6DMMplme3/nOcVnQheeYaNX69qCi/dw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l425lVTx215V0JxMtguSlB8vcqfxzwU5cX9RbfFxIXfPR9ebbY9DTd2lDD96FUKkNaqon3ITxAYK8QHXbzKe9H0TMF1dtuzjU3Z9PJWDRO8cOOna5PkgTDM1oHbzgRn0zbix41FcEErZa6CHLch0yyllbkHmkAXxiKX2cGuXjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoHImoq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoHImoq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8CD1F00A3A;
	Thu, 16 Jul 2026 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784172619;
	bh=KFupHQyIuf8a/W1wE9jI2SgofKJZrmDuLrHRvydNInE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoHImoq52jxzjsZs6JddR0ZWQsV4WRXCcY82W/di/IFxwZNCQwcv4tw9bKHAD9Pee
	 iWEJXp8RMSZrVSLVGCILqTtWiLeqWADHEH8XRc7/kHIRSiyYFpeswlZ51BecDc6Cgi
	 Nky4OwyWnEeodgKzR9ngQ6GTuaofR48IqaZQ+CYv4UyRjL2748xntZzhqqUIeJY0Lx
	 r2I2FldEMyI8nCgaNOFrr8q3w3RjtT+m/mIUQei1l6OGJthl6CGlfQH98JQZmdYQFC
	 BEUl8IPi8lQIuBGzFp6QpsnsK/gDWfB3a9nEiuZz3edUcgODfbomgWQMPeWKSBrDty
	 WlhXpc5tOoAbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/7] net: mana: free HWC comp_buf after
 destroying the EQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260715032942.3945317-4-longli@microsoft.com>
References: <20260715032942.3945317-1-longli@microsoft.com>
 <20260715032942.3945317-4-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:30:19 +0000
Message-Id: <20260716033019.9C8CD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of TX and RX work queues during HWC channel destruc=
tion due to incorrect teardown ordering.
- [High] Data corruption and premature completion due to msg_id reuse after=
 timeout in mana_hwc_send_request().
- [High] Use-after-free of gdma_context (gc) due to un-canceled service wor=
k during device removal.
--

--- Patch [3]: [PATCH net-next 3/7] net: mana: free HWC comp_buf after dest=
roying the EQ ---
commit 0772412f368270fa1d8812b8355a2560f063690d
Author: Long Li <longli@microsoft.com>
Subject: net: mana: free HWC comp_buf after destroying the EQ

This patch resolves a use-after-free issue by deferring the release of
the hardware channel completion buffer until after the event queue has been
destroyed. This ensures no late interrupts can access the freed memory.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
>  static void mana_hwc_destroy_cq(struct gdma_context *gc, struct hwc_cq *=
hwc_cq)
>  {
[ ... ]
>  	if (hwc_cq->gdma_eq)
>  		mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
> =20
> +	kfree(hwc_cq->comp_buf);
>  	kfree(hwc_cq);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while looking at teardown
ordering, could there be a similar use-after-free with the TX and RX work
queues?

In mana_hwc_destroy_channel(), the work queues are freed before the
completion queue:

mana_hwc_destroy_channel() {
    if (hwc->txq)
        mana_hwc_destroy_wq(hwc, hwc->txq);

    if (hwc->rxq)
        mana_hwc_destroy_wq(hwc, hwc->rxq);

    if (hwc->cq)
        mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
}

If an interrupt fires before the CQ and EQ are destroyed, will the
completion handler still attempt to dereference the already freed work
queues?

mana_hwc_rx_event_handler() {
    struct hw_channel_context *hwc =3D ctx;
    struct hwc_wq *hwc_rxq =3D hwc->rxq;
    ...
    rq =3D hwc_rxq->gdma_wq;
    ...
}


[Severity: High]
This is a pre-existing issue, but does mana_hwc_send_request() have a
race condition if a request times out?

If a timeout occurs, mana_hwc_send_request() releases the msg_id while the
hardware might still be processing it:

mana_hwc_send_request() {
    ...
    err =3D -ETIMEDOUT;
    goto out;
    ...
out:
    mana_hwc_put_msg_index(hwc, msg_id);
}

Could another caller subsequently allocate the same msg_id and assign its
own stack buffer? If the hardware then completes the original delayed
request, would the handler overwrite the new caller's buffer with the old
response?

mana_hwc_handle_resp() {
    ctx =3D hwc->caller_ctx + msg_id;
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
    ...
    complete(&ctx->comp_event);
}


[Severity: High]
This is also a pre-existing issue, but could there be a use-after-free
during device removal if service work is pending?

In mana_gd_remove(), the gdma_context is freed without canceling pending
work on the system workqueue:

mana_gd_remove() {
    ...
    mana_gd_cleanup_device(pdev);
    xa_destroy(&gc->irq_contexts);
    pci_iounmap(pdev, gc->bar0_va);
    vfree(gc);
}

If the delayed work handler executes concurrently with or after device
removal, will it dereference the freed pointer?

mana_serv_reset() {
    struct gdma_context *gc =3D pci_get_drvdata(pdev);
    struct hw_channel_context *hwc;
    ...
    hwc =3D gc->hwc.driver_data;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715032942.3945=
317-1-longli@microsoft.com?part=3D3
