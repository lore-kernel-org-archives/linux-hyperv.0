Return-Path: <SRS0=amei=3K=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC7C2D0CE
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jan 2020 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4820882
	for <linux-hyperv@archiver.kernel.org>; Tue, 21 Jan 2020 10:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAUKE6 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:04:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35970 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAUKE6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jan 2020 05:04:58 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C906E15BD84F7;
        Tue, 21 Jan 2020 02:04:55 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:04:54 +0100 (CET)
Message-Id: <20200121.110454.2077433904156411260.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2,net-next, 1/2] hv_netvsc: Add XDP support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1579558957-62496-2-git-send-email-haiyangz@microsoft.com>
References: <1579558957-62496-1-git-send-email-haiyangz@microsoft.com>
        <1579558957-62496-2-git-send-email-haiyangz@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 02:04:57 -0800 (PST)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Mon, 20 Jan 2020 14:22:36 -0800

> +u32 netvsc_run_xdp(struct net_device *ndev, struct netvsc_channel *nvchan,
> +		   struct xdp_buff *xdp)
> +{
> +	struct page *page = NULL;
> +	void *data = nvchan->rsc.data[0];
> +	u32 len = nvchan->rsc.len[0];
> +	struct bpf_prog *prog;
> +	u32 act = XDP_PASS;

Please use reverse christmas tree ordering of local variables.

> +	xdp->data_hard_start = page_address(page);
> +	xdp->data = xdp->data_hard_start + NETVSC_XDP_HDRM;
> +	xdp_set_data_meta_invalid(xdp);
> +	xdp->data_end = xdp->data + len;
> +	xdp->rxq = &nvchan->xdp_rxq;
> +	xdp->handle = 0;
> +
> +	memcpy(xdp->data, data, len);

Why can't the program run directly on nvchan->rsc.data[0]?

This data copy defeats the whole performance gain of using XDP.
