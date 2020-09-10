Return-Path: <SRS0=7ZzS=CT=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE439C43461
	for <linux-hyperv@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC55208E4
	for <linux-hyperv@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIJT4R (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIJTz7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 15:55:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EAC061756;
        Thu, 10 Sep 2020 12:55:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0853612A34059;
        Thu, 10 Sep 2020 12:39:08 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:55:53 -0700 (PDT)
Message-Id: <20200910.125553.598018287826728299.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kuba@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        saeedm@mellanox.com, markb@mellanox.com
Subject: Re: [PATCH net 1/2] hv_netvsc: Switch the data path at the right
 time during hibernation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200909040732.18993-1-decui@microsoft.com>
References: <20200909040732.18993-1-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 12:39:08 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Tue,  8 Sep 2020 21:07:32 -0700

> When netvsc_resume() is called, the mlx5 VF NIC has not been resumed yet,
> so in the future the host might sliently fail the call netvsc_vf_changed()
> -> netvsc_switch_datapath() there, even if the call works now.
> 
> Call netvsc_vf_changed() in the NETDEV_CHANGE event handler: at that time
> the mlx5 VF NIC has been resumed.
> 
> Fixes: 19162fd4063a ("hv_netvsc: Fix hibernation for mlx5 VF driver")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied.
