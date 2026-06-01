Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41F199949
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780354794; cv=none; b=SB4euaQCOt3tGlF3RC1Z41tfNFH0PrTJJoDWlOoEy+5+egvhAsXwbnOlFNtycXZhyzOsA4QXuFAX1LHihKtpnZT2vBK/wI24H95Gwv3gySBrKHCOqPEYGfTN+/t9pd/VcDPy2s80Tb+peZE3nfvlWed7v5Madcd7VH/sZeDPE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780354794; c=relaxed/simple;
	bh=vDxO/oN+LmIS6KJzwXnLwjf4J+KB0ni4e8rB8lC8wBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPCgmgWwJSoosPcbr42EIARxICLgBAgJzydXu8AQpFW4Ob7Fu3GqTlC+l/Yp3OjDX7LOi9ZPb0vukW8kSHF6svVN0I0xLwPAmNC5oz4UT1h2mFApg2J0DvrlvLsnbOQmZh9rig85VbkFkiSFFkEQVWlUiXKZfB0catcp/AZC3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmk0rX/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmk0rX/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B4D1F00893;
	Mon,  1 Jun 2026 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780354793;
	bh=j/fjeu5jhpYd+TyEyrQ3iAl6XuVTDxZ8MFnqUsDcxMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dmk0rX/ZiA0S0aUuhL7Vy7f9todFd3HEGrDw2mD7dUVsUa0LcrE2iBiNjF1HNnGf/
	 94lVei7ynbJxZ0AAmL9GojkknR4glYbNVXQw0qUXatRHgtiSWD42PDXj35dG0ZKCzD
	 FqOPcQRMvv4TK7QeByM2IQ52UYobyjaFOVSgF92yj1V2wNJqtEmcnURaU5Nc4wCR31
	 CqwgUxS2PIuxb4o4OrT/oXshblAAyPuxdkab+RaA0OFsVW+ZnhgUhjbFM1k0SrLZbR
	 xAgOVjmVh+2lH32rxMdS4J8Ank/0t6HD9ZzNB/Io5c2+y262dzMOrLspcScKoDH+19
	 Kk4y/pQNpbj/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes in irqdomain.c for
 readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260601225116.956392-1-mrathor@linux.microsoft.com>
References: <20260601225116.956392-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 22:59:52 +0000
Message-Id: <20260601225953.42B4D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Allocation or mapping failure in `hv_irq_compose_msi_msg()` ca=
uses the function to return without initializing the caller-provided `msg` =
structure, potentially leading to uncontrolled MSI writes by the device.
- [High] The `hv_msi_domain_free` function fails to iterate through allocat=
ed IRQs for multi-vector MSI, leading to leaked memory and stale hypervisor=
 mappings.
--

commit 042e553a37dead023377268bdb9c0d43c5394d75
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Cosmetic changes in irqdomain.c for readability

This commit makes various cosmetic changes to irqdomain.c, such as renaming
variables, fixing indentation, replacing spaces with tabs, and resolving
checkpatch warnings, with no functional changes intended.

> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 365e364268d9a..b3ad50a874dca 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c

[ ... ]

> @@ -249,10 +253,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *=
data, struct msi_msg *msg)
>  	}
> =20
>  	stored_entry =3D kzalloc_obj(*stored_entry, GFP_ATOMIC);
> -	if (!stored_entry) {
> -		pr_debug("%s: failed to allocate chip data\n", __func__);
> +	if (!stored_entry)
>  		return;
> -	}
> =20
>  	ret =3D hv_map_msi_interrupt(data, stored_entry);
>  	if (ret) {
>  		kfree(stored_entry);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning early here leave the
caller-provided msg structure uninitialized?

If kzalloc_obj() or hv_map_msi_interrupt() fails in hv_irq_compose_msi_msg(=
),
the function returns without populating msg. Because the callback returns
void, the error is swallowed and the caller might write the uninitialized
contents of msg to the device's MSI address/data registers, potentially
causing the device to perform DMA writes to arbitrary or null physical
addresses when an interrupt fires.

[ ... ]

> -static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, =
unsigned int nr_irqs)
> +static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq,
> +			       unsigned int nr_irqs)
>  {
>  	for (int i =3D 0; i < nr_irqs; ++i) {
>  		struct irq_data *irqd =3D irq_domain_get_irq_data(d, virq);

[Severity: High]
This is a pre-existing issue, but does this loop process the same base IRQ
on every iteration?

By calling irq_domain_get_irq_data() with virq rather than virq + i inside
hv_msi_domain_free(), subsequent iterations will skip the remaining
interrupts in a multi-vector MSI scenario. This could leave them unfreed
and potentially lead to leaked kernel memory and stale hypervisor mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601225116.9563=
92-1-mrathor@linux.microsoft.com?part=3D1
