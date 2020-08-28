Return-Path: <SRS0=bk72=CG=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13EC433E6
	for <linux-hyperv@archiver.kernel.org>; Fri, 28 Aug 2020 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6BF20848
	for <linux-hyperv@archiver.kernel.org>; Fri, 28 Aug 2020 11:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgH1LmE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgH1Llp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 07:41:45 -0400
X-Greylist: delayed 74641 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Aug 2020 04:41:43 PDT
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D298C061264;
        Fri, 28 Aug 2020 04:41:43 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B73AF2E1; Fri, 28 Aug 2020 13:41:37 +0200 (CEST)
Date:   Fri, 28 Aug 2020 13:41:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200828114131.GA13881@8bytes.org>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)
> based devices in a halfways architecture independent way.
> 
> The first version can be found here:
> 
>     https://lore.kernel.org/r/20200821002424.119492231@linutronix.de
> 
> It's still a mixed bag of bug fixes, cleanups and general improvements
> which are worthwhile independent of device MSI.
> 
> There are quite a bunch of issues to solve:
> 
>   - X86 does not use the device::msi_domain pointer for historical reasons
>     and due to XEN, which makes it impossible to create an architecture
>     agnostic device MSI infrastructure.
> 
>   - X86 has it's own msi_alloc_info data type which is pointlessly
>     different from the generic version and does not allow to share code.
> 
>   - The logic of composing MSI messages in an hierarchy is busted at the
>     core level and of course some (x86) drivers depend on that.
> 
>   - A few minor shortcomings as usual
> 
> This series addresses that in several steps:

For all IOMMU changes:

	Acked-by: Joerg Roedel <jroedel@suse.de>

