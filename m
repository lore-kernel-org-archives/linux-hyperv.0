Return-Path: <SRS0=R4m1=WT=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136DEC3A5A2
	for <linux-hyperv@archiver.kernel.org>; Fri, 23 Aug 2019 06:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA23233A0
	for <linux-hyperv@archiver.kernel.org>; Fri, 23 Aug 2019 06:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbfHWGLu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:11:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53282 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404124AbfHWGLu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 02:11:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 82F1F153BAEA4;
        Thu, 22 Aug 2019 23:11:49 -0700 (PDT)
Date:   Thu, 22 Aug 2019 23:11:47 -0700 (PDT)
Message-Id: <20190822.231147.260584586705057718.davem@davemloft.net>
To:     saeedm@mellanox.com
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        eranbe@mellanox.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, leon@kernel.org, sashal@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net-next,v5, 0/6] Add software backchannel and mlx5e HV
 VHCA stats
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f7a0ce8822e197ace496a348a14ac6939313d8f6.camel@mellanox.com>
References: <DM6PR21MB133743FB2006A28AE10A170CCAA50@DM6PR21MB1337.namprd21.prod.outlook.com>
        <20190822.153912.2269276523787180347.davem@davemloft.net>
        <f7a0ce8822e197ace496a348a14ac6939313d8f6.camel@mellanox.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 23:11:50 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>
Date: Fri, 23 Aug 2019 05:29:48 +0000

> On Thu, 2019-08-22 at 15:39 -0700, David Miller wrote:
>> From: Haiyang Zhang <haiyangz@microsoft.com>
>> Date: Thu, 22 Aug 2019 22:37:13 +0000
>> 
>> > The v5 is pretty much the same as v4, except Eran had a fix to
>> patch #3 in response to
>> > Leon Romanovsky <leon@kernel.org>.
>> 
>> Well you now have to send me a patch relative to v4 in order to fix
>> that.
>> 
>> When I say "applied", the series is in my tree and is therefore
>> permanent.
>> It is therefore never appropriate to then post a new version of the
>> series.
> 
> Dave, I think you didn't reply back to v4 that the series was applied.
> So that might have created some confusion for Haiyang.

I thought I did, sorry, my bad.
