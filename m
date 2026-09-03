Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2A34EF0C;
	Thu,  3 Sep 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422948; cv=none; b=T3ClXMgskTtVehJB/AWma0hUweHejoxi8TsuZAIrRVZ662oZbmQ5hueY+v3xREw8Fqm+x94emrhDx3ZdsnVKF0hKbUY85Cu9ASQFlupMGljxtKfySAnDZ50f8vENB8rEbji+CAmISSd5UggTEpH+6E6kAbCuZwdpfVdoaqCp8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422948; c=relaxed/simple;
	bh=PYugPtjDD1Mwk+el5B4K6YHEudIcSNGBIqf4q6MNBVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUqynkyv8sg/GcWqNPI9cmESaQIaOMUpAz7/GabpNCSHipk+lP1EnhJqmSR94feXh5alwfh2LSrAJzwkmjPzgZTkTyNNEGcGhPcwWG/ut2jWdXlnvFOluuERV6s/OE3G8RRpQqWtaToaARvbL8eIlBAqoh9TQiKPkKG/SL4HN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f825k/uP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f825k/uP"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87D8520B712D;
	Thu,  3 Sep 2026 01:08:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87D8520B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788422909;
	bh=d+Zmca6npV9UBXDa9I7AGekjWXpzMKRIXE0F48nBe/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f825k/uPe3Egp/7Z97LpFknzMCZzxQIhFtaDudQErs7D6aob/qNvOFoJwbC4fXH7k
	 6Kk+93xULpkmPlVHJZYVdbLk1s5qL5IANfV2NCHPs81Zbw+pS1XJrjGwYICQYxKzrO
	 /oicEy561IhCPrvF6b4LnXqhTdHqRwGi2dnZW0Ns=
Date: Thu, 3 Sep 2026 16:09:03 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, 
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <dtnop2zqoxjchln5g6jnaz36jnsximf7dxzpt3nkkndgmtdnc3@bhhctyj4dpf4>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-6-zhangyu1@linux.microsoft.com>
 <BN7PR02MB41483DDDB70A211BC320BE03D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN7PR02MB41483DDDB70A211BC320BE03D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>

On Fri, Aug 28, 2026 at 05:22:48PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026 6:27 AM
> > 
> > Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> > This hypercall accepts a list of (page_number, page_mask_shift) entries,
> > enabling finer-grained IOTLB invalidation compared to the domain-wide
> > HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
> > 
> > hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> > range that covers the target IOVA region, producing a single flush
> > descriptor. This may over-flush when the range is not naturally aligned,
> > matching the approach used by Intel VT-d PSI. If the page-selective
> > flush fails, the code falls back to a full domain flush.
> > 
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/hyperv/hv-iommu-guest.c | 76 ++++++++++++++++++++++++++-
> >  include/hyperv/hvgdk_mini.h           |  1 +
> >  include/hyperv/hvhdk_mini.h           | 18 +++++++
> >  3 files changed, 94 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> > index 2169333020f4..3e38046bd998 100644
> > --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> > +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> > @@ -396,11 +396,84 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> >  	hv_flush_device_domain(to_hv_iommu_domain(domain));
> >  }
> > 
> > +/*
> > + * Calculate the minimal power-of-two aligned range that covers [start, end]
> > + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> > + * descriptor that may over-flush when the range is not naturally aligned.
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
> 
> Use the max() function here instead of open coding it?
> 
> 	sz_lg2 = max(fls_long(start ^ end), HV_HYP_PAGE_SHIFT);
> 
> But maybe that's just more obscure. Your call.
> 

The  max()  form looks clear to me. Thanks!

> > +
> > +	/*
> > +	 * A valid IOVA range shall not span bit 63. Use the maximum mask
> > +	 * so the host can safely perform a full flush.
> > +	 */
> > +	if (WARN_ON_ONCE(sz_lg2 >= BITS_PER_LONG)) {
> > +		va->as_uint64 = 0;
> > +		va->page_mask_shift =
> > +			BITS_PER_LONG - HV_HYP_PAGE_SHIFT;
> 
> This case is handled slightly inconsistently with the main case.
> Here the entire 64 bits are cleared, which implicitly sets the
> page_number field to zero and also clears the reserved field.
> The main case sets the page_number but doesn't clear the
> reserved field. The memset() in hv_flush_device_domain_list()
> assumes that the reserved field might not be zeroed. I'd just
> suggest making everything consistent and not doing any
> duplicate zero'ing.
> 
Agreed. The caller already clears the fixed header and the range entry.
I'd like to remove the duplicate as_uint64 assignment and explicitly set
page_number to 0 here(for the overflow case), leaving the reserved bits
consistently initialized by the caller. 

> > +		return;
> > +	}
> > +
> > +	va->page_number =
> > +		(start & GENMASK(BITS_PER_LONG - 1, sz_lg2)) >>
> > +		HV_HYP_PAGE_SHIFT;
> > +	va->page_mask_shift = sz_lg2 - HV_HYP_PAGE_SHIFT;
> > +}
> > +
> > +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domain,
> > +					struct iommu_iotlb_gather *iotlb_gather)
> > +{
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
> > +	hv_iommu_calc_flush_range(iotlb_gather->start, iotlb_gather->end,
> > +				  &input->iova_list[0]);
> > +
> > +	status = hv_do_rep_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> > +				     1, 0, input, NULL);
> > +
> > +	if (WARN_ON_ONCE(!hv_result_success(status))) {
> 
> I'd suggest having a message here with the status. The list flush really
> should not be failing, so outputting the status might provide a clue
> as to what's going on if it does fail.
> 

Sure. Thanks!

B.R.
Yu
