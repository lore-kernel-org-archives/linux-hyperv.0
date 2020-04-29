Return-Path: <SRS0=1R82=6N=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B5EC83000
	for <linux-hyperv@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D8D21973
	for <linux-hyperv@archiver.kernel.org>; Wed, 29 Apr 2020 18:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgD2SLl (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SLl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 14:11:41 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF3C03C1AE;
        Wed, 29 Apr 2020 11:11:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CB3B611F5F61A;
        Wed, 29 Apr 2020 11:11:38 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:11:35 -0700 (PDT)
Message-Id: <20200429.111135.1012491992605250039.davem@davemloft.net>
To:     wei.liu@kernel.org
Cc:     natechancellor@gmail.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        samitolvanen@google.com
Subject: Re: [PATCH v2] hv_netvsc: Fix netvsc_start_xmit's return type
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200429101055.rdrpchkypbkwxscj@debian>
References: <20200428100828.aslw3pn5nhwtlsnt@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
        <20200428175455.2109973-1-natechancellor@gmail.com>
        <20200429101055.rdrpchkypbkwxscj@debian>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Apr 2020 11:11:39 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>
Date: Wed, 29 Apr 2020 11:10:55 +0100

> Do you want this to go through net tree? I can submit it via hyperv tree
> if that's preferred.

I'll be taking this, thanks.
