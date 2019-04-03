Return-Path: <SRS0=38gl=SF=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6DC4360F
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Apr 2019 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4564205C9
	for <linux-hyperv@archiver.kernel.org>; Wed,  3 Apr 2019 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDCRDO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCRDO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Apr 2019 13:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E756EC058CBD;
        Wed,  3 Apr 2019 17:03:13 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC0A42D25A;
        Wed,  3 Apr 2019 17:03:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>
Subject: [PATCH] x86/hyper-v: implement EOI assist
Date:   Wed,  3 Apr 2019 19:03:09 +0200
Message-Id: <20190403170309.4107-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 03 Apr 2019 17:03:14 +0000 (UTC)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V TLFS suggests an optimization to avoid imminent VMExit on EOI:
"The OS performs an EOI by atomically writing zero to the EOI Assist field
of the virtual VP assist page and checking whether the "No EOI required"
field was previously zero. If it was, the OS must write to the
HV_X64_APIC_EOI MSR thereby triggering an intercept into the hypervisor."

Implement the optimization in Linux.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 8eb6fbee8e13..5c056b8aebef 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -86,6 +86,11 @@ static void hv_apic_write(u32 reg, u32 val)
 
 static void hv_apic_eoi_write(u32 reg, u32 val)
 {
+	struct hv_vp_assist_page *hvp = hv_vp_assist_page[smp_processor_id()];
+
+	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
+		return;
+
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
-- 
2.20.1

