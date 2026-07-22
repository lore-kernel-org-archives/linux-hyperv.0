Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DA368D7B;
	Wed, 22 Jul 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733310; cv=none; b=sh+/TjkGhmfgbd/XAQ9M+Bjp1jLcbiijANBjV+nCTcx3R9vpMs4kkuab1EIXziWVpfeqbLn1Ii70UTTJTYTMZ8eAAESADXRYRD1E1N3diu015EsepA7Ibu5+Mfe8aB53LAdsypolMn+MAqE4WIXSvIIxJfpBXCxIzjk/pPJn9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733310; c=relaxed/simple;
	bh=ArwJ2JcsO/Ndc1AiYdKrsLdwykRV3zW5+OVNLVF/RY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUhiZFgBz83SW8d1+jneJ4DX7rFusd5k71lGX/8x7uca7iCtn1CRm5Q0A5qY6DhcqgUowWAJFgcOFeec2zVoFyntFQBcWf1wTflEGS2c5xHA2apg5cQCxHZtdblcD1mGJkHYBHENwe6D4a3ITAVpyTzyfuk1Q52kmN4xWEsgY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J3eKdCx+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J3eKdCx+"
Received: from [192.168.0.105] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B02220B7167;
	Wed, 22 Jul 2026 08:14:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B02220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784733290;
	bh=WhxLn0OIyun6pU+cHXMszhNcMqQyhZmqdwxsVkPBAR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J3eKdCx+BRaCwe81EJGv8OfEh9tCv6BYQn6Ntm6GjDhwJenAKrgcsqRkIuntODpGE
	 tmTfgYjZG9VKY92YqVMv14njxigITas5/TNs8VU1LPTzyFRGVatWwAfV9jaGi+nCm4
	 N5Udh1oO0AqoxJyG6tJp2Q47Qq80dghWJOuWFqz0=
Message-ID: <9739e095-9696-412b-adaa-2c37ef630bdf@linux.microsoft.com>
Date: Wed, 22 Jul 2026 20:44:57 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector migration
 on Hyper-V
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
References: <20260710054007.288807-1-namjain@linux.microsoft.com>
 <874ihskq1h.ffs@fw13>
 <12557e3a-5feb-4601-ad53-cf4846052edd@linux.microsoft.com>
 <87y0f3jhd6.ffs@fw13>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <87y0f3jhd6.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/2026 6:45 PM, Thomas Gleixner wrote:
> Naman!
> 
> On Wed, Jul 22 2026 at 14:59, Naman Jain wrote:
>> I completely agree with your comments, and now that I know how to fix
>> this, do you suggest me to -
>>
>> 1. add irq_retrigger callback in pci-hyperv.c
>> or
>> 2. go with your fixup-irq() change to no longer need drivers to add the
>> above? And then see what all stale irq_retrigger inits can be removed
>>
>> Going with 1) would be easier for me to fix this bug, and back port it
>> to older kernels, with proper Fixes tag (pointing to some pci-hyperv.c
>> change).
>> Then later, we can go with 2) separately as a general enhancement (not a
>> Fix).
> 
> This should be one patch series:
> 
>    1) Add the callback to pci-hyperv, i.e. in hv_pcie_init_dev_msi_info()
> 
>       +    chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> 
>       That sets it on the outermost domain interrupt chip (PCI/MSI
>       device domain), which is what fixup_irqs() looks at.
> 
>       This one needs a Fixes: tag (The first commit which introduced the
>       driver) and a Cc: stable@... so it will be backported.
> 
>    2) Change fixup_irqs() to use irq_chip_retrigger_hierarchy()
> 
>       Feel free to pick up the patch I gave you, add a proper change log
>       and a Suggested-by: Thomas .... tag.
> 
>    3) Remove the initialization of the outermost chip from arch/x86/* and
>       drivers/iommu/amd/* as that's not longer required then.
> 
> Thanks,
> 
>          tglx
> 

Understood. Thanks.

Regards,
Naman

