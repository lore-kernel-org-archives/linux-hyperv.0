Return-Path: <SRS0=8lvP=B7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9D1C433E1
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6DE2075E
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiLeH5k1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXln3vkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHUCRD (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:17:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHUCQ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:56 -0400
Message-Id: <20200821002946.594509001@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=F0DCbonLQEL0D8Df9OCMfcJxjv/hy8xJtmzGkTlqTvs=;
        b=FiLeH5k11k/JQk52LH07+Ha7hk2n6XQvR9iMpdcvrX0tGljFYc9Qi7o0vZeoI2pUpr7GAQ
        gWARnz+Dyy0o3UBEGQr7w05ek4rV/jDbOjy9VUToJ3LYHQk6KxCN+kV2Z5XvNluJsq3ZQJ
        Ux4MZW6mDOuO0i5C+v696sSuJt9PUm1WyLWZFnLnChKRx7Ml9Gc11Q+UPrRLV1BSljsAu8
        MFMNC756vte58E3bXdW0eBuOu1wEsLayoglkGDRvYc1qTKxi3JMTcMQaUH4uAHrFmwyU76
        cwolBKYJBVyvOzB7TinHMZvwR2GuMsDX8+KplK43DzRvVoVZFiWeBehrxcNVLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=F0DCbonLQEL0D8Df9OCMfcJxjv/hy8xJtmzGkTlqTvs=;
        b=vXln3vkM6Fevc/JOETlWU1DSFXrQ25Mc+B9Hb6i6fwkV0etAyK5QBWjFXhdiu4LrVkOWQu
        2f7XTKsxazS0bBCA==
Date:   Fri, 21 Aug 2020 02:24:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
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
        Jonathan Derrick <jonathan.derrick@intel.com>,
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
Subject: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="PCI--MSI--Rework-pci_msi_domain_calc_hwirq--.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Retrieve the PCI device from the msi descriptor instead of doing so at the
call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/kernel/apic/msi.c |    2 +-
 drivers/pci/msi.c          |   13 ++++++-------
 include/linux/msi.h        |    3 +--
 3 files changed, 8 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
-	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
+	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1346,17 +1346,17 @@ void pci_msi_domain_write_msg(struct irq
 
 /**
  * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @dev:	Pointer to the PCI device
  * @desc:	Pointer to the MSI descriptor
  *
  * The ID number is only used within the irqdomain.
  */
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc)
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
+	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
+
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
-		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		pci_dev_id(pdev) << 11 |
+		(pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
 }
 
 static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
@@ -1406,8 +1406,7 @@ static void pci_msi_domain_set_desc(msi_
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
-					       desc);
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
 #else
 #define pci_msi_domain_set_desc		NULL
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -369,8 +369,7 @@ void pci_msi_domain_write_msg(struct irq
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc);
+irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);

