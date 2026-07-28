Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE543786A;
	Tue, 28 Jul 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247406; cv=none; b=aRjcFKiShdtqoCxOAeU7xshlid6/GKWVRNE9k3p7mji0WlKuUsK4fax89TNTCTZYMGHAWAgxGMJsF9vJnx1sOVK6UdBhnYNzrjs0N8U7LzsB83yA1GK46WTHDXRfINjQDXasL+yx4GX/ybjme+oEJSYPwNKlTnWV1iN759+bXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247406; c=relaxed/simple;
	bh=T2NU3pmpi+OjQ7/FNVkJg9qIlm9hOemh0FAHOev63IU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhwdbPz2E6KZefCt3+9vkTw5Quba5LESRfwPVoLwbuohAciq/LglmXHyPQvdsoKkoiJOn4NTU+XRhOvZIO+DYtRrewV6/3MAm0aFE/NzyAFduLiiwVx35jG2lyclaLOrXHdoUA/F9YvSxMto3aMBzN8FEToDWihm6dxAo/fXvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJuQGIPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJuQGIPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D11F000E9;
	Tue, 28 Jul 2026 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247404;
	bh=M6AwQ7+MgGHjdLywKtET4of1Hk2KG/OkpgRG/h1rjvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJuQGIPLRDO68Qfoh7WUaYzK5cMyKQOKYH8FfFmdYIU5i56Sbz7E42+joleFmuOXE
	 gmPStc7xAgKObVUSRrX9C6XqUBENjQwuVt54uWTlk6bNT80TbQDsq1RfHv758WFcKB
	 zs9ZN641HOerhbABaZeKpP0FQaNlK7YcSbGYUdpXYaOtE2CFRhdZZw28o+DpmpVUuu
	 P8ojTZvyso+QKVAA56S5fw/+fKh8sQ7pXDK2d4ai4qxvQ2kPVXN4ymIf4wut4dBgDq
	 CmyjZAR/EmpWMOGyI05iGVh+7Y2OOns6X6qGYbBx52oiPS/YDB5LIgqsjnNmYxBpce
	 7qGSMbjJMp0AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260728135117.2888175-3-namjain@linux.microsoft.com>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:03:23 +0000
Message-Id: <20260728140324.690D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch replaces the direct invocation of the outermost chip's i=
rq_retrigger() callback with irq_chip_retrigger_hierarchy(). However, irq_c=
hip_retrigger_hierarchy() initializes its loop with `data =3D data->parent_=
data`, completely skipping the outermost chip. This breaks interrupt retrig=
gering for flat domains (like native lapic_controller) and any hierarchical=
 domain where the outermost chip directly implements the retrigger callback.
--

--- Patch [2]: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in f=
ixup_irqs() ---
commit f97e883de2f6626561de48c426194caa41c3e062
Author: Naman Jain <namjain@linux.microsoft.com>
x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()

This commit modifies fixup_irqs() to use irq_chip_retrigger_hierarchy()
instead of invoking the outermost domain chip's irq_retrigger() callback
directly. It also refactors the loop to use scoped guards for the irq
descriptor lock.

> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 30122f0b3af96..ef1bdd3c4659a 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
[ ... ]
> @@ -489,22 +484,18 @@ void fixup_irqs(void)
[ ... ]
> -	for (vector =3D FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
> +	for (unsigned int vector =3D FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS=
; vector++) {
> +		struct irq_desc *desc =3D __this_cpu_read(vector_irq[vector]);
> +
> +		if (IS_ERR_OR_NULL(desc))
>  			continue;
> =20
>  		if (is_vector_pending(vector)) {
> -			desc =3D __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> -			data =3D irq_desc_get_irq_data(desc);
> -			chip =3D irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			guard(raw_spinlock)(&desc->lock);
> +			if (irq_chip_retrigger_hierarchy(&desc->irq_data))
[Severity: High]
Will this skip the outermost chip and cause a regression for flat domains?

Looking at kernel/irq/chip.c:irq_chip_retrigger_hierarchy(), the loop
initializes by immediately moving to the parent_data:

    int irq_chip_retrigger_hierarchy(struct irq_data *data)
    {
        for (data =3D data->parent_data; data; data =3D data->parent_data)
            if (data->chip && data->chip->irq_retrigger)
                return data->chip->irq_retrigger(data);

        return 0;
    }

By passing &desc->irq_data directly to this function, it seems any retrigger
callback on the outermost chip itself will be bypassed.

Could this lead to dropped hardware interrupts during CPU hot-unplug for
flat domains (like native lapic_controller) or any hierarchical domain where
the outermost chip implements the retrigger callback?

>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135117.2888=
175-1-namjain@linux.microsoft.com?part=3D2
