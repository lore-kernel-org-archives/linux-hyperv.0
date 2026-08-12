Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727853E3D92;
	Wed, 12 Aug 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525113; cv=none; b=BFCSJQvbwxkNgvv3unON7oJX3lAoHLFUeIA4dzgC73/qTJhO+37+gAQXr1LCag+wSEruWTlGxShcsmeoAzxeqGNTcs0xMIevDHbtA39Ksbsg6D8JrxP3EYdNQbG7f//Snw+D/zVbamr5iox+YAipHxsVQJxImsfqxX/A9xaqlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525113; c=relaxed/simple;
	bh=OVYMLfjmw3Kq858GaqkEYiNHUNBJcqM/UGCNQ/I5G5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCH9Vd+vUSvscyMSIZkp5ddfpkV+nXEFXu6KpzBE2vygpaQOV8AFPgSqIBRBitI+kzHkUbivCjfd7wha/umQoplsZhqFt5eRYY5bMRNDRj7mD+WeSvm3BNq9asdg2+VUoMICW1Bpv+u/djXRkpa+yq94GC4YDBXjFTgeYg+3jBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jNDaS3nz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jNDaS3nz"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63F3B20B7167;
	Wed, 12 Aug 2026 01:58:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63F3B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786525086;
	bh=BtjlLWYfdR0leu278nI7w2GiJtrtZ2QXn9PMqPnl5Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNDaS3nzAn6gK60FhGOusb2QJESEfmYd1VbviyvmHDj0mB3212Y+MMYzAy6D0qo8p
	 6Z23YEfDxJJbgtD3+W7ejaM/XTkwHC3b2pnH4kEOpii0j30LXDr42DcOLp0V6JGGqB
	 LEdjKnCw+H0+InOebdJQEUjtp34gsfCdV1hlMS1U=
Date: Wed, 12 Aug 2026 16:58:28 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, 
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <obiixds667qdhv5upqdpxmgrvrvp3bl5gfbpingvog2vzbexhg@b7n4fpfbkff5>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
 <20260811162124.GK544626@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811162124.GK544626@ziepe.ca>

On Tue, Aug 11, 2026 at 01:21:24PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 11, 2026 at 11:50:19PM +0800, Yu Zhang wrote:
> > @@ -50,8 +50,6 @@
> >  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
> >  
> >  /* Reserved IOVA ranges */
> > -#define MSI_RANGE_START		(0xfee00000)
> > -#define MSI_RANGE_END		(0xfeefffff)
> >  #define HT_RANGE_START		(0xfd00000000ULL)
> >  #define HT_RANGE_END		(0xffffffffffULL)
> >  
> > @@ -3097,8 +3095,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
> >  		list_add_tail(&region->list, head);
> >  	}
> >  
> > -	region = iommu_alloc_resv_region(MSI_RANGE_START,
> > -					 MSI_RANGE_END - MSI_RANGE_START + 1,
> > +	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
> > +					 X86_IOMMU_MSI_RANGE_END -
> > +					 X86_IOMMU_MSI_RANGE_START + 1,
> >  					 0, IOMMU_RESV_MSI, GFP_KERNEL);
> 
> Maybe instead of adding constants you should add a
> iommu_alloc_resv_x86_msi_region()
> 
> That is just an inline doing the above?
> 

Thank you, Jason!
Do you mean something like below?

-#define X86_IOMMU_MSI_RANGE_START        0xfee00000
-#define X86_IOMMU_MSI_RANGE_END          0xfeefffff
+static inline struct iommu_resv_region *
+iommu_alloc_resv_x86_msi_region(void)
+{
+       return iommu_alloc_resv_region(0xfee00000, SZ_1M, 0,
+                                      IOMMU_RESV_MSI, GFP_KERNEL);
+}

So all the drivers(Intel vt-d, AMD IOMMU, and Hyper-V pvIOMMU) can just
call iommu_alloc_resv_x86_msi_region() directly. :)

B.R.
Yu
> Jason
> 
