Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998933A9CF;
	Mon, 22 Jun 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146203; cv=none; b=UsBW5fxrKSh8WgiF2Y4eNmx/jEQzPUFQcXC/KcqgypeVMGRzKs/dWvbEkMGkTJ6SCDEh/PABDfCUHSPXF1GZkmpJfsDXCDc23+UNZMDtvjfJhPebcWZ1X9OjdUJp1aShwUJbQTOjJnh8zIfhXUK9a2yEPmAgK5ABCTu6uSi7pUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146203; c=relaxed/simple;
	bh=NWyY1R7RKyzQvPmtlMxYv6ZUPEFgvPpc5B1Ze5RtF0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fdKTbsl7KxighfQdnfGEVT0EINCONMI/phBWSEUjA1UaWCaY6rtskRGOr8+zQ/OlcXwe3Txnb/C82rBV/zNMpzM4EcD1vW2VslJkE9AB56dJ3pbFDkxLy/O/0R5tKxKu60stuONYgeGRURB1YlWFTAYWayTnRtvzj7eYjTRTzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqGBmWD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqGBmWD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085151F000E9;
	Mon, 22 Jun 2026 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146202;
	bh=wqStrO37Yvo01QvBb9ZJsm0H8Qof2xASnIQrlNFRE+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kqGBmWD90FYSVQKiuUlxByJ+qaTAb6uuMT6TeMGVdilQ9zIK1GWE1dLbxkMARBTl5
	 qqJver7lleXA6XSZivRF0c7UVWTwfk9kLOTh4yAE5+MWPRWCqBxpVz6jiGsLI2mLS0
	 WM5LeuutG9i7NrZtXyTYk0KvobnDab8jJ99lSj08J52YY6bHB4R5gVtcunQFOxF7Zy
	 zlfuDXrqt1lT2PpNOYMGV+qSnQmlCqPJcm/YYXO6D+bLQzdIdYozpADsP7/y+5O56w
	 mFc90kAajA8lc0HB0WSFxQz4SZB43FPvgyh/Amsg9zVicwi3Ep6eZTb+W5ak6M6KEo
	 iPO3LTDtjMTsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C733930907;
	Mon, 22 Jun 2026 16:36:33 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V patches for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
References: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260621
X-PR-Tracked-Commit-Id: a4ffc59238be84dd1c26bf1c001543e832674fc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e869de3a1b9ef9f096223e0e7f30c727de4f6bc
Message-Id: <178214619241.1310507.16461535384209779931.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 16:36:32 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Jun 2026 23:45:49 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260621

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e869de3a1b9ef9f096223e0e7f30c727de4f6bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
