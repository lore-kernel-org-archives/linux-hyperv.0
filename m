Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39E403AEC
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763979; cv=none; b=RFznefTLskBCm36u4Fsh6juwzX3SaAVCZXPgOfOS8xXIx8Y9cQ0BNwMZyArW3yvpWXyIUAPLYOGyPGpA9P3hyE5/MEo0HW9iibNIR4I0fodjgyqYRytg8H2uDHdT+/yzOpQqXwiz9mKZSuNwZkw3pYOio4bXVk3tNfggLN4Kx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763979; c=relaxed/simple;
	bh=u/aUFfSibyixEVAF16QBaw1wKa36EXBxVzK2EKayY2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AYV1wUb2hTRBCOvFmuppKkNo1B+yzM1CX3dL/5b4wCqTwFNY6SUDxd5xdrcbbf/ch3KXw4vVT+jt18q6sKdX/6J69+0nRyTNIoq9XI1cSRAp5oFfeRVQh8aPWO824vrHlFlw5dwgJC4Q24okCZdS2SJGlLguRhLAdBgCv6FhbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ7bO9aK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ7bO9aK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69E61F00A3D;
	Wed, 22 Jul 2026 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763977;
	bh=5oNRF5awI4qGpEG8wBpc4z8tSkPzYk1qEo5zPyk73Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJ7bO9aK37CWlJP1qM/7cAolzp2X0i1MXvEw7MpY732Md0G9Uw8+jPH/l08G30a3x
	 67hUgLminDkjV43fDPijoh0K6sBqEg/QtnhgGRfc/nFw4tXVjHS0WQwSBMfJwF8qOb
	 pLgqi+h5BTzpi07R8lO0lGNSgZFSUy/3/pJy72o386qjgEWFdWauL4qQK5swd2zyVq
	 BcInlNe2W3t9A6uRsQ91wDYBJeNlfWr0qWw+EQPl7GZKyPVFxIXZkGG+gzCxWI64jo
	 trt8/i38fCQYyaEHt6V4jBmYLiMSaSTehEOaFafYch6Uhh+j8gw/56SkZ5Ro8FHhDf
	 se23nGgsfzQsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: mana: fix HWC teardown safety with
 setup_active flag and destroy ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721234339.1476932-6-longli@microsoft.com>
References: <20260721234339.1476932-1-longli@microsoft.com>
 <20260721234339.1476932-6-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:46:17 +0000
Message-Id: <20260722234617.B69E61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Improper PCI device reset via `pcie_flr()` leaves PCI core state o=
ut of sync.

Pre-existing issues:
- [Critical] Use-After-Free in EQ interrupt handler because the CQ is destr=
oyed before the EQ is deregistered.
- [Critical] Tag reuse causing logical corruption when HWC commands time ou=
t.
- [High] Race condition leading to Use-After-Free on module unbind due to u=
n-cancelled `mana_serv_work`.
--

--- Patch [5]: [PATCH net-next v2 5/7] net: mana: fix HWC teardown safety w=
ith setup_active flag and destroy ordering ---
commit 7a0e58ab3c693baa720b6e21219cbe04fb7e9fcf
Author: Long Li <longli@microsoft.com>

net: mana: fix HWC teardown safety with setup_active flag and destroy order=
ing

This patch adds a setup_active flag to ensure safe hardware channel teardown
on initialization failures. It also reorders queue destruction to prevent
DMA-after-free races during teardown.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 515c45c4a890f..5bc873d548d58 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -902,11 +926,58 @@ void mana_hwc_destroy_channel(struct gdma_context *=
gc)

[ ... ]

> +			/* On systems without IOMMU, freeing DMA memory with
> +			 * active hardware MST mappings risks memory corruption.
> +			 * Issue FLR to force-reset the device and invalidate
> +			 * all hardware state including MST entries.
> +			 */
> +			td_err =3D pcie_flr(to_pci_dev(gc->dev));

[Severity: High]
Does using pcie_flr() here instead of pci_reset_function() leave the
Linux PCI core completely unaware of the reset?

Since pcie_flr() does not save and restore the PCI configuration space,
such as BARs, MSI-X vectors, and Bus Master enable, could this leave the
hardware's PCI configuration wiped and out of sync with the kernel's
cached state, resulting in a wedged device?

> +			if (td_err) {

[ ... ]

> +	/* Tear down the HWC CQ object first =E2=80=94 mana_hwc_destroy_cq()
> +	 * both unpublishes the CQ from cq_table (+synchronize_rcu) and
> +	 * deregisters the HWC EQ from the interrupt handler list (via
> +	 * mana_gd_deregister_irq + synchronize_rcu), guaranteeing no
> +	 * interrupt handler can access RQ/TXQ buffers after this point.
> +	 */
> +	if (hwc->cq)
> +		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);

[Severity: Critical]
This is a pre-existing issue, but does destroying the CQ before the EQ
inside mana_hwc_destroy_cq() create a use-after-free window?

In mana_hwc_destroy_cq(), the CQ structure is freed first:

mana_hwc_destroy_cq() {
    if (hwc_cq->gdma_cq)
        mana_gd_destroy_queue(gc, hwc_cq->gdma_cq);
    ...
}

If the hardware posts an initialization event before the EQ is
subsequently destroyed, could the interrupt handler execute:

mana_hwc_init_event_handler() {
    ...
    case HWC_INIT_DATA_CQID:
        hwc->cq->gdma_cq->id =3D val;
        break;
}

and write directly into the newly freed gdma_cq structure memory?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
leading to a use-after-free on module unbind due to un-cancelled service
work?

If a hardware reset event triggers mana_schedule_serv_work(), it queues
work on the global system_wq. If the driver is unbound via sysfs,
mana_gd_remove() frees the gdma_context via vfree(gc) without cancelling
this pending work.

Could the work then execute concurrently, calling mana_serv_reset() which
fetches the freed context:

mana_serv_reset() {
    struct gdma_context *gc =3D pci_get_drvdata(pdev);
    struct hw_channel_context *hwc =3D gc->hwc.driver_data;
    ...
}

and dereference the freed memory?

[Severity: Critical]
This is a pre-existing issue, but can tag reuse cause logical data
corruption when hardware channel commands time out?

When wait_for_completion_timeout() times out in mana_hwc_send_request(),
the function calls mana_hwc_put_msg_index() to free the msg_id for
immediate reuse.

Since the hardware is not reset, the timed-out command is still pending.
If another thread sends a new command and allocates the same msg_id,
what happens when the hardware eventually responds to the original
command?

Could mana_hwc_handle_resp() match this late response to the new command:

mana_hwc_handle_resp() {
    ctx =3D hwc->caller_ctx + msg_id;
    ...
    memcpy(ctx->output_buf, resp_msg, resp_len);
    complete(&ctx->comp_event);
}

and complete it with stale data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721234339.1476=
932-1-longli@microsoft.com?part=3D5
