Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A82DEA75;
	Tue,  8 Sep 2026 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846223; cv=none; b=XOxqbnI3Hci59wgzdPtkGdpY02wpxStqZKm5Cu6EWCNyaDkaUE4sO+EBOzQqrODAkjOJbPY1l3ymBu2xwI9FW3jDhKRGfFdWtpTtHd6owdTZTR8BpC+5MeAfLTi3oDf1cekAsok/oD/adcjShPIx8Ptd5zBaQ7E8uv6Upet+cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846223; c=relaxed/simple;
	bh=vZwNnu50WBOnHHp5Q5GpjEovzlIYyzNaB1+5egmTV/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpNJ4zn9Hv7hlmunjwbSleEClTMJvAETKL19FKYrYlYA9kZMedEiJ/Wa/QXntAjHqZXSkH8zo+9qLTtn1a7g0PKA8WIn7nWKk5iFWO5mXUDQjMVvxJ3oOTDPuO7gw/oQqvzBUkDRgloVLrGe+VVUqh5g7xeL6kZz5+NQ03h10Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mqPoxYwn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mqPoxYwn"
Received: from [10.95.64.224] (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9736D20B7128;
	Mon,  7 Sep 2026 22:42:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9736D20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788846182;
	bh=mOfnYWdYwTedISZYAV/f2LHtRKHnTLG773loI06PJpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mqPoxYwn05066xYQjpg95Vy2X2PlIQJsfWmrNsnQwEPmDfQaRzbkSOFrOD9qz7qo+
	 UTlKj79thhN9ARBkIfe1M2y07Rv3kvgIMTQ7gXsjxEI2S2e2PlLgNKYbF5TZt9HEi5
	 zrzUnPhK/kdaMLkipbRlxbQKtzvGe/TLjurjnbnU=
Message-ID: <e4f179cd-41c2-40e6-9054-c2023c29970c@linux.microsoft.com>
Date: Tue, 8 Sep 2026 11:13:30 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
To: Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Wei Liu <wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>, Nam Cao <namcao@linutronix.de>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Kees Cook <kees@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Radu Rendec <radu@rendec.net>,
 Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>,
 Dmitry Ilvokhin <d@ilvokhin.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thierry Reding <treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>,
 Daniel J Blueman <daniel@quora.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-4-namjain@linux.microsoft.com>
 <SN6PR02MB415704CEBA0F9107C37A009CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415704CEBA0F9107C37A009CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 1:24 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 11:51 PM
>>
>> With fixup_irqs() and the generic resend path (try_retrigger()) now both
>> falling back to irq_chip_retrigger_hierarchy(), installing it as the
>> irq_retrigger() callback on the outermost domain chips is no longer
>> required. The hierarchy walk reaches the x86 vector domain's
>> apic_retrigger_irq() for all of these stacked domain chips.
>>
>> Remove the now redundant irq_retrigger() initializations from the outermost
>> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
>> msi_set_affinity() is the only site that invoked the outermost chip's
>> irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
>> the x86_init_dev_msi_info() initialization can be dropped as well.
>>
>> No functional change intended.
>>
>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/irqdomain.c         | 1 -
>>   arch/x86/kernel/apic/io_apic.c      | 2 --
>>   arch/x86/kernel/apic/msi.c          | 4 +---
>>   arch/x86/kernel/hpet.c              | 1 -
>>   drivers/iommu/amd/init.c            | 1 -
>>   drivers/pci/controller/pci-hyperv.c | 1 -
>>   6 files changed, 1 insertion(+), 9 deletions(-)
>>
> 
> [snip]
> 
>> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
>> index 66bc5d3e79db3..aad2f15eb2176 100644
>> --- a/arch/x86/kernel/apic/msi.c
>> +++ b/arch/x86/kernel/apic/msi.c
>> @@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
>>   	 * IRR.
>>   	 */
>>   	if (lapic_vector_set_in_irr(cfg->vector))
>> -		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
>> +		irq_chip_retrigger_hierarchy(irqd);
> 
> In v2 of this patch series, I commented about whether this code
> should also check for irq_retrigger() being set in the outermost
> domain before calling irq_chip_retrigger_hierarchy(). fixup_irqs()
> in Patch 2 of this series has that check, and I think it should be
> here as well. While there are no domains in the x86 world today
> that have a custom irq_retrigger function, I'll argue the check
> should be done so the infrastructure is correct if such a domain
> were added in the future.
> 
> Michael
> 

The reason I skipped changing this is because I realized that unlike
fixup_irqs(), this path is not generic, i.e. the chip you get here is
the same one as the one initialized in x86_init_dev_msi_info() below. So
someone adding a custom irq_retrigger function could simply change it in
above call site.
However, on looking at this again, I see if someone adds this custom
function again, it would be taken care of in fixup_irqs() but
msi_set_affinity() could silently be missed. I'll add the fallback soon
in next version.

Regards,
Naman

>>
>>   	return ret;
>>   }
>> @@ -246,7 +246,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>>   	info->ops->msi_prepare		= x86_msi_prepare;
>>
>>   	info->chip->irq_ack		= irq_chip_ack_parent;
>> -	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
>>   	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
>>   					   IRQCHIP_AFFINITY_PRE_STARTUP;
>>
>> @@ -313,7 +312,6 @@ static struct irq_chip dmar_msi_controller = {
>>   	.irq_mask		= dmar_msi_mask,
>>   	.irq_ack		= irq_chip_ack_parent,
>>   	.irq_set_affinity	= msi_domain_set_affinity,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   	.irq_compose_msi_msg	= dmar_msi_compose_msg,
>>   	.irq_write_msi_msg	= dmar_msi_write_msg,
>>   	.flags			= IRQCHIP_SKIP_SET_WAKE |  IRQCHIP_MOVE_DEFERRED |
>> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
>> index 8dc7b710e1250..2bb7a6f466af3 100644
>> --- a/arch/x86/kernel/hpet.c
>> +++ b/arch/x86/kernel/hpet.c
>> @@ -509,7 +509,6 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
>>   	.irq_mask = hpet_msi_mask,
>>   	.irq_ack = irq_chip_ack_parent,
>>   	.irq_set_affinity = msi_domain_set_affinity,
>> -	.irq_retrigger = irq_chip_retrigger_hierarchy,
>>   	.irq_write_msi_msg = hpet_msi_write_msg,
>>   	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
>>   };
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 40726dfef2733..a19e1faf98750 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -2471,7 +2471,6 @@ static struct irq_chip intcapxt_controller = {
>>   	.irq_unmask		= intcapxt_unmask_irq,
>>   	.irq_mask		= intcapxt_mask_irq,
>>   	.irq_ack		= irq_chip_ack_parent,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   	.irq_set_affinity       = intcapxt_set_affinity,
>>   	.irq_set_wake		= intcapxt_set_wake,
>>   	.flags			= IRQCHIP_MASK_ON_SUSPEND |
>> IRQCHIP_MOVE_DEFERRED,
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 89816a2bd7cd3..cfc8fa403dad6 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev,
>> struct irq_domain *dom
>>   	info->ops->msi_prepare = hv_msi_prepare;
>>
>>   	chip->irq_set_affinity = irq_chip_set_affinity_parent;
>> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>>
>>   	if (IS_ENABLED(CONFIG_X86))
>>   		chip->flags |= IRQCHIP_MOVE_DEFERRED;
>> --
>> 2.43.0
>>
> 

