Return-Path: <SRS0=8KIH=3O=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FCBC35242
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E802070A
	for <linux-hyperv@archiver.kernel.org>; Sat, 25 Jan 2020 09:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgAYJnk (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:43:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48820 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAYJnk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 04:43:40 -0500
Received: from localhost (unknown [147.229.117.36])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 81DB915A313CD;
        Sat, 25 Jan 2020 01:43:37 -0800 (PST)
Date:   Sat, 25 Jan 2020 10:43:35 +0100 (CET)
Message-Id: <20200125.104335.691207335724358170.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4,net-next, 0/2] hv_netvsc: Add XDP support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1579816355-6933-1-git-send-email-haiyangz@microsoft.com>
References: <1579816355-6933-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 Jan 2020 01:43:39 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Thu, 23 Jan 2020 13:52:33 -0800

> Add XDP support and update related document.

Series applied, thakns.
