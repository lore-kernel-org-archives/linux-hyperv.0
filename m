Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B74E50BA
	for <linux-hyperv@vger.kernel.org>; Fri, 18 Sep 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733662; cv=none; b=FQx60HxbkKxjZ4S46UF6FWM7qBsJtA7ClSAY8Pw8BbsIHQ93iM3U0O8x/84roIFSH76TDsckOCcvdh0UcHu/+2nLnfLZyxijmYbJ+9MDW+Ne6w6R8IZLeazgWz03b2i2Vy6p9GLAXu3MdldVnnG8mnmFEj91b1kCZTygTQQ2ayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733662; c=relaxed/simple;
	bh=Gq2Md5/PlQ65zul638/N3yFSg8Wmi8cjGuEBikmAmfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GNgh/6jVR9Guz8fpOxNA1TUjCQwA+QPAAP7u+rkYMX4xKalEr32r0z1FQet1eBiFlAUBI0BLh/1tLcr3/OKxHExmIx+iIve+WhJHt8x40hWLm1zcJm2IBVHiwNWddkxuSGz1g3fMBzQgxQmJY7wW6fMDonKvQFbIib82iP/jbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTd8BxGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTd8BxGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30B21F00893;
	Fri, 18 Sep 2026 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789733660;
	bh=ZbA3HW7l0avZVnxbbnXggu4Q2niqkA6EPs15nChjeEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GTd8BxGAeE6iZJIioXd4q3CmBInpsg79eCCXpjX8SP9oT9zDl5RFAAwXw+EZjKsQU
	 Mmbh46OwK6bmIETJ1H9Hm4acE7kaNZd8YZL7FX8f1CAcQNh3il3LWSUm+Hof5+uYog
	 WGItQMehQlOcTmOVzyDwkn20g6GDMEdyW7R1H1R8j5zL6vUcysvCtCrkAHolDpOCA4
	 SQovZea1lJWYNMnD5CjfFkVgHIITxjr7GQ/oYhHXHvf5YwjEW5sNXKD4cNCSz4X/di
	 wH5m2jVbFonvOvJfMUxuf/kq83zzG/oIHURl7ErK+kmgWKk6K6JMySotpmrPxNpJ1D
	 7dVlOeGk86bVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260918115741.3791682-7-weh@linux.microsoft.com>
References: <20260908121403.1160280-1-weh@linux.microsoft.com>
 <20260918115741.3791682-1-weh@linux.microsoft.com>
 <20260918115741.3791682-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 12:14:20 +0000
Message-Id: <20260918121420.A30B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hv/mshv: unkillable task in mshv_partition_ioctl_import_isolated_p=
ages()
- [High] hv/mshv: soft lockups in unbounded memory region processing loops
--

commit c18842e6b577b1aad2cca89b02c8c1764f3d001e
Author: Wei Liu <wei.liu@kernel.org>
   =20
    mshv: wire SEV-SNP partition ioctls
   =20
This commit wires the SEV-SNP UAPI into partition creation, memory ownershi=
p,
and isolated-page import operations. It introduces tracking for host READ/W=
RITE
permissions and ownership for every pinned 4K page. It also implements the
necessary UAPI layers to handle guest requests and manage AP creation.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index b08b2709bf115..8920340942ce5 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c

[ ... ]

> +int mshv_region_check_duplicate_pfns(struct mshv_mem_region *region)
> +{
> +	struct mshv_partition *partition =3D region->partition;
> +	struct mshv_mem_region *existing;
> +	DEFINE_XARRAY(pfns);
> +	u64 i;
> +	int ret =3D 0;
> +
> +	lockdep_assert_held(&partition->pt_mutex);
> +
> +	/*
> +	 * Use a temporary index so alias rejection has no permanent per-page
> +	 * memory cost. xa_insert() also rejects duplicate PFNs within region.
> +	 */
> +	for (i =3D 0; i < region->nr_pages; i++) {
> +		ret =3D xa_insert(&pfns, page_to_pfn(region->mreg_pages[i]),

[Severity: High]
Does this code risk soft lockups during unbounded processing loops?

If a user maps a massive memory region, this loop can iterate over millions
of pages doing xa_insert() without yielding. Would it be better to add a
cond_resched() periodically?

[ ... ]

> +int
> +mshv_apply_region_host_access(struct mshv_mem_region *region, u64 index,
> +			      u64 count, u32 host_access, u32 flags,
> +			      struct mshv_host_access_result *result)
> +{
> +	u64 i;
> +
> +	mshv_host_access_normalize_result(result, count);
> +	for (i =3D 0; i < result->completed; i++) {
> +		u8 old_state =3D mshv_region_host_access_get(region, index + i);

[Severity: High]
Similarly, can this loop cause a CPU stall if updating a large region? It=20
modifies the bitmaps for potentially millions of completed pages without
yielding.

[ ... ]

> +int mshv_region_share(struct mshv_mem_region *region)
> +{
> +	u64 offset =3D 0;
> +	int state_error =3D 0;
> +	int ret;
> +
> +	while (offset < region->nr_pages) {
> +		u64 count;
> +		u32 flags;
> +		u8 state =3D mshv_region_host_access_get(region, offset);

[ ... ]

> +		/* One call may cover only pages with identical restore state. */
> +		for (count =3D 1; offset + count < region->nr_pages; count++) {
> +			u8 next =3D mshv_region_host_access_get(region,
> +							      offset + count);

[Severity: High]
Could this inner loop also cause soft lockups when scanning the entire regi=
on
size to find contiguous state blocks without yielding?

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb57275293557..c2a629bdef339 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c

[ ... ]

> @@ -1213,31 +1284,34 @@ int hv_call_modify_spa_host_access(u64 partition_=
id, struct page **pages,
>  		page_count >>=3D large_shift;
>  	}
> =20
> +	ret =3D mshv_validate_host_access_flags(flags, acquire);
> +	if (ret)
> +		return ret;
> +
>  	while (done < page_count) {
> -		ulong i, completed, remain =3D page_count - done;
> -		int rep_count =3D min(remain,
> -				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
> +		u64 i, completed, remain =3D page_count - done;
> +		unsigned int rep_count =3D min_t(u64, remain,
> +			HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);

[Severity: High]
Is there a risk of monopolizing the CPU here when batching hypercalls for
an extremely large page count without periodically yielding?

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index de6519ac677b3..cb090c380b97f 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c

[ ... ]

> +static long
> +mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partit=
ion,
> +					   void __user *user_args)
> +{
> +	struct mshv_import_isolated_pages args;
> +	u64 __user *guest_pfns;
> +	u64 *pages =3D NULL;
> +	u64 input_completed;
> +	u64 offset =3D 0;
> +	long ret =3D 0;

[ ... ]

> +	while (offset < args.page_count) {
> +		u64 count =3D min_t(u64, args.page_count - offset,
> +				  MSHV_USER_PAGE_BATCH_SIZE);
> +		u64 completed =3D 0;

[ ... ]

> +		ret =3D hv_call_import_isolated_pages(partition->pt_id, pages,
> +						    count, &completed,
> +						    args.page_type,
> +						    args.page_size,
> +						    mshv_async_hvcall_handler,
> +						    partition);

[ ... ]

> +		offset +=3D completed;
> +		if (ret) {
> +			if (ret =3D=3D -EPROTO)
> +				mshv_quarantine_partition(partition);
> +			break;
> +		}
> +		if (completed !=3D count) {
> +			ret =3D -EPROTO;
> +			mshv_quarantine_partition(partition);
> +			break;
> +		}
> +		cond_resched();
> +	}

[Severity: High]
Can an unkillable task hold the partition mutex indefinitely here?

Although this loop calls cond_resched(), it processes based on an unbounded
args.page_count without checking for fatal signals like fatal_signal_pendin=
g().

If a user passes a massive page count, could this loop run for hours without
responding to SIGKILL and effectively cause a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918115741.3791=
682-1-weh@linux.microsoft.com?part=3D6
