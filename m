Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2443B6FA;
	Wed,  8 Jul 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514614; cv=none; b=gk0cTzVfJhFFIX/9yMf5D68rcHDa9QBlmp9gdD9E26GbuiFIF824DHwNxQ1H1vhn28SO7YcH6WEIA9GS9ry/SS5z7XD2oWots9UdFI09PSksNINQY1iEmvPuoyHj3sU7uPEb7VWCspyH7NE2N8rYCmfA5m2apmdIWo1kTqF+iNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514614; c=relaxed/simple;
	bh=YPSlorxvKGGGAn9rS2DCDvIqf9nDCHFr8SvpqVkku20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQgt5ltGdqz6o3Znd/EYCL0vq3iigz5J7JrnYVgnfAhnoXxHJexWvdr/IOOD6vIDbY4pRSdS+xFOG+0KFqo6a2Cphq/Ip+imb6PC1W4umZzEcChn/3afgUCHbePLdxl2VSM30tH3z7+Rf+Ce7fQYUrjh7nKDHXbAlIQmsigH7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nraVjsSR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nraVjsSR"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAE2620B7166;
	Wed,  8 Jul 2026 05:43:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAE2620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783514607;
	bh=dfjsnvM8L5ZEJeKFiMUV10x0T6Aph9uTpWPOLGW1LMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nraVjsSRVBgKsrN/h1nM6C7JA7jJ0k9gFZTfs+/Og9Z0dB8pNTZbK2UGbxLjIPgD+
	 AImB40Rw+RgziAN2jG3RnRhpc+xCs/JTeB2KD9br3fpd2m18sVMnGQ+eqPF77kfWQy
	 jGDtWc2Guou3/dC2yGgQKSTHfAPwmY0Ov3BmpkGY=
Date: Wed, 8 Jul 2026 20:43:28 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, mhklinux@outlook.com, 
	jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <x2aatvemtx5sjnkcudcj6q5uwsjg533kiitqmg7lriknsfcd5c@t3ohzsw3ylr3>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
 <20260703171018.GA1968184@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703171018.GA1968184@ziepe.ca>

On Fri, Jul 03, 2026 at 02:10:18PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 03, 2026 at 12:05:18AM +0800, Yu Zhang wrote:
> 
> > @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> >  	hv_flush_device_domain(to_hv_iommu_domain(domain));
> >  }
> >  
> > +/*
> > + * Calculate the minimal power-of-two aligned range that covers [start, end]
> > + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> > + * descriptor that may over-flush when the range is not naturally aligned.
> > + */
> > +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> > +				       union hv_iommu_flush_va *va)
> > +{
> > +	unsigned long start_pfn = HVPFN_DOWN(start);
> > +	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;
> 
> Pedantically end can be ULONG_MAX, you shouldn't be adding to it since
> it will overflow.
> 

Good catch!

> > +	unsigned long mask_shift, aligned_pfn;
> > +
> > +	if (start_pfn == last_pfn) {
> > +		mask_shift = 0;
> > +	} else {
> > +		/*
> > +		 * Find the highest bit position where start_pfn and last_pfn
> > +		 * differ.  A range aligned to one above that bit is the
> > +		 * smallest power-of-two region that covers both endpoints.
> > +		 */
> > +		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
> > +	}
> > +
> > +	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);
> 
> I think the whole thing is simpler if it stays using bytes until the end:
> 
> 	sz_lg2 = __fls(gather->start ^ gather->end);
> 	if (sz_lg2 < HV_PAGE_SHIFT)
> 		cmd.sz_lg2 = HV_PAGE_SHIFT;
> 
> 	page_number = (gather->start & ~(1UL << sz_lg2)) >> HV_PAGE_SHIFT;
> 	page_mask_shift = sz_lg2 - HV_PAGE_SIFT;
> 
> No overflows that way either
> 

Indeed. It is much cleaner. Will rewrite using this logic.

B.R.
Yu
> Jason
> 
