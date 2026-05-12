Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229405A79B;
	Tue, 12 May 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629544; cv=none; b=SGHHi1ImWFmLiGry/FiGrur46nUnGqyu4u/ySwlkajJkDiWocRrQquXljSq7zOKc/uij81mU7FvJM4p1cLKfUgkxw0v2cXv3moSzxoooW4XhSdTkmnCh1GalUx4qply9j5y0jh74WZoXL0CSrFjefqI5dV5KYQozpMSGlts+xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629544; c=relaxed/simple;
	bh=rl1zwlOa+WIujXAw0ds2mSTWlr+YC8oavRcTq7BCqgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTVIyKP9yNdB8gBFSFsT6ukP8clIK6czMNORrv4riGXxaL+2K52cRGOvYmElLjg0bH3PnFerqY9fv4ltxtUgp3S4QESAlT2KhuEw7ZDd4+XLRQhDqbFE1d4zjez0MyeCaqpal8SqVeBmKx9pdYlj0Obatb6kLlEZyB8mgKDh/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBAOSswF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBAOSswF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6BC2BCB0;
	Tue, 12 May 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629543;
	bh=rl1zwlOa+WIujXAw0ds2mSTWlr+YC8oavRcTq7BCqgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BBAOSswFxcWaJqNHJ0GiCx6l6BCLqTNViovfPlrVFu2nCRraWwpvkz5lqL6LH8tw/
	 w+olDLOWU9a04zNi+rBTXg04844bJ5O87RUyLAKPBVVsWwBoEvrVj23PW1VoxUQRzR
	 uBApnkmN9YarT2gtEKhPbnm44BcYzbm+jrxuh4rGx1X2rup7MWj6AvhIS1RxrGeYBi
	 vxLATgOMOuvVL5UJYhcW9FxIZkbSkf543LwbZsLbqUumPibau7O7YkDRzEHqNYl0s5
	 glWpGRHDtABzOQOLnaQOhZ3GEvRDBVResg6i9bI0JTi0pXS8uLw94cWhuO8N1f/POB
	 v1onNpLKHnyGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:45:39 +0000
Message-Id: <20260512234543.A2E6BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] hv_iommu_fill_iova_list() incorrectly uses guest PAGE_SHIFT in=
stead of hypervisor HV_HYP_PAGE_SHIFT, causing incomplete and incorrect IOT=
LB flushes on architectures with non-4KB pages.
- [High] Unconditional use of the new HVCALL_FLUSH_DEVICE_DOMAIN_LIST hyper=
call without a capability check or fallback.
- [Medium] Bitfield assignment on uninitialized flexible array member cause=
s KMSAN use-of-uninitialized-value warnings.
--

commit 5fd02fd07f9fbc4f1734f312b8a33dfd79a38961
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add page-selective IOTLB flush support

This patch adds page-selective IOTLB flush support using the
HVCALL_FLUSH_DEVICE_DOMAIN_LIST hypercall. It decomposes IOVA ranges into
aligned power-of-two regions to fit in a single hypercall page, falling
back to a full domain flush if the range exceeds page capacity.

> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> index e5fc625314b55..3bca362b78150 100644
> --- a/drivers/iommu/hyperv/iommu.c
> +++ b/drivers/iommu/hyperv/iommu.c

[ ... ]

> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_=
list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;

Should this use HV_HYP_PAGE_SHIFT instead of PAGE_SHIFT?

If the kernel is compiled with a larger page size (like 64KB on ARM64),
start >> PAGE_SHIFT produces a 64KB guest PFN.

Since Hyper-V hypercalls expect 4KB PFNs (HV_HYP_PAGE_SHIFT =3D 12), this c=
ould
result in flushing the wrong pages and leaving stale DMA mappings active.

> +	unsigned long nr_pages =3D end_pfn - start_pfn;
> +	u16 count =3D 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align =3D __ffs(start_pfn);
> +		else
> +			pfn_align =3D BITS_PER_LONG - 1;
> +
> +		size_align =3D __fls(nr_pages);
> +		order =3D min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift =3D order;
> +		iova_list[count].page_number =3D start_pfn;

Could this assignment trigger a KMSAN use-of-uninitialized-value warning?

The input buffer is from a per-CPU page and memset in
hv_flush_device_domain_list() only zeroes the fixed-size header, leaving the
flexible array uninitialized.

Assigning to bitfields forces a read-modify-write on the uninitialized 64-b=
it
union hv_iommu_flush_va.

> +
> +		flush_pages =3D 1UL << order;
> +		start_pfn +=3D flush_pages;
> +		nr_pages -=3D flush_pages;
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
> +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domai=
n,
> +					struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	u64 status;
> +	u16 count;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain_list *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> +	count =3D hv_iommu_fill_iova_list(input->iova_list,
> +					iotlb_gather->start,
> +					iotlb_gather->end);
> +	if (count =3D=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> +		/*
> +		 * Range exceeds hypercall page capacity. Fall back to a full
> +		 * domain flush.
> +		 */
> +		struct hv_input_flush_device_domain *flush_all =3D (void *)input;
> +
> +		memset(flush_all, 0, sizeof(*flush_all));
> +		flush_all->device_domain =3D hv_domain->device_domain;
> +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> +					flush_all, NULL);
> +	} else {
> +		status =3D hv_do_rep_hypercall(
> +				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> +				count, 0, input, NULL);
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", status=
);

Does this code need a capability check or fallback for older hosts?

If the hypervisor doesn't support the new HVCALL_FLUSH_DEVICE_DOMAIN_LIST
hypercall, hv_do_rep_hypercall() might return an error status.

The code prints an error but doesn't fall back to HVCALL_FLUSH_DEVICE_DOMAI=
N,
potentially leaving the IOTLB unflushed.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511162408.1180=
069-1-zhangyu1@linux.microsoft.com?part=3D4
