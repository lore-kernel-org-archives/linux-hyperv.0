Return-Path: <SRS0=/lIm=VW=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05096C76190
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Jul 2019 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41492190F
	for <linux-hyperv@archiver.kernel.org>; Thu, 25 Jul 2019 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGYSqK (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:46:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37090 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSqK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Jul 2019 14:46:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4CF271439868A;
        Thu, 25 Jul 2019 11:46:09 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:46:08 -0700 (PDT)
Message-Id: <20190725.114608.721523278093090514.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Name NICs based on vmbus offer and enable
 async probe by default
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1563908517-55735-1-git-send-email-haiyangz@microsoft.com>
References: <1563908517-55735-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jul 2019 11:46:09 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


1) Subject: line lacks proper subsystem prefix

2) No module parameters in networking drivers, sorry.  Find some generic way to do
   this via devlink or similar.

