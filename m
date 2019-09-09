Return-Path: <SRS0=DFZk=XE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CABC4740C
	for <linux-hyperv@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72BE21D6C
	for <linux-hyperv@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067376;
	bh=sgpC2KLS/4Rjhn2ZMgXWoTc6xu05EmuS7/jOsnoo6nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jBgovdJI2aa5judm89DHh5vB28BwUZdDtJ8b+P484DqkbZPtZqapRexoRTaFc/buT
	 odXpCIjNdN7dPkSblJmEKyv5jhekAeFhAABl3k6NFKoG++12k6/2duS+KlFcKkXX7d
	 PL1VWzLEH7hyg+sB3ITVq0a9GQh2+GMtU//sxD2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392023AbfIIWQP (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388675AbfIIWQO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Sep 2019 18:16:14 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A4F2171F;
        Mon,  9 Sep 2019 22:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067374;
        bh=sgpC2KLS/4Rjhn2ZMgXWoTc6xu05EmuS7/jOsnoo6nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLUr5BTSCND9B9C+eHv5gcT3OHgdBnaPQonF6MYtVbQSb9ui5qWf2GcM6bitQvcnd
         3q5EPLrTgK7YoqwOKJSf0h1mb5bkUeKji4Xgsm3MPq2ORB9nHsHqjYo0nhkEiAC1XM
         i0ZibcmY7CsMcRPTxYBPNPtAx9t1P9YagAKI4Ep8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Jong Hyun Park <park.jonghyun@yonsei.ac.kr>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 05/12] x86/hyper-v: Fix overflow bug in fill_gva_list()
Date:   Mon,  9 Sep 2019 11:40:45 -0400
Message-Id: <20190909154052.30941-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154052.30941-1-sashal@kernel.org>
References: <20190909154052.30941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

[ Upstream commit 4030b4c585c41eeefec7bd20ce3d0e100a0f2e4d ]

When the 'start' parameter is >=  0xFF000000 on 32-bit
systems, or >= 0xFFFFFFFF'FF000000 on 64-bit systems,
fill_gva_list() gets into an infinite loop.

With such inputs, 'cur' overflows after adding HV_TLB_FLUSH_UNIT
and always compares as less than end.  Memory is filled with
guest virtual addresses until the system crashes.

Fix this by never incrementing 'cur' to be larger than 'end'.

Reported-by: Jong Hyun Park <park.jonghyun@yonsei.ac.kr>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 2ffd9e33ce4a ("x86/hyper-v: Use hypercall for remote TLB flush")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/mmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index e65d7fe6489f3..5208ba49c89a9 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -37,12 +37,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 		 * Lower 12 bits encode the number of additional
 		 * pages to flush (in addition to the 'cur' page).
 		 */
-		if (diff >= HV_TLB_FLUSH_UNIT)
+		if (diff >= HV_TLB_FLUSH_UNIT) {
 			gva_list[gva_n] |= ~PAGE_MASK;
-		else if (diff)
+			cur += HV_TLB_FLUSH_UNIT;
+		}  else if (diff) {
 			gva_list[gva_n] |= (diff - 1) >> PAGE_SHIFT;
+			cur = end;
+		}
 
-		cur += HV_TLB_FLUSH_UNIT;
 		gva_n++;
 
 	} while (cur < end);
-- 
2.20.1

