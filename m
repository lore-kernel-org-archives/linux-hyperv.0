Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482816;
	b=GOzqB5hCrlYvdM/K4ar9J/UtICABfGnDRS4ykNcdXL47EslaI6wiVpx2LLI9Y2+La59u
	 Ed1VUWsVyBYRgVJHENFthoe1bNSBovTw7tbWKq7ob0GcDFqaVOrs/HyIzmzQE4nBz3Z1t
	 jgfXsJtkfzqOkeaXsnLCctGcYa2r3zYFa/Dm+xhHEjZkSwesTcixFqQ6FXEul6xAE/5L1
	 ttZ49ambQHc2j+n5mYMdjsHGCWEnN9/S+ZbgxU8yDszdz2pDZIQ4mrs5L6GdsJc8Tu27M
	 qJK+ppBG8PBzDniCC6u0emo7m33lSPewVLIsh8KVYVdJ+fMttkx7eaHsI0V6q7/kEgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482816;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=FX0YJ7jj3NBl5LK+9MORMkD5tTD9X0hq1VShL+NEA2k=;
	b=etTQ/KCtJEhBA+v8k/M6bHLi1AzZH0Ql52tUJH9eYnl57ITHhHCTposw/SiGZEcBaAPZ
	 crj4vXeMiBOEgRp996Pa0GZTfIrwtnrjE8dtWb9TwGDm1/vSkhX19DsPPeygLdlbf3QFh
	 gWbecbadJQxkXCc9gvatLnu+qkaLBkcaDH8JnowulrtKG/XAWWhr5hOcRmAEuYiuND+QT
	 a+m3t0ullOKB08h1oqCablRmAtbKfO2jwzaTKDPmi2zk+3sbCfIjN9N3oDkyUgkdLPNPq
	 UnIrV582M0kL6uXHo1HbxABc7F2/AEP5GDswGpeKCA2rWSZXrN8d1BVs0FCaEf0vDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=AJKo5Rxz;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91639606A31E;
	Tue, 24 Nov 2026 01:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91639606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=AJKo5Rxz
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1BA020B7168;
	Mon, 23 Nov 2026 17:13:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1BA020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795482810;
	bh=FX0YJ7jj3NBl5LK+9MORMkD5tTD9X0hq1VShL+NEA2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AJKo5RxzCSmm7rDWU3BcWcqYXGcppOIEkOjckGS/qQwcP6+pVreGotZZNBW9yRSB7
	 YQBs5ZXMi+NpIG813t+ePc70axYjLXdCGlOAGh64I6BNvZxabdtoBs5xjndz8FV/ze
	 ghF/W8Ucl0mKpOvgdt2HY6LpiotoZ/VSRlXUu3PA=
Message-ID: <e66367e8-b6d0-b9f2-6e0a-691790c99d27@linux.microsoft.com>
Date: Mon, 23 Nov 2026 17:13:33 -0800
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
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>
References: <20261113031343.896489-1-mrathor@linux.microsoft.com>
 <MN2PR02MB6863AD86B89C4055793E6724D4452@MN2PR02MB6863.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863AD86B89C4055793E6724D4452@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/26 20:42, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, November 12, 2026 7:14 PM
>>
>> Currently, mshv_map_user_memory() snoops into vma to get the mmio
>> pfn via vm_pgoff. The mmio pfn is no longer stored there and will
> 
> Did you identify a specific commit that changed how the mmio pfn
> is stored? Given that the issue fixed by this patch causes a system
> crash, it seems like this patch should have a Fixes: tag so it can
> be backported.

No, because that didn't break it, it was never supposed to be that
way. vfio folks strongly rejected anyone outside the vfio driver
snooping into it, but the code to do that here un-intentionally got in
via initial big driver checkin. The change in vfio happened somewhere
after 6.6, but like i said, our lookup was illegit to begin with.

> Is the mmio pfn now stored someplace else that is accessible?
> I'm wondering if this patch is a temporary band-aid to prevent the
> crash, with upfront mapping of MMIO space coming back again
> later via a more complex/more complete fix.

It is stored differently, but the patch to make the lookup vfio
function public was rejected. Instead, i suppose we will do what
kvm does which is look up via user address. That will all be
part of upcoming "guest pci-passthru using iommufd" patches....

>> cause the system to crash. Moreover, it is not legit to obtain
>> mmio pfn via that method. So, remove upfront mmio mappings, just
>> create region and do basic checks. The mmio entries will be populated
>> on demand during intercepts in future.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_root.h         |  1 -
>>   drivers/hv/mshv_root_hv_call.c | 15 ---------------
>>   drivers/hv/mshv_root_main.c    | 28 +++++++++++-----------------
>>   3 files changed, 11 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
>> index c61b52db7f00..c0844b28b6a8 100644
>> --- a/drivers/hv/mshv_root.h
>> +++ b/drivers/hv/mshv_root.h
>> @@ -281,7 +281,6 @@ int hv_call_create_partition(u64 flags,
>>   int hv_call_initialize_partition(u64 partition_id);
>>   int hv_call_finalize_partition(u64 partition_id);
>>   int hv_call_delete_partition(u64 partition_id);
>> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
>>   int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
>>   			  u32 flags, struct page **pages);
>>   int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
>> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
>> index e8485d949951..1287c0a8d118 100644
>> --- a/drivers/hv/mshv_root_hv_call.c
>> +++ b/drivers/hv/mshv_root_hv_call.c
>> @@ -327,21 +327,6 @@ int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
>>   				   flags, pages, 0);
>>   }
>>
>> -/* Ask the hypervisor to map guest mmio space */
>> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
>> -{
>> -	int i;
>> -	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
>> -		    HV_MAP_GPA_NOT_CACHED;
>> -
>> -	for (i = 0; i < numpgs; i++)
>> -		if (page_is_ram(mmio_spa + i))
>> -			return -EINVAL;
>> -
>> -	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
>> -				   mmio_spa);
>> -}
>> -
> 
> With this code removed, hv_call_map_gpa_pages() is now the only caller
> of hv_do_map_gpa_hcall(), and it is only a wrapper. Is there a reason to not
> collapse these into one function?  And the last parameter of
> hv_do_map_gpa_hcall() is "mmio_spa", which becomes never used and could
> be removed.

Actually, the upcoming guest passthru support via iommufd calls
hv_do_map_gpa_hcall() for mapping mmio pages. so it will be removing
then adding back in...  so i thought i will leave it there.

>>   int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
>>   			    u32 flags)
>>   {
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index f0bfbbbd7bdd..a11756e5c48d 100644
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
> 
> Just testing is_mmio is sufficient here.  is_mmio can be true only
> when vma is non-NULL.  Indeed, the existing code uses exactly
> that dependency when accessing vma->vm_pgoff.

AI was generating comment that vma was not being checked. i could remove
it and we can just ignore the AI comment..

>> +		vma_sz = vma->vm_end - mem->userspace_addr;
>>   	mmap_read_unlock(current->mm);
>>
>>   	if (!vma)
>>   		return -EINVAL;
>>
>> +	if (is_mmio)
>> +		/* Upon mmio intercept, entire region is mapped */
>> +		if (mem->size > vma_sz)
> 
> Combine these two tests instead of nesting?  I.e.,
> 
> 	if (is_mmio && mem->size > vma_sz)

ok.


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
> 
> A default case with just "break" seems useless. Omitting it
> entirely produces the same result. The existing code doesn't have
> a default. If you want to be explicit that no mapping is done for
> MMIO, perhaps leave the case MSHV_REGION_TYPE_MMIO
> with just "break".

Yeah, I had MSHV_REGION_TYPE_MMIO with just break, but another
reviewer internally asked i remove it. i can remove default also,
not sure if it is there because some tool chain complaining of no
default..

Thanks,
-Mukesh



> Michael
> 
>>   	}
>>
>> --
>> 2.51.2.vfs.0.1
>>

