Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75618C11F67
	for <linux-hyperv@archiver.kernel.org>; Tue, 29 Jun 2021 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4DE61DA8
	for <linux-hyperv@archiver.kernel.org>; Tue, 29 Jun 2021 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhF2UAD (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhF2UAC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 17A4F61D9A;
        Tue, 29 Jun 2021 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996655;
        bh=19i31BQ1eXD9q2J1sX8GQunX6PxvfYuWxVptVFULJ3g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jpvsIO8v4ZdmEG4mw4Zh69fVGmZ4oipz0Gl0Nl9ePyaTx7oZHyERhNUuOWPQizvcl
         UbPTutKE8R9nwhupN1TJ9qmRN5KHCN38sMSoGguDlqULUC7sBI912pVstPCJA5fRpU
         IIX5q4xBO6OuHPcRYKWG+Ni81HsVotUzbGAK2nRCaeX25qgxbshmk1NOMalvgqbfid
         ukpXZpthY++gnWqeAFvmFDznYJWnEj1UIx6N6cVUoHh+/Z2H9Ehh1iUU3204ZIMWY3
         tEsclyKKmaqz6P9GEUZ9x6qTFcNPlvGzH7Bf5X7Xguffy/+XJ5FkmWe0TGjlX/0E3p
         FzadPK9Vt9aXg==
Subject: Re: [GIT PULL] Hyper-V commits for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629110154.y7hegtxwjbo55kue@liuwe-devbox-debian-v2>
References: <20210629110154.y7hegtxwjbo55kue@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629110154.y7hegtxwjbo55kue@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210629
X-PR-Tracked-Commit-Id: 7d815f4afa87f2032b650ae1bba7534b550a6b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b694011a4aec3e8df98bc59fdb78e018b09de79d
Message-Id: <162499665505.30376.13738829394335710206.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:35 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 11:01:54 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20210629

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b694011a4aec3e8df98bc59fdb78e018b09de79d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
