Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8D53CA7E
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870811; cv=none; b=B2Kjg0fsYVdgcTTlKyZMUnGmLGDth5fUXV+mHLi/qw8FlDlzb5zrTqH16hWWnunyPS0DcYZxYOpwfdvTaa2ZVj+1xyjcvURfw3zqmXu++RQ8I7TZK8ymnZgBABXiArkNOlM6YvI8lYnGtc8DhZLFzR0mbVkqP5WKWQET82Ujq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870811; c=relaxed/simple;
	bh=aYxYVb4Hs4o6E+CTCBb8RFJjtFLHYrZaFCKCNb932N4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uI+pESPVcO0Qbjx0SRlCT8KOtbSf9qI809t/PnAjhRXNj4qpzjhI61HBkeyX9GYvAMtmfkBZCACtHK4/S7UA5VIQFxtGCwChb7DTvt038W8hprxdkqHVyxD2jYnWmVnq7uZsc+jrzuFuFoBs5Uk47JT/E+GM7NlroEmoPiMBASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+xHjjqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+xHjjqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89911F00A3A;
	Tue,  8 Sep 2026 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870809;
	bh=9SNVULsma0l9ACdLvuvkGICToJinRtwl382n3xRMHwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+xHjjqGmMHFaxX+YK7KYSlTQm/UQV6vF92cy0ZuAsvwKQwnY8xwticgb7QEOeDpk
	 Yzzu7N55qN905BGEOs0RDRMWRU2iuC3+9Sai2pq+8uNiRGhgGXQXq0x1cOGUmZPNNV
	 orp6qYADVW3VGWoo4NHAO3WhnZAgff71hAQ9Gq24karhv7oqh28b+MYVsZYvNRH6cP
	 I4FqWb02KdhHQd5KzL8Id+XM2R/Q49lIovX0ABUSysqrxTsSFEw9d0JI5bPCpT43Ak
	 dhFkVbXX0HgXG3wDAncZFxAzkCnzIsBlmQylIWTuCvKwTeK3dk4sBYuyLdbdi+SX7n
	 uvYqReFQpFj+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] mshv: retain memory regions until unmap succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260908121403.1160280-2-weh@linux.microsoft.com>
References: <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260908121403.1160280-1-weh@linux.microsoft.com>
 <20260908121403.1160280-2-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:33:28 +0000
Message-Id: <20260908123329.C89911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Partial mapping failure for pinned memory causes permanent VM quar=
antine and memory leak without attempting rollback.
- [Medium] Data race on `region->mapping_may_exist` between the initializat=
ion mapping hypercall and the MMU interval notifier.

Pre-existing issues:
- [Critical] Missing verification of contiguous physical pages when mapping=
 2M chunks to the hypervisor, allowing guests to bypass COW and modify shar=
ed huge folios.
- [High] The mmu_interval_notifier invalidate callback returns false on a b=
lockable failure, violating the API contract and causing host use-after-fre=
e.
- [High] GFP_KERNEL allocation inside MMU interval notifier invalidate call=
back causes reclaim deadlocks and atomic context sleep violations.
- [High] mshv_region_destroy calls unpin_user_pages on a NULL array after e=
rror paths have already invalidated the region, causing a kernel panic.
- [High] mshv_map_user_memory computes mmio_pfn incorrectly when userspace_=
addr is not at the VMA start, mapping the wrong physical memory into the gu=
est.
--

commit ae5e74dcd02edb43f5a42fb59ce2354d9c3d2b17
Author: Wei Hu <weh@microsoft.com>

mshv: retain memory regions until unmap succeeds

Do not remove a region from the partition list or unpin its pages until
a checked UnmapGpaPages hypercall has completed. Validate repetition
progress so malformed zero or oversized completion counts cannot spin or
conceal partial state.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 6d65e5b421529..7b1860d3233d3 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
[ ... ]
> @@ -245,13 +247,21 @@ static int mshv_region_chunk_remap(struct mshv_mem_=
region *region,
>  				   u64 page_offset, u64 page_count,
>  				   bool huge_page)
>  {

[Severity: Critical]
This is a pre-existing issue, but I have a question about the huge page path
here. When mapping 2M chunks to the hypervisor, is there any verification
that the intermediate physical pages are contiguous and belong to the same
folio?

In mshv_chunk_stride() and mshv_region_process_chunk(), the code seems to
check only the first page and increments by a stride of 512. If a huge folio
mapped into the host has pages broken by COW (replaced by private anonymous
pages), the hypervisor might still be instructed to map the entire 2M
contiguous physical page. Could this allow a guest to bypass COW and overwr=
ite
shared huge folio memory belonging to other processes?

> +	bool chunk_mapping_may_exist;
> +	int ret;
> +
>  	if (huge_page)
>  		flags |=3D HV_MAP_GPA_LARGE_PAGE;
> =20
> -	return hv_call_map_gpa_pages(region->partition->pt_id,
> -				     region->start_gfn + page_offset,
> -				     page_count, flags,
> -				     region->mreg_pages + page_offset);
> +	ret =3D hv_call_map_gpa_pages(region->partition->pt_id,
> +				    region->start_gfn + page_offset,
> +				    page_count, flags,
> +				    region->mreg_pages + page_offset,
> +				    &chunk_mapping_may_exist);
> +	if (chunk_mapping_may_exist)
> +		region->mapping_may_exist =3D true;
> +
> +	return ret;
>  }
[ ... ]
> @@ -337,37 +347,39 @@ static int mshv_region_chunk_unmap(struct mshv_mem_=
region *region,
[ ... ]
>  static void mshv_region_destroy(struct kref *ref)
>  {
>  	struct mshv_mem_region *region =3D
>  		container_of(ref, struct mshv_mem_region, mreg_refcount);
> -	struct mshv_partition *partition =3D region->partition;
> -	int ret;
> +
> +	/* Callers must retain the list reference until cleanup is certain. */
> +	if (WARN_ON_ONCE(region->mapping_may_exist))
> +		return;
> =20
>  	if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_MOVABLE)
>  		mshv_region_movable_fini(region);
> =20
> -	if (mshv_partition_encrypted(partition)) {
> -		ret =3D mshv_region_share(region);
> -		if (ret) {
> -			pt_err(partition,
> -			       "Failed to regain access to memory, unpinning user pages will =
fail and crash the host error: %d\n",
> -			       ret);
> -			return;
> -		}
> -	}
> -
> -	mshv_region_unmap(region);
> -
>  	mshv_region_invalidate(region);

[Severity: High]
This is a pre-existing issue, but I am concerned about calling
mshv_region_invalidate() here unconditionally.

On error during mshv_prepare_pinned_region(), the code calls
mshv_region_invalidate_pages(), which unpins the pages and zero-initializes
the mreg_pages array. The error then propagates to mshv_map_user_memory()
which drops the refcount and triggers this mshv_region_destroy().

Because mshv_region_destroy() calls mshv_region_invalidate() again, it will
pass the now-NULL mreg_pages array elements to unpin_user_pages().
Will this result in a kernel panic when unpin_user_pages() dereferences the
NULL page pointers?

> -
>  	vfree(region);
>  }
[ ... ]
> @@ -531,6 +532,12 @@ static bool mshv_region_interval_invalidate(struct m=
mu_interval_notifier *mni,
>  	page_offset =3D HVPFN_DOWN(mstart - region->start_uaddr);
>  	page_count =3D HVPFN_DOWN(mend - mstart);
> =20
> +	/*
> +	 * mmap_lock is already held by the notifier core. Take only the region
> +	 * mutex here; taking the fair fault rwsem would deadlock behind an unm=
ap
> +	 * writer that is waiting for this mutex. Publish the sequence after the
> +	 * mutex is acquired even when a checked unmap proved no mapping remain=
s.
> +	 */
>  	if (mmu_notifier_range_blockable(range))
>  		mutex_lock(&region->mreg_mutex);
>  	else if (!mutex_trylock(&region->mreg_mutex))
> @@ -538,15 +545,15 @@ static bool mshv_region_interval_invalidate(struct =
mmu_interval_notifier *mni,
> =20
>  	mmu_interval_set_seq(mni, cur_seq);
> =20
> -	ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> -				      page_offset, page_count);
> -	if (ret)
> -		goto out_unlock;
> +	if (READ_ONCE(region->mapping_may_exist)) {
> +		ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> +					      page_offset, page_count);
> +		if (ret)
> +			goto out_unlock;
> +	}

[Severity: High]
This is a pre-existing issue, but I am worried about memory allocations her=
e.

mshv_region_interval_invalidate() is invoked by memory reclaim or atomic
contexts. It calls mshv_region_remap_pages() which triggers a hypercall.
If the hypervisor requires memory, it calls hv_call_deposit_pages(), which
allocates memory using alloc_page(GFP_KERNEL).

Does using sleepable allocations (GFP_KERNEL) from reclaim context cause
deadlocks, or from atomic context trigger a sleeping-in-atomic bug?

[Severity: Medium]
Also, is it safe to use READ_ONCE(region->mapping_may_exist) here when
the writer in hv_do_map_gpa_hcall() uses a plain assignment
(*mapping_may_exist =3D true)?

Since mmu_interval_notifier_insert() could be called before the hypercall,
mshv_region_interval_invalidate() might run concurrently. Under the C memory
model, this data race could lead to missed invalidations if the compiler
reorders or tears the write.

> =20
>  	mshv_region_invalidate_pages(region, page_offset, page_count);
> -
>  	mutex_unlock(&region->mreg_mutex);
> -
>  	return true;
> =20
>  out_unlock:

[Severity: High]
This isn't a bug introduced by this patch, but returning false on a
blockable failure here violates the mmu_interval_notifier API contract.

The core MM subsystem strictly forbids returning false when
mmu_notifier_range_blockable(range) is true. Doing so causes a WARN_ON and
ignores the failure, which means the host proceeds to free or reuse the page
while the hypervisor retains guest access.
Could this lead to a cross-process use-after-free reachable under memory
pressure or untrusted guest action?

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..bb6f16fac4de1 100644
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

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the mmio_pfn
computation earlier in this function:

	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;

Does this completely ignore the page offset of the requested userspace_addr
within the VMA? If a user requests a mapping for a sub-region of the VMA,
would the guest incorrectly be mapped to the very beginning of the VMA's
physical address space instead of the requested offset?

>  		break;
>  	}
> =20
> @@ -1421,7 +1424,17 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  	return 0;
> =20
>  errout:
> -	mshv_region_put(region);
> +	if (region->mapping_may_exist) {
> +		spin_lock(&partition->pt_mem_regions_lock);
> +		hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> +		spin_unlock(&partition->pt_mem_regions_lock);
> +		pt_err(partition,
> +		       "Retaining region after uncertain map cleanup at GFN %#llx\n",
> +		       region->start_gfn);
> +		mshv_quarantine_partition(partition);
> +	} else {
> +		mshv_region_put(region);
> +	}

[Severity: High]
If a later chunk fails to map during mshv_prepare_pinned_region(), the
earlier chunks remain mapped, leaving region->mapping_may_exist as true.

When the error propagates back here and mapping_may_exist is true, the
driver immediately calls mshv_quarantine_partition(), permanently leaking
the partition and module.

Should this code attempt to call mshv_region_unmap() on the error path to
clean up the partially mapped chunks before resorting to quarantine, to
prevent a permanent DoS via resource exhaustion?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908121403.1160=
280-1-weh@linux.microsoft.com?part=3D1
