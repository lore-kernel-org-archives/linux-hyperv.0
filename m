Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E2435507;
	Mon, 14 Sep 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381854; cv=none; b=k3t6xxQ2WezH91hEyhZXi7kRoKKTGBZRZzSFFL4bQ4pwaJQsrV3IGlFweNjBTddbzVGFsm3u3T19VUeifQAb+7IDzJxig7/C3z3jKRkMR/m3gUNO6n8tXSPOsMioj4J/tdFs/L9wr7fyRJCyNTRAoG1NqXxyacU1Z/LT6tilZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381854; c=relaxed/simple;
	bh=Ib73cmKoLiJWU8DgSl1knaG80M05ZScXeJO5JNvIwaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DixAzdq6iXbUsNky0DoDH+1fpCmifJBupBZaVAkcW/yF1NUD5Y5YpyX7qon/qXtyJ+Gje+d8dc7qYrqdqDKIm4Ukz3Yhp4HjkKTU8gn7D+utMaE2VH8h0JCN6DV/U81MXJRVIypCE/zpAoATrCRpR27vbdtu6PSISK+dSNTsO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fatlIaR7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fatlIaR7"
Received: from [192.168.1.22] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 653C920B716B;
	Mon, 14 Sep 2026 03:29:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 653C920B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789381809;
	bh=LR7UILJpaibN7HFmxyjnyyrloFYOFPYzKcC3epND9nQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fatlIaR7Py4N0BSZTrIUxIvh6Cm90qgv0nQKjsXbjwwXtmpgHMZEtp3Xf2MjVRF0+
	 nsMlNHs0Xdvysi8SshUy1nXa7rLxQWtySxO274Us9zLyF0Q+jUpH2Lbb4BKADvxnPr
	 Eg8se51pqrS6hz3iSi7MpB7bGuQX937Zl62ExyXc=
Message-ID: <759b4eb6-2e11-40ba-9806-f467fd29f55f@linux.microsoft.com>
Date: Mon, 14 Sep 2026 16:00:38 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
To: Wei Liu <wei.liu@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Nam Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
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
 Daniel J Blueman <daniel@quora.org>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260913224842.GF2219269@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260913224842.GF2219269@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/2026 4:18 AM, Wei Liu wrote:
> On Wed, Sep 09, 2026 at 06:44:44AM +0000, Naman Jain wrote:
>> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
>> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
>> callback. The Hyper-V root partition PCI/MSI irqchip lost that callback
>> when it was converted to msi_create_parent_irq_domain(), so such a
>> pending interrupt is silently dropped, leading to lost interrupts, stalls
>> and "No irq handler for vector" messages.
>>
>> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that restores
>> irq_chip_retrigger_hierarchy() on the Hyper-V root partition PCI/MSI chip.
>> The equivalent guest pci-hyperv.c fix from the previous version is already
>> merged, so it is dropped here.
>>
>> Patch 2 then switches fixup_irqs() to have a fallback call to
>> irq_chip_retrigger_hierarchy() directly, if a chip does not define
>> irq_retrigger callback.
>>
>> Patch 3 makes a similar change in msi_set_affinity()
>>
>> Patch 4 then drops the now-redundant irq_retrigger() initializations.
>> This way, patch 2-4 do not need to be backported.
>>
>> Changes since v3:
>> https://lore.kernel.org/all/20260907065129.269262-1-namjain@linux.microsoft.com/
>> * Move irq_retrigger setting to hv_init_dev_msi_info() in patch 1
>>    (Michael, Nam)
>> * Add if-else fallback check in msi_set_affinity() in patch 3 (Michael)
>> * Break patch 3 into two separate patches, while *keeping review tags*.
>>
>> Changes since v2:
>> https://lore.kernel.org/all/20260810090716.2325295-1-namjain@linux.microsoft.com/
>> * Add a backportable fix for Hyper-V root partition irqchip (Wei)
>> * Add a check for custom irq_retrigger implementations and add direct
>>    irq_chip_retrigger_hierarchy() calls as a fallback if it is not
>>    defined by a chip. (Sashiko, Michael)
>> * Removed local loop variable change, and continue using the irq_desc
>>    accessor function (Michael)
>> * Did not pick "Acked-by: Manivannan Sadhasivam" as it was on v1, and v3
>>    is a functionally different to some extent, specially patch 2.
>>    Requesting you to please review again.
>>
>> Changes since v1:
>> https://lore.kernel.org/all/20260728135117.2888175-1-namjain@linux.microsoft.com/#t
>> * Added Review tags
>> * Adding minor clarification in commit msg of patch 2 (Shradha)
>>
>> Original RFC: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/
>>
>> Naman Jain (4):
>>    x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
>>    x86/irq: Fall back to irq_chip_retrigger_hierarchy() in fixup_irqs()
>>    x86/irq: Fall back to irq_chip_retrigger_hierarchy() in
>>      msi_set_affinity()
>>    x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
>>      inits
>>
> 
> I checked linux-next next-20260911. This series has not been applied.
> 
> This patch series needs to be applied in one go, since patch 4 depends
> on patch 1.
> 
> I'm fine with carrying this through the hyperv-fixes tree, or let it go
> through the x86 tree. Just let me know.
> 
> Thanks,
> Wei

Hi Wei,
There was some active discussion happening on v2 of this series which 
has been concluded now. It will bring minor changes. I'll send v5 now, 
and you or Thomas can pick those changes as per your convenience.

Regards,
Naman

Ref: https://lore.kernel.org/all/87y0d6xpan.ffs@fw13/

