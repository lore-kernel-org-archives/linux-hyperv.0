Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635A2E7179;
	Sat, 22 Aug 2026 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359976; cv=none; b=mWIYCWwC9/ay0QpuQKeSQGmc2Q7V0WnI/WuTmRF9osw3lhDEs4oA6V274EjgDg59IGEF0ZLHPaA9++A+FTk+Ck5ARreLA8Rb5Fp9kBHLgD9l8uJMwcMFfVn4wwJw4t0vLLG0H4l7JBSjWmxPypK6aDVopLa6KQ1LHI0yt9i0jVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359976; c=relaxed/simple;
	bh=QqFG0cxliJJ9VYtGutryCe6S4XoSVhCocYbhI93LJLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e8thc6M1+Eo67aL49ciwVSte/d/d92/ofnNgDGkoen2NvBMoIBqfH+dOdl/9m4iBbAG6/rvzxJ5EqpWDGwjiUpBLxtlLorzTZJ4nO4mx+5/v8PWoWQudUdG16ODF50zMmUT1y0UHsa5KET9mtIrMsLKbXDi7XirAnBbtUZoa2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce9VYjkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce9VYjkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627AC1F000E9;
	Sat, 22 Aug 2026 00:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359974;
	bh=V4SQdu77u7PU6etdVXEMLcrP6hDMmFF8WZyXfFErpDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ce9VYjkbFrGP7YQ1QSjP87BnZhofrye7sc5lH2JEv8YgC7IQwejaKulR/x0J6Ap70
	 lkQq8FYiMfB+QNk6yiLBZGDss7tQba4sbRcN8PP+svDm0GUeswkVcnm+FZ9hNRDJ0C
	 Iavf1D/12scS02kirzgn7GZ71Xl5uzk82e3PIcDia23D0HzV+25/CzN+1FEb3VgrFH
	 6/uMBxw6TYBVeWZHsDX5YYhsgqbdIPLYvl8FluF/oRa3oNQVrkZyGEA3OAOtC8t5aX
	 6eExOZ95bqbouYVb/zuIHsB1XplZ8ArH851Mn6xs8pUauoFtE5z8OmsLc7LMfd1FtP
	 SR314sMDIcLAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: hv: fix interrupt affinity change on the
 nested root partition
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260822003623.2925128-4-wei.liu@kernel.org>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-4-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 00:52:53 +0000
Message-Id: <20260822005254.627AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The newly composed MSI message on affinity change is never written=
 to the PCI device because `data->chip->irq_write_msi_msg` is NULL.
- [High] VMBus recomposition is permanently skipped when `mapped_vector` is=
 0, causing the device to use a stale vector.
- [High] Multi-MSI interrupts leak hypervisor mappings on every affinity ch=
ange.
--

--- Patch [3]: [PATCH 3/3] PCI: hv: fix interrupt affinity change on the ne=
sted root partition ---
commit b9428909b0f32d968c5c2cd7f2d85948c6d7893a
Author: Wei Liu <wei.liu@kernel.org>

PCI: hv: fix interrupt affinity change on the nested root partition

This commit updates interrupt handling on affinity changes in the nested ro=
ot
partition. It recomposes the VMBus interrupt with the new vector and progra=
ms
the device with the resulting message before mapping the new interrupt.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5a36382742bf7..5acb8e41567e6 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

[ ... ]

> @@ -752,9 +755,17 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  		 * RETARGET_INTERRUPT.
>  		 *
>  		 * Keep the returned entry so the mapping can be removed again
> -		 * when the interrupt is torn down.
> +		 * when the interrupt is re-targeted or torn down.
> +		 *
> +		 * This is also the re-target point.  The core calls us from
> +		 * __irq_move_irq() with the interrupt masked once the new
> +		 * vector has been assigned, so if the vector changed the vmbus
> +		 * interrupt is re-composed for it first -- PCI_CREATE_INTERRUPT
> +		 * carries the vector, so the device would otherwise keep
> +		 * signalling the one it was created with.
>  		 */
>  		struct hv_msi_int_entry *ie =3D data->chip_data;
> +		unsigned int vec =3D hv_msi_get_int_vector(data);
> =20
>  		/*
>  		 * A NULL chip_data means hv_compose_msi_msg() failed and the
> @@ -763,8 +774,29 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  		if (!ie)
>  			return;
> =20
> -		if (hv_map_msi_interrupt(data, &ie->hv_entry))
> +		/* Already mapped for this vector, nothing changed. */
> +		if (ie->mapped_vector =3D=3D vec && ie->hv_entry.source)
> +			return;
> +
> +		if (ie->mapped_vector && ie->mapped_vector !=3D vec) {

[Severity: High]
If hv_map_msi_interrupt() fails previously, ie->mapped_vector is set to 0.

On the next unmask, if the vector has changed due to an affinity change,
will this ie->mapped_vector !=3D 0 check skip recomposing the message?

It appears this could leave the device programmed with the old vector while
the hypervisor is programmed with the new one.

> +			struct msi_msg msg;
> +
> +			hv_compose_msi_msg(data, &msg);
> +
> +			ie =3D data->chip_data;
> +			if (!ie)
> +				return;
> +
> +			if (data->chip->irq_write_msi_msg)
> +				data->chip->irq_write_msi_msg(data, &msg);

[Severity: High]
Does hv_msi_irq_chip actually implement the irq_write_msi_msg callback?

Looking at the hv_msi_irq_chip definition, it seems to lack this callback.

If so, would this check fail and prevent the new MSI message from ever being
written to the device, causing it to continue signalling the old unmapped
vector?

> +		}
> +
> +		if (hv_map_msi_interrupt(data, &ie->hv_entry)) {

[Severity: High]
For multi-MSI devices, does this overwrite ie->hv_entry and leak hypervisor
mappings on every affinity change?

When hv_compose_msi_msg() is called for a multi-MSI device, it hits an
early return and bypasses the hv_vmbus_unmap_msi_interrupt() cleanup:

hv_compose_msi_msg() {
    ...
    if (data->chip_data && multi_msi) {
        ...
        return;
    }
    ...
}

Then hv_map_msi_interrupt() is called here, which issues a new
HVCALL_MAP_DEVICE_INTERRUPT and overwrites ie->hv_entry. Since the
previous mapping wasn't unmapped, is it permanently leaked?

>  			memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
> +			ie->mapped_vector =3D 0;
> +			return;
> +		}
> +		ie->mapped_vector =3D vec;
>  	} else {
>  		hv_irq_retarget_interrupt(data);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822003623.2925=
128-1-wei.liu@kernel.org?part=3D3
