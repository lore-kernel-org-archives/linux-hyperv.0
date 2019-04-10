Return-Path: <SRS0=4LCR=SM=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4DC10F11
	for <linux-hyperv@archiver.kernel.org>; Wed, 10 Apr 2019 22:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224A3217D4
	for <linux-hyperv@archiver.kernel.org>; Wed, 10 Apr 2019 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554937170;
	bh=RyqPxAal45Pdz7I8FwfjoEgf8r/UWZ4dWguC7k2YtlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DpkOvqnAmXQe6StzgmBgVst4sr2ti9vhu/tOME/CiF+TVXfqRrOsafaW/f5QTO9kN
	 WViWERGqrtQ2+cE3T2xZOGgV/48ZlssLC/n/rR4PSgTUmWELOZAPg0J/sauAhCgiiG
	 4HcFzh7LcETAGVZU4QMUGObvNw9iFZV4gD+UZxq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfDJW73 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJW73 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Apr 2019 18:59:29 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5BC2083E;
        Wed, 10 Apr 2019 22:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554937168;
        bh=RyqPxAal45Pdz7I8FwfjoEgf8r/UWZ4dWguC7k2YtlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qn9NYKIziqNrx85z9YXkDHc7ZOSu0DO8LY9OmwwwaUxCJF/yk+gwHPCMd+HnKnTBe
         rUJQONp62Q0SUz3AZFQHQL8TlcgTsmKZC9JUluaVXvvjbwAaFdXfocp5b9bDhEJ2D2
         vnmFwWgm5EWoF5wfhB4am1IDC3jAYOminPUXl8LA=
Date:   Wed, 10 Apr 2019 18:59:27 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: Fix a race condition in
 "_show" functions
Message-ID: <20190410225927.GF11568@sasha-vm>
References: <cover.1550806305.git.kimbrownkd@gmail.com>
 <cover.1552592620.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1552592620.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 14, 2019 at 04:04:52PM -0400, Kimberly Brown wrote:
>This patchset fixes a race condition in the "_show" functions that
>access the channel ring buffers.
>
>Changes in v3:
>Patch 1: Drivers: hv: vmbus: Refactor chan->state if statement
> - Added the “reviewed-by” line from v2.
>
>Patch 2: Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
> - This patch is new. This change allows the new mutex locks in patch 3
>   to be initialized when the channel is initialized.
>
>Patch 3: Drivers: hv: vmbus: Fix race condition with new
>         ring_buffer_info mutex
> - Added two ring buffer info mutex locks instead of the single channel
>   mutex lock that was proposed in v2.
> - Changed the mutex acquire/release calls as needed for the new ring
>   buffer info mutex locks.
> - Updated the commit message.
>
>
>Changes in v2:
> - In v1, I proposed using “vmbus_connection.channel_mutex” in the
>   “_show” functions to prevent the race condition. However, using this
>   mutex could result in a deadlock, so a new approach is proposed in
>   this patchset.
> - Patch 1 is new and consists of refactoring an if statement.
> - Patch 2 introduces a new mutex lock in the “vmbus_channel” struct,
>   which is used to eliminate the race condition.
>
>Kimberly Brown (3):
>  Drivers: hv: vmbus: Refactor chan->state if statement
>  Drivers: hv: vmbus: Set ring_info field to 0 and remove memset
>  Drivers: hv: vmbus: Fix race condition with new ring_buffer_info mutex
>
> drivers/hv/channel_mgmt.c |  2 +
> drivers/hv/hyperv_vmbus.h |  1 +
> drivers/hv/ring_buffer.c  | 22 ++++++++--
> drivers/hv/vmbus_drv.c    | 89 +++++++++++++++++++++++++++------------
> include/linux/hyperv.h    |  7 ++-
> 5 files changed, 88 insertions(+), 33 deletions(-)

Queued up, thanks Kimberly!

--
Thanks,
Sasha
