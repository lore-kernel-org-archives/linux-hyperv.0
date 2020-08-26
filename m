Return-Path: <SRS0=8BKv=CE=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAC4C433E1
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5562083B
	for <linux-hyperv@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598466859;
	bh=Kn9WaOAKN7gXslPeBiPkoNqVfs7VTSHXV4/e5nBFjyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Epdg66q/+oSnaPC2+Tjn3HIS7G+ObYFalmSsNpmrQGgqpoLtlKFWwAziPpHpOcOhS
	 zhSPB/LwojQbRKpGh4B/CykVAJ4Y3+xqi2txEsIq5ZvzfwA4Zww/0Cmd9PyHAInM0e
	 GuAlQmigzMCgDt4tu6ETPogQT9eXuIs2WhTJLDiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHZSeT (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgHZSeQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 14:34:16 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598466856;
        bh=Kn9WaOAKN7gXslPeBiPkoNqVfs7VTSHXV4/e5nBFjyI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z9XIbgaVkfXWNe/BEoZsNeaIYzMzdqf4uZ3oD0dttVfK01Gol2aI4LW6cybrFeYin
         8w1GsEslf6o2L+sLRDi+3UoEr+rrnCo9ByzkyEDFeo4MPgVbaGfhken3W/VM6xKkbY
         I1xJqyu1iUMjCU4rcaGO9dnyBj+Dgs/c8C9E3LDo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200826134111.465ose3oyoyx6h7b@liuwe-devbox-debian-v2>
References: <20200826134111.465ose3oyoyx6h7b@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200826134111.465ose3oyoyx6h7b@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: b46b4a8a57c377b72a98c7930a9f6969d2d4784e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51c4518ab77c6d3e917675891a9a529daabfaef1
Message-Id: <159846685643.8056.6413043000779754006.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Aug 2020 18:34:16 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Wed, 26 Aug 2020 13:41:11 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51c4518ab77c6d3e917675891a9a529daabfaef1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
