Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B1C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0731E217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeTi4ZrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfDEBNE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:13:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41355 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDEBNE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:13:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so2292328pfd.8;
        Thu, 04 Apr 2019 18:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+5omg05moGUnjvkNUDj9Btx23ZMSVNZ5vRwilYMMMk=;
        b=VeTi4ZrH1JEG6ji2n1q2z7eYBgg+h5RtnlcM0AOvv6pXEMQx0Uq6BMdt8QOHV9/uEH
         xXndBV2xODHsatK/6CVMtGFmdHOD0DsdL/YiOyNJVxvcScAyDT4LC0ZtJzJI0dCp4alP
         OaKRmHjMMBJI5CpVwTvpkQ7fDConiTzAbipm8xlRCqXEpbBCSmnif5jW5bJ2Y1iD9Vl4
         RRB2c3iNtA+VSWx4vq+3WyqXEluM0I0BNT1zfs/lFan/Nrv4x/Dnn6RmmGtOG809FCh6
         PowYyuSFctk5TB7X4biNVV5zvgPjdeK2hx7ZATD1Cj5u5Plmjg+WFrDmdpa4o3qJ8UiQ
         mLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+5omg05moGUnjvkNUDj9Btx23ZMSVNZ5vRwilYMMMk=;
        b=YvyW0G32gqwXe7fFrfyN6mQ48T4qnXZKw/41aJLFIlJUcvZJqXZH5695AV7ucnZOaj
         CGPMcg+oHjNjUuVTHEAfW56iYOG48uSik4lN8/Bx4FoMvwSFIYPuZH8le1/veREOXoaH
         BfA/nnTXBHCUyClAtYWk1GdSTDvNJyblK7rjfiGNpZW6Xma+QnC3aTRf3Uc9PGGz4idx
         /Mry7U1ncIEOEiO+l2pjG77GtVxcCnIr0ble5qQhoQSykVOrEaZb9cMQQIknm/Z3fyjE
         YxeQajTtaJr9/k9BTzhmpxLlGH9R+unKkLAsOPG97I44QjQ04z7E+u/Zey26fVRt2Cj1
         xEpA==
X-Gm-Message-State: APjAAAXjHoNd0kwFreaJYHgbQIm7rG30xjtNb+/hjJ9naul/8awW0h/a
        qaLYsAeDONro0fsUGzF7j2ZwAvGviZqM3g==
X-Google-Smtp-Source: APXvYqxAKWm/w4wPsPFBKtvHhwouhcZH4iAJsmv1SwW9DCH83LoKe+zGlOsPhHkq00MD9DRrumqY9g==
X-Received: by 2002:a62:524e:: with SMTP id g75mr9185528pfb.106.1554426783643;
        Thu, 04 Apr 2019 18:13:03 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id b3sm26993453pfi.82.2019.04.04.18.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:13:02 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:13:02 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page
 definitions
Message-ID: <0532cc63764f11ce726219a38519b4c9bba1e656.1554426040.git.m.maya.nakamura@gmail.com>
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

Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
the Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86.

Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index cdf44aa9a501..44bd68aefd00 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -12,6 +12,16 @@
 #include <linux/types.h>
 #include <asm/page.h>
 
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
+ * of 4096. These definitions are used when communicating with Hyper-V using
+ * guest physical pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on all architectures.
+ */
+#define HV_HYP_PAGE_SHIFT	12
+#define HV_HYP_PAGE_SIZE	BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
+
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -841,7 +851,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.17.1

