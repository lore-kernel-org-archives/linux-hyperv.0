Return-Path: <SRS0=O+13=WS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C98C3A5A1
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Aug 2019 22:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E772082F
	for <linux-hyperv@archiver.kernel.org>; Thu, 22 Aug 2019 22:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbfHVWdR (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:33:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49784 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbfHVWdQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 18:33:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E93515394163;
        Thu, 22 Aug 2019 15:33:16 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:33:15 -0700 (PDT)
Message-Id: <20190822.153315.1245817410062415025.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, saeedm@mellanox.com, leon@kernel.org,
        eranbe@mellanox.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v5, 0/6] Add software backchannel and mlx5e HV
 VHCA stats
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566512708-13785-1-git-send-email-haiyangz@microsoft.com>
References: <1566512708-13785-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 15:33:16 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


I applied this patch series already to net-next, what are you doing?
