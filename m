Return-Path: <SRS0=mnmO=SO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809DC10F0E
	for <linux-hyperv@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552E1205ED
	for <linux-hyperv@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0FXbQwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfDLHYG (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:24:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39946 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHYF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Apr 2019 03:24:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so4759170pgl.7;
        Fri, 12 Apr 2019 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tmac2wD6GD50sbBNm9+eHFKNSGz66kGw4gG02gXCGmg=;
        b=F0FXbQwaxmu957CJTTTXsa2qnTd2YgIhAzLGdCyC9O8wN0CU0KKl8DkyKJg6mo6qt+
         gv9g3cST3nOJpMDwzmPcYTzrOeF/hUyh5plyO0QnZztca3uyi/beol4PtcshD2C9olLv
         RnpgWsi3MRiGzH+2EpjzId8Fnpb/20htzUf/oYqPEGwerswOZOssf+OeJ7VIeiT3hyHx
         7OQCc5USqNUYrWWw48dIobyUcukRlkdmBjCCxZ5/j986TS3G8wPf3fsOrMbUyxqRoNy4
         62IH7MHBLjcMUMm04o1LFLDToqudjFYpUvNg/0bNi5MqfTD3pijnLDi3ODXOmGGdI5AJ
         wkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tmac2wD6GD50sbBNm9+eHFKNSGz66kGw4gG02gXCGmg=;
        b=PdkIIMXfJvewxrMvcn03yubjE6ncmER/5H++pAuqLTMAGb6fKd1ikd8nFHZjI9qBXv
         s4PKW87gYa25jli4oVqnFuvRnYAfXknmNrY+acDugnPLrE6mC34uoTcsR0hbfC3fpqXk
         GiieQfsiJan76RFgStZffO4adb5kqf2yOO73bIRO0d04m169OBvU5cSwnNbKpZoTy7rP
         iPC8i4kttGQIrQTSfBlZ10OMDrxLspdWErvHF5pcEXoc5sYfq0c7vxwXm/8UKvqEHVeR
         1eJdUBOE6MmxS8NPn3Y/LXSYhf6yYDhsU8eBjqzwt6LwJRRpqhZVMeOgZnsg7gOS3BCY
         NRDg==
X-Gm-Message-State: APjAAAX+8bQ5HQLWLhxCmcgAUrwd0c2sSAAQP5SpCD0wipEmXeT8FIKG
        SVKI+WOKSjn1GRtHJdqYm+nbhmRE8sc=
X-Google-Smtp-Source: APXvYqySlz/DhTvJcZ9mx74YH3BupHCt16RjrxQoKfJyGFBl0SG6H8gj29Bl1t7idYXg3DvH5ZnD6Q==
X-Received: by 2002:a63:7843:: with SMTP id t64mr34386417pgc.130.1555053845058;
        Fri, 12 Apr 2019 00:24:05 -0700 (PDT)
Received: from maya190131 ([52.175.207.219])
        by smtp.gmail.com with ESMTPSA id g67sm62711857pfg.94.2019.04.12.00.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:24:04 -0700 (PDT)
Date:   Fri, 12 Apr 2019 07:24:03 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with
 kmem_cache_alloc()
Message-ID: <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com>
 <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com>
 <87wok8it8p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wok8it8p.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 05, 2019 at 01:31:02PM +0200, Vitaly Kuznetsov wrote:
> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> 
> > @@ -98,18 +99,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> >  u32 hv_max_vp_index;
> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> >  
> > +struct kmem_cache *cachep;
> > +EXPORT_SYMBOL_GPL(cachep);
> > +
> >  static int hv_cpu_init(unsigned int cpu)
> >  {
> >  	u64 msr_vp_index;
> >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
> >  	void **input_arg;
> > -	struct page *pg;
> >  
> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	pg = alloc_page(GFP_KERNEL);
> > -	if (unlikely(!pg))
> > +	*input_arg = kmem_cache_alloc(cachep, GFP_KERNEL);
> 
> I'm not sure use of kmem_cache is justified here: pages we allocate are
> not cache-line and all these allocations are supposed to persist for the
> lifetime of the guest. In case you think that even on x86 it will be
> possible to see PAGE_SIZE != HV_HYP_PAGE_SIZE you can use alloc_pages()
> instead.
> 
Thank you for your feedback, Vitaly!

Will you please tell me how cache-line relates to kmem_cache?

I understand that alloc_pages() would work when PAGE_SIZE <=
HV_HYP_PAGE_SIZE, but I think that it would not work if PAGE_SIZE >
HV_HYP_PAGE_SIZE.

> Also, in case the idea is to generalize stuff, what will happen if
> PAGE_SIZE > HV_HYP_PAGE_SIZE? Who will guarantee proper alignment?
> 
> I think we can leave hypercall arguments, vp_assist and similar pages
> alone for now: the code is not going to be shared among architectures
> anyways.
> 
About the alignment, kmem_cache_create() aligns memory with its third
parameter, offset.

> > @@ -338,7 +349,10 @@ void __init hyperv_init(void)
> >  	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> >  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
> >  
> > -	hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
> > +	hv_hypercall_pg = kmem_cache_alloc(cachep, GFP_KERNEL);
> > +	if (hv_hypercall_pg)
> > +		set_memory_x((unsigned long)hv_hypercall_pg, 1);
> 
> _RX is not writeable, right?
> 
Yes, you are correct. I should use set_memory_ro() in addition to
set_memory_x().

> > @@ -416,6 +431,7 @@ void hyperv_cleanup(void)
> >  	 * let hypercall operations fail safely rather than
> >  	 * panic the kernel for using invalid hypercall page
> >  	 */
> > +	kmem_cache_free(cachep, hv_hypercall_pg);
> 
> Please don't do that: hyperv_cleanup() is called on kexec/kdump and
> we're trying to do the bare minimum to allow next kernel to boot. Doing
> excessive work here will likely lead to consequent problems (we're
> already crashing the case it's kdump!).
> 
Thank you for the explanation! I will remove that.

