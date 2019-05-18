Return-Path: <SRS0=GUoJ=TS=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86EC04AAF
	for <linux-hyperv@archiver.kernel.org>; Sat, 18 May 2019 18:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092F020872
	for <linux-hyperv@archiver.kernel.org>; Sat, 18 May 2019 18:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfERSOa (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sat, 18 May 2019 14:14:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERSOa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 18 May 2019 14:14:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8A90314DE0A2B;
        Sat, 18 May 2019 11:14:29 -0700 (PDT)
Date:   Sat, 18 May 2019 11:14:27 -0700 (PDT)
Message-Id: <20190518.111427.1027480799644374908.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: perf: Allow the socket buffer size options to
 influence the actual socket buffers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <BN6PR21MB046528E2099CDE2C6C2200A7C00B0@BN6PR21MB0465.namprd21.prod.outlook.com>
References: <BN6PR21MB046528E2099CDE2C6C2200A7C00B0@BN6PR21MB0465.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 18 May 2019 11:14:29 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


These two changes really look like net-next material, and net-next is
closed at the moment.

Please resubmit these when net-next opens back up.

Thank you.
