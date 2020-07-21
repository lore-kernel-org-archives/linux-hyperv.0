Return-Path: <SRS0=aIJC=BA=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB619C433E3
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jul 2020 03:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4863206E3
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jul 2020 03:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGUDOB (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUDOB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jul 2020 23:14:01 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF08C061794;
        Mon, 20 Jul 2020 20:14:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA4FB1260D092;
        Mon, 20 Jul 2020 19:57:15 -0700 (PDT)
Date:   Mon, 20 Jul 2020 20:14:00 -0700 (PDT)
Message-Id: <20200720.201400.1580393372170110087.davem@davemloft.net>
To:     Song.Chi@microsoft.com
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, kuba@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next] net: hyperv: Add attributes to show TX
 indirection table
From:   David Miller <davem@davemloft.net>
In-Reply-To: <HK0P153MB02751820DD4F8892DEFA13D098780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB02751820DD4F8892DEFA13D098780@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jul 2020 19:57:16 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Chi Song <Song.Chi@microsoft.com>
Date: Tue, 21 Jul 2020 02:37:42 +0000

> +static ssize_t tx_indirection_show(struct device *dev,
> +				   struct device_attribute *dev_attr, char *buf)
> +{
> +	struct net_device *ndev = to_net_dev(dev);
> +	struct net_device_context *ndc = netdev_priv(ndev);
> +	int index = dev_attr - dev_attr_netvsc_dev_attrs;

Reverse christmas tree ordering for local variables please.

> +static void netvsc_attrs_init(void)
> +{
> +	int i;
> +	char buffer[4];

Likewise.
