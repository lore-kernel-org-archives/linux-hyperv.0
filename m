Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164A470433;
	Fri, 14 Aug 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711761; cv=none; b=uxllksmJscDBEmtDih0SsWunnjhjV1+LfBIrBhb/apSM+PIjmub2NqIr7OtR0Rrw2+yd3MsSHfOAwhM39CG0ImRa/e+cPRY/hhdwGyOg1jn8zPhgGrJJVZ7ZiX99e50ArxNorrDbTGfCLJYJTpFXv1KOlZe9N434LP1R4WNI0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711761; c=relaxed/simple;
	bh=fPiEbO5kU2O5bPbZIpxLV2Wsexd1odbAaPn3JJ+ob8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL1DkxuOlZdOHVnJh/WWnjPahnwwDyYvXxHV/bcOsGO4UzB+sYrP6tlpopzaWWsXJcdbF+i1oFR0fyXux3slbG6v/tMxA7828GRNPnaEvUYL4UDEEzqhOaGmt7MEqBnGvJgYFbfYCMI6ZPMET1XIVyJgAQEaheC47wefZYgnrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fcAp3o7+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fcAp3o7+"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0088320B7168;
	Fri, 14 Aug 2026 05:48:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0088320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786711729;
	bh=dJRW35gKakc9hml2+rRPkM7itMC10paLwoSLq8jsAKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcAp3o7+a7fMcM0WX+oqCIBlsTVP5aaKEoFdZf2kCGKPX6QEoPbB1R82qJAVPbJY4
	 0mBSalspmJwONMEL6n/MJ0nGK6u+Mk2BIM5bh/S1tGnn48PJcyLGTH/IVV0U/lJI7b
	 t8PbnYe7mZLEsWrMHgARqImX4RV0E32VVx5n2kOM=
Date: Fri, 14 Aug 2026 20:49:12 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <x6tm2k4b4fagvnpqwvwwwc5u76md7xrnann5okduauieuimj52@svvj6petg2n2>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <8b539b15-7373-474d-9afd-1135f0245a75@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b539b15-7373-474d-9afd-1135f0245a75@linux.microsoft.com>

On Thu, Aug 13, 2026 at 11:02:07AM -0700, Easwar Hariharan wrote:
> On 8/11/2026 08:50, Yu Zhang wrote:
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
> > ---
> >  arch/x86/hyperv/hv_init.c             |   4 +
> >  arch/x86/include/asm/mshyperv.h       |   4 +
> >  drivers/iommu/Kconfig                 |   1 +
> >  drivers/iommu/hyperv/Kconfig          |  16 +
> >  drivers/iommu/hyperv/Makefile         |   1 +
> >  drivers/iommu/hyperv/hv-iommu-guest.c | 632 ++++++++++++++++++++++++++
> >  drivers/iommu/hyperv/iommu.h          |  50 ++
> >  7 files changed, 708 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv/Kconfig
> >  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
> >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > 
> Seems like this is missing a change to MAINTAINERS. I'd suggest making a new section
> and adding both the IOMMU and Hyper-V lists. As it stands, the IOMMU list will get no
> notification of changes to this driver.
> 

Thanks for your remind, Easwar. 

We do intend to maintain the Linux guest pvIOMMU driver. I am just not
sure whether it needs a separate section in the MAINTAINERS file, since
drivers/iommu/hyperv/ is already covered by both the Hyper-V and generic
IOMMU entries, and get_maintainer.pl returns both mailing lists and sets
of maintainers. Therefore I don't see a notification gap that requires a
separate entry.
                                                                                                                                                        
Do the Hyper-V and IOMMU maintainers have a preference here?

B.R.
Yu
> Thanks,
> Easwar (he/him)
> 
