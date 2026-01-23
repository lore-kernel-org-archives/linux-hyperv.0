Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA721B9C1;
	Fri, 23 Jan 2026 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194826; cv=none; b=IFKkqXM4pbTTsyjcBIT4NXkK7+/hhGhkcQ04m3nZPsotS+yz+Nvka8tBkv9zWtvtYyq7Spyy+MMNr0W9oowzYUqEjilVudEWS0xlefjfp9bMG1P5ZhxP8Ie79/yX4PaDvwzU5OPkzqMm1o321G99ua+mVqkD8RZceymK1qZ3Yog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194826; c=relaxed/simple;
	bh=dNbnoajf/gBZc+p+PfQpAb1rVqmmyiRUsr7Dz6cjJuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xr+Pb0X3nY+5MLMy/f7g2++pfo1H7341KyTGOH9n5ZmisCtVjlfPPs+yIdLJm69Yxd5wutlN/G/o45uoS2HKepA5A42CpffLZMoL7rj/ioNKFU3bmRnZ9yBjEegwMg0wJG2f6NwZY8Rv9IH5NoDj92wykcXGIxLEokI2R8LhQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTfapnVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTfapnVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49AFC4CEF1;
	Fri, 23 Jan 2026 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194825;
	bh=dNbnoajf/gBZc+p+PfQpAb1rVqmmyiRUsr7Dz6cjJuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bTfapnVGJE0VCwydGcsW3hercYSBaXDW4DBhryt+CBBRVBOEygSXx+p5s4vz1o5jE
	 xiKFDMaJ0SLzR0o7JYJtpn3jV7i1MvWsQYwM3/CUxy21uiGL+moka+CKRT8lgRxqK2
	 gLezm06FbGCZCAonyx4vnPBsXbSHZ5zEiEWpWDPxVjRsQvkJWSw6x+14O7I+vwUbvs
	 wOW22mCYG76IZC4BeQf7GzwTKs+iQaNr06nyTFhyUsEdAWwcsjGLGF1/d2CE6rSCh+
	 qxeGOQ5nDIZKzwRw0bWh1Nhk0/TPuDjoV3qXDw7jQnz+//9FUziGgIfYcRzuVz/K6B
	 wqHMngQWzQ9qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8E7E3808200;
	Fri, 23 Jan 2026 19:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: convert drivers to
 .get_rx_ring_count
 (last part)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919482134.2680587.4373098453600260761.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:00:21 +0000
References: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
In-Reply-To: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 irusskikh@marvell.com, horms@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, alexanderduyck@fb.com, kernel-team@meta.com,
 ecree.xilinx@gmail.com, brett.creeley@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
 linux-hyperv@vger.kernel.org, linux-net-drivers@amd.com, sbhatta@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 10:40:12 -0800 you wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: benet: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/8f2a880d652e
  - [net-next,v2,2/9] net: atlantic: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/489a5b81abbc
  - [net-next,v2,3/9] net: nfp: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/46f4ad55605e
  - [net-next,v2,4/9] net: mana: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/3eb722571835
  - [net-next,v2,5/9] net: fbnic: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/ea28b02da84c
  - [net-next,v2,6/9] net: ionic: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/8bd5cee9891a
  - [net-next,v2,7/9] net: sfc: efx: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/67f16fba554f
  - [net-next,v2,8/9] net: sfc: siena: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/c9e4688b2ee2
  - [net-next,v2,9/9] net: sfc: falcon: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/f584347c1a2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


