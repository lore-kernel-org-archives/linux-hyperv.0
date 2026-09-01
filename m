Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E62327C08
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283255; cv=none; b=q2ymjhOsN0dWFWaUKbEwjJb4SXFtFzNVbVtBP9P6pWOtaTsxOWG2ZErTpOQg8pAolR73HFoBU2LR2kG0O0hMYKoHAHKvD5Fn00Yjt6enazqOqBiJZBlaVAeYPHXv2rNVuGRbIuFj6KW53u19jbCqojFruEXn23NO5L9lJ/PQTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283255; c=relaxed/simple;
	bh=Xd75rEnkDfgAuygfb2oMQnFRq1pWXY0bkmEw9LiHbr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfSrPBv/qCO9UxiZJR/Eg6XMmS2a645U2JmbQaS7UpDhuCdEBGNcSJ/Hh4WM9c2ZyChmsb+y2AO1p6rqlQLI7roChbbCu0ZsWOtrYJxIDm4RzudoyKLNuLBAUyvKa4IO6GMYPQr+KmgcSXGq3jAPeag569Qh7HmrKdLjEK6ejGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMYQE/9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMYQE/9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A361F000E9;
	Tue,  1 Sep 2026 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283254;
	bh=8nQs6Mag4JveBeYOxmZA19bzN7D9qr4y+Nrp6dXCHuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMYQE/9+6TeQNaW1L499G6jMeVQ2E+3Pzv0NC7mAZNomvXM4vPISUjQoMO4DvaJ0u
	 7eQezycYCJZrjM6h6p/P+/qe76TI8A4nDzWHscVp9yPSzmzpVEokSOkVqVocrzP6QA
	 tcSAfELgq4f0azNCA+4VuOlFrlJ83pebsMR/C+oII4fnc3W/N3WMawUHLC2HpGUVr/
	 ffUbgXXpDbzjusc+AdpMDklyYNQVVw9N0LouQNIqJueT+t3eySmTH1rlJbRGy6NSxu
	 F1FO3logb6+c360VG5M5XItLJju+OqD1phUKBCb7D+YqUw98RCfKvH+VX5FWbeu0wR
	 gZQuEvjlaTw/g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/12] drivers: hv: hv_vsm_boot: load secure kernel
 image from firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-8-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-8-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:20:53 +0000
Message-Id: <20260901172053.F2A361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] The ELF loader lacks bounds checking for program headers and segme=
nt data against the loaded firmware size, allowing out-of-bounds memory rea=
ds.
- [High] Missing validation that `p_memsz >=3D p_filesz` leads to integer u=
nderflow and massive out-of-bounds `memset`.
- [High] Signed-to-unsigned integer promotion bypasses the spatial boundary=
 check, allowing out-of-bounds memory writes.
- [High] The ELF load alignment is passed directly to `PTR_ALIGN` without v=
erifying it is a power of two, breaking pointer arithmetic.
- [High] The bounds check uses a hardcoded maximum size instead of the actu=
al reserved memory resource size, allowing out-of-bounds writes.
- [High] Integer overflow in the calculation of the ELF binary memory footp=
rint bypasses spatial bounds checks.
- [Medium] Incorrect use of the `PTR_ALIGN` macro miscalculates alignment b=
y unnecessarily pre-adding the alignment value, violating generic alignment=
 semantics.
--

commit a2d9d89a62300f04ed251e2db601b303f521e71c
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: hv_vsm_boot: load secure kernel image from firmware

This commit adds a VTL0-side loader for LVBS bring-up that stages a secure
kernel image into the reserved memory region. It fetches a 64-bit ELF using
request_firmware(), validates the ELF header, and stages the PT_LOAD
segments into memory.

> diff --git a/drivers/hv/hv_vsm_boot.c b/drivers/hv/hv_vsm_boot.c
> --- a/drivers/hv/hv_vsm_boot.c
> +++ b/drivers/hv/hv_vsm_boot.c
[ ... ]
> @@ -38,6 +55,167 @@ static int hv_vsm_get_register(u32 reg_name, u64 *res=
ult)
[ ... ]
> +static size_t __init hv_vsm_elf_binary_size(void *image)
> +{
[ ... ]
> +	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {

[Severity: High]
Is it safe to blindly iterate over and read memory from phdr here? If the
program header table offset or count extends beyond the firmware limits,
this could result in out-of-bounds memory reads.

> +		if (phdr->p_type !=3D PT_LOAD)
> +			continue;
> +
> +		max_paddr =3D max(max_paddr, phdr->p_paddr + phdr->p_memsz);

[Severity: High]
Can this calculation overflow? If a malformed ELF segment defines p_paddr
and p_memsz such that their sum exceeds the 64-bit integer limit, it could
wrap around. This would result in an undersized binary size, potentially
bypassing later spatial bounds checks and allowing out-of-bounds writes.

> +	}
> +
> +	return max_paddr - min_paddr;
> +}
> +
> +static int __init hv_vsm_load_elf(void *image, Elf64_Addr *sk_entry_pa)
> +{
[ ... ]
> +	/* Align the base load address up to the first PT_LOAD segment alignmen=
t */
> +	base_addr =3D PTR_ALIGN(vsm_skm_va + first_load_align, first_load_align=
);

[Severity: Medium]
Does this code miscalculate the alignment? By explicitly adding
first_load_align before invoking PTR_ALIGN, it forces the pointer to skip
an entire alignment block even if it is already aligned, which wastes memory
within the strictly reserved region.

[Severity: High]
Additionally, PTR_ALIGN relies on the alignment being a power of two. Since
first_load_align is only validated below using modulo (modulo SZ_2M), could
a non-power-of-two alignment corrupt the pointer calculation entirely?

> +
> +	size =3D hv_vsm_elf_binary_size(image);
> +	if (vsm_skm_va + VSM_SK_INITIAL_MAP_SIZE - base_addr < size) {

[Severity: High]
Can a malicious base_addr bypass this validation entirely? If base_addr
is located beyond the vsm_skm_va + VSM_SK_INITIAL_MAP_SIZE limit, the
pointer arithmetic yields a negative ptrdiff_t. When compared against the
unsigned size_t size, it undergoes standard C integer promotion to a
massive positive value, completely bypassing the boundary condition.

[Severity: High]
Also, does this check artificially limit the copy size against a hardcoded
constant rather than the actual bounds of the allocated sk_res region?
If a user reserves a secure kernel region smaller than 16MB via the kernel
command line, this could allow writes outside the dynamically allocated
physical region.

> +		pr_err("secure kernel does not fit: %zu > %td\n", size,
> +		       vsm_skm_va + VSM_SK_INITIAL_MAP_SIZE - base_addr);
> +		return -EFBIG;
> +	}
[ ... ]
> +	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
> +		void *load_addr;
> +
> +		if (phdr->p_type !=3D PT_LOAD)
> +			continue;
> +
> +		/*
> +		 * Adjust the load address by min_paddr to compensate the
> +		 * offset.
> +		 */
> +		load_addr =3D base_addr + (phdr->p_paddr - min_paddr);
> +
> +		pr_debug("  p_offset: %#016llx, p_filesz: %#016llx, p_memsz: %#016llx =
to pa %#016llx\n",
> +			 phdr->p_offset, phdr->p_filesz, phdr->p_memsz,
> +			 virt_to_phys(load_addr));
> +		memcpy(load_addr, image + phdr->p_offset, phdr->p_filesz);

[Severity: High]
Are the ELF segment properties validated before this memcpy? The source
memory is derived from phdr->p_offset and phdr->p_filesz, which don't appear
to be checked against the total firmware size. This risks out-of-bounds
memory reads.

> +
> +		if (phdr->p_memsz =3D=3D phdr->p_filesz)
> +			continue;
> +
> +		pr_debug("    zeroing %#016llx bytes at pa %#016llx\n",
> +			 phdr->p_memsz - phdr->p_filesz,
> +			 virt_to_phys(load_addr + phdr->p_filesz));
> +		memset(load_addr + phdr->p_filesz, 0,
> +		       phdr->p_memsz - phdr->p_filesz);

[Severity: High]
Can this subtraction underflow? If a malformed ELF provides a PT_LOAD
segment where phdr->p_filesz is larger than phdr->p_memsz, this calculation
would result in a massive out-of-bounds memset that could destroy memory.

> +	}
> +
> +	*sk_entry_pa =3D virt_to_phys(base_addr + (ehdr->e_entry - min_paddr));
> +	pr_debug("secure kernel entry pa: %#llx\n", *sk_entry_pa);
> +
> +	return 0;
> +}
> +
> +static int __init hv_vsm_load_secure_kernel(Elf64_Addr *sk_entry_pa)
> +{
> +	const struct firmware *fw;
> +	Elf64_Ehdr *ehdr;
> +	int ret;
> +
> +	ret =3D request_firmware(&fw, SK_FW_NAME, NULL);
> +	if (ret) {
> +		pr_err("Failed to load %s firmware: %d\n", SK_FW_NAME, ret);
> +		return ret;
> +	}
> +
> +	ehdr =3D (Elf64_Ehdr *)fw->data;
> +	if (fw->size < sizeof(*ehdr) ||

[Severity: High]
Does this bounds check sufficiently validate the firmware size? It appears =
to
omit validation for the program headers' offset and count, which could
allow a malformed firmware file to trigger out-of-bounds reads later in
the loader.

> +	    memcmp(ehdr->e_ident, ELFMAG, SELFMAG) ||
> +	    (ehdr->e_type !=3D ET_EXEC && ehdr->e_type !=3D ET_DYN)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D7
