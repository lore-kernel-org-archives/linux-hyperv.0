Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5A48987C;
	Fri, 31 Jul 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538452; cv=none; b=aHQudw3kxaB3AsKBqvjpFPYFGvxJjiyn1+JXEKilNnubxyS6ZKSMrWGCXrgVA/CLTWJzIYaj2yuictm31UnjUMQFxtZ8pYXrZV9L9xbb6sW6Jclbam/4NEshmoDbp7h8dYJaPCII1wTVfGyiU3X2GlEEKa1uUC4Przx3jpOH1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538452; c=relaxed/simple;
	bh=/CVJrYHKq7FHDpKlgSyPH4m2Afx9DhMTel1pzLJq8wo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0CewPdXjPE3gf+KcMxZbsW8dCgMcvnttiuVv5llvS6lwXcdHZdulsmHviGtyVbMt35ZwPAwjtuU/g4s+7LsSHvrD8binXafYG0xgK91+58f96+faRbqBhUu3J8r/jFrvy+vQXaeQ2fT8ITJqmKogxAQuHk53sr/HS8IZj5r3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj3aiaoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj3aiaoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DB1F00AC4;
	Fri, 31 Jul 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538451;
	bh=cD+j0HaD/KUwXU8mHwHsVgWFUYyRJS7pmrEGgrW8m78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zj3aiaooXHrhXW2Obmkngdvc/wkvIKSPvby2GHGnEJIkKnwyHGn620euo/SBWRXHI
	 RGVQsVqgn3lMeCubvnfiom5k4sTFoCS0YLRMD1Ou7zy2MxpWf4F6Dzq447We2CPrWq
	 HtAyLR4R37pajOKqY4rJGonICxrjlVx2UqBEE+UacQPhKR5u50g5/13u5MvAVqm3mU
	 CTIO2DKxUuAi16DkEgNNL/H7SvTeDseNGfAXvhK0t8U77OvqCh19zIwHxdbHKMaZNZ
	 z/TW0cLMejRxfl3O1+42fvz1tjNRqDi+309JzDR42kOSa4c+Sh4KG4Q78YSu3+UKCN
	 XOE3xFfU1q8cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] mshv: Populate mmio mappings for PCI passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-9-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-9-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:54:10 +0000
Message-Id: <20260731225410.E09DB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] Insecure MMIO region bounds check and PFN extrapolation allows=
 mapping arbitrary host RAM into the guest.
- [Critical] Conflation of Host PFNs with Hyper-V 4KB PFNs causes arbitrary=
 memory mapping on architectures with >4KB pages (ARM64).
- [Critical] Missing MMU interval notifier allows stale physical mappings (=
TOCTOU and Use-After-Unmap).
- [High] Use-After-Free of VMA pointer after dropping mmap_read_lock.
- [High] Alignment check logic error causes hypercall protocol violation fo=
r large pages.
- [High] Overloading `mmio_mfn` with `0` bypasses `page_is_ram()` checks fo=
r PFN 0.

Pre-existing issues:
- [High] Incorrect unit passed to unmap function on error path causes silen=
t resource leak.
- [High] Unbounded O(N) `page_is_ram()` checks in process context cause CPU=
 soft lockups.
--

--- Patch [8]: [PATCH v5 8/9] mshv: Populate mmio mappings for PCI passthru=
 ---
commit ef68862e98379b2ba894e7946e9748f29e46d61f
Author: Mukesh R <mrathor@linux.microsoft.com>
Subject: mshv: Populate mmio mappings for PCI passthru

This commit handles hypervisor unmapped GPA intercepts by resolving the PCI
resource PFN and mapping it via hypercall. It attempts to map 2M pages where
possible to improve performance and removes broken VMA offset code.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e5..4f6eb3a2aed03 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
[ ... ]
> -static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
> -			       u32 flags, struct page **pages, u64 mmio_spa)
> +static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_count,
> +			       u32 flags, struct page **pages, u64 mmio_mfn)
>  {
[ ... ]
> -	if (page_count =3D=3D 0 || (pages && mmio_spa))
> -		return -EINVAL;
> +	if (mmio_mfn) {
> +		if (pages)
>  			return -EINVAL;
> +		for (i =3D 0; i < page_count; i++)
> +			if (page_is_ram(mmio_mfn + i))
> +				return -EINVAL;
> +	}

[Severity: High]
Does this check evaluate to false when a legitimate MMIO region points to
physical PFN 0?

If mmio_mfn is 0, it appears to bypass the page_is_ram() loop entirely. Cou=
ld
this allow a VMM process to map the host's physical RAM page 0 into the gue=
st
as MMIO?

[Severity: High]
This is a pre-existing issue, but does this loop iterate over a potentially
massive number of pages without yielding?

Since page_count is derived from the user-provided region size, a malicious=
ly
large region might force the host CPU into a soft lockup. Should we add a
cond_resched() here?

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
This is a pre-existing issue, but does the error rollback path near the end
of this function pass the wrong units to hv_call_unmap_gpa_pages()?

The variable done tracks successfully mapped large pages, but
hv_call_unmap_gpa_pages() expects its page_count argument in 4KB units. If =
we
pass the large page count instead, it seems like it will fail the alignment
check and silently leak dangling large page mappings in the hypervisor's
stage 2 tables.

[ ... ]
> +int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg,
> +		      u64 mmio_mfn)
>  {
[ ... ]
> +	while (!HV_PAGE_COUNT_2M_ALIGNED(gfn) &&
> +	       !HV_PAGE_COUNT_2M_ALIGNED(mmio_mfn) &&
> +	       numpgs < reg->nr_pages) {
> +		numpgs++;
> +		gfn++;
> +		mmio_mfn++;
> +	}

[Severity: High]
Does the logical AND operator here cause the alignment loop to exit
prematurely?

If the offsets of gfn and mmio_mfn relative to a 2MB boundary differ, the l=
oop
will break as soon as only one of them becomes aligned, leaving the other
unaligned.

Will this cause us to pass unaligned addresses to a large-page hypercall la=
ter
in this function, violating the Hyper-V protocol?

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index fc08e994ecdf5..b45c6b275f999 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
> +{
[ ... ]
> +	mmio_mfn =3D mmio_mfn - (gfn - rg->start_gfn);   /* start of the range =
*/

[Severity: Critical]
Could this backwards extrapolation yield arbitrary physical addresses if a
region spans outside its intended VMA? By extrapolating the base PFN for the
entire region backwards, it looks like it could map adjacent, unauthorized =
host
physical memory into the guest.

Also, on architectures with page sizes larger than 4KB (like ARM64), does t=
his
mix incompatible units?

The function mshv_chk_get_mmio_start_pfn() returns a host PFN (e.g. 64KB
scaled), but this subtracts a 4KB-based Hyper-V GFN offset. Passing this
corrupted value to the hypervisor could cause incorrect physical addresses =
to
be mapped.

> +
> +	/* Map the entire mmio region now. mmap lock not needed because we
> +	 * are just mapping GPA to static device addresses, and the above
> +	 * mshv_partition_region_by_gfn_get() gets a hold on the region and
> +	 * hence its GPA. Unmap will occur when region ref count goes to 0.
> +	 */
> +	rc =3D hv_map_mmio_pages(pt->pt_id, rg, mmio_mfn);

[Severity: Critical]
Are these physical memory mappings protected against stale access?

Because MMIO regions do not register an mmu_interval_notifier, there doesn't
appear to be a mechanism to invalidate the hypervisor's translation tables =
if
the device is unbound or the VMA is unmapped.

Furthermore, dropping the mmap lock earlier seems to introduce a TOCTOU race
where a concurrent munmap could invalidate the PFN before the hypercall is
made. Will this allow stale mappings to persist?

> @@ -1340,7 +1424,6 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
[ ... ]
>  	mmap_read_lock(current->mm);
>  	vma =3D vma_lookup(current->mm, mem->userspace_addr);
>  	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> -	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
>  	mmap_read_unlock(current->mm);
> =20
>  	if (!vma)
>  		return -EINVAL;
> =20
> +	if (is_mmio) {
> +		size_t vma_sz =3D vma->vm_end - vma->vm_start;

[Severity: High]
Can this result in a use-after-free?

The vma pointer is unconditionally dereferenced here, but the lock is dropp=
ed
just above it with mmap_read_unlock(current->mm).

Could a concurrent thread in the VMM process calling munmap() unlink and
free the VMA before this calculation occurs, leading to memory corruption?

> +
> +		/* Upon mmio intercept, entire region is mapped */
> +		if (mem->size > vma_sz)
> +			return -EPERM;
> +	}

[Severity: Critical]
Does this bounds check properly validate the starting offset?

It only compares the total size against vma_sz, neglecting to check if the
region's start offset fits within the VMA. For example, it doesn't verify
that userspace_addr + size <=3D vm_end.

Would this allow a malicious userspace VMM to create a region that spans
outside its intended VMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D8
