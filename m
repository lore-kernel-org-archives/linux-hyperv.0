Return-Path: <SRS0=yslr=RQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F4AC43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4C2070D
	for <linux-hyperv@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCMVIj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:08:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfCMVIi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Mar 2019 17:08:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC81214D3C789;
        Wed, 13 Mar 2019 14:08:37 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:08:37 -0700 (PDT)
Message-Id: <20190313.140837.1079383755054713181.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_netvsc: fix a possible NULL pointer dereference
 in netvsc_get_ethtool_stats()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190312050149.3032-1-kjlu@umn.edu>
References: <20190312050149.3032-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 Mar 2019 14:08:38 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 12 Mar 2019 00:01:49 -0500

> In case kvmalloc_array fails, we should stop using it to avoid
> NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index cf4897043e83..4b3a03029fe8 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1426,6 +1426,9 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
>  	pcpu_sum = kvmalloc_array(num_possible_cpus(),
>  				  sizeof(struct netvsc_ethtool_pcpu_stats),
>  				  GFP_KERNEL);
> +	if (!pcpu_sum)
> +		return;
> +
>  	netvsc_get_pcpu_stats(dev, pcpu_sum);
>  	for_each_present_cpu(cpu) {
>  		struct netvsc_ethtool_pcpu_stats *this_sum = &pcpu_sum[cpu];

What a surprise it will be when the user's statistics monitoring
software sees values suddenly drop to zero with no error indication
whatsoever.
