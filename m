Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2AC433ED
	for <linux-hyperv@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ACD61242
	for <linux-hyperv@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhDGXiC (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:38:02 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:43610 "EHLO
        esgaroth.petrovitsch.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDGXiB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 19:38:01 -0400
X-Greylist: delayed 3592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 19:38:00 EDT
Received: from thorin.petrovitsch.priv.at (80-110-93-117.cgn.dynamic.surfer.at [80.110.93.117])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.16.1/8.16.1) with ESMTPSA id 137MbjSX2151151
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 8 Apr 2021 00:37:47 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 137MbjSX2151151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1617835069;
        bh=sRQ/Lrm5YctprFhxVHSSckbUfrGsc6U25VUJIbk4UJU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sFdwdWcj9OdVPl+hUYQs5bYYEjLpxNKhph00ykqVUPTIsmJd4ovnE4aheyihdisgs
         dJOqJI/cU4Y8XtPpeXlGCm2kJ8UXa3VH9R4TV8zFxdbjWb6VOIMegEtv/SqgOAHJMe
         gt/pSEO4b8pMyxbsx9ncVr5F/kY/j7VJVG7tH9y4=
X-Info-sendmail: I was here
Subject: Re: [PATCH net-next] net: mana: Add a driver for Microsoft Azure
 Network Adapter (MANA)
To:     Dexuan Cui <decui@microsoft.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Wei Liu <liuwe@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20210406232321.12104-1-decui@microsoft.com>
 <YG0F4HkslqZHtBya@lunn.ch>
 <MW2PR2101MB089237C8CCFFF0C352CA658ABF759@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <YG1qF8lULn8lLJa/@unreal>
 <MW2PR2101MB08923F19D070996429979E38BF759@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <YG2pMD9eIHsRetDJ@unreal>
 <MW2PR2101MB0892AC106C360F2A209560A8BF759@MW2PR2101MB0892.namprd21.prod.outlook.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Bimi-Selector: v=BIMI1; s=default
Message-ID: <0d84ef1b-debf-8d5b-0c8d-cb83427b0435@petrovitsch.priv.at>
Date:   Thu, 8 Apr 2021 00:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB0892AC106C360F2A209560A8BF759@MW2PR2101MB0892.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-Etherboy-Metrics: esgaroth.petrovitsch.priv.at 1002; Body=13 Fuz1=13
        Fuz2=13
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all!

On 07/04/2021 23:59, Dexuan Cui wrote:
[...]
> FWIW, {0} and { 0 } are still widely used, but it looks like
> {} is indeed more preferred:
> 
> $ grep "= {};" drivers/net/  -nr  | wc -l
> 829

$ egrep -nr "=[[:space:]]*{[[:space:]]*};" drivers/net/  | wc -l
872

> $ grep "= {0};" drivers/net/  -nr  | wc -l
> 708

$ egrep -nr "=[[:space:]]*{[[:space:]]*0[[:space:]]*};" drivers/net/  |
wc -l
1078

> $ grep "= {};" kernel/  -nr  | wc -l
> 29

$ egrep -nr "=[[:space:]]*{[[:space:]]*};" kernel/  | wc -l
45

> $ grep "= {0};" kernel/  -nr  | wc -l
> 4

$ egrep -nr "=[[:space:]]*{[[:space:]]*0[[:space:]]*};" kernel  | wc -l
8

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
     There is NO CLOUD, just other people's computers. - FSFE
                     LUGA : http://www.luga.at
