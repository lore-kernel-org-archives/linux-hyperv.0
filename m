Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540272;
	b=hlJv69mQn//+srzEuCMES1kuMBNi5U0hEqNrjPZ8/SPmD28++RYdGclFGKVCSyB6k2Xt
	 4qYp9P5XA40nC7fBhv4o6i9fqW3Qa/JUqBntq44YhOQiOd5f+y9lrtuGoUWVsW5mlIMjB
	 G3q+Dhm8yVUA8oHSXHiy9mTNEM8eTcVH5HV/Jn/wtq2EkzV/cykRmP8tLzwOKQfaVIri7
	 TzCpClstUReMvqVHMmxtN/VpHskGkhrQv6CA1Yp4rcQx32MymfjQvH3+T15Knuw6dJevQ
	 3fxw1ouuM/QJNlENWOIyh8+YsKtozXOix+ZvAtWUK8J7lyDrIUjF+qCQcSM+IzX3s5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mH2EuAEn9pNRh1OjAxPEMO7mM63iU3hd+y/zR1C/BQI=;
	b=EDGDNsqxbGSXWnp1OMscWsMRC6fnxz2TH+IT1G/PY5oFZPILkWaBdwha45Kq6ZwsD2Pm
	 jYNrW6IMxRb6G9H6jXuA9Rt8i2DV7y3Re6K/jrIahQxcUVtDEQBt/80a5JeQxGx6C80+H
	 lX3B01YY2Ml7uuL9hWTfviailkKUtjs/aB+MUN/K4/S0fAd9TffZbsLGnLQGeB50IZAZw
	 Bx35pyaWIMJNkADnw1GjxfNuLYG+UB7erMBZYcF9QnIBWwmi2W9UUu1a3/ag2Z7Zw5oeI
	 ZBHH7Y/40hohVXzRq4wZaYXChN8fVMtqColQQZcn4jNar8P7iGbC8dCGjd8NiW34P0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVXPXeIh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEC606A321
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Nov 2026 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVXPXeIh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2401F000C4;
	Fri, 13 Nov 2026 03:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540272;
	bh=mH2EuAEn9pNRh1OjAxPEMO7mM63iU3hd+y/zR1C/BQI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MVXPXeIh193G4/vgnc1taXOzfAEyYMkdDHbGAxB+ll0M99RHgDNEVCU9nVCCKwi1N
	 DGiEs5BOVIye3l/3o+o+jyfRbFcBGkifNc1run/DO2XRvIOTXE0Dtu5JXjwcRzssJ8
	 fFSgwU/dujKwyQY3Sh09j7Oe+yybka10xW/K9p0ISTtLezva7Y7kBw8lx5fQf1HRPo
	 4ZguIn2ytF8VcLliWmle0aygoPHQpAvHjYsjKKdX9EYx/P723oO8DPdIAw7KwTzqZh
	 r559oNbP9Mb7N/gY8kS89T+G4u6hHzzJ5Tzg/rvm9+4k06CSJF2e6WBVX1LUuLDaq5
	 QKozOXenioWqg==
Message-ID: <sashiko-outbox-212132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: Do not map mmio in map user memory ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261113031343.896489-1-mrathor@linux.microsoft.com>
References: <20261113031343.896489-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:24:31 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mshv: missing Fixes trailer on commit fixing crash in
  mshv_map_user_memory()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] mshv: ignored mshv_region_map() error in
  mshv_prepare_pinned_region() [1]
--

commit f8208ba7fc5113c6d67967e4650125ea72fda573
Author: Mukesh R <mrathor@linux.microsoft.com>

> mshv: Do not map mmio in map user memory ioctl
>
> Currently, mshv_map_user_memory() snoops into vma to get the mmio
> pfn via vm_pgoff. The mmio pfn is no longer stored there and will
> cause the system to crash. Moreover, it is not legit to obtain
> mmio pfn via that method. So, remove upfront mmio mappings, just
> create region and do basic checks. The mmio entries will be populated
> on demand during intercepts in future.
>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

[Severity: Low]
This fixes a system crash when mapping MMIO memory regions.  Should this
include:

  Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /=
dev/mshv to VMMs")

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc2cfce2aefdb..f1f143e32c078 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1345,16 +1345,8 @@ static int mshv_prepare_pinned_region(struct mshv_=
mem_region *region)
>  }
> =20
>  /*
> - * This maps two things: guest RAM and for pci passthru mmio space.
> - *
> - * mmio:
> - *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
> - *  - Two things need to happen for mapping mmio range:
> - *	1. mapped in the uaddr so VMM can access it.
> - *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
> - *
> - *   This function takes care of the second. The first one is managed by=
 vfio,
> - *   and hence is taken care of via vfio_pci_mmap_fault().
> + * This is called for both user ram and mmio space. The mmio space is not
> + * mapped here, that should happen later during intercept on demand.
>   */
>  static long
>  mshv_map_user_memory(struct mshv_partition *partition,
> @@ -1363,7 +1355,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  	struct mshv_mem_region *region;
>  	struct vm_area_struct *vma;
>  	bool is_mmio;
> -	ulong mmio_pfn;
> +	size_t vma_sz;
>  	long ret;
> =20
>  	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> @@ -1373,12 +1365,18 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  	mmap_read_lock(current->mm);
>  	vma =3D vma_lookup(current->mm, mem->userspace_addr);
>  	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
> -	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
> +	if (vma && is_mmio)
> +		vma_sz =3D vma->vm_end - mem->userspace_addr;
>  	mmap_read_unlock(current->mm);
> =20
>  	if (!vma)
>  		return -EINVAL;
> =20
> +	if (is_mmio)
> +		/* Upon mmio intercept, entire region is mapped */
> +		if (mem->size > vma_sz)
> +			return -EPERM;
> +
>  	ret =3D mshv_partition_create_region(partition, mem, &region,
>  					   is_mmio);
>  	if (ret)
> @@ -1399,11 +1397,7 @@ mshv_map_user_memory(struct mshv_partition *partit=
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

[Severity: Medium]
This problem wasn't introduced by this patch, but does
mshv_prepare_pinned_region() ignore mshv_region_map() errors on
non-encrypted partitions [1]?

drivers/hv/mshv_root_main.c:mshv_prepare_pinned_region() {
    ...
	ret =3D mshv_region_map(region);
	if (ret && mshv_partition_encrypted(partition)) {
		int shrc;

		shrc =3D mshv_region_share(region);
		if (!shrc)
			goto invalidate_region;
    ...
		goto err_out;
	}

	return 0;

invalidate_region:
	mshv_region_invalidate(region);
err_out:
	return ret;
}

When mshv_region_movable_init() fails on a non-encrypted partition,
mshv_partition_create_region() falls back to MSHV_REGION_TYPE_MEM_PINNED.
If mshv_region_map() then fails, mshv_prepare_pinned_region() skips
mshv_region_invalidate() and returns 0, so mshv_map_user_memory() links the
unmapped region into partition->pt_mem_regions with its pages left pinned
and returns success to userspace.

[1] https://sashiko.dev/#/bug/linux-a3d211d1-2dbc-4947-880d-f5809ec51869

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113031343.8964=
89-1-mrathor@linux.microsoft.com?part=3D1
