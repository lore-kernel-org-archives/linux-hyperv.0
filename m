Return-Path: <SRS0=i+7F=Q7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB0C43381
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDAF20661
	for <linux-hyperv@archiver.kernel.org>; Sun, 24 Feb 2019 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WScTtTRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfBXRhS (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 24 Feb 2019 12:37:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54862 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXRhR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Feb 2019 12:37:17 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so8425015itj.4;
        Sun, 24 Feb 2019 09:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gl/k8hSB2GiGWr+iJYWwe+4RNPO8X8l+5GaBoNrGveM=;
        b=WScTtTRwCsEVFIGen6XM4MA95kZlHOwpjKNT06knvTxeOgZ9D1lU9Z+GbHFeGkZ0e+
         2RQ0I7d4Hl/+M7GSEgrhW48CGSpRL3xXmV6Wu775ZfbdEFZmcL/L6wgNvgOaX2XtR8PT
         UDLPEyP0ZEhlddqwDpMO0ocjW1+2FFwaK+winvNH12alIg0F73vRUcdCQUBgFm3twhqR
         sxR9WJa8aXQqaegPN6y5W7CpuCY9+n5W69zty5OHoqWXgwx6ZdQ42T5saToeJpqc4Brf
         6RrHXisAGGBy3/KZhqzXfMchpLqJjx8OoWniVhzX4nrWOWFl0PyyMtejkBA+bfE8HS3p
         Yfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gl/k8hSB2GiGWr+iJYWwe+4RNPO8X8l+5GaBoNrGveM=;
        b=OG4CkY9KciWQlY3ix1rkz0rFhp0CPPHa5SLJWyutfhkI1sUFBTxbuRLuFX8aLk7Vjl
         R/M61n0W3qVUCSjCXOPNtziNh1wOy5FIG0ZlUTS8H58Yvk9CiJjIpDXFSLH2VCV9pLlm
         DKEjFt7s8zX9rZrmGrTQtRZeUi1aWT4eSaq9AlgJMvuhgtk0RvEOIuYxOoHE2DNBRvXa
         8vo6e0dFy2d95rE1c0z31evtXzq+ciOGYV5ld+2uzAeKOBveVjkBGrRwR7KWLvamPjH1
         j9YrnW3Eq/DwtXXgUOmKItfElNH6R8Z0TcdoL22TZjamNrVRsYxyKjepbwQx85TuSMj8
         Y3yQ==
X-Gm-Message-State: AHQUAuZz3FlMNiqTNY7z2bXH7zvPLu3mULPmjS9tJQ7N6exhcidFye4V
        t778E+PmUYj5mJH/dFNSOc0=
X-Google-Smtp-Source: AHgI3Ibt/TY3H3b/3IQjdmDyX0hmdO1t+ueL56XjcArsphCOlxeLbnxlL1uZqMnRy4ZDzBYl2/4Y9Q==
X-Received: by 2002:a02:56d4:: with SMTP id u81mr7237883jad.1.1551029836389;
        Sun, 24 Feb 2019 09:37:16 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id w8sm3867832ita.21.2019.02.24.09.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 09:37:15 -0800 (PST)
Date:   Sun, 24 Feb 2019 12:37:13 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@microsoft.com,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190224173713.GA2243@ubu-Virtual-Machine>
References: <20190223031226.AB912206A3@mail.kernel.org>
 <20190223085715.GA22149@kroah.com>
 <20190223155533.GE10616@sasha-vm>
 <20190224081710.GA23894@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224081710.GA23894@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 24, 2019 at 09:17:10AM +0100, Greg KH wrote:
> On Sat, Feb 23, 2019 at 10:55:33AM -0500, Sasha Levin wrote:
> > On Sat, Feb 23, 2019 at 09:57:15AM +0100, Greg KH wrote:
> > > On Fri, Feb 22, 2019 at 10:12:25PM -0500, Sasha Levin wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA512
> > > > 
> > > > The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
> > > > 
> > > >   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
> > > > 
> > > > for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:
> > > > 
> > > >   MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)
> > > > 
> > > > - ----------------------------------------------------------------
> > > > Two fixes:
> > > > 
> > > > 1. A fix for a race condition reading sysfs entries while a device is
> > > > being added, by Kimberly Brown.
> > > > 
> > > > 2. Update the Hyper-V mailing list to a new one created on
> > > > vger.kernel.org, by Haiyang Zhang.
> > > > 
> > > > - ----------------------------------------------------------------
> > > > Haiyang Zhang (1):
> > > >       MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
> > > > 
> > > > Kimberly Brown (2):
> > > >       Drivers: hv: vmbus: Change server monitor_pages index to 0
> > > >       Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set
> > > 
> > > I objected to this last patch when it was posted on the list.  The sysfs
> > > file should just not be present if the functionality is not there, no
> > > need to add the "-EINVAL" logic to it instead.
> > > 
> > > Having a sysfs file that says it can be read, and then rejecting that
> > > read with an error is NOT ok.
> > 
> > Hm, I'm sorry but I didn't see an objection on the thread
> > (https://lore.kernel.org/lkml/20190122020759.GA4054@ubu-Virtual-Machine/)
> > which is why it was sent in like this.
> > 
> > Could you please point me to it so we can get the patch fixed up?
> 
> My response was Message-ID: <20190219061748.GA5819@kroah.com> sent:
> 	Date: Tue, 19 Feb 2019 07:17:48 +0100
> but for some reason I do not see it on lore.kernel.org at all :(
> 
> I don't know what happened to it, sorry, it was also cc: to you.
> 
> Anyway, it just said what I said here, don't do this type of thing, if
> the sysfs file is not valid for a specific device, just do not create
> it, do not mess around with returning error values when trying to read
> from it.
> 

I didn't receive that email either.

Thanks for the feedback. I'll start looking into a new fix for this.

Kim

> thanks,
> 
> greg k-h
