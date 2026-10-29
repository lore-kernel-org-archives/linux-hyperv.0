Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313965;
	b=vdjJqeYyRlVkYi/bPTn6Om+YvCDVT3QFSPwhjOG83RaO8qHKnPC9m00OJJJNHfXDp0ge
	 iFqUSjsfvZzKti60WIxIxlHMzNc93ixLhTUHrXDLqQvw9373LwZm6xzulsO/Qh1AbcsKh
	 /Vmpy6hyRiQCcKqyjZIKyLBzTq8FWlUjWlWGF0qT6qBIx7yaVcUIAPDrewQCZsYEcmxHK
	 0lt/zfzMNDdozRkY446UtVaCNjIbdBTK5/UcM2NZkVSqC6KyutsVZZ182giNnamK+lvFh
	 v7CFVk6JnA6TrW9gCMIePlluSXRe69lTd2/8+QRWjU5GV9M6wzazVOzQvPM7gPl/N2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313965;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=6wI4m1WVmIVYbP7G0/24p1ugWFdmcHn5gpgD1WpwHkE=;
	b=lsmqg7e4zORdhx4aFuDZTciAatR8GGnXBvoD3XyNk1rC6hoPl+Lpvk/BDfnycqAibwVx
	 x67VcUbeL/u0oH6Tt8JxP/92H9NvQNh5HzuoHdGrIO9N/Yswwn+E5X1VhdoLs9h9mEuIX
	 h6sxSJ+L97C+8gSLhUim0KrfEGxT8Yks5VxDOUpPv8+X5EispCeVdiLzAbu+6SjZckdLi
	 oNmEjw0V6oG2ytkIsg2JDXPswuv8aIKYKvqNsau8gH9T/YX+1ARfNpaCy+AHll7dVItqT
	 R0pAc99Ddk6o0CPVBKYMDEJ+hNA4eKT9vqjEMIMV+XEnPivDIpVq+ov+jv2Mw2iFw5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeErXzHC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3494606A322;
	Thu, 29 Oct 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeErXzHC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECA1F01824;
	Thu, 29 Oct 2026 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313964;
	bh=6wI4m1WVmIVYbP7G0/24p1ugWFdmcHn5gpgD1WpwHkE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DeErXzHCyHwFWAOkUX9RhxeWvcXEaVWNZfLdpq1c0Tq3/yXlXqSUD4n5f8f4w53Ex
	 1S1ervF4T7KYQ3M3V9NBX52GiHwUnf/Vt0r5RXv7oUZT5Qt0un+4LxAn1IUDNWnebQ
	 FWxeXs7CorZ04kcAuf/sy3RJPoT5HRFUgIW6oHDK09DUd52pkrNi+Bfk6DWahlkDYM
	 0bC+MN8SPFd3FuXIt8L6Lfr6XIsyYBtdWyzfRD5oKadh06GnS0Rj+vS08AC66or23E
	 SFZGFD/sQkqKZrylRGqQMLcIe+IDAyYUO8yRW9kUEH6TFh0NQfJqegWKEh9sMWVZfy
	 NBZ/8wbkvieeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2D638007D2;
	Thu, 29 Oct 2026 22:46:04 +0000 (UTC)
Subject: Re: [GIT PULL] Hyper-V next for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261029055527.GC3595008@liuwe-devbox-debian-v2.local>
References: <20261029055527.GC3595008@liuwe-devbox-debian-v2.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261029055527.GC3595008@liuwe-devbox-debian-v2.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20261028
X-PR-Tracked-Commit-Id: 33b28f3b313353f11fc939e9a268605e66290d0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c7e3d59107e2daf204bf6bf87b6c448ca89defe
Message-Id: <179331396323.734384.13955158115992451525.pr-tracker-bot@kernel.org>
Date: Thu, 29 Oct 2026 22:46:03 +0000
To: Wei Liu <wei.liu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, decui@microsoft.com
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 28 Oct 2026 22:55:27 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20261028

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c7e3d59107e2daf204bf6bf87b6c448ca89defe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
