Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A03612F8;
	Tue, 18 Aug 2026 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038304; cv=none; b=EU/UAzsDtSM7MSXRa2cg4iBEAdjZDCOXOb6ZZ5chCvudEGtXo+dbSwrXcIdi02OLXKfOmsKySs+JoA6NVe9QcQqtnoa3kQfjdvKRVh9B2Ae1p9f4yhoy4ufZsDGqGs0DCY4ML0HKAVaIjED2TkmwfGM++h9O3AbaZ0eNltUcBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038304; c=relaxed/simple;
	bh=qQc7NpVgjlwCgtPxFyKMVtz15dITF6AD/7Wy6HDmHxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kD5PEf0TugFqoFR3N1iaNRgZD+Brx9BDxJEkBjBc3fyt/fHy4RvVVFBwOOmHE5WN6wpsunp069W3x3MAxxwLNeB01YcqUkVc3OH+R6sI5RMGu2x8shfpEnlwyJ7I0rCWy9OeLbFIG/wHdD23XRSKpvlK+9wFlDCZtdjD/sVLwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q2nGwtoA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q2nGwtoA"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id D85D320B7167;
	Tue, 18 Aug 2026 00:30:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D85D320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787038264;
	bh=33oeJJ2KUl0c85m92fbwyfbJQ2UNWDvCfDyVxz5S2j4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q2nGwtoAukCeLTzPxYYr6c23vKRkqtZ52Zjv8TzRZkwl0RZcW+uz/1MQsshivtqzA
	 G4TbUr4MlTAM6k/PMNhqsT6NomohtocqNCFggsiDNe7vpsm0fsRI5FiVgclObAIXY0
	 jjRQQ3oplBqjyFIBME3El7DBVd5mSjwTMtO7zpaw=
Message-ID: <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
Date: Tue, 18 Aug 2026 13:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
To: Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570E8FC664CAC4A05CAFA9D4A62@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/2026 10:40 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, August 10, 2026 2:07 AM
>>
>> fixup_irqs() re-injects a pending interrupt on its new target CPU by
>> looking at the outermost domain chip and invoking its irq_retrigger()
>> callback directly. That only works when the outermost chip happens to
>> install an irq_retrigger() callback, which is not guaranteed for every
>> irqchip and could lead to lost interrupts on CPU hot-unplug.
>>
>> Use irq_chip_retrigger_hierarchy() instead, which walks up the interrupt
>> hierarchy until it finds a chip that implements irq_retrigger().
>>
>> While at it, move the loop-local variables into the loop scope and use a
>> scoped guard for desc->lock.
> 
> Moving the loop-local variables into the loop scope seems to be churn
> with no real benefit. I know Thomas' suggested code made that change
> and he's the maintainer, so it's his call. But still . . .
> 
> Changing to use the scoped guard seems OK since that's a new pattern
> we want to be using.
> 

I can avoid moving this to loop-local variable in next version, if we 
are moving ahead with changing the logic for below comments.

>>
>> VECTOR_RETRIGGERED is now set only when the retrigger succeeds
>> (irq_chip_retrigger_hierarchy() returns non-zero) instead of
>> unconditionally. This is harmless today since apic_retrigger_irq()
>> always returns 1, and arguably more correct. No functional change
>> intended for chips which already provide an irq_retrigger() callback
>> on the outermost domain.
>>
>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/kernel/irq.c | 23 +++++++----------------
>>   1 file changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>> index 30122f0b3af96..ef1bdd3c4659a 100644
>> --- a/arch/x86/kernel/irq.c
>> +++ b/arch/x86/kernel/irq.c
>> @@ -466,11 +466,6 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
>>   /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
>>   void fixup_irqs(void)
>>   {
>> -	unsigned int vector;
>> -	struct irq_desc *desc;
>> -	struct irq_data *data;
>> -	struct irq_chip *chip;
>> -
>>   	irq_migrate_all_off_this_cpu();
>>
>>   	/*
>> @@ -489,22 +484,18 @@ void fixup_irqs(void)
>>   	 * vector_lock because the cpu is already marked !online, so
>>   	 * nothing else will touch it.
>>   	 */
>> -	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
>> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
>> +	for (unsigned int vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
>> +		struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
>> +
>> +		if (IS_ERR_OR_NULL(desc))
>>   			continue;
>>
>>   		if (is_vector_pending(vector)) {
>> -			desc = __this_cpu_read(vector_irq[vector]);
>> -
>> -			raw_spin_lock(&desc->lock);
>> -			data = irq_desc_get_irq_data(desc);
>> -			chip = irq_data_get_irq_chip(data);
>> -			if (chip->irq_retrigger) {
>> -				chip->irq_retrigger(data);
>> +			guard(raw_spinlock)(&desc->lock);
>> +			if (irq_chip_retrigger_hierarchy(&desc->irq_data))
> 
> The existing code uses irq_desc_get_irq_data() instead of directly
> accessing the irq_data field.  I *think* using the function is preferred,
> but maybe I'm out-of-date.

I can switch to irq_desc_get_irq_data().

static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
{
         return &desc->irq_data;
}

> 
> Sashiko pointed out that irq_chip_retrigger_hierarchy() doesn't check
> the outermost domain -- it immediately goes the parent. In v1 of this patch
> series, you categorized this as a false positive. But I don’t understand
> your explanation. Even if there aren't currently any outermost domains
> with a custom retrigger function, there could be at some point in the
> future. So it seems wrong to skip it. But maybe I'm missing something.
> Could you elaborate on your reasoning?
> 
> Michael
> 

irq_chip_retrigger_hierarchy() deliberately skips the chip passed to it 
and begins with its parent, i.e. apic_retrigger_irq(). The new code was 
doing the same. However, if someone adds a custom .irq_retrigger, hoping 
that it would get executed, it would not.

Sashiko's example was valid in principle, but it is not relevant to 
these device interrupts because desc->irq_data is the outer 
MSI/IOAPIC/Hyper-V chip. The LAPIC data is its parent, not the starting 
data. I found no device IRQ in this path whose descriptor starts 
directly at lapic_controller.

I am all in for adding this as a fallback -
+    if (chip->irq_retrigger)
+        ret = chip->irq_retrigger(data);
+    else
+        ret = irq_chip_retrigger_hierarchy(data);

This should solve this problem while still covering the chips which can 
forget to add a retrigger function.

Please let me know if this looks good to you.

>>   				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
>> -			}
>> -			raw_spin_unlock(&desc->lock);
>>   		}
>> +
>>   		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
>>   			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>>   	}
>> --
>> 2.43.0
>>
> 

Regards,
Naman

