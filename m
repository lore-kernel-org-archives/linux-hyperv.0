Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6117A586;
	Sun, 13 Sep 2026 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339725; cv=none; b=riyrk6LdP84x5E5Eopo0byET7/tSiya3ePog3oQrz+PXIUEfrM2qcd2DzZ+D6vllI6cwkqCmDlPAkL6HLqztL609B8qno2BR1XvCtg/UYtJxbw8w4bdzlikzD/C1fajVEgoAn22iJBayWiO88SKFTOAceAU7XwsMZyX993h47W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339725; c=relaxed/simple;
	bh=6tpr5g9elJ/5OKQCWL95r11WMokZFrGmfKvXYz3Na6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyUbEpntKjvkYu5enPh9a1GM1/1ufsYbXusrNfySPFAlaMven0xSK2MSeDYcEl81QjhQM3qU4/jXlyH3S5x57jlvZ5BRmssZ83c3UkcBcSMyljPSu1Oa/CS92QlDebr5vk4YyCrN3LAADar3XZ1prZ5tD9FyAkWhDSGM/Y7b/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyKLs/UJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyKLs/UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8DD1F000FF;
	Sun, 13 Sep 2026 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339724;
	bh=LtB91lj9cFpKoc/Ifduclkv803l69YmsYbW+o77eFps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RyKLs/UJCKPwUw0rHkcQwPJHwI7ji4he8jjDUNfsXOmxHkl6Eb46ghH54AYg9yhYj
	 1fEZxTPH8sRZ7YfN8Hw9zvNEfYv7QP0v/+p4NhQs0/SgTqJtTqj+/QCE1m73xCN0nR
	 RN1TZPW06AXOc8mSaHSudoL9tPfypsyLZ4I+FbZ/Q1k8VleOB+URz1Z0wg6apSt2RD
	 kH3CYJTs/IqzokIlNjMDtfcriSlEW9SvPxbnQfI8QLo0dn4lhgaUDTs64zp2cz3Tis
	 M08BOOkrjxEirtZWQOjQDg8nVgCAskjlp0Jg6S7b9b/dbzXe5imZjJiYS6qZsyhNYj
	 B/0eqok0WG5Fg==
Date: Sun, 13 Sep 2026 15:48:42 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Nam Cao <namcao@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin <d@ilvokhin.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Jiri Wiesner <jwiesner@suse.de>,
	Daniel J Blueman <daniel@quora.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
Message-ID: <20260913224842.GF2219269@liuwe-devbox-debian-v2.local>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909064448.1004-1-namjain@linux.microsoft.com>

On Wed, Sep 09, 2026 at 06:44:44AM +0000, Naman Jain wrote:
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
> Patch 2 then switches fixup_irqs() to have a fallback call to
> irq_chip_retrigger_hierarchy() directly, if a chip does not define
> irq_retrigger callback.
> 
> Patch 3 makes a similar change in msi_set_affinity()
> 
> Patch 4 then drops the now-redundant irq_retrigger() initializations.
> This way, patch 2-4 do not need to be backported.
> 
> Changes since v3:
> https://lore.kernel.org/all/20260907065129.269262-1-namjain@linux.microsoft.com/
> * Move irq_retrigger setting to hv_init_dev_msi_info() in patch 1
>   (Michael, Nam) 
> * Add if-else fallback check in msi_set_affinity() in patch 3 (Michael)
> * Break patch 3 into two separate patches, while *keeping review tags*.
> 
> Changes since v2:
> https://lore.kernel.org/all/20260810090716.2325295-1-namjain@linux.microsoft.com/
> * Add a backportable fix for Hyper-V root partition irqchip (Wei)
> * Add a check for custom irq_retrigger implementations and add direct
>   irq_chip_retrigger_hierarchy() calls as a fallback if it is not
>   defined by a chip. (Sashiko, Michael)
> * Removed local loop variable change, and continue using the irq_desc
>   accessor function (Michael)
> * Did not pick "Acked-by: Manivannan Sadhasivam" as it was on v1, and v3
>   is a functionally different to some extent, specially patch 2.
>   Requesting you to please review again.
> 
> Changes since v1:
> https://lore.kernel.org/all/20260728135117.2888175-1-namjain@linux.microsoft.com/#t
> * Added Review tags
> * Adding minor clarification in commit msg of patch 2 (Shradha)
> 
> Original RFC: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/
> 
> Naman Jain (4):
>   x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
>   x86/irq: Fall back to irq_chip_retrigger_hierarchy() in fixup_irqs()
>   x86/irq: Fall back to irq_chip_retrigger_hierarchy() in
>     msi_set_affinity()
>   x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
>     inits
> 

I checked linux-next next-20260911. This series has not been applied.

This patch series needs to be applied in one go, since patch 4 depends
on patch 1.

I'm fine with carrying this through the hyperv-fixes tree, or let it go
through the x86 tree. Just let me know.

Thanks,
Wei
