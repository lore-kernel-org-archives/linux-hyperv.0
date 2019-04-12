Return-Path: <SRS0=mnmO=SO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E993C10F0E
	for <linux-hyperv@archiver.kernel.org>; Fri, 12 Apr 2019 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AD3206BA
	for <linux-hyperv@archiver.kernel.org>; Fri, 12 Apr 2019 07:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDLHwu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:52:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHwu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Apr 2019 03:52:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so10608359wrw.13
        for <linux-hyperv@vger.kernel.org>; Fri, 12 Apr 2019 00:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CxWzN6LyKcfU1M+CVUsLMOF2rxsiGWvfk71D5m5Wq54=;
        b=WGBKCVRbyKRjJDws5EpkmggXv5JXkaWsBB7F282fcXqbRcodJOIx/cpFIkd4rPi/v0
         7YKmrmKbFirD3gZGSiBO5uq0EuU6tkxJb+ApM47FnZOl0Hr+BdXwWgE6C9b8+yb89xe4
         aAvMXf1S+clMeGteKIkJnQ66dkvBJwwHCDtv4QoqnxwF3Wh7bl3Ek5SYVDfHFQSosYPQ
         sZHj44imE0n+AP3WomEOQXODAxQuDViZl/iRtjru0oa/3A9gqS83Of2rTVnNSG2RXdwq
         fjDG43YCzZ+ewM14uUnk+jTbJRlugKnvLbg919jyPICgX8V5YfPg+qxE1SBp6KA8aEOd
         4Frw==
X-Gm-Message-State: APjAAAVBS/bBG502y1q5Yfewel28KrT1bsi1bIwCPlk7KSBhjpIxL3x6
        IEKw9a2u4sH7viO7hnIM8x1efA==
X-Google-Smtp-Source: APXvYqzcUr7wS9V3i8t5eW0QD11fqERx5EY7if38085vtKD3xI6dPFND4CwKAkqAvLOduDZ5nswEiw==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr16190394wrr.145.1555055568684;
        Fri, 12 Apr 2019 00:52:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id z84sm8869363wmg.24.2019.04.12.00.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:52:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
Date:   Fri, 12 Apr 2019 09:52:47 +0200
Message-ID: <87mukvfynk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> On Fri, Apr 05, 2019 at 01:31:02PM +0200, Vitaly Kuznetsov wrote:
>> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
>> 
>> > @@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>> >  u32 hv_max_vp_index;
>> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>> >  
>> > +struct kmem_cache *cachep;
>> > +EXPORT_SYMBOL_GPL(cachep);
>> > +
>> >  static int hv_cpu_init(unsigned int cpu)
>> >  {
>> >  	u64 msr_vp_index;
>> >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> >  	void **input_arg;
>> > -	struct page *pg;
>> >  
>> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>> > -	pg = alloc_page(GFP_KERNEL);
>> > -	if (unlikely(!pg))
>> > +	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);
>> 
>> I'm not sure use of kmem_cache is justified here: pages we allocate are
>> not cache-line and all these allocations are supposed to persist for the
>> lifetime of the guest. In case you think that even on x86 it will be
>> possible to see PAGE_SIZE != HV_HYP_PAGE_SIZE you can use alloc_pages()
>> instead.
>> 
> Thank you for your feedback, Vitaly!
>
> Will you please tell me how cache-line relates to kmem_cache?
>
> I understand that alloc_pages() would work when PAGE_SIZE <=
> HV_HYP_PAGE_SIZE, but I think that it would not work if PAGE_SIZE >
> HV_HYP_PAGE_SIZE.

Sorry, my bad: I meant to say "not cache-like" (these allocations are
not 'cache') but the typo made it completely incomprehensible. 

>
>> Also, in case the idea is to generalize stuff, what will happen if
>> PAGE_SIZE > HV_HYP_PAGE_SIZE? Who will guarantee proper alignment?
>> 
>> I think we can leave hypercall arguments, vp_assist and similar pages
>> alone for now: the code is not going to be shared among architectures
>> anyways.
>> 
> About the alignment, kmem_cache_create() aligns memory with its third
> parameter, offset.

Yes, I know, I was trying to think about a (hypothetical) situation when
page sizes differ: what would be the memory alignment requirements from
the hypervisor for e.g. hypercall arguments? In case it's always
HV_HYP_PAGE_SIZE we're good but could it be PAGE_SIZE (for e.g. TLB
flush hypercall)? I don't know. For x86 this discussion probably makes
no sense. I'm, however, struggling to understand what benefit we will
get from the change. Maybe just leave it as-is for now and fix
arch-independent code only? And later, if we decide to generalize this
code, make another approach? (Not insisting, just a suggestion)

>
>> > @@ -338,7 +349,10 @@ void __init hyperv_init(void)
>> >  	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
>> >  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>> >  
>> > -	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
>> > +	hv_hypercall_pg = kmem_cache_alloc(cachep, GFP_KERNEL);
>> > +	if (hv_hypercall_pg)
>> > +		set_memory_x((unsigned long)hv_hypercall_pg, 1);
>> 
>> _RX is not writeable, right?
>> 
> Yes, you are correct. I should use set_memory_ro() in addition to
> set_memory_x().
>
>> > @@ -416,6 +431,7 @@ void hyperv_cleanup(void)
>> >  	 * let hypercall operations fail safely rather than
>> >  	 * panic the kernel for using invalid hypercall page
>> >  	 */
>> > +	kmem_cache_free(cachep, hv_hypercall_pg);
>> 
>> Please don't do that: hyperv_cleanup() is called on kexec/kdump and
>> we're trying to do the bare minimum to allow next kernel to boot. Doing
>> excessive work here will likely lead to consequent problems (we're
>> already crashing the case it's kdump!).
>> 
> Thank you for the explanation! I will remove that.
>

-- 
Vitaly
