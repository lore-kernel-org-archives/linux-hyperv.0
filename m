Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F41D47AC;
	Wed,  5 Aug 2026 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905044; cv=none; b=MgK234wX+QVOd2uMqKWqyNQly2p8bXw7WZzhxbH3wqDcD3IAZE3BHh0P+TIvBl5ZbPiBhlObGhl+CC4Lqsm/vcOcKLXeqoc3OC/DBrbnpp2WL9oQTLKB+o4gumSdoCjJdQor1uVk6677jdI9PHq/CpOF5+fU7bJLUhfqteKSqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905044; c=relaxed/simple;
	bh=n2P6idRe3RqOB1keZ96ibxRUsaj0qnSuENYCvkqZ2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRBs8p05sDqPNU3bucI/PokG2Wv0mzIBx4dKm7eH1Fc8rbFyfJMe7mxRQ4uEQ5hucLYre8cwMP0+SR5aFigS+jklJbPzZhzN/vBz63Rt2TxXTWivpdDYd9NNxKdB5bsdaNxAQKqgq1iD5zzu4koK9AElpYeYAujRsi2lzy8/Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VOfJdR5V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VOfJdR5V"
Received: from [10.7.58.6] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id A423420B7169;
	Tue,  4 Aug 2026 21:43:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A423420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785905021;
	bh=CRiTfhhHlWQ+Wky5oSEnJr3z9b/fF7IvnlsFt1kRh1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VOfJdR5VPx/n8VqYGq2vionMO1cw1homB43MhJCFnPjYAnK6wgb1aYjSoTI+BKaPw
	 bcWFBRY0CuUsAvuGDeJI0Vwg3rkezK4+Jo/yddqIMF5vmvKtwSXy6y7JUtcYF8hNv6
	 C2z5aex/xEHzLKPraj0lg4auiprjbwRvjj605VoE=
Message-ID: <750adee2-e934-4907-ae54-d01e7d3defc4@linux.microsoft.com>
Date: Wed, 5 Aug 2026 10:13:47 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug for
 Hyper-V PCI/MSI
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 <anHYJEeHlszuj/38@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <anHYJEeHlszuj/38@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/2026 5:46 PM, Shradha Gupta wrote:
> On Tue, Jul 28, 2026 at 01:51:14PM +0000, Naman Jain wrote:
>> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
>> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
>> callback. The Hyper-V vPCI MSI irqchip never installs one, so such a
>> pending interrupt is silently dropped, leading to lost interrupts, stalls
>> and "No irq handler for vector" messages.
>>
>> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that installs
>> irq_chip_retrigger_hierarchy() on the Hyper-V PCI/MSI chip. Patch 2 then
>> switches fixup_irqs() to call irq_chip_retrigger_hierarchy() directly, so
>> the retrigger works for any stacked irqchip without a per-chip callback.
>> Patch 3 drops the now-redundant irq_retrigger() initializations.
>> This way, patch 2 and 3 do not need to be backported.
> 
> Thanks Naman, the series looks good to me.
> 
> I just have a small nit. In the old code, VECTOR_RETRIGGERED is set
> unconditionally after calling chip->irq_retrigger(), regardless of its
> return value. In the new code, VECTOR_RETRIGGERED is only set when
> irq_chip_retrigger_hierarchy() returns non-zero. So retrigger failures
> would now result in VECTOR_UNUSED instead of VECTOR_RETRIGGERED.
> 
> In practice this doesn't matter since apic_retrigger_irq() always returns
> 1, but it is technically a behavior change and I think it is a correct
> one. Just that it might be worth noting this in the commit message to
> avoid confusion.
> 
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
>>

Thank you Shradha. I'll address this in the next patch version.

Regards,
Naman

