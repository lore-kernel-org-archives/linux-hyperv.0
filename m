Return-Path: <SRS0=avBn=Y5=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DABC5DF62
	for <linux-hyperv@archiver.kernel.org>; Tue,  5 Nov 2019 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D360621929
	for <linux-hyperv@archiver.kernel.org>; Tue,  5 Nov 2019 22:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfKEWCi (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:02:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39304 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbfKEWCh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Nov 2019 17:02:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F25CC150689DE;
        Tue,  5 Nov 2019 14:02:36 -0800 (PST)
Date:   Tue, 05 Nov 2019 14:02:36 -0800 (PST)
Message-Id: <20191105.140236.1734049686597934305.davem@davemloft.net>
To:     stephen@networkplumber.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sashal@kernel.org,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] netvsc: RSS related patches
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191101234238.23921-1-stephen@networkplumber.org>
References: <20191101234238.23921-1-stephen@networkplumber.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Nov 2019 14:02:37 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri,  1 Nov 2019 16:42:36 -0700

> Address a couple of issues related to recording RSS hash
> value in skb. These were found by reviewing RSS support.

Series applied.
