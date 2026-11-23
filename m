Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429023;
	b=votrbTF97yB14h1bINYgAaXSAXsqyh/7VMDIN4WMSCNAQSrKkx6Y0b8U2nkMWJzdpuvL
	 aNB4PiK1CUP2X2fc8IjhYtXxFuK37uTzO5r/iSfu5JC+d7L5ziexQ6C/TFFcc4OK301ns
	 rBDHhgFgThC/EOVvm1cmpwGu4R+imLwzP0LG4CoIVZ38hhf1B/73bSOK6Nl1HJT9Ssi1k
	 HO1wzs+UPcw1AgV27UTCgkuNg2rYzzo8ZNmcl/PIktnE/xiTRWvBWynyhb21+W6cbNWG+
	 mxvbgn/9SZhqfLMYRIcgFUGAxGdCFudem/pxrrGFhRbZUo3/dXKKSEG1SKMt0jL0XFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429023;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=LCEL5ZzIE6CqXobcR7VCKJa1aUMGK3bIhlWJxWwXyDE=;
	b=P/7fR2+9CWb2UoKkXd4yQfahI44QiegQlr07wSMhvw1AEcdfqcHNOrICCczR8DYOg4Zj
	 coicBv/h4g/EdBoZs2+SqPotFsbR6h+086zu6bGmt0hRbMdR/Xr4lmsrG6BeKteeNKIJP
	 5byxuHkoq+pEcCHlRWGYkT5HbAvn97+YHLEJ0erFygOVdqlr+DTN2OK0ZlV8UK0ATI9Ch
	 QLH1ls9Zuz0mtSCTbAj2HISTOk3xCfNR/yO1cuEXsbljUZkyVye4GBC9qmM54vX3kI188
	 u9PIk6mNpwCnBRRKoIxpop06Rii395ouxtwXHmXCmTz7mqgPL25elMDQiFwGz5hdJaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rxoIeIO1;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F9606A31A;
	Mon, 23 Nov 2026 10:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rxoIeIO1
Received: from [10.95.64.197] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A89A20B7167;
	Mon, 23 Nov 2026 02:16:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A89A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795429018;
	bh=LCEL5ZzIE6CqXobcR7VCKJa1aUMGK3bIhlWJxWwXyDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rxoIeIO18TglfBjIcajTCoR/X8ML4F+WY3w+5OpD/PM3z4cS3F3Ko20AymxoYuSaI
	 6Q1snFFRkujmbmsUHlk5xCRxuj0951U4mDhRcx4YH1rKTPUnW/j64kz6jYlAPbG1Cb
	 uXBCaMUbovUpD09F5tWvQ0w78fn34KDkmcLOfMuQ=
Message-ID: <102925b6-98c1-4535-bdbe-a682cc89e188@linux.microsoft.com>
Date: Mon, 23 Nov 2026 15:46:53 +0530
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
Subject: Re: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building
 hypercalls
To: Sahil Chandna <sahilchandna@linux.microsoft.com>, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 peterz@infradead.org
Cc: hpa@zytor.com, riel@surriel.com, mhklinux@outlook.com,
 bigeasy@linutronix.de, zhouchuyi@bytedance.com, houwenlong.hwl@antgroup.com,
 qq570070308@gmail.com, bastien.curutchet@bootlin.com, dianders@chromium.org,
 jgross@suse.com, hawk@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
 <d2857fff-9289-4b60-ac97-6194dea2d040@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <d2857fff-9289-4b60-ac97-6194dea2d040@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/23/2026 3:27 PM, Sahil Chandna wrote:
> 
> 
> On 17/11/2026 14:45, Naman Jain wrote:
>> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs 
>> regressed
>> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch 
>> caused
>> host-to-GPU copy stalls and timeouts. The reported bisection identified
>> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
>>
>> That change leaves a CPU's bit set after it switches to another mm.
>> Native flush callbacks remove these stale bits, but successful Hyper-V
>> hypercalls do not run those callbacks. A CPU actively running another
>> mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
>> exclude it. If the mask includes all present CPUs, the backend selects
>> the all-processors shortcut before checking individual CPUs.
>>
>> Use the native predicate to build a per-CPU target mask before selecting
>> the all-processors shortcut or either hypercall format. Keep the full
>> candidate mask when freeing page tables. Retain the empty basic-mask
>> check because filtering can leave no targets.
>>
>> This patch does not change when trimming is requested.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/mmu.c | 40 ++++++++++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index 375f23b157ab3..833eaea1d3fa8 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -1,6 +1,7 @@
>>   #define pr_fmt(fmt)  "Hyper-V: " fmt
>>   #include <linux/log2.h>
>> +#include <linux/percpu.h>
>>   #include <linux/slab.h>
>>   #include <linux/types.h>
>> @@ -16,6 +17,8 @@
>>   /* Each gva in gva_list encodes up to 4096 pages to flush */
>>   #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
>> +static DEFINE_PER_CPU(struct cpumask, hyperv_tlb_flush_mask);
>> +
>>   static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>>                         const struct flush_tlb_info *info);
>> @@ -51,19 +54,14 @@ static inline int fill_gva_list(u64 gva_list[], 
>> int offset,
>>       return gva_n - offset;
>>   }
>> -static bool cpu_is_lazy(int cpu)
>> -{
>> -    return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
>> -}
>> -
>>   static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>                      const struct flush_tlb_info *info)
>>   {
>>       int cpu, vcpu, gva_n, max_gvas;
>>       struct hv_tlb_flush *flush;
>> +    struct cpumask *flush_cpus;
>>       u64 status;
>>       unsigned long flags;
>> -    bool do_lazy = !info->freed_tables;
>>       trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>> @@ -87,6 +85,23 @@ static void hyperv_flush_tlb_multi(const struct 
>> cpumask *cpus,
>>           goto do_native;
>>       }
>> +    flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
>> +    /*
>> +     * mm_cpumask() may retain CPUs that have switched to another mm.
>> +     * Use the native predicate for its context-switch ordering and lazy
>> +     * TLB exclusion. Page-table freeing must include lazy CPUs, so keep
>> +     * the full candidate mask in that case.
>> +     */
>> +    if (info->freed_tables) {
>> +        cpumask_copy(flush_cpus, cpus);
> Hi Naman,
> 
> In VM, for a process that has ran lets say on multiple CPUs (worst case
> - on all CPUS), and now running on a single cpu while other cpu run
> different processes. Until the next trim, if this process calls munmap()
> or any flush_tlb_range() which has freed_tables set to true, this would
> copy all stale CPUs in flush_cpus and patch 5 will skip native path, and
> can cause HV_FLUSH_ALL_PROCESSORS (for all cpu scenario) as in original
> issue ?
> 
> Regards,
> Sahil


Hi,

Yes, your understanding is correct. With freed_tables set, we keep the
original CPU mask. If it contains all present CPUs, we can still select
HV_FLUSH_ALL_PROCESSORS, and patch 5's no-remote-target cleanup will
not run.

We keep the full mask because freeing page tables requires including
lazy CPUs. The filter we reuse skips lazy CPUs, so we cannot safely
apply it unchanged here. The native path also bypasses this filter
when freed_tables is set.

This does not mean every stale CPU needs the flush. Safely excluding
those CPUs while retaining the required lazy CPUs would need separate
logic.

So this series improves ordinary flushes, but the overhead you describe
can remain for page-table-freeing flushes until stale entries are
removed by native cleanup.

Regards,
Naman
