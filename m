Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D52DC77B75
	for <linux-hyperv@archiver.kernel.org>; Tue, 18 Apr 2023 05:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDRFMr (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRFMq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 01:12:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7ACB40F0;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3C13F21C2022;
        Mon, 17 Apr 2023 22:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C13F21C2022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681794765;
        bh=yRj88ka13GJpMg/3bI23hbHOSkGkGWzPUVOA10JufYg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fKigXjiBAJm9oUvMTmHO6KKqyaFUZCLKgwRTpsI75WUpZhc3DVs9fhAgGoE2P8Uy6
         1MdWHoicjJos+BkgKZDIIDz20G1z30Y6soO1go1ti8UUGi5vZB2fr+KpSFcL0XCS1Z
         RibdynS6ROLvWkVRZpCfPE6JETAwNZuRHXmtO+cE=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 2/2] x86/hyperv: Allow hv_get_nmi_reason compilation irrespective of HYPERV config
Date:   Mon, 17 Apr 2023 22:12:41 -0700
Message-Id: <1681794761-13734-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
References: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Move hv_get_nmi_reason out of CONFIG_HYPERV guard, so that it can be
compiled irrespective of CONFIG_HYPERV enabled or not.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 71ed240ef66d..67f8386c1775 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -29,6 +29,11 @@ typedef int (*hyperv_fill_flush_list_func)(
 
 void hyperv_vector_handler(struct pt_regs *regs);
 
+static inline unsigned char hv_get_nmi_reason(void)
+{
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
 
@@ -189,11 +194,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return hv_vp_assist_page[cpu];
 }
 
-static inline unsigned char hv_get_nmi_reason(void)
-{
-	return 0;
-}
-
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void set_hv_tscchange_cb(void (*cb)(void));
-- 
2.34.1

