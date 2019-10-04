Return-Path: <SRS0=U+5x=X5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD233C47404
	for <linux-hyperv@archiver.kernel.org>; Fri,  4 Oct 2019 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C5C222C2
	for <linux-hyperv@archiver.kernel.org>; Fri,  4 Oct 2019 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570203686;
	bh=8KzOJQ61qeCAa4RoR3AKehrhObB1Pqta11wvcDRH23M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCVocEO5R+v0S12qiJXm806VLBFJBYUvEjnCITeYsUBYE9Jn+DefVc4pvxq8gSF1U
	 so/EJLNM7l2JgGA3nDfPNylJSLsGqp5WZDNukiah/d5GXq/ERAZzCNWR6JQ5DVx9H/
	 cgjinHSrmYurm76n1o3wCYp9Qy4k1xEbndNLr5n4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbfJDPl0 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDPl0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 11:41:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322592133F;
        Fri,  4 Oct 2019 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570203685;
        bh=8KzOJQ61qeCAa4RoR3AKehrhObB1Pqta11wvcDRH23M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eABmywD0FEbmmJHqFTyqAMZ1NMJZZ9xGGBFogBvmSMIRldIEOX9i25SoRSHSjOpz7
         k81USC0qebD6Hg7sAj1DShmSoAZOMpfvbQspdI/p0SnbTRVURWB8aGqqh+YNypOMaK
         wSOpbzMjW/tTEDEuDc+MYaeKsX14dd7CrRFOxsZM=
Date:   Fri, 4 Oct 2019 11:41:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH 0/2] Drivers: hv: Remove dependencies on guest page size
Message-ID: <20191004154124.GJ17454@sasha-vm>
References: <20190730094944.96007-1-himadri18.07@gmail.com>
 <DM5PR21MB01377F433CD767AF5E917EA6D7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01377F433CD767AF5E917EA6D7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 04, 2019 at 11:41:43PM +0000, Michael Kelley wrote:
>From: Himadri Pandya <himadrispandya@gmail.com>
>>
>> Hyper-V assumes page size to be 4KB. This might not be the case on ARM64
>> architecture. The first patch in this patchset introduces a hyer-v
>> specific function for allocating a zeroed page which can have a
>> different implementation on ARM64 to address the issue of different
>> guest and host page sizes. The second patch removes dependencies on
>> guest page size in vmbus by using hyper-v specific page symbol and
>> functions.
>>
>> Himadri Pandya (2):
>>   x86: hv: Add function to allocate zeroed page for Hyper-V
>>   Drivers: hv: vmbus: Remove dependencies on guest page size
>>
>>  arch/x86/hyperv/hv_init.c       |  8 ++++++++
>>  arch/x86/include/asm/mshyperv.h |  1 +
>>  drivers/hv/connection.c         | 14 +++++++-------
>>  drivers/hv/vmbus_drv.c          |  6 +++---
>>  4 files changed, 19 insertions(+), 10 deletions(-)
>>
>> --
>> 2.17.1
>
>Thomas -- can you pick up this patch in the x86/hyperv branch of your
>tip tree along with the other patches to fix wrong page size assumptions?

I'll take it through the hyper-v tree, there's a bunch of similar work
queued up there already.

--
Thanks,
Sasha
