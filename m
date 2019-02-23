Return-Path: <SRS0=S9PY=Q6=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B77FC43381
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5CC20675
	for <linux-hyperv@archiver.kernel.org>; Sat, 23 Feb 2019 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550942082;
	bh=L4u+JYosL0416HDGgG/CadYMU1dnTcFf+1A4DHezvZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oSXis5DMEzSu7LJuoL8EliPblPtIMi7lJz55Nj0rnOCnaVjQNr1TumhDBjxREbHDp
	 7ohJZWxbQuqDZMFaKT34ocXiuZZTZgbvjLelYDpIw4HH08pHoe8cR8u9hKpp/TYqN1
	 DVoYxxoqYGyGFO9y1qtF/+gb6IjgKa8QgK5jrr0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfBWROm (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfBWROm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 Feb 2019 12:14:42 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E6A20657;
        Sat, 23 Feb 2019 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550942080;
        bh=L4u+JYosL0416HDGgG/CadYMU1dnTcFf+1A4DHezvZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyajUsP62N88xh+td+G5iEvATN98RhTdApc1od3jwX7nqzpWi125iSEHKUD9VS42Z
         rhXMiyzYnOl7U6AcRLQwWUqt3ABV03AOmnFrV0rxMlvW2NlW5uOiHbeWXuy8kpXgPC
         aUzyoC9SOEaPCCdio+08Fx1oJri5awX4tQHNPLy4=
Date:   Sat, 23 Feb 2019 12:14:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@microsoft.com,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0-rc
Message-ID: <20190223171439.GF10616@sasha-vm>
References: <20190223031226.AB912206A3@mail.kernel.org>
 <20190223085715.GA22149@kroah.com>
 <20190223155533.GE10616@sasha-vm>
 <20190223164748.GA10878@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190223164748.GA10878@ubu-Virtual-Machine>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Feb 23, 2019 at 11:47:49AM -0500, Kimberly Brown wrote:
>On Sat, Feb 23, 2019 at 10:55:33AM -0500, Sasha Levin wrote:
>> On Sat, Feb 23, 2019 at 09:57:15AM +0100, Greg KH wrote:
>> > On Fri, Feb 22, 2019 at 10:12:25PM -0500, Sasha Levin wrote:
>> > > -----BEGIN PGP SIGNED MESSAGE-----
>> > > Hash: SHA512
>> > >
>> > > The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:
>> > >
>> > >   Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)
>> > >
>> > > are available in the Git repository at:
>> > >
>> > >   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
>> > >
>> > > for you to fetch changes up to b2946cd86f3c1b5b1262c0ec06068110c2328fe6:
>> > >
>> > >   MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS (2019-02-22 21:46:37 -0500)
>> > >
>> > > - ----------------------------------------------------------------
>> > > Two fixes:
>> > >
>> > > 1. A fix for a race condition reading sysfs entries while a device is
>> > > being added, by Kimberly Brown.
>> > >
>> > > 2. Update the Hyper-V mailing list to a new one created on
>> > > vger.kernel.org, by Haiyang Zhang.
>> > >
>> > > - ----------------------------------------------------------------
>> > > Haiyang Zhang (1):
>> > >       MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
>> > >
>> > > Kimberly Brown (2):
>> > >       Drivers: hv: vmbus: Change server monitor_pages index to 0
>> > >       Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set
>> >
>> > I objected to this last patch when it was posted on the list.  The sysfs
>> > file should just not be present if the functionality is not there, no
>> > need to add the "-EINVAL" logic to it instead.
>> >
>> > Having a sysfs file that says it can be read, and then rejecting that
>> > read with an error is NOT ok.
>>
>> Hm, I'm sorry but I didn't see an objection on the thread
>> (https://lore.kernel.org/lkml/20190122020759.GA4054@ubu-Virtual-Machine/)
>> which is why it was sent in like this.
>>
>> Could you please point me to it so we can get the patch fixed up?
>>
>
>The correct link to the "Drivers: hv: vmbus: Return -EINVAL if
>monitor_allocated not set" patch thread is:
>
>https://lore.kernel.org/lkml/cover.1549619051.git.kimbrownkd@gmail.com/
>
>
>Also, this patch doesn't fix a race condition; it fixes a problem with
>sysfs returning invalid data.

You're right, I had your other patch in mind when I wrote that log
message.

Are you familiar with Greg's objection to the patch? It's not in the
thread you linked to either.

--
Thanks,
Sasha
