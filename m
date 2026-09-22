Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066839A4CF;
	Tue, 22 Sep 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048814; cv=none; b=l7Jmop/LXXcyLkpVDnRgjtWun5aPynzxV51NZZHHS6GMUTb7jrYHexQ7/l3pBTAULxyA1PnbE1K9URmADTwjPUQ1712GBP9i4SvMzg9H3ImeSVYU81tfzyuizEWqINX+9UlZpfgxiRcN8w/64WtmZoTC6H5fbTp+vuqnwDykjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048814; c=relaxed/simple;
	bh=LTpnuIgDGyq6xsQCCTBkMjz2ignLP0OXe2ADwuFTm4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3wbgw234HEipuSaFzsQMiIhzDgoYBK2yXjz/0gai7dWe/ISiIhKyh3N6HlM7ndZ2x5bexYC4yO0dxgmlAihAXfvhYyGwOTR8Xfb92k7OEBYN0ZziGXm4OH0jvwOkAr5aAxP9BXyBWUx7sMuHNGAgvPmjiNtqykdDl7GyqcNZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JyMZEPHo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JyMZEPHo"
Received: from [192.168.1.70] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CA9520B7169;
	Mon, 21 Sep 2026 20:45:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CA9520B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790048764;
	bh=hCWMokXUQJxjRS5QdQL5gNAVPByZ1c1WYuxTg8bYASY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JyMZEPHoh0VHsPtYUZ/NyYnw9zoO2Ai49u81MWxW8sYPlvSzR0CfmdbbVD56M4MXc
	 WP/4YcjlCemINQbDhdktQCaNknNK4Ap3PWCe77GE58KGbRw1PC48Uefavk50YhPk8a
	 gpq1XXv75N9tmq/B1OIkuxnxnxgH5lXHyjxEj6tA=
Message-ID: <d1609eac-6f3f-48e3-8b1f-1e272fb53bf3@linux.microsoft.com>
Date: Tue, 22 Sep 2026 09:16:30 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
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
 <20260914111836.2119301-4-namjain@linux.microsoft.com>
 <SN6PR02MB41570F45986408BA60D75A3CD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570F45986408BA60D75A3CD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2026 2:30 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, September 14, 2026 4:19 AM
>>
>> msi_set_affinity() re-injects a pending interrupt on its new target by
>> looking at the outermost domain chip and invoking its irq_retrigger()
>> callback. Since this mirrors the behavior of
>> irq_chip_retrigger_hierarchy(), use the helper directly instead.
> 
> This commit message glosses over the key point. I think the full
> statement is that in all cases where msi_set_affinity() is called, the
> irqchip's .irq_retrigger function is set to irq_chip_retrigger_hierarchy().
> Both are set only in x86_init_dev_msi_info(). So it is equivalent to
> just call irq_chip_retrigger_hierarchy() directly.

I'll add this info in next version.

Thanks,
Naman

> 
>>
>> Suggested-by: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/kernel/apic/msi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
>> index 66bc5d3e79db3..9160227b9b32a 100644
>> --- a/arch/x86/kernel/apic/msi.c
>> +++ b/arch/x86/kernel/apic/msi.c
>> @@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
>>   	 * IRR.
>>   	 */
>>   	if (lapic_vector_set_in_irr(cfg->vector))
>> -		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
>> +		irq_chip_retrigger_hierarchy(irqd);
>>
>>   	return ret;
>>   }
>> --
>> 2.43.0
>>

