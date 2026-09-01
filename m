Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A07488211
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283556; cv=none; b=eeDB/+HnRtEszwolabm5Vy9wQKS1kDpU8XHOrERka90VeWug4ehlRqhG79e5Ng9Dez2WaMK43RhmIruvmQPaNChSz2BvHpbt2h6EXUBi8vGyEYzy27OZpgyoAhdfgmJarbz3x7JUmD1apbgyUSAQVZW1iOC/UnCBw/SfCqHsX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283556; c=relaxed/simple;
	bh=9tkG6U0syQa7hbIa/uMMGoGNqIhdC8NlKtYnvvQwErs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CWhs8N3M1UxvwCUH8FYkGs/on2uwd3uzuFkMsLDB8pzi14XonkPkaMWdO3MfLZgwmtmSCvBdUa6XicxpjKI2uUQt6K2njMMtrloeDu3VdzLbnvtbQ24hdw3fktiz5avyG1MKmQltIU+MoyXTW0MqCSfVhvz7niTHbjN4XznObUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAr4YmRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAr4YmRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E591F000E9;
	Tue,  1 Sep 2026 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283554;
	bh=vzDAZ97S0TRw1clk9emrfaUHJLmPOpY4Fgmo9+sHlkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAr4YmRGfqh+5b5D59HTwINdqw2+juIuWI4cdOCrZKR5CjU5CC8I58OM03qhMBbBq
	 yEY15sUS36fkN7ysvW8FTqTmgutjRB2iDeJzXHCaH7Hg94Qq1atRfvGM3Wzcu3rm3Z
	 3p2cFBHiTS5bCcjMRrhiGnnn6wccny/wT6FGZXbEt4XF93/zlXi1t4tIe0thdEG9YN
	 yNXT17gJ9fGBtKEBlXri5JM3wLe9SSlsGtoE7jAI5mxTFvrfB5WvwS5Tp0/Ji6oDXr
	 D2gAZrvzSJt7V4vT+p/1hJKVfX+dFvhevItJ0ekjNsH4cMJ3kteBDvVZyUJ4h6vdkC
	 R6ak4bP14GOQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/12] arch: x86: hyperv: Build initial vCPU context
 for VTL1 secure kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-9-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-9-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:25:54 +0000
Message-Id: <20260901172554.C1E591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Page table initialization out-of-bounds write to the PDE page if t=
he mapping crosses a 1GB boundary.
- [High] Hardware-consumed GDT, TSS, and Kernel Stack pages are mapped but =
never zero-initialized, exposing host memory fragments.
- [Low] The TSS GDT descriptor limit is set to `tss_size` instead of `tss_s=
ize - 1`.
--

commit 6f8a1a825749fc111adb451004cf1aa1f0e24ee1
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

arch: x86: hyperv: Build initial vCPU context for VTL1 secure kernel

This commit adds the architecture-specific initialization function to const=
ruct
the initial page tables, GDT/TSS, and CPU register state for transitioning =
the
boot processor to the VTL1 secure kernel. It allocates and populates the da=
ta
structures required by Hyper-V's hv_init_vp_context.

> diff --git a/arch/x86/hyperv/hv_vtl_vsm.c b/arch/x86/hyperv/hv_vtl_vsm.c
> new file mode 100644
> index 0000000000000..edc55264c4d87
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_vtl_vsm.c
[ ... ]
> +static void __init hv_vsm_fill_pte_tables(phys_addr_t sk_pa, u64 *pde,
> +					  int pd_index, int num_pte_tables)
> +{
> +	u16 i, j;
> +	phys_addr_t pte_pa;
> +	u64 *pte;
> +
> +	/* Fill page tables with entries */
> +	for (i =3D 0; i < num_pte_tables; i++) {
> +		pte_pa =3D PAGE_AT(sk_pa, VSM_PTE_PAGES + i);
> +		pte =3D phys_to_virt(pte_pa);
> +		*(pde + pd_index + i) =3D pte_pa | VSM_PTE_FLAGS;

[Severity: High]
Does this loop overflow the 4KB PDE page if sk_pa crosses a 1GB boundary?=20

The allocator only guarantees a 2MB alignment for sk_pa, so pd_index can
be near the end of the page directory (e.g., 511). Since num_pte_tables
can be up to 8 (for a 16MB initial mapping), pd_index + i will exceed the
511 maximum index of the page directory, causing an out-of-bounds write into
the adjacent VSM_PTE_PAGES memory.

[ ... ]
> +static void __init hv_vsm_init_page_tables(struct hv_init_vp_context *vp=
_ctx, phys_addr_t sk_pa)
> +{
[ ... ]
> +	pml4e =3D phys_to_virt(pml4e_pa);
> +	pdpe =3D phys_to_virt(pdpe_pa);
> +	pde =3D phys_to_virt(pde_pa);
> +
> +	/*
> +	 * Zero the PML4, PDP, PD and PTE pages before populating them so that
> +	 * any entry not explicitly written below has its present bit clear.
> +	 */
> +	memset(pml4e, 0,
> +	       (VSM_KERNEL_STACK_PAGE - VSM_PML4E_PAGE) * VSM_PAGE_SIZE);

[Severity: High]
By starting the memset at VSM_PML4E_PAGE and stopping before
VSM_KERNEL_STACK_PAGE, does this leave VSM_GDT_PAGE, VSM_TSS_PAGE, and
the kernel stack page completely uninitialized?

The underlying physical memory is not guaranteed to be zeroed by the alloca=
tor,
which would expose host memory fragments directly to the secure kernel.

[ ... ]
> +static void __init hv_vsm_init_gdt(struct hv_init_vp_context *vp_ctx, ph=
ys_addr_t sk_pa)
> +{
> +	phys_addr_t gdt_pa, tss_pa, kstack_pa;
> +	void *gdt_va;
> +	u64 tss_sk_va, gdt;
> +	struct x86_hw_tss *tss;
> +	size_t gdt_size =3D sizeof(gdt), tss_size =3D sizeof(*tss), gdt_offset =
=3D 0;
> +
> +	/* Get a page for the GDT */
> +	gdt_pa =3D PAGE_AT(sk_pa, VSM_GDT_PAGE);
> +	gdt_va =3D phys_to_virt(gdt_pa);
> +	/* Get a page for the TSS */
> +	tss_pa =3D PAGE_AT(sk_pa, VSM_TSS_PAGE);
> +	tss =3D phys_to_virt(tss_pa);

[Severity: High]
Since the memory backing tss was skipped by the memset in
hv_vsm_init_page_tables(), will the hardware task state segment be populated
with random garbage?

This would leave hardware fields like the interrupt stack tables (ist) and
the IO bitmap base uninitialized, potentially causing a fatal exception whe=
n an
interrupt is taken in VTL1.

[ ... ]
> +	/*
> +	 * Make and add a system segment descriptor for the TSS in the GDT.
> +	 *
> +	 * In 64-bit mode a system-segment descriptor (TSS/LDT) is 16 bytes
> +	 * wide: the lower 8 bytes have the same layout as the legacy 32-bit
> +	 * descriptor (produced by GDT_ENTRY), and the upper 8 bytes hold
> +	 * base[63:32] in the low 32 bits with the high 32 bits reserved 0.
> +	 * GDT_ENTRY masks base to 32 bits, so the upper half must be written
> +	 * explicitly.
> +	 */
> +	gdt =3D GDT_ENTRY(DESC_TSS32, tss_sk_va, tss_size);

[Severity: Low]
Is this descriptor's limit off by one?

x86 segment limits are inclusive, so shouldn't this pass tss_size - 1 rather
than tss_size to avoid allowing access one byte past the end of the TSS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D8
