Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4EC4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3448217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg5jLbOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfDEBRg (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:17:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41677 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDEBRg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:17:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so2298017pfd.8;
        Thu, 04 Apr 2019 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jvMszzSvwdbU169l8LvoLjhC1NstQr9xJXp3myImfk4=;
        b=Zg5jLbOeo+d2lxIqbDXi30suPNEdjxilVEpOCIKMjJiEJTyqnGv1jmy8IuezZIJ9+l
         T5s2ZvUfhghICE7e+WaPCpp0F0yvYXkgj6eDcPbx8Bd2BVGp8Ny/Gx5xzqU9iQqzLmk3
         LNdrawSPsR5mS5SiOtFLe0siIj5KVeFrGu5hrThxOoowDBXPDgg4Zd/zQxYsqPtFzk8P
         t9DLr/89wyPIA1SdBeox8h3lbXTiAqsvvOwXhA3U7Tbss5oCf42kJfTAPSXLX4D6eq/o
         G9olpYgyumBVfDTJ836Wejp4Gsw0aK4yLJOZ4R01xpC6UMm2gWWhzRZX8H1Haj7Q4ZI1
         E0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jvMszzSvwdbU169l8LvoLjhC1NstQr9xJXp3myImfk4=;
        b=PUAP3BPiaEGMA/uY8I76dJac9CX7HZkNtN2xD7BcD5CGIKusvDWTyhdC6WIYSGGu+C
         2PipJkHJm5AZiGKuPGeTlwV5IuNvRa2S6oq9CabxekjK7Ks9FDE+mVVCTyAKHbfYVsKs
         TUunR0nxRDW+3438XXrCgrze/kKRtwekgY4ifI7NKkKonVTWfSUgqxQo0C1/3ydkOWrX
         +8LBkt09rL15Ar1nrb3L2dnJWwu9ouzqFIA0SV15Q/HUYlbgg5XAsLRst2HxBCf6iyza
         6jpp7jyB/BXsNCWQwxwhY5TIbYvL6s1SuGPYc0wGK+k/NeItcXDRincGQoR51GpBsN94
         3eXg==
X-Gm-Message-State: APjAAAWeeWUhxJm6mT5t+xKQaoHMUBspt88Rln5l0zS2Q1YPC+MWZlJ+
        LAbFArUpC0eEe8j3CL7erpnbZqZ5skrO1A==
X-Google-Smtp-Source: APXvYqzwEZLbhrdHPLY36xpVEaWqvTMw9pJhqhTZDytiwln67ACdsqdnRmOuCcWNsR7s9GeBaSV3GQ==
X-Received: by 2002:a62:4351:: with SMTP id q78mr9610568pfa.86.1554427055364;
        Thu, 04 Apr 2019 18:17:35 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id f63sm23830902pfc.180.2019.04.04.18.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:17:34 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:17:33 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] x86: hv: mmu.c: Replace page definitions with Hyper-V
 specific ones
Message-ID: <3bc5d60092473815fbd90422875233fb6075285b.1554426040.git.m.maya.nakamura@gmail.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554426039.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace PAGE_SHIFT, PAGE_SIZE, and PAGE_MASK with HV_HYP_PAGE_SHIFT,
HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK, respectively, because the guest
page size and hypervisor page size concepts are different, even though
they happen to be the same value on x86.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/hyperv/mmu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index e65d7fe6489f..175f6dcc7362 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -15,7 +15,7 @@
 #include <asm/trace/hyperv.h>
 
 /* Each gva in gva_list encodes up to 4096 pages to flush */
-#define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
+#define HV_TLB_FLUSH_UNIT (4096 * HV_HYP_PAGE_SIZE)
 
 static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 				      const struct flush_tlb_info *info);
@@ -32,15 +32,15 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	do {
 		diff = end > cur ? end - cur : 0;
 
-		gva_list[gva_n] = cur & PAGE_MASK;
+		gva_list[gva_n] = cur & HV_HYP_PAGE_MASK;
 		/*
 		 * Lower 12 bits encode the number of additional
 		 * pages to flush (in addition to the 'cur' page).
 		 */
 		if (diff >= HV_TLB_FLUSH_UNIT)
-			gva_list[gva_n] |= ~PAGE_MASK;
+			gva_list[gva_n] |= ~HV_HYP_PAGE_MASK;
 		else if (diff)
-			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
+			gva_list[gva_n] |= (diff - 1) >> HV_HYP_PAGE_SHIFT;
 
 		cur += HV_TLB_FLUSH_UNIT;
 		gva_n++;
@@ -129,7 +129,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	 * We can flush not more than max_gvas with one hypercall. Flush the
 	 * whole address space if we were asked to do more.
 	 */
-	max_gvas = (PAGE_SIZE - sizeof(*flush)) / sizeof(flush->gva_list[0]);
+	max_gvas = (HV_HYP_PAGE_SIZE - sizeof(*flush)) /
+		    sizeof(flush->gva_list[0]);
 
 	if (info->end == TLB_FLUSH_ALL) {
 		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
@@ -200,9 +201,9 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	 * whole address space if we were asked to do more.
 	 */
 	max_gvas =
-		(PAGE_SIZE - sizeof(*flush) - nr_bank *
+		(HV_HYP_PAGE_SIZE - sizeof(*flush) - nr_bank *
 		 sizeof(flush->hv_vp_set.bank_contents[0])) /
-		sizeof(flush->gva_list[0]);
+		 sizeof(flush->gva_list[0]);
 
 	if (info->end == TLB_FLUSH_ALL) {
 		flush->flags |= HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY;
-- 
2.17.1

