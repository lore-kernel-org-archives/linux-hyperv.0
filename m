Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D3C6FD1D
	for <linux-hyperv@archiver.kernel.org>; Mon, 20 Mar 2023 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCTHrs (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCTHrr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Mar 2023 03:47:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7B2125A3;
        Mon, 20 Mar 2023 00:47:44 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1476120FAAD4;
        Mon, 20 Mar 2023 00:47:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1476120FAAD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679298464;
        bh=4PRW0VI+oZvbTmFAcVbsrAFK92yD8Gwq6n0ZpwB9zPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NFOdiDJZUwvLWn/3+im5vYYkUdZEqchvLQ+qCTga3O3f2mlYIR6k+3iV5fWWH/Gko
         aCNoxTVlCJVu7RyAIAvKVZXlvgYfIfYr/kjkYMMuAtTcFWB3VD8QOityCWjF3KITHi
         NqoECmyNJBYO/pnFNRStMYv4y/e+T9W+MF2MvYuc=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: [PATCH v9 2/5] ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
Date:   Mon, 20 Mar 2023 00:47:37 -0700
Message-Id: <1679298460-11855-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

acpi_sleep_state_supported() is defined only when CONFIG_ACPI=y. The
function is in acpi_bus.h, and acpi_bus.h can only be used in
CONFIG_ACPI=y cases. Add the stub function to linux/acpi.h to make
compilation successful for !CONFIG_ACPI cases.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..d331f76b0c19 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1075,6 +1075,11 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
 	return 0;
 }
 
+static inline bool acpi_sleep_state_supported(u8 sleep_state)
+{
+	return false;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.34.1

