Return-Path: <SRS0=fBed=SZ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FCC10F03
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E4E21850
	for <linux-hyperv@archiver.kernel.org>; Tue, 23 Apr 2019 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048707;
	bh=wIuMsal+5nbtzzXII/QbWzVnP02PzQz3dCPnDhAcgZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AOUNmkGrzXj0aOElj4TWj0BXwX7CFlPvE3ooXUxcX5s9H/mH/hq3deHYuNMpuGBIk
	 KBaDT6nqVo3AF6TZc8wjLDorOo+AlKHqq0N/YBRW9Rhg3DnszFyq3Kczymbd2eWejK
	 5x2MgYMY+xPrUl5SiDitHTADoO492ZFqaVOlDeBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfDWTpH (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDWTpH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Apr 2019 15:45:07 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750DC21773;
        Tue, 23 Apr 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556048706;
        bh=wIuMsal+5nbtzzXII/QbWzVnP02PzQz3dCPnDhAcgZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFzGP0wXVUKVjfzcWBTNknEpLsHMMczyaMpkdx0g2ysbWx4mEVtOY1grRmP2yVwzf
         6vpTcTAHHWqjkSNv7bI/fbrlnc6cbH5N/dRjmqKgeJxn9NJiIvNxMozozQDR+LZLyy
         yO6M4yWxVDqOjxhLegTocfj5V5XhiPBm0h5YhKgg=
Date:   Tue, 23 Apr 2019 15:45:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] drivers: input: serio: Add a module desription to
 the hyperv_keyboard driver
Message-ID: <20190423194505.GS17719@sasha-vm>
References: <6a2c2e15e90138fcef67bed294d2e82d8d6f679b.1555967323.git.joseph.salisbury@microsoft.com>
 <DM5PR2101MB0918B570C0BCFF4326428A24D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB0918B570C0BCFF4326428A24D7230@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 23, 2019 at 04:39:00PM +0000, Michael Kelley wrote:
>From: Joseph Salisbury <joseph.salisbury@microsoft.com> Sent: Monday, April 22, 2019 8:47 PM
>>
>> This patch only adds a MODULE_DESCRIPTION statement to the driver.
>> This change is only cosmetic, so there should be no runtime impact.
>>
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
>> ---
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
