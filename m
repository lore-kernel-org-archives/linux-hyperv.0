Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFDC433DF
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0055F208A9
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ba+ApzA3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JYpSEt6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgHZMBe (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:01:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgHZMBB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:01 -0400
Message-Id: <20200826112330.683298931@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Oz0/1gWRPSvvsPJtwAVY3cS6pNjuxGdtqsobcr4ZCvs=;
        b=Ba+ApzA3lxf0wI52RxaFIrxrYAUyBUQG1gGFQztF1br0kk0U6AoE5wqCgnixhkjrgzOMo6
        rT2ZvDyvuHISEifoHKZcKVSGoRPA4BuCErcMtK3FQsusSIwD5cxoIwTKUluv4ET8zep/wX
        rIHR72+BqmwB1T2FYELwwtUSa5KalCb4GGFT5jGxBlx+9x72db//rw0t1XujWqIY8Vjs+P
        FVWGmQd/RE/PAIEnL0RNQjFWLeWLoGfwUlzXfBeO7dzRVssgTu8kngEQeo/lNittJ7g2V5
        NVXx9eYNRt9ZrPbdlXzYbDphBoMnpc/BMMJMcyjRQDnN40c6/GFaU/Q5glpFAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Oz0/1gWRPSvvsPJtwAVY3cS6pNjuxGdtqsobcr4ZCvs=;
        b=JYpSEt6S0O9MIXMNQT5EttPLTAVkYzwAAPVY2vxQEslrb722eNdO+r4OYiSe56zO/bTHh/
        UR0TOrKuXedUnoCQ==
Date:   Wed, 26 Aug 2020 13:16:29 +0200
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
Subject: [patch V2 01/46] iommu/amd: Prevent NULL pointer dereference
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Dereferencing irq_data before checking it for NULL is suboptimal.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/iommu/amd/iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3717,8 +3717,8 @@ static int irq_remapping_alloc(struct ir
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
-		cfg = irqd_cfg(irq_data);
-		if (!irq_data || !cfg) {
+		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
+		if (!cfg) {
 			ret = -EINVAL;
 			goto out_free_data;
 		}


