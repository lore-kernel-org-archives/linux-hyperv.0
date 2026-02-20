Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6D30B50F;
	Fri, 20 Feb 2026 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620641; cv=none; b=F1x9VkMllnObh9nNjyBnwlZvinfIM+ZyikSmlhkwVX1Tl/7oQzKJyBP1oWasjGH/THIgR9BrtNIROLrISWynlcZHn1lmP+GCLNwkXavCk9SvAO/BEDkHPFCNlJO1B6wJ/4BclwXqXFWv9nsg4mZYJSY4E2l+6U1y0NNocjOnGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620641; c=relaxed/simple;
	bh=SUZwxnxmtzXdCjMNVUHLjjaCuka6f1oiHBecNuooEAc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KTN26UBJODwNfYdFSOoU3CzfqmGFEF5RQKcC2tS6qYDAMoNeVgVFKRPEGxl877kr6Kf4hgHmzkB1/dnEFHHonjJCkh/7VmUJYZzuTz4okl6B9oj6v/X20gT4ThsBBbo5vOCKqcEhYOaZGI24LPA8+SQIpIkt0t7sit53GFWTykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MATDGESH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MATDGESH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8269CC19421;
	Fri, 20 Feb 2026 20:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771620641;
	bh=SUZwxnxmtzXdCjMNVUHLjjaCuka6f1oiHBecNuooEAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MATDGESHMhx85m5FDY/4P+IY1jU8SnoCcAXd2aGCuhcajl6qOgGWIKiAvyuclDLF/
	 Y9Eo4M/cVPCibWV0bfkNk53+zfzB7i39j1VmkuvcNcJRhkaEofN5Oz62D6XiVx9k7L
	 pURXeWQ47JQ+bZ75jYM1RhloL24XQOGMcpxwDQWasmSRTIQdmUO5vb0tmeJfw16nHm
	 e2pN+Ghz7XEoC5DbcxSiV6e7PSW8XaOWjPwEPjHi7g4UfGUE8Nkbn2gCo0/MkEyckg
	 eq5Fx0n1r1N+Fe1eDlmqtEJZ/6HGWFo6nER27263iPoSiwlfNul6yuEgsSy2Q8Up/c
	 zlIPO/14PLV9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FED3808201;
	Fri, 20 Feb 2026 20:50:50 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260219074550.GA2773704@liuwe-devbox-debian-v2.local>
References: <20260219074550.GA2773704@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260219074550.GA2773704@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260218
X-PR-Tracked-Commit-Id: 158ebb578cd5f7881fdc7c4ecebddcf9463f91fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d31558c077d8be422b65e97974017c030b4bd91a
Message-Id: <177162064946.902486.3361863673453264323.pr-tracker-bot@kernel.org>
Date: Fri, 20 Feb 2026 20:50:49 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Feb 2026 07:45:50 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260218

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d31558c077d8be422b65e97974017c030b4bd91a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
