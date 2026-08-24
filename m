Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6E3B2FFB;
	Mon, 24 Aug 2026 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550116; cv=none; b=rTs9SlqvFcCPZQUCdMMJ5D46V7h+IWVwbygOmadDiJkHSOeIroPm3xfuQU2UpOQenEDo45BxkkQbDHgEdjOEXgfrehGw+WknW08GxaThsqexSBUauNTBpF7vF2J17eWdUX/hpu/yRm+z8qMEQA4vzHgo541PYfIAC5UgqEaSsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550116; c=relaxed/simple;
	bh=RCZj70h0+gYIXU+6RyJFQ+PlAyNXP9sJti6tHncp4sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilcHjctYbdGUEC/T7uRr/i8GVgX/+HTK/5xiaXVu55vJDMKM+D0A+OIIy6pu7aDiqR5944aOt2MKF2h3H31sr/K9VGNFlww7CEJT6YM70KDU985rw343L6F2UbM4/nSGh3CZJSzqo1JMOMi0YkUgrI2FbovpJ/IvX26Ud2DHo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kuvk0Vi+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kuvk0Vi+"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F90D20B7166;
	Sun, 23 Aug 2026 22:41:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F90D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787550084;
	bh=je3FEBmIEIOvsJhScsyZLYxCRxTa76SkmSSg/ZomV6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kuvk0Vi+pymQ/UuXARFFGORUloQgEw0Du0vCrFKDWsAIcctqmsAWLgTSTBZ/A+u4r
	 tShGcij72kbJtmcqWmzORHSaFl2uKAU3pEHjPj6h7jnoVU/Sj0C+jwaPFtvkg9LKF1
	 hkYON3p1O9jhoEecOlIokHJ91buXtWTAFCwYfCSA=
Message-ID: <f763801e-04b1-4c38-9625-78da5797d85d@linux.microsoft.com>
Date: Mon, 24 Aug 2026 11:11:42 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/irq, iommu/amd, PCI: Drop redundant irq_retrigger
 inits
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
 <20260728135117.2888175-4-namjain@linux.microsoft.com>
 <20260824001747.GE3566091@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260824001747.GE3566091@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/2026 5:47 AM, Wei Liu wrote:
> On Tue, Jul 28, 2026 at 01:51:17PM +0000, Naman Jain wrote:
> [...]
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index ea3377e61aa5c..0c362e86a09d9 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -2468,7 +2468,6 @@ static struct irq_chip intcapxt_controller = {
>>   	.irq_unmask		= intcapxt_unmask_irq,
>>   	.irq_mask		= intcapxt_mask_irq,
>>   	.irq_ack		= irq_chip_ack_parent,
>> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>   	.irq_set_affinity       = intcapxt_set_affinity,
>>   	.irq_set_wake		= intcapxt_set_wake,
>>   	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 89816a2bd7cd3..cfc8fa403dad6 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>>   	info->ops->msi_prepare = hv_msi_prepare;
>>   
>>   	chip->irq_set_affinity = irq_chip_set_affinity_parent;
>> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>.
> 
> I suppose you do this because the first patch is supposed to be
> backported.
> 
> Wei

Yes, exactly.

Regards,
Naman
