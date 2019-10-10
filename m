Return-Path: <SRS0=TjGu=YD=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD4ECE596
	for <linux-hyperv@archiver.kernel.org>; Thu, 10 Oct 2019 08:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7C222C9
	for <linux-hyperv@archiver.kernel.org>; Thu, 10 Oct 2019 08:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfJJIqF (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389240AbfJJIqE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:04 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3995087638
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Oct 2019 08:46:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k4so2407608wru.1
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Oct 2019 01:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tR/b93II6w98Y1JcW5QoZrFBl2Ih7JvmORnV8m5CDsk=;
        b=nQNQIst9p85OnjcqpQ5blbqOBti1ySib3HaFaQMoux59hf2BwJPEs8l3D922ZUuFsl
         qlZjB5akKoZrjVclMbHyCpGx1w28llPbTymQrACWxFhiKZd1orRY68rwLyrfUmp60jm9
         /PD8ODCy4ViJc2k7zOiCh3iR/LK7XBeDbMGqHxJdjM+PrX0/z3fNXloFJYUaYBJhS9KP
         TpXjvfOBArbiNM3PEkHaRZmm9pKawzGNPmVMbHRs0xj6wFd6UCy4Ck5nBeEr308HK3Qx
         j5FD9Opj1shzPevIU34Ss55E7zsKtRS9I4gY68NfL33LvzNTOflDN1Y2xPlhmm7Y2YBL
         Y0Gg==
X-Gm-Message-State: APjAAAUz79G2JQvSQIULPaV2dOQyS8zRLu8UdFs76+XdoU5ToCCu24Zy
        CsqB1D1358PHttjL6mf7h+AXz7shw6JELLQxEDIkFHHOgdTvxBeT7rCJxuSXXE6f6QjghRCox1N
        BY82zBsnUTdKTwJz1142AdMdC
X-Received: by 2002:adf:e401:: with SMTP id g1mr5700485wrm.211.1570697162834;
        Thu, 10 Oct 2019 01:46:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrGXBfAqLL3DSANixqvzd6znc5l0D4LZnBiMcWibn1Ag6PBFlGAQzLidI7EwNDBrIbfhWgrA==
X-Received: by 2002:adf:e401:: with SMTP id g1mr5700471wrm.211.1570697162619;
        Thu, 10 Oct 2019 01:46:02 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id q124sm8324726wma.5.2019.10.10.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:46:01 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:45:59 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 00/13] vsock: add multi-transports support
Message-ID: <20191010084559.a4t6v7dopeqffn55@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20191009132952.GO5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009132952.GO5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 09, 2019 at 02:29:52PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:50PM +0200, Stefano Garzarella wrote:
> > Hi all,
> > this series adds the multi-transports support to vsock, following
> > this proposal:
> > https://www.spinics.net/lists/netdev/msg575792.html
> 
> Nice series!  I have left a few comments but overall it looks promising.

Thank you very much for the comments!

I'll follow them and respin.

Cheers,
Stefano
