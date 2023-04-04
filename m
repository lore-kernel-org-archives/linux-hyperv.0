Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315AC6FD1D
	for <linux-hyperv@archiver.kernel.org>; Tue,  4 Apr 2023 09:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjDDJBM (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 4 Apr 2023 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjDDJBK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 05:01:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8C081FF2;
        Tue,  4 Apr 2023 02:01:09 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0F2A2210DD89;
        Tue,  4 Apr 2023 02:01:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F2A2210DD89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680598869;
        bh=sYN20W6hPtwdUe2Zl//cBVNvF4+/oIZeshaAhbV6svU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c24aht4+rgL1vFOc6GlSj4vkyDCbYylqmnNBwQq8UWB2LY0NjGfwKhg8cUfsoSwjq
         CC5oOOk4GH6M+BpJaTfLaNVUTbwsjeKRBsZU3L93UBD4yHzDmX8gMY6oLgk+7z3XBO
         1H9BaW9zObxI9Y1SEFeSDC03nsb5bjCt0KBQqNSU=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: [PATCH v4 1/5] x86/init: Make get/set_rtc_noop() public
Date:   Tue,  4 Apr 2023 02:01:00 -0700
Message-Id: <1680598864-16981-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make get/set_rtc_noop() to be public so that they can be used
in other modules as well.

Co-developed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index acc20ae4079d..88085f369ff6 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -330,5 +330,7 @@ extern void x86_init_uint_noop(unsigned int unused);
 extern bool bool_x86_init_noop(void);
 extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
+extern int set_rtc_noop(const struct timespec64 *now);
+extern void get_rtc_noop(struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 95be3831df73..d82f4fa2f1bf 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.34.1

