Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E6C56202
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Nov 2020 23:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92F420717
	for <linux-hyperv@archiver.kernel.org>; Mon, 23 Nov 2020 23:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0hQVK0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKWXfS (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgKWXfS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Nov 2020 18:35:18 -0500
Subject: Re: [GIT PULL] Hyper-V fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606174517;
        bh=OjRwgYvjC7vz/qfUdF+Ir9evUzXap6tTZKJIbtIL+oA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V0hQVK0rrLkwymWB8G2gWGD3W8JxNeGYeJSjrZa2DZt1YpH66Rqux6r9Qdu7bt8yo
         xMiUfuxP5oZK7vx0KW1Rz5L+TnX0aedszmLyEjPZJnlDnBjVpAtsmB5/hhhrxNcuUV
         NUISW6+4EfPxkTJDXczh+kMO125OKHkd5r9EV6x8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201123110123.yeaovck27pc2odiq@liuwe-devbox-debian-v2>
References: <20201123110123.yeaovck27pc2odiq@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201123110123.yeaovck27pc2odiq@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 5f1251a48c17b54939d7477305e39679a565382c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
Message-Id: <160617451760.16558.12498787497038286492.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Nov 2020 23:35:17 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Mon, 23 Nov 2020 11:01:23 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
