Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349D433059;
	Mon, 14 Sep 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381688; cv=none; b=dSZQ25B9LaQlS6b4Av9cygbuRLV9YE+YOVgCIwhVc4mVMVUxux/6WE/Q6FqNm7BnK8HblM8dehoRexlX/D9+c+HRKhNOoW1Ua1xTdQxUyi8O0S1X2NCKJ//lIBDtPqaibXzTB/sCopciJVounrKCaW+hzERwB+EFul5KRydYEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381688; c=relaxed/simple;
	bh=BwOrr2KAJAZg+sgOgloSxZAMjyVMU0vsY3LxgeDpaRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVRVszLc6E/JJyII8U3/+rxQUAla0AOeUH7GReNL0N+bK+dMlBMk2dELqamaCpDyKV5LJCfaYXlwktVYiZov/m+Ly+XDdCwxB1sXTpZfdvz55+hh7lpnWMCXbgv7wYouI+nbbsuoyxR4Bp/GXEMvOb5ntY9NhdpS5caRZopFG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qvqyfRlT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qvqyfRlT"
Received: from [192.168.1.22] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id DBFBE20B7168;
	Mon, 14 Sep 2026 03:27:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBFBE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789381637;
	bh=9FMakUTBN+IyCdDcaWf7V7aTn6h5oZP5pYbgi1KoQUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvqyfRlTlbcG9uClnlktIuT2JJ9/rpqb493t3eWY3D03MVLG2VT7cy+uoByMG77Wm
	 cjs5IJFvlxYra/FjOXmPvNBAz2bSFYtA4Ff7EnqXIiDAXntznu0y6VX0PGf1D/Zdb4
	 R/MONBUDUZ1T+rPkCA3UX6aVMnnfRAyIMwHl2m9Y=
Message-ID: <28e42462-732b-4d58-bcdb-cc9378eb134d@linux.microsoft.com>
Date: Mon, 14 Sep 2026 15:57:49 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
To: Thomas Gleixner <tglx@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "namcao@linutronix.de" <namcao@linutronix.de>
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
 <20260810090716.2325295-4-namjain@linux.microsoft.com> <875x0e204j.ffs@fw13>
 <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87mrtoyzoy.ffs@fw13>
 <SN6PR02MB4157B093E09517D408FD58DAD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87y0d6xpan.ffs@fw13>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <87y0d6xpan.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/2026 12:36 AM, Thomas Gleixner wrote:
> On Fri, Sep 11 2026 at 16:32, Michael Kelley wrote:
>> From: Thomas Gleixner <tglx@kernel.org> Sent: Friday, September 11, 2026 1:12 AM
>> As for the future, you may remember my RFC patch set from a couple
>> years ago for the Synthetic Interrupt Controller (SynIC) that Hyper-V
>> provides to guests. The SynIC currently has special case nodes under
>> /sys/bus/vmbus to manage CPU affinity. As a better approach, the patch
>> set modelled the SynIC as an irqchip so standard Linux mechanisms could
>> manage affinity. You and I corresponded about per-cpu flow handler
>> tweaks to make it all work. The RFC patch set didn't get traction with
>> the Microsoft folks and I didn't push it. But it had a stand-alone IRQ
>> domain not parented to VECTOR because Hyper-V interrupts are hard
>> coded to HYPERVISOR_CALLBACK_VECTOR. As a stand-alone domain,
>> a .irq_retrigger function might have been useful in fixup_irqs(). That's
>> all speculative, but it was in the back of my head when I suggested to
>> Naman that the outermost chip .irq_retrigger function should be
>> checked. I'm fine with not doing that check now, and if a future case
>> like the Hyper-V SynIC arises, the check can be added.
> 
> It doesn't because that domain is not parented by the vector domain, so
> interrupts in that domain cannot have a descriptor in the descriptor
> array and neither will end up in msi_set_affinity().
> 
> These interrupts are handled in the generic cpuhotplug mechanism.
> 
> fixup_irqs() is really only about the vector domain to handle the case
> where an interrupt was raised on the old vector on the outgoing CPU
> before the generic hotplug affinity change took effect.
> 
>>> Devices might have a way to retrigger at the device level, but that's
>>> not reachable from the interrupt chip.
>>>
>>> So both places fixup_irq() and msi_set_affinity() can use retrigger
>>> hierarchy safely without the conditional checking the outermost domain
>>> chip.
>>
>> And setting .irq_retrigger in x86_init_dev_msi_info() becomes
>> superfluous, right?
> 
> Yes.
> 
> Thanks,
> 
>          tglx


I'll remove the conditional check in next version at both of the places.
Thanks.

Regards,
Naman

