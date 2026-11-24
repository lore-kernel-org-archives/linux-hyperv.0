Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502698;
	b=HVPb0itXUpgjYRKL340RBUmb9ucsWnlBNiSpMybzGZfjMoe9CDng4e+YyqFE0xAkQMA3
	 bFb5Wu9ZH33RhUMOxE+TGWeyDh+OoqvigAQItQm6KT6n0HopG9DPirENn4lXpsTJtdcXW
	 0fUbAtN0+Bqg7sSllUpFiNld8ub4QFNE1/Aad3hrn8YgvFnO4aFzKPNcp7i4iJ/q8V228
	 0Z2RleSs7kotjY59CYGl81ihptikGD0IIT03kRyEFXmlUGuHkd9sTIkDGHyeZQRqvI3Sh
	 dK+ukv/pSjcKtZy2YUMUJpt1n7h9VPkmgbQlY+QJgOWm0LOIWN90SRW79OTt7rN5KGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502698;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=IEC4Taxw4IHKhev4uWNKVyqN5oOMiQIrKovTWL5MEPo=;
	b=y3KQB7TZBvuWJVCAH7uKfs+Mkms73m0S60YXr2ZolNsoZi64mSYn4rYa08f1Qez5Tmkp
	 CP2qOJ7shKWCC0TfCnww9sxr2+njdqkucPgTYA0Y4JcU1xvZJX7rOQVRmMGHHeUZasZ7d
	 4tSr6kJbAHB8yQ2jpNj7DFkBqo+MfQKtoy3XNqte5Glt7dP9pMAF3qze8ro//kfCFXfe9
	 4RXMLlN6bWKOkEJCZwupwp0Jks6x4KsKx6QhqMCP3lq9kc/SC1tsFYWC1lrRM331uV48Q
	 c3Kf3MBy23D1aMj7fktELAV1SYv4Ax5lvfEdXEg+CmGHuWY4kLcPwebdqt7ahurnKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=JaLOfizZ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52468606A321;
	Tue, 24 Nov 2026 06:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52468606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=JaLOfizZ
Received: from [10.95.64.197] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D87620B716C;
	Mon, 23 Nov 2026 22:44:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D87620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502693;
	bh=IEC4Taxw4IHKhev4uWNKVyqN5oOMiQIrKovTWL5MEPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaLOfizZpyC4OB8YCLWMovjc8HblFCLjikleXbZoYoPwSSuQWnbt2AGfzMsXm3ZN3
	 jU/fYreuLCeSXw1MPXlZYyjb1Mw39HcuVkB6PG+XpGvBRVFC1vtHA1jcls0FK5nykl
	 9zAl5BWPOv1JnJNaBlTvrqjPdRbPK1rMQOHoU4vk=
Message-ID: <d7c486ff-dbd6-4ec0-ad3e-673976b811e6@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:14:50 +0530
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
 <20261117091507.2088642-5-namjain@linux.microsoft.com>
 <MN2PR02MB6863EA8EE36408EA031F1CEDD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863EA8EE36408EA031F1CEDD4442@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2026 5:46 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, November 17, 2026 1:15 AM
>>
>> SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regressed
>> between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch caused
>> host-to-GPU copy stalls and timeouts. The reported bisection identified
>> commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").
>>
>> That change leaves a CPU's bit set after it switches to another mm.
> 
> To be more explicit,
> 
> "... leaves a CPU's bit set in the mm_cpumask even after the CPU switches
> to another mm".
> 

Acked.

>> Native flush callbacks remove these stale bits, but successful Hyper-V
> 
> Again, I'm wondering about the "successful" qualifier.
> 

Discussed in patch 3 comments. Please let me know if I can retain this.

>> hypercalls do not run those callbacks. A CPU actively running another
> 
> The word "actively" seems redundant/superfluous here.

Acked. I'll remove it.

> 
>> mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
>> exclude it. If the mask includes all present CPUs, the backend selects
> 
> Be more explicit than just "backend".

Acked.

> 
>> the all-processors shortcut before checking individual CPUs.
>>
>> Use the native predicate to build a per-CPU target mask before selecting
> 
> Be more explicit than "native predicate" (which sounds like AI-speak).
> Just say should_flush_tlb().

Acked.

> 
>> the all-processors shortcut or either hypercall format. Keep the full
>> candidate mask when freeing page tables. Retain the empty basic-mask
>> check because filtering can leave no targets.
>>
>> This patch does not change when trimming is requested.
> 
> I had a little trouble parsing this sentence. I first read it as
> "When trimming is requested, this patch does not change.",
> which didn't make any sense.  Maybe reword as "This patch
> does not affect when trimming is requested."

Agreed.

> 
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/mmu.c | 40 ++++++++++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 14 deletions(-)
>>


<snip>

>> -
>>   static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>   				   const struct flush_tlb_info *info)
>>   {
>>   	int cpu, vcpu, gva_n, max_gvas;
>>   	struct hv_tlb_flush *flush;
>> +	struct cpumask *flush_cpus;
>>   	u64 status;
>>   	unsigned long flags;
>> -	bool do_lazy = !info->freed_tables;
>>
>>   	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>>
>> @@ -87,6 +85,23 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>>   		goto do_native;
>>   	}
>>
>> +	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
>> +	/*
>> +	 * mm_cpumask() may retain CPUs that have switched to another mm.
>> +	 * Use the native predicate for its context-switch ordering and lazy
> 
> Again, say should_flush_tlb() instead of "native predicate". And I don't
> really know what "context-switch ordering" is trying to get at.

Please allow me to rewrite this whole comment as follows:

mm_cpumask() may include CPUs that have switched to another mm.
Use should_flush_tlb() to check which CPUs need this flush.
When freeing page tables, keep the full mask because CPUs in
lazy TLB mode must also be flushed.


> 
>> +	 * TLB exclusion. Page-table freeing must include lazy CPUs, so keep
>> +	 * the full candidate mask in that case.
>> +	 */
>> +	if (info->freed_tables) {
>> +		cpumask_copy(flush_cpus, cpus);
>> +	} else {
>> +		cpumask_clear(flush_cpus);
>> +		for_each_cpu(cpu, cpus) {
>> +			if (should_flush_tlb(cpu, info))
>> +				__cpumask_set_cpu(cpu, flush_cpus);
>> +		}
>> +	}
>> +

Regards,
Naman

