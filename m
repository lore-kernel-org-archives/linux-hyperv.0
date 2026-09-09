Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1037A822;
	Wed,  9 Sep 2026 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949472; cv=none; b=KwdHuUG50h9zgbBL8PD64TIGqaJUfgzunGs1UYM0F8oyyp8W1JtIrtWtMDtGX3fzLBsx+LR17Zm+Gt8fYBX9ntPmgHeI260z3/9yL2wZdNeFQYPoxiYiHJFNQJ/65ZkSTqeCG5wp42d6nFLzhOI3apjkcDr3iqGxwEXdCCf6GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949472; c=relaxed/simple;
	bh=I8Onle8fDcB2jJH/6ZCRLaXNOxUd6QuB/0FGJ6RuK6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dc1i56k62MYBQdjz9mkoY12znDIV/GpMiAcUvJ6EdbTw2NqUCX0bo9fVwJ27jXkeGPQ15nupPYxYzoKc800tlCvcCGTdnQg5BkJClV0jSo7tCjH8inZoLv/6YIO58Nc0VLdKvDTUO1KygcHiyI8M8AkbYeAWBWkfVMNWaJR3iFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLovTtU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLovTtU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6FF1F00A3A;
	Wed,  9 Sep 2026 10:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949471;
	bh=gbV02tkIR0l5+u0XIgUNoM3WdEsWs96K0HwU9kLHxWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JLovTtU8ApoMQpMX5pDtVyhtOFv/Glvm3zMo8dcpf76G+RSWmHoiTBS3WRw4ShQkv
	 Yt93feqcMS9bZwLHeqwYNTe76OrQ7Aj2jzuHo5zKdYiaWck4KRJ2KHT3oyb5vg7b71
	 pO0FLMvr7AXwYeOKjIi0rL7iF4aEACVceVIlRioRQfFOK+FLTUELHwjNCTU8HDFBNS
	 hujPHhJcpkYem4MSeRlW7bRb7H5iqNEErxtpIWq/1wk+EGRpe2WfbCCqqWT51sMfU+
	 BzNINXI3vSeWDj2A/I24P6C4F5tEyoUNJvf+XkYGjwalWmMO5inCt+1seGL53F+oWz
	 j5pG+i3gSZ6Jg==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, iommu@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
In-Reply-To: <20260810090716.2325295-4-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com>
Date: Wed, 09 Sep 2026 12:24:28 +0200
Message-ID: <875x0e204j.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 10 2026 at 09:07, Naman Jain wrote:
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
>  	 * IRR.
>  	 */
>  	if (lapic_vector_set_in_irr(cfg->vector))
> -		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
> +		irq_chip_retrigger_hierarchy(irqd);

That's broken because irqd points at the vector domain already, so there
is no parent and nothing gets retriggered.

Let's look at the hierarchy when interrupt remapping is enabled:

             | --- [DMAR]
[VECTOR] --- |                | -- [IOAPIC]
             | --- [REMAP] ---| -- [HPET]
                              | -- [DEVICE MSI]

All outer domains have .irq_set_affinity = msi_domain_set_affinity,
which does:

msi_domain_set_affinity(irqdata, ....)

    irqdata->parent->irq_set_affinity(irqdata->parent, ....);
    
In that case msi_set_affinity() is only reachable for the DMAR domain
and all others (IOAPIC, HPET, DEVICE MSI) end up in the REMAP domain
which handles irq_set_affinity and never ends up in the above code.

In the non-remapping case:

             | -- [IOAPIC]
[VECTOR] --- | -- [HPET]
             | -- [DEVICE MSI]

In this case the vector domain is the MSI parent domain for all of them
and all outer domains will end up in msi_set_affinity() via
msi_domain_set_affinity().

In any case 'irqd' in msi_set_affinity() will always point to the vector
domain and therefore the exiting code is correct and can't be changed to
retrigger hierarchy as that would see irqd->parent == NULL and do
nothing. Neither will adding a conditional there do anything useful
because the vector domain always has the retrigger callback set.

Thanks,

        tglx
