Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB0C76196
	for <linux-hyperv@archiver.kernel.org>; Mon,  3 Apr 2023 23:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDCXWU (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 3 Apr 2023 19:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjDCXWT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Apr 2023 19:22:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5889211F;
        Mon,  3 Apr 2023 16:22:18 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6A784210CBF2;
        Mon,  3 Apr 2023 16:22:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A784210CBF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680564138;
        bh=MC+jadVc7FZbGi+PwmB9b0t3If3HuxEogBotcxti98I=;
        h=From:To:Cc:Subject:Date:From;
        b=X46iBUYGR8gEtSk2jXJFF/MeQphJna/uVGxpdfPl5XYIAR4pTYTc84kVOd+hdx3XR
         nS2se5fOGKUeQuy4BHNYxTtIXjN4TIfXpA/jyd1U/u9dJQ665wqHZq33vv+0PfPoc0
         jftKOfk+FSmfnZl7TZEafLjzQ91RTAy09UYjrisU=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
Subject: [PATCH] Drivers: hv: Do not free synic pages when they were not allocated
Date:   Mon,  3 Apr 2023 16:22:02 -0700
Message-Id: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case of root partition or snp, the synic pages are allocated by the
hypervisor instead of the kernel, so they should not be freed.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index c7f7652932ca..a10cf642c9ad 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -193,8 +193,10 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		free_page((unsigned long)hv_cpu->synic_event_page);
-		free_page((unsigned long)hv_cpu->synic_message_page);
+		if (!hv_isolation_type_snp() && !hv_root_partition) {
+			free_page((unsigned long)hv_cpu->synic_event_page);
+			free_page((unsigned long)hv_cpu->synic_message_page);
+		}
 		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
-- 
2.25.1

