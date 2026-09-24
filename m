Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705748094D;
	Thu, 24 Sep 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256964; cv=none; b=Th7ZFLojxUgvxfhUOXjO4imzkG2YaLE5zF2Uf2kc5z2i1CZzcKWO7KmfgQwplltpVdrhA5a6Cbkw9bkZbZj1z3apRrs6Lc3jU8moFL6PHkyDwNKqJSVSNu/vUrJQniX1xvFW25tVA4ptM1WBc836Yrx/VQwY/MNakUqON+dqlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256964; c=relaxed/simple;
	bh=5U72Wm7yfEWJHFOYCiJL/eGjgoxMt4uzqoM5WeTeix0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAkxsbuMCZNof/PARubBaOUDZl5q1ZZ7jHTV7hhZt5nLxS0qpGtA2WFQN4TjIKr32FOPGZndi/5jAHeslsT/G9LJt37ElRJloZybutYVh3uTdWmgYU1e45YMMGqe/d2I5qEdEyzY+JdlhAH01qrlCdmMwCThET6GIWQW6geI65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2F7E41C7465;
	Thu, 24 Sep 2026 15:35:55 +0200 (CEST)
Date: Thu, 24 Sep 2026 15:35:54 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com, 
	jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Message-ID: <arUkaFhYGxaYwL0L@8bytes.org>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924020221.128762-4-mrathor@linux.microsoft.com>

On Wed, Sep 23, 2026 at 07:02:21PM -0700, Mukesh R wrote:
> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
> +	u32 map_flags;
> +	int ret;
> +	u64 status = 0;
> +	ulong npages, sav_iova = iova, done = 0;
> +	struct hv_domain *hvdom = to_hv_domain(immdom);
> +	phys_addr_t sav_paddr = paddr;
> +	size_t done_size, size = pgsize * pgcount;
> +
> +	map_flags = HV_MAP_GPA_READABLE;	/* required */
> +	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +	while (done < npages) {
> +		ulong completed, remain = npages - done;
> +
> +		remain = min(remain, HV_MAP_DEVICE_GPA_BATCH_SIZE);
> +
> +		status = hv_iommu_map_pgs(hvdom, iova, paddr, remain,
> +					  map_flags);
> +
> +		completed = hv_repcomp(status);
> +		done = done + completed;
> +		iova = iova + (completed << HV_HYP_PAGE_SHIFT);
> +		paddr = paddr + (completed << HV_HYP_PAGE_SHIFT);
> +
> +		if (hv_result_needs_memory(status)) {
> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    256);

hv_call_deposit_pages() can sleep and must not be called when gfp == GFP_ATOMIC.

> +			if (ret)
> +				break;
> +			continue;
> +		}
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	done_size = done << HV_HYP_PAGE_SHIFT;
> +
> +	if (mapped)
> +		*mapped = done_size;
> +
> +	if (done_size == 0)
> +		return hv_result_to_errno(status);
> +
> +	ret = hv_iommu_add_tree_mapping(hvdom, sav_iova, sav_paddr, done_size,
> +					map_flags);
> +	if (ret) {
> +		size = hv_iommu_hyp_unmap_pages(immdom, sav_iova, done_size);
> +		if (size != done_size)
> +			WARN(1, "Failed to unmap exact sizes(%lx/%lx)\n",
> +			     done_size, size);
> +		if (mapped)
> +			*mapped = done_size - size;
> +
> +		return ret;
> +	}

A general question: Why is the tree mapping added after the hypervisor mappings
are established. It seems easier and more robust the other way around.  Same on
the unmap path which should use strictly the reverse order.

With this order, if adding a tree entry fails and the unmap only partially
succeeds, it ends up with a partial mapping which can not be unmapped anymore
because there is no tree entry.

> +static int __init hv_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup = &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc = hv_iommu_get_caps(&caps);
> +	if (rc)
> +		return rc;
> +

The capabilities returned need more checking. I think at least it needs a check
for HV_IOMMU_CAP_PRESENT and that PAGE_SIZE is set in the pgsize_bitmap.

> +	hv_iommu_max_iova = ((ulong)1 << caps.max_iova_width) - 1;

This is undefined behavior if caps.max_iova_width == 64. Better use DMA_BIT_MASK().

