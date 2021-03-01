Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573BBC433E0
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Mar 2021 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219CD64F27
	for <linux-hyperv@archiver.kernel.org>; Tue,  2 Mar 2021 14:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhCBOVl (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 2 Mar 2021 09:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhCAX6I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 18:58:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C00A560249;
        Mon,  1 Mar 2021 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614642877;
        bh=Tdvi9OtnLVM234hz9z/rcWqFTO9DrJy6+2TJJSoPIAQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jFqSbzE69gzYoKg6IOCrP9SDsqxK7jIDncXARrcohjPzu0CDxw/LHET+b19zxm2uT
         NGhgex2o2Ahc6eYKW8cOHNzfN/zfL0ozw2SrI9bkkAI7IO+mc8eGIIEpfRCcpi6UPn
         rWq7dOPf7yKZ1Z4k3p1MlRE7T2Xt9eoY6TdjfYw9auk9/xFPvzpB9CGct9SpJmEA/2
         ZZG1nGSFBcn6CCfWWQn7Wi9yF3/pLPtrbc9+7Z0GM+XZeC0vUw99pbmYSN3Br8sWYm
         YvFymertcOSn2OZT68rXeVcLyUWAE//1WBYPjwY+DXJwtSTxIX9AVqP38epQK7KBtV
         QQ4fIRTYeX2QQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hv_netvsc: Fix validation in netvsc_linkstatus_callback()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161464287773.7970.8137891577012683736.git-patchwork-notify@kernel.org>
Date:   Mon, 01 Mar 2021 23:54:37 +0000
References: <20210301182530.194775-1-parri.andrea@gmail.com>
In-Reply-To: <20210301182530.194775-1-parri.andrea@gmail.com>
To:     Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, decui@microsoft.com,
        mikelley@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon,  1 Mar 2021 19:25:30 +0100 you wrote:
> Contrary to the RNDIS protocol specification, certain (pre-Fe)
> implementations of Hyper-V's vSwitch did not account for the status
> buffer field in the length of an RNDIS packet; the bug was fixed in
> newer implementations.  Validate the status buffer fields using the
> length of the 'vmtransfer_page' packet (all implementations), that
> is known/validated to be less than or equal to the receive section
> size and not smaller than the length of the RNDIS message.
> 
> [...]

Here is the summary with links:
  - [net] hv_netvsc: Fix validation in netvsc_linkstatus_callback()
    https://git.kernel.org/netdev/net/c/3946688edbc5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


