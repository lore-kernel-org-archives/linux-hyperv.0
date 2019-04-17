Return-Path: <SRS0=V+x0=ST=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDFC282DA
	for <linux-hyperv@archiver.kernel.org>; Wed, 17 Apr 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7475F2177B
	for <linux-hyperv@archiver.kernel.org>; Wed, 17 Apr 2019 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555504920;
	bh=FJrKbDioiV0SL5m9INC3XNxsrDX0hb9Lywvvj74//Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xfm+t8uUPDrzqK6tAgOYaU/rdQgWZMyTZlysmvakVH9uU0IpIyMdfg8dg4xQPC3oT
	 OS4zisRjCVOd8huSEc4UPAm7o3nxRjFxHLfwhtu+7dxuDl++SOLmAaPqDDYciHTubA
	 f3dfLk+SWN02AxkrjRYp/1gg6UorRWLogStcoGn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfDQMmA (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfDQMl7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Apr 2019 08:41:59 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050A621773;
        Wed, 17 Apr 2019 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555504919;
        bh=FJrKbDioiV0SL5m9INC3XNxsrDX0hb9Lywvvj74//Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4/4z5TO6B7zQTJzb1iF1w6WOp4k52WK51ny9oSXbzCFxXAj1hunrZCm01zBnnaIa
         lY/37N+FoFIT+AIQH14r+dfqMPeJ91RoYJZRGVo7qBZAJc1IolxFtl17eX3Hw8fdJX
         nou7wvL+m241FOb3/y9UbS5aikGxQzW+KhcfS+Z8=
Date:   Wed, 17 Apr 2019 08:41:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.1
Message-ID: <20190417124157.GA28651@sasha-vm>
References: <20190417013452.438FA20821@mail.kernel.org>
 <20190417062854.GA24045@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190417062854.GA24045@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 17, 2019 at 08:28:54AM +0200, Greg KH wrote:
>On Tue, Apr 16, 2019 at 09:34:51PM -0400, Sasha Levin wrote:
>>  2. Fix to show monitor data only when monitor pages are actually
>> allocated, also by Kimberly Brown.
>
>That's not really a "fix", more like a "new feature", right?

This is (sadly) a fix; we access invalid memory or leak kernel memory to
userspace if we access the monitor sysfs files when there are no monitor
pages allocated.

>>  drivers/hv/vmbus_drv.c                   | 166 +++++++++++++++++++++++++------
>A patch this big so late in the release cycle is not good.

Indeed, but I've had it in my queue for a few weeks now so it's been
receiving a good amount of testing - it's not something we came up with
a few days ago.

>Can you drop this one and resend the others?  If you sent this as a
>patch series, I could have done it that way on my own :)

I would prefer if you could take it in. While it's on the bigger side, a
lot of it is documentation (and comments!), and the code itself is
straightforward and was well reviewed over 6 iterations of the original
patch.

--
Thanks,
Sasha
