Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71018AE3;
	Tue, 29 Sep 2026 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717660; cv=none; b=aGlj2AkrNbea6fv+zrA33EFLRqeuACphLDRE076MXf5URFQQ88s8TMYA/qOGGzU+AJzeWrVyNh7u7CJDGpCpF7V7znwkmkk0UE18Ex/9CkElzXoRh/WBJ7ZA7KWntLwef6N1BlLybtnlDQF2G+VtiP8hCc99Ba0SF0WZY+n99fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717660; c=relaxed/simple;
	bh=khm6VJUFJt8/2b2ThR+Srq5Fru/RnmxYzVSCIh1Pc3I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PjvPhp16j4xq4HqohB7WgH1gwYefPam542Ck9qGRmnCgBVVjhvJMzg9DCZoO9Uewpb320ai2SRItSH9cPZBDTpPFrth64F1Wh4i6PMGkNJhXFJvPkODJN3WPTnETMdiZpSaqVVifuSgbzhEYQEP/MoVEzsAYHOA1R9jjrKhLcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lDBkqMTz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lDBkqMTz"
Received: from [10.20.30.135] (unknown [131.107.1.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75A1620B7166;
	Tue, 29 Sep 2026 14:33:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75A1620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790717606;
	bh=9DhT9e15vQQh0b26rC1HTcYsluAjwlm0+d6IW4IilrA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lDBkqMTzeGY3kbmBb5zL8b7xTN4pUbv396ldhXMFk1EeHWG6HlbIdtZ18P8+Fe/zL
	 wnD7mA4OTUMKf5vGoM26Xt61ZehKc06xfd9AkFRGCBFqn7YRh/7VBvfadSgKtX7FZx
	 EYD1LB2axMpBjs7ox9u3rMxiA8qVGZFkZ0wCUOMI=
Message-ID: <30c45240-3dd4-43d5-8512-6f3e7e839f51@linux.microsoft.com>
Date: Tue, 29 Sep 2026 14:34:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com,
 easwar.hariharan@linux.microsoft.com, Yu Zhang
 <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 jgg@ziepe.ca, mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 mrathor@linux.microsoft.com, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com
Subject: Re: [PATCH v5 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
To: Jacob Pan <jacob.pan@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-5-zhangyu1@linux.microsoft.com>
 <179071228738.122959.14326374887826159868.b4-review@b4>
 <20260929142542.0000575e@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260929142542.0000575e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2026 14:25, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 29 Sep 2026 17:04:47 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>>> +config HYPERV_PVIOMMU
>>> +	bool "Microsoft Hyper-V para-virtualized IOMMU driver for
>>> Linux guests"
>>> +	depends on X86_64 && HYPERV
>>> +	select IOMMU_API
>>> +	select GENERIC_PT
>>> +	select IOMMU_PT
>>> +	select IOMMU_PT_X86_64
>>> +	select IOMMU_IOVA  
>>
>> Should this be IOMMU_DMA ?
> 
> I agree. I guess we should also delete "select IOMMU_API", since
> IOMMU_DMA selects both.
> 
> Noticed vt-d driver has the same option, maybe it should also
> be changed. Baolu, is that due to historical reasons?
> 
> config INTEL_IOMMU
> 	bool "Support for Intel IOMMU using DMA Remapping Devices"
> 	depends on PCI_MSI && ACPI && X86
> 	select IOMMU_API
> 	select GENERIC_PT
> 	select IOMMU_PT
> 	select IOMMU_PT_X86_64
> 	select IOMMU_PT_VTDSS
> 	select IOMMU_IOVA

FWIW, AMD also has the same...

config AMD_IOMMU
        bool "AMD IOMMU support"
        select SWIOTLB
        select PCI_MSI
        select PCI_ATS
        select PCI_PRI
        select PCI_PASID
        select IRQ_MSI_LIB
        select MMU_NOTIFIER
        select IOMMU_API
        select IOMMU_IOVA

but ARM doesn't, and doesn't select IOMMU_DMA either.

:confused:

Thanks,
Easwar (he/him)
