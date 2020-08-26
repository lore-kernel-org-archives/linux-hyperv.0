Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC7C433E3
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB120786
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYeOk83p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19p1170o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgHZMIu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgHZMBs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A3C061757;
        Wed, 26 Aug 2020 05:01:47 -0700 (PDT)
Message-Id: <20200826112334.698236296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T7GI6+per3yw7C/RYhxMMvPmri10khmLfeX2/IGCf+c=;
        b=rYeOk83pkEJnp46ajEK6NUiZaIQWhcYQOD7ARwQ4vU+RFzqloQ63JN2nVYehUzJCZ3LhEM
        nSvRtOTy2UEio1ys8RRtDU/QayBvKZkSuMuvMgk+a9H5ILcig8cpK/553ZabvDI8df5lKS
        okR053zhIrINePDGUZi1mOpY/lBtAW5f6ZunqQOcOmm/Sm2oNDC+w9GwUD6L0lAJTkCSNt
        voLf39dTRK8wXWcqnk8nqZa7+ytxZXByWN4UpDIwm6TP4r34cMxnX/n8ogGmo5ibrOp+nq
        jMMBNare5DRQuC71qjLfmswliL61Gs8OgznCWDk/2DJZm1QTEOADZCXvc8ODGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T7GI6+per3yw7C/RYhxMMvPmri10khmLfeX2/IGCf+c=;
        b=19p1170oqCuoZJTSY37jpDQNACEfJLfBQIGgKA6yb2yN5TF7Hyw1gvihiQWU9wKDv1m7Ky
        q5LnSO3wTOR3faCA==
Date:   Wed, 26 Aug 2020 13:17:09 +0200
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
Subject: [patch V2 41/46] platform-msi: Provide default irq_chip:: Ack
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For the upcoming device MSI support it's required to have a default
irq_chip::ack implementation (irq_chip_ack_parent) so the drivers do not
need to care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/base/platform-msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,6 +95,8 @@ static void platform_msi_update_chip_ops
 		chip->irq_mask = irq_chip_mask_parent;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
 	if (!chip->irq_set_affinity)

