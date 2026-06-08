Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE641C2E1;
	Mon,  8 Jun 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931038; cv=none; b=khLoqM4B57VUQ3XYHuTPShR3CYdOwe1P835I/FAveQRAUlrLsUfTCUd4jVDkF6/Dbz83OiI/MgBomX5RlNvHKoQXzhE1l+Gi2NaQA9Np9OrVSiF4ZpTALQzaqtZjxb8K+5yNedV8jC1fospYovmp1pXulyQcPsr+5oZCm9vMQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931038; c=relaxed/simple;
	bh=cvXix1/czz1rnKbxmTdvgvLvm0m2nMPf8k3z2mqbNEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NdEv5uLFDZ7xD1VORwCTCdtBW7WNnJ/X87wklckoCn68xhN5WlgC15/woeEKp8juQmkcO6QJYt7IRPkhINKWu8vFsKHwF8luGppszPRt5xZaPyX5FHxJ1op+F6FtsFzf6eUupnl7fnWm3BjxoRoBAVkzbDFuG5JbkuR8br4RCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHZlMNP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHZlMNP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27EA1F00893;
	Mon,  8 Jun 2026 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931037;
	bh=QtHnCUrGvuOBvcaAChp7PbVS1X4Upstaaaa/0mcr1OM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PHZlMNP6yGxgZtMPzJq9uUsEk1v4WxnBba77qiCAnb/2LMAneFxk2t3MxnzlSqO/n
	 XNSfu3FXXmacXzvcMQFdQCBaaCxSpBU6iX7piFTyCb2MmAcJlXLAg8u9pboHoTu7ti
	 ufW/wliMHA1lcQ+2hCGM61lCYY23MeLUdMH+Wk6gxp4dxI2rfLYdCWIta0sVYdxNdR
	 klceEoij/TEiWEJeo1+P8JokjRNKGszrjLD9VTjNGtOAKw3AuxaSfYuD3tDTpzRZdf
	 JqK+XOOi/dZncgCi78wFztR1WF1eiMdq/qjZmdfmmYkIzP2dg9O6ruVJMjENa58XMy
	 zz3UTg3igTHFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BC3811A67;
	Mon,  8 Jun 2026 15:03:57 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for v7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
References: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260607
X-PR-Tracked-Commit-Id: 98e0fc32e53dd62cd38a0d67eaf5846ae20078cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e92a7628772ba49f3cdc1d141cd2b0b5d607bda2
Message-Id: <178093103560.1528785.10563931039261125990.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jun 2026 15:03:55 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jun 2026 22:34:08 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260607

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e92a7628772ba49f3cdc1d141cd2b0b5d607bda2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
