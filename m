Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5326059D;
	Sat, 18 Jul 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342003; cv=none; b=K1s0gRV/5+L+F47/f/DBRtx58sQrK74s152pi0sYq7YwT420sWfx8uKC1vdEDaSFsTopKYejfWkxXbYCx8kBRzZjhLZ6BvFLH5XvTPXb9uBZcIQWhjLBrla70zvlz4rGuOKJs3dhb4PTvKdrqxNWovJ0N8cQI2hLNBs9zjFcWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342003; c=relaxed/simple;
	bh=8zdAMDMd4MACp2GOXsnC+cg/ApU4dPV35GG3zBOks9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/Pp3WblRzqgA7bffulIdx476ERDbAADMBXHJyY0Zy2P5jk/WcVQEFHHLUBdqHMpk1GtEQiVZtGRhog0PkYoEwY9Egcv6u+ckgv1k4WkwTMHJUFyFMGI6rfuWgwGi4S1e/gGlZZvsSURU2E0HnRrdV5JBPstEDxUsbA5J54gHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciRysw+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciRysw+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F11F000E9;
	Sat, 18 Jul 2026 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784342001;
	bh=Cdo1evD16ZHaVPub5vZm6+yRFJuw+c8JVGhJnL9gQcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciRysw+Z9FOsqYANjZXGsqPdeWDT1E2KLq9LvD2JPRtpd1rOub7rePDWnY8DzZXae
	 kebmde4abzPDhIJsSZMeupsZjWDzNnpv3o4fAhN9OHhqgCAh0uA+kC/jYOLy5PNGle
	 F64iRtWTTer6syYd1qiUof+BAEoc7tsJ0/tOvzwnaAhJD6BRDS0A6DJ+g/q3rnE2Cj
	 WnAuODxk5+bb2jqHPOP+KBtAwSKRva1zLP6Ye/YeCg/9OdHwkgiyAk1YFRUYVcBZAO
	 4bQY2nvBuRKRNWWlfRNk/YfUH6phTMmYSJEtKrHLQ705neThRN9tvyeVO2CYVnb5gA
	 iqwCRCOeU9fEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 8/9] mshv: Populate mmio mappings for PCI passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-9-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-9-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:33:21 +0000
Message-Id: <20260718023321.925F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] hv_map_mmio_pages extrapolates the physical base address for a=
n entire MMIO region from a single page fault, allowing unauthorized arbitr=
ary physical memory access.
- [High] Flawed alignment logic allows mapping unaligned addresses as 2M la=
rge pages and fails to iterate the physical frame variable.
- [High] Unconditional use of FAULT_FLAG_WRITE in mshv_chk_get_mmio_start_p=
fn breaks read-only MMIO mappings.
- [High] Missing cleanup of partial mappings in hv_map_mmio_pages on failur=
e.
- [High] Resolving user space PFNs without synchronizing with MMU notifiers=
 introduces a TOCTOU race.

Pre-existing issues:
- [Critical] Guest MMIO mappings are never torn down when host userspace un=
maps the VMA or detaches the device.
- [High] Synchronous, unbounded loop over page_is_ram for the entire region=
 size can cause soft lockups.
- [High] Error handling rollback in hv_do_map_gpa_hcall fails to unmap page=
s due to a mismatched page count unit.
--

--- Patch [8]: [PATCH V4 8/9] mshv: Populate mmio mappings for PCI passthru=
 ---
commit 65da49ecfde6e092de4c941dffc7d00deae59b78
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Populate mmio mappings for PCI passthru

This commit handles unmapped GPA intercepts by resolving the PCI resource
pfn for a guest gpa and dynamically asking the hypervisor to map it via
hypercalls. It attempts to use 2M page sizes where possible and removes
the old vma->vm_pgoff mapping approach.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
[ ... ]
> @@ -189,31 +189,33 @@ int hv_call_delete_partition(u64 partition_id)
>  }
> =20
>  /* Ask the hypervisor to map guest ram pages or the guest mmio space */
> -static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
> -			       u32 flags, struct page **pages, u64 mmio_spa)
> +static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_count,
> +			       u32 flags, struct page **pages, u64 mmio_mfn)
>  {
>  	struct hv_input_map_gpa_pages *input_page;
>  	u64 status, *pfnlist;
>  	unsigned long irq_flags, large_shift =3D 0;
> -	int ret =3D 0, done =3D 0;
> -	u64 page_count =3D page_struct_count;
> -
> -	if (page_count =3D=3D 0 || (pages && mmio_spa))
> -		return -EINVAL;
> +	int i, ret =3D 0, done =3D 0;
> +	u64 adj_page_count =3D page_count;
> =20
> -	if (flags & HV_MAP_GPA_LARGE_PAGE) {
> -		if (mmio_spa)
> +	if (mmio_mfn) {
> +		if (pages)
>  			return -EINVAL;
> +		for (i =3D 0; i < page_count; i++)
> +			if (page_is_ram(mmio_mfn + i))
> +				return -EINVAL;

[Severity: High]
This is a pre-existing issue, but could this synchronous loop cause soft
lockups?

If a user maps a multi-gigabyte MMIO region (like a large GPU BAR), this
loops page_count times calling page_is_ram() synchronously for every 4KB
page without preemption, which could trigger kernel soft lockup watchdogs.

[ ... ]
>  		} else if (!hv_result_success(status)) {
> +			pr_err("%s: failed to map pages at gfn %#llx: completed %u/%llu, flag=
s=3D%#x, status=3D%#llx (%s)\n",
> +			       __func__, gfn, done, page_count, flags, status,
> +			       hv_result_to_string(hv_result(status)));
>  			ret =3D hv_result_to_errno(status);
>  			break;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does the error rollback at
the end of hv_do_map_gpa_hcall() pass the wrong unit to
hv_call_unmap_gpa_pages()?

If an error occurs during mapping and HV_MAP_GPA_LARGE_PAGE is set, "done"
contains the number of mapped 2M pages. This is passed to
hv_call_unmap_gpa_pages(), which expects a 4K page count:

hv_do_map_gpa_hcall() {
    ...
    if (ret && done) {
        u32 unmap_flags =3D 0;
        if (flags & HV_MAP_GPA_LARGE_PAGE)
            unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
        hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
    }
}

Since hv_call_unmap_gpa_pages() expects 4K pages, it evaluates
!HV_PAGE_COUNT_2M_ALIGNED(done), which fails for small integers and aborts
with -EINVAL, leaking the memory mappings in the hypervisor's page tables.

[ ... ]
> -/* Ask the hypervisor to map guest mmio space */
> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs)
> +/*
> + * Ask the hypervisor to map guest mmio space. Don't set HV_MAP_GPA_NOT_=
CACHED
> + * in hcall flags for slightly better performance, and in that case the =
guest
> + * stage 1 page table will control caching.
> + */
> +int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg, u64=
 gfn,
> +		      u64 mmio_mfn)
>  {
> -	int i;
> -	u32 flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
> -		    HV_MAP_GPA_NOT_CACHED;
> +	int rc;
> +	u32 flags =3D HV_MAP_GPA_READABLE;
> +	u64 hpages, numpgs, numpgs_in_hpage =3D HPAGE_SIZE / PAGE_SIZE;
> +
> +	if (reg->hv_map_flags & HV_MAP_GPA_WRITABLE)
> +		flags |=3D HV_MAP_GPA_WRITABLE;
> +	if (reg->hv_map_flags & HV_MAP_GPA_EXECUTABLE)
> +		flags |=3D HV_MAP_GPA_EXECUTABLE;
> +
> +	mmio_mfn =3D mmio_mfn - (gfn - reg->start_gfn);	/* start of the range */

[Severity: Critical]
Does extrapolating the physical base address from a single page fault allow
mapping arbitrary physical memory?

If a user creates a large MSHV region backed by a sparse or smaller VM_PFNM=
AP
VMA, mshv_handle_unmapped_gpa() resolves a single PFN. This extrapolation t=
hen
calculates the base PFN for the entire region and maps reg->nr_pages of
contiguous physical memory into the guest. This would map the holes or
unrelated physical memory (like other devices' MSI-X tables or kernel RAM),
bypassing VFIO's memory protections.

> +
> +	numpgs =3D 0;
> +	gfn =3D reg->start_gfn;
> +	while (!HV_PAGE_COUNT_2M_ALIGNED(gfn) &&
> +	       !HV_PAGE_COUNT_2M_ALIGNED(mmio_mfn) &&
> +	       numpgs < reg->nr_pages) {
> +		numpgs++;
> +		gfn++;
> +	}

[Severity: High]
Does this loop condition prematurely exit, and are we failing to iterate
mmio_mfn?

If gfn and mmio_mfn have different 2M offsets, the logical AND causes the l=
oop
to exit as soon as one of them is aligned. Furthermore, mmio_mfn is never
incremented inside this loop, which leaves it misaligned when it is later
passed to the large page mapping request.

> +
> +	if (numpgs) {
> +		rc =3D hv_do_map_gpa_hcall(partition_id, reg->start_gfn, numpgs,
> +					 flags, NULL, mmio_mfn);
> +		if (rc || numpgs =3D=3D reg->nr_pages)
> +			return rc;
> +	}
> +
> +	mmio_mfn =3D mmio_mfn + numpgs;
> +	numpgs =3D reg->nr_pages - numpgs;
> +
> +	if (numpgs < numpgs_in_hpage)
> +		return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags,
> +					   NULL, mmio_mfn);
> +
> +	for (hpages =3D 0; numpgs >=3D numpgs_in_hpage;) {
> +		hpages++;
> +		numpgs =3D numpgs - numpgs_in_hpage;
> +	}
> +	rc =3D hv_do_map_gpa_hcall(partition_id, gfn, hpages * numpgs_in_hpage,
> +				 flags | HV_MAP_GPA_LARGE_PAGE, NULL, mmio_mfn);
> +	if (rc)
> +		return rc;

[Severity: High]
Are we leaking partial mappings here if the hypercall batch fails?

If the initial batch of 4K pages succeeds but this second batch for 2M pages
fails, the function returns the error code directly. This skips cleaning up
the pages mapped during the first hv_do_map_gpa_hcall(), leaking those
mappings in the hypervisor.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> +static int mshv_chk_get_mmio_start_pfn(u64 uaddr, u64 *mmio_pfnp)
> +{
> +	struct vm_area_struct *vma;
> +	bool is_mmio;
> +	struct follow_pfnmap_args pfnmap_args;
> +	int rc =3D -EINVAL;
> +
> +	mmap_read_lock(current->mm);
> +	vma =3D vma_lookup(current->mm, uaddr);
> +	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> +	if (!is_mmio)
> +		goto unlock_mmap_out;
> +
> +	pfnmap_args.vma =3D vma;
> +	pfnmap_args.address =3D uaddr;
> +
> +	rc =3D follow_pfnmap_start(&pfnmap_args);
> +	if (rc) {
> +		rc =3D fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
> +				      NULL);

[Severity: High]
Does this unconditional use of FAULT_FLAG_WRITE break read-only MMIO
mappings?

When resolving an unmapped GPA intercept for a read-only VMA, the
fixup_user_fault() call will fail with -EFAULT because the VMA lacks write
permissions, completely denying the guest access to read-only MMIO regions.

> +		if (rc)
> +			goto unlock_mmap_out;
> +
> +		rc =3D follow_pfnmap_start(&pfnmap_args);
> +		if (rc)
> +			goto unlock_mmap_out;
> +	}
> +
> +	*mmio_pfnp =3D pfnmap_args.pfn;
> +	follow_pfnmap_end(&pfnmap_args);
> +
> +unlock_mmap_out:
> +	mmap_read_unlock(current->mm);
> +	return rc;
> +}
> +
> +/*
> + * Check if the unmapped gpa belongs to mmio space. If yes, resolve it.
> + *
> + * Returns: True if valid mmio intercept and handled, else false.
> + */
> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
> +{
[ ... ]
> +	rc =3D mshv_chk_get_mmio_start_pfn(uaddr, &mmio_mfn);
> +	if (rc)
> +		goto put_rg_out;
> +
> +	rc =3D hv_map_mmio_pages(pt->pt_id, rg, gfn, mmio_mfn);

[Severity: High]
Is there a TOCTOU race here when mapping the resolved PFN?

mshv_chk_get_mmio_start_pfn() resolves the PFN and drops mmap_read_lock
before returning. There is no synchronization with the MMU interval notifier
sequence lock prior to calling hv_map_mmio_pages(). If the VMA is unmapped
concurrently after the lock is dropped, could the hypervisor map a stale or
freed PFN into the guest?

[ ... ]
> @@ -1376,11 +1449,7 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  					    region->nr_pages,
>  					    HV_MAP_GPA_NO_ACCESS, NULL);
>  		break;
> -	case MSHV_REGION_TYPE_MMIO:
> -		ret =3D hv_call_map_mmio_pages(partition->pt_id,
> -					     region->start_gfn,
> -					     mmio_pfn,
> -					     region->nr_pages);
> +	default:
>  		break;
>  	}

[Severity: Critical]
This is a pre-existing issue, but are guest MMIO mappings ever torn down
when host userspace unmaps the VMA or detaches the device?

Because MMIO regions fall into the default case, they skip
mshv_prepare_pinned_region() and do not register MMU interval notifiers.
When the host userspace calls munmap() on the VFIO region or the device is
detached, the guest's stage-2 page tables are never invalidated, leaving the
guest with arbitrary access to reassigned physical memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D8
