Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6C36A34E;
	Thu, 25 Jun 2026 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349750; cv=none; b=DuzlgaD5KltQrtPxRSkQgo/VtYzp1d4byrtTgtsGiHo0uTDPVVDzemWTa4bzmL+DWcVeWYEsWPSgU73v1aj15ec4486GZfiTV00rkTTnZ8qp1qqP2MW+vTsu5uJsyUK0GamrE9aP+GVUrQ+S+JqDASd5/4wIBjdrNE9puDF+F0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349750; c=relaxed/simple;
	bh=EhBWeBor7+3TLkCvfTysfZR/VPJ7nKtlH2rnA0Lob+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txLxuMMfMUcGhT809pDbgyWDTWhvAm7XhW4U1CcF9yUNH+DYcf6QPvpyQhtxFwfO1PYCbs9PiuW5D4jN3VC5aFFJbkUKxjJ9tyC2zquXKOvRqeFXpuh7cgLUJZCdkO7t0iqHFEpXls+nAo3XOjWBr16qe8AG5E+IVuhrUD9gCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrRfq9DY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrRfq9DY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BE01F000E9;
	Thu, 25 Jun 2026 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349749;
	bh=u8uJ8GHJ07pejXcy4KRwPpXgXLjWoU2SgIbTVNpVTno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DrRfq9DYyT2ITNIiPP1cG2dYEFGN5wFRdae2H8DC497cS/AvP46JuNtDLPySpl5uo
	 eZWnIID07v7aa693/lU2AjQGVwVunaKPvAHkk7nQ7ZCv9tMrHwmdyJFUYLm4GFDSLr
	 1CbrrC2pWXNQCuJQKIz8JqXarlyWIbJ6Hz0BrsqgkxSFBvfZeSGUC55lrUJwyAsUDc
	 Bfl9EaSIFBTu6Z+3wY78Wr3DSPberQcORbb5H6GaNI841acmdPpw4xJ+BbG2DzYAMl
	 H6ShURy4ZY00ueODPnixTnKYJcaVHq+IaezdKlr9JAaGPsezylFQd+JazXHCXHqNEm
	 qH4GKnOxPVaYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC03AAA0F5;
	Thu, 25 Jun 2026 01:08:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Fall back to standard MTU when PF reports
 adapter_mtu of 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234973748.3045401.8722834683122221137.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:08:57 +0000
References: <20260619055348.467224-1-ernis@linux.microsoft.com>
In-Reply-To: <20260619055348.467224-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, ssengar@linux.microsoft.com,
 jacob.e.keller@intel.com, horms@kernel.org, gargaditya@linux.microsoft.com,
 kees@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 22:53:38 -0700 you wrote:
> Commit d7709812e13d ("net: mana: hardening: Validate adapter_mtu from
> MANA_QUERY_DEV_CONFIG") rejected any adapter_mtu value smaller than
> ETH_MIN_MTU + ETH_HLEN, including 0, returning -EPROTO and failing
> mana_probe().
> 
> Some older PF firmware versions still in the field report
> adapter_mtu as 0 in the MANA_QUERY_DEV_CONFIG response. With the
> hardening check in place, the MANA VF driver now fails to load on
> those hosts, breaking networking entirely for guests.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0
    https://git.kernel.org/netdev/net/c/6bd81a5b4e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


