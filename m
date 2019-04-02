Return-Path: <SRS0=Cz6W=SE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EBC4360F
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727CC207E0
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Apr 2019 09:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t5Ohdgk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDBJK1 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:10:27 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:22833 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBJK0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Apr 2019 05:10:26 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3298VSZ007626;
        Tue, 2 Apr 2019 18:08:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3298VSZ007626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554196113;
        bh=EAXKI8xuU8IlM0GjkRwXsx7k4dD562vpzZxwsiCOtOY=;
        h=From:To:Cc:Subject:Date:From;
        b=t5Ohdgk47kaYLy5jMmLNtp2C+KaJs0Yof76QBkFUx2e2iECi4EATjKYso9lb8FiIb
         /FyshpraRsqHqdZSDoSygB++IntV63cWnHOrnGnhufUUZMfn4FEqMHk+0wrcjKScsV
         ip5jnjmok0zcuWgieChwBXkpZAQb8MQwo5yoWwgl2BYTekW/ECbbnXTdXnLaH/ol5V
         5ZcEseI6OZUSDHERhKACExgZd4DZbFc8r8tDc518b/7Bu8WkPZllPdlA+wzUOdbpk7
         zTngzozMALddTivC0aDWCVpMO/BtyG1mNCQIeCg6h34uzeyAtkVVqFqICqqDlbC2Mr
         bYu3GRwLpvjqQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2] Remove SPDX "WITH Linux-syscall-note" from kernel-space headers
Date:   Tue,  2 Apr 2019 18:08:24 +0900
Message-Id: <1554196104-3522-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The "WITH Linux-syscall-note" should be added to headers exported to
the user-space.

Some kernel-space headers have "WITH Linux-syscall-note", which seems
a mistake.

[1] arch/x86/include/asm/hyperv-tlfs.h

5a4858032217 ("x86/hyper-v: move hyperv.h out of uapi") moved this file
out of uapi, but missed to update the SPDX License tag.

[2] include/asm-generic/shmparam.h

76ce2a80a28e ("Rename include/{uapi => }/asm-generic/shmparam.h really")
moved this file out of uapi, but missed to update the SPDX License tag.

[3] include/linux/qcom-geni-se.h

eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver") added this
file, but I do not see a good reason why its license tag must include
"WITH Linux-syscall-note".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix a typo in commit log

 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 include/asm-generic/shmparam.h     | 2 +-
 include/linux/qcom-geni-se.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 2bdbbbc..cdf44aa 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * This file contains definitions from Hyper-V Hypervisor Top-Level Functional
diff --git a/include/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
index 8b78c0b..b8f9035 100644
--- a/include/asm-generic/shmparam.h
+++ b/include/asm-generic/shmparam.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_GENERIC_SHMPARAM_H
 #define __ASM_GENERIC_SHMPARAM_H
 
diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 3bcd67f..dd46494 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
  */
-- 
2.7.4

