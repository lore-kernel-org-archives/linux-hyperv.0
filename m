Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96EFC433ED
	for <linux-hyperv@archiver.kernel.org>; Mon, 12 Apr 2021 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7BD61287
	for <linux-hyperv@archiver.kernel.org>; Mon, 12 Apr 2021 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhDLMLM (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:11:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45292 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237718AbhDLMLM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Apr 2021 08:11:12 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lVvOq-00GG9g-DR; Mon, 12 Apr 2021 14:10:40 +0200
Date:   Mon, 12 Apr 2021 14:10:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Wei Liu <liuwe@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bernd@petrovitsch.priv.at" <bernd@petrovitsch.priv.at>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Shachar Raindel <shacharr@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v4 net-next] net: mana: Add a driver for Microsoft Azure
 Network Adapter (MANA)
Message-ID: <YHQ4wBMvknqBNIcy@lunn.ch>
References: <20210412023455.45594-1-decui@microsoft.com>
 <YHP6s2zagD67Xr0z@unreal>
 <MW2PR2101MB08920145C271FCEF8D337BE2BF709@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <YHQKWx6Alcc6OQ9X@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHQKWx6Alcc6OQ9X@unreal>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > Currently the protocol versin is 0.1.1 You may ask why it's called
> > "drv version" rather than "protocol version" -- it's because the PF driver
> > calls it that way, so I think here the VF driver may as well use the same
> > name. BTW, the "drv ver" info is passed to the PF driver in the below
> > function:
> 
> Ohh, yes, the "driver version" is not the ideal name for that.
> 
> I already looked on it in previous patch, came to the conclusion about
> the protocol and forgot :(.

Which suggests it needs renaming.

      Andrew
