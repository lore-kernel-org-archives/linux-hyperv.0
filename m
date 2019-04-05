Return-Path: <SRS0=/IGX=SH=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B59C4360F
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971232186A
	for <linux-hyperv@archiver.kernel.org>; Fri,  5 Apr 2019 11:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDELbH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:31:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45070 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELbH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Apr 2019 07:31:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so7505863wra.12
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Apr 2019 04:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fTBOSUKpnb4iZC2klHF3NUVyOEn0t9VM8wGyJuSdIy8=;
        b=pc/wtmFO8mogPzxZTYyeK0Yx0QKaloV2nFGmsXOh6VcmbT+Q73ZTjPu01PcN5JYIQe
         wRcIUTc1fVKfB6iSiJrozMBvyBYJ4HefixyAlTB+B/Uli4q8eLTli0ApwQ7oZ8sfHiSI
         6Y8deLD4RsTVs1TqOT5qlqb0xTFlonzC3k53Wa3s9jH9XZv4ed5mI4V34GRDykT/MJvp
         sH0Qd83CwQfLjCN2zFtl+JsJN08/Q+btCC70bwTdHAVO0e2NWuKOg7/vJcmvYL7X94kY
         7axZ+3TIij5LFfjz3YMQVWzoHASu+YgPnGULkNAT2yIdeAJ2uMX73sCcQzEi55aSCMaN
         WRIQ==
X-Gm-Message-State: APjAAAV1acdFBn6haf2wxs8QAcrRlu+wxquWqMCgGMc8nu0b46kFRLLn
        LVGRbKY8XtGF7Tm5uIf85LUztQ==
X-Google-Smtp-Source: APXvYqyJQZLVhgZzXy/XWh1fpOWWyB0nheoKBglixP6Qy62FKpVOi6lD5zuIcn1Q1VOF2xT804tUzw==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr8649900wrn.29.1554463864618;
        Fri, 05 Apr 2019 04:31:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n13sm25207808wrw.67.2019.04.05.04.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 04:31:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com>
Date:   Fri, 05 Apr 2019 13:31:02 +0200
Message-ID: <87wok8it8p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Switch from the function that allocates a single Linux guest page to a
> different one to use a Hyper-V page because the guest page size and
> hypervisor page size concepts are different, even though they happen to
> be the same value on x86.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/hyperv/hv_init.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e4ba467a9fc6..5f946135aa18 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -31,6 +31,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> +#include <asm/set_memory.h>
>  
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  
> @@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> +struct kmem_cache *cachep;
> +EXPORT_SYMBOL_GPL(cachep);
> +
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;
>  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>  	void **input_arg;
> -	struct page *pg;
>  
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	pg = alloc_page(GFP_KERNEL);
> -	if (unlikely(!pg))
> +	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);

I'm not sure use of kmem_cache is justified here: pages we allocate are
not cache-line and all these allocations are supposed to persist for the
lifetime of the guest. In case you think that even on x86 it will be
possible to see PAGE_SIZE != HV_HYP_PAGE_SIZE you can use alloc_pages()
instead.

Also, in case the idea is to generalize stuff, what will happen if
PAGE_SIZE > HV_HYP_PAGE_SIZE? Who will guarantee proper alignment?

I think we can leave hypercall arguments, vp_assist and similar pages
alone for now: the code is not going to be shared among architectures
anyways.

> +
> +	if (unlikely(!*input_arg))
>  		return -ENOMEM;
> -	*input_arg = page_address(pg);
>  
>  	hv_get_vp_index(msr_vp_index);
>  
> @@ -122,14 +125,12 @@ static int hv_cpu_init(unsigned int cpu)
>  		return 0;
>  
>  	if (!*hvp)
> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> +		*hvp = kmem_cache_alloc(cachep, GFP_KERNEL);
>  
>  	if (*hvp) {
>  		u64 val;
>  
> -		val = vmalloc_to_pfn(*hvp);
> -		val = (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> +		val = virt_to_phys(*hvp) | HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>  
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
>  	}
> @@ -233,17 +234,22 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned long flags;
>  	void **input_arg;
>  	void *input_pg = NULL;
> +	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
>  
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	input_pg = *input_arg;
>  	*input_arg = NULL;
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +	kmem_cache_free(cachep, input_pg);
> +	input_pg = NULL;
>  
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
>  
> +	kmem_cache_free(cachep, *hvp);
> +	*hvp = NULL;
> +
>  	if (hv_reenlightenment_cb == NULL)
>  		return 0;
>  
> @@ -325,6 +331,11 @@ void __init hyperv_init(void)
>  		goto free_vp_index;
>  	}
>  
> +	cachep = kmem_cache_create("hyperv_pages", HV_HYP_PAGE_SIZE,
> +				   HV_HYP_PAGE_SIZE, 0, NULL);
> +	if (!cachep)
> +		goto free_vp_assist_page;
> +
>  	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
>  				  hv_cpu_init, hv_cpu_die);
>  	if (cpuhp < 0)
> @@ -338,7 +349,10 @@ void __init hyperv_init(void)
>  	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>  
> -	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
> +	hv_hypercall_pg = kmem_cache_alloc(cachep, GFP_KERNEL);
> +	if (hv_hypercall_pg)
> +		set_memory_x((unsigned long)hv_hypercall_pg, 1);

_RX is not writeable, right?

> +
>  	if (hv_hypercall_pg == NULL) {
>  		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  		goto remove_cpuhp_state;
> @@ -346,7 +360,8 @@ void __init hyperv_init(void)
>  
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable = 1;
> -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> +	hypercall_msr.guest_physical_address = virt_to_phys(hv_hypercall_pg) >>
> +		HV_HYP_PAGE_SHIFT;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  
>  	hv_apic_init();
> @@ -416,6 +431,7 @@ void hyperv_cleanup(void)
>  	 * let hypercall operations fail safely rather than
>  	 * panic the kernel for using invalid hypercall page
>  	 */
> +	kmem_cache_free(cachep, hv_hypercall_pg);

Please don't do that: hyperv_cleanup() is called on kexec/kdump and
we're trying to do the bare minimum to allow next kernel to boot. Doing
excessive work here will likely lead to consequent problems (we're
already crashing the case it's kdump!).

>  	hv_hypercall_pg = NULL;
>  
>  	/* Reset the hypercall page */

-- 
Vitaly
