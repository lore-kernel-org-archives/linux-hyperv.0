Return-Path: <SRS0=IMab=5T=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7EC43331
	for <linux-hyperv@archiver.kernel.org>; Fri,  3 Apr 2020 08:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3013E2073B
	for <linux-hyperv@archiver.kernel.org>; Fri,  3 Apr 2020 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbgDCIa3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:30:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390557AbgDCIa2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 04:30:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 018D779D60BE3470D8B0;
        Fri,  3 Apr 2020 16:30:10 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 16:30:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] hv_debugfs: Make hv_debug_root static
Date:   Fri, 3 Apr 2020 16:28:45 +0800
Message-ID: <20200403082845.22740-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix sparse warning:

drivers/hv/hv_debugfs.c:14:15: warning: symbol 'hv_debug_root' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hv/hv_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
index 8a2878573582..ccf752b6659a 100644
--- a/drivers/hv/hv_debugfs.c
+++ b/drivers/hv/hv_debugfs.c
@@ -11,7 +11,7 @@
 
 #include "hyperv_vmbus.h"
 
-struct dentry *hv_debug_root;
+static struct dentry *hv_debug_root;
 
 static int hv_debugfs_delay_get(void *data, u64 *val)
 {
-- 
2.17.1


