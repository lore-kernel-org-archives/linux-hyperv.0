Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4E46AF1A;
	Fri, 14 Aug 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709257; cv=none; b=XPO8ApdEh3oT5NXavKeR+ii346YL4agEobSPzCtJ9HeDEOuiWA+Aa3wztMHsINFoFmkIyMom4dNUZPo6x30qc09g5aBZeZy7fzWqOa8UamLXqFqP7/foUVX3DoWHv3vIsyVvSzAIdKL8mLdmRbojtvnUPITH29YXFt7ytrQMJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709257; c=relaxed/simple;
	bh=B0yG6yh7f0/AQOL6k/GXCi8xwl/S8YVnFP4bkYgGJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqJ0SE49PNiyeAtx7eV9TjMLUcEILKPUF3j9WiFwInDEhoVMnJPcgUrrA3N/XaVd+rAd1FhpHrUkb7a0W8HJdTR6beKPfyJuSttHC2sagFInFV9Ml0i6LI6OF5nLfLIF59wbc0MaPLiRZpsLdZGqJ30LUWzJfJBH2Q5EIDngURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TqBc8bEI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TqBc8bEI"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6AF6A20B7168;
	Fri, 14 Aug 2026 05:07:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF6A20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786709228;
	bh=1tXkiNi9emUJSms0+jEWDbzQtflkc93S/WX9UGPJMf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqBc8bEIxgtVCYk3yuvuiT1IQcMPS3BxbvwqYSAPIZPdIJdUzBf27ZxG/SLb6Uy+U
	 928Psg4bQ3g46lHu7DoM5yh8DKOnfahfoSZvsXeucAjYpL67zFsBNsBHlJ7voDgVzW
	 7ibFSVXo9A4bXvjnQIR6USd5Baf7eE19TxY7FFEE=
Date: Fri, 14 Aug 2026 20:07:32 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <ocsfhdlxqoavboz3hv62377g4sfjxu462lusc6fjyc5nrbzb3c@otc5irbfrzin>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-6-zhangyu1@linux.microsoft.com>
 <20260813160713.00004f95@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813160713.00004f95@linux.microsoft.com>

On Thu, Aug 13, 2026 at 04:07:13PM -0700, Jacob Pan wrote:
> Hi Yu,
> 
> On Tue, 11 Aug 2026 23:50:21 +0800
> Yu Zhang <zhangyu1@linux.microsoft.com> wrote:
> 
> > Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> > This hypercall accepts a list of (page_number, page_mask_shift)
> > entries, enabling finer-grained IOTLB invalidation compared to the
> > domain-wide HVCALL_FLUSH_DEVICE_DOMAIN used by
> > hv_iommu_flush_iotlb_all().
> > 
> > hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> > range that covers the target IOVA region, producing a single flush
> > descriptor. This may over-flush when the range is not naturally
> > aligned, matching the approach used by Intel VT-d PSI. If the
> > page-selective flush fails, the code falls back to a full domain
> > flush.
> > 
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >  drivers/iommu/hyperv/hv-iommu-guest.c | 73
> > ++++++++++++++++++++++++++- include/hyperv/hvgdk_mini.h           |
> > 1 + include/hyperv/hvhdk_mini.h           | 17 +++++++
> >  3 files changed, 90 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c
> > b/drivers/iommu/hyperv/hv-iommu-guest.c index
> > 2a00353ce733..060c2efd6bf0 100644 ---
> > a/drivers/iommu/hyperv/hv-iommu-guest.c +++
> > b/drivers/iommu/hyperv/hv-iommu-guest.c @@ -9,6 +9,7 @@
> >  #define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> >  #define dev_fmt(fmt) pr_fmt(fmt)
> >  
> > +#include <linux/hyperv.h>
> why need this?
> 

It's not needed. Thanks!

> >  #include <linux/iommu.h>
> >  #include <linux/pci.h>
> >  #include <linux/dma-map-ops.h>
> > @@ -408,10 +409,79 @@ static void hv_iommu_flush_iotlb_all(struct
> > iommu_domain *domain)
> > hv_flush_device_domain(to_hv_iommu_domain(domain)); }
> >  
> > +/*
> > + * Calculate the minimal power-of-two aligned range that covers
> > [start, end]
> > + * (end is inclusive). Returns a single (page_number,
> > page_mask_shift)
> > + * descriptor that may over-flush when the range is not naturally
> > aligned.
> > + */
> > +static void
> > +hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> > +			  union hv_iommu_flush_va *va)
> > +{
> > +	unsigned int sz_lg2;
> > +
> > +	sz_lg2 = fls_long(start ^ end);
> > +	if (sz_lg2 < HV_HYP_PAGE_SHIFT)
> > +		sz_lg2 = HV_HYP_PAGE_SHIFT;
> > +
> > +	/*
> > +	 * A valid IOVA range shall not span bit 63. Use the maximum
> > mask
> > +	 * so the host can safely perform a full flush.
> > +	 */
> > +	if (WARN_ON_ONCE(sz_lg2 >= BITS_PER_LONG)) {
> > +		va->as_uint64 = 0;
> > +		va->page_mask_shift =
> > +			BITS_PER_LONG - HV_HYP_PAGE_SHIFT;
> > +		return;
> > +	}
> > +
> > +	va->page_number =
> > +		(start & GENMASK(BITS_PER_LONG - 1, sz_lg2)) >>
> > +		HV_HYP_PAGE_SHIFT;
> > +	va->page_mask_shift = sz_lg2 - HV_HYP_PAGE_SHIFT;
> > +}
> > +
> > +static void hv_flush_device_domain_list(struct hv_iommu_domain
> > *hv_domain,
> > +					struct iommu_iotlb_gather
> > *iotlb_gather) +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_flush_device_domain_list *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	/* Clear the fixed header and the single range entry. */
> > +	memset(input, 0, struct_size(input, iova_list, 1));
> > +
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->flags |= HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> > +	hv_iommu_calc_flush_range(iotlb_gather->start,
> > iotlb_gather->end,
> > +				  &input->iova_list[0]);
> > +
> > +	status = hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> > +				     1, 0, input, NULL);
> > +
> > +	if (WARN_ON_ONCE(!hv_result_success(status))) {
> > +		/* Page-selective flush failed, fall back to full
> > flush. */
> > +		struct hv_input_flush_device_domain *flush_all =
> > (void *)input; +
> > +		memset(flush_all, 0, sizeof(*flush_all));
> > +		flush_all->device_domain = hv_domain->device_domain;
> > +		status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> > +					 flush_all, NULL);
> > +		WARN(!hv_result_success(status),
> > +		     "HVCALL_FLUSH_DEVICE_DOMAIN fallback also
> > failed: %lld\n",
> > +		     status);
> > +	}
> > +
> > +	local_irq_restore(flags);
> > +}
> > +
> >  static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> >  				struct iommu_iotlb_gather
> > *iotlb_gather) {
> > -	hv_flush_device_domain(to_hv_iommu_domain(domain));
> > +	hv_flush_device_domain_list(to_hv_iommu_domain(domain),
> > iotlb_gather); 
> >  	iommu_put_pages_list(&iotlb_gather->freelist);
> Maybe add a comment explaining that HVCALL_FLUSH_DEVICE_DOMAIN_LIST
> covers non-leaf/walk caches, therefore it is safe to put freelist.
> 

Yes, the hypercall also invalidates the non-leaf page-walk caches,                                                                               ┃
Will document that.

B.R.
Yu
> >  }
> > @@ -464,6 +534,7 @@ static struct iommu_domain
> > *hv_iommu_domain_alloc_paging(struct device *dev) 
> >  	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
> >  	cfg.common.hw_max_oasz_lg2 = 52;
> > +	cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
> >  	/*
> >  	 * Hyper-V S1 domains use a 4-level root for IOVA widths up
> > to
> >  	 * 48 bits. A 5-level root is used only for wider apertures
> > when diff --git a/include/hyperv/hvgdk_mini.h
> > b/include/hyperv/hvgdk_mini.h index 5bdbb44da112..eaaf87171478 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -496,6 +496,7 @@ union hv_vp_assist_msr_contents {	 /*
> > HV_REGISTER_VP_ASSIST_PAGE */ #define
> > HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9 #define
> > HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce #define
> > HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0 +#define
> > HVCALL_FLUSH_DEVICE_DOMAIN_LIST			0x00d1 #define
> > HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7 #define
> > HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8 #define
> > HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db diff
> > --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index 1e3eac99886a..25671ee7056d 100644 ---
> > a/include/hyperv/hvhdk_mini.h +++ b/include/hyperv/hvhdk_mini.h
> > @@ -674,4 +674,21 @@ struct hv_input_flush_device_domain {
> >  	u32 reserved;
> >  } __packed;
> >  
> > +union hv_iommu_flush_va {
> > +	u64 as_uint64;
> > +	struct {
> > +		u64 page_mask_shift : 6;
> > +		u64 reserved : 6;
> > +		u64 page_number : 52;
> > +	};
> > +} __packed;
> > +
> > +struct hv_input_flush_device_domain_list {
> > +	struct hv_input_device_domain device_domain;
> > +#define HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT BIT(0)
> > +	u32 flags;
> > +	u32 reserved;
> > +	union hv_iommu_flush_va iova_list[];
> > +} __packed;
> > +
> >  #endif /* _HV_HVHDK_MINI_H */
> 
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
