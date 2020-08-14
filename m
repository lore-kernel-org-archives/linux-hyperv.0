Return-Path: <SRS0=5ztu=BY=vger.kernel.org=linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4447CC433E1
	for <linux-hyperv@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2106A20771
	for <linux-hyperv@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597437304;
	bh=xmraX1VskVlB1C4HiotcsoIX4dcBJb1puLCu/NmqxQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C3XSA/z1gujinENwprw4HTTZ0Sxp3/f4J5xKXae/wt4ZWPu1rjsnvsjxdLpaigEKu
	 0AYyWmGagDKIVGN6q2VYxr7KvvY+LTpF/SVQ+S9sNICGkMUKPk2DRcJuuvCBCj82ZT
	 GfbxaCd0QOQaWsBJaSHzYRZ8IuhPWP7MObl4Jv0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHNUfE (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNUfD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 16:35:03 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597437303;
        bh=xmraX1VskVlB1C4HiotcsoIX4dcBJb1puLCu/NmqxQw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QWFE1dG8Sxan25P/b2hD4dZvO7/1O388VCtzkZZYimYbaePdWszIDBCsFuon+jppq
         d+rEVNYWc+ZruUccHQo5CGgdYx3JU4ZbYyeWePgx0CHlrdv+V7RtHbwCm8eyGCqhMj
         B8oBAO5040aHkfjF2Uv1fpgnX7/ZwW1QIz9Urg5k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814100751.uirns3llugywet2x@liuwe-devbox-debian-v2>
References: <20200814100751.uirns3llugywet2x@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814100751.uirns3llugywet2x@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: b9d8cf2eb3ceecdee3434b87763492aee9e28845
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd94257d7a8103acf136e4bd46e3d0ad698a6f3d
Message-Id: <159743730299.11329.15823682190785813966.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 20:35:02 +0000
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

The pull request you sent on Fri, 14 Aug 2020 10:07:51 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd94257d7a8103acf136e4bd46e3d0ad698a6f3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
