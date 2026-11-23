Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427863;
	b=NR49sOrDAjvHDSDIJVOr6vQlPh4v1kCDhQ6xvXn8/4NGyT+jFasnXy0ps2mrpuItZVYi
	 erS6iOCtB2KxwpG91RSHoPXvHAtqRLYqEUMVOj2+DoIiOZV6bf5x9e+q7jIxbaz8GyD27
	 ugUVhZbTo/gIKf6KHiDBEHvx8VyPulQkclW0N0aZ/I5JYj4tSYI9pJrDa80UA6T9gIMV1
	 1Sfj1wa+bHv/Q+pgFUyrKgby6YSO4M5LMhEPdVSpmyhRSOGut4wI+YMTYNHg7WxTrJA9j
	 9CqfN7MXNona95U+Gnz0N+mNdHxai+yGvjkWyhP1vMWcwUs4HmqGtmViwb1BOomreMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427863;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=aj7jXoHhBMxF1whDYLxx2xV390qlwMkMeBDrrsc0htQ=;
	b=vML2H2acEu1LskhY99OdbEzkmU9rMhZGxf51uj2ynnhC+pkK6pycFUi0rYLGnuX4IvmE
	 qe6emqYz6OlTnzNVMwqhnW1lXBdabdoRdu8yXJxWso5ak9FlxLv0MaCNtPKfGdO/HL0AM
	 IAjuUWnnAvi8ZEFe008bdtoTosT8yooBBpczseQzeXWTSdMaDfBzpTDppsamiqwqA9sJE
	 Q3SyMQXid9Oylk4RZ4g2OYCS0xalD8QW06FgXCp75dfAZ9D7BvAsS3ehLuEZ+1eyh3d/3
	 LiXQTwrDw4bp+S9rBRcEshv3oVu/YSPmtg1i4v0gxrSUI68lB7ygIjzhxUqQjO175Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D2jle0rZ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB3606A31A;
	Mon, 23 Nov 2026 09:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=D2jle0rZ
Received: from [10.18.135.130] (unknown [167.220.238.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D7ED20B7167;
	Mon, 23 Nov 2026 01:57:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D7ED20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795427858;
	bh=aj7jXoHhBMxF1whDYLxx2xV390qlwMkMeBDrrsc0htQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D2jle0rZhDZaeedAeo7DLmNuTuvSUDheoIucOW7Dc6+CxGS37UySDTDj2XezzeNNG
	 rWgfWq+76kfFLlev8bqo2EPVqO4BR/Wvs56HanNU+r2jgx0vhFCnIHybjTgqMwYue9
	 qv/7IqC1u4aWrlb6qsuCkztvhOhRuTHY2Jh62n20=
Message-ID: <d2857fff-9289-4b60-ac97-6194dea2d040@linux.microsoft.com>
Date: Mon, 23 Nov 2026 15:27:33 +0530
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
To: Naman Jain <namjain@linux.microsoft.com>, haiyangz@microsoft.com,
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
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <20261117091507.2088642-5-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/11/2026 14:45, Naman Jain wrote:
> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regressed
> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch caused
> host-to-GPU copy stalls and timeouts. The reported bisection identified
> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
> 
> That change leaves a CPU's bit set after it switches to another mm.
> Native flush callbacks remove these stale bits, but successful Hyper-V
> hypercalls do not run those callbacks. A CPU actively running another
> mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
> exclude it. If the mask includes all present CPUs, the backend selects
> the all-processors shortcut before checking individual CPUs.
> 
> Use the native predicate to build a per-CPU target mask before selecting
> the all-processors shortcut or either hypercall format. Keep the full
> candidate mask when freeing page tables. Retain the empty basic-mask
> check because filtering can leave no targets.
> 
> This patch does not change when trimming is requested.
> 
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>   arch/x86/hyperv/mmu.c | 40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 375f23b157ab3..833eaea1d3fa8 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -1,6 +1,7 @@
>   #define pr_fmt(fmt)  "Hyper-V: " fmt
>   
>   #include <linux/log2.h>
> +#include <linux/percpu.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   
> @@ -16,6 +17,8 @@
>   /* Each gva in gva_list encodes up to 4096 pages to flush */
>   #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
>   
> +static DEFINE_PER_CPU(struct cpumask, hyperv_tlb_flush_mask);
> +
>   static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>   				      const struct flush_tlb_info *info);
>   
> @@ -51,19 +54,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
>   	return gva_n - offset;
>   }
>   
> -static bool cpu_is_lazy(int cpu)
> -{
> -	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> -}
> -
>   static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>   				   const struct flush_tlb_info *info)
>   {
>   	int cpu, vcpu, gva_n, max_gvas;
>   	struct hv_tlb_flush *flush;
> +	struct cpumask *flush_cpus;
>   	u64 status;
>   	unsigned long flags;
> -	bool do_lazy = !info->freed_tables;
>   
>   	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>   
> @@ -87,6 +85,23 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>   		goto do_native;
>   	}
>   
> +	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
> +	/*
> +	 * mm_cpumask() may retain CPUs that have switched to another mm.
> +	 * Use the native predicate for its context-switch ordering and lazy
> +	 * TLB exclusion. Page-table freeing must include lazy CPUs, so keep
> +	 * the full candidate mask in that case.
> +	 */
> +	if (info->freed_tables) {
> +		cpumask_copy(flush_cpus, cpus);
Hi Naman,

In VM, for a process that has ran lets say on multiple CPUs (worst case
- on all CPUS), and now running on a single cpu while other cpu run
different processes. Until the next trim, if this process calls munmap()
or any flush_tlb_range() which has freed_tables set to true, this would
copy all stale CPUs in flush_cpus and patch 5 will skip native path, and
can cause HV_FLUSH_ALL_PROCESSORS (for all cpu scenario) as in original
issue ?

Regards,
Sahil
> +	} else {
> +		cpumask_clear(flush_cpus);
> +		for_each_cpu(cpu, cpus) {
> +			if (should_flush_tlb(cpu, info))
> +				__cpumask_set_cpu(cpu, flush_cpus);
> +		}
> +	}
> +
>   	if (info->mm) {
>   		/*
>   		 * AddressSpace argument must match the CR3 with PCID bits
> @@ -101,7 +116,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>   	}
>   
>   	flush->processor_mask = 0;
> -	if (cpumask_equal(cpus, cpu_present_mask)) {
> +	if (cpumask_equal(flush_cpus, cpu_present_mask)) {
>   		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
>   	} else {
>   		/*
> @@ -115,14 +130,12 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>   		 * must. We will also check all VP numbers when walking the
>   		 * supplied CPU set to remain correct in all cases.
>   		 */
> -		cpu = cpumask_last(cpus);
> +		cpu = cpumask_last(flush_cpus);
>   
>   		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >= 64)
>   			goto do_ex_hypercall;
>   
> -		for_each_cpu(cpu, cpus) {
> -			if (do_lazy && cpu_is_lazy(cpu))
> -				continue;
> +		for_each_cpu(cpu, flush_cpus) {
>   			vcpu = hv_cpu_number_to_vp_number(cpu);
>   			if (vcpu == VP_INVAL) {
>   				local_irq_restore(flags);
> @@ -166,7 +179,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>   	goto check_status;
>   
>   do_ex_hypercall:
> -	status = hyperv_flush_tlb_others_ex(cpus, info);
> +	status = hyperv_flush_tlb_others_ex(flush_cpus, info);
>   
>   check_status:
>   	local_irq_restore(flags);
> @@ -205,8 +218,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
>   	flush->hv_vp_set.valid_bank_mask = 0;
>   
>   	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> -	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
> -			info->freed_tables ? NULL : cpu_is_lazy);
> +	nr_bank = cpumask_to_vpset(&flush->hv_vp_set, cpus);
>   	if (nr_bank <= 0)
>   		return HV_STATUS_INVALID_PARAMETER;
>   

