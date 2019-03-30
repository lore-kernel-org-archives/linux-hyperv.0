Return-Path: <SRS0=nmsr=SB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE65C43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 01:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663FB2064A
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 01:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907899;
	bh=sF6Tmw0XpqrPxv///1QK5vQUUsVfGIvHzt95QALa2Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoJaeaPiFvO9PvA1URIetI6TK9G2hneTuJZcFx0PmCAcG4aNPEQ94q2NkgjkZr/dK
	 /yGovfrb3wbM8VeKoYAuMfZVUAyw7U+h43v8c72kKpRnI/b0qtmGjPJnUl68617k4C
	 gOLA6PR279OK/C/9uf6t5L1E4FNnw3bx/VKT2Id0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfC3AyZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbfC3AyY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3927218D3;
        Sat, 30 Mar 2019 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907264;
        bh=sF6Tmw0XpqrPxv///1QK5vQUUsVfGIvHzt95QALa2Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5kw87K8//FTh50yP0ll598JJrh/DCgzWfJWzVdGmpxCE/a0onuRNLUbgCHhfyUdm
         GREci1Y6ddl2Q2JIfxvCjh8drhk6Rm9QGBWczl68IpjgP+SXXF6nLkcQhZ6WxaaEIM
         HQ03Cd7gOAKys+EcgonF5TnQkaQs8ZX6ihgFfKeI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Thomas Gleixner <tglx@linutronix.de>,
        pakki001@umn.edu, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/52] x86/hyperv: Prevent potential NULL pointer dereference
Date:   Fri, 29 Mar 2019 20:52:52 -0400
Message-Id: <20190330005301.26868-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

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
index 20c876c7c5bf..5a81a8edff12 100644
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

