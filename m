Return-Path: <SRS0=BF87=C2=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15937C43464
	for <linux-hyperv@archiver.kernel.org>; Thu, 17 Sep 2020 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C625920872
	for <linux-hyperv@archiver.kernel.org>; Thu, 17 Sep 2020 23:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQXVx (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 17 Sep 2020 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgIQXVx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Sep 2020 19:21:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777BC06174A;
        Thu, 17 Sep 2020 16:21:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5733F1365D73C;
        Thu, 17 Sep 2020 16:05:05 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:21:51 -0700 (PDT)
Message-Id: <20200917.162151.1659729424033781238.davem@davemloft.net>
To:     parri.andrea@gmail.com
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, lkmlabelt@gmail.com,
        mikelley@microsoft.com, skarade@microsoft.com,
        juvazq@microsoft.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] hv_netvsc: Add validation for untrusted Hyper-V
 values
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200916094727.46615-1-parri.andrea@gmail.com>
References: <20200916094727.46615-1-parri.andrea@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 17 Sep 2020 16:05:05 -0700 (PDT)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Date: Wed, 16 Sep 2020 11:47:27 +0200

> From: Andres Beltran <lkmlabelt@gmail.com>
> 
> For additional robustness in the face of Hyper-V errors or malicious
> behavior, validate all values that originate from packets that Hyper-V
> has sent to the guest in the host-to-guest ring buffer. Ensure that
> invalid values cannot cause indexing off the end of an array, or
> subvert an existing validation via integer overflow. Ensure that
> outgoing packets do not have any leftover guest memory that has not
> been zeroed out.
> 
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Applied, thank you.
