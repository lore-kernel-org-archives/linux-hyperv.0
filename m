Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3C2AE8D;
	Sat, 24 Jan 2026 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220737; cv=none; b=Ynl3hdaYDtpVsgSFS8ca5Ppmc6WuzoS30unKustcaOym1eqJDx8UWnRKYez5QGLu3bdHweYpMGYLpPn9Dl4WXuoBKu6kFPPTU8IRDpFqhMD13Xn9E/2qFoL4qrQ1bMqGCg87R7uDXN4kLixS80perBODRXaqDewkOqPanHcl33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220737; c=relaxed/simple;
	bh=epG5g1tlciBVUj8jl2vqbcB6jZ8t17Wj4Af3+tsoDEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnByjCxhDOwcbrJcbM8hacGaK0l/wF3Oq00Sy7I/QiB1LLUEvDITVa7grpPe3yH9TfnIcxj27DrcMHx8NZ3BJp5aIzfBhfUX6noQtfeh3qMOe5z3imHshJZSYTArSK9MLExNGwuCt4tKUZqnpEfbmYfvYVIqSFHN9AuVl1qcERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L47tREGI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L47tREGI"
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A0C420B7167;
	Fri, 23 Jan 2026 18:12:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A0C420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769220736;
	bh=U01vUOT3l/iWkj1oiqo3mEbBNEg35d4YQ+M4NvaMNFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L47tREGI76U53gKkHUPXTXi/8+0UA3q8D7wq10l6YlyEYH9eMODpyINIwi1s9CG0X
	 vWy5MmBme4hAaK1CPencIOtMUap46i+m409h3VGrKk+JnDRX9s4uqnofHki7kEDo/A
	 gUec5ByclivQM0v33UqbM7RjWkniIVWYVUmo8LUQ=
Message-ID: <f92a90d2-77e6-33cc-0c08-3851242298e0@linux.microsoft.com>
Date: Fri, 23 Jan 2026 18:12:14 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 14/15] mshv: Remove mapping of mmio space during map
 user ioctl
Content-Language: en-US
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-15-mrathor@linux.microsoft.com>
 <152d9393-4af3-4c2f-a808-367ee7249d36@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <152d9393-4af3-4c2f-a808-367ee7249d36@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/26 10:34, Nuno Das Neves wrote:
> On 1/19/2026 10:42 PM, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> VFIO no longer puts the mmio pfn in vma->vm_pgoff. So, remove code
>> that is using it to map mmio space. It is broken and will cause
>> panic.
> 
> What is the reason for having this as a separate commit from patch 15?
> It seems like removing this code and adding the mmio intercept
> handling could be done in one patch.

Just ease of review and porting patches from this branch to that
branch to that release to this release... I am sure someone would
have asked for this to be a separate patch :).

Thanks,
-Mukesh


>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root_main.c | 20 ++++----------------
>>   1 file changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 27313419828d..03f3aa9f5541 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1258,16 +1258,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
>>   }
>>   
>>   /*
>> - * This maps two things: guest RAM and for pci passthru mmio space.
>> - *
>> - * mmio:
>> - *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
>> - *  - Two things need to happen for mapping mmio range:
>> - *	1. mapped in the uaddr so VMM can access it.
>> - *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
>> - *
>> - *   This function takes care of the second. The first one is managed by vfio,
>> - *   and hence is taken care of via vfio_pci_mmap_fault().
>> + * This is called for both user ram and mmio space. The mmio space is not
>> + * mapped here, but later during intercept.
>>    */
>>   static long
>>   mshv_map_user_memory(struct mshv_partition *partition,
>> @@ -1276,7 +1268,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   	struct mshv_mem_region *region;
>>   	struct vm_area_struct *vma;
>>   	bool is_mmio;
>> -	ulong mmio_pfn;
>>   	long ret;
>>   
>>   	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
>> @@ -1286,7 +1277,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   	mmap_read_lock(current->mm);
>>   	vma = vma_lookup(current->mm, mem.userspace_addr);
>>   	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
>> -	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
>>   	mmap_read_unlock(current->mm);
>>   
>>   	if (!vma)
>> @@ -1313,10 +1303,8 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   					    HV_MAP_GPA_NO_ACCESS, NULL);
>>   		break;
>>   	case MSHV_REGION_TYPE_MMIO:
>> -		ret = hv_call_map_mmio_pages(partition->pt_id,
>> -					     region->start_gfn,
>> -					     mmio_pfn,
>> -					     region->nr_pages);
>> +		/* mmio mappings are handled later during intercepts */
>> +		ret = 0;
>>   		break;
>>   	}
>>   
> 

