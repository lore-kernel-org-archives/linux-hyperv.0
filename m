Return-Path: <SRS0=jM96=5Y=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE9C2BA1A
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797F82082F
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 12:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyDdyMNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDHMBW (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:01:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDHMBT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 08:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+lcZXxZEHGVocLnAtFg5vca+ZcryIgWoBTFv1YYLF4g=; b=pyDdyMNBolOORlttG0Ow8hMuA8
        buz5EeD0sjSvmJHQdIlYMloXGCUqtH/NgI1zYxqxslpC50LmuKkT2+rHdh9Zy0HSRo06czklbqt1u
        UonmZgJX7dvVKYYlVmBu45Xwb108cTxn+IssXZhLq7pBnsEYZvMZ9OIGblW7pVBUtl8yETpwacET5
        O3xVQLQEEVCxAMnU35vpWxF2yaWjY4jp5jnRit6Z6WZEXeSf7gPKmbHzd0MbHP1LjLzICE/Cead+4
        CF/PVgJQtX89EiknsH5urF9gCmJ0Ccb6at4CUW7p3c8Rf4p2uJG/7FAohqFcDtc7MShP8AYKN+bo/
        te1inlrQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9OC-0005u0-OI; Wed, 08 Apr 2020 12:01:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/28] s390: use __vmalloc_node in alloc_vm_stack
Date:   Wed,  8 Apr 2020 13:59:25 +0200
Message-Id: <20200408115926.1467567-28-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

alloc_vm_stack can use a slightly higher level vmalloc function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a25ed47087ee..4518fb1d6bf4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -735,9 +735,8 @@ void do_IRQ(struct pt_regs *regs)
 
 static void *__init alloc_vm_stack(void)
 {
-	return __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, VMALLOC_START,
-				    VMALLOC_END, THREADINFO_GFP, PAGE_KERNEL,
-				     0, NUMA_NO_NODE, (void*)_RET_IP_);
+	return __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, THREADINFO_GFP,
+			      NUMA_NO_NODE, (void *)_RET_IP_);
 }
 
 static void __init vmap_irqstack_init(void)
-- 
2.25.1

