Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4EC433E3
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4E720786
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7xv50AT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YlpLIMOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgHZMJU (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:09:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgHZMBo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:44 -0400
Message-Id: <20200826112334.400700807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XS2OtPL63+BbeAwrgOvQZ62jjX8dKd2NUee/RefW/jE=;
        b=g7xv50ATWyf0Y9KZtfd5GDP7gv+ub4Reyp3zzVcltJZHJTLFQiFFXZP+cdXkZqtXlfvIpG
        tdDcnRDMiB+NAD5pfoxdVPRDMENd5IGhIAds5207sNs7ZFUbnwlncbC9MFo6M3VyfOi/E2
        sTAtg0h0YKOOz9nDA3vW1m6MWO8ZCD3zzYaI7xVc9jcBd/G5iYloQEx+PRC6EaWAe2KhaK
        owm1ZICVZYAXvrQzrjTMUaGTpQ4IZGqclzgFWEqg5L8qaWofCWb0s81fNwQhQPAj02rxjV
        cyoLMosaH14iqtGJnoLcXp3hzvcc4rpt7+YOBBmYbBg+vQie4RgCA7KB9JgMBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XS2OtPL63+BbeAwrgOvQZ62jjX8dKd2NUee/RefW/jE=;
        b=YlpLIMOqrorOG1iP3fEgl8h8huJ+SEm1UgkOPUBIUHdgsvpjhvsDnVL85p8wf3l/OswF4l
        3rF6X4dWCwWuIwAQ==
Date:   Wed, 26 Aug 2020 13:17:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
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
Subject: [patch V2 38/46] iommu/amd: Remove domain search for PCI/MSI
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now that the domain can be retrieved through device::msi_domain the domain
search for PCI_MSI[X] is not longer required. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/iommu/amd/iommu.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3548,9 +3548,6 @@ static struct irq_domain *get_irq_domain
 	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return iommu->ir_domain;
-	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
-	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return iommu->msi_domain;
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;

