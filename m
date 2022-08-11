Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BA3C19F2A
	for <linux-hyperv@archiver.kernel.org>; Thu, 11 Aug 2022 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiHKNfD (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 11 Aug 2022 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKNfD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Aug 2022 09:35:03 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3C8991D;
        Thu, 11 Aug 2022 06:34:58 -0700 (PDT)
X-QQ-mid: bizesmtp81t1660224888tpy80avo
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:34:46 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: znfcQSa1hKYH8554wh+QYeslE5QQT6pOTq4jBxTh+Nr7oJm/ypfaaaIeOwy1t
        2qeaAULkSxObr/AzMbzI6sPQ+xBVcZ5noSkoZ6PiYG1s/UJeCxqGrzmk3vGywGvHSqJ5za3
        BttprhCnetGxQ0LrCrbrfBScsNpUPsXBR8OhPeNl8CfYmXOBDWDkzCOnuIXs8tf46CQB72M
        XGWtQNpBmOTBC0ISk6r4Vm22pvmmmBCRcWGhWCudA57kRdc9SFJStzl01ihDAJCehvILsrI
        BfXCkDVepK+QqvjBlKxex0IxYE0X7ilhkpdLZgdLikRKw31c8RRS26hglpBfh1+HiaGAUwd
        Ue1IzPrMgNy6CgcNpjIIEhFPcWMjZHs2ipK26XZjnS/ngMa1G1qtr11rheVfQU9YVwHj38v
        d4jRoPkvZZg=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     haiyangz@microsoft.com
Cc:     kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] tools: hv: Fix comment typo
Date:   Thu, 11 Aug 2022 21:34:33 +0800
Message-Id: <20220811133433.10175-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1e6fd6ca513b..c97c12e95ecb 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -44,7 +44,7 @@
 
 /*
  * KVP protocol: The user mode component first registers with the
- * the kernel component. Subsequently, the kernel component requests, data
+ * kernel component. Subsequently, the kernel component requests, data
  * for the specified keys. In response to this message the user mode component
  * fills in the value corresponding to the specified key. We overload the
  * sequence field in the cn_msg header to define our KVP message types.
-- 
2.36.1

