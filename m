Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6538F922;
	Wed, 23 Sep 2026 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138517; cv=none; b=YXGDLNS0DHJd5GUaAB9BhqwTJiMvAcN4PkASnEdMAyL785I45Dtgc+RcT1URaTU9+5y6N30+yz4BLEkZGa0X6vpGe2fgUjr4TR6RsVHVgMfgMygRCLM5homYZerbmvshfTisFXcEqVxPTMyw+CdJdndqLit5yObP5W0QDeWnNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138517; c=relaxed/simple;
	bh=/fZHByCCEDJeeI5uQS6QxWBPuFPxt+X9SuNOd7cQPO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hC7B3WpJE43yygkG8m1HNC4Cpf/Myn16TmxXyKec9jDqXmb5SWsqWaWSVsgtH+pqkKdaV5D0RoFrAP+GdS4kSeQXq6c7AjeemSIidZ6L2m5StKCpPwiAER87ZB5YRFz9+qtp5ZgHLhAyvvsExuo1Rm9XD/gVVamqSoIeFm3e4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3KpWTY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3KpWTY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBAF1F000FF;
	Wed, 23 Sep 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138516;
	bh=6jBSoM2fJWex8w1UDiJsXPaUgiEj8Jw2EE3n+JbtXa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3KpWTY2f2+w7RaY5iNJw+OgZ7Z8qUcZeeYOcOab11LUsL6m4t1yLRN/3Ra5yOQHr
	 /c5q0K7oTveSUacu0ABLZZHOD37EgGUczBh2NzkDJjveiA0PCIfuv5ZPRAxLfJPxHx
	 KZ0I+bIaROl6j09fnWuuWYq6HHjsk+/oqTKUHhC2mi6XLFx1Stx2n/fRfAF0hnKkzI
	 COSCw+O+2icLqoB/noEt0x9tt13xEVBh2Cz5f1ajU5R6ZLNGNOwoRZgj5xGJJ2w7HB
	 UlKWvzxSTxVpSLFIcBf3y8+VFE/aJkyI1QmsGYvuTix+CxVIjoWxIqghw/UAQI3UTO
	 FfGg3Kr2Ybjuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260923043023.3150498-3-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:41:55 +0000
Message-Id: <20260923044156.0DBAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/irq: lost interrupts in fixup_irqs() due to bypassed irq_retri=
gger
--

commit a27ffeac3562f1a871ba38be5a47e5097ea4e9f4
Author: Naman Jain <namjain@linux.microsoft.com>

x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()

fixup_irqs() re-injects a pending interrupt on its new target CPU by looking
at the outermost domain chip and invoking its irq_retrigger() callback
directly. This commit changes the implementation to use
irq_chip_retrigger_hierarchy() instead, which walks up the interrupt hierar=
chy
until it finds a chip that implements irq_retrigger(). It also changes
desc->lock to use a scoped guard.

> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 30122f0b3af96..acdc1145cce6d 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -490,21 +490,19 @@ void fixup_irqs(void)
>  	 * nothing else will touch it.
>  	 */
>  	for (vector =3D FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
> +		desc =3D __this_cpu_read(vector_irq[vector]);
> +
> +		if (IS_ERR_OR_NULL(desc))
>  			continue;
> =20
>  		if (is_vector_pending(vector)) {
> -			desc =3D __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> +			guard(raw_spinlock)(&desc->lock);
>  			data =3D irq_desc_get_irq_data(desc);
> -			chip =3D irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			ret =3D irq_chip_retrigger_hierarchy(data);

[Severity: High]
Does this skip the outermost chip and potentially drop the interrupt?

In fixup_irqs(), data is passed to irq_chip_retrigger_hierarchy(), which
begins by immediately advancing to data->parent_data:

kernel/irq/chip.c:irq_chip_retrigger_hierarchy() {
	for (data =3D data->parent_data; data; data =3D data->parent_data)
		if (data->chip && data->chip->irq_retrigger)
			return data->chip->irq_retrigger(data);

	return 0;
}

If the outermost chip (such as lapic_controller for legacy IRQs) implements
irq_retrigger itself, the original irq_data is skipped and the loop will
terminate immediately if data->parent_data is NULL.

This can lead to hardware interrupts pending during CPU hot-unplug being
silently dropped. It appears this logic error is not fixed by subsequent
patches in the series either.

> +			if (ret)
>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043023.3150=
498-1-namjain@linux.microsoft.com?part=3D2
