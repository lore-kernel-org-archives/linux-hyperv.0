Return-Path: <SRS0=8lvP=B7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B4C433DF
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DF92075E
	for <linux-hyperv@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EbrHK+nj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1w6grv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHUCQp (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgHUCQm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA8C061385;
        Thu, 20 Aug 2020 19:16:41 -0700 (PDT)
Message-Id: <20200821002945.262049945@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SAePHnv9QIZIElaA8Hv0f8fY0Re6tn3I6Urg3/UB+AE=;
        b=EbrHK+njZmE28dA4Hrd+kGB8kjnOw8PMN7kGhdHo4H/XTVddC1Oq8PxubaVZD7kI/o4w4L
        dTtMHjSHI6refIvP4RlqsaMiTyu2R7xsBb6s5doyy7bCq3XOOsh4gJ2r6ELs0x7CDd5Jd5
        sgpDcDKbuI4Y6UPLkcW5QfXGpNPICqbKsFmBrc13WkHcQw5bL9HUDYTZ+RkVF771BbUXJ1
        UbB5uO+LOTTZZcfGr1aBUaqpPhcR+Df2fPxXy6FCbTp2w52Zv0c9mLRTlmuieUQreMG5h/
        wMXEBxiAdTspWuBv51dptpaDxmxbXBbZFrDpiWnri+rKQ0zwCZyyH8X3KS2Nfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SAePHnv9QIZIElaA8Hv0f8fY0Re6tn3I6Urg3/UB+AE=;
        b=i1w6grv2586y+n4GxwRriZSHHsUqFlzyyiQJ55JZdxUfm48yrSi745Ev04/K+pHwsCTBN+
        RnicLQnPA4t76MCA==
Date:   Fri, 21 Aug 2020 02:24:25 +0200
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
Subject: [patch RFC 01/38] iommu/amd: Prevent NULL pointer dereference
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="iommu-amd--Prevent-NULL-pointer-dereference.patch"
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dereferencing irq_data before checking it for NULL is suboptimal.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
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

