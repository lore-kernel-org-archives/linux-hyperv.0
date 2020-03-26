Return-Path: <SRS0=YEkK=5L=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792FC43331
	for <linux-hyperv@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44C120748
	for <linux-hyperv@archiver.kernel.org>; Thu, 26 Mar 2020 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="AFFIqAWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCZP0v (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:26:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43992 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZP0u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 11:26:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id v23so2248068ply.10
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxQYW/nnrzb7W5073+0iMTEQJ++9sTJN5W/GMW2FN1I=;
        b=AFFIqAWnDRv4folqfy/T/Ljb8pr8zkAnlgorZ67c5raMz+ejCcNcMmAahXPdj/uh2i
         mY8LRxN7UYP/Nsu4fTizjCYnYjDs2sM3gFqBGP3gFdUkxK+ZS94XtunXIKxoNq8I86Q9
         3misuD83KFRzr2MVGM1sU3D/VM5rJnj1zNNhlHde/GxONLu9PvKiesD319uX27Aeu5UK
         mpjEAjjjFbCbG8mlun/UW+MYkjqBuKyz8WaSk4Q9IqnYYk+FvRspJ9pSKuT0lvQ2H7pa
         X0HvLrd/Z7s3jTPxdKEHoLPbajwwgmIxlQxgXbGDEMiG92Hkm4eEtvZGaZb3IJwPS5X4
         O6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxQYW/nnrzb7W5073+0iMTEQJ++9sTJN5W/GMW2FN1I=;
        b=tNwTEpdYZ6O+wcdzpZW57+dgaeVT8cTOFSlBCQQu2QvbZr5hMt17CkR/Ca13lqLa1w
         fGL8nH9hq6v4PfNXbZ59T3vvpPmWilDVBCiFzTgElGiFJepXr0G0RCVmKBevQUUMf3do
         3m5QoAO80e5M2qQsAo3HzA0SaFiAlmJnVU828vwFU3xTASf2iXXHsgAXGn2rVCiLA9LG
         SZJgQXKKbULa7B+XzNOpeoifxW0+ecw/+9NXe1S/ZAu699YfZgdjEWCBGO7VKm7LuIVF
         k+82luOdWcm+9ztE4HqIwjOjx04MeQVrpSeDQwi5UO5jN4CMhu2Eq1Vae/E6dMzx411O
         gq2A==
X-Gm-Message-State: ANhLgQ37FT3fIQ5fSWv72TXj6tDOiCcwrNF7iUawmW3gcm3v9V9u8pMp
        a3vmuhu+TmBr0HKK7D80eJLjeg==
X-Google-Smtp-Source: ADFU+vvGVhjWWJCwQHAO/ETHPGmnATcfj+jq0WdWxnlkrpMVACwroMGnDwpy3IX1TfsgQt4SofOoYQ==
X-Received: by 2002:a17:902:b115:: with SMTP id q21mr8292519plr.337.1585236407290;
        Thu, 26 Mar 2020 08:26:47 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id bo12sm1853269pjb.16.2020.03.26.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:26:46 -0700 (PDT)
Date:   Thu, 26 Mar 2020 08:26:36 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 04/11] hv_netvsc: Disable NAPI before closing the
 VMBus channel
Message-ID: <20200326082636.1d777921@hermes.lan>
In-Reply-To: <20200325225505.23998-5-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
        <20200325225505.23998-5-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 25 Mar 2020 23:54:58 +0100
"Andrea Parri (Microsoft)" <parri.andrea@gmail.com> wrote:

> vmbus_chan_sched() might call the netvsc driver callback function that
> ends up scheduling NAPI work.  This "work" can access the channel ring
> buffer, so we must ensure that any such work is completed and that the
> ring buffer is no longer being accessed before freeing the ring buffer
> data structure in the channel closure path.  To this end, disable NAPI
> before calling vmbus_close() in netvsc_device_remove().
> 
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <netdev@vger.kernel.org>

Do you have a test that reproduces this issue?

The netvsc device is somewhat unique in that it needs NAPI
enabled on the primary channel to interact with the host.
Therefore it can't call napi_disable in the normal dev->stop() place.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
