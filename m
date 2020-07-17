Return-Path: <SRS0=fRQn=A4=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93853C433E1
	for <linux-hyperv@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F2720704
	for <linux-hyperv@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQQzn (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQzn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 12:55:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FFC0619D2;
        Fri, 17 Jul 2020 09:55:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B44811353EA68;
        Fri, 17 Jul 2020 09:55:39 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:55:35 -0700 (PDT)
Message-Id: <20200717.095535.195550343235350259.davem@davemloft.net>
To:     haiyangz@microsoft.com
Cc:     stephen@networkplumber.org, Song.Chi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: hyperv: Add attributes to show RX/TX
 indirection table
From:   David Miller <davem@davemloft.net>
In-Reply-To: <DM5PR2101MB09344BA75F08EC926E31E040CA7C0@DM5PR2101MB0934.namprd21.prod.outlook.com>
References: <HK0P153MB027502644323A21B09F6DA60987C0@HK0P153MB0275.APCP153.PROD.OUTLOOK.COM>
        <20200717082451.00c59b42@hermes.lan>
        <DM5PR2101MB09344BA75F08EC926E31E040CA7C0@DM5PR2101MB0934.namprd21.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 09:55:40 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Fri, 17 Jul 2020 16:18:11 +0000

> Also in some minimal installation, "ethtool" may not always be
> installed.

This is never an argument against using the most well suited API for
exporting information to the user.

You can write "minimal" tools that just perform the ethtool netlink
operations you require for information retrieval, you don't have to
have the ethtool utility installed.
