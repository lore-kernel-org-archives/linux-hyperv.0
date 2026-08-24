Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDF33939A;
	Mon, 24 Aug 2026 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552884; cv=none; b=qnKh8KJDvDANiww0SoZ50NACWFsehf9+OHGmjVGJGlyiQymuO+3ZoyyLzWPS5ncwV+/Iks2ddHHAswcM9pXPbFSqaorAIJ4yCxEUzg3TUSTTitlhfJvFz/s5ees9IY3vFwAtBjbTam0/85C8nd5gcrkk+JYw4VYqyOXmhpXeheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552884; c=relaxed/simple;
	bh=LkRtI3pmvjIoVMEzbKSKIuqvH8xMDB+uK0wyKOQxHVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7irFO17FP8DV0mKVIi0YIkon80pvh1zx16FzYNz2dbgB1oEKlDmrmXjfkn7fpEWKWYKJDYlFDGcvnlwEiXGOrp8OW2WBkQq3HoSt/peJmiCDT33DEleJo6zLOzLWeA+Q1xre9CUYf0AjN3Qd/UrJEKzVYaby0oK4nOswDzwISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HwvBEUZE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HwvBEUZE"
Received: from [192.168.1.70] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 835B120B7166;
	Sun, 23 Aug 2026 23:27:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 835B120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787552851;
	bh=O4pr4hYlgjdfgeWFfFKRFT/vKwaQD3nS7Ku4eOeDQ5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HwvBEUZEywrg293E6Up5D+IQNqqle+GOIVLaAS0DJQa8fHA29EFvVURYCtrzITnXb
	 /AyslYGxR00vU4x030h1eMC6XWq/EQ7cEzsDnj/e8M9lUC1KkboMVhJqiUIaDY5eMu
	 hdG5uJzOnzvOJIpZ9JtBXQGJsGkhfEphiC14EASY=
Message-ID: <c165f17f-b214-4a96-a446-6dd4e6cb2161@linux.microsoft.com>
Date: Mon, 24 Aug 2026 11:57:56 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V
 PCI MSI irqchip
To: Wei Liu <wei.liu@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-2-namjain@linux.microsoft.com>
 <20260728140427.714311F000E9@smtp.kernel.org>
 <a9d44162-3c90-44c8-aae7-4813678234a9@linux.microsoft.com>
 <20260824001406.GC3566091@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260824001406.GC3566091@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/2026 5:44 AM, Wei Liu wrote:
> On Thu, Jul 30, 2026 at 04:56:27PM +0530, Naman Jain wrote:
>>
>>
>> On 7/28/2026 7:34 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>
>>> Pre-existing issues:
>>> - [High] The fix for dropped pending interrupts during CPU hot-unplug was missed in the sister Hyper-V root partition MSI domain.
>>> --
>>>
>>> --- Patch [1]: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip ---
>>> commit b8b1c843c457dd145f0d360b44f4b1bf34bd8cf5
>>> Author: Naman Jain <namjain@linux.microsoft.com>
>>>
>>> PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
>>>
>>> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
>>> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
>>> the outgoing CPU to a new target. As the Hyper-V PCI/MSI chip does not
>>> provide that callback, the pending interrupt is silently dropped, which
>>> can result in lost interrupts, stalls and "No irq handler for vector"
>>> messages.
>>>
>>> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Long Li <longli@microsoft.com>
>>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>
>>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>>>> index cfc8fa403dad6..89816a2bd7cd3 100644
>>>> --- a/drivers/pci/controller/pci-hyperv.c
>>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>>> @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>>>>    	info->ops->msi_prepare = hv_msi_prepare;
>>>>    	chip->irq_set_affinity = irq_chip_set_affinity_parent;
>>>> +	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>>>
>>> [Severity: High]
>>> This isn't a bug introduced by this patch, but does the sister Hyper-V root
>>> partition MSI domain in arch/x86/hyperv/irqdomain.c also need this fix?
>>>
>>> Looking at hv_init_dev_msi_info(), it appears to be missing the exact same
>>> callback initialization for the root partition's top-level irq_chip:
>>>
>>> arch/x86/hyperv/irqdomain.c:hv_init_dev_msi_info() {
>>> 	...
>>> 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>>> 		return false;
>>>
>>> 	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
>>>
>>> 	info->ops->msi_prepare = pci_msi_prepare;
>>>
>>> 	return true;
>>> }
>>>
>>> If a CPU is hot-unplugged while a device MSI interrupt is pending in its
>>> local APIC IRR, could fixup_irqs() fail to resend the pending interrupt
>>> to the new target CPU because this callback is NULL?
>>>
>>> This could potentially lead to the same lost interrupts and I/O stalls
>>> described in this commit message, just in the root partition MSI domain
>>> instead of the guest paravirtual MSI domain.
>>>
>>>>    	if (IS_ENABLED(CONFIG_X86))
>>>>    		chip->flags |= IRQCHIP_MOVE_DEFERRED;
>>>>
>>>
>>
>> I am not planning to include this in this series, since this issue is not
>> seen in root partition yet and I am not sure if it is applicable here.
>> Second patch would anyways fix it going forward, but I am OK adding the
>> change for this, if we need.
> 
> What's the downside of fixing the root partition irq domain?

No downside as such. It would be a latent bug, exposed only if we 
exercise hotplug in root partition, which seems like we don't. After 
patch 2 of this series, that would go away anyways. If you tell me, I 
can add a change similar to patch 1, which is backportable, but then I 
would need to remove it similarly in patch 3.

Regards,
Naman

> 
> We never really attempted to unplug any CPU from the root partition, so
> it is unsurprising that it has not been reported.
> 
> Wei
> 
>>
>> Regards,
>> Naman
>>

