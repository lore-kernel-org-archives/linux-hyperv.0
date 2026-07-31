Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9A37E5E8;
	Fri, 31 Jul 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532703; cv=none; b=kLQAuKf50Rrc72tWsq7TdCjLk+Z+Y+58p30zGwk92cAiQdApQ+azD7ZqNfUEmx2bVWzQMOjute7g8WV65ww8yuron4g36J9vIyHv8lJ0lcx7xHbzfXomf8NoHV6t/xoq4eG9OLNKqVrig0zBe5b+fNMq2hK/1wqyIgr/4F8Qtgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532703; c=relaxed/simple;
	bh=8DHivmJ0/l0Ljdxd9VF5JPHsrYTZGxHSg6O4yZ8COHA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ji+9AduI3XSggkdyR62rEKgVmYBhQTIFxca0QATMiLDYpHGmoYF7s5dTFW7QBwQY2lhbVxiqXhAlx1YZVChJjxChIrzIbFHjaVbuekTse230zdiyOoNyLYfybSoR7gBLeURcEVy/ElQkxLlKSo4Bn40YJ3eSUc10NXsHmfqHE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh8javHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh8javHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8281F00AC4;
	Fri, 31 Jul 2026 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785532701;
	bh=WWa2ltw1j5cAIYkimqn7yp4reHnGbrAjjBxi3yo+Zh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Eh8javHSmPWsuJNDim3WXuoCjvNOH+/7iUVQ6vS3N3G8ZNhf1fwo59twiQUJSsJ/x
	 LA7iwzSWuKie11TDa1TKSUdTLtfVCXmdfalTLkOw/CW52EVbbcR80nxNTUaQpYNZXx
	 +FIp1Dbbqip+WXubi/oNwqu074ltoenwmekPpB9jLb4CD3F1JDYPJBwzKWHH+9IRPt
	 sfa++sMtHXWNvNQtv1UrSlSRa9/vU/3Pnc3LoJrEKBfZfo7yRG4l84qfoacnXY4o3X
	 54VhywQ/pnOoS05LqAUT8yK3JTeKNEFULnz+6tTSbU2ja5lvsOZ1rlKgJFZqaQD/va
	 fR3NqG3xg27Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A403926653;
	Fri, 31 Jul 2026 21:17:45 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260731201748.GA3243806@liuwe-devbox-debian-v2.local>
References: <20260731201748.GA3243806@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260731201748.GA3243806@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260731
X-PR-Tracked-Commit-Id: 22dfdc17ceadd2783a609947af621a7f697b7765
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de8c3b8e05e14cc8c0654881257c49a78c3e5259
Message-Id: <178553266432.908029.6269746967040332885.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jul 2026 21:17:44 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com, kys@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jul 2026 13:17:48 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260731

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de8c3b8e05e14cc8c0654881257c49a78c3e5259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
