Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF380C54EBE
	for <linux-hyperv@archiver.kernel.org>; Mon, 16 Jan 2023 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjAPRIF (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjAPRHm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 12:07:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B2DD45216;
        Mon, 16 Jan 2023 08:48:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1483D20DFE79;
        Mon, 16 Jan 2023 08:48:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1483D20DFE79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673887693;
        bh=JZq9G5MlrIm9vmsNAI+byLNXbxxsM+mcQ1O6doawohU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DM6T02C13nUQxv9ynrGjywSQSw3cYMHP0HQEhBzbYKhx7W/K+tUgLuceXmjtWtQ+B
         G1zGkFR8XgmvxNvk+OOKGm4VeDqhnuB/nXVsNIPIrorfi8PBErI2UcCZj5CyRfnTId
         d+GkTyQyHD1ip4lyYRSSPaOY5WurmpKZV6VBDSeg=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH 2/4] Drivers: hv: allow non ACPI compilation for hv_is_hibernation_supported
Date:   Mon, 16 Jan 2023 08:48:06 -0800
Message-Id: <1673887688-19151-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

acpi_sleep_state_supported API is only define for CONFIG_ACPI flag and
thus it can't be used for non-ACPI builds. Initaly there won't be
hibernate support for non ACPI builds.

This change will help adding device tree support in subsequent commits.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 52a6f89..370ec20 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -234,7 +234,11 @@ void hv_setup_dma_ops(struct device *dev, bool coherent)
 
 bool hv_is_hibernation_supported(void)
 {
+#ifdef CONFIG_ACPI
 	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
+#else
+	return false;
+#endif
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
-- 
1.8.3.1

