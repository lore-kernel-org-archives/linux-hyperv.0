Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A021CA03;
	Mon, 24 Aug 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530671; cv=none; b=W9XWdKhbrwSv7T7zhpBl3I7Rs82uMbfF4hIFKy0NfNEbuhvK+vUyNOWgcxWCkUD6AwOd6bVbHjaaJNDM8lFl/rv8ISd4iy454tHb18cFqyHlsPn+c0CoRSg6hYF27rwvdClN8kH/OmdEccgvgxFTzhBRS9F1SfI/o3DTpmCWMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530671; c=relaxed/simple;
	bh=BtY40Kg/GLDsSSKKNh6oGg1tg/2npmL6pBFdFzoxIWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAEO12iP7kHOcuPIbKxqv9mdmA88T5vzpBddULpIwgF8hjvze2yCYvolCq/SH3p2NJykDGEWtiIJJ7d+/jVsQyOwfgQXV7slRz+uICUutaQ6x6X408bvbqUUrGgMTCR2kyUKd3JdMtt2kH501UAbP9yX+ycR1M0m7xbBxOnV1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo+e93B0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo+e93B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1788B1F000E9;
	Mon, 24 Aug 2026 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530669;
	bh=JXHLqnpy5FRwrCT7OCsFLqokuLrj12X7U3QZX2dJJzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oo+e93B0kNCXMLZootgv/CEtD1049HiSySlJyyOcZ9/G+/I2QXps6wt+1mTrORktk
	 M57jlWKEhENIMfjegJj3B3KIhopZ5ZrFttI5zB8bZN49Il/qnZ+UmG4E6wVOmtaaH0
	 8wEYGJhbZENHnn/W8SX3e35Othhnl1avBONJk/TT18q3mDbTjMKWBHIHmBg8ziS4fo
	 POHQx6icbEbwgcNdlAIZKmzBeeyyDmd7F4ZaQs7lqi8cg3nm7BGCywOTNXVBd6IOPu
	 R9mhOyJiYLSlJccb1MFE8usET+6hbbAqN1RgAgoUTdN+ztVBLIRjIhwXuhBodI1W8a
	 G6hTFCSWtDEDQ==
Date: Sun, 23 Aug 2026 17:17:47 -0700
From: Wei Liu <wei.liu@kernel.org>
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
Subject: Re: [PATCH 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Message-ID: <20260824001747.GE3566091@liuwe-devbox-debian-v2.local>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-4-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728135117.2888175-4-namjain@linux.microsoft.com>

On Tue, Jul 28, 2026 at 01:51:17PM +0000, Naman Jain wrote:
[...]
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ea3377e61aa5c..0c362e86a09d9 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2468,7 +2468,6 @@ static struct irq_chip intcapxt_controller = {
>  	.irq_unmask		= intcapxt_unmask_irq,
>  	.irq_mask		= intcapxt_mask_irq,
>  	.irq_ack		= irq_chip_ack_parent,
> -	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_set_affinity       = intcapxt_set_affinity,
>  	.irq_set_wake		= intcapxt_set_wake,
>  	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 89816a2bd7cd3..cfc8fa403dad6 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
>  	info->ops->msi_prepare = hv_msi_prepare;
>  
>  	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> -	chip->irq_retrigger = irq_chip_retrigger_hierarchy;

Acked-by: Wei Liu <wei.liu@kernel.org>.

I suppose you do this because the first patch is supposed to be
backported.

Wei
