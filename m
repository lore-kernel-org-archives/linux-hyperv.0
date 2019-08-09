Return-Path: <SRS0=COzm=WF=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37295C433FF
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Aug 2019 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BA921773
	for <linux-hyperv@archiver.kernel.org>; Fri,  9 Aug 2019 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHIUmj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:42:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfHIUmj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Aug 2019 16:42:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6822145E7446;
        Fri,  9 Aug 2019 13:42:38 -0700 (PDT)
Date:   Fri, 09 Aug 2019 13:42:38 -0700 (PDT)
Message-Id: <20190809.134238.370705461293465028.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     netdev@vger.kernel.org, haiyangz@microsoft.com,
        sthemmin@microsoft.com, jakub.kicinski@netronome.com,
        sashal@kernel.org, kys@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH net v2] hv_netvsc: Fix a warning of suspicious RCU usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <PU1P153MB0169A6492DCBB490FE7FE52CBFD60@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169A6492DCBB490FE7FE52CBFD60@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Aug 2019 13:42:39 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Fri, 9 Aug 2019 01:58:08 +0000

> This fixes a warning of "suspicious rcu_dereference_check() usage"
> when nload runs.
> 
> Fixes: 776e726bfb34 ("netvsc: fix RCU warning in get_stats")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied.
