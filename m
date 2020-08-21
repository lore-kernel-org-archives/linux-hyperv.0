Return-Path: <SRS0=8lvP=B7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D2C433E1
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FDC21741
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a95MDNsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I2nkTUky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHUCSx (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:18:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHUCRH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:07 -0400
Message-Id: <20200821002947.464203710@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPxit2e89mZWZCCiMpEUS6iF/wsktMMgYd58N2BBpyo=;
        b=a95MDNskdEo+EDmYcXSnuFOWHSWxtCujQO0IV2xm/4C/eA0rxhBPT8ZNmHe0JYhniEINcb
        IFu1crITpj0j/TGl5HCfm3AoY0XUc3Mawzk8Q2Dbv4J9LrnFEOC707XBZ1om+quHOcCY8p
        LgRj6cN2UkF8//WimkFDZWyqLGbUMYGrgoDInMQTZjdg8lIsGb+jquyE79hW/y/j6cY8hH
        lO8qOsEcYlNYx5zG+jcNVSxjdUeHAAgwIfBlRyYMDm08vRIjZHIZWKabH+7B4FftfBQ9Rp
        Nqkl20FzWp7aAR60fjb+cmTF22y3ruiyerLL+9CYWZH7h9BuLq0q+vcnObBEBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPxit2e89mZWZCCiMpEUS6iF/wsktMMgYd58N2BBpyo=;
        b=I2nkTUkyNw4H5SXSR3lo/snSYOmbbBODI8HUl/uMOl6QGgZZinUUN3m2/fSKk5QNtF00Y1
        p7CEV1tcGok2HlBw==
Date:   Fri, 21 Aug 2020 02:24:46 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: [patch RFC 22/38] x86/xen: Make xen_msi_init() static and rename it
 to xen_hvm_msi_init()
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename="x86-xen--Make-xen_msi_init"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The only user is in the same file and the name is too generic because this
function is only ever used for HVM domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-pci@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

---
 arch/x86/pci/xen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -419,7 +419,7 @@ int __init pci_xen_init(void)
 }
 
 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_hvm_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
@@ -459,7 +459,7 @@ int __init pci_xen_hvm_init(void)
 	 * We need to wait until after x2apic is initialized
 	 * before we can set MSI IRQ ops.
 	 */
-	x86_platform.apic_post_init = xen_msi_init;
+	x86_platform.apic_post_init = xen_hvm_msi_init;
 #endif
 	return 0;
 }

