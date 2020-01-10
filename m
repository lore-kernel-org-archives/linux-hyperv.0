Return-Path: <SRS0=EqSz=27=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37012C33C99
	for <linux-hyperv@archiver.kernel.org>; Fri, 10 Jan 2020 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77E20721
	for <linux-hyperv@archiver.kernel.org>; Fri, 10 Jan 2020 07:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgAJHZM (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:25:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgAJHZM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jan 2020 02:25:12 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 327F3913EE20074B90DB;
        Fri, 10 Jan 2020 15:25:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:25:03 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
Date:   Fri, 10 Jan 2020 15:20:47 +0800
Message-ID: <20200110072047.85398-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The conversions to bool are not needed, remove these.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/hyperv/hv_apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 40e0e32..3112cf6 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -133,7 +133,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 
 ipi_mask_ex_done:
 	local_irq_restore(flags);
-	return ((ret == 0) ? true : false);
+	return ret == 0;
 }
 
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
@@ -186,7 +186,7 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
 				     ipi_arg.cpu_mask);
-	return ((ret == 0) ? true : false);
+	return ret == 0;
 
 do_ex_hypercall:
 	return __send_ipi_mask_ex(mask, vector);
-- 
2.7.4

