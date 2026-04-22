Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36B33C502;
	Wed, 22 Apr 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890321; cv=none; b=JDyhnKYEKzwIj3pTnPhl4e2yALW1LpVMohZA5TTDucJ7xn39/DTheDMGFw3Pc1ErSOSEsbbPZq0xKZpEx+jZDyhDNgkI7Yp5GPECWmpvJSwrPuYavYPI4yF7nXffqLtx+uI1CiKW5T/jo4Zz3s4pNAkEkYkpt8wm7wi5cyjSDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890321; c=relaxed/simple;
	bh=xQurz2Xvezo0AomERFrCJsXM1shY44l+I/2QOjVwsKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IHJtXbAy/fPQ2ZBrFMnYBhPYna0f9OSwJKHWK+MCt4/v3hMTjbFfkmi2u8frF09psFIiK+Hp0B2/exKG5fEbAG3GSf66aVz8z9JvljZ4+l/8zxkhUQ3inzcA4sYGPNDqOTgzf4Sw+fU5Y+dwfJlQxlGDi8PgHLURV7RntFyTHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnKVT1S6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnKVT1S6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C075C19425;
	Wed, 22 Apr 2026 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776890321;
	bh=xQurz2Xvezo0AomERFrCJsXM1shY44l+I/2QOjVwsKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MnKVT1S6fmVMAWI330zgXko+1QFdxiqraxDq8j2HaPBSX7WS/NL6PTmjQ1yzo0lFF
	 S3DQ2IvPk8FH+r2hGU4D/OyS5TlhaBbB0NdT6znbipFFKyfDk3800LROIJb2M/Zcu2
	 YOZEzm8R9UyIlZiLArkQUE7F0gMdo1zhnVRYoj6Ov2/lepMHh1NvJlG/uKc0qJ2bca
	 kk5caOOmxv4JNcoAl/hxCz4uXg6isJw4scX+uqrOtQX4tXnHkHxaSRxDcDq8syupCn
	 WXjWqghk6LoLwEHMBSs2PgEgtM5Fuu8ctcg8SBomotnXC29jEbhs6Yqh3SKTp6lFVk
	 jAp0JhWmw8irg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0513809A84;
	Wed, 22 Apr 2026 20:38:04 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
References: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-hyperv.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260421
X-PR-Tracked-Commit-Id: 5170a82e89211d876af17bf3d94a511fb2bb4921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fd12b03c7c888303c3c45559d8c3e270a916f9f
Message-Id: <177689028316.4027770.934602851877617668.pr-tracker-bot@kernel.org>
Date: Wed, 22 Apr 2026 20:38:03 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Apr 2026 06:48:24 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260421

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fd12b03c7c888303c3c45559d8c3e270a916f9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
