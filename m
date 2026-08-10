Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03C3DA5CC
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367155; cv=none; b=sTrUR4iNyY18r8y7S6wSrA88X7unUlfggvwHwuSqGOsW4KZr7jaeBiy/y/s+q2EZVdgrzvrwNW2PSHiNk9UCKxqGG2qmHBhX3K8pR9oiXxvaepwAvkCOgx/0EuQLKt6+zYKECmdocQQDfgVTMSgG+8/kMnwZV2ru5gd0xgHOYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367155; c=relaxed/simple;
	bh=vOLVZMXSzSrAFmG61K6lOTediWX3jokEcyNQ5Qr8tMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Knz6vW6F+PSoTgsDXluwaqJLw/upYf57R642628Py8+tKBb+jJnTb3tV6mHM0PUIAcKBYnPKNtdpAN+hHCvREmBbLLMwdrsVmK/PxN/hsmLUaG4u4AmTg4FaCLnWMohzJXZgxfmwUxqRcYlj92y+EuDyrrWNd2tyyNCuLStBYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/re7ayH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/re7ayH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21291F000E9;
	Mon, 10 Aug 2026 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367154;
	bh=EtsgEQYQgMABhJLCbrAaaoltxF0MoIStD4xUpsVh4Do=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/re7ayHJf4vFk8vrP41c9t5MDPHyt/7H4/epUN2vMNbZx/2abxVirrSy1U0XDmfK
	 lkoc6NTDReQV//pkzaoBQoxytDEpmyF+CrtLuQiZWq+sOEbggEsybIoS4LuhNxfuw+
	 jl5K9COHE5usIVGzWGwNncE5Ew1KPSEOlqPtmMfx8ejuIY4rsJyqemxuUOPt9WIctj
	 eY2lJrjX9ZKrmf5v+8Mpx9uVwmGcgshsnhLdzOrlJQAJXYmAlkuEoq+XpTeVGGZMaE
	 tsjlKlHWblBr8aiVxbUjX5i0m19UCXhj6I0+RMYczlWzRrn31vVp3McmRUZNt3WSyw
	 +W7G3wBDxRQBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] hyperv: add MSHV Dom0 root-partition boot
 enablement (EFI HvLoader)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-13-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-13-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:05:53 +0000
Message-Id: <20260810130553.D21291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Secure Boot bypass and arbitrary memory overwrite via `hyperv_=
resvd=3D` early parameter.
- [High] Uninitialized stack variable `ret` used across trust boundary in `=
mshv_launch`.
- [High] EFI stub passes unmerged hypervisor memory ranges to the kernel, o=
verflowing command-line and parser limits.
- [High] Logic error in `hv_parse_hyperv_resvd_new` rejects valid physical =
address 0.
- [Medium] Incorrect variadic argument forwarding in `mshv_efi_reboot`.
- [Medium] State corruption in `hv_parse_hyperv_resvd_new` overwriting head=
 without clearing the tail.
- [Low] Incomplete implementation/Dead code: `SETUP_MSHV` is built but neve=
r parsed.
--

--- Patch [12]: [PATCH v2 12/13] hyperv: add MSHV Dom0 root-partition boot =
enablement (EFI HvLoader) ---
commit d68b02782397b0c67109138fd120320cacae1537
Author: Wei Hu <weh@microsoft.com>

hyperv: add MSHV Dom0 root-partition boot enablement (EFI HvLoader)

Port the EFI HvLoader protocol handshake (efi-mshv stub + SETUP_MSHV) and
the hyperv_resvd_new memory reservation so an upstream kernel can boot as
a Microsoft Hypervisor (MSHV) root partition.

> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 185d4f677ec0f..63504b22b5ba8 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
[ ... ]
> +static int __init hv_parse_hyperv_resvd(char *arg)
> +{
> +	int idx, max =3D ARRAY_SIZE(hv_resvd_ranges);
> +	int i =3D 0;
[ ... ]
> +	while (get_option(&arg, &idx)) {
> +		if (i >=3D max) {
> +			pr_err("Hyper-V: resvd ranges tbl full %d\n", idx);
> +			break;
> +		}
> +
> +		hv_resvd_ranges[i++] =3D idx;
> +	}
> +
> +	return 0;
> +}
> +early_param("hyperv_resvd", hv_parse_hyperv_resvd);
> +
> +/*
> + * Reserve memory that the hypervisor is using early on. The ranges are =
marked
> + * reserved by a custom bootloader, change that to usable and reserve th=
at
> + * range. Note, the bootloader sanitizes the e820 before passing on here.
> + */
> +static void __init hv_resv_mshv_memory(void)
> +{
> +	u64 start, end, size;
> +	int i, idx, max =3D ARRAY_SIZE(hv_resvd_ranges);
> +	int resource_index =3D 0;
> +
> +	for (i =3D 0; i < max && hv_resvd_ranges[i] !=3D -1; i++) {
> +		idx =3D hv_resvd_ranges[i];
[ ... ]
> +		start =3D e820_table->entries[idx].addr;
> +		size =3D e820_table->entries[idx].size;
> +		end =3D start + size - 1;
> +
> +		memblock_reserve(start, size);
> +		e820_table->entries[idx].type =3D E820_TYPE_RAM;
> +		pr_info("Hyper-V reserve [mem %#018Lx-%#018Lx]\n", start, end);
> +
> +		hv_mshv_res[resource_index].name =3D "Hypervisor Code and Data";
> +		hv_mshv_res[resource_index].flags =3D IORESOURCE_BUSY | IORESOURCE_SYS=
TEM_RAM;
> +		hv_mshv_res[resource_index].start =3D start;
> +		hv_mshv_res[resource_index++].end =3D end;
> +	}
> +}

[Severity: Critical]
Does this allow bypassing kernel lockdown?

The hv_parse_hyperv_resvd() function takes an unauthenticated index from the
kernel command line. Then hv_resv_mshv_memory() blindly converts that e820
entry to E820_TYPE_RAM and IORESOURCE_SYSTEM_RAM without bounds checks.

Could a user with access to the bootloader command line use this to target
reserved ACPI or firmware regions, map them as System RAM, and overwrite th=
em
via kexec_file_load?

> diff --git a/drivers/firmware/efi/libstub/efi-mshv-common.c b/drivers/fir=
mware/efi/libstub/efi-mshv-common.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/efi-mshv-common.c
[ ... ]
> +efi_status_t mshv_launch(void)
> +{
> +	struct hvl_return_data ret;
> +
> +	if (!efi_mshv)
> +		return EFI_SUCCESS;
> +
> +	efi_mshv->launch_hv(NULL, &ret);
> +	/* TODO: Where/how do we dump the hv loader logs? */
> +	if (ret.launch_data.launch_status !=3D 0)
> +		efi_rt_call(reset_system, EFI_RESET_COLD, EFI_ABORTED, 0, NULL);
> +	return EFI_SUCCESS;
> +}

[Severity: High]
Can this result in evaluating uninitialized stack memory?

The ret structure is allocated on the stack but not zeroed before being
passed to efi_mshv->launch_hv(). If the hypervisor loader protocol fails
early or neglects to fully populate the structure, does checking
ret.launch_data.launch_status read stack garbage and trigger an unexpected
cold reboot?

> diff --git a/drivers/firmware/efi/libstub/efi-mshv.h b/drivers/firmware/e=
fi/libstub/efi-mshv.h
> new file mode 100644
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/efi-mshv.h
[ ... ]
> +static inline void mshv_efi_reboot(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	efi_printk(fmt, args);
> +	va_end(args);
> +
> +	efi_bs_call(stall, 5 * EFI_USEC_PER_SEC);
> +	efi_rt_call(reset_system, EFI_RESET_COLD, EFI_ABORTED, 0, NULL);
> +}

[Severity: Medium]
Is args correctly passed to efi_printk() here?

efi_printk() is a variadic function rather than a vprintf-style function.
Passing a va_list directly to it as the first argument will cause it to
interpret the va_list structure itself as the format argument, which prints
garbage memory values instead of the actual error codes.

> diff --git a/drivers/firmware/efi/libstub/x86-efi-mshv.c b/drivers/firmwa=
re/efi/libstub/x86-efi-mshv.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/x86-efi-mshv.c
[ ... ]
> +efi_status_t mshv_efi_setup(struct boot_params *boot_params)
> +{
[ ... ]
> +	for (i =3D 0, nr_ranges =3D 0; i < nr_desc; i++) {
[ ... ]
> +		mshv_range->name =3D "Hypervisor Code and Data";
> +		mshv_range->flags =3D IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> +		mshv_range->start =3D d->phys_addr;
> +		mshv_range->end =3D d->phys_addr + (d->num_pages << PAGE_SHIFT) - 1;
> +
> +		prev =3D mshv_range++;
> +		nr_ranges++;
[ ... ]
> +	}
> +
> +	status =3D mshv_populate_ranges(boot_params, mem_map, map_sz, desc_sz);

[Severity: High]
Does this pass the unmerged EFI memory map to the command line?

The code successfully merges adjacent EFI descriptors into the mshv_reserved
array above, but then passes the raw, unmerged mem_map array into
mshv_populate_ranges().

Since mshv_efi_update_cmdline() serializes every descriptor, could this
exceed the 32-range limit (HV_MAX_RESVD_RANGES) in hv_parse_hyperv_resvd_ne=
w()
if the unmerged map is highly fragmented, causing the kernel to silently
drop the remaining ranges?

> +	if (status !=3D EFI_SUCCESS)
> +		mshv_efi_reboot("failed to update command line with code %d",
> +				status);
> +
> +	/* Build an indirect setup_data for each mshv reserved range. */
> +	status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +			     nr_ranges * sizeof(struct mshv_setup_data),
> +				(void **)&sd_block);
> +	if (status !=3D EFI_SUCCESS)
> +		mshv_efi_reboot("failed to allocate space for hv ranges: error code %d=
", status);
[ ... ]
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		start =3D mshv_reserved[i].start;
> +		end =3D mshv_reserved[i].end;
> +
> +		sd_block[i].sd.type =3D SETUP_INDIRECT;
> +		sd_block[i].sd.len  =3D sizeof(struct setup_indirect);
> +		sd_block[i].sd.next =3D (__u64)&sd_block[i + 1];
> +
> +		sd_block[i].si.type =3D SETUP_MSHV;
> +		sd_block[i].si.reserved =3D 0;
> +		sd_block[i].si.len =3D end - start + 1;
> +		sd_block[i].si.addr =3D start;
> +	}

[Severity: Low]
Is the SETUP_MSHV data parsed by the kernel later?

The stub builds a SETUP_INDIRECT chain wrapping SETUP_MSHV elements, but it
doesn't look like there is any logic added in the kernel to parse SETUP_MSH=
V.
Does this leave unused structures in boot memory?

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac6167891..ab301dd602fbc 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
[ ... ]
> +static int __init hv_parse_hyperv_resvd_new(char *arg)
> +{
> +	int i =3D 0;
> +
> +	if (is_kdump_kernel())
> +		return 0;
> +
> +	while (arg && *arg) {
> +		unsigned long long region_start, region_sz;
> +		char *range, *addr_str;
[ ... ]
> +		if (kstrtoull(range, 16, &region_sz) || !region_sz ||
> +		    kstrtoull(addr_str, 16, &region_start) || !region_start) {

[Severity: High]
Does the !region_start check reject physical address 0?

If the hypervisor reserves a range starting at the beginning of physical
address space (page 0), region_start will be 0. This check will treat it
as a validation failure and break out of the parsing loop.

> +			pr_err("Hyper-V: invalid format for hyperv_resvd_new\n");
> +			break;
> +		}
> +
> +		memblock_reserve(region_start, region_sz);
> +
> +		hv_mshv_res[i].name =3D "Hypervisor Code and Data";
> +		hv_mshv_res[i].flags =3D IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> +		hv_mshv_res[i].start =3D region_start;
> +		hv_mshv_res[i].end =3D region_start + region_sz - 1;
> +
> +		++i;
> +	}
> +
> +	ranges_nr =3D i;
> +
> +	return 0;
> +}
> +early_param("hyperv_resvd_new", hv_parse_hyperv_resvd_new);
[ ... ]
> +void __init hv_mark_resources(void)
> +{
> +	int i, max =3D ARRAY_SIZE(hv_mshv_res);
> +
> +	for (i =3D 0; i < max && hv_mshv_res[i].end; i++)

[Severity: Medium]
Can stale entries in hv_mshv_res be read during resource marking?

If hv_parse_hyperv_resvd_new() is invoked multiple times (e.g. appended by
bootloader and supplied by user), the local index i resets to 0, overwriting
the head of hv_mshv_res without clearing the tail.

Because hv_mark_resources() iterates until hv_mshv_res[i].end =3D=3D 0 rath=
er
than using ranges_nr, it will process the remaining stale tail entries from
the previous parse.

> +		insert_resource(&iomem_resource, &hv_mshv_res[i]);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D12
