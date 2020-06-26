Return-Path: <SRS0=czHO=AH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB5C433E0
	for <linux-hyperv@archiver.kernel.org>; Fri, 26 Jun 2020 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB95D207D8
	for <linux-hyperv@archiver.kernel.org>; Fri, 26 Jun 2020 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFZRsG (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:48:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgFZRsG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 13:48:06 -0400
Received: by linux.microsoft.com (Postfix, from userid 1041)
        id F13E520B4901; Fri, 26 Jun 2020 10:48:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F13E520B4901
From:   Joseph Salisbury <joseph.salisbury@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, wei.liu@kernel.org, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] Drivers: hv: Change flag to write log level in panic msg to false
Date:   Fri, 26 Jun 2020 10:48:05 -0700
Message-Id: <1593193685-74615-1-git-send-email-joseph.salisbury@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Reply-To: joseph.salisbury@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When the kernel panics, one page worth of kmsg data is written to an allocated
page.  The Hypervisor is notified of the page address trough the MSR.  This
panic information is collected on the host.  Since we are only collecting one
page of data, the full panic message may not be collected.

Each line of the panic message is prefixed with the log level of that
particular message in the form <N>, where N is the log level.   The typical
4 Kbytes contains anywhere from 50 to 100 lines with that log level prefix.

hv_dmsg_dump() makes a call to kmsg_dump_get_buffer().  The second argument in
the call is a bool described as: ‘@syslog: include the “<4>” Prefixes’.

With this change, we will not write the log level to the allocated page.  This
will provide additional room in the allocated page for more informative panic
information.

Requesting in stable kernels, since many kernels running in production are 
stable releases.

Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9147ee9d5f7d..d69f4efa3719 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1368,7 +1368,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	kmsg_dump_get_buffer(dumper, true, hv_panic_page, HV_HYP_PAGE_SIZE,
+	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
-- 
2.17.1

