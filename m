Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5B3CD8BD;
	Thu, 15 Oct 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077467; cv=none; b=igLizOMj4LkuYOogmqqpowHSGZRWdDrKg/OaRDKrGC6slVjIPmUt0SkQrmDH01JEa5O0FIfKJUueYHt4ulTFQbNA/9skQ4J9kGNOl3/NHZknOAlj0LaduKG3Qgq4QmFWBxpOVvcvK1M2SouOndWDu3VXM4IRBrvpvHNl0rCd6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077467; c=relaxed/simple;
	bh=h2Iy0R6vKuyK5VPkaxF8HNYsRF9dMgH1cP9pWNDUAW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oVMVY6Gj8XO1M0Be99zLVL30zD6zUyg1lwlc7PQX9eCiBCw7ZAl+DGr6Xc6Hl2v5I+VGL5aZvfzkoHIzfI4G/V5KJV5+mOs6r5g2tzNIzHU+KpDaP6BHG70E+QF09FZPmiPooFNiMQdTEhQHHzcuXuar6EzRf3gi7lTo9S94VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhJVDTGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhJVDTGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090B81F000C4;
	Thu, 15 Oct 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077466;
	bh=2ln10caUd09K2ldjQWhf5+xEkYu/SuUHgH99g0J9LD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bhJVDTGm5nhM5ajAo4tA2WHQPrI+5u78lN9uePVLppdOG9uUrtK318R2m/DOPtyUD
	 +WchZgtkuim2wFJJQZSvI1samxa/nhDS1KwFw3r63zn40IN/fIFulUdqIeSpqOfh85
	 WDed4+tcIOAcLybcKJ9PzaaSCeLg1UvsuqTLdsHLdNGaTEuKRjxWO8KhflqfV3BJF7
	 BAKStdmfXTfMRoZtN3xs/mOWk10tvcly5WdJIIhjK6AYD4mfzYReu7wVZ/vAOPhBA6
	 O+pSEa/rag8zcgmaBAVzfVftgY8x58OAXKkCC8bC/NODsQ8eeEoJsMocLIPhcmN4wd
	 BhLCAMIpTuJqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1508392EB21;
	Thu, 15 Oct 2026 15:17:45 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V fixes for 7.3-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261015081110.GD936897@liuwe-devbox-debian-v2.local>
References: <20261015081110.GD936897@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261015081110.GD936897@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20261015
X-PR-Tracked-Commit-Id: dbc393f6f009a2bf7e4a22ef2d70b53f533f20f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a66840a68683d9361a9b31faf3bd8104428ad29
Message-Id: <179207746460.3496071.18038049043984104098.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:17:44 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, decui@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Oct 2026 01:11:10 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20261015

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a66840a68683d9361a9b31faf3bd8104428ad29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
