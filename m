Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06679C43334
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 Jun 2022 17:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiFIRQn (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiFIRQl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 13:16:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12191CEAF0;
        Thu,  9 Jun 2022 10:16:40 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4847F20BE68D;
        Thu,  9 Jun 2022 10:16:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4847F20BE68D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654795000;
        bh=rdXIF+/5BrdwY7RSyPMsiv15cC+P7VG0Gwq7r32ptHs=;
        h=From:To:Subject:Date:From;
        b=f9ptvfusVj2osgluyfV5Hv3sHRKxBtf+BubLtvOxHaYXPMKMc63X1nqXKSypFiOzB
         5sRDx6mMB91Li3RP/sCGNaIPh2og7Q6XO9R+Pa70vbaGH99z9Cy7t6gYN6whVfVvcf
         rBGt51XwgnjBK49Dd1RR5JU9wAa0cBt4TF/crhKw=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: [PATCH] Drivers: hv: vmbus: Release cpu lock in error case
Date:   Thu,  9 Jun 2022 10:16:36 -0700
Message-Id: <1654794996-13244-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case of invalid sub channel, release cpu lock before returning.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 280b529..5b12040 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -639,6 +639,7 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		 */
 		if (newchannel->offermsg.offer.sub_channel_index == 0) {
 			mutex_unlock(&vmbus_connection.channel_mutex);
+			cpus_read_unlock();
 			/*
 			 * Don't call free_channel(), because newchannel->kobj
 			 * is not initialized yet.
-- 
1.8.3.1

