Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A81C7EE23
	for <linux-hyperv@archiver.kernel.org>; Wed,  7 Jun 2023 08:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbjFGIwN (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjFGIvf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 04:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3121FD5;
        Wed,  7 Jun 2023 01:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FDD160C7B;
        Wed,  7 Jun 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91267C4339E;
        Wed,  7 Jun 2023 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686127820;
        bh=IIyOROjdNjxeEb0UvMyIbTg8b9AVkiKvs6VlFnwoAA0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QGtNFL5r1UHfGdQy7fmQ66lNZzxZCbzvyyBphKKFIJNo6aJqlc8jQhzkNZtvYKS//
         B6I8MgPun3S5IeFMowSCl7BHfutTVnKcbFAMDLILZMRsYwqaGhnMcsUGWWnLHBxSsZ
         +en8bufufAqaAgqfk2mnCA8EOhyEhBt0y17WRsFyGcgAegXCcF4Tqf6cd4gPDrcyBm
         DUxpXUf2b91/4J6ocT+xMkH+RTltzmtWDihqItZRz72Myyizj3RAMh10Yjd89qPJzN
         2DaBlz8bHYg87T4HU/Xl36R1gzZn+LHx+5kIltpG1+j7Rpvo0SPGmxY39x9DzwNyEY
         DouIxM4+LfUnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76141E29F3C;
        Wed,  7 Jun 2023 08:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] hv_netvsc: Allocate rx indirection table size dynamically
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168612782047.19677.12670846520240383400.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 08:50:20 +0000
References: <1685964606-24690-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1685964606-24690-1-git-send-email-shradhagupta@linux.microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        mikelley@microsoft.com, davem@davemloft.net,
        steen.hegelund@microchip.com, simon.horman@corigine.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  5 Jun 2023 04:30:06 -0700 you wrote:
> Allocate the size of rx indirection table dynamically in netvsc
> from the value of size provided by OID_GEN_RECEIVE_SCALE_CAPABILITIES
> query instead of using a constant value of ITAB_NUM.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Tested-on: Ubuntu22 (azure VM, SKU size: Standard_F72s_v2)
> Testcases:
> 1. ethtool -x eth0 output
> 2. LISA testcase:PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 3. LISA testcase:PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 
> [...]

Here is the summary with links:
  - [v6] hv_netvsc: Allocate rx indirection table size dynamically
    https://git.kernel.org/netdev/net-next/c/4cab498f33f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


