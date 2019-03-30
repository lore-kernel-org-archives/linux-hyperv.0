Return-Path: <SRS0=nmsr=SB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41436C10F05
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A38A2184C
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908134;
	bh=S5PeUGUAYe/Kz+Y3zj+oBMXsduxpAypjMN641UXFObk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKtu8xtftelw2AbcZjlCpAwTamKvA+ri7B0grGsfufhgVkD9l5QgoHMK37qe6vBqP
	 LLSE/jYsSwWI5xppFSpye0SpeAK4V1bXhqP61S9DpixAh8Y7DZpM9h8P5QhudmAMER
	 v/xiROUAn4NTz1cg5PNqqyvLczujvGdmnah+9eOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfC3Awm (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfC3Awl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DAE218AC;
        Sat, 30 Mar 2019 00:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907161;
        bh=S5PeUGUAYe/Kz+Y3zj+oBMXsduxpAypjMN641UXFObk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LknTNTIkfhX23GX8bggquQkorWICpG20z2swaDNn8hEK9orcqi50YdnFkTBdzVHLZ
         Vmcwey0FDxLQrmRfh61YIDvgoth/nDTNwRQc/tDFBsMHQUzyrREhJF/C3PaWqkBZnp
         KqBEYHBMKyOtQG8duK306gHJalTK1laaAykVI6Rw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Thomas Gleixner <tglx@linutronix.de>,
        pakki001@umn.edu, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 57/67] x86/hyperv: Prevent potential NULL pointer dereference
Date:   Fri, 29 Mar 2019 20:50:37 -0400
Message-Id: <20190330005047.25998-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
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
index 7abb09e2eeb8..dfdb4ce1ae9c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -102,9 +102,13 @@ static int hv_cpu_init(unsigned int cpu)
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

