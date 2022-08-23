Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B385C25B08
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Aug 2022 03:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiHWDp7 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbiHWDp6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 23:45:58 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A6B5E337;
        Mon, 22 Aug 2022 20:45:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 35BAD1E80CE3;
        Tue, 23 Aug 2022 11:42:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9dOJF5QK0ECb; Tue, 23 Aug 2022 11:42:08 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 82E5A1E80CBF;
        Tue, 23 Aug 2022 11:42:08 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] hv/hv_kvp_daemon: remove unnecessary (void*) conversions
Date:   Tue, 23 Aug 2022 11:45:52 +0800
Message-Id: <20220823034552.8596-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 tools/hv/hv_kvp_daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1e6fd6ca513b..445abb53bf0d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -772,11 +772,11 @@ static int kvp_process_ip_address(void *addrp,
 	const char *str;
 
 	if (family == AF_INET) {
-		addr = (struct sockaddr_in *)addrp;
+		addr = addrp;
 		str = inet_ntop(family, &addr->sin_addr, tmp, 50);
 		addr_length = INET_ADDRSTRLEN;
 	} else {
-		addr6 = (struct sockaddr_in6 *)addrp;
+		addr6 = addrp;
 		str = inet_ntop(family, &addr6->sin6_addr.s6_addr, tmp, 50);
 		addr_length = INET6_ADDRSTRLEN;
 	}
-- 
2.18.2

