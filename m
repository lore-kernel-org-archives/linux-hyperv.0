Return-Path: <SRS0=Xe0B=56=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8CC2BB1D
	for <linux-hyperv@archiver.kernel.org>; Tue, 14 Apr 2020 19:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CF52074D
	for <linux-hyperv@archiver.kernel.org>; Tue, 14 Apr 2020 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586892430;
	bh=HMUCX6aWm71uge2BoPhYzk7fH+SUIkv3Ru9XRaQuLNU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hJlqTT3kDAYcDhyINO8n8vinYtXR1EiJf/E/uW9/fwA6mW1dZUFvn6eYyYW06SwPV
	 aveCiXF0DOV1xSY7XsdqruoSwLhWD6leYe5oOGvxQCIBTy5cZ2xTX1NzrhU7S10Zig
	 jf0s+bDv/7AegiSBJK1LjP54lKE4s8piBqi9LPbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504642AbgDNTY3 (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504621AbgDNTYU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:20 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586891122;
        bh=HMUCX6aWm71uge2BoPhYzk7fH+SUIkv3Ru9XRaQuLNU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z2Am7yZ9Y6qIZ+x31ILB+uyNWwcbIcSyLo9IF0AyGIWnM7Dh28PMl4sErQo+wDe95
         0zWy1rp1oOAyF2hpudVmADjltiEqcmThWlQVOfvS66ktyD3pbV+3nXdTAnMdu3l2wp
         1qQ8Ntaf6PiCB/Tu5J+iiBBgFWTiwGout1cny5xc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200414102102.7jci4pzsp5tdoifr@debian>
References: <20200414102102.7jci4pzsp5tdoifr@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200414102102.7jci4pzsp5tdoifr@debian>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: f3a99e761efa616028b255b4de58e9b5b87c5545
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8632e9b5645bbc2331d21d892b0d6961c1a08429
Message-Id: <158689112259.29674.18320264839412857827.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Apr 2020 19:05:22 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        haiyangz@microsoft.com
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 14 Apr 2020 11:21:02 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8632e9b5645bbc2331d21d892b0d6961c1a08429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
