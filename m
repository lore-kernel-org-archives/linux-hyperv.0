Return-Path: <SRS0=8lvP=B7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E6C433E4
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00C120855
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yE78YKBW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WP3SvXjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHUCTG (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:19:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgHUCRE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:17:04 -0400
Message-Id: <20200821002947.168173557@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Xil47Xitq/gy2CFriIqkg6fmKg4rUeNmWQC3UIIAE6w=;
        b=yE78YKBWeQJNRno/mhgAqmoyeOTKFwnOmAuRZQ5SkOa0rdPcXDsezUiMafpbmddhT8YtRx
        Q48PBPl5MCz8RE+vKQS6FvAoswzKSqltLT8dz4hEt8NfisI3WqmgK4DKoERYansXMAOCPd
        EwBdwb4DFqgc98F1KE4se7KtWer9ytqTsAhj9vGzByVYJQv/UCteKvlg8RR+c36Z6ixDcJ
        BD6gKlCjCebIEAR5oyxn66+VkJnohi7LOi/o0l5x7UMgjimXfDEJyg400bRHlBN1oBEuWP
        fTTG6828E//dV9xRZEjoWhFP+b/n2Z4ZMMIf+ezYaZKeZkEJp8dyTlXQ87/pZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Xil47Xitq/gy2CFriIqkg6fmKg4rUeNmWQC3UIIAE6w=;
        b=WP3SvXjrxQ5y0nFAbsID3Pj/5cUANa6inm+6T4+n98lsoiLiw/u7pX1jx+Twz/Mxho32Av
        rocr6eby1iKkoNCA==
Date:   Fri, 21 Aug 2020 02:24:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
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
Subject: [patch RFC 19/38] irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="genirq-msi--Provide-DOMAIN_BUS_VMD_MSI.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PCI devices behind a VMD bus are not subject to interrupt remapping, but
the irq domain for VMD MSI cannot be distinguished from a regular PCI/MSI
irq domain.

Add a new domain bus token and allow it in the bus token check in
msi_check_reservation_mode() to keep the functionality the same once VMD
uses this token.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jon Derrick <jonathan.derrick@intel.com>
---
 include/linux/irqdomain.h |    1 +
 kernel/irq/msi.c          |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -370,8 +370,13 @@ static bool msi_check_reservation_mode(s
 {
 	struct msi_desc *desc;
 
-	if (domain->bus_token != DOMAIN_BUS_PCI_MSI)
+	switch(domain->bus_token) {
+	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_VMD_MSI:
+		break;
+	default:
 		return false;
+	}
 
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;

