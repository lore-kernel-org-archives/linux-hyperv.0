Return-Path: <SRS0=Xe0B=56=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39626C3815B
	for <linux-hyperv@archiver.kernel.org>; Tue, 14 Apr 2020 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9932075E
	for <linux-hyperv@archiver.kernel.org>; Tue, 14 Apr 2020 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VJlZLs1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgDNNkc (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502725AbgDNNOu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 09:14:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8FDC061A0C;
        Tue, 14 Apr 2020 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e0PtFSPo0Iy8oJ4AyTx7isQx+jUj9sBCh3WiJ7noJgw=; b=VJlZLs1gWebRy4YQPswH/Z8Jx5
        qJDtJm9oUL50SK3MdnShcWlZj3qn/JmLl4WXQPMdfksoHOFPIy15ASpmhOOGsUxMbrHeVHV8gdWRU
        UCuBa+xiakEmMn6lvr0DTJmIJAgl2S01lnpBusJzo0U1J4z757NE4e2GDpCIwVpsyQPIs3FAFK0jy
        4EXTYCe4HaWcotfsaa2WsYwxdP7SOCkBJH0yCmyWvoKBo5Aa+Psiv26r1eOwMk8O5QMGH0WZBtV8h
        NfsGFtFTw4PlQWMF4vJUqRreblEroLpFCwgul6XK9DKdIjFoicP5aS3yJsmZVL7XNYQK7QBkn/DFY
        6YsSQ7fg==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOQ-0006bs-Qu; Tue, 14 Apr 2020 13:14:23 +0000
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
Subject: [PATCH 09/29] mm: unexport unmap_kernel_range_noflush
Date:   Tue, 14 Apr 2020 15:13:28 +0200
Message-Id: <20200414131348.444715-10-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There are no modular users of this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d1534d610b48..3375f9508ef6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2029,7 +2029,6 @@ void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 	vunmap_page_range(addr, addr + size);
 }
-EXPORT_SYMBOL_GPL(unmap_kernel_range_noflush);
 
 /**
  * unmap_kernel_range - unmap kernel VM area and flush cache and TLB
-- 
2.25.1

