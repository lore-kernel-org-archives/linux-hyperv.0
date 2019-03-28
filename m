Return-Path: <SRS0=/rR5=R7=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C9C43381
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCC52173C
	for <linux-hyperv@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Hrfx+TVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfC1Sia (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfC1Sia (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so3841566pgv.13
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HgwLPeP0qqBX11bWu5yNsHrwRKeRYbfEdwOA4/zC80=;
        b=Hrfx+TVXtP1YJ63SWkJ55zSFAxpNSAyIYL7yJbEKf92yCTm4GH3qbX5ggWeF0nizrx
         /nJnrvlJ8323hu9UyTRjbDjHHn/OVzkMqBEYXjzi5vxAavRr+SwImmfsxLe0JZnF68Rq
         I6kQhT1ReaQriWi+gvBO09pPpaFoWfiifIrqOOLNyirzPMlzYdf1JiKwzS1T/vnn/umM
         yHKYCEEVjiRNDCwG+zXIRGYb1iZnl6e60uXYH1C0DNS4l+E5sg3qbGzdnonFjr6tMZu9
         OK8ZYNPrlTkB8o+lNWmxiKcsa5nyVcLsc8Wn2OR9f98Ike9A2ZDDDC/iu58hCBMAz3eM
         idMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HgwLPeP0qqBX11bWu5yNsHrwRKeRYbfEdwOA4/zC80=;
        b=bvEAeFvu1TzkZpgW8pmA++JDvgpGzxtiDckZCX/ZrcQtbJ2//cSa7fJ3PckD+YZUb6
         u94EYBVJBh9ZiMRw96WXUEvNj/Hdn4u5DA2hcJT+hZzbgp7VMUH3oVs23iB/JmqH/0K+
         vmBRiRhKbK5l+yJTIX33dAJmGlXE14Bgaw9de6zZAChw33/Ql6+0uQRs6MCZ1A69+GRT
         vlF4tnUwj4BYDFzloH2kVN6xhvk9NVXQeqkoQJE25JuqwdzODPTDMx2NjbjUUpzHx8tN
         /F0VbSn8E11nOOytPk8aj3w/cCvd5zZX5TG7HXiFdy4F7vlibrUTHjUQ91HupAIgC4Qb
         CT9A==
X-Gm-Message-State: APjAAAVjeyeB3CFCZeCG/whHTQLtAKT/Wuibw0Nlk/eSZBwUE/QBgMvj
        fCv7wn4JyH5R/lULMkDaK9Ahcg==
X-Google-Smtp-Source: APXvYqx6nRklFUwe7sou9TUHY57Ksq3AeQythrMrdXdTXNrlId1MD02ctcp3Jrz6RJHVkP3mR52G/A==
X-Received: by 2002:a63:4b14:: with SMTP id y20mr1366619pga.15.1553798309455;
        Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id g67sm39468578pfg.94.2019.03.28.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:38:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:38:23 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix unwanted wakeup after
 tx_disable
Message-ID: <20190328113823.3c9b3599@shemminger-XPS-13-9360>
In-Reply-To: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
References: <20190328174845.4799-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 28 Mar 2019 17:48:45 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> +static inline void netvsc_tx_enable(struct netvsc_device *nvscdev,
> +				    struct net_device *ndev)
> +{
> +	nvscdev->tx_disable = false;
> +	mb(); /* ensure queue wake up mechanism is on */
> +
> +	netif_tx_wake_all_queues(ndev);
> +}

You don't need a full mb(). virt_wmb() should be sufficient.

Could I suggest an alternative approach.
You don't need to introduce a local tx_disable flag, the only place where a wakeup
could cause problems is after a send_completion was processed during detach state.

Instead, just avoid wakeup in that place.

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -720,6 +720,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
                struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
 
                if (netif_tx_queue_stopped(txq) &&
+                   netif_device_present(ndev) &&
                    (hv_get_avail_to_write_percent(&channel->outbound) >
                     RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
                        netif_tx_wake_queue(txq);
