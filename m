Return-Path: <SRS0=sGep=SU=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D81C10F0E
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9A4214DA
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Apr 2019 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612377;
	bh=j6TqMVgjFtOAJb6ukAQxbmY2WalOjaTfILrGTA7UkpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e3oZWg1Bozp4qf8lENR11wFRUXfl88QCdhX/6WCEWPXI6kVyypRpIYxvAI4tvG9NQ
	 wevXC8Ad/VISp4LNMQnm8gHS90Xs20fl6Smt/LUresb74ulMPemokKdaUYEtz9wVh3
	 qlfxVpJCETMfNFy9dJfHA7xR1GVG5ZFxi8T6iZQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbfDRSc4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389831AbfDRR75 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DC2206B6;
        Thu, 18 Apr 2019 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610396;
        bh=j6TqMVgjFtOAJb6ukAQxbmY2WalOjaTfILrGTA7UkpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHov5Q58G55IE9A3uG4ObEh4wP8Q72vhvdQYnqCrWsGMJIiPm3mNRY0toG31VN1qF
         5CZlvK8HWXRSq2kdCYM9dieZyjcCvmZYS9iEQpAlQRg7umDZ9rpTFT/puANbFZpUdC
         AmOLyEkLggCFH7+KZlJ+ETnQq15i9iK2qwXHaEuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>, pakki001@umn.edu,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org
Subject: [PATCH 4.19 045/110] x86/hyperv: Prevent potential NULL pointer dereference
Date:   Thu, 18 Apr 2019 19:56:34 +0200
Message-Id: <20190418160443.128732247@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[ Upstream commit 534c89c22e26b183d838294f0937ee092c82ad3a ]

The page allocation in hv_cpu_init() can fail, but the code does not
have a check for that.

Add a check and return -ENOMEM when the allocation fails.

[ tglx: Massaged changelog ]

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Acked-by: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: pakki001@umn.edu
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org
Link: https://lkml.kernel.org/r/20190314054651.1315-1-kjlu@umn.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 87abd5145cc9..3fb855155286 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -101,9 +101,13 @@ static int hv_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
+	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(alloc_page(GFP_KERNEL));
+	pg = alloc_page(GFP_KERNEL);
+	if (unlikely(!pg))
+		return -ENOMEM;
+	*input_arg = page_address(pg);
 
 	hv_get_vp_index(msr_vp_index);
 
-- 
2.19.1



