Return-Path: <SRS0=8KIH=3O=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62016C2D0DB
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1BD2071E
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579988504;
	bh=EkoP8mp3H+BuaFmFH9KUtUPs07vqCNs8nUzXWhJ/RHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QFw8FmaR6nx0MH/cjpQoaA7DNqb3gq7M0kXyaGjjcwaYK6wb5RNlsfgdhT24p8FZM
	 uaMx2lWR2BnhSzTielbcdfHFRgOEctufsqcUaMhK4BeMNc7AFIw5MKrxgjwUEni0Aw
	 E+Y4i5LvGDpPuj/pMnmt2oRjSxbrgtczn/Ro4ZDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAYVlo (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAYVln (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 16:41:43 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1024820716;
        Sat, 25 Jan 2020 21:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579988503;
        bh=EkoP8mp3H+BuaFmFH9KUtUPs07vqCNs8nUzXWhJ/RHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fB4tHrRsWahRKd/nvTJ1BEt7XKx37Je0atpPqw5IvDLj/8ZIV8yuGAi78TtadRd0o
         lXwyikMCVkw8iavUfTkRwpVcQ50vnkb5zWxyiKElaiXX3K6XkkMk3KbF9vCChfRIB3
         mGPuRS9Kqx6R8hnDWcbPcNOFdIvEJfOOwNbd+YTg=
Date:   Sat, 25 Jan 2020 16:41:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH V4] x86/Hyper-V: Balloon up according to request page
 number
Message-ID: <20200125214141.GK1706@sasha-vm>
References: <20200121034912.2725-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052B2248B0F9B92F98A2201D70D0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052B2248B0F9B92F98A2201D70D0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 21, 2020 at 04:36:26AM +0000, Michael Kelley wrote:
>From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, January 20, 2020 7:49 PM
>>
>> Current code has assumption that balloon request memory size aligns
>> with 2MB. But actually Hyper-V doesn't guarantee such alignment. When
>> balloon driver receives non-aligned balloon request, it produces warning
>> and balloon up more memory than requested in order to keep 2MB alignment.
>> Remove the warning and balloon up memory according to actual requested
>> memory size.
>>
>> Fixes: f6712238471a ("hv: hv_balloon: avoid memory leak on alloc_error of 2MB memory
>> block")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued up, thanks!

-- 
Thanks,
Sasha
