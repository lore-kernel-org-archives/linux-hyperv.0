Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62946C433E3
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426022071E
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXkpbg7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="76R9Kmzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgHZMLN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:11:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57538 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgHZMBd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:33 -0400
Message-Id: <20200826112333.047315047@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gJ39OSf8ktRSnZ6d/j2dt7j1z3jbrcZeNgc5pz/l+zo=;
        b=bXkpbg7vXId4cgEooAI1FievWWwmsWknAPlKYWOt0b+qx11d6yLu/cHswt1gghrWpZ0y4p
        OogEoTISMfdsGaFQxwDXrjdAYV7fpbl7lvN/Pd44ye1NPulELZ2AqG1QXNidbTS8fOA5sL
        dE3Y8y7zSGoykO/A2Y22PidwXvE2JmTcJZeBM4X/WVvRopmoxh4QM75ngWUvhGD6Z5gADH
        gci/2TvWnj96j4gOq2pSHxN+ruog7JhGi9PrN4oUyN6tdWzBYuXFlgatiELb5NOVmhIxLT
        pZSsmjLUAlQLuIYIzZR1g1BAjfSl89NRHKJ81TQT0IphVjr1Ly4j2bBA/Y6TTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gJ39OSf8ktRSnZ6d/j2dt7j1z3jbrcZeNgc5pz/l+zo=;
        b=76R9KmznGw62pNG68AAqA66n9MVIAIb93ShPM0bCT14jdPK4KCpjLcWq25+24lkdJtIMrv
        D9oyizCmcUVt66Dg==
Date:   Wed, 26 Aug 2020 13:16:52 +0200
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
Subject: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Devices on the VMD bus use their own MSI irq domain, but it is not
distinguishable from regular PCI/MSI irq domains. This is required
to exclude VMD devices from getting the irq domain pointer set by
interrupt remapping.

Override the default bus token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/vmd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
 		return -ENODEV;
 	}
 
+	/*
+	 * Override the irq domain bus token so the domain can be distinguished
+	 * from a regular PCI/MSI domain.
+	 */
+	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);


