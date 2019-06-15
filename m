Return-Path: <SRS0=3+ow=UO=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD6C31E44
	for <linux-hyperv@archiver.kernel.org>; Sat, 15 Jun 2019 02:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02C2133D
	for <linux-hyperv@archiver.kernel.org>; Sat, 15 Jun 2019 02:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfFOCO7 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:14:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFOCO7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 22:14:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EDACD133FE74A;
        Fri, 14 Jun 2019 19:14:56 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:14:56 -0700 (PDT)
Message-Id: <20190614.191456.407433636343988177.davem@davemloft.net>
To:     sunilmut@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hvsock: fix epollout hang from race condition
From:   David Miller <davem@davemloft.net>
In-Reply-To: <MW2PR2101MB11164C6EEAA5C511B395EF3AC0EC0@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB11164C6EEAA5C511B395EF3AC0EC0@MW2PR2101MB1116.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 19:14:57 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQpUaGlzIGFkZHMgbG90cyBvZiBuZXcgd2FybmluZ3M6DQoNCm5ldC92bXdfdnNvY2svaHlwZXJ2
X3RyYW5zcG9ydC5jOiBJbiBmdW5jdGlvbiChaHZzX3Byb2JlojoNCm5ldC92bXdfdnNvY2svaHlw
ZXJ2X3RyYW5zcG9ydC5jOjIwNToyMDogd2FybmluZzogoXZuZXeiIG1heSBiZSB1c2VkIHVuaW5p
dGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQ0KICAgcmVt
b3RlLT5zdm1fcG9ydCA9IGhvc3RfZXBoZW1lcmFsX3BvcnQrKzsNCiAgIH5+fn5+fn5+fn5+fn5+
fn5+Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCm5ldC92bXdfdnNvY2svaHlwZXJ2X3RyYW5zcG9y
dC5jOjMzMjoyMTogbm90ZTogoXZuZXeiIHdhcyBkZWNsYXJlZCBoZXJlDQogIHN0cnVjdCB2c29j
a19zb2NrICp2bmV3Ow0KICAgICAgICAgICAgICAgICAgICAgXn5+fg0KbmV0L3Ztd192c29jay9o
eXBlcnZfdHJhbnNwb3J0LmM6NDA2OjIyOiB3YXJuaW5nOiChaHZzX25ld6IgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQog
ICBodnNfbmV3LT52bV9zcnZfaWQgPSAqaWZfdHlwZTsNCiAgIH5+fn5+fn5+fn5+fn5+fn5+fn5e
fn5+fn5+fn5+DQpuZXQvdm13X3Zzb2NrL2h5cGVydl90cmFuc3BvcnQuYzozMzM6MjM6IG5vdGU6
IKFodnNfbmV3oiB3YXMgZGVjbGFyZWQgaGVyZQ0KICBzdHJ1Y3QgaHZzb2NrICpodnMsICpodnNf
bmV3Ow0KICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo=
