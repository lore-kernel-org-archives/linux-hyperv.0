Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08DC433F5
	for <linux-hyperv@archiver.kernel.org>; Thu, 24 Mar 2022 19:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353275AbiCXTpz (ORCPT
        <rfc822;linux-hyperv@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353112AbiCXTpy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD343A724;
        Thu, 24 Mar 2022 12:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F9A61AB9;
        Thu, 24 Mar 2022 19:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C050C340F4;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151060;
        bh=UtErAgugF9IOD8ONeuDngANkBj9U+gQPaZ8hc6twRZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=byXI5AzzT/M+vxzCCukkegkpO5Z56dpGESA49rxwhrapmiZeQhhC1ziyt8p6KvobX
         GN3CJTyaHU5yFoY/ovFvGamVsR3bej/GDBCSs2ZXElTimOEKQfmKluzq3TAz6DELW4
         1c2maxm1A2XPNaAHZqM/iqH1lBfuwUL8wFAmccppMRZIsYWIY5QrOdWJFD3amMfPph
         klB1Zz2jybir1S3G+tNxDnBuFcu4ZCa/5ZUhgDbXHhciH8YKi6m4s9+HPH6oC5kk8f
         EN7KT+Y/211jSm2RqcS3At6vaa9yTyXuijTruiAk7cUEXxGIUTS+l/15bwBW4OqrwN
         ooU8lOcN2eEwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6945CE6D44B;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322205441.ah7k6aj7csdwa3b6@liuwe-devbox-debian-v2>
References: <20220322205441.ah7k6aj7csdwa3b6@liuwe-devbox-debian-v2>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322205441.ah7k6aj7csdwa3b6@liuwe-devbox-debian-v2>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220322
X-PR-Tracked-Commit-Id: eeda29db98f429a3b6473117e6ce1c213ab614f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66711cfea642a162bc99abdefe1645b26dbd778f
Message-Id: <164815106042.31218.2313626155089106836.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:20 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 20:54:41 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20220322

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66711cfea642a162bc99abdefe1645b26dbd778f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
