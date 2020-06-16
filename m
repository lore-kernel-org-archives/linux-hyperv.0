Return-Path: <SRS0=wn86=75=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1225AC433DF
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Jun 2020 10:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE3B20739
	for <linux-hyperv@archiver.kernel.org>; Tue, 16 Jun 2020 10:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgFPKvr (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:51:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53456 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgFPKvq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:51:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EE90F1C0BD2; Tue, 16 Jun 2020 12:51:44 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:51:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Steve Pronovost <spronovo@microsoft.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Iouri Tarassov <iourit@microsoft.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/4] DirectX on Linux
Message-ID: <20200616105133.GD1718@bug>
References: <20200519163234.226513-1-sashal@kernel.org>
 <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
 <CAKMK7uEa0FH5_AyopVH+wpAXOOxoeo8Acck2qwzzyVnq0UuSZA@mail.gmail.com>
 <MWHPR21MB0287145CD511A2FF6DA502A9C7B60@MWHPR21MB0287.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB0287145CD511A2FF6DA502A9C7B60@MWHPR21MB0287.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi!

> Thanks for the discussion. I may not be able to immediately answer all of your questions, but I'll do my best ????.
> 

Could you do something with your email settings? Because this is not how you should use
email on lkml. "[EXTERNAL]" in the subject, top-posting, unwrapped lines...

Thank you,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
