Return-Path: <SRS0=ecOg=77=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83710C433E0
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Jun 2020 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C022186A
	for <linux-hyperv@archiver.kernel.org>; Thu, 18 Jun 2020 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LoixPRyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgFRGnZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgFRGnY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 02:43:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BABC061755;
        Wed, 17 Jun 2020 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rJN0H8/0nC5UPhILL9WR0pQNIdABbC5dw/uf3CUdzm0=; b=LoixPRySLyqh/93G323y4koNbl
        fTkZcMyqx2tSrkPmAVyEZ62A8S63jBcuLr27BTsixPvJJFeAOULv7jF7FQ0GNnjWYNEYtHD7wntD3
        aot98lYYu7v/oXbrS7LQeGdy2MeIT+B88XPW85A9pARg9OUG9HHApN226yfKWYOtwx1XaZkYTPNZ/
        az5JzzYCjeCLjJ7pED3fwRNAIkR1fuZcEw7Yr2nPb6jeUOoGALZ07RabxXG2d3XeA8948BEOBmry1
        1XXzKETKhPSL7NcRzjooA9Bcp6f+dORA7YRNAMN3F2UlTHz+PpL3ZBf53cibppF6wjymS3FyWjfc1
        ShgbsCoA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jloGb-000803-Rs; Thu, 18 Jun 2020 06:43:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page
Date:   Thu, 18 Jun 2020 08:43:06 +0200
Message-Id: <20200618064307.32739-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618064307.32739-1-hch@lst.de>
References: <20200618064307.32739-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
page read-only just after the allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/kernel/probes/kprobes.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1c95dcf1d7833..cbe49cd117cfec 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 void *alloc_insn_page(void)
 {
-	void *page;
-
-	page = vmalloc_exec(PAGE_SIZE);
-	if (page) {
-		set_memory_ro((unsigned long)page, 1);
-		set_vm_flush_reset_perms(page);
-	}
-
-	return page;
+	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
+			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
+			NUMA_NO_NODE, __func__);
 }
 
 /* arm kprobe: install breakpoint in text */
-- 
2.26.2

