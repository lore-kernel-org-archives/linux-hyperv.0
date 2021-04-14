Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F0C433B4
	for <linux-hyperv@archiver.kernel.org>; Wed, 14 Apr 2021 06:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23863611EE
	for <linux-hyperv@archiver.kernel.org>; Wed, 14 Apr 2021 06:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbhDNGWA (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:22:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34361 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232405AbhDNGVv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 02:21:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVWCFKV_1618381283;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWCFKV_1618381283)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:21:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] Drivers: hv: vmbus: remove unused function
Date:   Wed, 14 Apr 2021 14:21:22 +0800
Message-Id: <1618381282-119135-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix the following clang warning:

drivers/hv/ring_buffer.c:89:1: warning: unused function
'hv_set_next_read_location' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hv/ring_buffer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 35833d4..78d4043 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -84,15 +84,6 @@ static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 	ring_info->ring_buffer->write_index = next_write_location;
 }
 
-/* Set the next read location for the specified ring buffer. */
-static inline void
-hv_set_next_read_location(struct hv_ring_buffer_info *ring_info,
-		    u32 next_read_location)
-{
-	ring_info->ring_buffer->read_index = next_read_location;
-	ring_info->priv_read_index = next_read_location;
-}
-
 /* Get the size of the ring buffer. */
 static inline u32
 hv_get_ring_buffersize(const struct hv_ring_buffer_info *ring_info)
-- 
1.8.3.1

