Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40B37FF68;
	Tue,  8 Sep 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848841; cv=none; b=vFpU0uu4eojHMIQjaO70j2M46ykmduELNFlCfw3KT7orcMFvSf+wij/CuIKAedaS9rL4m/s72TOXmKdAHk+cqqFCE6QVxFtx1JrbIear1DxV5gqumAqrnMiZ+6B8Wq0HyaEHgDQ9Hedc8ObWlwSdOfNKWZ1DEdVk0Mkymk8BviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848841; c=relaxed/simple;
	bh=moJMN8O3L98OMrpYwW001RWUIzOm27kfc+4ey19OG4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOKl130BnkjRMc7Z0babU5VyklBmyLMHP3pgKteixId1cwR/oPN28coUE21LyI4IVmw8NsDmznBnbPn+5/hf6MH4xtNTmVmhPkLAUbQ+qAD9poxVwE47fIDDi9tKNrp8EsxsmbTOEwuqlhqlZpeUF3DmYeZDmFPeFQ3cV2IeHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q6Y5vmWF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q6Y5vmWF"
Received: from [10.95.64.224] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 243C320B7128;
	Mon,  7 Sep 2026 23:26:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 243C320B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788848794;
	bh=/8JxHTnBCLPamYDux4i0PHSyHFScUeetfljkq7nsqOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6Y5vmWFnK85cH44VyzqkkVrA/+E83jXI+Jgf089f4IlXgeJG6DbqliW3wQLDCaab
	 2hQrM09ctSJPnDN+fzvRKJSGc/7nTu4UmIr2h/WMUc065QLuKCS91B0pdginaH8lKu
	 ccrlYXUnBEnSJ6lBEcRSg/Na2ImKaW+WznGVVcNc=
Message-ID: <b993a1c1-19e3-4af8-887d-b171db83c1a4@linux.microsoft.com>
Date: Tue, 8 Sep 2026 11:57:02 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
To: Nam Cao <namcao@linutronix.de>, Michael Kelley <mhklinux@outlook.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Wei Liu <wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
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
 <87bja88djw.fsf@yellow.woof>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <87bja88djw.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 11:55 AM, Nam Cao wrote:
> Michael Kelley <mhklinux@outlook.com> writes:
>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 6, 2026 11:51 PM
>>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>>> index b3ad50a874dca..1e273d7d6c5b3 100644
>>> --- a/arch/x86/hyperv/irqdomain.c
>>> +++ b/arch/x86/hyperv/irqdomain.c
>>> @@ -304,6 +304,7 @@ static struct irq_chip hv_pci_msi_controller = {
>>>   	.irq_ack		= irq_chip_ack_parent,
>>>   	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
>>>   	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>>   };
>>
>> There's a slight discrepancy compared with the guest pci-hyperv.c driver,
>> where setting the .irq_retrigger function is done dynamically in
>> hv_pcie_init_dev_msi_info() instead of statically.  The parallel here would
>> be to set it in hv_init_dev_msi_info(). But given that Patch 3 of series
>> removes setting .irq_retrigger in both cases, the discrepancy shouldn't
>> really matter.
>>
>> If there's a reason to prefer one approach vs. the other, I don't know
>> what that reason is.
> 
> hv_pcie_init_dev_msi_info() is for the MSI device's interrupt domain,
> while this patch is setting it for the parent's interrupt domain.
> 
> The former is what we need.
> 
> Nam

Acked. I will push this change in next version.

Thanks,
Naman

