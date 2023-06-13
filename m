Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732BC7EE2E
	for <linux-hyperv@archiver.kernel.org>; Tue, 13 Jun 2023 07:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjFMHNX (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 13 Jun 2023 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjFMHNV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jun 2023 03:13:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CF0ECE;
        Tue, 13 Jun 2023 00:13:19 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF6D320FE88D;
        Tue, 13 Jun 2023 00:13:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF6D320FE88D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686640398;
        bh=/PT81JOy5+bQnTFFKIvi5pPXC/tbbHKChswSnu/pguk=;
        h=From:To:Subject:Date:From;
        b=V0Db+28uycwdF4LyY20ikpS4q2z84hTbVu/y2Alw28k2dkzMg2Q1YQnUHdjrk98ry
         0pUJQZh+OXbB+VMThRoCMf69fz/KXJ/NSBt/Ax/a++xb93ROR30TTIKXmIDGDYYlUE
         MFwpCm1c25Ul/GVzqCnmYWc9GoP+owhi/j9ncVpM=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: [PATCH v2] x86/hyperv: add noop functions to x86_init mpparse functions
Date:   Tue, 13 Jun 2023 00:13:11 -0700
Message-Id: <1686640391-13001-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In certain configurations, VTL0 and VTL2 can share the same VM
partition and hence share the same memory address space. In such
systems VTL2 has visibility of all of the VTL0 memory space.

When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel performs
a scan of low memory to search for MP tables. However, in systems
where VTL0 controls the low memory and may contain valid tables
specific to VTL0, this scanning process can lead to confusion
within the VTL2 kernel.

In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE
hence add the noop function instead.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]: Improve commit message

 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 85d38b9f3586..db5d2ea39fc0 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -25,6 +25,10 @@ void __init hv_vtl_init_platform(void)
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
+	/* Avoid searching for BIOS MP tables */
+	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
 	x86_platform.get_nmi_reason = hv_get_nmi_reason;
-- 
2.34.1

