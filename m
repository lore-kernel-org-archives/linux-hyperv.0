Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F8357D11;
	Tue,  8 Sep 2026 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846203; cv=none; b=EAWEVegC5cvkj+tsHfEDhlvTqlkQF/1SxboebBo2tQpK1dRt5ZL6HfH7ZwYcY68aKEzFDi4WbYafumRdX4ZVJJNXJnCDQhsUIj72Lhlr51a9fL8vGFzOEa5Wa4xFto8d3Z+FyfmIbpxQUpabx2AHf71Uxrw+b/WkFn8co8jO7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846203; c=relaxed/simple;
	bh=tRcVazBVH6cpfRqA+ksjMJOYtIoLXNNdNcrI12au7Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kku6nSPcto74qXIkEDUpcAHgDwbGNKhg/FxNbU419z2U41tZWjaWALMQVZvN1PYinvRCntoY+/C/FwNe7nQxtHpmhOQrVU+q6fBRt/8PaxgySOb+k92jXlY552HNmPBIer1p84Cs1+JXrohHnr9tNxHnLMgazodcMoqDwsVtkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QqzEJV9W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QqzEJV9W"
Received: from [10.95.64.224] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 827C320B710C;
	Mon,  7 Sep 2026 22:42:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 827C320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788846161;
	bh=jFpKqLnYESRtZkyjcO9naVHbKzpUYdkyU/qeRVdO2n4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QqzEJV9Wa/zWVEF30GtCjI70bzoOx/oIz3Ow+94Tc1osgz3JgXUiLBSS0yKv3BNiP
	 xwnmyFs6EBB4VqxjkJ5TRnMPqdeo7FjGrzhVyL39Aq0jHvLaO/yMrLuFYB/DW22XSv
	 d8yg0bMJHEBSxObxxqTarNtbWPoS4sAp/FM07LuQ=
Message-ID: <404f5574-1f46-48bd-b5d4-a13fd70ffc0a@linux.microsoft.com>
Date: Tue, 8 Sep 2026 11:13:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
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
 <20260907065129.269262-2-namjain@linux.microsoft.com>
 <SN6PR02MB41570E8F17B6A78AD607F91CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570E8F17B6A78AD607F91CD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 1:23 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 11:51 PM
>>
>> The Hyper-V root partition vPCI MSI irqchip lost its irq_retrigger()
>> callback when it was converted to msi_create_parent_irq_domain(). The
>> callback was present on the original irqchip and was dropped during that
>> conversion.
>>
>> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
>> the outgoing CPU to a new target. If an interrupt still has its pending bit
>> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
>> new target through the irqchip's irq_retrigger() callback. As the root
>> partition PCI/MSI chip no longer provides that callback, the pending
>> interrupt is silently dropped, which can result in lost interrupts, stalls
>> and "No irq handler for vector" messages during CPU hotplug.
>>
>> Restore irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
>> the root partition PCI/MSI irqchip, so that a pending interrupt is resent
>> on its new target CPU via the parent x86 vector domain.
>>
>> Fixes: 4691db0704ac ("x86/hyperv: Switch to msi_create_parent_irq_domain()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/irqdomain.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index b3ad50a874dca..1e273d7d6c5b3 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -304,6 +304,7 @@ static struct irq_chip hv_pci_msi_controller = {
>>   	.irq_ack		= irq_chip_ack_parent,
>>   	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
>>   	.irq_set_affinity	= irq_chip_set_affinity_parent,
>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   };
> 
> There's a slight discrepancy compared with the guest pci-hyperv.c driver,
> where setting the .irq_retrigger function is done dynamically in
> hv_pcie_init_dev_msi_info() instead of statically.  The parallel here would
> be to set it in hv_init_dev_msi_info(). But given that Patch 3 of series
> removes setting .irq_retrigger in both cases, the discrepancy shouldn't
> really matter.
> 
> If there's a reason to prefer one approach vs. the other, I don't know
> what that reason is.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

This change should be done for the outermost chip, i.e. in
hv_init_dev_msi_info(). With change 2, it won't matter, but patch 2 is
not being back ported. So, I'll fix it.

Regards,
Naman

> 
>>
>>   static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>> --
>> 2.43.0
>>
> 

