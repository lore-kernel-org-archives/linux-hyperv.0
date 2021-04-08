Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20399C433B4
	for <linux-hyperv@archiver.kernel.org>; Thu,  8 Apr 2021 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9F861151
	for <linux-hyperv@archiver.kernel.org>; Thu,  8 Apr 2021 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhDHXqg (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:46:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41120 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhDHXqg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 19:46:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id D2E474D24927D;
        Thu,  8 Apr 2021 16:46:22 -0700 (PDT)
Date:   Thu, 08 Apr 2021 16:46:18 -0700 (PDT)
Message-Id: <20210408.164618.597563844564989065.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, liuwe@microsoft.com,
        netdev@vger.kernel.org, leon@kernel.org, andrew@lunn.ch,
        bernd@petrovitsch.priv.at, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: mana: Add a driver for Microsoft
 Azure Network Adapter (MANA)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210408225840.26304-1-decui@microsoft.com>
References: <20210408225840.26304-1-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Thu, 08 Apr 2021 16:46:23 -0700 (PDT)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Thu,  8 Apr 2021 15:58:40 -0700

> +struct gdma_msg_hdr {
> +	u32 hdr_type;
> +	u32 msg_type;
> +	u16 msg_version;
> +	u16 hwc_msg_id;
> +	u32 msg_size;
> +} __packed;
> +
> +struct gdma_dev_id {
> +	union {
> +		struct {
> +			u16 type;
> +			u16 instance;
> +		};
> +
> +		u32 as_uint32;
> +	};
> +} __packed;

Please don't  use __packed unless absolutely necessary.  It generates suboptimal code (byte at a time
accesses etc.) and for many of these you don't even need it.

Thank you.
