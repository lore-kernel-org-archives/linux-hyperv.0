Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED9C4320E
	for <linux-hyperv@archiver.kernel.org>; Wed, 25 Aug 2021 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A16A61214
	for <linux-hyperv@archiver.kernel.org>; Wed, 25 Aug 2021 10:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhHYKVB (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 25 Aug 2021 06:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238799AbhHYKUy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 06:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F228E611EF;
        Wed, 25 Aug 2021 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629886809;
        bh=ubKSMLaf0Bu90+7mm5SA839aehOR3fneQebmdHeiZc4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sW2Y8nLjLCoOUEPK7yBabGXTBeh/WWF+hR42IBcrL6CPlxG9QWuOnvRruwHflg8OT
         V2L991cNlRJh7pnqg7WWMeJGPaYnHSnH6qWG5QUCh1elAcOriOxYEv8ThwJmCKWOED
         eQuRnUbXFrObPHf+jD6ANXmIgeQO1XAkwP7J72++Qrjx/nxK/d93g3mzI3/KR/4vfH
         pNO/AkAprRkcJw/QIWiLy4IFejUiJLcuL74aX7sXfqFxJPAWs1ODUYk1scF6AwPHA9
         Eca3y0BHWEiFC5qqEyWZK3J7HCqM+EwbpxmD1XIFQIWK3PqLlfTiKt62SCjiTs8ge2
         RZkzg7HcGCJbw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2,net-next, 0/3] net: mana: Add support for EQ sharing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162988680892.8958.11271831152775576933.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Aug 2021 10:20:08 +0000
References: <1629823561-2261-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1629823561-2261-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com, paulros@microsoft.com,
        shacharr@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 24 Aug 2021 09:45:58 -0700 you wrote:
> The existing code uses (1 + #vPorts * #Queues) MSIXs, which may exceed
> the device limit.
> 
> Support EQ sharing, so that multiple vPorts can share the same set of
> MSIXs.
> 
> Haiyang Zhang (3):
>   net: mana: Move NAPI from EQ to CQ
>   net: mana: Add support for EQ sharing
>   net: mana: Add WARN_ON_ONCE in case of CQE read overflow
> 
> [...]

Here is the summary with links:
  - [V2,net-next,1/3] net: mana: Move NAPI from EQ to CQ
    https://git.kernel.org/netdev/net-next/c/e1b5683ff62e
  - [V2,net-next,2/3] net: mana: Add support for EQ sharing
    https://git.kernel.org/netdev/net-next/c/1e2d0824a9c3
  - [V2,net-next,3/3] net: mana: Add WARN_ON_ONCE in case of CQE read overflow
    https://git.kernel.org/netdev/net-next/c/c1a3e9f98dde

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


