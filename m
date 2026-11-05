Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844993;
	b=JYkZ7CRnWD7QabuD+6feHhf0OGnwMaw/NU8gR2yBG99TIqqi0+a3tgWq8EIASGu2tWWs
	 Y4mn0b8wT1Cpg3JVxTRaOj+VIx/p6NzBwfM0uCVUjdwIQVaHynKitWx7cJhMfOLmt9GaC
	 iDL+wElKtUKgkWfIdkUrZ645RsNSGmEzkH1YJfDWfwjDne7nuMbUwsd6TQsv8bxCU5Q1d
	 Fw8HxdrQnUMOUAyaTCPSoiDLmxlVO0NRDAQQ0L+4DFy1Xd8WRIM0cxMaZWDz5LJ17pSYc
	 dwTXCXx1LZAc2Nf0AAYnZAPnQAW3zvIbpSbgmjYhEQi6Pz6macnj9spWabiAL+t2gyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qZeSeIWR9U/BTun87nqGA1sXByCWhPJI9Wz4QWGwg1U=;
	b=dj4SxkixHte/oJNY2KslGiXq9kuqd/gFvjl622XNCsPYFrw7/kUty7K7wmORRAlw7Gcm
	 L6LGD3R/LxmUT6GiIQhr2sCMPUvcfy05lZ8bwTTsML1IBnIaVqWDlNmlWFq/ALQHRDVhu
	 ukVUCX3aXr13cOwFlzuqDKBkvJiWe5HzJdm5bsXcR7Jaqtdgo0M2XAiS9ltwLy9ygZ4O/
	 aDyQOlvChDessSk/Cz974y9EdTxKIg0IMJbd7n8MBbErESyg0F6zSciHcsWK6Jzi8+bdP
	 CQwHfWiw0gFAEdMiZbbrNkcdZrt862xL/OZn200BMMsV8Gd4cTbiVCIsdUJ/btPwPYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXCZ+fJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E0606A31B
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXCZ+fJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58121F000C1;
	Thu,  5 Nov 2026 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844992;
	bh=qZeSeIWR9U/BTun87nqGA1sXByCWhPJI9Wz4QWGwg1U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BXCZ+fJq5aCL2ovI9UF++IZ2o/pLfhJa3hK6vxOhC5bbzgZtlKVsNKtx0OHhOXMpH
	 z57xSiE6efLm7YK87SEa/90eCaHjCLcxNJqDGbihdobAwAPUf44xwfAWetx6Fgo/y0
	 4P5TCKzdrMX8kVqVeptqj+FGhuKE9wEukSEicl0IMK/reCTRqoeUdwMqTMdckXNIZY
	 iJYhY2RiquWnC1zoNC1ondOW+cR/t4m+cdx8tnbiwIbat+dE14E7lz/SK2e6RXZ4Vg
	 VEAaq+mAKL5366HjsDWfpkNWMS6vgqRDFwx0ezyIOGOM9YRpHsnO5sNK33gX/YSXxC
	 3zwZ0lM2srB8A==
Message-ID: <sashiko-outbox-198443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/5] iommu/hyperv: Only call pviommu init on non-root
 VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261105020106.3496339-5-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:16:32 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/hyperv: hyperv_init() overwrites iommu_init without prior ch=
eck
--

commit ea2b425f9f0c2f00b3af04374abd0211b8229429
Author: Mukesh R <mrathor@linux.microsoft.com>

iommu/hyperv: Only call pviommu init on non-root VMs

This commit restricts setting x86_init.iommu.iommu_init to the Hyper-V
PVIOMMU initialization callback to non-root partitions and renames
hv_iommu_init() to hv_pviommu_init().

>     iommu/hyperv: Only call pviommu init on non-root VMs
>    =20
>     Next patch introduces root iommu init. Since both can co-exist, set
>     x86 iommu_init to pviommu init only on non-root VMs. Also, rename
>     hv_iommu_init() to hv_pviommu_init(). Lastly, check for null iommu_in=
it
>     before assignement as suggested by one of the pviommu authors.
>    =20
>     Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b90e6f4875335..ea50708c3ae60 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -580,7 +580,8 @@ void __init hyperv_init(void)
>  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev;
> =20
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -	x86_init.iommu.iommu_init =3D hv_iommu_init;
> +	if (!hv_root_partition())
> +		x86_init.iommu.iommu_init =3D hv_pviommu_init;

[Severity: High]
The commit message states:

  "Lastly, check for null iommu_init before assignement as suggested by one
  of the pviommu authors."

However, hyperv_init() in arch/x86/hyperv/hv_init.c only checks
!hv_root_partition() before overwriting x86_init.iommu.iommu_init. Was the
check accidentally omitted from this patch?

Also, x86_init.iommu.iommu_init is initialized to iommu_init_noop rather
than NULL in arch/x86/kernel/x86_init.c:

    .iommu =3D {
        .iommu_init =3D iommu_init_noop,
    },

During x86 boot, start_kernel() -> mm_core_init() -> arch_mm_preinit() ->
pci_iommu_alloc() runs before init_IRQ() -> apic_intr_mode_init() ->
x86_platform.apic_post_init() -> hyperv_init(). If an ACPI DMAR or IVRS
table is present on a non-root partition (such as a guest VM with an
emulated Intel VT-d or AMD-Vi vIOMMU, or an L1VH partition where
hv_root_partition() returns false), detect_intel_iommu() in
drivers/iommu/intel/dmar.c or amd_iommu_detect() in
drivers/iommu/amd/init.c sets iommu_detected =3D 1 and sets
x86_init.iommu.iommu_init to intel_iommu_init or amd_iommu_init.

When hyperv_init() subsequently overwrites x86_init.iommu.iommu_init with
hv_pviommu_init, apic_bsp_setup() -> enable_IR_x2apic() ->
irq_remapping_prepare() still allocates early DMAR/IVRS structures
(dmar_drhd_unit and intel_iommu, or amd_iommu instances, device tables, and
command buffers). Later, when pci_iommu_init() invokes
x86_init.iommu.iommu_init(), hv_pviommu_init() in
drivers/iommu/hyperv/hv-iommu-guest.c sees iommu_detected set:

    if (no_iommu || iommu_detected)
        return -ENODEV;

and returns -ENODEV without running intel_iommu_init() or amd_iommu_init().
Could this leave neither IOMMU initialized while leaking the early-allocated
DMAR/IVRS structures, and should hyperv_init() check !iommu_detected (or
x86_init.iommu.iommu_init =3D=3D iommu_init_noop) before assigning
hv_pviommu_init?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020106.3496=
339-1-mrathor@linux.microsoft.com?part=3D4
