Return-Path: <SRS0=C8pJ=X3=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B3FECE587
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Oct 2019 01:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E328D2133F
	for <linux-hyperv@archiver.kernel.org>; Wed,  2 Oct 2019 01:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfJBBX6 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 1 Oct 2019 21:23:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbfJBBX5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 21:23:57 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1003014D65306;
        Tue,  1 Oct 2019 18:23:56 -0700 (PDT)
Date:   Tue, 01 Oct 2019 21:23:55 -0400 (EDT)
Message-Id: <20191001.212355.540884408544073853.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, stefanha@redhat.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, deepa.kernel@gmail.com, ytht.net@gmail.com,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mikelley@microsoft.com, sgarzare@redhat.com, jhansen@vmware.com
Subject: Re: [PATCH net v3] vsock: Fix a lockdep warning in
 __vsock_release()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1569868998-56603-1-git-send-email-decui@microsoft.com>
References: <1569868998-56603-1-git-send-email-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Oct 2019 18:23:56 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Mon, 30 Sep 2019 18:43:50 +0000

> Lockdep is unhappy if two locks from the same class are held.
> 
> Fix the below warning for hyperv and virtio sockets (vmci socket code
> doesn't have the issue) by using lock_sock_nested() when __vsock_release()
> is called recursively:
 ...
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks.
