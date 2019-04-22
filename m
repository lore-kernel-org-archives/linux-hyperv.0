Return-Path: <SRS0=dxrV=SY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C7C10F11
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993602087E
	for <linux-hyperv@archiver.kernel.org>; Mon, 22 Apr 2019 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939533;
	bh=IJt2s6aZb0h9l59Whc7fVCDcTaYeMBegY9jTVz4B1WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tCJKAYA2MtYhJ7FYZFMboXH/icOAh2jDlFWpc5eCfWOpLhbZXhJ/np7ay5fP7zKyN
	 Eo28JvcKU74oJ7tRu0loE3O5GxsRFTrssUdrfINMMkeF6LFAMYiL/Wxj4eC9kBfMmP
	 /DeSd+BvJdgQ0Iv1fuZN+0SslZUTWKezjtg19aB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfDVNZd (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDVNZd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Apr 2019 09:25:33 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CAF20693;
        Mon, 22 Apr 2019 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555939532;
        bh=IJt2s6aZb0h9l59Whc7fVCDcTaYeMBegY9jTVz4B1WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQBmks0yF962nCTirms+89Q5fDlfcE8uQTG4HgvrzWxpnyR/miJk/IDGs6a3YV7v/
         2wu+fE3F9aTfuJ9bfhG24SD+p+U3rZawbzVCXUFrAx3sogOQzQoybeKWK8d8J17Fdx
         TFkh4GUQklNz7RA/xKkfEniWuUchslT+zAE4qLZw=
Date:   Mon, 22 Apr 2019 09:25:31 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.1
Message-ID: <20190422132531.GI17719@sasha-vm>
References: <20190417013452.438FA20821@mail.kernel.org>
 <20190417062854.GA24045@kroah.com>
 <20190417124157.GA28651@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190417124157.GA28651@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

ping?

On Wed, Apr 17, 2019 at 08:41:57AM -0400, Sasha Levin wrote:
>On Wed, Apr 17, 2019 at 08:28:54AM +0200, Greg KH wrote:
>>On Tue, Apr 16, 2019 at 09:34:51PM -0400, Sasha Levin wrote:
>>> 2. Fix to show monitor data only when monitor pages are actually
>>>allocated, also by Kimberly Brown.
>>
>>That's not really a "fix", more like a "new feature", right?
>
>This is (sadly) a fix; we access invalid memory or leak kernel memory to
>userspace if we access the monitor sysfs files when there are no monitor
>pages allocated.
>
>>> drivers/hv/vmbus_drv.c                   | 166 +++++++++++++++++++++++++------
>>A patch this big so late in the release cycle is not good.
>
>Indeed, but I've had it in my queue for a few weeks now so it's been
>receiving a good amount of testing - it's not something we came up with
>a few days ago.
>
>>Can you drop this one and resend the others?  If you sent this as a
>>patch series, I could have done it that way on my own :)
>
>I would prefer if you could take it in. While it's on the bigger side, a
>lot of it is documentation (and comments!), and the code itself is
>straightforward and was well reviewed over 6 iterations of the original
>patch.
>
>--
>Thanks,
>Sasha
