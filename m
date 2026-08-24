Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53961A9F83;
	Mon, 24 Aug 2026 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530951; cv=none; b=JtnqPTE1gHBy0nOOopxlExb3mKOGoMrC2cXuL+GpVGy3opVqPGT9kpmxQzfTFY/Wyb81+eqRi1/qnZF0RmkeFjO5+lgrQPLG81l74kwZ7zceYXsqaNod4U00sq5Xa8BcgbsHJrZWHcB9PIGxiXMUCAU+hBKik5Qw6AoxJNXSUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530951; c=relaxed/simple;
	bh=dV3R+Pz5kQ5h6ZlLsF1aWhISVPB4UEergia3lJpO3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnWziQm3tUo8jPWfbzPC7eEI8N/Hk8a2XFzagI6pJnBx9UFuMTFQAAiCoYuSIeMLBg6bYPstTjzasidJwL+duN7tTq59GlxOgLWGtwfE/p7TLa0+zHWxy+EBT4zYBDj5D8LBd6+N8Cj69lXR2dEiRRxne+Jf/fMXR/5VQFF29Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjXgM4Jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjXgM4Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329A31F000E9;
	Mon, 24 Aug 2026 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530949;
	bh=6i8J1ynUdc4pHe6Njdru111x+LUNyRVLA355H1iwvLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cjXgM4JgpYFLPIXhx97eXNxmxm5azf3IMVW47mC18tA/3TmtKyO5alSfBE+tX03pH
	 M0Dt8Y/P2n8xYMmch9fOeJbtBLw0fjf9YEI5w5/U0vcFDhRoJlu9FJuwKfb4t9Z/Qn
	 AKf5ITcD7G9plTrE3fkCFEPK39ZgxN62WxQl6N58AtlbGg/icf0j+I6mR6g/T8zEPX
	 NTt3Yw0fcTp9esSIi+PscCaAR/7qk7W5gfB0M+pEuM2r9rSIX4aTpX2SETJ2Yf+ROV
	 fD41yjdxEMfWCcgxq/ndRR1WJckPQQMGFhS9w+sb0o1kfRtNfQ8+ctdPnqJ4K9zdEK
	 kTjerB1zXxY5w==
Date: Sun, 23 Aug 2026 17:22:28 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: hv: Set irq_retrigger callback for the
 Hyper-V PCI MSI irqchip
Message-ID: <20260824002228.GF3566091@liuwe-devbox-debian-v2.local>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810090716.2325295-2-namjain@linux.microsoft.com>

On Mon, Aug 10, 2026 at 09:07:13AM +0000, Naman Jain wrote:
> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
> 
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. If an interrupt still has its pending bit
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
> new target through the irqchip's irq_retrigger() callback. As the Hyper-V
> PCI/MSI chip does not provide that callback, the pending interrupt is
> silently dropped, which can result in lost interrupts, stalls and "No irq
> handler for vector" messages during CPU hotplug.
> 
> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
> the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on its
> new target CPU via the parent x86 vector domain.
> 
> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Cc: stable@vger.kernel.org
> Suggested-by: Long Li <longli@microsoft.com>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

I applied this patch alone. It is a good bug fix. The rest still have
opens.

Wei

> ---
>  drivers/pci/controller/pci-hyperv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index cfc8fa403dad6..89816a2bd7cd3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>  	info->ops->msi_prepare = hv_msi_prepare;
>  
>  	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> +	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>  
>  	if (IS_ENABLED(CONFIG_X86))
>  		chip->flags |= IRQCHIP_MOVE_DEFERRED;
> -- 
> 2.43.0
> 
