Return-Path: <SRS0=8KIH=3O=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2FC2D0DB
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA552071E
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579988535;
	bh=tm468yLK258z+vQZXxvZSvh8Ke8beUu1DDpbah1vEM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rhXCgdLc1QJ4lDNwP53RUxqLVjns/s/dwBxM8+CVhHoUfbAn7HaY6lUUhIz/b7dNp
	 NLungzYXCyEIQ5o6A8en2BC4TmgrijYpJyo/GZ/mlqu767F2GGEhG4FNwrGneVHJQJ
	 566Qqfq1LRW6SU0BGBY8uakus8pIWaZjmFOsFWWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgAYVmO (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAYVmO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 16:42:14 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D473B20716;
        Sat, 25 Jan 2020 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579988534;
        bh=tm468yLK258z+vQZXxvZSvh8Ke8beUu1DDpbah1vEM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWnw1/hXdUba87olIdOt0wxcKWcWUcAk9eUpQJJCHimA79OKNS5wd0ESOUhM9GBhw
         d0PeNYeuU/bU0csR07exNDMbWF2MQ5D4rN7c9amodJS2rCCKP6GD516LkCRok8SG7Z
         mrpfMG1waiwUhBAxvVlS4qTxRbnHOuK2XnY4GMqs=
Date:   Sat, 25 Jan 2020 16:42:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>,
        Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Message-ID: <20200125214212.GL1706@sasha-vm>
References: <1579476562-125673-1-git-send-email-decui@microsoft.com>
 <MW2PR2101MB1052AEC27FF7287F5BA81C91D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052AEC27FF7287F5BA81C91D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 20, 2020 at 12:51:51AM +0000, Michael Kelley wrote:
>From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 19, 2020 3:29 PM
>>
>> When a Linux hv_sock app tries to connect to a Service GUID on which no
>> host app is listening, a recent host (RS3+) sends a
>> CHANNELMSG_TL_CONNECT_RESULT (23) message to Linux and this triggers such
>> a warning:
>>
>> unknown msgtype=23
>> WARNING: CPU: 2 PID: 0 at drivers/hv/vmbus_drv.c:1031 vmbus_on_msg_dpc
>>
>> Actually Linux can safely ignore the message because the Linux app's
>> connect() will time out in 2 seconds: see VSOCK_DEFAULT_CONNECT_TIMEOUT
>> and vsock_stream_connect(). We don't bother to make use of the message
>> because: 1) it's only supported on recent hosts; 2) a non-trivial effort
>> is required to use the message in Linux, but the benefit is small.
>>
>> So, let's not see the warning by silently ignoring the message.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> ---
>>
>> In v2 (followed Michael Kelley's suggestions):
>>     Removed the redundant code in vmbus_onmessage()
>>     Added the new enries into channel_message_table[].
>>
>>  drivers/hv/channel_mgmt.c | 21 +++++++--------------
>>  drivers/hv/vmbus_drv.c    |  4 ++++
>>  include/linux/hyperv.h    |  2 ++
>>  3 files changed, 13 insertions(+), 14 deletions(-)
>>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued up, thanks!

-- 
Thanks,
Sasha
