Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C427C433DB
	for <linux-hyperv@archiver.kernel.org>; Sun, 21 Feb 2021 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E27565100
	for <linux-hyperv@archiver.kernel.org>; Sun, 21 Feb 2021 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBUWDO (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhBUWDL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 21 Feb 2021 17:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8156B64EC3;
        Sun, 21 Feb 2021 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944918;
        bh=8eJKkFtEodNY52VxRHFhgZKOoTtnvqEZ+38oSmKiHPs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Oidc1TB/2a3G+ziV/HlcKmN2kRFJObudVW+zVUlrZOFhRZG9bgxK6BTykqUsT11pw
         jVxCHLuWAHdYIcz+ur7wuWU0NPymAK/MU/o+HNcVq/pgt5MQ3gL3Ra8uBYgpzeqbwA
         z8I8JtVRArPOMKCdklhmasWJUiNIVCSsoN+AWQiVy5HNPxEP7GSzakMx+dV7Dqwhgz
         yqqvCYi5bSr1whOTXVJtVK4CQ1SfU0vXfhBZi0WzXV/XkIwd8ndvi3mqXXAOFO6EF4
         XxE3BK3ObFPCyfAB3WmOkMxL5ljZdQHMAtxEAgxNwK/Sqo+pJyPNARmKepwszZjDEL
         J66ux2/DMvu3A==
Subject: Re: [GIT PULL] Hyper-V commits for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210216094519.mc4o74npzdm32avt@liuwe-devbox-debian-v2>
References: <20210216094519.mc4o74npzdm32avt@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210216094519.mc4o74npzdm32avt@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210216
X-PR-Tracked-Commit-Id: 3019270282a175defc02c8331786c73e082cd2a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c5b80b795e9c847a7b7f5e63c6bcf07873fbcdf
Message-Id: <161394491850.8676.10672509490478025232.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:58 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 09:45:19 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210216

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c5b80b795e9c847a7b7f5e63c6bcf07873fbcdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
