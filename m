Return-Path: <SRS0=4eFl=AE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA6C433DF
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Jun 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E3E20768
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Jun 2020 09:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgFWJFI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:05:08 -0400
Received: from verein.lst.de ([213.95.11.211]:38524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgFWJFI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 05:05:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3048568AEF; Tue, 23 Jun 2020 11:05:05 +0200 (CEST)
Date:   Tue, 23 Jun 2020 11:05:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-ID: <20200623090505.GA7518@lst.de>
References: <20200618064307.32739-1-hch@lst.de> <20200618064307.32739-3-hch@lst.de> <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jun 20, 2020 at 07:16:16PM -0700, Andrew Morton wrote:
> On Thu, 18 Jun 2020 08:43:06 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> > page read-only just after the allocation.
> > 
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  
> >  void *alloc_insn_page(void)
> >  {
> > -	void *page;
> > -
> > -	page = vmalloc_exec(PAGE_SIZE);
> > -	if (page) {
> > -		set_memory_ro((unsigned long)page, 1);
> > -		set_vm_flush_reset_perms(page);
> > -	}
> > -
> > -	return page;
> > +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > +			NUMA_NO_NODE, __func__);
> >  }
> >  
> >  /* arm kprobe: install breakpoint in text */
> 
> But why.  I think this is just a cleanup, doesn't address any runtime issue?

It doesn't "fix" an issue - it just simplifies and speeds up the code.
