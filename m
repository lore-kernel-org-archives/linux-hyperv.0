Return-Path: <SRS0=3+ow=UO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99322C31E44
	for <linux-hyperv@archiver.kernel.org>; Sat, 15 Jun 2019 02:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C50E20850
	for <linux-hyperv@archiver.kernel.org>; Sat, 15 Jun 2019 02:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfFOCrn (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:47:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57704 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOCrn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 22:47:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9260212B05D34;
        Fri, 14 Jun 2019 19:47:42 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:47:42 -0700 (PDT)
Message-Id: <20190614.194742.1040162810429209822.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Set probe mode to sync
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1560459955-37900-1-git-send-email-haiyangz@microsoft.com>
References: <1560459955-37900-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 19:47:42 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Thu, 13 Jun 2019 21:06:53 +0000

> For better consistency of synthetic NIC names, we set the probe mode to
> PROBE_FORCE_SYNCHRONOUS. So the names can be aligned with the vmbus
> channel offer sequence.
> 
> Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv drivers")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied and queued up for -stable.
