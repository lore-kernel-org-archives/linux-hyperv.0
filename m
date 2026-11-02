Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608860;
	b=xKI9Q82H+2BwiAChFEPqjic3uYMVYPA1A3xzBjCkyCjgx8zGubXPn5HF0oLnG6tfo61y
	 p2VdErTcMuEXO9cGq/715XqXQYlrdLzVYWsHnpJtXX9SCMYSXa1yY9WpClBqMsOdFz8Ah
	 d5xmOmFQ4xoNc1pSOje1dgBBFkb53P1ycO1SgtDkYroOqOB2zsD07++L7CqxS12DtA/gT
	 kRer7VHSLWydjehgjgZK63dcn3815rn3Qw4DVDo8UXDXyGJflzfSjbTyyxt2jqEI6G60M
	 6NB8idxyglUbCVVWAmnLCBwWsj5KHtzUtW6Jslz1S6PcHZE2ryK9WXBuMn1ulOE/EvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608860;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=TBMPW9Hz/9HOJ6hvWgJSPpHoL/GUz3UlXN+d2qADpsk=;
	b=4T3aUs5ntfyfewcNUBP6mmXSPoT3FNetfH61/XjfsRpiJ6fVQej5XlRPWV+Jz2gldMbi
	 l/snzdxYyTzqqx2d06028FzI8N+2gHr93SmSiewkLZ4Xo+Y8VpfF1sNYrcKe2gJ8iTLgC
	 z1rzxRhpz576AxjHr3bRfYFSAzdRgGfFuUl8H3I2FsmtbSxRgO1rLuQIjQ8E7YMsBahR9
	 ecXjFDszZ4Er00SxRxofI1VnmP7c4iGP46zUrfP/kME9OutU/aPraexrNh+w7zyngYg9d
	 Dk1MgLPzSv1dqsgSELcODUmJIIJ4cBAjkfrPH9UJGoUaOem7Pd8ieoGtQqQ8jrpZPzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NYGQybIW;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8250606A324;
	Mon,  2 Nov 2026 08:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8250606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NYGQybIW
Received: from [10.95.64.190] (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDA7B20B7166;
	Mon,  2 Nov 2026 00:40:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDA7B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793608844;
	bh=TBMPW9Hz/9HOJ6hvWgJSPpHoL/GUz3UlXN+d2qADpsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NYGQybIWbkUHU2Bw31QghwVsbUX6WhJzJCjW1MhEzn7M7abGTFZPxJXyngJgDMfki
	 uBnrIadeDBXoxg+LkTfUrNTyb/GgGbRb61+3hDBkqv8xb9Wwfk8+Da6BSHJgCmnF56
	 iM/hq/WIlcNLVRcZIp/Y28hF44eo2kgtyOuIy2XI=
Message-ID: <1aa540cd-5bcc-492e-a6d2-561962d9dd69@linux.microsoft.com>
Date: Mon, 2 Nov 2026 14:10:52 +0530
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
Subject: Re: [PATCH] x86/hyperv: Account for lazy mm_cpumask maintenance
To: Dave Hansen <dave.hansen@intel.com>, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 peterz@infradead.org
Cc: hpa@zytor.com, riel@surriel.com, mhklinux@outlook.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029064234.362385-1-namjain@linux.microsoft.com>
 <cae10e61-ef31-4a66-9de9-7c39663026cd@intel.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <cae10e61-ef31-4a66-9de9-7c39663026cd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/2026 9:39 PM, Dave Hansen wrote:
> On 10/28/26 23:42, Naman Jain wrote:
>> CPUs no longer running an mm may remain in mm_cpumask(). Hyper-V treats
>> these CPUs as flush targets and bypasses the native callbacks that trim
>> the mask. A single-threaded process can therefore keep issuing
>> all-processor flushes after visiting all CPUs and returning to one CPU.
>>
>> Share the native target predicate and filter the mask before building
>> either hypercall format or selecting HV_FLUSH_ALL_PROCESSORS. Preserve
>> lazy-TLB exclusion and unfiltered page-table-freeing flushes, and use
>> native callbacks for periodic trimming and ASID transitions.
>>
>> When no remote targets remain, request immediate trimming through native
>> callbacks so stale memberships do not unnecessarily prevent later
>> invalidations from using the local fast path. Leave lazy CPU-mask
>> maintenance during context switches unchanged.
> 
> There's a lot of stuff in this patch not covered in the changelog. Like
> the mm_in_asid_transition() addition.
> 
> This reads to me as being highly LLM-generated and not super readable or
> relevant.

In my attempt to fix AI reported issues, I combined several changes
without explaining their individual purposes clearly enough. I'll split
the patch and simplify the explanations.

> 
>> Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
> 
> We usually don't put Fixes: tags on performance improvements.
> 
> I don't want this backported.

I included Fixes because this is a measured regression rather than a
general optimization. We observed the SuperBench workload regress
between 6.8 and 7.0 and bisected it to 209954cbc7d0. That commit stopped
clearing outgoing mm_cpumask bits at context-switch time and moved their
removal into the native flush callback, which successful Hyper-V
hypercalls bypass. More details on this in my reply to Michael Kelley in 
this thread.

I understand that you don't want this backported, but if this changes
anything, please let me know.

> 
>> -	if (!hv_hypercall_pg)
>> +	/*
>> +	 * Hypercalls bypass the callbacks that trim mm_cpumask() and complete
>> +	 * ASID transitions.
>> +	 */
>> +	if (!hv_hypercall_pg || info->trim_cpumask ||
>> +	    mm_in_asid_transition(info->mm))
>>   		goto do_native;
> 
> What do ASID transitions have to do with this?

They are separate from the reported regression. The native path
explicitly bypasses this predicate during global ASID transitions,
and its callbacks can switch CPUs still using a local ASID to the
mm's global ASID.

A Hyper-V flush hypercall does not run those callbacks. I added the
guard to preserve that handling when reusing the native predicate.

The missing fallback predates this patch. I'll separate it for review
and explain the reason. I have not runtime-tested the transition case.

> 
>>   	local_irq_save(flags);
>> @@ -79,6 +82,30 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>   		goto do_native;
>>   	}
>>   
>> +	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
>> +	if (info->freed_tables) {
>> +		cpumask_copy(flush_cpus, cpus);
>> +	} else {
>> +		cpumask_clear(flush_cpus);
>> +		for_each_cpu(cpu, cpus) {
>> +			if (cpu_needs_tlb_flush(cpu, info))
>> +				__cpumask_set_cpu(cpu, flush_cpus);
>> +		}
>> +	}
> 
> This needs some heavy commenting. Or a helper. Or both.

Acked.

> 
>> +	/*
>> +	 * An effectively local mm should not keep taking the remote path until
>> +	 * the next periodic trim. Let the native callbacks prune stale bits.
>> +	 */
>> +	if (cpumask_any_but(flush_cpus, smp_processor_id()) >= nr_cpu_ids) {
> 
> Is this condition right? Doesn't ">= nr_cpu_ids" mean "no other CPUs found"?
> 
> I'm not following this.

Yes, that is the intended condition. The filtered mask contains no CPU
other than the current CPU, or is empty.

The purpose was to avoid a Hyper-V hypercall when there are no remote
targets, and to request native mask cleanup at that point. The comment
doesn't explain that clearly enough. I'll fix it.

> 
>> +		struct flush_tlb_info local_info = *info;
> 
> What's wrong with reusing 'info'?

The argument 'info' is const. The copy lets this call request trimming 
without modifying the caller's request.

> 
>> +		local_info.trim_cpumask = 1;
>> +		local_irq_restore(flags);
>> +		native_flush_tlb_multi(cpus, &local_info);
>> +		return;
>> +	}
> 
> Gah, so is this hacking "trim_cpumask = 1" to force should_flush_tlb()
> or something?

Yes. It makes the native predicate select stale, non-lazy members so
their callbacks can clear their own mask bits. The intent was to avoid
waiting for periodic trimming before later flushes can use the local
fast path.

> 
> Right now, we have quite clean code around info->trim_cpumask. It's
> either 0 or set from:
> 
> 	info.trim_cpumask = should_trim_cpumask(mm);
> 
> It would be nice to keep it that way if possible.

Agreed. Having a second trimming decision in the Hyper-V backend is
awkward. I'll separate this cleanup optimization from target filtering
so we can review the policy independently.

> 
> Also, just looking at flush_tlb_mm_range(), there's a very familiar
> check there:
> 
>          } else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
>                  remote_flush = true;
> 
> which feeds:
> 
>          if (remote_flush) {
>                  info.trim_cpumask = should_trim_cpumask(mm);
>                  flush_tlb_multi(mm_cpumask(mm), &info);
>                  consider_global_asid(mm);
>          }
> 
> So what if we just added a check to should_trim_cpumask(), like:
> 
> 	if (cpumask_weight(mm_cpumask(mm)) > atomic_read(&mm->mm_users))
> 		return true;
> 
> Or mm_users*2, or _some_ other heuristic that will trip when
> mm_cpumask(mm) gets out of whack from ->mm_users.
> 
> That's a pretty cheap check because mm_cpumask() is already hot or is
> just about to be read anyway. It might actually be useful to INVLPGB
> systems too. That still needs the info->trim_cpumask check at the top of
> hyperv_flush_tlb_multi(), btw.
> 

I tested this as a replacement for the Hyper-V forced-trim block on a
32-vCPU Hyper-V VM, retaining the native fallback for
info->trim_cpumask. With three remote readers, mm_users was 4, while
the mask weight remained at 26–32, including 22–28 lazy memberships.

For ordinary flushes, trimming skips lazy CPUs. The comparison stayed
true across 10,000 flush requests, and each reader received 10,000
remote callbacks. The current patch used Hyper-V hypercalls instead
in the corresponding test.

I agree with centralizing the decision, but the raw comparison can
keep requesting cleanup while lazy memberships keep the condition
true. A 2x threshold would still trigger for these observed counts.

> Also, this is *kinda* changing the meaning of ->trim_cpumask. It's
> really starting to mean "send IPIs". A rename might be appropriate.
> 

For Hyper-V it does select native callbacks rather than a flush
hypercall. The native predicate still skips lazy CPUs, though, so it
does not mean unconditional IPI delivery.

I'll revisit the name as part of the separate cleanup patch, once
the intended policy is settled.

> /*
>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>> index 70098d448e999..e1e05cc867d5a 100644
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -264,6 +264,12 @@ void flush_tlb_one_kernel(unsigned long addr);
>>   void flush_tlb_multi(const struct cpumask *cpumask,
>>   		      const struct flush_tlb_info *info);
>>   
>> +/*
>> + * Do not use for filtering when freeing page tables or during global ASID
>> + * transitions.
>> + */
>> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info);
> 
> Please look around this header that's being patched. Are the functions
> above this commented? Please match the style.
> 
> Comment the definition itself, not the declaration.
> 

Acked.

>>   static inline bool is_dyn_asid(u16 asid)
>>   {
>>   	return asid < TLB_NR_DYN_ASIDS;
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 0c4da320831cb..f2f40928d56a4 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1273,10 +1273,9 @@ static void flush_tlb_func(void *info)
>>   			nr_invalidate);
>>   }
>>   
>> -static bool should_flush_tlb(int cpu, void *data)
>> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)
>>   {
>>   	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
>> -	struct flush_tlb_info *info = data;
>>   
>>   	/*
>>   	 * Order the 'loaded_mm' and 'is_lazy' against their
>> @@ -1311,6 +1310,11 @@ static bool should_flush_tlb(int cpu, void *data)
>>   	return false;
>>   }
>>   
>> +static bool should_flush_tlb(int cpu, void *data)
>> +{
>> +	return cpu_needs_tlb_flush(cpu, data);
>> +}
>> +
>>   static bool should_trim_cpumask(struct mm_struct *mm)
>>   {
>>   	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
> 
> None of this movement is mentioned in the changelog. The naming change
> here is also really silly. Now we have
> 
> 	should_flush_tlb(int cpu, void *data)
> and
> 	cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)
> 
> which are literally the same thing, except for the type. This is
> precisely the kind of place we should keep the names _identical_. Either
> use an __ or call the "void *" version "_wrapper" or something with a
> comment:
> 
> /* Wrap foo() with a different type for use as an IPI callback: */
> 
> BTW, this "patch" probably needs to be broken up into a 4-5ish patch series.


I can use the wrapper and explain its role.
I'll also break this patch into a series.

Thanks for reviewing.

Regards,
Naman

