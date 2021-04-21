Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E7C43461
	for <linux-hyperv@archiver.kernel.org>; Wed, 21 Apr 2021 00:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC9B61422
	for <linux-hyperv@archiver.kernel.org>; Wed, 21 Apr 2021 00:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhDUAKs (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234446AbhDUAKm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 20:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9169761428;
        Wed, 21 Apr 2021 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618963810;
        bh=M98/mV4ACEJRSScS93rjGBHBjNPw40xcPHUVzCL4wjg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T7uNzh2fZE+5pwwJe/L6yuhdAz3kNzDBlII8KUIksQVy1uFAgOIZt4sFipwNRi7HR
         62/iGARUhziodB2GJM91zbfsBALpnKbbx/4NfghbIhQ7xosMom/axzw9meFLaqIt8G
         Vw4hJyJeTgggtSx9nFuAYuLNnO5qHO7zhIejDlfktXJ+YvVeNz/x6Gk0OyxaY8piMw
         apmOK53uStgz+XSJlLR1nHO/tDvbiTS8i0IktDt3L0mZ9+sWk/GY9krbRQ7PiqTeXR
         W2K/0FWKfnzlKKY9cHy5WaVb8h38Maz118MtwhrEuV705fDQSHQynzQQpGlctv/OB7
         Ag7eXsD/nnJNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: mana: remove redundant initialization of variable
 err
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161896381056.7038.9449243097792804835.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Apr 2021 00:10:10 +0000
References: <20210420122730.379835-1-colin.king@canonical.com>
In-Reply-To: <20210420122730.379835-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, kuba@kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue, 20 Apr 2021 13:27:30 +0100 you wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> [...]

Here is the summary with links:
  - [next] net: mana: remove redundant initialization of variable err
    https://git.kernel.org/netdev/net-next/c/55cdc26a91ac

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


