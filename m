Return-Path: <SRS0=lDLd=UP=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A5C31E50
	for <linux-hyperv@archiver.kernel.org>; Sun, 16 Jun 2019 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6392080C
	for <linux-hyperv@archiver.kernel.org>; Sun, 16 Jun 2019 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfFPVBL (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 16 Jun 2019 17:01:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfFPVBL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 16 Jun 2019 17:01:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85CCA151BE526;
        Sun, 16 Jun 2019 14:01:07 -0700 (PDT)
Date:   Sun, 16 Jun 2019 14:01:06 -0700 (PDT)
Message-Id: <20190616.140106.158669787444398226.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     netdev@vger.kernel.org, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        Alexander.Levin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com
Subject: Re: [PATCH net] hv_sock: Suppress bogus "may be used
 uninitialized" warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1560574826-99551-1-git-send-email-decui@microsoft.com>
References: <1560574826-99551-1-git-send-email-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Jun 2019 14:01:08 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCkRhdGU6IFNhdCwgMTUgSnVu
IDIwMTkgMDU6MDA6NTcgKzAwMDANCg0KPiBnY2MgOC4yLjAgbWF5IHJlcG9ydCB0aGVzZSBib2d1
cyB3YXJuaW5ncyB1bmRlciBzb21lIGNvbmRpdGlvbjoNCj4gDQo+IHdhcm5pbmc6IKF2bmV3oiBt
YXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24NCj4gd2FybmluZzogoWh2
c19uZXeiIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbg0KPiANCj4g
QWN0dWFsbHksIHRoZSAyIHBvaW50ZXJzIGFyZSBvbmx5IGluaXRpYWxpemVkIGFuZCB1c2VkIGlm
IHRoZSB2YXJpYWJsZQ0KPiAiY29ubl9mcm9tX2hvc3QiIGlzIHRydWUuIFRoZSBjb2RlIGlzIG5v
dCBidWdneSBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT4NCg0KQXBwbGllZC4NCg==
