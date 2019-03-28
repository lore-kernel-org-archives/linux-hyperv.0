Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F6C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 04:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF35206C0
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 04:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omDPTgo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfC1EbC (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:31:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36354 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfC1EbB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 00:31:01 -0400
Received: by mail-io1-f67.google.com with SMTP id f6so16080740iop.3;
        Wed, 27 Mar 2019 21:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+/belK3ejYzZvvz9x7FiTI3PQoVx/Ow2x/QOwiUhUk=;
        b=omDPTgo0Bk1VdYEtxiVyT0fGl3cTpcw+pFHUoXeuC3deY4aw65tO8CKlwcoHU2rVUL
         Sme/FH6oTQHzT4nKU5bvEQa3JG5vT/kM3kZx6/CW1U7ZcyohFJWsRuQ8JZJfL11D2G8C
         Lf45Sd5IRMllo+rcE6vnusYCjwsmYTqYKYgHQ1562VPx8fbR7beJDusyQFkYQtHjtzEH
         RXnGQYvJGRiBkPFVqtXnT/lfPcat2unIL8POgB5Cz0jcrj2HCMWEIBD3PQ1H8RWsJmYb
         DE0uyZxoDNsEYrYhPr5a6CG75OJa+z8qgNYc4LJE17ib9caekbNSke4XLV8UcTNHrQRA
         Al5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+/belK3ejYzZvvz9x7FiTI3PQoVx/Ow2x/QOwiUhUk=;
        b=E8vd6q5+EvADwVEeBdH1hGLWHPDHRdToElGdbEAKGpIA5YZC6OZfGHXQ5GqQJoUsQt
         EndaHcU4q07ZugQBuBfRzuvmBOdHA5YPrYeNw465GN1KEUCcqIfhE/JjXF7fPvYGn6En
         ak68GJ5H3cDcSuz+p/ig1/RuzT6E+wKjSoYG1dBAT5wNfHb4qJVg0uf7g0xzYOGKkran
         rlCHMN9sKH7gkfWpyy3bCb3dJLg7BhZ9+lTVPZp1PnSZgo/oGoCpjj01Wo3G1UWddlCf
         uWU41aKIZTTXlZOwEPGRdKRQT/FwwMTOOduwYB49VHlr0qJ4u15cINK8St+1kKwoWM46
         jqIw==
X-Gm-Message-State: APjAAAXQsx8WoyyO4SNqkfq0CPiSpXtZTLFUC3Ky+EfF8ALCOoBIF3Yc
        ESLemS7XpCwpoVWrJ3+izw89sK2I
X-Google-Smtp-Source: APXvYqyns6Vff7kUH+rUID8tZln8mRJVj8o+3pPaCd4oFy0P3i40MDaw4ppYbnTc2ER0O6dZ4KZmgw==
X-Received: by 2002:a5d:87d3:: with SMTP id q19mr27223875ios.29.1553747460974;
        Wed, 27 Mar 2019 21:31:00 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id u204sm1237526ita.33.2019.03.27.21.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 21:31:00 -0700 (PDT)
Date:   Thu, 28 Mar 2019 00:30:57 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Message-ID: <20190328043057.GA2258@ubu-Virtual-Machine>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
 <20190314154533.17c8a362@shemminger-XPS-13-9360>
 <20190317014927.GA60356@ubu-Virtual-Machine>
 <20190320130619.07e49c97@shemminger-XPS-13-9360>
 <20190321034752.GA6828@ubu-Virtual-Machine>
 <DM5PR2101MB091851BC7C55093D388514D9D7420@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091851BC7C55093D388514D9D7420@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 21, 2019 at 04:04:20PM +0000, Michael Kelley wrote:
> From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Wednesday, March 20, 2019 8:48 PM
> > > > > Adding more locks will solve the problem but it seems like overkill.
> > > > > Why not either use a reference count or an RCU style access for the
> > > > > ring buffer?
> > > >
> > > > I agree that a reference count or RCU could also solve this problem.
> > > > Using mutex locks seemed like the most straightforward solution, but
> > > > I'll certainly switch to a different approach if it's better!
> > > >
> > > > Are you concerned about the extra memory required for the mutex locks,
> > > > read performance, or something else?
> > >
> > > Locks in control path are ok, but my concern is performance of the
> > > data path which puts packets in/out of rings. To keep reasonable performance,
> > > no additional locking should be added in those paths.
> > >
> > > So if data path is using RCU, can/should the control operations also
> > > use it?
> > 


Hi Stephen,

Do you have any additional questions or suggestions for this race
condition and the mutex locks? I think that your initial questions were
addressed in the responses below. If there's anything else, please let
me know!

Thanks,
Kim


> > The data path doesn't use RCU to protect the ring buffers.
> 
> My $.02:  The mutex is obtained only in the sysfs path and the "delete
> ringbuffers" path, neither of which is performance or concurrency sensitive. 
> There's no change to any path that reads or writes data from/to the ring
> buffers.  It seems like the mutex is the most straightforward solution to
> preventing sysfs from accessing the ring buffer info while the memory is
> being freed as part of "delete ringbuffers".
> 
> Michael
