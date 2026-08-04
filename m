Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1768340A6B;
	Tue,  4 Aug 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845818; cv=none; b=Pki3PhKSiAx0em1pwo1PZZc1UX0AI6e390BEqyAVE8gRMnLOZtziwEx3rcSDtMsK/TNVDQUQvreq3rYO2Is7bOkMoCse4OEMYV7MJy5EONaAXkmGfTnc59ez0XipgmO6MSXOBWsx3QYIfJd0xSLRJUYM7HLsTiSGlltWXPojdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845818; c=relaxed/simple;
	bh=B6/WRddiaYtxSye2QXK20TGfRHU0iPsemPBwQ0yTEdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzenQeRczw5AIlT+8byg7kUm+1arXmwPP4HwKnwo4LB+iZxTtDO8J3hBdnQysYD9jIkwbvzHkIL4aF6xd8/3d3KhWnxtukTuUkr2HRHpwoxcaidkz4JJYi6gKpU9baH2MmZ3CPpIQssfxYH36uCEHntZasUPgKvwk4VbNvhKDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j3Zdtqsj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j3Zdtqsj"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8155120B7168; Tue,  4 Aug 2026 05:16:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8155120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785845796;
	bh=aTqXnV7ZBoFAQTtt7IICjqfQNaAMMc/7wWeZF7s6F8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3ZdtqsjxFxsinSa0gq66Hbv5nOsVFaN/IkBlbFVrNI7CmSYLoxsWWW4VtbEU7vtj
	 2to0kxeiA1Sy25zsRX2edmwbxGxuuHSM/AWyEohK6DPUp9A/WUU2Lwxka/DQFNyY/6
	 dCzACpgmVEp9U7CpC1qPcp/3ZrojV3+ou9fE3lhE=
Date: Tue, 4 Aug 2026 05:16:36 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Jake Oshins <jakeo@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug for
 Hyper-V PCI/MSI
Message-ID: <anHYJEeHlszuj/38@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728135117.2888175-1-namjain@linux.microsoft.com>

On Tue, Jul 28, 2026 at 01:51:14PM +0000, Naman Jain wrote:
> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
> callback. The Hyper-V vPCI MSI irqchip never installs one, so such a
> pending interrupt is silently dropped, leading to lost interrupts, stalls
> and "No irq handler for vector" messages.
> 
> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that installs
> irq_chip_retrigger_hierarchy() on the Hyper-V PCI/MSI chip. Patch 2 then
> switches fixup_irqs() to call irq_chip_retrigger_hierarchy() directly, so
> the retrigger works for any stacked irqchip without a per-chip callback.
> Patch 3 drops the now-redundant irq_retrigger() initializations.
> This way, patch 2 and 3 do not need to be backported.

Thanks Naman, the series looks good to me.

I just have a small nit. In the old code, VECTOR_RETRIGGERED is set
unconditionally after calling chip->irq_retrigger(), regardless of its
return value. In the new code, VECTOR_RETRIGGERED is only set when
irq_chip_retrigger_hierarchy() returns non-zero. So retrigger failures
would now result in VECTOR_UNUSED instead of VECTOR_RETRIGGERED.

In practice this doesn't matter since apic_retrigger_irq() always returns
1, but it is technically a behavior change and I think it is a correct
one. Just that it might be worth noting this in the commit message to
avoid confusion.

Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

> 
> The series follows the original RFC:
> Link: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/
> 
> Naman Jain (3):
>   PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
>   x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
>   x86/irq, iommu/amd, PCI: Drop redundant irq_retrigger inits
> 
>  arch/x86/kernel/apic/io_apic.c |  2 --
>  arch/x86/kernel/apic/msi.c     |  4 +---
>  arch/x86/kernel/hpet.c         |  1 -
>  arch/x86/kernel/irq.c          | 23 +++++++----------------
>  drivers/iommu/amd/init.c       |  1 -
>  5 files changed, 8 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
> -- 
> 2.43.0
> 
