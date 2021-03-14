Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D8C433E0
	for <linux-hyperv@archiver.kernel.org>; Sun, 14 Mar 2021 21:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA7864EAE
	for <linux-hyperv@archiver.kernel.org>; Sun, 14 Mar 2021 21:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhCNVkk (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 14 Mar 2021 17:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhCNVkI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 14 Mar 2021 17:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3094464E67;
        Sun, 14 Mar 2021 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615758008;
        bh=hnmFulogmxC0lhYYhnHQtNMtjngUle4a+5IlvAmqq+s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PN4uaHDhUTGkezOhItES4McIHlxJ/8i4l2OBSvDIH33p7/7fFYyVhxP78Tvtdy50M
         IQkbjnAi4rKi14XTk4J0tCCNPJw4gIephUinwiMKXxdBhwwwl6s1WiqWm6sqQ/J7VN
         ypZixl5o8onmww2dy3vb+RRNILt3P/Ow18wEk6rd3yt+GjtYT1OPoC3Bg4+9KorRlA
         5d2hdjDvX0d0GAE0urMjET/GdzjE13c1lQLKRodi7pkds3ZDk/aK6JPoAPoVD3loAK
         8VJFKlj774P5v0YkXQdaMXBlO2moos1gw5Kva/jTjuk9uM+sblOHR7QtjD+184kOEu
         VoZFxC46GV0bA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hv_netvsc: Add a comment clarifying batching logic
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161575800812.11131.8853264901586856326.git-patchwork-notify@kernel.org>
Date:   Sun, 14 Mar 2021 21:40:08 +0000
References: <1615592727-11140-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1615592727-11140-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, shacharr@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 12 Mar 2021 15:45:27 -0800 you wrote:
> From: Shachar Raindel <shacharr@microsoft.com>
> 
> The batching logic in netvsc_send is non-trivial, due to
> a combination of the Linux API and the underlying hypervisor
> interface. Add a comment explaining why the code is written this
> way.
> 
> [...]

Here is the summary with links:
  - [net-next] hv_netvsc: Add a comment clarifying batching logic
    https://git.kernel.org/netdev/net-next/c/bd49fea7586b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


