Return-Path: <SRS0=1SxB=24=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F8C33C8C
	for <linux-hyperv@archiver.kernel.org>; Tue,  7 Jan 2020 13:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35642072A
	for <linux-hyperv@archiver.kernel.org>; Tue,  7 Jan 2020 13:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/YDQNs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgAGNKN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:10:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44387 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id 195so27728286pfw.11;
        Tue, 07 Jan 2020 05:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7VpROxxsQmteVCJCWl6rje7QI3OYOMNJtsxFthQWfkU=;
        b=L/YDQNs0YQdPQmLkKnGNRFKRbPvGcSD2QbZ4bNHgm5ODq0mUAIYQEG1ycQ3+JabrYO
         ouYQnlwqcIGumvAFI9wkqR1k3xv5gq3f/eyjqfmA+tElxXVfVu+4IAAV3BrtNhzC3Tjy
         x9v2FKgv2zLoiMciieNNMh8FEnAnbtzsUH9CwGIWbssUhMTwtBfRF+Thj39ZXS1KI+3z
         Fe9IM9lcLzdcBVlqKCMKRB4l4ds4yGvVwcJrOhUKijC/32qXFerXZ4/xCe1xQD/ZB8ts
         XbAJx6O3MPLFu488A2g44RxRjL7D2t1+n1q/2e+OheGsZ1mMFuLRsBu+aiRowiJXv/zv
         IHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7VpROxxsQmteVCJCWl6rje7QI3OYOMNJtsxFthQWfkU=;
        b=INfzR2612O6NXoZuyQad9cb8ztQ+yeX/n9OAASN1E8CNvxEwlHgxKfkeFn5CPjqSZF
         6rtwUgC+nulZqoWi+HP6GUKOdeDdHsRMFIlyhkUntpK1wHeKDR5fgN2E1JxhBTledjY2
         +Yxf2evwu9F1xKO16E6x0jhrxST8InSktVEGi2suBjkiiGhcAFlZVsNmd4TBFg+C7kHq
         Jwn/pXGYRdM+QX0uPGmX1ILntlBI0vScKtjTeB52bmUi3UNBS0UaRPrAQ4RmJDI6Mfgk
         9bJZEou+G6/sVuZrT5bhiiy8SaLlxw6odX2ZS9uvsRr22TYHw59T7bqxDd7fbdiT5sck
         hYYQ==
X-Gm-Message-State: APjAAAW3lL90o/ciOZK30R5IDSLai/VCz9PRVFMD7ZW+dsNCXvFujQgf
        2SQG6ptr8c4HRt54bB8d6w4=
X-Google-Smtp-Source: APXvYqyuQRhSdjBWkr+00uZbJj1FJKSDtvjplvSlE9fSXf9xpI+PGU5cW0cjDdSnT7w9sFxEUf9ewg==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr120207809pgi.64.1578402612168;
        Tue, 07 Jan 2020 05:10:12 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:11 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        michael.h.kelley@microsoft.com, david@redhat.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com,
        vbabka@suse.cz, osalvador@suse.de, pavel.tatashin@microsoft.com,
        rppt@linux.ibm.com, mhocko@suse.com
Subject: [RFC PATCH V2 2/10] mm: expose is_mem_section_removable() symbol
Date:   Tue,  7 Jan 2020 21:09:42 +0800
Message-Id: <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V balloon driver will use is_mem_section_removable() to
check whether memory block is removable or not when receive
memory hot remove msg. Expose it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d04369e6d3cc..a4ebfc5c48b3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1179,6 +1179,7 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 	/* All pageblocks in the memory block are likely to be hot-removable */
 	return true;
 }
+EXPORT_SYMBOL_GPL(is_mem_section_removable);
 
 /*
  * Confirm all pages in a range [start, end) belong to the same zone.
-- 
2.14.5

