Return-Path: <SRS0=rKnE=CX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98552C433E2
	for <linux-hyperv@archiver.kernel.org>; Mon, 14 Sep 2020 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F7920EDD
	for <linux-hyperv@archiver.kernel.org>; Mon, 14 Sep 2020 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600105846;
	bh=pqPSd8kjThaKaamevBlGffzYFqFbRYWilYCqCHNqyNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OqaTcrKgLpKJuJh42tn0b8WpdMEI//6pxYwX4qJOmCR8RzffaQwTr+/EQ40wCBwXb
	 vdQSzPy0Ix+UgII5TrXtMedk81p7n1+ToOEXeWVhEECCx+LyCIvgPFgpbmFSbbTjEu
	 f38+607/rex+OcfdqKPuYgb6hdVTJOXRMk4BIgmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgINRun (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:50:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgINL2N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z9so10869136wmk.1;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkfHYu6VFyajw5WpXwEkCq0cVnpjzGJSXx+/xipV4v8=;
        b=M3eYuJpXza5gD0kIK5gL1W3KrJyPZu+4s8YRqJHwUkWlZaHj+5w+gMibYXllQUGzcj
         83AlnVadwCwT5etlESgLsd8TyfaeHuKJg9nWjg8NDCnXbzIGAhhcSH3cp+qWYkpP6Oy5
         40laBXMqhoHa2+DX16pBBvMccUavhOWFAXqDD4MB/dPFEkaL6UZfJKbyRQ2wAmKTsa32
         3t3Z2uwVDmOOROtkoRDSslquppt1TP0BdXxYRWdK2PPBfH4cu5kdzVDWY9n3sQ32419M
         RsrBKHgxhbzu4CdU+P7pRiNUwFUJUONi1524MPJqFjbg/aIu8+EqOBjQX/HeEzrF3S4E
         u9/g==
X-Gm-Message-State: AOAM533xmEjRpWMmZkBxLxV26rasANwd71HnaMMvc+TqP6RKJ1nFRvT/
        du68WpxZ/BIcnCGPLjtxwW+UgDGCPGI=
X-Google-Smtp-Source: ABdhPJzLuElp65R6p44tUHfmz7EuYN+7QWxYPI9EYrKSjiq0pLpakmMPkIlFBus8Mdcki7oqQechWA==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr10781497wmk.178.1600082892013;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:11 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 01/18] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Mon, 14 Sep 2020 11:27:45 +0000
Message-Id: <20200914112802.80611-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This makes the name match Hyper-V TLFS.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/hyperv-tlfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e73a11850055..e6903589a82a 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -88,7 +88,7 @@
 #define HV_CONNECT_PORT				BIT(7)
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
-#define HV_CPU_POWER_MANAGEMENT			BIT(12)
+#define HV_CPU_MANAGEMENT			BIT(12)
 
 
 /*
-- 
2.20.1

