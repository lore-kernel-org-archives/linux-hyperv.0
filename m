Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0664C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD84D206B7
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfC1TXV (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:23:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfC1TXU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:23:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B86A714CF153D;
        Thu, 28 Mar 2019 12:23:19 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:23:17 -0700 (PDT)
Message-Id: <20190328.122317.605812187186177051.davem@davemloft.net>
To:     haiyangz@linuxonhyperv.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes,v2] hv_netvsc: Fix unwanted wakeup after
 tx_disable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328.122214.1269115693598269959.davem@davemloft.net>
References: <20190328191637.6698-1-haiyangz@linuxonhyperv.com>
        <20190328.122214.1269115693598269959.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 12:23:20 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Also, your email bounces:

<haiyangz@linuxonhyperv.com>: host mail.linuxonhyperv.com[107.180.71.197] said:
    550 No Such User Here (in reply to RCPT TO command)
