Return-Path: <SRS0=Gp0b=RC=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA6C43381
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3257C20643
	for <linux-hyperv@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubi3zoqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfB0RZj (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36926 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfB0RZb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+9lXgh3E7SXmm1ucnodSstiQXX281Ct1+LDKAFy9Od0=; b=ubi3zoqRApa5r5IwmLmnw7KA6i
        1f4Xf78chkRn8nDTpGIsI1iOdm/2mp6o7A16rUogJ5vpotCrtIfgYeS+R5f3jHdB0DzmVGhh2xAr6
        JUD5NGR2+BYkWVrk/0mY6A2OcljMJmUOETuCEa0NFcU2erPtKUxCqio1rNajeLMflWSadYXANI0av
        qCBuK9PPVDlIdmGjZrKY6jI/hqaS1nMvC6vD6R6UH5fYL8IPRDo+lWAP7ThnVU3b9Ou/JkhyPYelV
        fgQ2EZEBXQH12BkdvtffQoz8Tjqfq8Vbgtq690ZIhXRyy+KXt6Sz7wER6sZe5RaaYVZqR3HTfHZmX
        2v1RAb5w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz2xV-0005t4-1B; Wed, 27 Feb 2019 17:25:29 +0000
Subject: Re: linux-next: Tree for Feb 27 (mshyperv)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
References: <20190227174427.4e8f7f24@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6cfb923-c21e-b0e3-44e1-33197aac2625@infradead.org>
Date:   Wed, 27 Feb 2019 09:25:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190227174427.4e8f7f24@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/26/19 10:44 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190226:
> 

on i386:

../arch/x86/kernel/cpu/mshyperv.c: In function ‘ms_hyperv_init_platform’:
../arch/x86/kernel/cpu/mshyperv.c:339:3: error: ‘x2apic_phys’ undeclared (first use in this function)
   x2apic_phys = 1;
   ^


-- 
~Randy
