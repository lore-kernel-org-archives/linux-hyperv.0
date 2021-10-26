Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDBC433F5
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Oct 2021 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144426108B
	for <linux-hyperv@archiver.kernel.org>; Tue, 26 Oct 2021 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJZOCc (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhJZOCb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Oct 2021 10:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C75E761040;
        Tue, 26 Oct 2021 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635256807;
        bh=CFoQtyAK/qetJgLQ1CwQmmdpb9n1b7OYNPMIk49CDS0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HmK7scsbOEQ622ExQa5rhkNl1gEdOL8WRJWUhUVIkWOGLDfGzv33CHsB0s7pTvjv/
         1fGxvMdz1hT+X+bR5uCEJbafcNzr3c0qThHZfvsFCocDd3jJh7nQK6rZjFCJszxXXS
         QOPOlv7YrG3aSK4Dw09uUQt4jgun3dn0mGdr/GscbZ4jEBfBO7P/xO8lv8XQDgbsPM
         m7pYJYtTE1vNZVLy3gBGIUPIgQp5YeK9y66IfNW8pO/S4kPjWtUDilzymZ1mYiaBRz
         PYFRLzyg6opHyWAG52HWjZr6tCUyM9Gn1HrvT1QwqSxb9HuCS4mHCno++DEGXg0iyo
         laX4mAeTz4wIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Allow setting the number of queues while
 the NIC is down
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163525680774.8133.292374133911071162.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Oct 2021 14:00:07 +0000
References: <1635187054-12995-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1635187054-12995-1-git-send-email-haiyangz@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com, paulros@microsoft.com,
        shacharr@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Oct 2021 11:37:34 -0700 you wrote:
> The existing code doesn't allow setting the number of queues while the
> NIC is down.
> 
> Update the ethtool handler functions to support setting the number of
> queues while the NIC is at down state.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: Allow setting the number of queues while the NIC is down
    https://git.kernel.org/netdev/net-next/c/a137c069fbc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


