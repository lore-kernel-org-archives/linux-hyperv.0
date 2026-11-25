Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567626;
	b=jmXncU+c3AXotA/Tv1n2BAzbUxDHgUJHfKO+BhKKF8A22bk1PvWaiXNztNbeHEkaounx
	 8qf5TSs8NglrZZ2cqUX3O50GUxbU4IUBZiUUSt2ReVZmTa/uce0ch5EHJm0U10DBwxbQ8
	 4n09zWb3YPUxc7eH11//mPpe61VXQrbf4Q+Ac1p+NAZNJTEAydqxhoKOegFAeInRXr5Vo
	 o99NRGStsbmqnYj9jK+4K2tAWePau2I5DAgualXu8MyhtOO/wdlKM/5I79VkWWfVR6oGK
	 57hxSQAkT5yxYccQe+nVvzSfkStVKi6VolVLOx4fpT/24l/1fxkhdXT7ZHdOO1S2zSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567626;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=8zvV6gy2YC8kYGmYD/OCKcorsdWRW8UwKtO7dpunkQM=;
	b=kp90g+Hs3kGOhbUJQarnypvcwkT0Spgihd0qyAvL2aUfj0FPcTASRg2V0XasmkQ+iVru
	 J9RtNzqainSaj6JsS2U6AxxJdEXDPhqscpp9jN1cJniYG+RF6FYIXrVZejbGtEJyvG26U
	 27z07Z6HeLytFw6VPGd3BYgBN5cV3sKyOvtAlyi2XiqgUwqI+PyI4HexQO3rI9+8AqYdf
	 YdvT+PYJP4uw8QodTbVcGcRX+xIm54PdkvFlm5KNAZzHZprVMhmN0n+lwI9u57WpzZXjN
	 hplZvN9CDOuNVxT2sBl9xbYxxqKgks931pWy08YAeAiZ76UwbNeyq/o/xL8I+VLpWpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=EaqqdZ6X;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56B606A321
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Nov 2026 00:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D56B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=EaqqdZ6X
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E1C420B7166;
	Tue, 24 Nov 2026 16:47:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E1C420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795567620;
	bh=8zvV6gy2YC8kYGmYD/OCKcorsdWRW8UwKtO7dpunkQM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EaqqdZ6Xo0lNPxsfiwHQLttiTeSv0GethOWjICDn3yre+M/ZTuPV3xQBTdOe+ZylK
	 zfw9NdARFUFwVwAvf75GvAgStgP59BKPF5Ib6dg06DNXprKAFzFRz4WDU/y8CUqyzm
	 p0bXGhM99rCfIFS/CCxCFOBIVWkXSV50/a3DUlSc=
Message-ID: <bf3cb1ac-f5fd-1848-c3c6-2adb319e5125@linux.microsoft.com>
Date: Tue, 24 Nov 2026 16:47:03 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Do not map mmio in map user memory ioctl
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev, linux-hyperv@vger.kernel.org
References: <20261113031343.896489-1-mrathor@linux.microsoft.com>
 <sashiko-outbox-212132@kernel.org>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <sashiko-outbox-212132@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 19:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mshv: missing Fixes trailer on commit fixing crash in
>    mshv_map_user_memory()
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [Medium] mshv: ignored mshv_region_map() error in
>    mshv_prepare_pinned_region() [1]
> --
> 
> commit f8208ba7fc5113c6d67967e4650125ea72fda573
> Author: Mukesh R <mrathor@linux.microsoft.com>
> 
>> mshv: Do not map mmio in map user memory ioctl
>>
>> Currently, mshv_map_user_memory() snoops into vma to get the mmio
>> pfn via vm_pgoff. The mmio pfn is no longer stored there and will
>> cause the system to crash. Moreover, it is not legit to obtain
>> mmio pfn via that method. So, remove upfront mmio mappings, just
>> create region and do basic checks. The mmio entries will be populated
>> on demand during intercepts in future.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> 
> [Severity: Low]
> This fixes a system crash when mapping MMIO memory regions.  Should this
> include:
> 
>    Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> 
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index cc2cfce2aefdb..f1f143e32c078 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1345,16 +1345,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
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
>> + * mapped here, that should happen later during intercept on demand.
>>    */
>>   static long
>>   mshv_map_user_memory(struct mshv_partition *partition,
>> @@ -1363,7 +1355,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   	struct mshv_mem_region *region;
>>   	struct vm_area_struct *vma;
>>   	bool is_mmio;
>> -	ulong mmio_pfn;
>> +	size_t vma_sz;
>>   	long ret;
>>   
>>   	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
>> @@ -1373,12 +1365,18 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   	mmap_read_lock(current->mm);
>>   	vma = vma_lookup(current->mm, mem->userspace_addr);
>>   	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
>> -	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
>> +	if (vma && is_mmio)
>> +		vma_sz = vma->vm_end - mem->userspace_addr;
>>   	mmap_read_unlock(current->mm);
>>   
>>   	if (!vma)
>>   		return -EINVAL;
>>   
>> +	if (is_mmio)
>> +		/* Upon mmio intercept, entire region is mapped */
>> +		if (mem->size > vma_sz)
>> +			return -EPERM;
>> +
>>   	ret = mshv_partition_create_region(partition, mem, &region,
>>   					   is_mmio);
>>   	if (ret)
>> @@ -1399,11 +1397,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>>   					    region->nr_pages,
>>   					    HV_MAP_GPA_NO_ACCESS, NULL);
>>   		break;
>> -	case MSHV_REGION_TYPE_MMIO:
>> -		ret = hv_call_map_mmio_pages(partition->pt_id,
>> -					     region->start_gfn,
>> -					     mmio_pfn,
>> -					     region->nr_pages);
>> +	default:
>>   		break;
>>   	}
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but does
> mshv_prepare_pinned_region() ignore mshv_region_map() errors on
> non-encrypted partitions [1]?
> 
> drivers/hv/mshv_root_main.c:mshv_prepare_pinned_region() {
>      ...
> 	ret = mshv_region_map(region);
> 	if (ret && mshv_partition_encrypted(partition)) {
> 		int shrc;
> 
> 		shrc = mshv_region_share(region);
> 		if (!shrc)
> 			goto invalidate_region;
>      ...
> 		goto err_out;
> 	}
> 
> 	return 0;
> 
> invalidate_region:
> 	mshv_region_invalidate(region);
> err_out:
> 	return ret;
> }
> 
> When mshv_region_movable_init() fails on a non-encrypted partition,
> mshv_partition_create_region() falls back to MSHV_REGION_TYPE_MEM_PINNED.
> If mshv_region_map() then fails, mshv_prepare_pinned_region() skips
> mshv_region_invalidate() and returns 0, so mshv_map_user_memory() links the
> unmapped region into partition->pt_mem_regions with its pages left pinned
> and returns success to userspace.
> 
> [1] https://sashiko.dev/#/bug/linux-a3d211d1-2dbc-4947-880d-f5809ec51869
> 


Yes, this is a pre-existing bug that must be fixed asap.

Thanks,
-Mukesh

