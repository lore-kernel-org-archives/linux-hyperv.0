Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA582E92BA;
	Thu, 20 Aug 2026 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201269; cv=none; b=MpcoAyOLR8OiM6K2Wv4qVQmJrJWzB297dOSTKtj4Aj5XWSPLDQjQ+MB52qwP0bHICzZnp11GsS/PoeFVTn9Qvd7+xvrMgYfu/WOWBmB46UjtAUdDqFpQAqRiptmtv7xb+4wplwNncfp/VXdialWKsJUtiX6sk41UGULreYRXoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201269; c=relaxed/simple;
	bh=vl0zaEmKib6Lbz3VHNSh2Uy7gdNEzyfoZ5bpxkE+TSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1iILp6uMhbwtZRYYoAopa2Bj044kG9EHNtmLJ2OQ7ay8OABqPEbJVKjcW0lgciWsI84Azvo5WY7XtNn2KoY/+HtchQjNJHpfteFCJYUTzfv7OSATexbRBnGqUZwqP19TrvbhxEzDGCNDoj7JpteAjn0OoZPwJuJjuX5wjBB6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TMWiRyfn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TMWiRyfn"
Received: from [10.95.65.118] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0117920B710C;
	Wed, 19 Aug 2026 21:47:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0117920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787201239;
	bh=v2/+CNUjToYHkwV06DuRLGXLncXWjf3PDjIzpLbwhZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMWiRyfnoh+/P+YB/o+lnKy1BbpV0VDW3WbhMemPgLG8PakKysok3jJAmmozCevqz
	 ZnSgN7jTfHYkxPCJHw4k18lfCde/0v6ZkHYX7ed3igoPK3gkij0Zf1nXaQXIkserpd
	 DyWFsaBCZvP5wdTxoF+nsitmMRBteD3ibSTezRt0=
Message-ID: <fc7c4d74-d861-4268-8044-fa83748572f4@linux.microsoft.com>
Date: Thu, 20 Aug 2026 10:17:37 +0530
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
 <72ccf7d4-0fda-4f55-a47c-27486ef3e159@linux.microsoft.com>
 <SN6PR02MB41574989AE7DB1332F06C66DD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574989AE7DB1332F06C66DD4A52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/19/2026 9:29 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, August 18, 2026 12:31 AM
>>
>> On 8/18/2026 10:40 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, August 10, 2026 2:07 AM
> 
> [snip]
> 
>>>
>>> Sashiko pointed out that irq_chip_retrigger_hierarchy() doesn't check
>>> the outermost domain -- it immediately goes the parent. In v1 of this patch
>>> series, you categorized this as a false positive. But I don't understand
>>> your explanation. Even if there aren't currently any outermost domains
>>> with a custom retrigger function, there could be at some point in the
>>> future. So it seems wrong to skip it. But maybe I'm missing something.
>>> Could you elaborate on your reasoning?
>>>
>>> Michael
>>>
>>
>> irq_chip_retrigger_hierarchy() deliberately skips the chip passed to it
>> and begins with its parent, i.e. apic_retrigger_irq(). The new code was
>> doing the same. However, if someone adds a custom .irq_retrigger, hoping
>> that it would get executed, it would not.
>>
>> Sashiko's example was valid in principle, but it is not relevant to
>> these device interrupts because desc->irq_data is the outer
>> MSI/IOAPIC/Hyper-V chip. The LAPIC data is its parent, not the starting
>> data. I found no device IRQ in this path whose descriptor starts
>> directly at lapic_controller.
>>
>> I am all in for adding this as a fallback -
>> +    if (chip->irq_retrigger)
>> +        ret = chip->irq_retrigger(data);
>> +    else
>> +        ret = irq_chip_retrigger_hierarchy(data);
>>
>> This should solve this problem while still covering the chips which can
>> forget to add a retrigger function.
>>
>> Please let me know if this looks good to you.
> 
> In principle, I think what you have is correct.  But there's a
> problem in that irq_chip_retrigger_hierarchy() isn't defined
> unless CONFIG_IRQ_DOMAIN_HIERARCHY=y.  try_retrigger()
> is what you want, but it's static. You could add the #ifdef's here
> like in try_retrigger(), but the same problem will occur in Patch 3
> with msi_set_affinity(). Really need a non-static version of
> try_retrigger(). Or maybe just doing the #ifdef's here and in
> msi_set_affinity() is the simplest approach. I don't have a
> strong opinion either way.  Sorry this is getting so messy ....
> 
> Michael

Hi Michael,
Config dependencies make sure that CONFIG_IRQ_DOMAIN_HIERARCHY is 
defined wherever irq_chip_retrigger_hierarchy() is getting called.

x86 SMP or x86-64 guarantees X86_LOCAL_APIC → IRQ_DOMAIN_HIERARCHY, 
PCI_MSI guarantees it via GENERIC_MSI_IRQ. So the #ifdef may not be 
required.

Hi Thomas,
Can you please comment if you are OK with me adding this fallback 
mechanism in next version.

Regards,
Naman
