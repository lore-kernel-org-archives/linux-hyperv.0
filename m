Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7EAC2B9F4
	for <linux-hyperv@archiver.kernel.org>; Tue, 22 Jun 2021 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96ECD61369
	for <linux-hyperv@archiver.kernel.org>; Tue, 22 Jun 2021 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFVRcU (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFVRcU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Jun 2021 13:32:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E9DA610C7;
        Tue, 22 Jun 2021 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624383004;
        bh=E6qiPxwz91u/GZp7zdFKvscmtYO1klejZ1g4ju8yOrw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s/SajBxFdh6yyitZ4+jt+L3CPxN/bCaFjNCXIXWoiG51gzYDtjHBNIMsEEFQc/NfK
         EaiBxWudnoVPPAnJ9JcAFliPjTm8Hb5T31TCwG9YTD2GUHDAjLZM5wRz3AbZhOPIqr
         r9i7eGCmVXxNckmHHW7ZL6+vJgoDyG3PTVPj4rw4rF0WMD1hFy3NCF5BfNEch6KpZT
         jP/MW0eRL6Fc/3AAqDUx5hoFFDP1yjBFt2oIx1QXAldhfBDhUO+RgA4pd0o0MD1Ayv
         g0kqTG+6P+u58THmeEhboEmkMLqCPDpGP9MlY+7snfOubI23NtlwIah4utjJyoZgUT
         KW/M6rGamEzkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hv_netvsc: Avoid field-overflowing memcpy()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162438300432.21657.18268821954591671920.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Jun 2021 17:30:04 +0000
References: <20210621222112.1749650-1-keescook@chromium.org>
In-Reply-To: <20210621222112.1749650-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Mon, 21 Jun 2021 15:21:12 -0700 you wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Add flexible array to represent start of buf_info, improving readability
> and avoid future warning where memcpy() thinks it is writing past the
> end of the structure.
> 
> [...]

Here is the summary with links:
  - hv_netvsc: Avoid field-overflowing memcpy()
    https://git.kernel.org/netdev/net-next/c/f2fcffe392c1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


