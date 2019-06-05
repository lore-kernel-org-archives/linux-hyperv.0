Return-Path: <SRS0=H8mT=UE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83915C28CC5
	for <linux-hyperv@archiver.kernel.org>; Wed,  5 Jun 2019 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A057206C3
	for <linux-hyperv@archiver.kernel.org>; Wed,  5 Jun 2019 19:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iW2cayQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFET0s (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:26:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET0r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Y8zuvkCwcHaFQUQv7wzEqNkhLFVav9+d88U6leKjGY=; b=iW2cayQ2aUIr2L/27EV1SlsCH
        +OqCyQZVb7lfWpcuupKWlghbbmkSRfz0wk3ICYjGylfOlPLe5oJJ7s81QzeZypLpCiQ4uy7oY/qXr
        zb4npyyPq+pXJh0aIinKgdQQmdc5qUt0DpjrLBJpwn7K16cuMpTgjTbdAIE25yAwVM+XyLUZCiHYL
        FEYJSbERy3mPAofYHLC1s9XL8mqL+YdNVQ2+LBa/ksl54l7tR/cmOUL/Wz0xHzIXK6lFWIWfrriMp
        ISVRpnBupsofLlU6mJ4pa76FUBCKIWBPd9QrHZY/A+SVy1LdFLuNV7AOFOxPGB+QNN5f3ZGes9Bbw
        fXCniad7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbYd-0006gC-6C; Wed, 05 Jun 2019 19:26:47 +0000
Date:   Wed, 5 Jun 2019 12:26:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605192647.GA25034@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
 <20190605185637.GA31439@infradead.org>
 <20190605120640.00358689@hermes.lan>
 <20190605190722.GA19684@infradead.org>
 <20190605121020.1a41b753@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605121020.1a41b753@hermes.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 05, 2019 at 12:10:20PM -0700, Stephen Hemminger wrote:
> > Sure.  But they should not get a way out for just one specific driver.
> 
> There are people running new kernels on 6 year old distributions.
> Was every distribution smart enough then? If you think so, then
> this not necessary.

I think you are missing my point.  If we want a way to disable this,
we:

 a) want it opt-in
 b) it needs to for the whole SCSI layer and not just one driver
