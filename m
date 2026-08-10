Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606121A42D
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366743; cv=none; b=GNvnCRpfRuen3NsXZ/V5sUl408R5PVpWY6Q4dPshjxBUSinNgZlM/d/PNUBmOn6IBdtxmNj6X5GZgqmdr15I8vwIjcpnjelv3ZpH5zix82MGPlloLYARWvkK7bTkOMrpFwAW+pA7Tu9tg4XjcFpGAmYxNnALfVzOcaLrjLLuAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366743; c=relaxed/simple;
	bh=vJh4g36+TLpk8g6Uwo4IorDoNr3oKx1/60rS2gCeF1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDKUuC9ABe4++z5QewhQdcVQ6ubTiklh4n+P1ca+/DzPjCB/Tk3OMQNYqdYqxBBxF7PbNyQl9b9XNftJlw7FeRDBRFvB1IkHnpfAsVcvFFsOOXdegcC58S1nhkahXfd0v64txG19ttLtuuaVpHnrAg/xACTvsJxqfGkBTGj9hrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5AWHwJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5AWHwJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886001F000E9;
	Mon, 10 Aug 2026 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366741;
	bh=UzLc60sPUgbkHrYZFLbhkVPqQZXgfT/r8rR6JXOdNzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5AWHwJpYIHToft37ERhpdFFrxWuNNgayntW5X0vvXHRVtIVbxHLvOIYAZOutD1ar
	 6OA1rSrrpU2mf8ewuQt93pgtu1VdmbZ8+Vqn6qMeE/nsJRscUjbWpOS89OVSIBLIqs
	 j3MAc3bvitHCD71uLLMc7ubcgx/rSlyn/RTsNti/1sz4PjXVd1qF2Hke1Z0z58Li5X
	 jldEDGG17arOKWCqhFqxpSUpAVWkb6We1/KCgHIUfahzPkA2Sjw2v50xBK2R+ho/yx
	 npmExH64m8E1JpPcvOEW/aLiy5yRL9HGUCjBe80VTA2vkXB5S8lKN5UayfFaXP+DOo
	 0wGFqweugCF0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] mshv: add SEV-SNP UAPI definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-2-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-2-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:59:01 +0000
Message-Id: <20260810125901.886001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The UAPI header uses C bitfields in `union mshv_snp_guest_policy`,=
 violating Linux UAPI design guidelines and risking ABI instability.
- [High] Massively oversized ioctl argument passed by value (3.3 KB), riski=
ng kernel stack overflow.
- [High] Structures embed flexible array members (`guest_pfns[]`) but are p=
assed by value in `_IOW` macros, concealing the true payload size from audi=
t tools.
- [Medium] UAPI structs use `__attribute__((packed))` without natural align=
ment padding, resulting in unaligned boundaries.
- [Medium] Missing `page_size` field in the UAPI struct `mshv_import_isolat=
ed_pages`.
--

--- Patch [1]: [PATCH v2 01/13] mshv: add SEV-SNP UAPI definitions ---
commit c9fecd1e92fbda950177d18a68754c3dabf290f1
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP UAPI definitions

Add the MSHV UAPI and Hyper-V ABI definitions needed by the SEV-SNP
partition ioctls: the SNP isolation type, GPA host-access and
isolated-page request structures, PSP request structures, and the SEV
control register definitions.

Also add the SNP launch-data definitions (guest policy, ID block, ID
auth info and launch-finish data) that form the isolated-import
completion parameters, along with the SNP support-status enumeration.

> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 0c89c62c97067..691ac495a095d 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h

[ ... ]

> @@ -953,4 +953,49 @@ struct hv_input_modify_sparse_spa_page_host_access {
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
> =20
> +enum hv_isolated_page_type {
> +	HV_ISOLATED_PAGE_TYPE_NORMAL,
> +	HV_ISOLATED_PAGE_TYPE_VMSA,
> +	HV_ISOLATED_PAGE_TYPE_ZERO,
> +	HV_ISOLATED_PAGE_TYPE_UNMEASURED,
> +	HV_ISOLATED_PAGE_TYPE_SECRETS,
> +	HV_ISOLATED_PAGE_TYPE_CPUID,
> +	HV_ISOLATED_PAGE_TYPE_COUNT
> +};
> +
> +enum hv_isolated_page_size {
> +	HV_ISOLATED_PAGE_SIZE_4KB,
> +	HV_ISOLATED_PAGE_SIZE_2MB
> +};
> +
> +struct hv_input_import_isolated_pages {
> +	u64 partition_id;
> +	u32 page_type;
> +	u32 page_size;
> +	u64 page_number[];
> +} __packed;

[ ... ]

> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b2..fc89f6c9a968f 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h

[ ... ]

> +struct mshv_modify_gpa_host_access {
> +	__u8 flags;
> +	__u8 rsvd[7];
> +	__u64 page_count;
> +	__u64 guest_pfns[];
> +};

[ ... ]

> +struct mshv_import_isolated_pages {
> +	__u8 page_type;
> +	__u8 rsvd[7];
> +	__u64 page_count;
> +	__u64 guest_pfns[];
> +};

[Severity: Medium]
Will this user-facing structure limit the ability to import 2MB pages?

The underlying kernel hypercall structure hv_input_import_isolated_pages
supports both a page_type and a page_size. By shrinking page_type to a __u8
and omitting page_size in mshv_import_isolated_pages, is the ABI locked into
a single default page size?

[ ... ]

> +union mshv_snp_guest_policy {
> +	struct {
> +		__u64 minor_version : 8;
> +		__u64 major_version : 8;
> +		__u64 smt_allowed : 1;
> +		__u64 vmpls_required : 1;
> +		__u64 migration_agent_allowed : 1;
> +		__u64 debug_allowed : 1;
> +		__u64 reserved : 44;
> +	} __attribute__((packed));
> +	__u64 as_uint64;
> +};

[Severity: High]
Could these bitfields introduce ABI instability by exposing compiler-depend=
ent
layouts to userspace?

Bitfield memory layout and packing order can vary depending on the compiler,
its flags, and the architecture. Might this cause critical security policy
flags like debug_allowed to be misinterpreted by the kernel or hypervisor if
userspace is compiled differently?

[ ... ]

> +struct mshv_psp_launch_finish_data {
> +	struct mshv_snp_id_block id_block;
> +	struct mshv_snp_id_auth_info id_auth_info;
> +	__u8 host_data[32];
> +	__u8 id_block_enabled;
> +	__u8 author_key_enabled;
> +} __attribute__((packed));

[Severity: Medium]
Does using __attribute__((packed)) here create unaligned boundaries?

This strips natural alignment from the UAPI structures, creating arbitrary
sizes that are not multiples of their largest member's alignment. Could this
force unaligned accesses if pointers are cast or structures are arrayed in
userspace code?

[ ... ]

> +struct mshv_complete_isolated_import {
> +	union mshv_partition_complete_isolated_import_data import_data;
> +};
> +
>  /**
>   * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
>   * @code: Hypercall code (HVCALL_*)

[ ... ]

> @@ -254,6 +350,11 @@ struct mshv_root_hvcall {
>  #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_=
gpap_access_bitmap)
>  /* Generic hypercall */
>  #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcal=
l)
> +#define MSHV_MODIFY_GPA_HOST_ACCESS	_IOW(MSHV_IOCTL, 0x09, struct mshv_m=
odify_gpa_host_access)
> +#define MSHV_IMPORT_ISOLATED_PAGES	_IOW(MSHV_IOCTL, 0x0A, struct mshv_im=
port_isolated_pages)

[Severity: High]
Does encoding flexible array structures in _IOW macros conceal the true
payload size from audit tools?

The _IOC_SIZE encoded in the resulting ioctl command number will only
represent the size of the fixed headers. Standard tools like strace, seccom=
p,
or eBPF that rely on _IOC_SIZE might truncate the memory access to just the
header and miss the variable-length guest_pfns arrays.

Should these UAPI structures use a userspace pointer for the variable-length
arrays instead?

> +#define MSHV_COMPLETE_ISOLATED_IMPORT	_IOW(MSHV_IOCTL, 0xF4, struct mshv=
_complete_isolated_import)

[Severity: High]
Does passing struct mshv_complete_isolated_import by value risk overflowing
the kernel stack?

This structure is approximately 3.3 KB in size. Pressure on standard ioctl
paths might encourage allocating this buffer on the kernel stack, which cou=
ld
trigger a stack overflow on systems with small stacks.

Would it be better to pass large payloads via a pointer in the ioctl
structure instead of directly passing them by value?

> +#define MSHV_ISSUE_PSP_GUEST_REQUEST	_IOW(MSHV_IOCTL, 0xF5, struct mshv_=
issue_psp_guest_request)
> +#define MSHV_SEV_SNP_AP_CREATE		_IOW(MSHV_IOCTL, 0xF6, struct mshv_sev_s=
np_ap_create)
> =20
>  /*
>   ********************************

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D1
