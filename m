Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B740DFDE;
	Thu, 30 Jul 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410793; cv=none; b=JfuAVwcECly9ljD/iq6znYd+R1H+fagdiRXuoh+/IzuaYXCXtE/xpKRzvNjtJiDtTAlPVa4lXlMmNbZyAzjkSSB2nQTT1kZNkMFSRmwKkF6XzY77Wp6UIehae7r2aeAnABomn7cHpm73KmlsDQ5eR1DfvzqgSsISR9V742vXNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410793; c=relaxed/simple;
	bh=YBS5CAPrY6XCRXGO24rFetMnYeFYoU1tOAvyI4TL2CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwDNVd4JLVpOcO1elvTGpjj+97jte/buPXfdT3lrE9kPK/oDYYf0KZheheRVbtPqnWDe973TuWpnW4cDfQn1BHJofqrbn9hYiY+gvtIab8A3RE58XFAhPaR4+cTUgnz3rd6wy5d1kqCRRoIQ2ucDHiDJxLHD3Mpt0lOYaGyTO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDxCbLF3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDxCbLF3"
Received: from [192.168.0.105] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD33220B7166;
	Thu, 30 Jul 2026 04:26:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD33220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785410774;
	bh=nEtBSGQcZxkgP2yOsZrtiYPwJcVN3ZOuyTNRUYzYGkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iDxCbLF3u9BwvqAxSZ0/CBKQOyLeiA99SkiHnfqSfc/hL/kRp3yE+gLcbBrTLuKna
	 2zj23nDi2EsUrw/1MPi1sa+SktvJsaCopuNeMAENLOzkSdR9BH+CJQTzFd2W5n+vN2
	 dhRHdS7ZnSo+OzzcRO384FGNWKqpFdfelnvICAn4=
Message-ID: <2e798fad-fa8a-46b4-b874-7a178fd123dd@linux.microsoft.com>
Date: Thu, 30 Jul 2026 16:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-3-namjain@linux.microsoft.com>
 <20260728140324.690D11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260728140324.690D11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/2026 7:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch replaces the direct invocation of the outermost chip's irq_retrigger() callback with irq_chip_retrigger_hierarchy(). However, irq_chip_retrigger_hierarchy() initializes its loop with `data = data->parent_data`, completely skipping the outermost chip. This breaks interrupt retriggering for flat domains (like native lapic_controller) and any hierarchical domain where the outermost chip directly implements the retrigger callback.
> --
> 
> --- Patch [2]: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs() ---
> commit f97e883de2f6626561de48c426194caa41c3e062
> Author: Naman Jain <namjain@linux.microsoft.com>
> x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
> 
> This commit modifies fixup_irqs() to use irq_chip_retrigger_hierarchy()
> instead of invoking the outermost domain chip's irq_retrigger() callback
> directly. It also refactors the loop to use scoped guards for the irq
> descriptor lock.
> 
>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>> index 30122f0b3af96..ef1bdd3c4659a 100644
>> --- a/arch/x86/kernel/irq.c
>> +++ b/arch/x86/kernel/irq.c
> [ ... ]
>> @@ -489,22 +484,18 @@ void fixup_irqs(void)
> [ ... ]
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
> [Severity: High]
> Will this skip the outermost chip and cause a regression for flat domains?
> 
> Looking at kernel/irq/chip.c:irq_chip_retrigger_hierarchy(), the loop
> initializes by immediately moving to the parent_data:
> 
>      int irq_chip_retrigger_hierarchy(struct irq_data *data)
>      {
>          for (data = data->parent_data; data; data = data->parent_data)
>              if (data->chip && data->chip->irq_retrigger)
>                  return data->chip->irq_retrigger(data);
> 
>          return 0;
>      }
> 
> By passing &desc->irq_data directly to this function, it seems any retrigger
> callback on the outermost chip itself will be bypassed.
> 
> Could this lead to dropped hardware interrupts during CPU hot-unplug for
> flat domains (like native lapic_controller) or any hierarchical domain where
> the outermost chip implements the retrigger callback?
> 
>>   				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
>> -			}
>> -			raw_spin_unlock(&desc->lock);
>>   		}
> 

I think this is a false positive, considering we are not changing the 
behavior for any of the existing chip->irq_retrigger(data) which come in 
this path (irq_chip_retrigger_hierarchy()).

Regards,
Naman

