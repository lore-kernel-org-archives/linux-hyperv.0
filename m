Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55026C7EE29
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Jun 2023 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjFIIx2 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbjFIIxK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 04:53:10 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71236210D;
        Fri,  9 Jun 2023 01:52:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VkhQf38_1686300772;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VkhQf38_1686300772)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 16:52:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     simon.horman@corigine.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH net-next 2/3] tools: ynl: Remove duplicated include in handshake-user.c
Date:   Fri,  9 Jun 2023 16:52:48 +0800
Message-Id: <20230609085249.131071-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
References: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

./tools/net/ynl/generated/handshake-user.c: stdlib.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/net/ynl/generated/handshake-user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/net/ynl/generated/handshake-user.c b/tools/net/ynl/generated/handshake-user.c
index fe99c4ef7373..7a1f0364b88f 100644
--- a/tools/net/ynl/generated/handshake-user.c
+++ b/tools/net/ynl/generated/handshake-user.c
@@ -8,7 +8,6 @@
 #include "ynl.h"
 #include <linux/handshake.h>
 
-#include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <libmnl/libmnl.h>
-- 
2.20.1.7.g153144c

