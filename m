Return-Path: <SRS0=nmsr=SB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C794EC43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 05:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844F4218AC
	for <linux-hyperv@archiver.kernel.org>; Sat, 30 Mar 2019 05:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UDTT5YlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfC3FGO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:06:14 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:50356 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfC3FGN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 Mar 2019 01:06:13 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 01:06:11 EDT
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-09.nifty.com with ESMTP id x2U4rFEw010955
        for <linux-hyperv@vger.kernel.org>; Sat, 30 Mar 2019 13:53:18 +0900
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x2U4pLAS007869;
        Sat, 30 Mar 2019 13:51:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x2U4pLAS007869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553921483;
        bh=pPtH2t8GZ8WqRr4VJX9/foridPbWBTo0wL5g5vqglAE=;
        h=From:To:Cc:Subject:Date:From;
        b=UDTT5YlXYzmV8aMr64IB9o/kx9x1SJcsuDQRVB6zc2+ncJxYU/ylUjjCaZsNrRTBG
         7Q9UvzIIKGMWVDC+bn1T3gtD6qEXpRVWdgKX12Og05nhDGPNKoU050KHM5J4YM5plW
         VNAjhxTJOyOxzVt4aPyh96ZEVQwIoLcNPVsA2z8kO8SEx+n4im/pNq+a9xm6DCJkCq
         wh+GZPtByurdKUccFQib7S3wH7R4x/80IRV6BLZnatRuN69zbsYKPIjAUgpfXhWc/p
         0sTX6rGOgBMkFgode+b8egs88JrUIrOqFKipdFYMcZHoIilGc14B/iG8n/SVJR6qGa
         EQ8Kpcf8xl4VA==
X-Nifty-SrcIP: [218.220.227.105]
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
Subject: [PATCH] Remove SPDX "WITH Linux-syscall-note" from kernel-space headers
Date:   Sat, 30 Mar 2019 13:50:53 +0900
Message-Id: <1553921453-23777-1-git-send-email-yamada.masahiro@socionext.com>
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
file, but I do now see a good reason why its license tag must include
"WITH Linux-syscall-note".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

