Return-Path: <SRS0=LHv9=XI=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B12C4CEC9
	for <linux-hyperv@archiver.kernel.org>; Fri, 13 Sep 2019 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D327920692
	for <linux-hyperv@archiver.kernel.org>; Fri, 13 Sep 2019 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfIMUDs (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 13 Sep 2019 16:03:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48654 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUDs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Sep 2019 16:03:48 -0400
Received: from localhost (93-63-141-166.ip28.fastwebnet.it [93.63.141.166])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 963BC1539AD18;
        Fri, 13 Sep 2019 13:03:45 -0700 (PDT)
Date:   Fri, 13 Sep 2019 21:03:43 +0100 (WEST)
Message-Id: <20190913.210343.724088723062134961.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH][PATCH net-next] hv_sock: Add the support of hibernation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1568245042-66967-1-git-send-email-decui@microsoft.com>
References: <1568245042-66967-1-git-send-email-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 13 Sep 2019 13:03:47 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 11 Sep 2019 23:37:27 +0000

> Add the necessary dummy callbacks for hibernation.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> This patch is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> 
> I request this patch should go through Sasha's tree rather than the
> net-next tree.

That's fine:

Acked-by: David S. Miller <davem@davemloft.net>
