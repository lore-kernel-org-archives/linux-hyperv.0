Return-Path: <SRS0=F1By=XC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F8C43331
	for <linux-hyperv@archiver.kernel.org>; Sat,  7 Sep 2019 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A0218AC
	for <linux-hyperv@archiver.kernel.org>; Sat,  7 Sep 2019 15:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfIGPnP (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:43:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46338 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390200AbfIGPnP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Sep 2019 11:43:15 -0400
Received: from localhost (unknown [88.214.184.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 04F64152F1AC6;
        Sat,  7 Sep 2019 08:43:09 -0700 (PDT)
Date:   Sat, 07 Sep 2019 17:43:08 +0200 (CEST)
Message-Id: <20190907.174308.789173738819323314.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2, 0/2] Enable sg as tunable, sync offload
 settings to VF NIC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1567725722-33552-1-git-send-email-haiyangz@microsoft.com>
References: <1567725722-33552-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Sep 2019 08:43:12 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Thu, 5 Sep 2019 23:22:58 +0000

> This patch set fixes an issue in SG tuning, and sync
> offload settings from synthetic NIC to VF NIC.

Series applied to net-next.
