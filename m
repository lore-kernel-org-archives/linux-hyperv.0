Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F1C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08DD217D4
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 01:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIz9iBtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfDEBOi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:14:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDEBOi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Apr 2019 21:14:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so2281805pfj.13;
        Thu, 04 Apr 2019 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMNGxbwBsPJSAVuK8BWaUBImmUHtEKnsLU+rO1P39zs=;
        b=ZIz9iBtF0Hv/NcNJd3o7HTXJgedeu5BVCivUuv3c+fkyEQlGS3nmPXoBSeeWERFN6K
         ay6XRl0Bszuz1D7oFj5DrNlk/4oe8j5jBX92ig22LSZq3LPdNut996zlUCVW9KD6z7vi
         5p5+o60mbJv+1BoOTfYxo346aM5T2NDZn47+QQzzGLEos4BFiwagWU/KCYJ4cwQfdPwA
         k02RST1MofP+F6cR4eTMqggthcQiMNTZTPx/GuN4t90vwsASnVgSnud1Whv5rmh7MqKi
         JuVX0G4GSDpERGsh3kR1PAzZJeG2RDuswm/maV47857uHrMrggaD0Mnrm34jes0FIBzS
         84iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMNGxbwBsPJSAVuK8BWaUBImmUHtEKnsLU+rO1P39zs=;
        b=Xb7evgMRbzqs4hRQTU4CvBh+ksRCj3y7dn3YM1/yBdv+o6CFRaKO8ZnYNDW4bgNDDM
         0KyZ6a/ls/XMZlztiOXOB4+qmmZ5VLuye7ssu+lUYAvyLqpnZWznrRQUU8s0LVdUzixY
         txWzP2jnu8nudfkU5ijWuaUxWgWoPRDMXydJ666O1q/oByV0Eli1RsOZ9jvK2ksIfRJi
         MlTGPIKS5nWqnEZOPezibonG5C+eLBypIEhwoul4PLiNg+njftNqD5bqFujUIYAL5KK4
         bSZy1p6EQGS3idEcwmozTQmS14nYj/1Y9AjKCmARXG6k1D+CYY1sqCW+3nR/LM9j0IgI
         uvng==
X-Gm-Message-State: APjAAAX/7zFJCMP6vpamCFGs6V2xQC8YR/CAmX+X4vnkwFXvn3k/+dFC
        Twv7wuJXRjMkCpWa7gmCi04DYU9f+iMBmA==
X-Google-Smtp-Source: APXvYqy7dqqWJr5J5l0NzvRgFSYlPcNnxta5cniQPHacjD6Lb+RSvj0nLPXtqBTtNdxAybw/qYJtpw==
X-Received: by 2002:a65:6212:: with SMTP id d18mr8595981pgv.162.1554426877014;
        Thu, 04 Apr 2019 18:14:37 -0700 (PDT)
Received: from maya190131 ([52.250.109.216])
        by smtp.gmail.com with ESMTPSA id x28sm14215956pgl.38.2019.04.04.18.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 18:14:36 -0700 (PDT)
Date:   Fri, 5 Apr 2019 01:14:35 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with
 kmem_cache_alloc()
Message-ID: <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com>
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

Switch from the function that allocates a single Linux guest page to a
different one to use a Hyper-V page because the guest page size and
hypervisor page size concepts are different, even though they happen to
be the same value on x86.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/hyperv/hv_init.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e4ba467a9fc6..5f946135aa18 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -31,6 +31,7 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <asm/set_memory.h>
 
 #ifdef CONFIG_HYPERV_TSCPAGE
 
@@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
+struct kmem_cache *cachep;
+EXPORT_SYMBOL_GPL(cachep);
+
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
-	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	pg = alloc_page(GFP_KERNEL);
-	if (unlikely(!pg))
+	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);
+
+	if (unlikely(!*input_arg))
 		return -ENOMEM;
-	*input_arg = page_address(pg);
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -122,14 +125,12 @@ static int hv_cpu_init(unsigned int cpu)
 		return 0;
 
 	if (!*hvp)
-		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+		*hvp = kmem_cache_alloc(cachep, GFP_KERNEL);
 
 	if (*hvp) {
 		u64 val;
 
-		val = vmalloc_to_pfn(*hvp);
-		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
-			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
+		val = virt_to_phys(*hvp) | HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
 
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
 	}
@@ -233,17 +234,22 @@ static int hv_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **input_arg;
 	void *input_pg = NULL;
+	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
 
 	local_irq_save(flags);
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 	input_pg = *input_arg;
 	*input_arg = NULL;
 	local_irq_restore(flags);
-	free_page((unsigned long)input_pg);
+	kmem_cache_free(cachep, input_pg);
+	input_pg = NULL;
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
 
+	kmem_cache_free(cachep, *hvp);
+	*hvp = NULL;
+
 	if (hv_reenlightenment_cb == NULL)
 		return 0;
 
@@ -325,6 +331,11 @@ void __init hyperv_init(void)
 		goto free_vp_index;
 	}
 
+	cachep = kmem_cache_create("hyperv_pages", HV_HYP_PAGE_SIZE,
+				   HV_HYP_PAGE_SIZE, 0, NULL);
+	if (!cachep)
+		goto free_vp_assist_page;
+
 	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
 				  hv_cpu_init, hv_cpu_die);
 	if (cpuhp < 0)
@@ -338,7 +349,10 @@ void __init hyperv_init(void)
 	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
+	hv_hypercall_pg = kmem_cache_alloc(cachep, GFP_KERNEL);
+	if (hv_hypercall_pg)
+		set_memory_x((unsigned long)hv_hypercall_pg, 1);
+
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
@@ -346,7 +360,8 @@ void __init hyperv_init(void)
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
-	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
+	hypercall_msr.guest_physical_address = virt_to_phys(hv_hypercall_pg) >>
+		HV_HYP_PAGE_SHIFT;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
 	hv_apic_init();
@@ -416,6 +431,7 @@ void hyperv_cleanup(void)
 	 * let hypercall operations fail safely rather than
 	 * panic the kernel for using invalid hypercall page
 	 */
+	kmem_cache_free(cachep, hv_hypercall_pg);
 	hv_hypercall_pg = NULL;
 
 	/* Reset the hypercall page */
-- 
2.17.1

