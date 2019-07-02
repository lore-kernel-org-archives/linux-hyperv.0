Return-Path: <SRS0=vugJ=VA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5637FC06511
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Jul 2019 01:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCEF20B1F
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Jul 2019 01:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJjRCX8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfGCBdR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:33:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfGCBdR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Jul 2019 21:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T6lwvzaIdbz/BZ6sGTCQ6xcfRARrDSx4wOd7/AZvlgA=; b=HJjRCX8tM0V+o6w1ycakC1h/u
        KJ57SgETpC2AjqSXKpyUth7aNElF3NTRN/A+moXQyzH3YVlD9OnYdHZfS76ngLzVCiFlWkfeQ23f8
        CmqxCFkMJ+vzAMgsnO/gTjV4/LUWVntkllTW3kyh+BMpSuOmY1brDlDFxlMGmb2b6CoABpbcjBXCF
        7dSH+0UPowDVDgQHSN6f8MY4h+C4BYcIwBmVANFgpoLLn2eX6q2khzxXqjixtOLQcbB485j4GWSxN
        PLFTl2Ewoc0v6q+dMoYHfnrtyZ1XEZ+MJKAQfjslONQ8q7Jt4LAB6n/s4cvhubKt4oVwu6Z5yQih1
        QVQthwgkg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiS8V-0003XW-Td; Tue, 02 Jul 2019 23:24:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Message-ID: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
Date:   Tue, 2 Jul 2019 16:24:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when building almost-allmodconfig but with SYSFS
not set (not enabled).  Fixes these build errors:

ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!

drivers/pci/slot.o is only built when SYSFS is enabled, so
pci-hyperv.o has an implicit dependency on SYSFS.
Make that explicit.

Also, depending on X86 && X86_64 is not needed, so just change that
to depend on X86_64.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jake Oshins <jakeo@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/pci/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-52-rc7.orig/drivers/pci/Kconfig
+++ lnx-52-rc7/drivers/pci/Kconfig
@@ -181,7 +181,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
         tristate "Hyper-V PCI Frontend"
-        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+        depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
         help
           The PCI device frontend driver allows the kernel to import arbitrary
           PCI devices from a PCI backend to support PCI driver domains.


