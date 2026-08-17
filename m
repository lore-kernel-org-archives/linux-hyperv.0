Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C203E4510;
	Mon, 17 Aug 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980665; cv=none; b=HjwTfo+8pXS5gaaqm1wY7u1CL2S82TRh7D0p3775DPeWg4+XQwjCSK/kWrOQNpKD0r113ZDTeHhiGz6XUR6NCiZTvnxrdA2LptbKWEKDKLwdc1jjOnksQLKhMnVNWzr6tNdPIuUa0MQSIejJfM3VMj760aBnqtBjFNBrDL8Q0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980665; c=relaxed/simple;
	bh=j9Nnvyyq0998hIgxyoGSFK22woaTS56Z2zWd/S1ZO+4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mR+RQjJnb3Ch4prcdpyyFWasFP4Cz33JURWDqRCALUePedMFUGA7ognQX08pt2iSSdhy+zHTKIQaeO1ivns/BtcqwYURA5w2odk54KQctTKfBkQ48iisvgBArOXnB+p0EGmNnQ9QizBnGyQTN44nw2szAPvbpIMOG9tkjeN5RH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fUpgmI9I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fUpgmI9I"
Received: from [192.168.0.100] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5219320B7167;
	Mon, 17 Aug 2026 08:30:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5219320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786980635;
	bh=qeHY3+RlQzQhCDqlnfGp3+CgFMQL/RXYE8B9od6UsDU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fUpgmI9I2VdpeWZVJakWQYCHpaYx5FtGmYvniyvVgAds3Pja6uUeppMKosOlMzvBM
	 ilalV2V9tDV4Ehczewzo/E9EEtm/j1r0ZL3hYyLL8dmlHiQRl2nDXqnJJuPdDO0qwe
	 968dTE/sxNvCYpfYZVY1eJgBTx00611gMv1ij5nU=
Message-ID: <bed153ef-1cc4-4c27-9cfb-88afc2f73a3a@linux.microsoft.com>
Date: Mon, 17 Aug 2026 21:00:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: hv: Set irq_retrigger callback for the
 Hyper-V PCI MSI irqchip
From: Naman Jain <namjain@linux.microsoft.com>
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
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157CE7F6C5A11D172444D60D4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <68315782-3695-4e16-a990-3a1c41cb7476@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <68315782-3695-4e16-a990-3a1c41cb7476@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/17/2026 5:45 PM, Naman Jain wrote:
> 
> 
> On 8/17/2026 9:08 AM, Michael Kelley wrote:
>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, August 
>> 10, 2026 2:07 AM
>>>
>>> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
>>>
>>> On CPU hot-unplug fixup_irqs() migrates the interrupts which are 
>>> affine to
>>> the outgoing CPU to a new target. If an interrupt still has its 
>>> pending bit
>>> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it 
>>> on the
>>> new target through the irqchip's irq_retrigger() callback. As the 
>>> Hyper-V
>>> PCI/MSI chip does not provide that callback, the pending interrupt is
>>> silently dropped, which can result in lost interrupts, stalls and "No 
>>> irq
>>> handler for vector" messages during CPU hotplug.
>>>
>>> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() 
>>> callback for
>>> the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on 
>>> its
>>> new target CPU via the parent x86 vector domain.
>>
>> The RFC version of this patch set listed the asynchronous nature
>> of the HVCALL_RETARGET_INTERRUPT hypercall as a cause of the
>> problem. Is that hypercall still believed to be asynchronous?
>> My understanding of "asynchronous" would be that Hyper-V
>> does not guarantee that the retargeting of the interrupt to a new
>> vCPU has occurred when the hypercall returns. There is an
>> unspecified time period during which the interrupt could still be
>> directed to the vCPU that is going offline. Furthermore, Hyper-V
>> provides no rendezvous mechanism for the guest to know when
>> the interrupt is guaranteed to go to the new vCPU.
>>
>> If the async behavior is indeed present, isn't it a problem, even
>> after this patch? irq_migrate_all_off_this_cpu() causes the
>> RETARGET_INTERRUPT hypercall to be made, but a new interrupt
>> could still be generated to the going-offline vCPU after fixup_irqs()
>> runs its loop searching for any pending interrupts. A new such
>> interrupt would be lost. The 1 millisecond delay in fixup_irqs()
>> probably mitigates this problem by giving Hyper-V time to complete
>> the retargeting. But it's not a 100% solution.
>  > > Assuming my thinking is correct, there isn't a 100% solution. But
>> the problem's existence, and the likely benefit of the 1 ms delay,
>> should be called out in the commit message and/or code
>> comments for future readers.
> 
> Please allow me to confirm with the Hyper-V team internally once. I may 
> have assumed asynchronous behavior because of the pending interrupt 
> after retarget. It could simply have been committed to the old route 
> before the retarget operation.

This is actually synchronous. So the fix in this series should suffice.
Sorry for the confusion.
I don't see any mentions of asynchronous behavior of that hypercall 
anywhere in these 3 patches, so I think we should be good.

Regards,
Naman

> 
>>
>> I also wondered about arm64 where Hyper-V provides an
>> emulated GICv3. The RETARGET_INTERRUPT hypercall is not
>> used since the retargeting is done by writing to a GICD register.
>> Presumably on real GICv3 hardware, after the write the new
>> CPU is guaranteed to receive any subsequent interrupts. And if
>> an interrupt was pending at the time of the write, the appropriate
>> trigger happens in the new CPU, so everything works. As long
>> as Hyper-V is doing the emulation the same way (i.e., fully
>> synchronously), the problem would not occur on arm64
>> guests.
>>
>> I'm reminded that a similar problem occurred with changing
>> the target CPU for a VMBus channel interrupt. The initial
>> Hyper-V implementation of the VMBus MODIFYCHANNEL
>> message was asynchronous, which caused the same problem
>> as seen here if a vCPU were to be taken offline. A later version
>> of the VMBus protocol added a notification that the change to
>> the target vCPU is complete, which solves the problem. See
>> vmbus_channel_set_cpu() and vmbus_send_modifychannel()
>> and the associated code comments.
>>
> 
> Thanks for sharing this info. I'll check and get back.
> 
> Regards,
> Naman
> 

