Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF5C7EE22
	for <linux-hyperv@archiver.kernel.org>; Thu, 11 May 2023 14:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjEKO4i (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 11 May 2023 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbjEKO4X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 May 2023 10:56:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B57611B48;
        Thu, 11 May 2023 07:55:58 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A007220EAB6B;
        Thu, 11 May 2023 07:55:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A007220EAB6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683816900;
        bh=O4J9DTHM5ykaLqmtABIlS+wEAau1jelC6LEZQR7BwQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmNzbGlBq8Eg1wauWEGCh5NWemaFbFcRw00GOHRqhR/k4N+JHh/ImOh9ZSKTA1Dp5
         V9lvh4Wgnens8yhjLrhGK/SUPbuMEi7QWkgNy1U91iv45Odv5OwCBu56bq0UIZHRXx
         dcZOVAsORNvKspJArl7ZBXznMayL/GVh/FuaCFfo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     ssengar@microsoft.com
Subject: [PATCH 2/2] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE dependencies
Date:   Thu, 11 May 2023 07:54:37 -0700
Message-Id: <1683816877-10747-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

MTRRs are not per-VTL and are controlled by VTL0, make sure it
is disabled for all other VTLs.

X86_MPPARSE scans low memory for MP tables, which is not required
for Hyper-V VTL platforms.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 00242107d62e..c8d443886b9d 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -16,6 +16,8 @@ config HYPERV
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
 	depends on X86_64 && HYPERV
+	depends on !MTRR
+	depends on !X86_MPPARSE
 	default n
 	help
 	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
-- 
2.34.1

