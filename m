Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FA3EF67D;
	Thu, 15 Oct 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055411; cv=none; b=DSjpvJuYSudmZVtrKV6cQnhXFgf3MO85lLP9wlnKc2g7eupZFnM9gTQE88nGO4xX1DHGnMRon3VZPcdTclD6Xp+NS7l4POwg/Gt8ftrfLmvpi4CDaRnnSUYKblKLhymmPUKtWxL91mnuwklF12iajspX1QpP4X0p/Pangdkoce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055411; c=relaxed/simple;
	bh=qbPT3vKmnaI+U1z729U2LoQwg0qtNLYje1pulpSivYk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHWFS9SHG+tjH1cgGqKVQK24lKCqjUxRyW8KNncSXm9tagqE5W2kzSyP2wLrQ9qvcIWr9wyowpYNxH87d5nEE0sLe3SKPUYKlj+n3pvkyy8YKdbWQm4rRVSFU3Utu4MGoDTIUNRjFeMVHovnkp9IREbOEisEjk6mgnEQ2RNfbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AawnaJ4I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AawnaJ4I"
Received: from [10.95.64.106] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id A639120B7166;
	Thu, 15 Oct 2026 02:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A639120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792055405;
	bh=7ZvitbVIHx4genvaOzk0rR3WfZKmeRXiVirIb0psHlU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AawnaJ4IjGtG8X+AJ0H3qpVpiCtWFQzQCs1HCf9BkxyP8vQoU5D8ierMAr/05YWuk
	 ZmRmSvdbWN5PhkJKuaOwrqbcg8zbip9lpbbtlozuc/pPhzG7wGDJHuJfWtye+UYMsU
	 uL2XH18rxyBhHi4I4D4G1bSERbRGZ6U5fRCGjyOc=
Message-ID: <cb24da4f-fd1e-478d-8924-5d047b904336@linux.microsoft.com>
Date: Thu, 15 Oct 2026 14:39:57 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Wei Liu <wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
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
 Daniel J Blueman <daniel@quora.org>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260923043023.3150498-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/2026 10:00 AM, Naman Jain wrote:
> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
> callback. The Hyper-V root partition PCI/MSI irqchip lost that callback
> when it was converted to msi_create_parent_irq_domain(), so such a
> pending interrupt is silently dropped, leading to lost interrupts, stalls
> and "No irq handler for vector" messages.
> 
> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that restores
> irq_chip_retrigger_hierarchy() on the Hyper-V root partition PCI/MSI chip.
> The equivalent guest pci-hyperv.c fix from the previous version is already
> merged, so it is dropped here.
> 
> Patch 2 then switches fixup_irqs() to call irq_chip_retrigger_hierarchy()
> directly which ensures that this issue does not occur for chips that
> miss adding this initialization.
> 
> Patch 3 makes a similar change in msi_set_affinity()
> 
> Patch 4 then drops the now-redundant irq_retrigger() initializations.
> This way, patch 2-4 do not need to be backported.
> 

Hi Thomas, maintainers,
Gentle ping on this patch series. Please let me know if this is good to 
be picked in next merge cycle or if any changes are needed from my side.

Regards,
Naman
