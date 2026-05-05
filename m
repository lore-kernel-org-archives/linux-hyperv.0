Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174B17AE11;
	Tue,  5 May 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948268; cv=none; b=sVWeoK8BM5K9eXxpsc2N40ZfVVSM70lDLeRF2kfBj0dY0FmQwsLJJZ5PwIyMP8Ycpk/Wz0PA28LMxhentMeWRmUq0pszShCN/39UMj5CemAh4kZrCVMCqpSsIEJfzlvirWkPbLEhf+oUduND/BLVocn6UJvDzZEw4DxOeykbK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948268; c=relaxed/simple;
	bh=RCAjlfKuZagrgxtMe0XjrLpsCYqCn3cYxzS3K/p3io4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rbgm4uHU8GgwYJbTI0MnUHpufmhgWM5s7MiBla6m5rDCIGFtceluVZKpT+HtpRfJbJKyRZjPVjtDeo9XVzbjvFZLaf88lJ656m1Nhgzz8yl0Jbve6ziKqv4Wx2K5l5YLPymnNWGGc5AZ18drz59gRxxxzZ0SA3+AyXcRQzVqI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/S3bRzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/S3bRzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044BCC2BCB8;
	Tue,  5 May 2026 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948268;
	bh=RCAjlfKuZagrgxtMe0XjrLpsCYqCn3cYxzS3K/p3io4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/S3bRzH5NibC2wo+6jcKtYgfdcsVJdUdCHSe9QtZdcbDWrf1/TJZeikkesNZydEz
	 8+VfDfuPaSeMbpu1jNpvBlz1Cc+Y//tTvDcwUHxNmarcQdMt4DHhvOtKC0eG59/83J
	 YU/TK8J8FGyIp4+f7TvPgKUDGD+xxCcDCjo86d7E+InSSPBRC7HAb1jCS8iQTQNkTl
	 dFp9Jg9hbxkWqqaJ3XLIfLhXXjpfM7MdgmBj8lIN0cOYtxKm+xYln9Gx+gQMfdzd3H
	 gMGy0Xf45TzWRoWkmMviJpsYNivRXF/rAOeV8+dQKFlSKdo4rNIl+IhJSonMmr5ipX
	 cyRc+lCHe/nAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E3339301A2;
	Tue,  5 May 2026 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: hardening: Reject zero
 max_num_queues
 from MANA_QUERY_VPORT_CONFIG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794821880.1394832.6493120099852463221.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:30:18 +0000
References: <20260430085638.1875400-1-ernis@linux.microsoft.com>
In-Reply-To: <20260430085638.1875400-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 01:56:31 -0700 you wrote:
> As a part of MANA hardening for CVM, validate that max_num_sq and
> max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
> values flow into apc->num_queues, which is used as an allocation count
> and loop bound. A zero value would result in zero-size allocations and
> incorrect driver behavior.
> 
> Return -EPROTO if either value is zero.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG
    https://git.kernel.org/netdev/net-next/c/93ca1575dd1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


