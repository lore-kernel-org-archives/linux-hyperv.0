Return-Path: <SRS0=jM96=5Y=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C21C2BA2B
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB002083E
	for <linux-hyperv@archiver.kernel.org>; Wed,  8 Apr 2020 12:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMLbPDv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgDHMAe (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:00:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgDHMAe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WzOt0GdNQnN9W8rWLv3kSycAULlc6HEQKX8/oCDxHuU=; b=GMLbPDv5CKJVuoIiX6Qpd0FpUQ
        dPpYg6qQF1jZKryrp6PHJKxeXakwTjTPAtRacgwRzfMttFQ/3S8mMj+ngjyDY0d8gksH5TDW35WMg
        rHsQFLJLjFMhFtBTRzf1nbgywfs0xdwNxh384zReYJjaRUgVPNSSU5JN2M23dbOcWA0rRmiPEttIO
        5KVNv70PJhaSCZPinD4MBT/Ocy8K0cT2epCFc8i/hKnENAsBf6f4WGjWsjTRfd44NwfvyPYg4PgDR
        P+OFfdp+u3v8tPVn68ns4fPRuGKHVslpBJj5vCgJ+9Y8B4MRBfOqdLaGv888mzrw9td0sRTWMHSYJ
        hDt03PQw==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9NJ-0002pA-RG; Wed, 08 Apr 2020 12:00:10 +0000
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
Subject: [PATCH 11/28] mm: pass addr as unsigned long to vb_free
Date:   Wed,  8 Apr 2020 13:59:09 +0200
Message-Id: <20200408115926.1467567-12-hch@lst.de>
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

Ever use of addr in vb_free casts to unsigned long first, and the caller
has an unsigned long version of the address available anyway.  Just pass
that and avoid all the casts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9183fc0d365a..aada9e9144bd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1664,7 +1664,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	return vaddr;
 }
 
-static void vb_free(const void *addr, unsigned long size)
+static void vb_free(unsigned long addr, unsigned long size)
 {
 	unsigned long offset;
 	unsigned long vb_idx;
@@ -1674,24 +1674,22 @@ static void vb_free(const void *addr, unsigned long size)
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
 
-	flush_cache_vunmap((unsigned long)addr, (unsigned long)addr + size);
+	flush_cache_vunmap(addr, addr + size);
 
 	order = get_order(size);
 
-	offset = (unsigned long)addr & (VMAP_BLOCK_SIZE - 1);
-	offset >>= PAGE_SHIFT;
+	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 
-	vb_idx = addr_to_vb_idx((unsigned long)addr);
+	vb_idx = addr_to_vb_idx(addr);
 	rcu_read_lock();
 	vb = radix_tree_lookup(&vmap_block_tree, vb_idx);
 	rcu_read_unlock();
 	BUG_ON(!vb);
 
-	vunmap_page_range((unsigned long)addr, (unsigned long)addr + size);
+	vunmap_page_range(addr, addr + size);
 
 	if (debug_pagealloc_enabled_static())
-		flush_tlb_kernel_range((unsigned long)addr,
-					(unsigned long)addr + size);
+		flush_tlb_kernel_range(addr, addr + size);
 
 	spin_lock(&vb->lock);
 
@@ -1791,7 +1789,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		debug_check_no_locks_freed(mem, size);
-		vb_free(mem, size);
+		vb_free(addr, size);
 		return;
 	}
 
-- 
2.25.1

