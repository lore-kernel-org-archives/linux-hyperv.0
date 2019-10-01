Return-Path: <SRS0=SqhV=X2=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37115C352AA
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Oct 2019 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB5221855
	for <linux-hyperv@archiver.kernel.org>; Tue,  1 Oct 2019 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569955365;
	bh=5vQyiBW7N80kC2WfeV1Zs8ny3axRA860TQ7AJAkm2LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xF2S+GtDSiOO36kfxgqYfeujcMu6s429VzjNObazCTn2jW7hhoBqYzVu9OhdLpJkM
	 jv7pNpE/BPV5bYL1iB9p5s9iotr14q3TcxmCYFgoanOj4kAASTxSf+2oDc2qaHoyks
	 0lu47d7zx2uynAxHuCn4lJOQQMVm6MILXQS2DXyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJASmi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfJASmd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:42:33 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344FD2190F;
        Tue,  1 Oct 2019 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955352;
        bh=5vQyiBW7N80kC2WfeV1Zs8ny3axRA860TQ7AJAkm2LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIUjrdp2SYeUvBdnC7UyrFPY67F/naWfSSURodByEzeV+nui3EV3FrXzjtceUD1eD
         YaOdwLLsP+8VY0ssg5LXYoES8zRVOtCW6xLr3G1ddpnzVffqbCOFqswxjqgz7g+FjP
         UzfcHXQQjKpHMjD35pPDyn/VKuG6VjwsdLDj+Sns=
Date:   Tue, 1 Oct 2019 14:42:31 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2] hv_sock: Add the support of hibernation
Message-ID: <20191001184231.GD8171@sasha-vm>
References: <1569447243-27433-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1569447243-27433-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 25, 2019 at 09:34:13PM +0000, Dexuan Cui wrote:
>Add the necessary dummy callbacks for hibernation.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Acked-by: David S. Miller <davem@davemloft.net>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
