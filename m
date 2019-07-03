Return-Path: <SRS0=vugJ=VA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD81C5B57D
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Jul 2019 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF862063F
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Jul 2019 01:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MTAK0tEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGCBdR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:33:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfGCBdR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Jul 2019 21:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=InWmJ+St41ikI+4rizzZIL6hXVavnsXpRy2fc8t2i50=; b=MTAK0tEofyhdJtOypGTtVMIs8
        pBHy2O4TbTzCttnhg/LJanmt/XcBTzuDUPmbybPs6Rg0XsO8iYO8naIeHTwjWnTHMDu2KwwH+wcaU
        UpgnAge56JadzEiab+YsfsJgSwEcUVmsXXLcBg7486V8FIHylCXzlaBxru1QQo4Cxabp8ifS4zC1S
        WiCo1d2p5b0qBvzQ/Bn1xH/KrrLMTkgiNvjJ+icdIKMQqyrz+o0Zf66g5hdYwzpVJSFWLobFtRLOO
        6mqp/Zt3/me/Ikt6C503zATKULYzwPjiKZ1shQ0rrnDcVy3RZxqs3bIlRyDOoQLav2NUCrdUOuspl
        e2I5twPxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiSw1-0007NX-MU; Wed, 03 Jul 2019 00:15:41 +0000
Date:   Tue, 2 Jul 2019 17:15:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        Jake Oshins <jakeo@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Message-ID: <20190703001541.GG1729@bombadil.infradead.org>
References: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 02, 2019 at 04:24:30PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when building almost-allmodconfig but with SYSFS
> not set (not enabled).  Fixes these build errors:
> 
> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> 
> drivers/pci/slot.o is only built when SYSFS is enabled, so
> pci-hyperv.o has an implicit dependency on SYSFS.
> Make that explicit.

I wonder if we shouldn't rather provide no-op versions of
pci_create|destroy_slot for when SYSFS is not set?
