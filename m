Return-Path: <SRS0=beEQ=2B=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D8C43603
	for <linux-hyperv@archiver.kernel.org>; Wed, 11 Dec 2019 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6360E22B48
	for <linux-hyperv@archiver.kernel.org>; Wed, 11 Dec 2019 22:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLKWWN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:22:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:32912 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKWWN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Dec 2019 17:22:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B37BE14F6383E;
        Wed, 11 Dec 2019 14:22:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:22:11 -0800 (PST)
Message-Id: <20191211.142211.1624810442420026092.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix tx_table init in rndis_set_subchannel()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576101543-130334-1-git-send-email-haiyangz@microsoft.com>
References: <1576101543-130334-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Dec 2019 14:22:12 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Wed, 11 Dec 2019 13:59:03 -0800

> Host can provide send indirection table messages anytime after RSS is
> enabled by calling rndis_filter_set_rss_param(). So the host provided
> table values may be overwritten by the initialization in
> rndis_set_subchannel().
> 
> To prevent this problem, move the tx_table initialization before calling
> rndis_filter_set_rss_param().
> 
> Fixes: a6fb6aa3cfa9 ("hv_netvsc: Set tx_table to equal weight after subchannels open")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Please format your subject lines properly.

	[PATCH $version $GIT_TREE] $subsystem_prefix: $description

Even the Fixes: tag had the proper subsystem prefix in it.

So your next posting must be of the form:

	[PATCH v2 net] hv_netvsc: Fix tx_table init in rndis_set_subchannel().
