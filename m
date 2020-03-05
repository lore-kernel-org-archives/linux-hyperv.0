Return-Path: <SRS0=hxzj=4W=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA9C3F2D7
	for <linux-hyperv@archiver.kernel.org>; Thu,  5 Mar 2020 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277D7208CD
	for <linux-hyperv@archiver.kernel.org>; Thu,  5 Mar 2020 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583433912;
	bh=8juZa1/JDihIlo6AZpKTn+VSIoMeVmWt0uru1T4t19k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sgQKK4GTRA0g8d0UefywohC4+dhthQ3qJGoqe37uflcw0SlxMcD1bC0f03Ueq8BkW
	 NyOdqx3x2kaZsD3S9fhK4oeJzUQZxTKXG5Ej8+lD4bti/YLSZanaijN4xLPie2NagI
	 hqVsY3NLB1atb/5yNn2jyyhh2xczn7xfm8tpJmZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCESpI (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgCESpH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Mar 2020 13:45:07 -0500
Subject: Re: [GIT PULL] Hyper-V commits for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583433906;
        bh=8juZa1/JDihIlo6AZpKTn+VSIoMeVmWt0uru1T4t19k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2tA5SWA2+qFbWBvkDklzp5ViqWUTntcywKKs/Ec4+I9ix/RCdY//bHxGg4WQycz/
         aCvMkr00y2SdT3SqBo4YYKIUHlqqw6NuYssogSu1+88jaArJFdVotKha/vYE0T0mE1
         FtaAXCY3GJY67/t1Y6nMTa58fPcwRAToo51zZzBM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200305155901.xmstcqwutrb6s7pi@debian>
References: <20200305155901.xmstcqwutrb6s7pi@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200305155901.xmstcqwutrb6s7pi@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 5313b2a58ef02e2b077d7ae8088043609e3155b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad
Message-Id: <158343390663.15864.12737571692029797378.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Mar 2020 18:45:06 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        sashal@kernel.org, haiyangz@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Thu, 5 Mar 2020 15:59:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
