Return-Path: <SRS0=/bEP=RR=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392CC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 05:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCDC217F5
	for <linux-hyperv@archiver.kernel.org>; Thu, 14 Mar 2019 05:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="j941Sds8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfCNFq7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:46:59 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36256 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfCNFq7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Mar 2019 01:46:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4F3F5BC1
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Mar 2019 05:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d6dCkW2cKASi for <linux-hyperv@vger.kernel.org>;
        Thu, 14 Mar 2019 00:46:58 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1DCDFBB1
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Mar 2019 00:46:58 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id v125so3601539itc.4
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Mar 2019 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lFBvHFrXAL0eimKSp+hFYJLmZ6C2x3iSkcwzXmsag2U=;
        b=j941Sds84VzuR7SeNTbNS8+Hi5T5qBjqFD930mLELOEkUXi7dOvpwGKpFpr3yF5CsY
         +/aO54dZDBluqv0a/cOst7UFsfp94hioSBGXOIS+i42pxCuPbpKpsmMZEONHZU/hBxbv
         0F4w7Vrubj6Sn0IGIB4i5GnWNLgAU4hN/4aiVDrj7XnyZpkB3dk7AQF3LdnXMFTDm1Od
         gkcp7i4BjoCL+oHvX4L8x6OfdVlXMkQpvs/RSPbf8/vz68x0T62NUN2IfTcGiQ3wltn/
         BQJaKQO2+iOZfGiAmm/xWa4Au1cGLXCQZrl0UAFTb48W3L2hi7Ig3j8zSNa5/Qqx234V
         WGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lFBvHFrXAL0eimKSp+hFYJLmZ6C2x3iSkcwzXmsag2U=;
        b=IKVM+ZlnfIXHlNhZiMymMKMRm5y+7xIbyyt/0TyEpHIR8mmrRZPJRKF3k4qIfS26Zk
         ZHCU7JM8dmLOpGurjOieMF+RAGmVelhMFoEaWAJa6nmWIsvYIzIuJo8bt4dShs7voTIS
         aaXm/pyMdhjmecI66dyUPTpi6PHiChzsUh4Hx3lUDEHm2CUy+KUIHJiGW/MMuJqboSbW
         gqY6gAZ7a9H5XhYXS6Ke/VmK35iFUkAfHo//7gxWaSqgqPMqJvxCHDeiXl+/a9Y65sr4
         6K1A3zyjYx2NOvWoqWH9qmQXH4xykgLbt/SB38/aV2XYE/iwQ9CmgeLRcAixXwKztN1A
         gkgg==
X-Gm-Message-State: APjAAAV0yBzBxTid6ahCzSNJzUEIpiWH0nu/TKhPnas8Ze+tdQ9Q7Yyl
        HskiqRk5lBEdFRPZF0RJa9BAOi75d7CJZXj3dh6ipLa/A7ukVVvNe6k3nB88UkZYTBdYuN6+Fzv
        aofE2YZrbfVL367+7H+m5jha0AlWo
X-Received: by 2002:a24:6588:: with SMTP id u130mr1014843itb.136.1552542417629;
        Wed, 13 Mar 2019 22:46:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+s7feI/hd0LsJz9Cd6v14jsHG38YCGWnFPsvBkygMzaDzo0oCVx1ptz8mDOZkLpzk7LSI/g==
X-Received: by 2002:a24:6588:: with SMTP id u130mr1014828itb.136.1552542417375;
        Wed, 13 Mar 2019 22:46:57 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y16sm5945790ion.64.2019.03.13.22.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:46:56 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hyperv: a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 00:46:51 -0500
Message-Id: <20190314054651.1315-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In case alloc_page, the fix returns -ENOMEM to avoid the potential
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 arch/x86/hyperv/hv_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..dfdb4ce1ae9c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -102,9 +102,13 @@ static int hv_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
+	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(alloc_page(GFP_KERNEL));
+	pg = alloc_page(GFP_KERNEL);
+	if (unlikely(!pg))
+		return -ENOMEM;
+	*input_arg = page_address(pg);
 
 	hv_get_vp_index(msr_vp_index);
 
-- 
2.17.1

