Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5135677E
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119773; cv=none; b=EzRwIDL0ykCYWBE/OGxy3p/ev50wQWjr6Z/Ufmrx+3gbfd1HxEmbFejnAUQos2UaygoVcjE+ePotlSmt4jqcCsmvPNqKLfVAmn5g4Bc0RbHvaFVAcK0bUXK7Nwza8iKYtKKeIOAMuQwN0cBX0QGrwS9nTHyIR/TuCy69Srz6gKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119773; c=relaxed/simple;
	bh=31omDzfaWGwEAeLokdBCNMhf3N5B6aigjBMhTH19rrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ckYOCut97Gcl1vpU/I0krnvrjd72bhgzXldAYR39gPhBnk/JGfsehcIm8YrmL6S1GF+XAzcO797y7BvY0+sN+7QFMDZtqzkXBTzvCBEpASoHuhTUOph5Qkik64R1HqZqsVQCuUqaKiNVY4xILwIoHO+b3y6I3oPnyF0pwZI/+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2SXdRYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2SXdRYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4577C1F000E9;
	Fri,  7 Aug 2026 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119771;
	bh=8cUl61MZKgsCDLLGbvw1n+RhIP1cedVW6GgLzPwWHEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U2SXdRYByKcwed31Xl9l6t9jYpp8PwYQEj0aD6GoDso14HpfMYiJS5OkvX61fujlW
	 VlL7vzmnNYl1Uk62C05l36DjIPaRBtiOGvpKvjSIvs7iRUx8zcMet/1VFJlvKjGiGs
	 u2SmoFpJzDwQPRbJRfRqhexVka2Lf4a9ILP0KzVsbbJdS1OJXN1KN9EJYWwmWXawtA
	 gbIs2V1C8dRN6ANc1ad25hNCSgFQP8cEVWW7FoeJyjwcu+DFQPnDks8WUItpUe5JZe
	 SOonp8smQcnA4GCp96uNEhbGsJ4cVEqAcdtoRZ539FFkfoMqz2zgqA0fTNFmL2bWd9
	 hvlkhs7U3MSOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/13] hyperv: add MSHV Dom0 root-partition boot
 enablement (EFI HvLoader)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-13-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-13-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:22:50 +0000
Message-Id: <20260807162251.4577C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] The x86 EFI stub stores the command line in a `.bss` static bu=
ffer which is wiped by the kernel decompressor.
- [High] Unconditional increment of `cmdline_len` with `snprintf` return va=
lue leads to buffer overflow.
- [High] Incorrect linked list traversal causes truncation of the existing =
`setup_data` chain.
- [Medium] Missing NULL pointer check before calling `strlen` on the comman=
d line.
- [Medium] Skipping invalid e820 indices leaves uninitialized holes in `hv_=
mshv_res`, breaking resource registration.
- [Medium] MSHV root partition boot enablement is completely unreachable on=
 ARM64.
- [Low] Memory leak of `mshv_reserved` array in x86 EFI stub.
- [Low] Memory leak of `mem_map` in ARM64 EFI stub.
- [Low] Parsing error in `hyperv_resvd_new` bypasses state updates, silenci=
ng previous valid ranges.
--

--- Patch [12]: [PATCH v1 12/13] hyperv: add MSHV Dom0 root-partition boot =
enablement (EFI HvLoader) ---
commit fcbf57de7557f7a5bf335c4003de65861d33a7c5
Author: Wei Hu <weh@microsoft.com>

hyperv: add MSHV Dom0 root-partition boot enablement (EFI HvLoader)

This commit ports the EFI HvLoader protocol handshake and the hyperv_resvd_=
new
memory reservation. It provides the Linux-side enablement necessary to boot=
 an
upstream kernel as a Microsoft Hypervisor (MSHV) root partition.

> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
[ ... ]
> @@ -496,6 +499,75 @@ EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
> +static void __init hv_resv_mshv_memory(void)
> +{
> +	u64 start, end, size;
> +	int i, idx, max =3D ARRAY_SIZE(hv_resvd_ranges);
> +
> +	for (i =3D 0; i < max && hv_resvd_ranges[i] !=3D -1; i++) {
> +		idx =3D hv_resvd_ranges[i];
> +		if (idx < 0 || idx >=3D e820_table->nr_entries) {
> +			pr_info("Hyper-V: invalid resvd idx %d\n", idx);
> +			continue;

[Severity: Medium]
Does skipping the invalid index here leave the hv_mshv_res array
zero-initialized for this slot?

Later on, hv_mark_resources() iterates over this array using:
    for (i =3D 0; i < max && hv_mshv_res[i].end; i++)

Could this cause the registration loop to terminate prematurely when it hits
the hole, silently dropping all subsequent valid memory ranges?

> +		}
> +
> +		start =3D e820_table->entries[idx].addr;

> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/arm64-efi-mshv.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <asm/efi.h>
> +#include <asm/setup.h>
> +
> +#include "efistub.h"
> +#include "efi-mshv.h"
> +
> +efi_status_t mshv_efi_setup(char **cmdline_ptr)
> +{

[Severity: Medium]
Is this function ever invoked? It appears to be defined here but never hook=
ed
into the ARM64 EFI stub entry point, making the ARM64 MSHV boot enablement
unreachable code.

> +	efi_status_t status;
> +	efi_memory_desc_t *mem_map;
> +	unsigned long map_sz, desc_sz, new_cmdline_addr;
> +
> +	status =3D mshv_efi_init();
> +	if (status =3D=3D EFI_NOT_FOUND) // we are in a standard Linux boot
> +		return EFI_SUCCESS;
> +
> +	map_sz =3D 0;
> +	mshv_get_hv_ranges((void *)&mem_map, &map_sz, &desc_sz);
> +
> +	status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA, COMMAND_LINE_SIZ=
E,
> +			     (void **)&new_cmdline_addr);

[Severity: Low]
Does this code leak the mem_map pool allocation? Unlike the x86 implementat=
ion
in this patch, it doesn't appear to be freed before returning EFI_SUCCESS.

> +	if (status !=3D EFI_SUCCESS)

> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/efi-mshv-common.c
[ ... ]
> +void mshv_efi_update_cmdline(efi_memory_desc_t *mem_map,
> +			     unsigned long map_sz, unsigned long desc_sz, char *old_cmdline,
> +		char *buf, unsigned long buf_sz)
> +{
> +	int i, cmdline_len, nr_desc;
> +
> +	cmdline_len =3D strlen(old_cmdline);

[Severity: Medium]
Can old_cmdline be NULL if the kernel is booted without a command line?
If so, passing it directly to strlen() would lead to a NULL pointer
dereference.

> +	memcpy(buf, old_cmdline, cmdline_len + 1);
> +
> +	cmdline_len +=3D snprintf(buf + cmdline_len,
> +				buf_sz - cmdline_len,
> +				" hyperv_resvd_new=3D");
> +
> +	nr_desc =3D map_sz / desc_sz;
> +	for (i =3D 0; i < nr_desc; ++i) {
> +		efi_memory_desc_t *d;
> +		u64 start, end, sz;
> +
> +		d =3D efi_memdesc_ptr(mem_map, desc_sz, i);
> +		start =3D d->phys_addr;
> +		sz =3D d->num_pages << PAGE_SHIFT;
> +		end =3D start + sz - 1;
> +
> +		cmdline_len +=3D snprintf(buf + cmdline_len,
> +					buf_sz - cmdline_len,
> +					"%s0x%llx!0x%llx", i > 0 ? "," : "",
> +					sz, start);

[Severity: High]
Could this result in a buffer overflow?

If the appended string exceeds buf_sz, snprintf returns the number of
characters that would have been written, not the number actually written.=20
Adding this value to cmdline_len could cause buf_sz - cmdline_len to underf=
low
into a very large unsigned integer.

Will the next loop iteration then write out of bounds via buf + cmdline_len?

> +	}

> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/x86-efi-mshv.c
[ ... ]
> +static efi_status_t mshv_populate_ranges(struct boot_params *boot_params,
> +					 efi_memory_desc_t *mem_map, unsigned long map_sz,
> +			unsigned long desc_sz)
> +{
> +	unsigned long cmdline_ptr;
> +	u32 cmdline_size;
> +	static u8 mshv_cmdline[COMMAND_LINE_SIZE];

[Severity: Critical]
Will this static buffer be placed in the .bss segment and subsequently
destroyed?

When the EFI stub hands over control to the kernel decompressor
(e.g. startup_64), the decompressor zeroes its .bss segment before the comm=
and
line is parsed. Using a static buffer here might cause the entire kernel
command line to be lost.

> +
> +	memset(mshv_cmdline, 0, sizeof(mshv_cmdline));
> +
> +	cmdline_ptr =3D boot_params->hdr.cmd_line_ptr;
> +	cmdline_ptr |=3D (u64)boot_params->ext_cmd_line_ptr << 32;
> +	cmdline_size =3D boot_params->hdr.cmdline_size;
> +
> +	mshv_efi_update_cmdline(mem_map, map_sz, desc_sz,
> +				(char *)cmdline_ptr,
> +				(char *)mshv_cmdline, COMMAND_LINE_SIZE);
> +
> +	boot_params->hdr.cmd_line_ptr =3D (u32)((unsigned long)mshv_cmdline);
[ ... ]
> +efi_status_t mshv_efi_setup(struct boot_params *boot_params)
> +{
[ ... ]
> +	/*
> +	 * Build an array of kernel 'struct resource' objects that contain mshv
> +	 * reserved ranges. This array is populated via a command line parameter
> +	 * called 'hyperv_resvd_new'.
> +	 */
> +
> +	status =3D mshv_realloc_ranges(&mshv_reserved,
> +				     &mshv_reserved_sz,
> +				MSHV_RESERVED_RANGES_COUNT);

[Severity: Low]
Does this code leak the mshv_reserved array memory? It is dynamically
allocated here and possibly reallocated during the loop, but it doesn't app=
ear
to be freed at the end of the function.

[ ... ]
> +	setup_data_itr =3D (struct setup_data **)&boot_params->hdr.setup_data;
> +
> +	while (*setup_data_itr && (*setup_data_itr)->next)
> +		setup_data_itr =3D (struct setup_data **)&(*setup_data_itr)->next;
> +
> +	*setup_data_itr =3D (struct setup_data *)sd_block;

[Severity: High]
Does this loop terminate one node early?

Because it checks (*setup_data_itr)->next in the while condition, it exits
when pointing to the last node. Overwriting *setup_data_itr here seems to
overwrite the pointer to the last element rather than appending to it, which
could drop critical boot parameters passed by the bootloader.

> +
> +	for (i =3D 0; i < nr_ranges; i++) {

> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
[ ... ]
> @@ -863,3 +867,81 @@ const char *hv_result_to_string(u64 status)
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
> +
> +		if (i >=3D HV_MAX_RESVD_RANGES) {
> +			pr_err("Hyper-V: too many hyperv_resvd_new ranges specified\n");
> +			return 0;
> +		}
> +
> +		/* Each range is "<size>!<address>", ranges separated by ','. */
> +		range =3D strsep(&arg, ",");
> +		addr_str =3D strchr(range, '!');
> +		if (!addr_str) {
> +			pr_err("Hyper-V: invalid format for hyperv_resvd_new: %s\n", range);
> +			return 0;

[Severity: Low]
If an invalid format is encountered, does this early return bypass updating
the global ranges_nr counter?

By returning early instead of breaking the loop, ranges_nr =3D i is skipped,
which might cause any previously parsed valid memory ranges to be silently
ignored by hv_dump_mshv_memory() later.

> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D12
