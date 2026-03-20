Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75A3CF050;
	Fri, 20 Mar 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023956; cv=none; b=gyFgHLirueYHMrVZXqa6wYm0NMzIj1BFynCtEwWP1vy1Cj8ONU5zJE6qYaBapwbmPvnGIUF04ArH09+TEGlW1zWmx8AkNlvGk0ekygi+zoGACkPpvxSpnrQ/HjIvWhGuL+RDlt9kggVDO2OKk3chPAXmXPDM9aoq+O4+R6+ggkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023956; c=relaxed/simple;
	bh=4pgP4a3teJS76+1j2XkWjbfkGLLyVBiPx5OiBid/8s8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YhLitTJWnb0nzXn910aA/sTN25bWjlPjHStmcST8ymLlk7F/rWajhxSfwznZSDUHdRuOrmfDXT79D1yyfH6n0dqAa4vTPp4anFp4YzBBu/am7jw2TOj4I1vx3an/uyQ3NbkKbxgqgCp+SzwD7DXSQX5OjEP32e9hmvFlw/9/5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdDBycia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdDBycia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD96C19425;
	Fri, 20 Mar 2026 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023956;
	bh=4pgP4a3teJS76+1j2XkWjbfkGLLyVBiPx5OiBid/8s8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UdDByciaE3eJRObkt8+bOGJSgNPm7rdTtBm8J/e1mL1DkUi36l4bE9TfWloORbYUi
	 dlTJyPMT+cHrIHkPONtWLW7eZkVLFEp4qjrVAnNcIXfBAkjY6roA5xZWiFoCuuJYi2
	 CthRlZ8Obg6UUI3sXn54rbItjEH7wfZmp9qxXDjLWGRO6KYSAIoc9Wg6tKwWM7ctN1
	 V+MmBHoyZn1Sn9wfWs1Csg+1JzccmE8wIyXsd9TJUnd5DlyAsDWZJylWrupnt8iWfi
	 e1d5eHtVcSUoAvKSykriFFx6QNPEjEGyhMSlDJJeIVEiuEI1Mfrupg+fvAxFq9mrXL
	 5tJQ6ZDG2CEGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D5349380820D;
	Fri, 20 Mar 2026 16:25:47 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260320051524.GA759166@liuwe-devbox-debian-v2.local>
References: <20260320051524.GA759166@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260320051524.GA759166@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260319
X-PR-Tracked-Commit-Id: c0e296f257671ba10249630fe58026f29e4804d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3d13784d5b200fc4b4a1f5d5f5585b8e3a5777e
Message-Id: <177402394660.2556506.5209654560701775360.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 16:25:46 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 05:15:24 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260319

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3d13784d5b200fc4b4a1f5d5f5585b8e3a5777e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
