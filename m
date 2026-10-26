Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025781;
	b=OBtpC5joLSLaf1YrngDKrWN3pKabDvcQIAfx2gehSxSlfRPTPIL7AX8D0RvfhtEBhxrd
	 Dl0AYmN4jfPCFtMDYvynMfF2itLzQ6hB9eSaz2v/bCzqNCXwaRiyDHqPF+TLaH/mJbAgX
	 2RP2i7PRvXiq/8+7UXNoIYyFAxhW2+k484wLNEA+dOGd3MOCTcmMYw5e44ynbQwI6RBi0
	 8WQBOssR3K0gVbc++V4OJqG24r84hEgq+SoDrVBJLOq1k4Tr2fBpzEdR/dVAx68oIue6j
	 Bp3A/l2MXfBYHlbZw00G9QpMNMbz2HUDbb8w2xsaulH1OhgXhMGmotl/kN9tfAXK1/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tICposUMI+B6W1ojwON2Ww1awfFKHLwqRvM7QzxamLw=;
	b=aAnGRGxZgiZpKadbPDQVqjcm9Acdc3V1ON3Lg7h/j6SoL5GY07BZMNx+MR3cEX4FXOw2
	 acBL2IcR8vbZQ1LPTfui7zfi4VlTwE0EFxaz5X6Ry7Jz/Kebp/a8/nrrvS62oyWUbTjpb
	 XtreEd06JQ7oyorm3z1TfJ0oJs8oBkXwk2ra3ej/JseyCglQGQjdWJG8/Xu1bJGHjFP+z
	 p4mc5TM33S8s//S1qC+HBaI73Ni+eOgPN0u42tgnkvc8z72vmyxkPZA0FI4Qq29YSVubT
	 tCIg/PgOHgG1fcS2hXZ9DaUi/LJ1GbyXxJLBzZU9cGwiK2OtQNDaV2skNhyAOT4RZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXPrTlY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCA606A32D
	for <linux-hyperv@vger.kernel.org>; Mon, 26 Oct 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXPrTlY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15881F031E2;
	Mon, 26 Oct 2026 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025780;
	bh=tICposUMI+B6W1ojwON2Ww1awfFKHLwqRvM7QzxamLw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GXPrTlY63zep8MkRG0YxWkdBEP5rDSAICPitYfZUOWG/8yyyEKCGRlRku0hdzuKmr
	 BG7vk1tTakuqJglQiGC+P/4IXlL81ekbDVyVC4FyLuE9GwGS96ZJ1tBvchHk9+Nz7a
	 aNGHUAUON8qMNOnEUFe0rVjVJu6p1R8lFunqy0TerBsIkk9mhv2sNoqxo10Ps7Q1Jm
	 Ma+Eg5hd0EDqb3icx27KVT0bsoaLHhz3YN63DRceNdQi7p3hziPaiUOXDmIV2BlcOz
	 K6WbZQGOMMnbfW6iAU2yWNp6hq0vzWLnd2HeQZfBmxKaU/8x5GNmvF/zRzk5H6fAO1
	 mypugGHiykr+w==
Message-ID: <sashiko-outbox-185409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] mshv: retain memory regions until unmap succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261026141512.2987985-2-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
 <20261026141512.2987985-2-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:43:00 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mshv: mshv_region_unmap() omits HV_UNMAP_GPA_LARGE_PAGE for movabl=
e regions
- [High] mshv: incomplete teardown and page leaks on unmap error in destroy=
_partition()
- [High] mshv: lock inversion and GFP_KERNEL allocation under mreg_mutex
- [Medium] mshv: unblocked GPA faults on retained failed regions in mshv_ma=
p_user_memory()
--

commit b6202cda71e3fd510b253d3ac5b2f6431f276487
Author: Wei Hu <weh@microsoft.com>

mshv: retain memory regions until unmap succeeds

This patch ensures memory regions are retained in the partition list and
their pages remain pinned until a checked UnmapGpaPages hypercall succeeds.
It also serializes movable region faults and MMU interval notifier
invalidations with region locking, and quarantines partitions if unmap
cleanup fails.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index dddaade31b5dc..074e0dd6649c3 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
[ ... ]
> @@ -337,37 +347,39 @@ static int mshv_region_chunk_unmap(struct mshv_mem_=
region *region,
>  				       page_count, flags);
>  }
> =20
> -static int mshv_region_unmap(struct mshv_mem_region *region)
> +int mshv_region_unmap(struct mshv_mem_region *region)
>  {
> -	return mshv_region_process_range(region, 0,
> -					 0, region->nr_pages,
> -					 mshv_region_chunk_unmap);
> +	int ret;
> +
> +	if (!region->mapping_may_exist)
> +		return 0;
> +
> +	if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_PINNED)
> +		ret =3D mshv_region_process_range(region, 0, 0, region->nr_pages,
> +						mshv_region_chunk_unmap);
> +	else
> +		ret =3D hv_call_unmap_gpa_pages(region->partition->pt_id,
> +					      region->start_gfn,
> +					      region->nr_pages, 0);

[Severity: High]
Will hv_call_unmap_gpa_pages() fail here for movable regions that have
faulted in 2M huge pages?

When a movable region handles a GPA fault via:

  mshv_region_handle_gfn_fault() ->
    mshv_region_range_fault() ->
      mshv_region_remap_pages() ->
        mshv_region_process_range(..., mshv_region_chunk_remap)

mshv_region_range_fault() populates region->mreg_pages[], and if the
faulted memory is backed by a 2M-aligned huge folio, mshv_chunk_stride()
identifies a huge page and mshv_region_chunk_remap() maps it in the
hypervisor with HV_MAP_GPA_LARGE_PAGE. Similarly,
mshv_region_interval_invalidate() remaps 2M chunks with
HV_MAP_GPA_NO_ACCESS | HV_MAP_GPA_LARGE_PAGE before clearing
region->mreg_pages[].

Because mshv_region_unmap() now only uses mshv_region_process_range() for
MSHV_REGION_TYPE_MEM_PINNED and passes flags =3D 0 to
hv_call_unmap_gpa_pages() for MSHV_REGION_TYPE_MEM_MOVABLE, the hypervisor
rejects the unmap for any 2M-mapped ranges due to the missing
HV_UNMAP_GPA_LARGE_PAGE flag. This causes mshv_unmap_user_memory() to fail
and causes destroy_partition() to quarantine and leak the partition.

> +	if (!ret)
> +		region->mapping_may_exist =3D false;
> +
> +	return ret;
>  }
[ ... ]
> @@ -497,6 +528,13 @@ static bool mshv_region_interval_invalidate(struct m=
mu_interval_notifier *mni,
>  	page_offset =3D HVPFN_DOWN(mstart - region->start_uaddr);
>  	page_count =3D HVPFN_DOWN(mend - mstart);
> =20
> +	/*
> +	 * mmap_lock is already held by the notifier core. Take only the region
> +	 * mutex here; taking the fair fault rwsem would deadlock behind an
> +	 * unmap writer that is waiting for this mutex. Publish the sequence
> +	 * after the mutex is acquired even when a checked unmap proved no
> +	 * mapping remains.
> +	 */
>  	if (mmu_notifier_range_blockable(range))
>  		mutex_lock(&region->mreg_mutex);
>  	else if (!mutex_trylock(&region->mreg_mutex))
> @@ -504,15 +542,15 @@ static bool mshv_region_interval_invalidate(struct =
mmu_interval_notifier *mni,
> =20
>  	mmu_interval_set_seq(mni, cur_seq);
> =20
> -	ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> -				      page_offset, page_count);
> -	if (ret)
> -		goto out_unlock;
> +	if (region->mapping_may_exist) {
> +		ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> +					      page_offset, page_count);
> +		if (ret)
> +			goto out_unlock;
> +	}

[Severity: High]
Can acquiring region->mreg_mutex here and around hv_call_map_gpa_pages()
cause a lock inversion with fs_reclaim and sleep in a non-blockable MMU
notifier?

In mshv_region_interval_invalidate(), region->mreg_mutex is acquired inside
the MMU notifier invalidation callback while the kernel holds
__mmu_notifier_invalidate_range_start_map (and __fs_reclaim_map when invoked
from direct reclaim such as try_to_unmap_one()). This establishes the lock
ordering:

  __fs_reclaim_map -> __mmu_notifier_invalidate_range_start_map -> region->=
mreg_mutex

However, in mshv_map_user_memory() (after mmu_interval_notifier_insert() has
already registered the notifier on current->mm) and in
mshv_region_range_fault(), the code holds region->mreg_mutex while calling:

  hv_call_map_gpa_pages() ->
    hv_do_map_gpa_hcall() ->
      hv_deposit_memory() ->
        hv_deposit_memory_node() ->
          hv_call_deposit_pages()

which allocates pages with GFP_KERNEL via get_zeroed_page(GFP_KERNEL) and
alloc_pages_node(node, GFP_KERNEL, order), inverting the lock hierarchy:

  region->mreg_mutex -> __fs_reclaim_map -> __mmu_notifier_invalidate_range=
_start_map

Additionally, when mshv_region_interval_invalidate() is called with
!mmu_notifier_range_blockable(range), it uses mutex_trylock() on
region->mreg_mutex, but then calls mshv_region_remap_pages() which can still
enter hv_deposit_memory() and sleep on GFP_KERNEL allocations in a
non-blockable context.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..b37d8652c2f41 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1421,6 +1445,28 @@ mshv_map_user_memory(struct mshv_partition *partit=
ion,
>  	return 0;
> =20
>  errout:
> +	if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_MOVABLE) {
> +		bool mapping_may_exist;
> +
> +		mutex_lock(&region->mreg_mutex);
> +		mapping_may_exist =3D region->mapping_may_exist;
> +		mutex_unlock(&region->mreg_mutex);
> +		if (!mapping_may_exist)
> +			goto put_region;
> +	} else if (!region->mapping_may_exist) {
> +		goto put_region;
> +	}
> +
> +	spin_lock(&partition->pt_mem_regions_lock);
> +	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
> +	spin_unlock(&partition->pt_mem_regions_lock);
> +	pt_err(partition,
> +	       "Retaining region after uncertain map cleanup at GFN %#llx\n",
> +	       region->start_gfn);
> +	mshv_quarantine_partition(partition);
> +	return ret;

[Severity: Medium]
Should region->faults_blocked be set to true before adding a failed region
to partition->pt_mem_regions here?

When mshv_map_user_memory() fails for a movable region and cleanup is
uncertain (region->mapping_may_exist is true), the region was only being
mapped with HV_MAP_GPA_NO_ACCESS and no host pages have been mapped into the
guest yet.

Because region->faults_blocked remains false when the region is added to
partition->pt_mem_regions, and mshv_vp_ioctl() does not check
partition->teardown_quarantined, a concurrent or subsequent MSHV_RUN_VP
ioctl that triggers a GPA intercept via:

  mshv_handle_gpa_intercept() ->
    mshv_partition_region_by_gfn_get() ->
      mshv_region_handle_gfn_fault() ->
        mshv_region_range_fault()

will find this region, pass the !READ_ONCE(region->faults_blocked) check,
and fault in and map host userspace pages into the guest for a region whose
MSHV_SET_GUEST_MEMORY ioctl failed.

[ ... ]
> @@ -1814,6 +1907,39 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
> =20
>  	trace_mshv_destroy_partition(partition->pt_id);
> =20
> +	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
> +		bool was_blocked;
> +		int unmap_ret;
> +
> +		/* Stop new lookup users before draining in-flight remappers. */
> +		spin_lock(&partition->pt_mem_regions_lock);
> +		was_blocked =3D READ_ONCE(region->faults_blocked);
> +		WRITE_ONCE(region->faults_blocked, true);
> +		spin_unlock(&partition->pt_mem_regions_lock);
> +
> +		down_write(&region->mreg_fault_lock);
> +		mutex_lock(&region->mreg_mutex);
> +		unmap_ret =3D mshv_region_unmap(region);
> +		if (unmap_ret) {
> +			spin_lock(&partition->pt_mem_regions_lock);
> +			WRITE_ONCE(region->faults_blocked, was_blocked);
> +			spin_unlock(&partition->pt_mem_regions_lock);
> +			mutex_unlock(&region->mreg_mutex);
> +			up_write(&region->mreg_fault_lock);
> +
> +			pt_err(partition,
> +			       "Failed to unmap region at GFN %#llx: %d; retaining partition\=
n",
> +			       region->start_gfn, unmap_ret);
> +			mshv_quarantine_partition(partition);
> +			return;
> +		}
> +		mutex_unlock(&region->mreg_mutex);
> +		up_write(&region->mreg_fault_lock);
> +
> +		if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_MOVABLE)
> +			mshv_region_movable_fini(region);
> +	}

[Severity: High]
If mshv_region_unmap() fails on one region here, doesn't returning early
skip cleanup for the rest of the partition and leak already-unmapped
regions?

destroy_partition() is called from mshv_partition_release() ->
mshv_partition_put() after partition->pt_ref_count reaches 0 and after
cleanup_srcu_struct(&partition->pt_irq_srcu) has already run, so
destroy_partition() will never be invoked again. Returning early here has
several consequences:

1. Any regions that were already successfully unmapped in earlier iterations
   of this loop are not detached or freed until the second
   hlist_for_each_entry_safe() loop at the bottom of destroy_partition(), so
   their FOLL_LONGTERM pinned pages and vzalloc() structures are leaked even
   though their hypervisor mappings were removed.

2. Any remaining regions in partition->pt_mem_regions are skipped, and
   movable regions (the failing one and subsequent ones) never call
   mshv_region_movable_fini(), leaking the mmgrab() reference on the mm.

3. Restoring region->faults_blocked to was_blocked (false) re-enables fault
   admission on a dying partition.

4. Running VPs are never stopped or finalized (drain_all_vps() and
   hv_call_finalize_partition() are skipped), debugfs entries are left
   behind, and remove_partition() is skipped, leaving the zero-refcount
   partition (with its already-cleaned-up pt_irq_srcu) in
   mshv_root.pt_htable where interrupt handlers can still find it via
   mshv_partition_find().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026141512.2987=
985-1-weh@linux.microsoft.com?part=3D1
