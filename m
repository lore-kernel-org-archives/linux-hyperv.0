Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22927435AB3;
	Tue, 28 Jul 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247469; cv=none; b=vCHE1ez698tlFXhAqUg5HkPJ4FyDj2UmiOtOC6xAduRzi3/D1FBaKF7Lod//x3kfCfND1MWPa2zCaPiwSaRK6ZRc5VGu4ImhAKaZ1slDyL3Is3SzLhp0jSfAPZNmGlMod23XKQF2VP2AOF5oXcmXXOME+HnVn8i69VM8Gzje9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247469; c=relaxed/simple;
	bh=eu6VoR90zzm+rfpqRdKp2PLuYrlRS8U2cJKQaBRU/2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CceSVx7hf5Bb3AB78N4w7rlXf68Yoj9z1CaiPYjpjeE4YVnN3cHAa4pKztOFesMGcCqDdn/5KLY2py/3NMS1udpsB/rKvUNaaascFlDfTbDftXXDVu6gHzUG9pR7I/Z0PODak2AD3YDpC596RKDGoxNbJwI44zb70YazoLJDa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enDXxXMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enDXxXMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714311F000E9;
	Tue, 28 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247467;
	bh=7bDgTzWW37Ji9lo8k4jClll2ORwVjCpxFFzgpwR4ErU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enDXxXMrIIAbVHG2acGwNzReeX1n1ZtpGtu89bRaVHRkGxxqc54v1qrFS/WjOG6fz
	 perxMvSLS0nlbXHlmlULF+CqamFiDx4x25o2tojrvgAMhYKXmv2mXPfjDEJBqd8PGu
	 lo2Yiu+vHdTnpVx3BZRPIWm5r+txFnzodwq1DFD5oMkEJWUxnrSyFflGG1d0Y5Sn7a
	 cjvKRcxbSFDSffK8XEbzZ0c1vAcpT1JzYjISyEuesdmJmQdhhO0sU5LYCB9EuRS9FL
	 yQPPV/SgfZzKUo7koPqR/FoM5vKpBwdq+qtsM/jMn/eQCL1HUXX0pbnpreWS+OghQe
	 ZWJog/Lux0A4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V
 PCI MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260728135117.2888175-2-namjain@linux.microsoft.com>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:04:27 +0000
Message-Id: <20260728140427.714311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fix for dropped pending interrupts during CPU hot-unplug was m=
issed in the sister Hyper-V root partition MSI domain.
--

--- Patch [1]: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hype=
r-V PCI MSI irqchip ---
commit b8b1c843c457dd145f0d360b44f4b1bf34bd8cf5
Author: Naman Jain <namjain@linux.microsoft.com>

PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip

The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
the outgoing CPU to a new target. As the Hyper-V PCI/MSI chip does not
provide that callback, the pending interrupt is silently dropped, which
can result in lost interrupts, stalls and "No irq handler for vector"
messages.

Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft=
 Hyper-V VMs")
Cc: stable@vger.kernel.org
Suggested-by: Long Li <longli@microsoft.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad6..89816a2bd7cd3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device=
 *dev, struct irq_domain *dom
>  	info->ops->msi_prepare =3D hv_msi_prepare;
> =20
>  	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
> +	chip->irq_retrigger =3D irq_chip_retrigger_hierarchy;

[Severity: High]
This isn't a bug introduced by this patch, but does the sister Hyper-V root
partition MSI domain in arch/x86/hyperv/irqdomain.c also need this fix?

Looking at hv_init_dev_msi_info(), it appears to be missing the exact same
callback initialization for the root partition's top-level irq_chip:

arch/x86/hyperv/irqdomain.c:hv_init_dev_msi_info() {
	...
	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
		return false;

	chip->flags |=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;

	info->ops->msi_prepare =3D pci_msi_prepare;

	return true;
}

If a CPU is hot-unplugged while a device MSI interrupt is pending in its
local APIC IRR, could fixup_irqs() fail to resend the pending interrupt
to the new target CPU because this callback is NULL?

This could potentially lead to the same lost interrupts and I/O stalls=20
described in this commit message, just in the root partition MSI domain
instead of the guest paravirtual MSI domain.

> =20
>  	if (IS_ENABLED(CONFIG_X86))
>  		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135117.2888=
175-1-namjain@linux.microsoft.com?part=3D1
