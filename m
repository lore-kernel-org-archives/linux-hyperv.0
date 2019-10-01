Return-Path: <SRS0=SqhV=X2=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF3BECE587
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Oct 2019 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA210215EA
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Oct 2019 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569955910;
	bh=TkSQARMmhlWTbc5qvm3pp5gUetrJdVs8ct3fom+VhaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGCUCaWfjq/NzCVuw6CnepVhq/7KLRfok6IWk3q6KtWU0M9I+BBRs4HTDiUdMRcax
	 B1yCV9MdepxfSL6cjK/Eah3CE34NzWw3bu7gwKRL7ZwfsgYU+HBOmqpWoR7TsPjEOu
	 bMQEf9wEW/EOgjpDyh0YMSWK5qZJfYS9FRuuFW/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfJASvu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfJASvu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:51:50 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0D120B7C;
        Tue,  1 Oct 2019 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955909;
        bh=TkSQARMmhlWTbc5qvm3pp5gUetrJdVs8ct3fom+VhaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Th+fan2bzyZ59Eo3C+edluzWkQORg8a8jpiH5KceQJdAsaiy7JscHoN6yIdKHpmsV
         RRC5Leg+MDq0sKIuBvPW8zaO6++kjd0bVq8+zwPH5XEumYqva0lrRGcZ4zVO3zTLYo
         iS7cE5mIQclvepYaJpBZM80Ths7WNJ7cATClcNTM=
Date:   Tue, 1 Oct 2019 14:51:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2] scsi: storvsc: Add the support of hibernation
Message-ID: <20191001185148.GH8171@sasha-vm>
References: <1569442244-16726-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1569442244-16726-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 25, 2019 at 08:11:08PM +0000, Dexuan Cui wrote:
>When we're in storvsc_suspend(), we're sure the SCSI layer has quiesced the
>scsi device by scsi_bus_suspend() -> ... -> scsi_device_quiesce(), so the
>low level SCSI adapter driver only needs to suspend/resume its own state.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>
>---
>
>This patch is basically a pure Hyper-V specific change and it has a
>build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
>suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
>Hyper-V tree's hyperv-next branch:
>https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
>
>I request this patch should go through Sasha's tree rather than the
>SCSI tree.
>
>In v2:
>	Added Acked-by from Martin.
>
>	@Sasha: I think the patch can go through the hyper-v tree, since
>                we have the Ack from Martin. :-)

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
