Return-Path: <SRS0=/wEv=SD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D0C43381
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91FC20663
	for <linux-hyperv@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfDASFh (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:05:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730440AbfDARNE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 05E1B14B8AF55;
        Mon,  1 Apr 2019 10:13:03 -0700 (PDT)
Date:   Fri, 29 Mar 2019 13:34:43 -0700 (PDT)
Message-Id: <20190329.133443.2076313992847138247.davem@davemloft.net>
To:     haiyangz@linuxonhyperv.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes,v3] hv_netvsc: Fix unwanted wakeup after
 tx_disable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328194036.7279-1-haiyangz@linuxonhyperv.com>
References: <20190328194036.7279-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 10:13:04 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Thu, 28 Mar 2019 19:40:36 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> After queue stopped, the wakeup mechanism may wake it up again
> when ring buffer usage is lower than a threshold. This may cause
> send path panic on NULL pointer when we stopped all tx queues in
> netvsc_detach and start removing the netvsc device.
> 
> This patch fix it by adding a tx_disable flag to prevent unwanted
> queue wakeup.
> 
> Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> Reported-by: Mohammed Gamal <mgamal@redhat.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied and queued up for -stable, thanks.
