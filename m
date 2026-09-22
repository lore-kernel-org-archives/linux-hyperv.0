Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87291D9A66;
	Tue, 22 Sep 2026 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048805; cv=none; b=EZbb3IKT4ze/nkyFnujQXv5seCEafXq9Kk0UfQo8/I6e6ydRIXGrn+hByVr6zNbTSvFP4bFo1Xp6XI1CloAl414i3ZW9SntHr11C8xdtcq1dIpRXqdzAMMNumvKJ5bkFS74VofLnm+qk/cubFvE5XECEtKR0Mz18io+ZcsqDeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048805; c=relaxed/simple;
	bh=qBL4hOnkWrnl9KngneqkBU17EWse148K0i1gIAwANFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvbA9vZ1+5ML2oHXTyd2OWX1Ub3LnB6xFyiYmQSr2OgziHxTyS/4MS0HnAjfD4HOQhAhJauFKCLInKjA+QtewCyww9UFBVXzrtsIJUSwt9h2/wWytQg6hfoD4+zpq5ZXjrsPaC7H/2SJiBD2ToSlav0/jTLgMQNWUTHK/erP3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ab/1Xmm0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ab/1Xmm0"
Received: from [192.168.1.70] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E69C20B7168;
	Mon, 21 Sep 2026 20:45:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E69C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790048753;
	bh=ei/RamUX7t5csrMcNl7UepCODFZshy2mQl2ZoF4lX7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ab/1Xmm0uV0FQNIoD4At64yMz5qVSjA0VS2PKZb1ZSmck3ppzdkl9Bv6BBZ0rj2zd
	 YAuUPtVaTyFqhdWBAEPgYz3vNkKJW3wvFcVk8TD0lqjYqf+/3Ds3z8lf0qSxaP+zkZ
	 X1iQY1u84bjMKefXVun+WKpr2M7mftn5Q5HGlej0=
Message-ID: <aaecad83-cb46-44cc-91c4-1675350749f4@linux.microsoft.com>
Date: Tue, 22 Sep 2026 09:16:28 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
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
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-5-namjain@linux.microsoft.com>
 <SN6PR02MB4157B6AAECA10E13072B727BD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157B6AAECA10E13072B727BD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2026 2:31 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, September 14, 2026 4:19 AM
>>
>> With fixup_irqs(), msi_set_affinity() and the generic resend path
>> (try_retrigger()) now all falling back to irq_chip_retrigger_hierarchy(),
> 
> The "falling back" terminology is not accurate in this version of the
> patch set.  Perhaps "all now calling irq_chip_retrigger_hierarchy() directly"?
> 

Thanks for catching this Michael, it was a miss on my part.

Regards,
Naman

>> installing it as the irq_retrigger() callback on the outermost domain chips
>> is no longer required. The hierarchy walk reaches the x86 vector domain's
>> apic_retrigger_irq() for all of these stacked domain chips.
>>
>> Remove the now redundant irq_retrigger() initializations from the outermost
>> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
>>
>> No functional change intended.
>>
>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/irqdomain.c         | 1 -
>>   arch/x86/kernel/apic/io_apic.c      | 2 --
>>   arch/x86/kernel/apic/msi.c          | 2 --
>>   arch/x86/kernel/hpet.c              | 1 -
>>   drivers/iommu/amd/init.c            | 1 -
>>   drivers/pci/controller/pci-hyperv.c | 1 -
>>   6 files changed, 8 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index 6d790636c8b95..b3ad50a874dca 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -316,7 +316,6 @@ static bool hv_init_dev_msi_info(struct device *dev, struct
>> irq_domain *domain,
>>   		return false;
>>
>>   	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
>> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>>
>>   	info->ops->msi_prepare = pci_msi_prepare;
>>
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 7d7175d012288..18f49a251f23b 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -1857,7 +1857,6 @@ static struct irq_chip ioapic_chip __read_mostly = {
>>   	.irq_ack		= irq_chip_ack_parent,
>>   	.irq_eoi		= ioapic_ack_level,
>>   	.irq_set_affinity	= ioapic_set_affinity,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
>>   	.flags			= IRQCHIP_SKIP_SET_WAKE |
>> IRQCHIP_MOVE_DEFERRED |
>>   				  IRQCHIP_AFFINITY_PRE_STARTUP,
>> @@ -1871,7 +1870,6 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
>>   	.irq_ack		= irq_chip_ack_parent,
>>   	.irq_eoi		= ioapic_ir_ack_level,
>>   	.irq_set_affinity	= ioapic_set_affinity,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
>>   	.flags			= IRQCHIP_SKIP_SET_WAKE |
>>   				  IRQCHIP_AFFINITY_PRE_STARTUP,
>> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
>> index 9160227b9b32a..aad2f15eb2176 100644
>> --- a/arch/x86/kernel/apic/msi.c
>> +++ b/arch/x86/kernel/apic/msi.c
>> @@ -246,7 +246,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct
>> irq_domain *domain,
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
>>   	.flags			= IRQCHIP_SKIP_SET_WAKE |
>> IRQCHIP_MOVE_DEFERRED |
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
>> index edcc187b8f14f..bc3da5b0578eb 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -2477,7 +2477,6 @@ static struct irq_chip intcapxt_controller = {
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

