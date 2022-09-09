Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E3ECAAD3
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Sep 2022 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIISul (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 9 Sep 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIISuk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Sep 2022 14:50:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7402D8D3F0;
        Fri,  9 Sep 2022 11:50:39 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7B4E20B929C;
        Fri,  9 Sep 2022 11:50:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7B4E20B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662749438;
        bh=hKvp7xsxus8CJFQ+InVqMrBcREIdThrCu+sov09IzSo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=htS28ax+dhxwlIl8INCWvyEL2p15a5i4WfPWKNQDZID9ZVjTnxL4x62qlau32G8P2
         ITzmCbaXGgz1PmOfZQjjOkta3FyjLy2CDRiq+VzaPjmnkrlwe/ZPDELUTD3y3vJICP
         utBRVzYelJO31bf6+WqD2B2M34Y30kLcOQquG4Cc=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     vkuznets@redhat.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] hv: Use PCI_VENDOR_ID_MICROSOFT for better discoverability
Date:   Fri,  9 Sep 2022 11:50:24 -0700
Message-Id: <1662749425-3037-2-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662749425-3037-1-git-send-email-eahariha@linux.microsoft.com>
References: <87leqsr6im.fsf@redhat.com>
 <1662749425-3037-1-git-send-email-eahariha@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Easwar Hariharan <easwar.hariharan@microsoft.com>

Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3c833ea..6b77a53 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -39,6 +39,8 @@
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
 
+#define PCI_VENDOR_ID_MICROSOFT 0x1414
+
 struct vmbus_dynid {
 	struct list_head node;
 	struct hv_vmbus_device_id id;
@@ -2052,7 +2054,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	child_device_obj->channel = channel;
 	guid_copy(&child_device_obj->dev_type, type);
 	guid_copy(&child_device_obj->dev_instance, instance);
-	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
+	child_device_obj->vendor_id = PCI_VENDOR_ID_MICROSOFT;
 
 	return child_device_obj;
 }
-- 
1.8.3.1

