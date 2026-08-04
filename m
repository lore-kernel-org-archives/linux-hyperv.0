Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C63D349A
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887082; cv=none; b=FDgdMTsUPvBaHO/nfcQvLo7UXUrrGuRGxI9nte1YKaUdfng2/Luq5iSMHEs4sN4UDjJ45Pt8c5d9tVWds1H/5HViLMO3VTrF/+gKG3h4DlYEhUva/543Fu3Xs0McspIZVLubHXov7+sPINckRnoz+a93Na8djhUGEnLteyVEqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887082; c=relaxed/simple;
	bh=UeeC+baFepmUkc3Eab15Xaw9gK+5awfMQ+tcSGrc9OA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hru8gDPUa9IJziXxojbUiJlZXSi7DcuFeUlnFS53TPtswR7HKmkCqQM8zucNww8WPZV6UHqQtt7QJQmWa/zOGAOwd/pi+XHP/tstqKxZkCUvh7mlpdAgPfNbTVQbE7QU83HI65OAH3cjNAvMvixpHEwF3vKhe29Ya3jwHSVvX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3VYA9IJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3VYA9IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA21F00A3A;
	Tue,  4 Aug 2026 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887080;
	bh=cvFBL/dqrlPHBuNH216GiHx8RGMaQUX0AiX6hrtAubA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3VYA9IJqLpt83fy6xqWflcw1M0aqr0xjdCaGcLiWzzmIp+fTq9Youfj0K15+2rHW
	 JZAnjcXBYT028ESkFtESOCpUuuH8GUKNKbZioHNwWyd5hjE2+8XA4PlCMVBZNUcNTC
	 0Mh2Bzc53Eo9cxrTKa5BAKZBbAOnc7LmVd/JiAc2FJeEfnRhHyQM3zTz8DNRvEm4ey
	 /tCqC2ssb22WjwAHgJyFHW9aHOEitPy2JwSNyB3wB/FP+YmywiShpfjcSTPJDN15w9
	 xR/45Jz3l2IyYaqYBRxGZlzs/BOhaKjJO265tIyBUr9FDJFmfyT1yKQX2hhCEUGL08
	 Ghjx7fAAMtPgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 5/6] net: mana: fix HWC teardown safety with
 setup_active flag and destroy ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260803234355.636038-6-longli@microsoft.com>
References: <20260803234355.636038-1-longli@microsoft.com>
 <20260803234355.636038-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:44:39 +0000
Message-Id: <20260804234440.6CBA21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] An early return on HWC teardown failure leaves a stale pointer in =
`gc->cq_table`, which a malicious host can exploit to cause an out-of-bound=
s read.
- [Medium] Redundant HWC teardown in `mana_hwc_establish_channel()` causes =
a double hardware timeout (up to 120s stall) and masks the original initial=
ization error code.

Pre-existing issues:
- [High] During HWC teardown, the CQ is destroyed and its memory freed befo=
re the EQ is deregistered, leading to Use-After-Free and WARN splats if an =
interrupt occurs.
--

--- Patch [5]: [PATCH net v3 5/6] net: mana: fix HWC teardown safety with s=
etup_active flag and destroy ordering ---
commit cb8bd3f89f96cf2e7fd5d41275858b076d281d38
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC teardown safety with setup_active flag and destroy order=
ing

Three teardown hazards let the hardware touch memory the driver freed.

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -768,20 +769,33 @@ static int mana_hwc_establish_channel(struct gdma_c=
ontext *gc, u16 *q_depth,
[ ... ]
> +teardown:
> +	{
> +		int td_err =3D mana_smc_teardown_hwc(&gc->shm_channel, false);
> +
> +		if (!td_err)
> +			hwc->setup_active =3D false;
> +
> +		return td_err ? td_err : err;
> +	}
>  }

[Severity: Medium]
Does this teardown logic mask the original error code and cause a redundant
teardown attempt?

If mana_smc_teardown_hwc() fails, it returns td_err and leaves
hwc->setup_active =3D true. The caller mana_hwc_create_channel() handles the
returned error like this:

mana_hwc_create_channel() {
    ...
    err =3D mana_hwc_establish_channel(...);
    if (err) {
        dev_err(hwc->dev, "Failed to establish HWC: %d\n", err);
        goto out;
    }
    ...
out:
    mana_hwc_destroy_channel(gc);
    return err;
}

Since hwc->setup_active is still true, mana_hwc_destroy_channel() will
attempt to tear down the hardware a second time. This can cause the driver
to stall for twice the duration of a hardware timeout, while the original
initialization error code is lost.

> @@ -907,11 +931,38 @@ void mana_hwc_destroy_channel(struct gdma_context *=
gc)
[ ... ]
> +	if (hwc->setup_active) {
> +		int td_err =3D mana_smc_teardown_hwc(&gc->shm_channel, false);
> +
> +		if (td_err) {
> +			dev_err(gc->dev,
> +				"HWC teardown failed: %d, leaking resources\n",
> +				td_err);
> +			return;
> +		}

[Severity: High]
Could this early return leave a stale pointer in gc->cq_table?

If mana_smc_teardown_hwc() fails, this returns early without clearing
gc->cq_table. On resume or re-initialization, mana_hwc_create_channel()
creates a new hwc but reuses the same gc.

During mana_hwc_establish_channel(), while waiting for the initialization
event, the hardware could send an EQE updating gc->max_num_cqs to a large
value. Because the new cq_table is not assigned until after the wait
completes, gc->cq_table still points to the old, leaked table.

A malicious host could then inject a completion EQE with an out-of-bounds
cq_id. This would pass validation against the newly inflated gc->max_num_cqs
but read out of bounds from the smaller, old cq_table.

> +
> +		hwc->setup_active =3D false;
> +	}
> +
> +	/* Tear down the HWC CQ object first =E2=80=94 mana_hwc_destroy_cq()
> +	 * both unpublishes the CQ from cq_table (+synchronize_rcu) and
> +	 * deregisters the HWC EQ from the interrupt handler list (via
> +	 * mana_gd_deregister_irq + synchronize_rcu), guaranteeing no
> +	 * interrupt handler can access RQ/TXQ buffers after this point.
> +	 */
> +	if (hwc->cq)
> +		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during CQ
destruction?

Looking at mana_hwc_destroy_cq(), the CQ is destroyed and its memory freed
before the EQ:

mana_hwc_destroy_cq() {
    ...
    if (hwc_cq->gdma_cq)
        mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
    ...
    if (hwc_cq->gdma_eq)
        mana_gd_destroy_queue(gc, hwc_cq->gdma_eq);
}

Although mana_gd_destroy_queue() on the CQ clears the cq_table entry and
calls synchronize_rcu(), the EQ is still fully registered and on the
interrupt dispatch list. A pending interrupt could fire immediately after
the CQ is freed.

The interrupt handler (mana_gd_process_eqe) might then trigger a
WARN_ON_ONCE(!cq) for completions, or call mana_hwc_init_event_handler()
which accesses the freed memory:

mana_hwc_init_event_handler() {
    ...
    case HWC_INIT_DATA_CQID:
        hwc->cq->gdma_cq->id =3D val;
        break;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803234355.6360=
38-1-longli@microsoft.com?part=3D5
