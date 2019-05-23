Return-Path: <SRS0=aNbh=TX=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D5C282CE
	for <linux-hyperv@archiver.kernel.org>; Thu, 23 May 2019 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F82E2089E
	for <linux-hyperv@archiver.kernel.org>; Thu, 23 May 2019 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfEWBBA (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 22 May 2019 21:01:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWBA7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 May 2019 21:00:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1269115043931;
        Wed, 22 May 2019 18:00:59 -0700 (PDT)
Date:   Wed, 22 May 2019 18:00:58 -0700 (PDT)
Message-Id: <20190522.180058.887469871482412864.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, mikelley@microsoft.com, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_sock: perf: loop in send() to maximize
 bandwidth
From:   David Miller <davem@davemloft.net>
In-Reply-To: <BN6PR21MB0465FA591662A8B580AEF7D9C0000@BN6PR21MB0465.namprd21.prod.outlook.com>
References: <BN6PR21MB0465FA591662A8B580AEF7D9C0000@BN6PR21MB0465.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 May 2019 18:00:59 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>
Date: Wed, 22 May 2019 23:10:44 +0000

> Currently, the hv_sock send() iterates once over the buffer, puts data into
> the VMBUS channel and returns. It doesn't maximize on the case when there
> is a simultaneous reader draining data from the channel. In such a case,
> the send() can maximize the bandwidth (and consequently minimize the cpu
> cycles) by iterating until the channel is found to be full.
> 
> Perf data:
> Total Data Transfer: 10GB/iteration
> Single threaded reader/writer, Linux hvsocket writer with Windows hvsocket
> reader
> Packet size: 64KB
> CPU sys time was captured using the 'time' command for the writer to send
> 10GB of data.
> 'Send Buffer Loop' is with the patch applied.
> The values below are over 10 iterations.
 ...
> Observation:
> 1. The avg throughput doesn't really change much with this change for this
> scenario. This is most probably because the bottleneck on throughput is
> somewhere else.
> 2. The average system (or kernel) cpu time goes down by 10%+ with this
> change, for the same amount of data transfer.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Applied.
