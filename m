Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD0BC43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989420665
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRiU8g95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfBWQry (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:47:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36573 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBWQry (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Feb 2019 11:47:54 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so7773577itl.1;
        Sat, 23 Feb 2019 08:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxUjnukuIsd15PUgWaJ65KQMVXhYBPKSKR9XEs5Geoo=;
        b=QRiU8g95i1PnOE9ND8FZdk0hd/1djc+W7DzEy2v/saULqijYf2t89i4Uao3JvslBjw
         2YKc7o5iWOYcgeQxWjJytKXYg+iIOu/pY7HunttTRpjkqBbG1aYM+SrymwepXhrMjenz
         JErJ7ySCt3Cbil+b33Utyro7/1yDKRqS3EwLAWjvwemBNbO7AJgimhrOe2shDFDC7yqm
         2m6ROu1t2ZgqXhpG2E3eG0AB1lvY9er7dVMhdWXYrxAV6xUgYZLeD82bN/cPvZIt+X2U
         2zhHun0ts6VybL2F1HMa2G0Q3+byiQDYgjewnhyFLD4lQ0LY383k416dgeS0uB4vkbvB
         Xbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxUjnukuIsd15PUgWaJ65KQMVXhYBPKSKR9XEs5Geoo=;
        b=KH1QX/LBtE5i3d2Wz/PmO9+ZSaGvnZEhl1DmC1MnVtvHmhu1N4628gpXtj3442P1Aq
         Fqldqb7NrZhQaaqXDrPeeODEHBakFi9yhguHaVcTOBp7ZNCkzXMJycHDmP7UoDXCpmmw
         uT7IXFBfy9LvQQL/mfVCXDvV5YNpV2wKbVI+7pWz8wo1XlzBVfhj7UletvTR0uvRdFZH
         7lnoKjM7Yrk8Oft6ww46/BmlOevj7b7DqXDQ4+EIgDoB3DfXtbbw7YwS5/29yT+OmamK
         3Li/MJt1QEpA2ZZAMk4Fg5zIMulKS90pef/zMi7sLo+qzdmjuglpuZ5CmwOTWSY/NJwj
         EUhw==
X-Gm-Message-State: AHQUAuZBwuq2054aor3BvPr20xFQTvsoXHJGXpLWEqVZYUKuE2CJN5uR
        fy2aMYL8o0TI9gN2p5BfjiA=
X-Google-Smtp-Source: AHgI3IY3MVviGCg3z/TNHbjwXbGRWl4Wa8VbEw7rp8OXh7C8GrpAauhY0Y3zVAmLNPShpC+g1d9YWw==
X-Received: by 2002:a24:3449:: with SMTP id z70mr5619047itz.169.1550940472565;
        Sat, 23 Feb 2019 08:47:52 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id s26sm1847557iol.41.2019.02.23.08.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 08:47:51 -0800 (PST)
Date:   Sat, 23 Feb 2019 11:47:49 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@microsoft.com,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190223164748.GA10878@ubu-Virtual-Machine>
References: <20190223031226.AB912206A3@mail.kernel.org>
 <20190223085715.GA22149@kroah.com>
 <20190223155533.GE10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223155533.GE10616@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> 

The correct link to the "Drivers: hv: vmbus: Return -EINVAL if
monitor_allocated not set" patch thread is:

https://lore.kernel.org/lkml/cover.1549619051.git.kimbrownkd@gmail.com/


Also, this patch doesn't fix a race condition; it fixes a problem with
sysfs returning invalid data.



> --
> Thanks,
> Sasha
