Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BEC433B4
	for <linux-hyperv@archiver.kernel.org>; Wed,  7 Apr 2021 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9646135D
	for <linux-hyperv@archiver.kernel.org>; Wed,  7 Apr 2021 14:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhDGOlv (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:41:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhDGOlt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 10:41:49 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A50B20B5682;
        Wed,  7 Apr 2021 07:41:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A50B20B5682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617806499;
        bh=UiD+TNwnDWGUgflcKnE8t0Jg4WOePE7eT9ubvNMNffY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpHwn0Pw8FnVXfCbWSWehI/S1BDZIQBXFpffAfrG+ldHUBidc+em/Lf6Ixl6ny0Qz
         w6Pp1DOdz6wabRrgG68F0BIKrLjwRpmsuIKqCIuHKOGJZK/W5f1xqWJSaZM76n/31N
         YznIOeeIWhw/0xYf4EaBqK0scVky0EVpqjKhmFUU=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 1/7] hyperv: Detect Nested virtualization support for SVM
Date:   Wed,  7 Apr 2021 14:41:22 +0000
Message-Id: <e14dac75ff1088b2c4bea361954b37e414edd03c.1617804573.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617804573.git.viremana@linux.microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Detect nested features exposed by Hyper-V if SVM is enabled.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3546d3e21787..4d364acfe95d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -325,9 +325,17 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 	}
 
-	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
+	/*
+	 * AMD does not need enlightened VMCS as VMCB is already a
+	 * datastructure in memory. We need to get the nested
+	 * features if SVM is enabled.
+	 */
+	if (boot_cpu_has(X86_FEATURE_SVM) ||
+	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
 		ms_hyperv.nested_features =
 			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
+		pr_info("Hyper-V nested_features: 0x%x\n",
+			ms_hyperv.nested_features);
 	}
 
 	/*
-- 
2.25.1

