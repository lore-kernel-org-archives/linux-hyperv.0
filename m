Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FA3803F7;
	Thu, 27 Aug 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850601; cv=none; b=hdC4qfphbMh8+emNchNs6tO0B9qNe3BGGXpqOoKvXcl6jldm3z2VfxcEhvvNdbpMMEHbd78aIm5527E4vpkhE+Jo/MLVfrYS0HL5ePnTmk3bGfZRrc047e/YhE/9Iy0tPTB2u0YC0cSTZUtvCDieBH6HhOMbtTARwpNWwshl2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850601; c=relaxed/simple;
	bh=KPeQgRgizxI8rwIEeF6Nsx6tJ/5iQm2/7h/TNBG1vSc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TXAeX9ltivg7m9YHrSltulu0XmKsd9NUCqZKuTW1Sp9RDYIkIS5twOKp+iBVtLmUxQwGvavcDiuxaiyl05DgNN+2H9yvyadYEWdHlWKk0BRfmc11BlWawwbJswJXedzpqdthgSTxs32LjtHVTFhO+Ndvla15wJV5RRCuPkLCv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlzX5M9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlzX5M9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A01F000E9;
	Thu, 27 Aug 2026 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850599;
	bh=+vY7Gio00hnQmHdjcgm992ztnsXSG4wGEXj00Ylf+04=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dlzX5M9JLbh9R5ZF2Oo1FRwVEBmOxdQtd6D8LO0TSaPZIHtvQiVffcqDnOR6NtMc0
	 OGbsUOyqMyBS1rEe3/EPfdcOhLriLLzQpP+I4nmHQYkIgwIUCcZST+iFQj2qd9N7y/
	 jwoCPBM64WfuZZXVRZ7wPzp5BrRG/kcKZu0/BymcEmMB8JgDtrHstVaUnsK16NrhXy
	 IsmVoGasghcoOSb/6QYUQhW1Q0u/NbYrodXlG0LEbL9eaOgGIy9+Ki0sBdYqDr01QZ
	 7lJ+D+bdTZH7GHr0YY8885TI1qoVGCzAzqnraJ4xxQMxIr1ymwJsoANjYlWMeL2ufi
	 cbiMyglYaASCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2E3809A89;
	Thu, 27 Aug 2026 17:09:06 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260826212106.GA693916@liuwe-devbox-debian-v2.local>
References: <20260826212106.GA693916@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260826212106.GA693916@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260826
X-PR-Tracked-Commit-Id: be0cfab740e58b70047ef6e7e3d578f00ed5d258
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e6ff28676dd92a608eb00eeb8d1319ad34024dc
Message-Id: <178785054520.1753754.5692913989667656928.pr-tracker-bot@kernel.org>
Date: Thu, 27 Aug 2026 17:09:05 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com, kys@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 14:21:06 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260826

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e6ff28676dd92a608eb00eeb8d1319ad34024dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
