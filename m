Return-Path: <SRS0=Q4qA=DE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A6C4346E
	for <linux-hyperv@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C174923998
	for <linux-hyperv@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtWT6FXN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lHZQSLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgI0Iqs (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgI0Iqs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Sep 2020 04:46:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB24C0613CE;
        Sun, 27 Sep 2020 01:46:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601196405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=3LGtm2OI8qF06h9KMGGQRJ7d4e/B09d0iYRNLqK19DE=;
        b=vtWT6FXNpv1rJGdbEJJKxhxZ2hkowdjPcJEaDMAro5/mwYgF7f2qjEeiKFQSSH9PtTbtjQ
        HsUFQz/Trt8kMSfUg/AQa+Dd6H6TLmp85HgtKhILMKJEBPAXZTlBVlCuBVrTlZ3SWkXObd
        A3uYhH4wFHZJacmbgX2O+NsHMqa/9G2Pkuz65AAv9jSfW+iCB+ZS9fYcuTgvLwKZwmDf/O
        zZgGz9fCusPWYJqd2bYwAHlyXGdEd/MWFvhUhNXr7HHWvB0uTZIwM6dBXR4V6SnJO+mQK+
        WSRcbCQJ++zz1iV8DGtZCO9vHOjRIHe69AAw88TEiMXTyc69NYyY/moKXh9SBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601196405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=3LGtm2OI8qF06h9KMGGQRJ7d4e/B09d0iYRNLqK19DE=;
        b=2lHZQSLVc5ukVdtzXcK6JAqYUmFwK6ZXXzxyFLvvd4IZf5x37NfcDYaGYy6WSVTOsGs4s7
        44wL1Jbt8wkVdCAA==
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, x86@kernel.org,
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
Subject: [PATCH] x86/apic/msi: Unbreak DMAR and HPET MSI
In-Reply-To: <87tuvltpo5.fsf@nanos.tec.linutronix.de>
Date:   Sun, 27 Sep 2020 10:46:44 +0200
Message-ID: <87wo0fli8b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Switching the DMAR and HPET MSI code to use the generic MSI domain ops
missed to add the flag which tells the core code to update the domain
operations with the defaults. As a consequence the core code crashes
when an interrupt in one of those domains is allocated.

Add the missing flags.

Fixes: 9006c133a422 ("x86/msi: Use generic MSI domain ops")
Reported-by: Qian Cai <cai@redhat.com> 
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -309,6 +309,7 @@ static struct msi_domain_ops dmar_msi_do
 static struct msi_domain_info dmar_msi_domain_info = {
 	.ops		= &dmar_msi_domain_ops,
 	.chip		= &dmar_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 static struct irq_domain *dmar_get_irq_domain(void)
@@ -408,6 +409,7 @@ static struct msi_domain_ops hpet_msi_do
 static struct msi_domain_info hpet_msi_domain_info = {
 	.ops		= &hpet_msi_domain_ops,
 	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 struct irq_domain *hpet_create_irq_domain(int hpet_id)
