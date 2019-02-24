Return-Path: <SRS0=i+7F=Q7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E0C43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 08:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278C206BA
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550996234;
	bh=wPBZo+1iRaAN/EZF1gf53btdp4Z1uDOZqqyteg/WJXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZY0XYzbb1VDjxZ7jVpBUBNiRIw4aBwTGIVVZ3b/zhOcCMVP5qDAJ9qsA6ZUPd60Se
	 jAGlW7t9TrMUTGWaTLs4YKM7S4l4TD8c+7+1G1DB+l8slrNmp7eAK+kSMdwZhPzixQ
	 Q0RiylIYMSvi9cdnNCzeydE3xkOLjq+jqi2+mdN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbfBXIRO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 24 Feb 2019 03:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfBXIRO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Feb 2019 03:17:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76E420651;
        Sun, 24 Feb 2019 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550996233;
        bh=wPBZo+1iRaAN/EZF1gf53btdp4Z1uDOZqqyteg/WJXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiqxSy+2j3F0It7x5VmJB2vhntKgJM/t39n5g3VEbyZg6fu+dGOO0ua2Fz1M5u6g8
         lWoOD+xeCSpFjaQhFhqvSeZJafFFVlzgO4mKTOdGPSkc9CmR2yk17HMBEgVbTby99E
         DBXrzipAW+AWyK6pE4bmWd/as2VVHB64Gs+ylrSY=
Date:   Sun, 24 Feb 2019 09:17:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190224081710.GA23894@kroah.com>
References: <20190223031226.AB912206A3@mail.kernel.org>
 <20190223085715.GA22149@kroah.com>
 <20190223155533.GE10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223155533.GE10616@sasha-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Feb 23, 2019 at 10:55:33AM -0500, Sasha Levin wrote:
> On Sat, Feb 23, 2019 at 09:57:15AM +0100, Greg KH wrote:
> > On Fri, Feb 22, 2019 at 10:12:25PM -0500, Sasha Levin wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA512
> > > 
> > > The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
> > > 
> > >   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
> > > 
> > > for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:
> > > 
> > >   MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)
> > > 
> > > - ----------------------------------------------------------------
> > > Two fixes:
> > > 
> > > 1. A fix for a race condition reading sysfs entries while a device is
> > > being added, by Kimberly Brown.
> > > 
> > > 2. Update the Hyper-V mailing list to a new one created on
> > > vger.kernel.org, by Haiyang Zhang.
> > > 
> > > - ----------------------------------------------------------------
> > > Haiyang Zhang (1):
> > >       MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
> > > 
> > > Kimberly Brown (2):
> > >       Drivers: hv: vmbus: Change server monitor_pages index to 0
> > >       Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set
> > 
> > I objected to this last patch when it was posted on the list.  The sysfs
> > file should just not be present if the functionality is not there, no
> > need to add the "-EINVAL" logic to it instead.
> > 
> > Having a sysfs file that says it can be read, and then rejecting that
> > read with an error is NOT ok.
> 
> Hm, I'm sorry but I didn't see an objection on the thread
> (https://lore.kernel.org/lkml/20190122020759.GA4054@ubu-Virtual-Machine/)
> which is why it was sent in like this.
> 
> Could you please point me to it so we can get the patch fixed up?

My response was Message-ID: <20190219061748.GA5819@kroah.com> sent:
	Date: Tue, 19 Feb 2019 07:17:48 +0100
but for some reason I do not see it on lore.kernel.org at all :(

I don't know what happened to it, sorry, it was also cc: to you.

Anyway, it just said what I said here, don't do this type of thing, if
the sysfs file is not valid for a specific device, just do not create
it, do not mess around with returning error values when trying to read
from it.

thanks,

greg k-h
