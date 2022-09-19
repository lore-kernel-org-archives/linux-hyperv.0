Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC7ECAAD3
	for <linux-hyperv@archiver.kernel.org>; Mon, 19 Sep 2022 22:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiISWE6 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 19 Sep 2022 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiISWE5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 18:04:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4103E13E8D;
        Mon, 19 Sep 2022 15:04:56 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 11D9A20B929C;
        Mon, 19 Sep 2022 15:04:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11D9A20B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663625096;
        bh=Ybw8YXXwwBPUc8bFbNbCUhdABz/tJqzbFNtnPKTyRz0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZcPj3Hmk5V3cuAfx0glUFqHQJ7uT69u1jaW7A+9ElaKn2O1Q2jZCI1cx5cw+QZ21n
         mV4RmCEBC+FEvo82mcSEbZGWcb+beffViAYKjfP2iXbYMjsujlZAISF3Djky0QGYf3
         ylPSG7tn8/yrit+7oRXSWWwVb6qR42T0lYIDBoQ4=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better discoverability
Date:   Mon, 19 Sep 2022 15:04:44 -0700
Message-Id: <1663625084-2518-2-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
References: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Easwar Hariharan <easwar.hariharan@microsoft.com>

pci_ids.h already defines PCI_VENDOR_ID_MICROSOFT, and is included via
linux/pci.h. Use the define instead of the magic number.

Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3c833ea..f2efb74 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2052,7 +2052,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	child_device_obj->channel = channel;
 	guid_copy(&child_device_obj->dev_type, type);
 	guid_copy(&child_device_obj->dev_instance, instance);
-	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
+	child_device_obj->vendor_id = PCI_VENDOR_ID_MICROSOFT;
 
 	return child_device_obj;
 }
-- 
1.8.3.1

