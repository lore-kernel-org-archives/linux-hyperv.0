Return-Path: <SRS0=GgkG=RB=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA5C43381
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AD5218D9
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Feb 2019 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfBZWpw (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:45:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33900 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZWpw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Feb 2019 17:45:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA64014F2E69A;
        Tue, 26 Feb 2019 14:45:51 -0800 (PST)
Date:   Tue, 26 Feb 2019 14:45:51 -0800 (PST)
Message-Id: <20190226.144551.1264975286059315553.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for
 coalesced packets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
References: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Feb 2019 14:45:52 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Fri, 22 Feb 2019 18:25:03 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Incoming packets may have IP header checksum verified by the host.
> They may not have IP header checksum computed after coalescing.
> This patch re-compute the checksum when necessary, otherwise the
> packets may be dropped, because Linux network stack always checks it.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied and queued up for -stable.
