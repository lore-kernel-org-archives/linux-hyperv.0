Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C7400967;
	Thu, 30 Jul 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410795; cv=none; b=A86YSN5l4C1Srzq7KKrMwGPfOKsnVVjEgr3JC5EPRKIScShBBQ3RNlrcPaCWdddThIK5TrNfNDs0GHS1W88y/c1YCN1RLkig0GhWAFdpVrisgv1tYnXvI/Wpi9R9mDvM3xoDZ4lridJOEUBShrm/8fn+jPfAFFegbwpMl2h9l54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410795; c=relaxed/simple;
	bh=jAQYUEH9rp6tkN0ocp40/35LZbc1Iu7rIRMXZgAVKVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmS2uNFynhnWMlUXEoWE0e9qsCVsr1W38881ysdRiD+MOGhtAeQO84FWbcPISFYnW67iS1P3ewTceZ++J2TMqc8uCdVlaWE4eR0iYGNJZX8rzggJ7RH4E9DXYvc0WQSaF6Vd/HG3pjkXRvlAynAsbvTtw8On4OWVclo5Lbypknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sXdICoph; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sXdICoph"
Received: from [192.168.0.105] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4EFA220B7167;
	Thu, 30 Jul 2026 04:26:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EFA220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785410776;
	bh=Vds4LkW3KdTdjeaQxu1TTLzrv4vuQbQinRX0D3ockIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXdICoph3qcu+kkj01nFVh6dKy1RxyJLbEXCjshWt530ki4FvNkXiQC3qeFUif2jT
	 xjtHBJPzKWLMDwlEdxuqsN4l7fwkPl+klFMu5Yr43/x26e0dFH6d7eK2R/gn+bnBsF
	 01lAj4uPLMoxznpLit7YlUTUX0Az6/Vxr7EPrqBY=
Message-ID: <a9d44162-3c90-44c8-aae7-4813678234a9@linux.microsoft.com>
Date: Thu, 30 Jul 2026 16:56:27 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V
 PCI MSI irqchip
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-2-namjain@linux.microsoft.com>
 <20260728140427.714311F000E9@smtp.kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260728140427.714311F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/2026 7:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The fix for dropped pending interrupts during CPU hot-unplug was missed in the sister Hyper-V root partition MSI domain.
> --
> 
> --- Patch [1]: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip ---
> commit b8b1c843c457dd145f0d360b44f4b1bf34bd8cf5
> Author: Naman Jain <namjain@linux.microsoft.com>
> 
> PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
> 
> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. As the Hyper-V PCI/MSI chip does not
> provide that callback, the pending interrupt is silently dropped, which
> can result in lost interrupts, stalls and "No irq handler for vector"
> messages.
> 
> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Cc: stable@vger.kernel.org
> Suggested-by: Long Li <longli@microsoft.com>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> 
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index cfc8fa403dad6..89816a2bd7cd3 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>>   	info->ops->msi_prepare = hv_msi_prepare;
>>   
>>   	chip->irq_set_affinity = irq_chip_set_affinity_parent;
>> +	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the sister Hyper-V root
> partition MSI domain in arch/x86/hyperv/irqdomain.c also need this fix?
> 
> Looking at hv_init_dev_msi_info(), it appears to be missing the exact same
> callback initialization for the root partition's top-level irq_chip:
> 
> arch/x86/hyperv/irqdomain.c:hv_init_dev_msi_info() {
> 	...
> 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> 		return false;
> 
> 	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
> 
> 	info->ops->msi_prepare = pci_msi_prepare;
> 
> 	return true;
> }
> 
> If a CPU is hot-unplugged while a device MSI interrupt is pending in its
> local APIC IRR, could fixup_irqs() fail to resend the pending interrupt
> to the new target CPU because this callback is NULL?
> 
> This could potentially lead to the same lost interrupts and I/O stalls
> described in this commit message, just in the root partition MSI domain
> instead of the guest paravirtual MSI domain.
> 
>>   
>>   	if (IS_ENABLED(CONFIG_X86))
>>   		chip->flags |= IRQCHIP_MOVE_DEFERRED;
>>
> 

I am not planning to include this in this series, since this issue is 
not seen in root partition yet and I am not sure if it is applicable 
here. Second patch would anyways fix it going forward, but I am OK 
adding the change for this, if we need.

Regards,
Naman
