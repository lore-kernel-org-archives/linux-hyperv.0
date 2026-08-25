Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDC31D72E
	for <linux-hyperv@vger.kernel.org>; Tue, 25 Aug 2026 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631765; cv=none; b=ayRhyfxC6Xx+lgTKOOskcEwy4CKy6iZa9HOAOv6/jc9CliEVZzQ2yNzNJlMdu4wtLgvohl1Iseeva9T8c2utBVp+2xojyUPL7Hyz/oM46fr95TWKlDCjtxGutTpc6lpu2hA+FPbCYB/Q/0hoUZYhAT41IutgMLAUAA4ZV4HmJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631765; c=relaxed/simple;
	bh=vFAzhW1045eOikikZ263xCA22+9Zik71Eii+wfTkxuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9veiMfL36jWdUVNhxjEcnhXlQnKvMC6rYq5o678z6VV7r7cLDD0ThwegYOngwHvZb1gAFPQxhYWbC6jlD5qdF92U7OTOMyOc5o2F2l6YQBlePSsTlosA1RsJVpGEPjQpzHwGD46bdg3BwsOc2PmQjBCcMeLGPET7IijGIIHMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2QnCyaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2QnCyaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175C11F000E9;
	Tue, 25 Aug 2026 04:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787631764;
	bh=TIZqUd1tnVn02OFgNUmkIlbI2iZiziMnB5IZDa+deN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2QnCyaaMUKwybckfD1lb4L1WAnQWBR2vb378kPJ53U8/I6XCaIA+CrcjzHTLZTLK
	 oUJo3S75ai4DJUBYPcZ/sHxBJxQxKDf/5diFzJPzV8ZX7BWh+PKUFt2Ij/T1blMn2P
	 hIuF8GoFWKPWyH+7elNpgtiyHxv012x3n1bUS1dkPwEnFS9SKpC5arWixRtQM7MYKQ
	 U32qF3BgeBZsn+ejElfw0/Hz3DPTqv+99mLnv2bUwMXhGwRSxbwsbeO/lQk1s/Sc8T
	 Y3wkAjZUiLGf+lt7TxHao2q2O6znhgaFgGK7f4Hkj2578zC7fNVgU5fhb1SBl+ZP+5
	 CZ5s8XOxAGksQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260825040505.826600-5-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260825040505.826600-5-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:22:43 +0000
Message-Id: <20260825042244.175C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Revoking host access to guest pages without invalidating them =
in the kernel's direct map allows stray kernel accesses to crash the host s=
ystem.
- [High] destroy_partition attempts to restore host access before unmapping=
 memory for uninitialized SEV-SNP partitions, guaranteeing failure and perm=
anent memory leak.
- [Medium] Batched IOCTLs abort on failure midway through without reporting=
 progress or unrolling completed operations, permanently bricking partition=
 state.

Pre-existing issues:
- [Critical] Ignored return value of mshv_region_unmap() in mshv_region_des=
troy() allows guest access to freed host physical memory.
--

--- Patch [4]: [PATCH v3 4/7] mshv: wire SEV-SNP partition ioctls ---
commit 438c5ba1c23ba880c2f38d767dbf75dd5ce5c64b
Author: Wei Liu <wei.liu@kernel.org>
Subject: mshv: wire SEV-SNP partition ioctls

Wire the SEV-SNP partition ioctls for GPA host-access changes,
isolated-page import, PSP guest requests, AP creation, and ordered SNP
partition teardown. Process userspace page arrays in bounded batches.

> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
[ ... ]
> @@ -354,17 +354,19 @@ static void mshv_region_destroy(struct kref *ref)
>  	if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_MOVABLE)
>  		mshv_region_movable_fini(region);
> =20
> -	if (mshv_partition_encrypted(partition)) {
> +	if (mshv_partition_encrypted(partition) &&
> +	    !partition->snp_host_access_restored) {
>  		ret =3D mshv_region_share(region);
>  		if (ret) {
>  			pt_err(partition,
> -			       "Failed to regain access to memory, unpinning user pages will =
fail and crash the host error: %d\n",
> +			       "Failed to regain access to memory, retaining pinned region: %=
d\n",
>  			       ret);
>  			return;
>  		}
>  	}
> =20
> -	mshv_region_unmap(region);
> +	if (!partition->snp_regions_unmapped)
> +		mshv_region_unmap(region);
> =20
>  	mshv_region_invalidate(region);

[Severity: Critical]
This is a pre-existing issue, but does mshv_region_destroy() ignore the
return value of mshv_region_unmap()?

If a user issues MSHV_SET_GUEST_MEMORY with the UNMAP flag on an active
partition, mshv_unmap_user_memory() is triggered. This removes the region
from the list and calls mshv_region_put().

When the refcount drops to 0, mshv_region_destroy() calls
mshv_region_unmap() to perform HVCALL_UNMAP_GPA_PAGES. If this hypercall
fails due to hypervisor state or invalid parameters, the pages remain mapped
in the guest's GPA space.

Because the return value is ignored, the code unconditionally proceeds to
mshv_region_invalidate(), unpinning the pages and returning them to the
host buddy allocator. Can the running guest then trivially read or write
these freed pages, resulting in host memory corruption via use-after-free?

> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1648,6 +1682,409 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
>  	return ret;
>  }
> =20
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
[ ... ]
> +static long
> +mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
[ ... ]
> +		ret =3D hv_call_modify_spa_host_access(partition->pt_id, pages,
> +						     count, host_access, flags,
> +					     acquire);

[Severity: Critical]
When revoking host access from guest pages here, shouldn't we invalidate
them in the kernel's direct map?

MSHV_MODIFY_GPA_HOST_ACCESS calls hv_call_modify_spa_host_access() with
HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE to make pages exclusive to
the guest.

If these pages are not removed from the Linux kernel's direct map using
set_direct_map_invalid_noflush(), they remain mapped on the host while
hardware-level access is revoked by the hypervisor.

Could speculative execution, prefetching, or background kernel activity
accessing these virtual addresses trigger a hardware exception because the
underlying physical memory is protected by SEV-SNP RMP rules, leading to a
complete host panic?

> +		if (ret)
> +			break;

[Severity: Medium]
If the loop breaks midway due to a validation or hypercall failure, are the
completed pages unrolled?

Memory arrays are processed in chunks of 4096 pages. Validation checks like
mshv_pages_are_contiguous_2m() and the hypercalls are performed inside this
loop.

If a check fails on a subsequent iteration, the loop breaks and returns an
error code. Since the input arguments are passed by value, userspace receiv=
es
a generic error and cannot determine which pages were modified.

Does this leave the VM in a fragmented state where neither the kernel nor
userspace can safely clean up or resume the operation?

[ ... ]
> +static long
> +mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partit=
ion,
> +					   void __user *user_args)
> +{
[ ... ]
> +		ret =3D hv_call_import_isolated_pages(partition->pt_id, pages, count,
> +						    args.page_type, args.page_size,
> +						    mshv_async_hvcall_handler,
> +						    partition);
> +		if (ret)
> +			break;

[Severity: Medium]
Does this loop share the same brittle chunking and abort logic as
mshv_partition_ioctl_modify_gpa_host_access() mentioned above?

[ ... ]
> @@ -1805,6 +2324,9 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  	struct mshv_mem_region *region;
>  	struct hlist_node *n;
>  	int i;
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +	int ret;
> +#endif
> =20
>  	if (refcount_read(&partition->pt_ref_count)) {
>  		pt_err(partition,
> @@ -1814,7 +2336,87 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
> =20
>  	trace_mshv_destroy_partition(partition->pt_id);
> =20
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +	if (!partition->pt_initialized && mshv_partition_encrypted(partition)) {
> +		int region_ret;
> +
> +		ret =3D 0;
> +		hlist_for_each_entry_safe(region, n,
> +					  &partition->pt_mem_regions, hnode) {
> +			region_ret =3D mshv_region_share(region);
> +			if (region_ret) {
> +				pt_err(partition,
> +				       "Failed to restore host access at GFN %#llx: %d\n",
> +				       region->start_gfn, region_ret);
> +				ret =3D region_ret;
> +			}
> +		}
> +		if (ret) {
> +			pt_err(partition,
> +			       "Retaining uninitialized partition with inaccessible SNP pages=
\n");
> +			mshv_quarantine_partition(partition);
> +			return;
> +		}

[Severity: High]
When tearing down an uninitialized SEV-SNP partition, does
destroy_partition() fail to restore host access because the memory hasn't
been unmapped yet?

If a user creates an SNP partition, maps memory (which creates active GPA
mappings via mshv_prepare_pinned_region()), and then closes the fd without
initializing the partition, this path executes.

The code explicitly loops over all memory regions and calls
mshv_region_share() to restore host access before unmapping the GPAs,
which happens later when mshv_region_destroy() is triggered.

Will the hypervisor reject the share request since the pages are still
actively mapped in the guest's SLAT? The resulting mshv_region_share()
failure triggers mshv_quarantine_partition(), intentionally leaking the
partition object and its pinned memory.

Could an unprivileged user exploit this to cause host memory exhaustion by
rapidly creating, mapping, and destroying uninitialized partitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825040505.8266=
00-1-weh@linux.microsoft.com?part=3D4
