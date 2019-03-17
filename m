Return-Path: <SRS0=wL2l=RU=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CCC43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 17 Mar 2019 01:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3F1218E0
	for <linux-hyperv@archiver.kernel.org>; Sun, 17 Mar 2019 01:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AID9hOO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCQBtd (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 16 Mar 2019 21:49:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38748 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCQBtc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 16 Mar 2019 21:49:32 -0400
Received: by mail-it1-f194.google.com with SMTP id k193so16518565ita.3;
        Sat, 16 Mar 2019 18:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmEotmm+GdQGzl1fbL9drIiYRUCp/u1tAcuhI+o4qzw=;
        b=AID9hOO6EkpRxcNqi0jacbMZAzyDNGgFJvaAJ3C6pNO9rPRrNxZ/H087u6iwaEosCD
         KfA8H2SdiWyTv/UJdc//F8hBj1eo0LtN6zXaDe9e1iov6QBdH92WP932gt5RQU6K+Y7k
         D+AUtvZRM0RKBgUz9PXc5lzLNpenNr8F2X/lncb6T9hg6UBoDfIVDvLYKqy8NcJJY9Ti
         TvNdPcu7OCqzjum6LGMZCEcIC4zX3HbL+soBtrKIkhEN89F9mufsG4XK679VVYcx8OVS
         4gIPYnQZ1lbMJndIO8MktTJ/GJipyC1kUTFczLbP13927rI9aRJ9ouhKleBXVEnXn0ZM
         0qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmEotmm+GdQGzl1fbL9drIiYRUCp/u1tAcuhI+o4qzw=;
        b=EaLabrEH5U/k+NP2ukuNb/8Zd63AreZNAdViRiuDjGJHMAvtUistkWRfo8YtFx1ulh
         HIE/nn8nMvtuPn8c8ooKC8rdRQPK6k2v+dFkYGCP6Qw5FHg7drv/vWqGUp6Y2J/OlB+Z
         WiJdomq1xpSy5Kzd1k0LpqL3Qtnh2DbWZwWBDYwTkejgAObkCWObfcBJsoxJqGhmYKFO
         d5ILdQaIez9e7XjcO+U6bppv7j5EiY3diF5gpSsZr62RJAzG7x5z6PvDZ7oh8eMRn134
         rjhVzoQJ20quJoLZXkftm9KkvUHcCTn8qaCjd8G/KasGSWLQ950JrHdIOpQlIUq3ZikJ
         pCiQ==
X-Gm-Message-State: APjAAAXaOEGnnL+ObRcGNf3519t3QHKNG233SIdnWVeB3wwctx7mZk/I
        Bog3opngb9hYLXfAviCuOHs=
X-Google-Smtp-Source: APXvYqz7U3q/8bbfXRXd+gMQqCzPrjwauulFdn+oksyFR3k2Y/O9u9z1UIrw7cecbvF/mMUr6WqljQ==
X-Received: by 2002:a02:a589:: with SMTP id b9mr7248428jam.40.1552787371293;
        Sat, 16 Mar 2019 18:49:31 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id 134sm3230284itx.29.2019.03.16.18.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 18:49:30 -0700 (PDT)
Date:   Sat, 16 Mar 2019 21:49:28 -0400
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
Message-ID: <20190317014927.GA60356@ubu-Virtual-Machine>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
 <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
 <20190314154533.17c8a362@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314154533.17c8a362@shemminger-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 14, 2019 at 03:45:33PM -0700, Stephen Hemminger wrote:
> On Thu, 14 Mar 2019 13:05:15 -0700
> "Kimberly Brown" <kimbrownkd@gmail.com> wrote:
> 
> > Fix a race condition that can result in a ring buffer pointer being set
> > to null while a "_show" function is reading the ring buffer's data. This
> > problem was discussed here:
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > %2Flkml%2F2018%2F10%2F18%2F779&amp;data=02%7C01%7Csthemmin%40microsoft.com
> > %7C1d7557d667b741bdbb6008d6a8b8620f%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > %7C0%7C636881907217609564&amp;sdata=1bUbLaxsODANM7lCBR8lxyYajNpufuwUW%2FOl
> > vtGu2hU%3D&amp;reserved=0
> > 
> > To fix the race condition, add a new mutex lock to the
> > "hv_ring_buffer_info" struct. Add a new function,
> > "hv_ringbuffer_pre_init()", where a channel's inbound and outbound
> > ring_buffer_info mutex locks are initialized.
> >
> >  ... snip ...  
> 
> Adding more locks will solve the problem but it seems like overkill.
> Why not either use a reference count or an RCU style access for the
> ring buffer?

I agree that a reference count or RCU could also solve this problem.
Using mutex locks seemed like the most straightforward solution, but
I'll certainly switch to a different approach if it's better!

Are you concerned about the extra memory required for the mutex locks,
read performance, or something else?

Thanks,
Kim
