Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394672F3C19;
	Tue, 27 Jan 2026 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483245; cv=none; b=T74vaV2D6Q2JJCyjHpqhCRe9inq/vXuJTg580LllXkTlmmbgPN9XprXAgDl5Knr25BRLM3NaDsNNWaUH9toRXSV75udCIKHnZnRWRNE/EiCoSMteIQ2UTVrzHic32aop01HUVzZr2BfCU0KkTJfxYG6hmlgM/XJhX/8UMfpeDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483245; c=relaxed/simple;
	bh=BqV4NL0gMNLBxK2/Ed1t92zETjfJP5UM0zY7U9kvZK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMjgyIXXeZZ/O7+86hfWZUSVMub0eWve8dgnA9MR3+oBOPHjRdxKNzemX4PRyzbtWMnmhMS0vJ1gOXGrew2+saQyDF9bMSZtIBuUq7ocqaWqZkY8ezvo/OaWLpOAmyZhGIDvxbvsJnj1AbJbhLp6mHtpLBQkcwz8b5J7qq/74FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pZJhWzCm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pZJhWzCm"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBBD820B7165;
	Mon, 26 Jan 2026 19:07:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBBD820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769483243;
	bh=yzwQy7rEVgdF+HrGfCLWwO3wIrPqCjxjn0gpwCDGQI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pZJhWzCmT2NGW1FMC2+dvSHIgcziga0eOCSpxOie6uflWTAPvTU2h/Zy3+schEeVq
	 TfvnAVtcHTyAnY1BYF8xxbdq64phCs5B1rp6nMgLXNvHlRi/WaS0lmkWzNxko4e5j0
	 3fYJNKTkf4IDb0pnpzR5YnpA1779LY3/Zd83pGGA=
Message-ID: <f39a501e-478f-66ff-26c8-229ca3991f4f@linux.microsoft.com>
Date: Mon, 26 Jan 2026 19:07:22 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-16-mrathor@linux.microsoft.com>
 <aXAxmYm4zbOzGztz@skinsburskii.localdomain>
 <45e7a4c0-f1d8-b8b4-8c03-56d06845323b@linux.microsoft.com>
 <aXevWXolgNrrLltF@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXevWXolgNrrLltF@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/26 10:15, Stanislav Kinsburskii wrote:
> On Fri, Jan 23, 2026 at 06:19:15PM -0800, Mukesh R wrote:
>> On 1/20/26 17:53, Stanislav Kinsburskii wrote:
>>> On Mon, Jan 19, 2026 at 10:42:30PM -0800, Mukesh R wrote:
>>>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>>
>>>> Upon guest access, in case of missing mmio mapping, the hypervisor
>>>> generates an unmapped gpa intercept. In this path, lookup the PCI
>>>> resource pfn for the guest gpa, and ask the hypervisor to map it
>>>> via hypercall. The PCI resource pfn is maintained by the VFIO driver,
>>>> and obtained via fixup_user_fault call (similar to KVM).
>>>>
>>>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>>>> ---
>>>>    drivers/hv/mshv_root_main.c | 115 ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 115 insertions(+)
>>>>
>>>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>>>> index 03f3aa9f5541..4c8bc7cd0888 100644
>>>> --- a/drivers/hv/mshv_root_main.c
>>>> +++ b/drivers/hv/mshv_root_main.c
>>>> @@ -56,6 +56,14 @@ struct hv_stats_page {
>>>>    	};
>>>>    } __packed;
>>>> +bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
>>>> +static int __init setup_hv_full_mmio(char *str)
>>>> +{
>>>> +	hv_nofull_mmio = true;
>>>> +	return 0;
>>>> +}
>>>> +__setup("hv_nofull_mmio", setup_hv_full_mmio);
>>>> +
>>>>    struct mshv_root mshv_root;
>>>>    enum hv_scheduler_type hv_scheduler_type;
>>>> @@ -612,6 +620,109 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
>>>>    }
>>>>    #ifdef CONFIG_X86_64
>>>> +
>>>> +/*
>>>> + * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
>>>> + * else just return -errno.
>>>> + */
>>>> +static int mshv_chk_get_mmio_start_pfn(struct mshv_partition *pt, u64 gfn,
>>>> +				       u64 *mmio_pfnp)
>>>> +{
>>>> +	struct vm_area_struct *vma;
>>>> +	bool is_mmio;
>>>> +	u64 uaddr;
>>>> +	struct mshv_mem_region *mreg;
>>>> +	struct follow_pfnmap_args pfnmap_args;
>>>> +	int rc = -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * Do not allow mem region to be deleted beneath us. VFIO uses
>>>> +	 * useraddr vma to lookup pci bar pfn.
>>>> +	 */
>>>> +	spin_lock(&pt->pt_mem_regions_lock);
>>>> +
>>>> +	/* Get the region again under the lock */
>>>> +	mreg = mshv_partition_region_by_gfn(pt, gfn);
>>>> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
>>>> +		goto unlock_pt_out;
>>>> +
>>>> +	uaddr = mreg->start_uaddr +
>>>> +		((gfn - mreg->start_gfn) << HV_HYP_PAGE_SHIFT);
>>>> +
>>>> +	mmap_read_lock(current->mm);
>>>
>>> Semaphore can't be taken under spinlock.
> 
>>
>> Yeah, something didn't feel right here and I meant to recheck, now regret
>> rushing to submit the patch.
>>
>> Rethinking, I think the pt_mem_regions_lock is not needed to protect
>> the uaddr because unmap will properly serialize via the mm lock.
>>
>>
>>>> +	vma = vma_lookup(current->mm, uaddr);
>>>> +	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
>>>
>>> Why this check is needed again?
>>
>> To make sure region did not change. This check is under lock.
>>
> 
> How can this happen? One can't change VMA type without unmapping it
> first. And unmapping it leads to a kernel MMIO region state dangling
> around without corresponding user space mapping.

Right, and vm_flags would not be mmio expected then.

> This is similar to dangling pinned regions and should likely be
> addressed the same way by utilizing MMU notifiers to destpoy memoty
> regions is VMA is detached.

I don't think we need that. Either it succeeds if the region did not
change at all, or just fails.


>>> The region type is stored on the region itself.
>>> And the type is checked on the caller side.
>>>
>>>> +	if (!is_mmio)
>>>> +		goto unlock_mmap_out;
>>>> +
>>>> +	pfnmap_args.vma = vma;
>>>> +	pfnmap_args.address = uaddr;
>>>> +
>>>> +	rc = follow_pfnmap_start(&pfnmap_args);
>>>> +	if (rc) {
>>>> +		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
>>>> +				      NULL);
>>>> +		if (rc)
>>>> +			goto unlock_mmap_out;
>>>> +
>>>> +		rc = follow_pfnmap_start(&pfnmap_args);
>>>> +		if (rc)
>>>> +			goto unlock_mmap_out;
>>>> +	}
>>>> +
>>>> +	*mmio_pfnp = pfnmap_args.pfn;
>>>> +	follow_pfnmap_end(&pfnmap_args);
>>>> +d
>>>> +unlock_mmap_out:
>>>> +	mmap_read_unlock(current->mm);
>>>> +unlock_pt_out:
>>>> +	spin_unlock(&pt->pt_mem_regions_lock);
>>>> +	return rc;
>>>> +}
>>>> +
>>>> +/*
>>>> + * At present, the only unmapped gpa is mmio space. Verify if it's mmio
>>>> + * and resolve if possible.
>>>> + * Returns: True if valid mmio intercept and it was handled, else false
>>>> + */
>>>> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
>>>> +{
>>>> +	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
>>>> +	struct hv_x64_memory_intercept_message *msg;
>>>> +	union hv_x64_memory_access_info accinfo;
>>>> +	u64 gfn, mmio_spa, numpgs;
>>>> +	struct mshv_mem_region *mreg;
>>>> +	int rc;
>>>> +	struct mshv_partition *pt = vp->vp_partition;
>>>> +
>>>> +	msg = (struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
>>>> +	accinfo = msg->memory_access_info;
>>>> +
>>>> +	if (!accinfo.gva_gpa_valid)
>>>> +		return false;
>>>> +
>>>> +	/* Do a fast check and bail if non mmio intercept */
>>>> +	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
>>>> +	mreg = mshv_partition_region_by_gfn(pt, gfn);
>>>
>>> This call needs to be protected by the spinlock.
>>
>> This is sorta fast path to bail. We recheck under partition lock above.
>>
> 
> Accessing the list of regions without lock is unsafe.

I am not sure why? This check is done by a vcpu thread, so regions
will not have just gone away.

Thanks,
-Mukesh


> Thanks,
> Stanislav
> 
>> Thanks,
>> -Mukesh
>>
>>
>>> Thanks,
>>> Stanislav
>>>
>>>> +	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
>>>> +		return false;
>>>> +
>>>> +	rc = mshv_chk_get_mmio_start_pfn(pt, gfn, &mmio_spa);
>>>> +	if (rc)
>>>> +		return false;
>>>> +
>>>> +	if (!hv_nofull_mmio) {		/* default case */
>>>> +		gfn = mreg->start_gfn;
>>>> +		mmio_spa = mmio_spa - (gfn - mreg->start_gfn);
>>>> +		numpgs = mreg->nr_pages;
>>>> +	} else
>>>> +		numpgs = 1;
>>>> +
>>>> +	rc = hv_call_map_mmio_pages(pt->pt_id, gfn, mmio_spa, numpgs);
>>>> +
>>>> +	return rc == 0;
>>>> +}
>>>> +
>>>>    static struct mshv_mem_region *
>>>>    mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
>>>>    {
>>>> @@ -666,13 +777,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
>>>>    	return ret;
>>>>    }
>>>> +
>>>>    #else  /* CONFIG_X86_64 */
>>>> +static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp) { return false; }
>>>>    static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
>>>>    #endif /* CONFIG_X86_64 */
>>>>    static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
>>>>    {
>>>>    	switch (vp->vp_intercept_msg_page->header.message_type) {
>>>> +	case HVMSG_UNMAPPED_GPA:
>>>> +		return mshv_handle_unmapped_gpa(vp);
>>>>    	case HVMSG_GPA_INTERCEPT:
>>>>    		return mshv_handle_gpa_intercept(vp);
>>>>    	}
>>>> -- 
>>>> 2.51.2.vfs.0.1
>>>>

