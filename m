Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376591;
	b=Jf97qAVRHAFF8u5GzGJe/Qn8FJzS3oP+nBxQESuh3hkLGFZnfNjkP8MmvzAhgSMbcQLc
	 8yZou2MIVPQbff3LKlZU8QeQ3qT9p0E+ilWICj7q9UNBxVJXVqWHuF0r5MHaLskTSyvO3
	 XK7KQQ9H2y5Q/kEu80KEzpQ4pNz2F/iEiC/Wkoz5r5/hEtbM+++uCp1YIT2gFSumwztHZ
	 o6ex7P+M6ArDv6X5XH3gidyqj89nu235S71OoUl41yw4nba4mA9d5bdbSzk5qHuO2HxxQ
	 ev52DaOH0/bhY9ae8mEXbLv+dhusknOhohBew+Mw1c1iR3Bt9H1CZo3Zf5P2bF3MGVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376591;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=l7MQJpq5X4hRH088gv4skWVl01UmYhbxjHKQkDLkjWw=;
	b=eyK2dLnb3DDhcrGUzk3SAtEaCevVAHCl2ikJhDxvFTeONTY3truoLDbrJ1BjcWAe9kcR
	 sRz0dIDMPoZITO8h2DJwiX1CuSU0Mfa26KNFh3VzIx92eYQSn8FhBl9ipJVubcUQsFDC3
	 REhnEk7vchsFHyDTn85qpB0iPGtz/b1i6/Jsb80G1BMozMBuB6Acxb4kO0zqvx/ojvSJG
	 bvl3Do0Fhs2C3psTx+X/s5zbWILfXtgZ4KreRJ2sqQc3klEMFSXwyjgL6jCNmPaIg2jm8
	 V4XTzN7n1XeU4ScSKI8+PaxbNc2zjSUMa5PaMpOQGoe1YohfaGPlbid9ayAh7hQIYOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAl51e+S;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FA606A31D;
	Fri, 30 Oct 2026 16:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B72FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAl51e+S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793376590; x=1824912590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fQlYVdL1pbh/31Fi7mDROTG98juC6ku4Icdzr6337Lk=;
  b=aAl51e+Sptp4ytOf9u1RduQnXNuW4ZNbkRTTlWi3UOqBTPBq+6mgU/uq
   PLm+iNR0GnuiqNgROZRoa3UBLjQcVR56GRuPjbSj+mHyLfTNS5FKnIpDB
   1X4jwPAUG+nd23hfvXgHIHB3SJ/7GDBmMIWJyxbJ59US40ZRIJzX9RnES
   NfAPpbSDyHLKwuMiTDZaz13EYR6r5racoTrbrRebgNK9lRd5/E9SViYr2
   lqha+qFQtja5mLYT+Mi/fjaedTudfZVGbmQhgwCH4KVC4eyAWoMmVLAFJ
   l0HEN/O0ja9/WYIR0BQGw36mqgxGxeLcrZIkGD93FvH/wWobVH2LepA5P
   A==;
X-CSE-ConnectionGUID: hdxx9vveSHuOgR3Url4qfA==
X-CSE-MsgGUID: /0TO/8MUQ/mh/RC44VJn/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2026996"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2026996"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:09:49 -0700
X-CSE-ConnectionGUID: JUobdqyyQSufSPwejqe/BA==
X-CSE-MsgGUID: Q9XnYa6VRI6yjQZy65vBBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5362348"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.109.71]) ([10.125.109.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:09:50 -0700
Message-ID: <cae10e61-ef31-4a66-9de9-7c39663026cd@intel.com>
Date: Fri, 30 Oct 2026 09:09:49 -0700
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
To: Naman Jain <namjain@linux.microsoft.com>, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 peterz@infradead.org
Cc: hpa@zytor.com, riel@surriel.com, mhklinux@outlook.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029064234.362385-1-namjain@linux.microsoft.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20261029064234.362385-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 23:42, Naman Jain wrote:
> CPUs no longer running an mm may remain in mm_cpumask(). Hyper-V treats
> these CPUs as flush targets and bypasses the native callbacks that trim
> the mask. A single-threaded process can therefore keep issuing
> all-processor flushes after visiting all CPUs and returning to one CPU.
> 
> Share the native target predicate and filter the mask before building
> either hypercall format or selecting HV_FLUSH_ALL_PROCESSORS. Preserve
> lazy-TLB exclusion and unfiltered page-table-freeing flushes, and use
> native callbacks for periodic trimming and ASID transitions.
> 
> When no remote targets remain, request immediate trimming through native
> callbacks so stale memberships do not unnecessarily prevent later
> invalidations from using the local fast path. Leave lazy CPU-mask
> maintenance during context switches unchanged.

There's a lot of stuff in this patch not covered in the changelog. Like
the mm_in_asid_transition() addition.

This reads to me as being highly LLM-generated and not super readable or
relevant.

> Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")

We usually don't put Fixes: tags on performance improvements.

I don't want this backported.

> -	if (!hv_hypercall_pg)
> +	/*
> +	 * Hypercalls bypass the callbacks that trim mm_cpumask() and complete
> +	 * ASID transitions.
> +	 */
> +	if (!hv_hypercall_pg || info->trim_cpumask ||
> +	    mm_in_asid_transition(info->mm))
>  		goto do_native;

What do ASID transitions have to do with this?

>  	local_irq_save(flags);
> @@ -79,6 +82,30 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>  		goto do_native;
>  	}
>  
> +	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
> +	if (info->freed_tables) {
> +		cpumask_copy(flush_cpus, cpus);
> +	} else {
> +		cpumask_clear(flush_cpus);
> +		for_each_cpu(cpu, cpus) {
> +			if (cpu_needs_tlb_flush(cpu, info))
> +				__cpumask_set_cpu(cpu, flush_cpus);
> +		}
> +	}

This needs some heavy commenting. Or a helper. Or both.

> +	/*
> +	 * An effectively local mm should not keep taking the remote path until
> +	 * the next periodic trim. Let the native callbacks prune stale bits.
> +	 */
> +	if (cpumask_any_but(flush_cpus, smp_processor_id()) >= nr_cpu_ids) {

Is this condition right? Doesn't ">= nr_cpu_ids" mean "no other CPUs found"?

I'm not following this.

> +		struct flush_tlb_info local_info = *info;

What's wrong with reusing 'info'?

> +		local_info.trim_cpumask = 1;
> +		local_irq_restore(flags);
> +		native_flush_tlb_multi(cpus, &local_info);
> +		return;
> +	}

Gah, so is this hacking "trim_cpumask = 1" to force should_flush_tlb()
or something?

Right now, we have quite clean code around info->trim_cpumask. It's
either 0 or set from:

	info.trim_cpumask = should_trim_cpumask(mm);

It would be nice to keep it that way if possible.

Also, just looking at flush_tlb_mm_range(), there's a very familiar
check there:

        } else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
                remote_flush = true;

which feeds:

        if (remote_flush) {
                info.trim_cpumask = should_trim_cpumask(mm);
                flush_tlb_multi(mm_cpumask(mm), &info);
                consider_global_asid(mm);
        }

So what if we just added a check to should_trim_cpumask(), like:

	if (cpumask_weight(mm_cpumask(mm)) > atomic_read(&mm->mm_users))
		return true;

Or mm_users*2, or _some_ other heuristic that will trip when
mm_cpumask(mm) gets out of whack from ->mm_users.

That's a pretty cheap check because mm_cpumask() is already hot or is
just about to be read anyway. It might actually be useful to INVLPGB
systems too. That still needs the info->trim_cpumask check at the top of
hyperv_flush_tlb_multi(), btw.

Also, this is *kinda* changing the meaning of ->trim_cpumask. It's
really starting to mean "send IPIs". A rename might be appropriate.

/*
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 70098d448e999..e1e05cc867d5a 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -264,6 +264,12 @@ void flush_tlb_one_kernel(unsigned long addr);
>  void flush_tlb_multi(const struct cpumask *cpumask,
>  		      const struct flush_tlb_info *info);
>  
> +/*
> + * Do not use for filtering when freeing page tables or during global ASID
> + * transitions.
> + */
> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info);

Please look around this header that's being patched. Are the functions
above this commented? Please match the style.

Comment the definition itself, not the declaration.

>  static inline bool is_dyn_asid(u16 asid)
>  {
>  	return asid < TLB_NR_DYN_ASIDS;
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 0c4da320831cb..f2f40928d56a4 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1273,10 +1273,9 @@ static void flush_tlb_func(void *info)
>  			nr_invalidate);
>  }
>  
> -static bool should_flush_tlb(int cpu, void *data)
> +bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)
>  {
>  	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
> -	struct flush_tlb_info *info = data;
>  
>  	/*
>  	 * Order the 'loaded_mm' and 'is_lazy' against their
> @@ -1311,6 +1310,11 @@ static bool should_flush_tlb(int cpu, void *data)
>  	return false;
>  }
>  
> +static bool should_flush_tlb(int cpu, void *data)
> +{
> +	return cpu_needs_tlb_flush(cpu, data);
> +}
> +
>  static bool should_trim_cpumask(struct mm_struct *mm)
>  {
>  	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {

None of this movement is mentioned in the changelog. The naming change
here is also really silly. Now we have

	should_flush_tlb(int cpu, void *data)
and
	cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)

which are literally the same thing, except for the type. This is
precisely the kind of place we should keep the names _identical_. Either
use an __ or call the "void *" version "_wrapper" or something with a
comment:

/* Wrap foo() with a different type for use as an IPI callback: */

BTW, this "patch" probably needs to be broken up into a 4-5ish patch series.
