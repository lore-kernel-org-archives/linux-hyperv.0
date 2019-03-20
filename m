Return-Path: <SRS0=DxZm=RX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF8C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B645121841
	for <linux-hyperv@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="JfVC2UZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCTUGX (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:06:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42525 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTUGX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Mar 2019 16:06:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so2687125pfn.9
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Mar 2019 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdDPEIia79uGc35RkRI3ur8MSsWm0kMcfVaI5TTx+RA=;
        b=JfVC2UZ3idGczEJfuKhFb6uueH8DsRD90IWXap15PjjPUEQ/wGnAhKyQm4trxg6KZ/
         6Zgwl+ch6gTyuGc9qGkFeFl93J1D+d+wAmZW+Ho4YNhe2b5T0y7tHQH3DBkWQ6fJbA2C
         0n4dFne4HxAKBDrv5Cufv5ZAKWx0ELuAIhkWZFcAstSPUoi2yWMwhax1MIS77KfgkLej
         UW/pWfnIfUGQ5YxSUBjtrkng1yrESMvw4Z1B0IdgLC43X/mACMGliwnJdRJcIRttlF1o
         cfwYF5Fg4oq9FojaMoOARf7XoHxM+qkS3fe4rATMrX3dIZUTsPM/muRnrSaxajvEUISJ
         8g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdDPEIia79uGc35RkRI3ur8MSsWm0kMcfVaI5TTx+RA=;
        b=F2pvMaLqWPHlKJCYlmRaGDPg3OyaA3YBmK4RaNraH/XQYS9JFCjeMNztuDF8vrWWf2
         IIctIPJ32Tl1JWqAE2R397YXJsCTNsVlXNyVDEXqXVntkA17nwwV2iwmmOidG9vB2vJc
         eZDxxWKHEYXdO43jXZZ5+MKHiILtNysbSArBdt65rFTLU7gN5xq+h3FbwwU+juPnE1V6
         +r+I3VdpPvT9EBbXvaC6Gy008r/J6p0Vrnl/5z6pxAA0pjEX8GYNiXFLeCG0BaKvfPcs
         SnkefninuBFvp4PFqCmNkR697jEUL2afPWqWk2n3IoB0tC5yZveTc5vs9lVSawHHObtK
         FyKA==
X-Gm-Message-State: APjAAAW/+dEfrPcCwBBjCqpK/9/hk4jpqF8TPMxQ8BPhjMS2HcR9RpKa
        OPsqIecOQxDEk80VIuPZ4gq4Fg==
X-Google-Smtp-Source: APXvYqzVedx5gZe6dfDZ+RS3y+wJAKBZ1Y145g8sZk5aggQU82ObyiBMnLWSTbtOXiv/TNQWDIrGSA==
X-Received: by 2002:a65:6483:: with SMTP id e3mr9477237pgv.273.1553112382216;
        Wed, 20 Mar 2019 13:06:22 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id g67sm7237602pfg.13.2019.03.20.13.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:06:22 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:06:19 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
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
Message-ID: <20190320130619.07e49c97@shemminger-XPS-13-9360>
In-Reply-To: <20190317014927.GA60356@ubu-Virtual-Machine>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
        <cover.1552592620.git.kimbrownkd@gmail.com>
        <262046fa9e89d5f483ecd5972d86f4f9608dbcc3.1552592620.git.kimbrownkd@gmail.com>
        <20190314154533.17c8a362@shemminger-XPS-13-9360>
        <20190317014927.GA60356@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 16 Mar 2019 21:49:28 -0400
Kimberly Brown <kimbrownkd@gmail.com> wrote:

> On Thu, Mar 14, 2019 at 03:45:33PM -0700, Stephen Hemminger wrote:
> > On Thu, 14 Mar 2019 13:05:15 -0700
> > "Kimberly Brown" <kimbrownkd@gmail.com> wrote:
> >   
> > > Fix a race condition that can result in a ring buffer pointer being set
> > > to null while a "_show" function is reading the ring buffer's data. This
> > > problem was discussed here:
> > > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > > %2Flkml%2F2018%2F10%2F18%2F779&amp;data=02%7C01%7Csthemmin%40microsoft.com
> > > %7C1d7557d667b741bdbb6008d6a8b8620f%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > > %7C0%7C636881907217609564&amp;sdata=1bUbLaxsODANM7lCBR8lxyYajNpufuwUW%2FOl
> > > vtGu2hU%3D&amp;reserved=0
> > > 
> > > To fix the race condition, add a new mutex lock to the
> > > "hv_ring_buffer_info" struct. Add a new function,
> > > "hv_ringbuffer_pre_init()", where a channel's inbound and outbound
> > > ring_buffer_info mutex locks are initialized.
> > >
> > >  ... snip ...    
> > 
> > Adding more locks will solve the problem but it seems like overkill.
> > Why not either use a reference count or an RCU style access for the
> > ring buffer?  
> 
> I agree that a reference count or RCU could also solve this problem.
> Using mutex locks seemed like the most straightforward solution, but
> I'll certainly switch to a different approach if it's better!
> 
> Are you concerned about the extra memory required for the mutex locks,
> read performance, or something else?

Locks in control path are ok, but my concern is performance of the
data path which puts packets in/out of rings. To keep reasonable performance,
no additional locking should be added in those paths.

So if data path is using RCU, can/should the control operations also
use it?
