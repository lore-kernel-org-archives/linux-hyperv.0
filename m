Return-Path: <SRS0=3U3y=CD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC411C433E1
	for <linux-hyperv@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670152075F
	for <linux-hyperv@archiver.kernel.org>; Tue, 25 Aug 2020 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598387063;
	bh=ySOkd6aDLwyhEWNu5XId2t2Myh+7GbuDeWGuL4FyNs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=FvFnvBPkC7iRpENrQvkM7P5I7nXFKfZJ89QHOF6vtSCE7/uTO5aQZjh1j7tCYa8ZF
	 2/tmV1bHvUUahkOEX5XSb+E08gU9bGP1X2rkKp6AHZH+uO4ZZno82SXzkHuCJ12dR5
	 ZvA5g4BkXWLCubM46rrpQ1yMFfHlsKEAD42N0ejk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYUYW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYUYV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 16:24:21 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A772074D;
        Tue, 25 Aug 2020 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598387060;
        bh=ySOkd6aDLwyhEWNu5XId2t2Myh+7GbuDeWGuL4FyNs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E5SctpDfmJVH3GOS41BdxD1KAKCCgLGp5cRY/d4s5Iaw4NV/9UXP/0IZXYISEg/D5
         7jTqAEVySonTUr8pSMzETXyOu0kEsTuPgpG2nWnP9vXaG+N4MEWZk+TCj7M2xX2ukA
         qdRiLK425Y+fBMqVUhac3FmUSyR6dzlO73HmofKg=
Date:   Tue, 25 Aug 2020 15:24:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI
 MSI
Message-ID: <20200825202419.GA1925250@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821002948.664301259@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 02:24:58AM +0200, Thomas Gleixner wrote:
> Rename it to x86_msi_prepare() and handle the allocation type setup
> depending on the device type.

I see what you're doing, but the subject reads a little strangely
("pci_msi_prepare() handling non-PCI" stuff) since it doesn't mention
the rename.  Maybe not practical or worthwhile to split into a rename
+ make generic, I dunno.

> Add a new arch_msi_prepare define which will be utilized by the upcoming
> device MSI support. Define it to NULL if not provided by an architecture in
> the generic MSI header.
> 
> One arch specific function for MSI support is truly enough.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org
> ---
>  arch/x86/include/asm/msi.h          |    4 +++-
>  arch/x86/kernel/apic/msi.c          |   27 ++++++++++++++++++++-------
>  drivers/pci/controller/pci-hyperv.c |    2 +-
>  include/linux/msi.h                 |    4 ++++
>  4 files changed, 28 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/include/asm/msi.h
> +++ b/arch/x86/include/asm/msi.h
> @@ -6,7 +6,9 @@
>  
>  typedef struct irq_alloc_info msi_alloc_info_t;
>  
> -int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> +int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  		    msi_alloc_info_t *arg);
>  
> +#define arch_msi_prepare		x86_msi_prepare
> +
>  #endif /* _ASM_X86_MSI_H */
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -182,26 +182,39 @@ static struct irq_chip pci_msi_controlle
>  	.flags			= IRQCHIP_SKIP_SET_WAKE,
>  };
>  
> -int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> -		    msi_alloc_info_t *arg)
> +static void pci_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct msi_desc *desc = first_pci_msi_entry(pdev);
> +	struct msi_desc *desc = first_msi_entry(dev);
>  
> -	init_irq_alloc_info(arg, NULL);
>  	if (desc->msi_attrib.is_msix) {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
>  	} else {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
>  		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
>  	}
> +}
> +
> +static void dev_msi_prepare(struct device *dev, msi_alloc_info_t *arg)
> +{
> +	arg->type = X86_IRQ_ALLOC_TYPE_DEV_MSI;
> +}
> +
> +int x86_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
> +		    msi_alloc_info_t *arg)
> +{
> +	init_irq_alloc_info(arg, NULL);
> +
> +	if (dev_is_pci(dev))
> +		pci_msi_prepare(dev, arg);
> +	else
> +		dev_msi_prepare(dev, arg);
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_msi_prepare);
> +EXPORT_SYMBOL_GPL(x86_msi_prepare);
>  
>  static struct msi_domain_ops pci_msi_domain_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= x86_msi_prepare,
>  };
>  
>  static struct msi_domain_info pci_msi_domain_info = {
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1532,7 +1532,7 @@ static struct irq_chip hv_msi_irq_chip =
>  };
>  
>  static struct msi_domain_ops hv_msi_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= arch_msi_prepare,
>  	.msi_free	= hv_msi_free,
>  };
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -430,4 +430,8 @@ static inline struct irq_domain *pci_msi
>  }
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
>  
> +#ifndef arch_msi_prepare
> +# define arch_msi_prepare	NULL
> +#endif
> +
>  #endif /* LINUX_MSI_H */
> 
