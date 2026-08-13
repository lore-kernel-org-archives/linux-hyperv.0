Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F983403B02;
	Thu, 13 Aug 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644143; cv=none; b=I8Fx3IYChnBSFI4iZiLbQ0Wb9Wahmw2tqOtQjgNrKRJ1DLEP5VphUQEIZMcbddcSGhspCmidOlpU5KV5BOhSa+yFSkEmQM7EryDc9sVzQa81YToLnjTJMHsGDybHK75mUgGOVcy8OSqhPWG85pvDxvKo/SeefmoIA6bO9kk9Mj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644143; c=relaxed/simple;
	bh=KcMxzdl/F7sTVyjdUmc+wWBrX2UQsNHU3IBT8SoXuLU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PxhxyN4MPe1aBp/slMs1TEjpq/T/xBZ1I8vvs5+l10ZgYU3cQBlci5YeJdluET/F8sakdgbNeqBQeEUJ3Y4T7/41HlO3DbsfbBqbchrpjQVTrIgx2CbGUtPf5sJwmXWV1IysFjzAmu0zEqLGrqZJPgkVps85BQKLJRdjSR24xFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UoHROR1I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UoHROR1I"
Received: from [100.75.160.35] (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1586E20B7128;
	Thu, 13 Aug 2026 11:01:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1586E20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786644106;
	bh=77K6jPOq46ixP0pQ8hVkT+6cmdv88WtRusQoPc0bV3s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UoHROR1I03w8y4vKKqOB83mio4EcduNVYyUhSHshwDq7zH7DGfw/uG7cBi6veDyPB
	 hRFNjkNw/Yl0iVtuyR65o4UjhFk7/K0ny7anhXjChDDeHtoInhhDgXOMCHhgi1zZPO
	 OWhK8Er0Pwe7792HgUs4kA6aPo81kyEDiRFlVufI=
Message-ID: <8b539b15-7373-474d-9afd-1135f0245a75@linux.microsoft.com>
Date: Thu, 13 Aug 2026 11:02:07 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org,
 easwar.hariharan@linux.microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
 kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
 robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com,
 jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com,
 mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
To: Yu Zhang <zhangyu1@linux.microsoft.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/2026 08:50, Yu Zhang wrote:
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
> 
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
> 
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
> 
> Guest hibernation and resume are not supported by this initial
> implementation. The guest-owned stage-1 page tables reside in guest
> memory and are preserved in the hibernation image. However, the image
> does not by itself preserve the Hyper-V device-domain objects or their
> device attachments, and the current pvIOMMU interface does not define
> whether or how Hyper-V restores that state.
> 
> To identify a device in its hypercall interface, the driver looks up the
> logical device ID prefix registered for the device's PCI domain (see the
> logical device ID registry in hv_common.c) and combines it with the PCI
> function number of the endpoint device.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c             |   4 +
>  arch/x86/include/asm/mshyperv.h       |   4 +
>  drivers/iommu/Kconfig                 |   1 +
>  drivers/iommu/hyperv/Kconfig          |  16 +
>  drivers/iommu/hyperv/Makefile         |   1 +
>  drivers/iommu/hyperv/hv-iommu-guest.c | 632 ++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h          |  50 ++
>  7 files changed, 708 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
> 
Seems like this is missing a change to MAINTAINERS. I'd suggest making a new section
and adding both the IOMMU and Hyper-V lists. As it stands, the IOMMU list will get no
notification of changes to this driver.

Thanks,
Easwar (he/him)
