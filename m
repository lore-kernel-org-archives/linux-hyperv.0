Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3545CC4708F
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Jun 2021 19:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEE7613C1
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Jun 2021 19:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFATv1 (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:51:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56462 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFATv0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 15:51:26 -0400
Received: from [10.0.0.178] (c-67-168-106-253.hsd1.wa.comcast.net [67.168.106.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9EB9A20B7178;
        Tue,  1 Jun 2021 12:49:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EB9A20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622576984;
        bh=xXzSz4LZw1/ZO+01nLWKVaD5NSJhnMXplG+1InI/WbI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2uhv/LDXDMRpNcqU4fhFltuwsqIwWI3vZPiHlrprAHTZz0gWvclkmrBLlZ3qxMXg
         BZuyGG/U2J8xUHnhDXk81CoM2e+3eoonuPfu0kqzW4JVbY9TUdtpWEXh/sNhCFDIpk
         lZoomm+Z/zVX7uB60TgS/Gd5q9tQz7xRBLItZzpw=
Subject: Re: [PATCH 12/19] drivers/hv: run vp ioctl and isr
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        vkuznets@redhat.com, ligrassi@microsoft.com, kys@microsoft.com
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-13-git-send-email-nunodasneves@linux.microsoft.com>
 <20210529215548.okh67gtegsa4fd7r@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
Message-ID: <35ef9495-df4e-ef3e-e730-c3708bbfe6bd@linux.microsoft.com>
Date:   Tue, 1 Jun 2021 12:49:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210529215548.okh67gtegsa4fd7r@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/29/2021 2:55 PM, Wei Liu wrote:
> On Fri, May 28, 2021 at 03:43:32PM -0700, Nuno Das Neves wrote:
> [...]
>>  int mshv_synic_init(unsigned int cpu)
>>  {
>>  	union hv_synic_simp simp;
>> @@ -30,7 +126,7 @@ int mshv_synic_init(unsigned int cpu)
>>  	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>>  			     HV_HYP_PAGE_SIZE,
>>                               MEMREMAP_WB);
>> -	if (!msg_page) {
>> +	if (!(*msg_page)) {
> 
> This hunk belongs to the previous patch in which you introduced this
> function, not this one.
> 
> Wei.
> 
Hmm I think I messed up a rebase. Thanks for catching it!
