Return-Path: <SRS0=qkuJ=CF=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E0C433DF
	for <linux-hyperv@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A8A2054F
	for <linux-hyperv@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgH0O63 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:58:29 -0400
Received: from 8bytes.org ([81.169.241.247]:39646 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgH0O5q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 10:57:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 72FEB2D5; Thu, 27 Aug 2020 16:57:37 +0200 (CEST)
Date:   Thu, 27 Aug 2020 16:57:36 +0200
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
Subject: Re: [patch V2 01/46] iommu/amd: Prevent NULL pointer dereference
Message-ID: <20200827145735.GI3319@8bytes.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112330.683298931@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826112330.683298931@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:29PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Dereferencing irq_data before checking it for NULL is suboptimal.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>

