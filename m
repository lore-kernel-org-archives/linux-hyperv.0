Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C034EFFCA;
	Thu, 15 Oct 2026 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792104433; cv=none; b=DgbkAkbduuku9CJ4UdeXlsK5SsVmLNXWjhP2GlrVK5D5R25glp/LJIINhsTnDTon0dJ+nHlbfF5rfgpSwohCYTSoU4lkaJ833Bwpw8OizazxobtIzOoDG4BBKOJLbBlRYLwcnB0A0x8sFJ15wp/xtEDI11PHtAEQvODlmDB/wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792104433; c=relaxed/simple;
	bh=7VzyWhS0yiLiqhjJozM7MK0XGplhJcLRtNB0AJdHGWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e4X2ICgc3jZsjchJ9F6dk9Dnt2LiKek0pfz4gIUGSLix4HNHkG+Qnwp4GQurG1aBSulLYNkdCNcUIA1JQUfeUv2FHH+1RJC9SaY+XoTjf2cSyss6v1X48Z49nJowQMTqCMVtFbHKzJugxxNsplycOJouvY8IqAGOFz2yaXpscPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frWiSVJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frWiSVJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECA71F000C4;
	Thu, 15 Oct 2026 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792104430;
	bh=EgeZyXP6AssGk+9sGtqMIvSOTxvKxWy2gMJ2hGDgcKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=frWiSVJbt5aOK3+VC3/gyLircFrCXy1DAds2Xhs+iV5Ou6U8yfAECWUEb0qMVlist
	 s+eyeHlp15yeTc0FhC5AsaRs3gtsCLfKnomPMDRwSSfo0fhQlW/gdnyeT1Fkru1gGf
	 OGlpHpwb+vP9s5vkGrblUGuX8dK6AxLsi5Ri3JWxk+HPnfNM2SPsZNmFP2uOnK0V21
	 9guIyf0rfunb7t/7gDnto0X//aJDrnaBCbx7imox00jv1ADS11buBhYhf3c6W+Qky/
	 elHFGyjbcLdxdJ+hpQp1st6477Xa+oGpvBEUHrDo7t5pQIEgAdc/BK3QmNTAwkvjlW
	 KTTP50YYAP3NA==
Date: Thu, 15 Oct 2026 17:47:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v6 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Message-ID: <20261015224708.GA1810637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923043023.3150498-5-namjain@linux.microsoft.com>

On Wed, Sep 23, 2026 at 04:30:23AM +0000, Naman Jain wrote:
> With fixup_irqs() and msi_set_affinity() now using
> irq_chip_retrigger_hierarchy(), the outermost domain chips no longer need
> the helper as their irq_retrigger() callback. The generic resend path
> already uses the hierarchy helper.
> 
> The hierarchy walk reaches the x86 vector domain's apic_retrigger_irq() for
> all of these stacked domain chips.
> 
> Remove the now redundant irq_retrigger() initializations from the outermost
> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
> 
> No functional change intended.
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-hyperv.c

> ---
>  arch/x86/hyperv/irqdomain.c         | 1 -
>  arch/x86/kernel/apic/io_apic.c      | 2 --
>  arch/x86/kernel/apic/msi.c          | 2 --
>  arch/x86/kernel/hpet.c              | 1 -
>  drivers/iommu/amd/init.c            | 1 -
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  6 files changed, 8 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 6d790636c8b95..b3ad50a874dca 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -316,7 +316,6 @@ static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  		return false;
>  
>  	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>  
>  	info->ops->msi_prepare = pci_msi_prepare;
>  
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 7d7175d012288..18f49a251f23b 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1857,7 +1857,6 @@ static struct irq_chip ioapic_chip __read_mostly = {
>  	.irq_ack		= irq_chip_ack_parent,
>  	.irq_eoi		= ioapic_ack_level,
>  	.irq_set_affinity	= ioapic_set_affinity,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
>  	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
> @@ -1871,7 +1870,6 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
>  	.irq_ack		= irq_chip_ack_parent,
>  	.irq_eoi		= ioapic_ir_ack_level,
>  	.irq_set_affinity	= ioapic_set_affinity,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
>  	.flags			= IRQCHIP_SKIP_SET_WAKE |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 9160227b9b32a..aad2f15eb2176 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -246,7 +246,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  	info->ops->msi_prepare		= x86_msi_prepare;
>  
>  	info->chip->irq_ack		= irq_chip_ack_parent;
> -	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
>  	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
>  					   IRQCHIP_AFFINITY_PRE_STARTUP;
>  
> @@ -313,7 +312,6 @@ static struct irq_chip dmar_msi_controller = {
>  	.irq_mask		= dmar_msi_mask,
>  	.irq_ack		= irq_chip_ack_parent,
>  	.irq_set_affinity	= msi_domain_set_affinity,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	= dmar_msi_compose_msg,
>  	.irq_write_msi_msg	= dmar_msi_write_msg,
>  	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 8dc7b710e1250..2bb7a6f466af3 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -509,7 +509,6 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
>  	.irq_mask = hpet_msi_mask,
>  	.irq_ack = irq_chip_ack_parent,
>  	.irq_set_affinity = msi_domain_set_affinity,
> -	.irq_retrigger = irq_chip_retrigger_hierarchy,
>  	.irq_write_msi_msg = hpet_msi_write_msg,
>  	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
>  };
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa3704..0d22324568911 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2477,7 +2477,6 @@ static struct irq_chip intcapxt_controller = {
>  	.irq_unmask		= intcapxt_unmask_irq,
>  	.irq_mask		= intcapxt_mask_irq,
>  	.irq_ack		= irq_chip_ack_parent,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_set_affinity       = intcapxt_set_affinity,
>  	.irq_set_wake		= intcapxt_set_wake,
>  	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 056d379b3cee4..a004b08d68fe9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>  	info->ops->msi_prepare = hv_msi_prepare;
>  
>  	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>  
>  	if (IS_ENABLED(CONFIG_X86))
>  		chip->flags |= IRQCHIP_MOVE_DEFERRED;
> -- 
> 2.43.0
> 
