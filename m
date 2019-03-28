Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B89C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147D3206B7
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfC1TVo (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:21:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52728 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1TVo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:21:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F7F0108607D1;
        Thu, 28 Mar 2019 12:21:43 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:21:40 -0700 (PDT)
Message-Id: <20190328.122140.386564208141305518.davem@davemloft.net>
To:     haiyangz@linuxonhyperv.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 12:21:43 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Thu, 28 Mar 2019 17:48:45 +0000

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1a08679..0824155 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -109,6 +109,15 @@ static void netvsc_set_rx_mode(struct net_device *net)
>  	rcu_read_unlock();
>  }
>  
> +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> +				    struct net_device *ndev)

Do not use inline in foo.c files, let the compiler decide.

> @@ -184,6 +193,17 @@ static int netvsc_wait_until_empty(struct netvsc_device *nvdev)
>  	}
>  }
>  
> +static inline void netvsc_tx_disable(struct netvsc_device *nvscdev,
> +				     struct net_device *ndev)
> +{

Likewise.
