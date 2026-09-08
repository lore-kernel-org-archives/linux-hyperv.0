Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C51D5174;
	Tue,  8 Sep 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837383; cv=none; b=UhqaRzlSYWzy1sxzEmGdITzhov/HsoZ04MDp76cFEjNwt7cSo5wC2fPyHEHDfqpa+/7ggp+EWEKm+U6DEgknkVmX0EeyS1a/vyWwLtVxhCFPyLzapN2/woOuZNscxmLdZ+vOvibslyYVU1sug8wpA9AH+XroyFzqqZX6EUqcYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837383; c=relaxed/simple;
	bh=0SOAYylIn/iT32ZuhYhnLeMtvTFzELG1v5iufdQHD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHTETcemSjCw33pqV45SwB+Fvhscm1odFAWcx4nFnTzCX1G6nuBXkV9pOT94QDnZW8fYxl1Zwiu8KWFjo+35ai1qZOfslwtw8Gp4TEpZyxnz5E7rQXHh5XCmJrEPEgv2KJKeLYzmWiK3o5msRcKo++msLD6lUc4GFhZn4AWxUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OcCXQrlN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OcCXQrlN"
Received: from localhost (unknown [124.126.141.200])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2783020B710C;
	Mon,  7 Sep 2026 20:15:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2783020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788837341;
	bh=yvnPaMlJnV54aQ4efWfHMY4CmyOcsP8nXDCwg89Qi7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcCXQrlNmLed6XGcOcyyEBZFHQQFiBxldOuAfNWmipiP6CECpG25ktmX+0kCQMplh
	 dzFU0zmKGMi29OZNXRpyMYKDp3d17h1apT545sGz6p2/xlSAkyVEfGpSzpGVh5iUQW
	 GJQ/GAHarStjTlZ8rvbONrxofbGO1VleIc9fySHY=
Date: Tue, 8 Sep 2026 11:16:18 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <mjwk6raf75lpd3wjotii5lnxmnlt4c474tu55ezrwsvr2rbfmx@krnwg7yoifes>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
 <af047ef8-91ef-7786-c230-25e28b1c8c04@linux.microsoft.com>
 <re2lmz757bvtzbkylxtsj7zu2pjqz7ro752tcg7bpjaicuj6ml@mgsg6jnvgbyd>
 <421b3805-5b90-dfc9-b84c-ee58969f5e36@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421b3805-5b90-dfc9-b84c-ee58969f5e36@linux.microsoft.com>

On Mon, Sep 07, 2026 at 02:08:35PM -0700, Mukesh R wrote:
> On 9/7/26 01:41, Yu Zhang wrote:
> > <snip>
> > 
> > > > +{
> > > > +	u64 status;
> > > > +	u32 prefix;
> > > > +	unsigned long flags;
> > > > +	int ret;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	struct hv_input_get_logical_device_property *input;
> > > > +	struct hv_output_get_logical_device_property *output;
> > > > +
> > > > +	ret = hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +
> > > > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > > +	output = (struct hv_output_get_logical_device_property *)(input + 1);
> > > 
> > > Any reason for not using pcpu output arg like we do in all other places?
> > > If there is a technical reason, please document it, otherwise when revisited
> > > in future for re-design, anyone looking at this will be confused and
> > > waste time investigating if there is anything different about this hypercall.
> > > 
> > > 
> > 
> > Thank you, Mukesh. I had also incorrectly assumed that output required
> > a separate page, which is why the RFC included a separate output-page
> > allocation patch. Michael clarified during that review [1] that input
> > and output can share a page as long as their buffers do not overlap,
> > so I dropped that patch latter.
> 
> They can share a page, but we don't enforce the sizes combined do
> not overflow a page, and that could be an issue in future. There is

The two hypercalls (HVCALL_GET_IOMMU_CAPABILITIES and
HVCALL_GET_LOGICAL_DEVICE_PROPERTY) each currently use only 40 bytes of
combined input and output. No concrete requirement has been identified
that would make either approach 4 KB. A hypothetical future expansion
is not sufficient reason to allocate another per-CPU page now. 

> a tool on the hyp side i believe to check that input and output struct
> sizes do not exceed page size.
> 
> Also, both the input and output pages are pre-allocated, so there is no
> extra allocation (otherwise, we'd have changed all places by now). So
> it's better to just follow the convention we've so far just to avoid
> confusion during future redesign imo. We def need to revisit this in
> near/medium future for all hypercalls.
> 

Well, output page is NOT pre-allocated ordinary child partitions. Please
see hv_output_page_exists() in hv_common.c.
                                                                                                                                                        
My RFC included a separate allocation because I had incorrectly assumed
that output required its own page. Like I mentioned earlier, this was
already discussed during the RFC review [1], and that allocation patch
was dropped following the discussion.

Using separate pages is NOT a *convention* either: hv_pci_read_mmio()
already places input and output in non-overlapping regions of the same
page.

We can certainly reassess which hypercalls need separate output pages
in a broader review. I would keep that separate from this series,
rather than reopen the RFC discussion without a concrete issue in
the current implementation.

[1] https://lore.kernel.org/all/SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com/

B.R.
Yu
