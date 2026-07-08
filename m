Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E723BE627;
	Wed,  8 Jul 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506806; cv=none; b=G800AtFPRxlBnonKMHLGlX08zoBrRcCTubW7Uyae0DKMh3IwDVfenBYn6/JRTD/WcmpkTqfWGgCzpzbtq1sk222PXDhvLUlGoc2Abi4EA2Ne8N6JRcbuQrQz5iUxxndUKzRRoqmwtHwU+jqRRkNo4wEzbnyGRerm6jipDLf9idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506806; c=relaxed/simple;
	bh=KOfxWwqthP89d883QEsbCbM2ovIyad53dh00YEqUADw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlFyHdQ1Jw5DjlkfRUpEGipa+WBUud/xcMej2nGfQqC3gwETkmUmkG+rliH1nb6YlFUVwd7M9hvCODu/Qjaj76dIaemEib/wJgRxcx/Bhcd2InfIDC+zjMknUp8rXzVrgo8cFm0FP4Z7Lljz1gE92qUPPiA5341lThQ32Tntg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sr78UQcR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sr78UQcR"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5C4D20B7166;
	Wed,  8 Jul 2026 03:33:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5C4D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783506788;
	bh=vKK52gM9w8/zMLU0AJulU3rrns4vwDO+QxLbjmC5IBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr78UQcRnCYTn1/xwmJMo2d+1aFNNywFHRhXQCDH0X+7etsiUg54EDSsmazCGRL5i
	 jgqLm8vhzXMzQhIHs0MX+01zUIOGdVHjAVVLUP+/qXRlSfRwZAxJ2qfm493XAGxNBO
	 mDMoAhmWQw21//CwGcbOlUJqy4FdpFIEtS2QHAYE=
Date: Wed, 8 Jul 2026 18:33:10 +0800
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
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <rlbiupxg2prmkacggcv6prqlybwcnmwkgno4ggyjbhwesr4k6r@dvpt2o72ba3r>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <20260703173248.GB1968184@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703173248.GB1968184@ziepe.ca>

On Fri, Jul 03, 2026 at 02:32:48PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 03, 2026 at 12:05:17AM +0800, Yu Zhang wrote:
> 
> > +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +		return true;
> > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > +		return true;
> 
> This CAP isn't necessary anymore
> 

Right, thanks for pointing this out!

> > +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> > +{
> > +	struct pci_dev *pdev;
> > +	struct hv_iommu_endpoint *vdev;
> > +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> > +
> > +	if (!dev_is_pci(dev))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	if (hv_iommu_get_logical_device_property(dev,
> > +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> > +						 &device_iommu_property) ||
> > +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> > +	if (!vdev)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	vdev->dev = dev;
> > +	vdev->hv_iommu = hv_iommu_device;
> > +	dev_iommu_priv_set(dev, vdev);
> > +
> > +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> > +	    pci_ats_supported(pdev))
> > +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
> 
> This can probably just be PAGE_SHIFT

Indeed. 

> 
> Also ATS shouldn't be enabled until a translation is installed,
> otherwise the driver cannot participate in the ATS error handling
> Nicolin is working on.
> 

Yes.I'll move ATS enablement into a paging-domain-specific attach wrapper
that calls pci_enable_ats(pdev, PAGE_SHIFT) after the attach hypercall
succeeds. And maybe blocking attach shall also call pci_disable_ats()
before  the hypercall to prevent stale ATC entries from bypassing the
block?

Something like:

    static int hv_iommu_paging_attach_dev(...)
    {
        ret = hv_iommu_attach_dev(domain, dev, old);
        if (ret)
            return ret;
        if (!pdev->ats_enabled && ats_supported)
            pci_enable_ats(pdev, PAGE_SHIFT);
        return 0;
    }

    static int hv_iommu_blocking_attach_dev(...)
    {
        if (pdev->ats_enabled)
            pci_disable_ats(pdev);
        ret = hv_iommu_attach_dev(domain, dev, old);
        ...
    }

Does this look right?

> > +static void hv_iommu_release_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	dev_iommu_priv_set(dev, NULL);
> 
> No necessary, the caller does it
> 

Yes. Thanks!

> > +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> > +{
> > +	if (dev_is_pci(dev))
> > +		return pci_device_group(dev);
> > +
> > +	WARN_ON_ONCE(1);
> > +	return generic_device_group(dev);
> 
> I think you can just return failure here instead of WARN_ON ?
> 

Yes, will change to return ERR_PTR(-ENODEV).

> > +static int __init hv_initialize_static_domains(void)
> > +{
> > +	int ret;
> > +	struct hv_iommu_domain *hv_domain;
> > +
> > +	/* Default stage-1 identity domain */
> > +	hv_domain = &hv_identity_domain;
> > +
> > +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> > +	if (ret)
> > +		goto delete_identity_domain;
> 
> IMHO I would change this around to have a single function that accepts
> a struct hv_input_configure_device_domain as input and does both of
> the hypercalls inside. Then here it is easy to directly construct the
> hv_input_configure_device_domain for blocking and identity.
> 
> I'd be happy if this never touched domain_type, drivers shouldn't be
> touching that.
> 

Good idea. Maybe we can just change hv_configure_device_domain()
to take a "struct hv_device_domain_settings *" directly - that way each
caller constructs the HW settings explicitly and domain_type is not
needed at all. Does that sound right?

> > +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> > +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> > +{
> > +	ida_init(&hv_iommu->domain_ids);
> > +
> > +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> > +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> > +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> > +	    hv_iommu->max_iova_width > 48) {
> > +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> > +		hv_iommu->max_iova_width = 48;
> > +	}
> > +
> > +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> > +		.aperture_start = 0,
> > +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> > +		.force_aperture = true,
> > +	};
> 
> I don't see anything reading this, I don't expect this to be used?
> 
> The max_iova_width has to be passed into the iommupt creation, which
> it does:
> 
>  +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
>  +	cfg.common.hw_max_oasz_lg2 = 52;
>  +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
>  +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
>  +	if (ret)
> 
> So just delete hv->iommu->geometry.
> 

Right. Will remove.

> Also, VT-D has weirdness where the HW can require a 4 level table but
> only a 3 level worth of IOVA width is being used. This was a
> real-world bug we hit when converting to iommupt. This interaction
> with the HV doesn't seem able to represent that.
> 

Is this the issue fixed by commit d856f9d27885 ("iommupt/vtd: Allow
VT-d to have a larger table top than the vasz requires")? For pvIOMMU
the first-stage table is either 4-level (max_iova_width <= 48) or
5-level (max_iova_width > 48 && 5lvl cap set). Is there a scenario
where this would still be a problem?

> > +	/*
> > +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> > +	 * hypervisor to advertise a non-empty subset of exactly those.
> > +	 */
> > +	if (!hv_iommu_cap.pgsize_bitmap ||
> > +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> > +		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> > +		       hv_iommu_cap.pgsize_bitmap);
> > +		return -ENODEV;
> > +	}
> 
> This can just be
> 
> if (!(hv_iommu_cap.pgsize_bitmap & PAGE_SHIFT)) {
> 		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> 		       hv_iommu_cap.pgsize_bitmap);
> }		return -ENODEV;
> 
> Which is all you really need. If the HV doesn't support 1G it is
> perfectly fine, the iommupt page bitmap is already masked by this. 
> 

Good point, it's much simpler.
And I assume you meant PAGE_SIZE / SZ_4K instead of PAGE_SHIFT here. :) 

> > +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> > +	if (ret) {
> > +		pr_err("iommu_device_register failed: %d\n", ret);
> > +		goto err_sysfs_remove;
> > +	}
> > +
> > +	pr_info("successfully initialized\n");
> 
> Don't log someting so vauge?
> 

With pr_fmt defined as "Hyper-V pvIOMMU: ", this shows up as
"Hyper-V pvIOMMU: successfully initialized" in dmesg. I'd like to
keep some indication that pvIOMMU init succeeded at boot. Is this
still too vague? Would it be better if I also print capabilities
like IOVA width and supported page sizes here? Thanks!

B.R.
Yu

> Jason
> 
