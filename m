Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5BC352A1
	for <linux-hyperv@archiver.kernel.org>; Tue,  6 Dec 2022 12:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiLFMFs (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 6 Dec 2022 07:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiLFMFe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Dec 2022 07:05:34 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 823412934B;
        Tue,  6 Dec 2022 04:04:30 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id DECE320B83CB; Tue,  6 Dec 2022 04:04:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DECE320B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670328269;
        bh=nAGw0Ppx8rmPRSOLSZL4sBGnXf6tR5BK+rncL/6h2kY=;
        h=From:To:Cc:Subject:Date:From;
        b=L43SkFGlwHkLmxBiEFa7TTHJtKqxmFN0lgcNCUpISqPUvu/xsPOgbxyUua/sbAo76
         u1RdzgUteB7uk1fJ/D9V/ZYXQOv+VuVqs4aZ4ewhdilBYwPw0B7sjKvVERq+kvnlf4
         XWb5Yn83BAVgCZPm/zqNAe3OsyB6/Ca52PJ/EomQ=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2] hv_balloon: Fix committed value in post_status() if dynamic memory is disabled
Date:   Tue,  6 Dec 2022 04:03:33 -0800
Message-Id: <1670328213-9471-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If Dynamic memory is disabled for VM, the committed value reported by the
post_status() call by hv_balloon driver includes compute_balloon_floor().
This is not needed if balloon_up operations or hot_add operations were
never requested on the VM(or if Dynamic memory was disabled for the VM)

Fixes: 1c7db96f6feac ("Prevent the host from ballooning the guest too low")

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---

Changes in v2:
  * Add Fixes: tag in the patch

---
 drivers/hv/hv_balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fdf6decacf06..a6f5321d4a2e 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1129,11 +1129,23 @@ static unsigned long compute_balloon_floor(void)
 
 static unsigned long get_pages_committed(struct hv_dynmem_device *dm)
 {
-	return vm_memory_committed() +
-		dm->num_pages_ballooned +
-		(dm->num_pages_added > dm->num_pages_onlined ?
-		 dm->num_pages_added - dm->num_pages_onlined : 0) +
-		compute_balloon_floor();
+	unsigned long pages_committed;
+
+	pages_committed = vm_memory_committed();
+
+	/*
+	 * If no balloon_up or hot_add operation was performed do not add
+	 * num_pages_ballooned, number of pages offline or
+	 * compute_balloon_floor() to the pages_committed value
+	 */
+	if (dm->num_pages_ballooned || dm->num_pages_added) {
+		pages_committed += dm->num_pages_ballooned +
+			(dm->num_pages_added > dm->num_pages_onlined ?
+			 dm->num_pages_added - dm->num_pages_onlined : 0) +
+			 compute_balloon_floor();
+	}
+
+	return pages_committed;
 }
 
 /*
-- 
2.37.2

