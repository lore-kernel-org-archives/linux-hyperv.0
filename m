Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E635CB7B;
	Mon, 23 Mar 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304425; cv=none; b=CNGXWMsSqHW2iaHfIifxN1zAepRosn2yS8pXyzsB2MXzV6Yj41YfenbG6OAgDOFV/kAZjcOOVekLDkA8qhPxIxg48FHMA4vvvZUAQcpDCBXXB7CvZ7J+WTFQX1tIbZXC/DQN/5T9BoT3oeIi5x5w3xq3ebz6YXPaBv2kNJffxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304425; c=relaxed/simple;
	bh=u2PRXKsBmPIwGWhx9jKQwzxH5qBqFm5G2OrNpkcG+cs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WUuvfARe39YXOq2IpIomBGqWRScNs70s+BuFe1ZEnHY2D2/lFAgmgZXcA5HaiiaPi3n2ciOft590mEBNCO1UczmdH34/rhLnkx9hVAdEK0SGXxuq6Rz+zZfS+DiDip+dVewPvLON474bMGVe9qlb6unKG37receA1tXiDH0Lq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taLPUWaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taLPUWaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C32C4CEF7;
	Mon, 23 Mar 2026 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304425;
	bh=u2PRXKsBmPIwGWhx9jKQwzxH5qBqFm5G2OrNpkcG+cs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=taLPUWaKoOMvChkXrNDxMSLLzjVXBxwlbRV386OlYFSsbXE4j62rtjv7c1OsQknfR
	 nLvtXP2RMICCzkyvZxMqApgP4jMFQig8OXo65n8Egn9hXBcjJzrVulArwYUIHI1GDa
	 fcP+ppiXCuae35K4q3gN2PCS641UEFhs/qz8eRsO5XcoPBTTppmhwx29af8nvFZt1l
	 2npEYfWNrxZoRvNYLq6CKT4cooSK8hnVnR3hh6YTlk9fHxY7GjllbQevF+S2tM1Xe/
	 bBtQEdit3rufeJ/PatEBVI/sS3w6ZvOW8r+5riPTBx+kRRd+ZH5a+gduaR2DfSZzDz
	 /rBqkcCDcQCYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F273808200;
	Mon, 23 Mar 2026 22:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next] netlink: settings: add netlink support for
 RX
 CQE Coalescing params
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177430441353.345009.4314896579030595975.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 22:20:13 +0000
References: <20260320203159.1590235-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260320203159.1590235-1-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: mkubecek@suse.cz, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com

Hello:

This patch was applied to ethtool/ethtool.git (next)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri, 20 Mar 2026 13:31:59 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add support to get/set RX CQE Coalescing parameters, including the max frames
> and time out value in nanoseconds.
> 
> (Headers: dc3d720e12f6 "net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS")
> 
> [...]

Here is the summary with links:
  - [ethtool-next] netlink: settings: add netlink support for RX CQE Coalescing params
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=d35d87fbcda9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


