Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502661;
	b=hGCj1f2eeQWE1ZwR5S4CfWkkl2Ct04g43I3INDjE8JMljHAM1rDE0y682jthcGxpePCx
	 EY4N6vnto2+uUeLxDt2d0W5UdPJMfhFBAkAJvfl1+6LwI8cz1Z/BdN58ORLeEfHn9WIQL
	 L3Md2JfchhQGn4QGGoSHKzgfxOp4byL4Xu1Z9Y5fCEd36TAv98SmsJx4qx9hPR+MIprU2
	 deQK7wD7nVUdpCMuc/ShDeKyWXp6Wxiv46Sr1pWxOoVuyCRsy4xL1THYrucZv5kAUNHQ6
	 +GNgLh01LVtRZyBSmQekKhM3AFSt/JMnS8qSg3k+L+Qec2KCW5WKFjyTqNNv6aXCIEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502661;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=6KCxuP49ZA/jhyS8CSuFRF1ohjW5VqHIFBt+co+3m+o=;
	b=tquv2gXknvBxxU5zR/tI3KiYaw/mvXdfOrYFEwF+evSHN6qkuSzKWtw7dhA/6GH6j9mp
	 aLUxCqT/iSdtOst4IYlC9Zr0380hHv5D25vNxz171d3EfAIL9u2RbxUQ3Tg58eLDT3/Gs
	 IdKi/cgsDn4hurGLBujFo+J/auE5vmZ8JZFRpk6Z7WOi6g940x+xbh3LIbHYxw59V96Fe
	 E2UKKl4Hpr/sThYmMirvHtOYdQdViGFMUJo7Etno9nEpJXmxfE5WMt+befVcyv2HUhVcu
	 aBYVjze7Z5/s4I63yZAt8YcK7rDRlysPNbbTVoXi+cnnkVMO6sD8rphGTm92SJURn1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=g+zyOARA;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B9606A322;
	Tue, 24 Nov 2026 06:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21B9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=g+zyOARA
Received: from [10.95.64.197] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B3A320B716A;
	Mon, 23 Nov 2026 22:44:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B3A320B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502656;
	bh=6KCxuP49ZA/jhyS8CSuFRF1ohjW5VqHIFBt+co+3m+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+zyOARAxxGprdOLkF1HD/p5nb4fs1wB1/2wsel3+0vijEKXB6pwQx00EZc8SLHHn
	 u078suSLAsak3B3l2RyCouSV5gS8YRHPljHueUnxpyWccK2kXiJwk3mgyXxsRYSEvR
	 CdcqOZDip1/KZMDd/cpaJcEbdPxLFpF4rzK6RCiU=
Message-ID: <14e81d94-1219-4999-8d32-a3f8d1a90e50@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:14:12 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/tlb: Make the conditional flush predicate
 reusable
To: Michael Kelley <mhklinux@outlook.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "riel@surriel.com" <riel@surriel.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>,
 "houwenlong.hwl@antgroup.com" <houwenlong.hwl@antgroup.com>,
 "qq570070308@gmail.com" <qq570070308@gmail.com>,
 "bastien.curutchet@bootlin.com" <bastien.curutchet@bootlin.com>,
 "dianders@chromium.org" <dianders@chromium.org>,
 "jgross@suse.com" <jgross@suse.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-3-namjain@linux.microsoft.com>
 <MN2PR02MB6863198AC15E17474598EF23D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863198AC15E17474598EF23D4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:46 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>
> 
> In the patch Subject, avoid the "flush predicate" terminology (see my
> comment on Patch 4).

Acked. I can use this:
[PATCH v3 2/5] x86/tlb: Make should_flush_tlb() available to Hyper-V

> 
>> Make should_flush_tlb() available to the Hyper-V backend and give it a
> 
> What is the Hyper-V "backend"?  Maybe more specific would be
> "PV tlb flush functions"?

yes, I should change it to "Hyper-V PV TLB flush functions".

> 
>> const struct flush_tlb_info pointer instead of void *. Keep a
>> should_flush_tlb_wrapper() adapter for the SMP callback interface.
> 
> Is there any particular reason for needing a specific type instead
> of keeping the void *? I'm just wondering what value that change
> adds other than the compiler being able to typecheck the call
> as made from the Hyper-V code.
> 
> Michael

No functional reason. I changed the type because the Hyper-V caller
passes a "const flush_tlb_info *" while should_flush_tlb() expects
"void *". The original function does not modify the request, although
its local pointer is not declared const.

Keeping the void * signature would also work, with an explicit cast
at the Hyper-V call site. I can keep the existing signature if you
prefer a smaller change.

Regards,
Naman

> 
>>
>> No functional changes.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/include/asm/tlbflush.h |  1 +
>>   arch/x86/mm/tlb.c               | 18 ++++++++++++++----
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 70098d448e999..1d1852ecaf084 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -263,6 +263,7 @@ void flush_tlb_one_user(unsigned long addr);
>>   void flush_tlb_one_kernel(unsigned long addr);
>>   void flush_tlb_multi(const struct cpumask *cpumask,
>>   		      const struct flush_tlb_info *info);
>> +bool should_flush_tlb(int cpu, const struct flush_tlb_info *info);
>>
>>   static inline bool is_dyn_asid(u16 asid)
>>   {
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 53dcab39566f2..9b1aea2b3a1d5 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1279,10 +1279,14 @@ static void flush_tlb_func(void *info)
>>   			nr_invalidate);
>>   }
>>
>> -static bool should_flush_tlb(int cpu, void *data)
>> +/*
>> + * Select ordinary flush targets using state ordered against context switches.
>> + * Callers must bypass this filtering for page-table freeing and global ASID
>> + * transitions, as native_flush_tlb_multi() does.
>> + */
>> +bool should_flush_tlb(int cpu, const struct flush_tlb_info *info)
>>   {
>>   	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
>> -	struct flush_tlb_info *info = data;
>>
>>   	/*
>>   	 * Order the 'loaded_mm' and 'is_lazy' against their
>> @@ -1317,6 +1321,12 @@ static bool should_flush_tlb(int cpu, void *data)
>>   	return false;
>>   }
>>
>> +/* Adapt the typed predicate to the SMP conditional-call interface. */
>> +static bool should_flush_tlb_wrapper(int cpu, void *data)
>> +{
>> +	return should_flush_tlb(cpu, data);
>> +}
>> +
>>   static bool should_trim_cpumask(struct mm_struct *mm)
>>   {
>>   	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
>> @@ -1357,8 +1367,8 @@ STATIC_NOPV void native_flush_tlb_multi(const struct
>> cpumask *cpumask,
>>   	if (info->freed_tables || mm_in_asid_transition(info->mm))
>>   		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>>   	else
>> -		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>> -				(void *)info, 1, cpumask);
>> +		on_each_cpu_cond_mask(should_flush_tlb_wrapper, flush_tlb_func,
>> +				      (void *)info, 1, cpumask);
>>   }
>>
>>   void flush_tlb_multi(const struct cpumask *cpumask,
>> --
>> 2.43.0
>>

