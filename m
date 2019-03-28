Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317EC43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353DF2173C
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="DpU2RT5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfC1TmM (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:42:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfC1TmL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 15:42:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so12497pgq.4
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Mar 2019 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9zRhz/6pORXy69BKITtRDAURXnhfzFXtRl0HikpUzw=;
        b=DpU2RT5drjPDlvsC025OXDz5YJSnmd1C3a4UhZvPMRPdSWRgqb7enEBL879X+6U1xt
         a5yjPnn10WLmdUpi7/95PfWGkHxhFZVVfQZlXuCwyKEkSnwVQ6zMfI0ML9fBA71yHHmU
         VK5RG4UzQcKfi13vXduGMXnwkNKaDR8MtK+3geA7Iej4b4n3xyZCDsmlzXq/o1tH6onn
         uK1P7F5zWuMn2Vp86Snfo/iA1c1vN7k4I4QRGfV87r210naKvXX5hC0ZLTFv5KslPMOw
         LNICYtVb9hOygKf2WzbQnHyQn/RDI9w+5CDEvF4NqYYNM9pBlbc9TLfSJHafu05VLZXu
         fCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9zRhz/6pORXy69BKITtRDAURXnhfzFXtRl0HikpUzw=;
        b=QrKn19t6dmSPbN6J3hmLFQzMEF/sy5joV2nhqgRdffIdsGztVpOqk5nLGNkcC1jH4C
         qMz5oYrt+MzdTPgLaYVFpJzZUN7CSvT8UVIHw+glLbpZ+MteGjMRREHqqqkHs/I48xPD
         r28Kdra20CTpNHp9aJbeWyivRSuiXL87DzpZB4q0cGF99ZM6VA8lTfAM1TZ9AyUxS6Ni
         OndOe5J9S4CoTbfN9OgnVVa1jboVpuknioXZqdxI1Jdd9DmuN04QCCo5eMsacuQeZm6W
         mKIvEdXQ7Z63qX2ZIwj1dXgJqOKZVzygybEZtic4agq9ZTdyRw3UrHO2nJWRyI1JbhEB
         vM0Q==
X-Gm-Message-State: APjAAAWx8G+VVabG3SV2ARYt9tMqbMmwDDPVItzFDqFELbdZZ5AG0GXg
        D+M7dNRfaIKjXT1JMIP2Ome5TQ==
X-Google-Smtp-Source: APXvYqy/uE0KX80354K/p2FJebf3jKs3u49WgcfmtPQi/zKtvQKrQp+UPzaDQ5AlXyEpFhPIPdWgmg==
X-Received: by 2002:a65:4343:: with SMTP id k3mr23249292pgq.384.1553802130694;
        Thu, 28 Mar 2019 12:42:10 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 17sm41548640pgz.52.2019.03.28.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 12:42:10 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:42:05 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@linuxonhyperv.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Message-ID: <20190328124205.42f5f337@shemminger-XPS-13-9360>
In-Reply-To: <DM6PR21MB1337250A47CEE73D1EFE0AB7CA590@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
        <20190328113823.3c9b3599@shemminger-XPS-13-9360>
        <DM6PR21MB1337250A47CEE73D1EFE0AB7CA590@DM6PR21MB1337.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 28 Mar 2019 19:00:18 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Thursday, March 28, 2019 2:38 PM
> > To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> > Cc: sashal@kernel.org; linux-hyperv@vger.kernel.org; Haiyang Zhang
> > <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets
> > <vkuznets@redhat.com>; davem@davemloft.net; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
> > tx_disable
> > 
> > On Thu, 28 Mar 2019 17:48:45 +0000
> > Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
> >   
> > > +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> > > +				    struct net_device *ndev)
> > > +{
> > > +	nvscdev->tx_disable = false;
> > > +	mb(); /* ensure queue wake up mechanism is on */
> > > +
> > > +	netif_tx_wake_all_queues(ndev);
> > > +}  
> > 
> > You don't need a full mb(). virt_wmb() should be sufficient.  
> 
> I will make this change. 
> 
> > Could I suggest an alternative approach.
> > You don't need to introduce a local tx_disable flag, the only place where a
> > wakeup could cause problems is after a send_completion was processed
> > during detach state.
> > 
> > Instead, just avoid wakeup in that place.  
> 
> In netvsc_detach(), after netif_tx_disable(), we call  netvsc_wait_until_empty(nvdev);
> TX patch should not be waken up again while waiting for in/out ring to becomes empty.
> 
> In my tests before this patch, there are wakeup happens before netif_device_detach(), 
> so netif_device_present(ndev) is still true at that time.
> 
> In other places, like netvsc_close(), link_change(), we also don't want wakeup after tx_disable.
> 
> Thanks.
> - Haiyang
> 
> > 
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -720,6 +720,7 @@ static void netvsc_send_tx_complete(struct
> > net_device *ndev,
> >                 struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
> > 
> >                 if (netif_tx_queue_stopped(txq) &&
> > +                   netif_device_present(ndev) &&
> >                     (hv_get_avail_to_write_percent(&channel->outbound) >
> >                      RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
> >                         netif_tx_wake_queue(txq);  


Then what about doing netif_detach earlier in netvsc_detach.

The state management is already (too) complex in netvsc and adding another
boolean flag just makes it harder to understand.
