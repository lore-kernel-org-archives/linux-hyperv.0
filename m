Return-Path: <SRS0=wn86=75=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D60C433DF
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Jun 2020 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187F020767
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Jun 2020 10:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgFPKdR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:33:17 -0400
Received: from verein.lst.de ([213.95.11.211]:37487 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKdR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:33:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DDF068AEF; Tue, 16 Jun 2020 12:33:13 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:33:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dexuan Cui <decui@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616103313.GA30833@lst.de>
References: <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <20200616072318.GA17600@lst.de> <20200616101807.GO2531@hirez.programming.kicks-ass.net> <20200616102350.GA29684@lst.de> <20200616102412.GB29684@lst.de> <20200616103137.GQ2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616103137.GQ2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:31:37PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 12:24:12PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 16, 2020 at 12:23:50PM +0200, Christoph Hellwig wrote:
> 
> > > > +	hv_hypercall_pg = module_alloc(PAGE_SIZE);
> > > >  	if (hv_hypercall_pg == NULL) {
> > > >  		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> > > >  		goto remove_cpuhp_state;
> > > >  	}
> > > >  
> > > > +	set_memory_ro((unsigned long)hv_hypercall_pg, 1);
> > > > +	set_memory_x((unsigned long)hv_hypercall_pg, 1);
> > > 
> > > The changing of the permissions sucks.  I thought about adding
> > > a module_alloc_prot with an explicit pgprot_t argument.  On x86
> > > alone at least ftrace would also benefit from that.
> 
> How would ftrace benefit from a RX permission? We need to actually write
> to the page first. This HV thing is special in that it lets the host
> write.

sorry, s/ftrace/kprobes/.  See my updated branch here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/module_alloc-cleanup
