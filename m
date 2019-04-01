Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3769C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830A620857
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eEIn3lE0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F0u35ap6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDAPCK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:02:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfDAPCJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 11:02:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EEC7D60712; Mon,  1 Apr 2019 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554130929;
        bh=aGsk7hKJOHIKA67xAJTC/YBHMPJYHRKYAdsm/hdvdk0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eEIn3lE0RMrL8w3Lq5qm6KlBTXwb7TVVeoTcD/inV1HWsmWunabxhlrbYyW2bTxkI
         caqpmaAsyxmFzdoevOhCNTF0evyVlp9WyOw0UblCwqJvE+5fYyoZnL8JuIXiKj2xcd
         xMITtsGQTC2mlwNeGnuEDRCaia8wRjOoMXX0ANes=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04ACC60712;
        Mon,  1 Apr 2019 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554130927;
        bh=aGsk7hKJOHIKA67xAJTC/YBHMPJYHRKYAdsm/hdvdk0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F0u35ap6MELfM017+9JyhVGET0uuHnicZ+c4FEuYfzdbaQwgpIaOUvL6DzEL3XOAm
         v7B0XQA1ORECJIO0DgnDE89sOkjqPGYMMwcopvJL6nvcJtxDa01gCQ9dRiZiecHriL
         qwCpSCECwvSjNsFp1qZENkAw+8xkvff89AA5APoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04ACC60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] MAINTAINERS: Fix Hyperv vIOMMU driver file name
To:     Sasha Levin <sashal@kernel.org>
Cc:     lantianyu1986@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, tglx@linutronix.de, mingo@kernel.org,
        konrad.wilk@oracle.com, jpoimboe@redhat.com, peterz@infradead.org,
        jkosina@suse.cz, riel@surriel.com, peterz@infraded.org,
        Tianyu.Lan@microsoft.com, luto@kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <1553581701-25250-1-git-send-email-Tianyu.Lan@microsoft.com>
 <58c16b52-5833-ede0-c4b0-8b8839ef06b2@codeaurora.org>
 <20190401142026.GA2792@sasha-vm>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9d91ee81-f1ec-3326-1c7e-eb0546273249@codeaurora.org>
Date:   Mon, 1 Apr 2019 20:31:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401142026.GA2792@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 4/1/2019 7:50 PM, Sasha Levin wrote:
> On Tue, Mar 26, 2019 at 02:57:09PM +0530, Mukesh Ojha wrote:
>>
>> On 3/26/2019 11:58 AM, lantianyu1986@gmail.com wrote:
>>> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>>
>>> The Hyperv vIOMMU file name should be "hyperv-iommu.c" rather
>>
>> s/vIOMMU/IOMMU
>
> What's wrong with vIOMMU? There's no hardware involved (afaik).


What is that extra `v`, v=>virtual

To be precise , it should be  s/Hyperv vIOMMU file name/Hyper-V stub 
IOMMU driver file name.

Thanks,
Mukesh

>
> -- 
> Thanks,
> Sasha
