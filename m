Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72336346E6D;
	Thu,  3 Sep 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422495; cv=none; b=DhzuW8eg/ItsQ7w7nvQnBsW5Kg/1W6GzWSnV5AsKIr5DW0Or7Jc7Vg1nW5HnIhbEMsx7iaX+6v9rf0FUizEljt4KUU7hfcMdrMzptEqy8GG5AVmrvBZzTXk+FSb5AuTpPjgbYWRb+3tiJcpyMxgirZHnyV/gQpe2uwkr8+FMF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422495; c=relaxed/simple;
	bh=vpfLl3XOI7rlkVuJq1PgI2vEBKX0lNQYwDmbXu4z21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kzu6nisdDDd7jdQyHQETqPPFPUg0SIMEK7GidXJZzJgXDblbg2tbNhcPQ7lPut5cPu1FjLDiHbHxfGv7s/mBhaJUY19GyhUQfwLns5zBiXWs2yJylNcpA8GnMWKIyvuwJ6JWH0/zF5EiC/oUzS9qCMFapu/B9yUwccMftSimLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iuf0Zpbh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iuf0Zpbh"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47F8F20B712B;
	Thu,  3 Sep 2026 01:00:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47F8F20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788422454;
	bh=nBs8WjtPOPK/iPmNWaCpV8vwPsHWUeve/Fx6Ar0apQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuf0ZpbhptHZ3cl4mdiP/4Cs20dPAJkKGF4XqAPMA12nffuZxczgkKZQYjeR2BctP
	 atftrvhceIwIILopc5hfHxR3bKFtt+w1Riclz+/kBPA03AtigMIzyy5EXQyzlUu+tV
	 f0nnpBM2QTvdnS0chPp0DGX4fSi9HD5b++yxWaa8=
Date: Thu, 3 Sep 2026 16:01:29 +0800
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
Subject: Re: [PATCH v4 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <xgcx7tq47d6wlw7glk7yoka5qr32hxv3rlrdzaw5i2kzs7b7s5@7xdljgmwo77n>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-5-zhangyu1@linux.microsoft.com>
 <BN7PR02MB41489C44F11D14DDCEF925C7D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN7PR02MB41489C44F11D14DDCEF925C7D4AC2@BN7PR02MB4148.namprd02.prod.outlook.com>

On Fri, Aug 28, 2026 at 05:22:25PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, August 21, 2026 6:27 AM
> > 
> > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > This driver implements stage-1 IO translation within the guest OS.
> > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > for:
> >  - Capability discovery
> >  - Domain allocation, configuration, and deallocation
> >  - Device attachment and detachment
> >  - IOTLB invalidation
> > 
> > The driver constructs x86-compatible stage-1 IO page tables in the
> > guest memory using consolidated IO page table helpers. This allows
> > the guest to manage stage-1 translations independently of vendor-
> > specific drivers (like Intel VT-d or AMD IOMMU).
> > 
> > Hyper-V consumes this stage-1 IO page table when a device domain is
> > created and configured, and nests it with the host's stage-2 IO page
> > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > operations. For unmapping operations, VM exits to perform the IOTLB
> > flush are still unavoidable.
> > 
> > Guest hibernation and resume are not supported by this initial
> > implementation. The guest-owned stage-1 page tables reside in guest
> > memory and are preserved in the hibernation image. However, the image
> > does not by itself preserve the Hyper-V device-domain objects or their
> > device attachments, and the current pvIOMMU interface does not define
> > whether or how Hyper-V restores that state.
> > 
> > To identify a device in its hypercall interface, the driver looks up the
> > logical device ID prefix registered for the device's PCI domain (see the
> > logical device ID registry in hv_common.c) and combines it with the PCI
> > function number of the endpoint device.
> > 
> > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c             |   4 +
> >  arch/x86/include/asm/mshyperv.h       |   4 +
> >  drivers/iommu/Kconfig                 |   1 +
> >  drivers/iommu/hyperv/Kconfig          |  16 +
> >  drivers/iommu/hyperv/Makefile         |   1 +
> >  drivers/iommu/hyperv/hv-iommu-guest.c | 620 ++++++++++++++++++++++++++
> >  drivers/iommu/hyperv/iommu.h          |  49 ++
> >  7 files changed, 695 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv/Kconfig
> >  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
> >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > 
> 
> [snip]
> 
> > +
> > +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
> > +			       struct iommu_domain *old)
> > +{
> > +	u64 status;
> > +	u32 prefix;
> > +	unsigned long flags;
> > +	struct pci_dev *pdev;
> > +	struct hv_input_attach_device_domain *input;
> > +	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
> > +	int ret;
> > +
> > +	pdev = to_pci_dev(dev);
> > +	dev_dbg(dev, "attaching to domain %d\n",
> > +		hv_domain->device_domain.domain_id.id);
> > +
> > +	ret = hv_pci_lookup_dev_id(pci_domain_nr(pdev->bus), &prefix);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");
> 
> Nit: Given that the device id registration is independent of IOMMUs,
> this message seems a bit off. Maybe just drop "IOMMU"?
> 

How about making the message more explicit and including the lookup key?
E.g.,

	pci_domain = pci_domain_nr(pdev->bus);
	ret = hv_pci_lookup_dev_id(pci_domain, &prefix);
	if (ret) {
		dev_err(dev,
			"no logical device ID registered for PCI domain %04x\n",
			pci_domain);
		return ret;
	}

> > +		return ret;
> > +	}
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->device_id.as_uint64 = (u64)prefix | PCI_FUNC(pdev->devfn);
> > +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status) &&
> > +	    hv_result(status) != HV_STATUS_DEVICE_ALREADY_IN_DOMAIN) {
> > +		hv_status_err(status, "HVCALL_ATTACH_DEVICE_DOMAIN failed\n");
> > +		return hv_result_to_errno(status);
> > +	}
> > +
> > +	if (domain != &hv_blocking_domain.domain &&
> > +	    !pdev->ats_enabled &&
> > +	    hv_iommu_ats_supported(hv_iommu_device->cap) &&
> 
> Nit: In other places where the hv_domain is available, 
> hv_domain->hv_iommu is used instead of directly accessing
> hv_iommu_device. That's a good practice that limits references
> to the static variable hv_iommu_device in case future enhancements
> allow multiple IOMMUs in a VM. I'd suggest doing the same here.
> 

Good point. Will use hv_domain->hv_iommu.

> > +	    pci_ats_supported(pdev))
> > +		pci_enable_ats(pdev, PAGE_SHIFT);
> > +
> > +	return 0;
> > +}
> > +
> 
> [snip]
> 
> > +
> > +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> > +{
> > +	struct hv_iommu_endpoint *vdev;
> > +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> > +
> > +	if (!dev_is_pci(dev))
> > +		return ERR_PTR(-ENODEV);
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
> 
> This struct hv_iommu_endpoint is set up, but doesn't seem to be
> used for anything except to free it. Am I missing some reason that
> it exists?
> 

Hah! You aren not missing anything. :)

This structure used to carry more per-device state. In v3, it also
contained hv_domain, which tracked the currently attached domain and
was used to skip a duplicate blocking domain attach. v4 removed the
hv_domain field in struct hv_iommu_endpiont, and also the redundant
ATS cleanup in release_device().

Next, I will remove struct hv_iommu_endpoint, its allocation, the
dev_iommu_priv_set()/get() calls, the release_device() callback, and
the corresponding iommu_ops entry. hv_iommu_probe_device() can return
&hv_iommu_device->iommu  directly.

If future work needs any per-device state, we can introduce the structure
again. Keeping an unused data structure in the current code is indeed
not a good practice. Thanks for pointing this out!

B.R.
Yu

