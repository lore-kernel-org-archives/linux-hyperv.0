Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C62C001DE
	for <linux-hyperv@archiver.kernel.org>; Tue, 25 Jul 2023 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGYN7G (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGYN7F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jul 2023 09:59:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016BB0;
        Tue, 25 Jul 2023 06:59:04 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9JTK1ghSztRX2;
        Tue, 25 Jul 2023 21:55:49 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:59:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] hv: hyperv.h: Remove unused extern declaration vmbus_ontimer()
Date:   Tue, 25 Jul 2023 21:58:34 +0800
Message-ID: <20230725135834.1732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit 30fbee49b071 ("Staging: hv: vmbus: Get rid of the unused function vmbus_ontimer()")
this is not used anymore, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/hyperv.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index bfbc37ce223b..3ac3974b3c78 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1239,9 +1239,6 @@ extern int vmbus_recvpacket_raw(struct vmbus_channel *channel,
 				     u32 *buffer_actual_len,
 				     u64 *requestid);
 
-
-extern void vmbus_ontimer(unsigned long data);
-
 /* Base driver object */
 struct hv_driver {
 	const char *name;
-- 
2.34.1

