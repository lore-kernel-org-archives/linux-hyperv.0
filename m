Return-Path: <SRS0=yHP1=TJ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DE8C04AB1
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 May 2019 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A12177B
	for <linux-hyperv@archiver.kernel.org>; Thu,  9 May 2019 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEIU6L (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 9 May 2019 16:58:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40856 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEIU6K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 May 2019 16:58:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ED81014DAEDD7;
        Thu,  9 May 2019 13:58:09 -0700 (PDT)
Date:   Thu, 09 May 2019 13:58:09 -0700 (PDT)
Message-Id: <20190509.135809.630741953977432246.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: Fix data loss upon socket close
From:   David Miller <davem@davemloft.net>
In-Reply-To: <BN6PR21MB0465168DEA6CABA910832A5BC0320@BN6PR21MB0465.namprd21.prod.outlook.com>
References: <BN6PR21MB0465168DEA6CABA910832A5BC0320@BN6PR21MB0465.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 May 2019 13:58:10 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>
Date: Wed, 8 May 2019 23:10:35 +0000

> +static inline void hvs_shutdown_lock_held(struct hvsock *hvs, int mode)

Please do not use the inline keyword in foo.c files, let the compiler decide.

Also, longer term thing, I notice that vsock_remove_socket() is very
inefficient locking-wise.  It takes the table lock to do the placement
test, and takes it again to do the removal.  Might even be racy.
