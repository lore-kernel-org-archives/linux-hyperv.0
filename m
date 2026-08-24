Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5213B38BD;
	Mon, 24 Aug 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550083; cv=none; b=tawoX7ojVshY7lSMjBSUHOlWQGS++rW2j2Z+WlIS1uWERUemwODT+OfhgiyZPVV0e2SWVtDUmKauLaLDBYEVMp52gMPiqD4ZvpR4fmI8r7Xp5ZT4fa/78TZ1mLFlAUys0EOXwlKN7WDzj0ilEoEzVh7I/XoA3pnxGyrvsqsCQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550083; c=relaxed/simple;
	bh=1goF1hUY2+jfQCM4cCVj2oUgayb2ZOdlIla9d+oA378=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaxsbasWaKLHHpF4luuz1AWWU3zXgvrC0jVcf7YS7pveCPhpdAzQm1CTiELNZq+5eDncLwDILUT3TDDRYAabAGrgOqINQvrHITBHFidhdKxwT08GMRuIzU/6cDEfGxBevk0cPYGLB1HJohvHmqYNnypS4e+cOhQ2MVS5jVQgzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S9ywES8d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S9ywES8d"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC0DF20B7166;
	Sun, 23 Aug 2026 22:40:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC0DF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787550050;
	bh=x7+UMA3lTYEM484uVy7XpCvdDVN+yr3RjRbu9iaBiwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S9ywES8dBBql8h3aG6zB/XC6auDGe6gL+1/f2OQuHWelmaollawN5Xekaiyq8fIfo
	 jxs/lPYEafKGKNlljWwi8N6vw3oTwG1J/+9kx/GfHG0voIQ85Q7mA5w2BMICTYK4zr
	 /k2nkgeUoL2SWejDvb5YLz9I8W/AKUZiPVf+BjRo=
Message-ID: <23b75192-35eb-4e01-9c90-e41ab3510f93@linux.microsoft.com>
Date: Mon, 24 Aug 2026 11:11:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 Jake Oshins <jakeo@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-3-namjain@linux.microsoft.com>
 <20260824001508.GD3566091@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260824001508.GD3566091@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/2026 5:45 AM, Wei Liu wrote:
> On Tue, Jul 28, 2026 at 01:51:16PM +0000, Naman Jain wrote:
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
>>
>> No functional change intended for chips which already provide an
>> irq_retrigger() callback on the outermost domain.
>>
>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> 
> I can pick this up as part of this series but this requires an ack from
> Thomas.
> 
> Wei

Hi Wei,
Patch 1 that you picked is same in v1, v2, so that is fine.
But there's v2 for this series, where the rest of the patches are being 
discussed.

https://lore.kernel.org/all/fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com/

Regards,
Naman

> 
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
>>

