Return-Path: <SRS0=H8mT=UE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C2C28CC5
	for <linux-hyperv@archiver.kernel.org>; Wed,  5 Jun 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F22083E
	for <linux-hyperv@archiver.kernel.org>; Wed,  5 Jun 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prXvGyNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfFES4i (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFES4i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 14:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7w+N39qphMZq/D6AkfOhXxHv+GWc9Yu+ie9KGgweKUc=; b=prXvGyNQ35v3BUpZb79BMpPz1
        xetVbhCejRQlSMCzs9twwkeaJcSjZs+HI4gQWWq2BHhl2tp5pckmu3Pl1SrH6NFcse1coyQcSeJrt
        8oZmwtD4AdEXEv7hEIQQDK+EQvvaOq+4qdrWObDW8pSKMYhTWud23mzjE9QeQEiI9Nm5D9GjJN4rd
        ltxCXAauDtW8iMhleJM0d+QQgpzCqW1AqVQuk7cG4VbLHcAE0+fhNDYxTp4VEeq9bbtvqwWFeRaJ/
        1WHnohIlJz+4dpcoP0oj9KOzc5AQaSn0/HlaS2WP6NnQdRiwZKxtjni4TGkum6bPHlzgLqZPmezbr
        2dVIq0rdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYb5S-00016R-0x; Wed, 05 Jun 2019 18:56:38 +0000
Date:   Wed, 5 Jun 2019 11:56:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605185637.GA31439@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605185205.12583-1-sthemmin@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 05, 2019 at 11:52:05AM -0700, Stephen Hemminger wrote:
> Doing asynchronous probing can lead to reordered device names
> which is leads to failed mounts.

Which is true for every device, and why we use UUIDs or label for
mounts that are supposed to be stable.
