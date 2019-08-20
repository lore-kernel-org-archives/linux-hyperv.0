Return-Path: <SRS0=8k6u=WQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9134C3A589
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB88322D6D
	for <linux-hyperv@archiver.kernel.org>; Tue, 20 Aug 2019 19:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTTpu (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:45:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTTpu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 15:45:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2E0A146F0E88;
        Tue, 20 Aug 2019 12:45:49 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:45:49 -0700 (PDT)
Message-Id: <20190820.124549.2048964358332749388.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     jhansen@vmware.com, stefanha@redhat.com, sgarzare@redhat.com,
        netdev@vger.kernel.org, sthemmin@microsoft.com,
        Alexander.Levin@microsoft.com, sashal@kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: Fix a lockdep warning in __vsock_release()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566270830-28981-1-git-send-email-decui@microsoft.com>
References: <1566270830-28981-1-git-send-email-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 20 Aug 2019 12:45:50 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Tue, 20 Aug 2019 03:14:22 +0000

> +static void __vsock_release2(struct sock *sk)

Do not duplicate an entire function just to adjust some aspect of the
lock debugging, please find a cleaner and more minimal way to
implement this fix.
