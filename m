Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC1C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C8F217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKqS7e7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfDEBQO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:16:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34832 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDEBQO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:16:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so2139186pgf.2;
        Thu, 04 Apr 2019 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSmrtwds6phmiS5rkG4PAMwIL17Ba4GekRHSmWsFNcY=;
        b=ZKqS7e7lyMUXDhTjXZSvjbph1gc3PJ0s5zC7eDac7jaByK6aOBBozZSIO9KulNRTpu
         paWcFfJKs546iStZB1+dJfAXNEMrf7v0/jnOSWpZSptjh4YJqElCbVQzsItrXFNOu8MC
         2TEQs4Vdf7vGvFx4Toh9m5tPLpc06VB5BeHFcAueEbkyUTfr5RHQrGIxjjWYI/BWOrUI
         P1FVJnvQ5g5v21dPztPOs0wte7EQVFrhxodR7QpM5amyyuQpMBYWMjmI2JHWwDtZO5fu
         9SAy+j4IyAKabOmiww02i9xnZPecFQNpmSop9chzljEeMPBuSYWX/j1Yuyv5MvRBgv5u
         Mfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSmrtwds6phmiS5rkG4PAMwIL17Ba4GekRHSmWsFNcY=;
        b=DWZGvO99oQ2jVDLpaxV149EXKCuTqCTfwyl5iLh4LZREbaXliu2JOfzXprR+7+FYsI
         o/psaFVL8eqVoQlMEKJowxZFALZXiy7Gi0MnGqRVpc0I9jfi9v19+3Z/3kEabnXYyX5R
         QEL0dyePbseyyuvQBKybT969TECheAwKWJmW2XIeiAupASCw47en6vyEQBl2hh9GZN4/
         Ut0afTmrmdfoPPGcszhgA5Rtt3b6lK/lAj8PXlqfxiW30nGtiOq0AIHCopqAayysECvS
         LHmXiPA4DJKks0IWOVRAaAmTIipTIbdeA+X4CL+Zs4ayh8llI61nZWafSu7Rf3DfhYsf
         sbWQ==
X-Gm-Message-State: APjAAAUYrbrkxxl1B0AZyphw8nPY9O8vd+GG2ko0ZYm88Z7qIHwREh1S
        A1MvX6DfQP0TdnSLDkWEUrbCSfNgh4y1IQ==
X-Google-Smtp-Source: APXvYqxQ7s7vcdXgkehXLZcb2YDIUow9q+4b195abWQ2Qu2wZ+fQ0I3PfDTL2bR0VBTWD0UL5hVEhQ==
X-Received: by 2002:a62:4290:: with SMTP id h16mr9340869pfd.8.1554426973503;
        Thu, 04 Apr 2019 18:16:13 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id x24sm27187240pfn.128.2019.04.04.18.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:16:12 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:16:12 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] hv: vmbus: Replace page definition with Hyper-V specific
 one
Message-ID: <2db6149c45e8f1406cfff145d7a7cf83a99f2fc6.1554426040.git.m.maya.nakamura@gmail.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554426039.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
not be 4096 on all architectures and Hyper-V always runs with a page
size of 4096.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 drivers/hv/hyperv_vmbus.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index a94aab94e0b5..00ad573870e9 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -207,11 +207,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * Maximum channels is determined by the size of the interrupt page
- * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
- * and the other is receive endpoint interrupt
+ * Maximum channels, 16348, is determined by the size of the interrupt page,
+ * which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to send endpoint
+ * interrupt, and the other is to receive endpoint interrupt.
  */
-#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
+#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
 /* TODO: Need to make this configurable */
-- 
2.17.1

