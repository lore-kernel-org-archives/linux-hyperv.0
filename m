Return-Path: <SRS0=U+5x=X5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D193C47404
	for <linux-hyperv@archiver.kernel.org>; Fri,  4 Oct 2019 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256462133F
	for <linux-hyperv@archiver.kernel.org>; Fri,  4 Oct 2019 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570202976;
	bh=+rHNNYut7o8YfUTtQQNfhljadinAJHDEp+EqN59+kGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zzh4760r9EhgyVYJCC+8OI1qaktc8IxZNADt5mDuEsbflymzfcfBX1yuCQGMiPtsm
	 ckB7Czgm3DL2V99z0SXDFG1ZCPQqFfv385Lt4059PW88VdBgI/+fPFIU4uQzZ9PUiJ
	 tDrVt7p5QzAW+KkuxDaO6+9YFfKy0kWFdKMkeORA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbfJDP3g (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfJDP3f (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 11:29:35 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B024820873;
        Fri,  4 Oct 2019 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570202975;
        bh=+rHNNYut7o8YfUTtQQNfhljadinAJHDEp+EqN59+kGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHsckrCN9PJhU9rhwNJbWaQJXBaduSb6iiknS6yefSHeCLPGIIewQveXTgJOsPyz7
         nj78/PUkFKvFLQHNvrQVmzJeA9lcE6T33vf8VBBAD0/2HF6GLtpCizKNAjRuUgERo8
         WHxJRRTx1zCxxhgD0qyx02AyNebnjEqy70gktQq4=
Date:   Fri, 4 Oct 2019 11:29:33 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH 0/2] Drivers: hv: Specify buffer size using Hyper-V page
 size
Message-ID: <20191004152933.GI17454@sasha-vm>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
 <DM5PR21MB01377E1E6DE541E902A12EEFD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01377E1E6DE541E902A12EEFD7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 04, 2019 at 11:40:21PM +0000, Michael Kelley wrote:
>From: Himadri Pandya <himadrispandya@gmail.com>  Sent: Wednesday, July 24, 2019 10:03 PM
>>
>> recv_buffer and VMbus ring buffers are sized based on guest page size
>> which Hyper-V assumes to be 4KB. It might not be the case for some
>> architectures. Hence instead use the Hyper-V page size.
>>
>> Himadri Pandya (2):
>>   Drivers: hv: Specify receive buffer size using Hyper-V page size
>>   Drivers: hv: util: Specify ring buffer size using Hyper-V page size
>>
>>  drivers/hv/hv_fcopy.c    |  3 ++-
>>  drivers/hv/hv_kvp.c      |  3 ++-
>>  drivers/hv/hv_snapshot.c |  3 ++-
>>  drivers/hv/hv_util.c     | 13 +++++++------
>>  4 files changed, 13 insertions(+), 9 deletions(-)
>>
>> --
>> 2.17.1
>
>Thomas -- can you pick up this patch set in the x86/hyperv branch
>of your tip tree along with the other patches to fix wrong page size
>assumptions?

I've queued these two for hyperv-next, thanks!

-- 
Thanks,
Sasha
