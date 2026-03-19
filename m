Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF440DFCA;
	Thu, 19 Mar 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889820; cv=none; b=ElhqU8sslg7FS5rTCmlKc7NZHg/JySVKkAv+6ZuAwJt8Mdj06U+okkP7yr2tkZYUedcQ031R1dq3fURzZTMHUxvoEmqBiHOMy03K4m5/qkovmXEx7bt09e9/O1q0bU814FgXl5GvhVFZsluLvKdxBsJQKBcK4KryeECeGCZ55RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889820; c=relaxed/simple;
	bh=zrtGPBlmwv3bHJ0dKnfcrKQ9djenXXqNcDoZSmgUT+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rdyGt0+j0SM8Xbi3jY10yaqCHcrPT4tAhURzJRCpgO5IkSfrRHdNcZrXVd98P46fxtN1S1Wu8Fa0CmuT6ECRhI/WW6mzhtFgVRMLxTV1ECYtGy5liyiMsmk3G2GBYo3vkl9ngI5qeYNUFZscR2BlSBNfrAi9JFxskLdmH3aMmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOei5mc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOei5mc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408BCC19421;
	Thu, 19 Mar 2026 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889820;
	bh=zrtGPBlmwv3bHJ0dKnfcrKQ9djenXXqNcDoZSmgUT+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOei5mc5gT2c9BwbaIa8RDhR6gFhY9dA1NaIxaUBJKtjAtvC7k9gryvInaaZdHrnU
	 6L3osodVwZgaP7iziiEK6GotFJeoBTrZSIyjzaTjwCsBAc1fw66GW4DDF9/uWVFkZK
	 B3MeJ2K8Ts3S0s+YdPOeL8iIFA7B+0fDpOQ/bDaMxrPhCvj1eA2e8gQq94qeY7V720
	 0bnwdsU+jmxMN1ShVUCl3qbLWuZOMXWf9CjR8uNBjxokyvHK+1GoqoU+vAHtYqaW+3
	 tAg5y/uh8rEEGNgLZUKn4fC3LcnecEV0iZi7Cb/aR8PvUOEVn3dtCU7ePMN8SJh5Me
	 xcd3MQSVuHRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1503808200;
	Thu, 19 Mar 2026 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS
 and
 use it in MANA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388981154.1008325.11236653611617046174.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 03:10:11 +0000
References: <20260317191826.1346111-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260317191826.1346111-1-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 12:18:04 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE or
> writeback.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
    https://git.kernel.org/netdev/net-next/c/dc3d720e12f6
  - [net-next,v6,2/3] net: mana: Add support for RX CQE Coalescing
    https://git.kernel.org/netdev/net-next/c/c2fe3ff3d66d
  - [net-next,v6,3/3] net: mana: Add ethtool counters for RX CQEs in coalesced type
    https://git.kernel.org/netdev/net-next/c/d01440e10a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


