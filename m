Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82633E6DDA
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176916; cv=none; b=JV0Jo28fYh5zsa6gnGzkJSSrUKX7TG6BT1gpe+p7ujRos71XyZwBk8fcSP426vqNBRGhUO6f0JC47yKj0DBwf56rHEyeBbjRsYkHXmb963n5pU/g4qbb0lS5wmc8eJiKPmkiV3o4rnRc+9cbL7dGSnIMIn5leITWjA0FSk/0dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176916; c=relaxed/simple;
	bh=9IkIAMTzOpw78e2bp2PbMSlOumSo90tYp/GtkQaNvgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gzb6lR/WhuedmSPF6lpfKy4LB4E6BxTjFRudGJ2jeg1YJrjrIXuReuNC8Foa57Y2qwa/K6LkvypitFLgdMDX9i1DQBTGbkznxR+mVdDZzSNzK5s/nU/Ezrij/HhiPdeZaGhd2G/GOzrOboHakjpemfOCwz9u/XoBZrMm7CxxfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjNzyH1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjNzyH1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586961F000E9;
	Mon, 31 Aug 2026 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176914;
	bh=1UYcj7EfnCivwyEtF8x0OhR6Iqfdo4GYgRj33rX4BmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OjNzyH1xjfzsnqJM8kb5NgpRgMKV6Hu5JoNQT70SIDl4IXNZHFT7fXO49N++StvuF
	 VfeuuN3h4YOFjLsm/AHtNdzsEfZwOqi31SwxUjTz1Jietf58t+iRgJUWRv7zuf/N8M
	 2Eh3fhIQLYWNqJkoqJVGwsy2h6Mo9VePiMDKjABAX2F1LSpOEtvKrc8NSFgv94OuIU
	 6VH6seyjA/H34xakH3yye86XBvkIScJR4e0+ga8LLgcOF+YkANaBmPRmf+MXZkZFsY
	 5nYEa1bBwJWnWWvL00hXJmXYWfPfaT38EbgTrm5dDN+QtRUyxX4pP02AhTqYm86tDw
	 3vGvC8XoKyXUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] mshv: retain memory regions until unmap succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260831112704.2851147-2-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260831112704.2851147-2-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:48:33 +0000
Message-Id: <20260831114834.586961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Early return in MMU interval notifier allows guest-to-host use=
-after-free because it falsely signals that guest access has been revoked b=
efore the hypervisor unmap completes.
- [High] ABBA deadlock between `mreg_remap_lock` rwsem fair-queueing and HM=
M sequence counter invalidation due to holding locks across a retry loop.

Pre-existing issues:
- [Critical] mshv_region_interval_invalidate() returns false for blockable =
ranges if remapping fails, leading to silent UAF.
- [Critical] Incorrect MMIO physical address mapped for user memory region,=
 allowing arbitrary physical memory access.
--

commit bdfaa07680341c254374f6fa979c3fcd550c4840
Author: Wei Hu <weh@microsoft.com>

mshv: retain memory regions until unmap succeeds

Do not remove a region from the partition list or unpin its pages until
a checked UnmapGpaPages hypercall has completed. Validate repetition
progress so malformed zero or oversized completion counts cannot spin or
conceal partial state.

[ ... ]

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 6d65e5b421529..9feb49d9d9d49 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c

[ ... ]

> @@ -452,12 +458,35 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>  	range.start =3D region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
>  	range.end =3D range.start + page_count * HV_HYP_PAGE_SIZE;
> =20
> +	/*
> +	 * Pin the mm while the remap gate still guarantees that the interval
> +	 * notifier is registered. Do not acquire mmap_lock while holding the
> +	 * gate: invalidation enters with mmap_lock held for write.
> +	 */
> +	down_read(&region->mreg_remap_lock);
> +	if (READ_ONCE(region->remap_blocked) ||
> +	    !mmget_not_zero(region->mreg_mni.mm)) {
> +		up_read(&region->mreg_remap_lock);
> +		ret =3D -ECANCELED;
> +		goto out;
> +	}
> +	mm =3D region->mreg_mni.mm;
> +	up_read(&region->mreg_remap_lock);
> +
> +	/* Lock order: mmap_lock -> mreg_remap_lock -> mreg_mutex. */
> +	mmap_read_lock(mm);
> +	down_read(&region->mreg_remap_lock);
> +	if (READ_ONCE(region->remap_blocked)) {
> +		ret =3D -ECANCELED;
> +		goto out_unlock_remap;
> +	}
> +
>  	do {
>  		ret =3D mshv_region_hmm_fault_and_lock(region, &range);
>  	} while (ret =3D=3D -EBUSY);

[Severity: High]
Does holding mreg_remap_lock across this retry loop create an ABBA deadlock?

If a concurrent page fault and region unmap occur:
1. The fault handler acquires mreg_remap_lock for read and blocks here wait=
ing
   for mmu_interval_read_retry() to clear.
2. The unmap thread queues for the mreg_remap_lock write lock in
   mshv_unmap_user_memory(), blocking new readers due to fair-queueing.
3. The MMU interval invalidation callback mshv_region_interval_invalidate()
   (which would clear the retry loop) attempts to acquire mreg_remap_lock f=
or
   read, but gets stuck behind the queued writer.

Can the fault handler loop forever holding the read lock, freezing the host
kernel?

[ ... ]

> @@ -524,6 +558,17 @@ static bool mshv_region_interval_invalidate(struct m=
mu_interval_notifier *mni,
>  	unsigned long mstart, mend;
>  	int ret =3D -EPERM;
> =20
> +	if (mmu_notifier_range_blockable(range))
> +		down_read(&region->mreg_remap_lock);
> +	else if (!down_read_trylock(&region->mreg_remap_lock))
> +		return false;
> +
> +	/* A completed checked unmap makes notifier remapping unnecessary. */
> +	if (READ_ONCE(region->remap_blocked)) {
> +		up_read(&region->mreg_remap_lock);
> +		return true;
> +	}

[Severity: Critical]
Does this early return falsely signal that guest access has been revoked be=
fore
the hypervisor unmap completes?

If mshv_unmap_user_memory() sets remap_blocked =3D true but has not yet acq=
uired
the mreg_remap_lock write lock to issue the hypervisor unmap, a racing MMU
invalidation could acquire the read lock first, see remap_blocked =3D=3D tr=
ue, and
immediately return true.

Could the MM subsystem then free the page while the hypervisor unmap has not
yet executed, leading to a guest-to-host use-after-free?

[ ... ]

>  out_unlock:
>  	mutex_unlock(&region->mreg_mutex);
>  out_fail:
> +	up_read(&region->mreg_remap_lock);
>  	WARN_ONCE(ret,
>  		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u=
, pages %#llx-%#llx, mm: %#llx): %d\n",
>  		  region->start_uaddr,

[Severity: Critical]
This is a pre-existing issue, but does mshv_region_interval_invalidate()
return false on a blockable range if mshv_region_remap_pages() fails?

The core MM __mmu_notifier_invalidate_range_start() explicitly ignores the
return value of blockable notifiers. By returning false instead of ensuring
the mapping is torn down, the driver silently fails the invalidation contra=
ct.

Does this allow the core MM subsystem to free or reuse a host page while the
guest VM retains mapped access to it, resulting in a guest-to-host
use-after-free?

[ ... ]

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..1ca14660f9985 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c

[ ... ]

> @@ -1397,13 +1398,15 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  		ret =3D hv_call_map_gpa_pages(partition->pt_id,
>  					    region->start_gfn,
>  					    region->nr_pages,
> -					    HV_MAP_GPA_NO_ACCESS, NULL);
> +					    HV_MAP_GPA_NO_ACCESS, NULL,
> +					    &region->mapping_may_exist);
>  		break;
>  	case MSHV_REGION_TYPE_MMIO:
>  		ret =3D hv_call_map_mmio_pages(partition->pt_id,
>  					     region->start_gfn,
>  					     mmio_pfn,
> -					     region->nr_pages);
> +					     region->nr_pages,
> +					     &region->mapping_may_exist);
>  		break;
>  	}

[Severity: Critical]
This is a pre-existing issue, but does mshv_map_user_memory() allow mapping=
 of
arbitrary physical memory by passing an unadjusted MMIO PFN and unvalidated
size directly to the hypervisor?

By using vma->vm_pgoff directly without adding the intra-VMA offset
corresponding to the userspace_addr, and by failing to validate that the
requested size fits inside vma->vm_end:

drivers/hv/mshv_root_main.c:mshv_map_user_memory() {
	vma =3D vma_lookup(current->mm, mem->userspace_addr);
	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
    ...
}

Could a malicious userspace process set userspace_addr to an offset within a
legitimate MMIO VMA (or beyond it) and map arbitrary contiguous physical
memory into the guest VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831112704.2851=
147-1-weh@linux.microsoft.com?part=3D1
