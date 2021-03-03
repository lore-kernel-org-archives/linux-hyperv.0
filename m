Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763ABC4332D
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Mar 2021 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4701B64EDF
	for <linux-hyperv@archiver.kernel.org>; Thu,  4 Mar 2021 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445658AbhCDA3w (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:29:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhCCNuG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Mar 2021 08:50:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614779319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pu/3seYMql33mUGXHcZj1oG0qaMLQn8mcgtStwoiQOY=;
        b=qi4UC6hUpKVqsIab1ecHkri1SQfudluavf0CINthr1FLnsNtM5q8rG05RSaCJn+Um9pgwR
        JfB+Vj2/CNZ02GVC22inMEzATHJ+8kPxSW7/R6gewxBgKHq1cQaLnv6iq+ws7baN5OJd9I
        zx5+UaQymkuoSD+q1Ar5CPG7aqqg87o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9E98AC24;
        Wed,  3 Mar 2021 13:48:38 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:48:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Kelley <mikelley@microsoft.com>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH next v4 12/15] printk: introduce a kmsg_dump iterator
Message-ID: <YD+TsR+yiM2RB9Hh@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
 <20210303101528.29901-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303101528.29901-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 2021-03-03 11:15:25, John Ogness wrote:
> Rather than storing the iterator information in the registered
> kmsg_dumper structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller, thus
> allowing lockless use of the kmsg_dump functions.
> 
> Update code that accesses the kernel logs using the kmsg_dumper
> structure to use the new kmsg_dump_iter structure. For kmsg_dumpers,
> this also means adding a call to kmsg_dump_rewind() to initialize
> the iterator.
> 
> All this is in preparation for removal of @logbuf_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Kees Cook <keescook@chromium.org> # pstore

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
