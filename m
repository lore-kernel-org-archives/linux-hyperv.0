Return-Path: <SRS0=G4Ks=UQ=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A755C31E5B
	for <linux-hyperv@archiver.kernel.org>; Mon, 17 Jun 2019 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216362084B
	for <linux-hyperv@archiver.kernel.org>; Mon, 17 Jun 2019 20:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfFQUEN (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:04:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37608 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFQUEN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 16:04:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A9F60150FB19B;
        Mon, 17 Jun 2019 13:04:12 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:04:10 -0700 (PDT)
Message-Id: <20190617.130410.2107901726761819200.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     decui@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, mikelley@microsoft.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hvsock: fix epollout hang from race condition
From:   David Miller <davem@davemloft.net>
In-Reply-To: <MW2PR2101MB11168BA3D46BEC843D694E04C0EB0@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB111697FDA0BEDA81237FECB3C0EB0@MW2PR2101MB1116.namprd21.prod.outlook.com>
        <20190617.115615.91633577273679753.davem@davemloft.net>
        <MW2PR2101MB11168BA3D46BEC843D694E04C0EB0@MW2PR2101MB1116.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Jun 2019 13:04:13 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>
Date: Mon, 17 Jun 2019 19:27:45 +0000

> The patch does not change at all. So, I was hoping we could reapply
> it. But, I have resubmitted the patch. Thanks.

It's easy for me to track things if you just resubmit the patch.

That's why I ask for things to be done this way, it helps my workflow
a lot.

Thank you.
