Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13077C433E1
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA812076C
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bmera78M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHZUUZ (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:20:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42398 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZUUY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 16:20:24 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B05920B4908;
        Wed, 26 Aug 2020 13:20:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B05920B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598473223;
        bh=EX/DwFAXiHCmLBGtxTOq0U+Q9LW6/6kBb+g19ZDld40=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bmera78MVtkF/OSr/j4ERa4NV3ikXNA5CPNgXnXmYldvTa+elh8oRvWYtcBfIeSww
         jHp0cVUYeg8pOTEsswWJj/X+1/wWQbBdC14ccpMZhVkbmEkdrQ88seEx9M3SMYRpft
         FZNZTwuQXpzNMBBOLxKYAJBrRnu7AUA0AEZd7lpQ=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     iourit@microsoft.com, iouri_t@hotmail.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com,
        gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814131839.u2vy52mtiejtuwcg@liuwe-devbox-debian-v2>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <7db18ff7-e99b-62db-508e-a6054c9ac3f9@linux.microsoft.com>
Date:   Wed, 26 Aug 2020 13:20:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814131839.u2vy52mtiejtuwcg@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 8/14/2020 6:18 AM, Wei Liu wrote:
> On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> [...]
>> +
>> +#include "dxgkrnl.h"
>> +
>> +int dxgadapter_init(struct dxgadapter *adapter, struct hv_device *hdev)
>> +{
>> +	int ret = 0;
>> +	char s[80];
>> +
>> +	UNUSED(s);
> If s is not used, why not just remove it?
>
> Indeed it is not used anywhere in this function. That saves you 80 bytes
> on stack.
>
>> +static int dxgk_destroy_hwcontext(struct dxgprocess *process,
>> +					      void *__user inargs)
>> +{
>> +	/* This is obsolete entry point */
>> +	return ENOTTY;
>> +}
>> +
> Other places have been using negative numbers for errors. I guess you
> want -ENOTTY here too.
>
> Wei.
>
>
