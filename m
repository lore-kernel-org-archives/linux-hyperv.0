Return-Path: <SRS0=ckcO=RY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DCC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 03:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B0218A1
	for <linux-hyperv@archiver.kernel.org>; Thu, 21 Mar 2019 03:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSL34AFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCUDr4 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:47:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36620 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfCUDr4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 23:47:56 -0400
Received: by mail-io1-f67.google.com with SMTP id f6so4143487iop.3;
        Wed, 20 Mar 2019 20:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=560gdLQ9K5QkP6bOTK3jGWQLe35SKY2rQO0/WiF1Ojw=;
        b=iSL34AFw9dzFRe4U5h4Cg1pgYHWt1iO+0VStGQe1xYQMTiH+hB36qbyuCSYspOc3To
         40IDsIBikJFCYCjFSHYF0q25eJknBWCWeHmlkTab1HPfqkSQY9HkQPWdZDUuQdh+McEs
         vcvkWjcD/W2rlX2C16Rcs3fY3Mt9xfWN1Usrq9Yr3PZycMc0gKlJ73A72+nnhS47hpoz
         pYeJwlapZdPQ+OcIDhXDY8hq7ZjDk350OLVDYapXNeC5NT9RlDzEBMvpCuyqehQtrHYi
         YX0JWOSQFT6mB5khmyVW79izoAWBrfeXN4JmKC+weAmGHuidSh1NL+8XLR/ceo26iBUV
         OLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=560gdLQ9K5QkP6bOTK3jGWQLe35SKY2rQO0/WiF1Ojw=;
        b=OD8++Aeb9vG8ZdGxHuK6aqeiaKum6j7I4A+/smfy6IuylCzY1/VLDCmTQcvpz53ydE
         bTl+wl4kTFSnbRYtPJIsuwvtpZYKhh4Gkf2YGApNMXhBdCHmFlUWfgtFH6THTL1MpJWr
         OkZlH5X5CBtKmNuZ0+HK3obnZGw1//UuGtTYEyP1Dy/sQNAbYEXlsLKa3y5t3fMRdgGl
         mU094M9Hwmuk6qt9Zxk2dnaBNdnCm5IkoHTN1S6L2e4aBOVD6wccc+bToM0/hDuHzPue
         FwOX1tznnx0u8RT4GghR3ZCq1AGYXtiTHMXRI0I3GX+O9Y7qP9nP5SG+LFr7J4/XZQME
         4CDA==
X-Gm-Message-State: APjAAAVY7+FCic00MsQ2RXkRJxbWJ07nOf0wbLK00wPX53FnizPk/ZpD
        c1h3MpR7H0WqbJ7pmEYrokY=
X-Google-Smtp-Source: APXvYqyWCmScoNy/n6e8DX6lgLHz4TUJXFVo0dqIGQZVQHUgY7ZlPX0Bio5mUFQfDN3yOQF1J5BlEg==
X-Received: by 2002:a5d:8049:: with SMTP id b9mr1166774ior.302.1553140075547;
        Wed, 20 Mar 2019 20:47:55 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id v18sm2092974ita.21.2019.03.20.20.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 20:47:54 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:47:52 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Drivers: hv: vmbus: Fix race condition with new
 ring_buffer_info mutex
Message-ID: <20190321034752.GA6828@ubu-Virtual-Machine>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
 <20190314154533.17c8a362@shemminger-XPS-13-9360>
 <20190317014927.GA60356@ubu-Virtual-Machine>
 <20190320130619.07e49c97@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320130619.07e49c97@shemminger-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 20, 2019 at 01:06:19PM -0700, Stephen Hemminger wrote:
> On Sat, 16 Mar 2019 21:49:28 -0400
> Kimberly Brown <kimbrownkd@gmail.com> wrote:
> 
> > On Thu, Mar 14, 2019 at 03:45:33PM -0700, Stephen Hemminger wrote:
> > > On Thu, 14 Mar 2019 13:05:15 -0700
> > > "Kimberly Brown" <kimbrownkd@gmail.com> wrote:
> > >   
> > > > Fix a race condition that can result in a ring buffer pointer being set
> > > > to null while a "_show" function is reading the ring buffer's data. This
> > > > problem was discussed here:
> > > > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > > > %2Flkml%2F2018%2F10%2F18%2F779&amp;data=02%7C01%7Csthemmin%40microsoft.com
> > > > %7C1d7557d667b741bdbb6008d6a8b8620f%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > > > %7C0%7C636881907217609564&amp;sdata=1bUbLaxsODANM7lCBR8lxyYajNpufuwUW%2FOl
> > > > vtGu2hU%3D&amp;reserved=0
> > > > 
> > > > To fix the race condition, add a new mutex lock to the
> > > > "hv_ring_buffer_info" struct. Add a new function,
> > > > "hv_ringbuffer_pre_init()", where a channel's inbound and outbound
> > > > ring_buffer_info mutex locks are initialized.
> > > >
> > > >  ... snip ...    
> > > 
> > > Adding more locks will solve the problem but it seems like overkill.
> > > Why not either use a reference count or an RCU style access for the
> > > ring buffer?  
> > 
> > I agree that a reference count or RCU could also solve this problem.
> > Using mutex locks seemed like the most straightforward solution, but
> > I'll certainly switch to a different approach if it's better!
> > 
> > Are you concerned about the extra memory required for the mutex locks,
> > read performance, or something else?
> 
> Locks in control path are ok, but my concern is performance of the
> data path which puts packets in/out of rings. To keep reasonable performance,
> no additional locking should be added in those paths.
> 
> So if data path is using RCU, can/should the control operations also
> use it?

The data path doesn't use RCU to protect the ring buffers.
