Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E6217F27;
	Sat,  5 Sep 2026 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788574266; cv=none; b=IxJuATf3aHfxI9iSxI6+ksWJSuHkrhwiUQpN/B+KaRxE1/n/t/R0AqjOLNe/wPdEX6NAUHLsFTZ7UQDwZGE0a3NzCmlB9cSoarcmi9mU8EDvZdLjW8NoBTZ7FGU25+xh4VA18gTQ7/dWjBODnF78F5YQfG0YHr74bj0A3Yuo8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788574266; c=relaxed/simple;
	bh=RpDpfDcp9e2N7tWTSH53Ljfy1goThv89Ia0svnAGPu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IsaxEdT2khrkgbO0kbq9KaECYchrV+WnjhTSv24iy06SVBLhcr2RSzLXGPZ37oBpBmvSU2we34bjx3yvl1op7dHR4LcR5TfjNW0WeE/k3hwhTaGYnI5mztRpJBFFjvKysM7iICShaXf3k0zV6Czn4ait1iahcFzwcJP0Hk0cj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx49yyKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx49yyKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428C1F00A3D;
	Sat,  5 Sep 2026 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788574265;
	bh=3/QYKxtEz+fZLJ1JHa20DrCN/s/sfIckDJB0xqq+BEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zx49yyKJo/ux4OD7Hqfv1h3lKxXW/ah88sKRhS5Dy/ks/Md9+pjuL7BGXXDaKVpQi
	 ciPwerrmLgF5ppmEZeAnU0RH3CMdxRgDVIdq8tSOA5KktOvYd6lG5SKQfGSRohwRLg
	 2aJ5D6y/nBquS0Pli+bQEw3QaBt3SPbY2GNAW6Pboltyn3M7Z9Xlj808zqT6KuBF9d
	 FcM8Pu0gtKzr+g/LXW7HQY+6o5KdUqffd9L4YPHB9zlbFFSNTjP4DGwtY8bllCwnpy
	 TzW8uDIb0EnTLYaWEVW0Oe9cx+7XGy/pxdtZp/vpi0Hb7J3I0qb6GHNTuAWib5jNEE
	 dUF9EixOuD/nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CF93924FC0;
	Sat,  5 Sep 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: netvsc: Remove stale "not yet supported"
 XDP_REDIRECT note
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857420564.1060508.17543646660124481544.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 02:10:05 +0000
References: <20260902193711.113291-1-chrismelnu@gmail.com>
In-Reply-To: <20260902193711.113291-1-chrismelnu@gmail.com>
To: Christian Melendez <chrismelnu@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 21:37:11 +0200 you wrote:
> netvsc_run_xdp() in drivers/net/hyperv/netvsc_bpf.c has handled
> XDP_REDIRECT since commit 1cb9d3b6185b ("hv_netvsc: Add support for
> XDP_REDIRECT"), and netvsc_drv.c advertises NETDEV_XDP_ACT_REDIRECT
> in xdp_features. Remove the stale note.
> 
> Link: https://patch.msgid.link/20260831200357.45390-1-chrismelnu@gmail.com
> Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
> 
> [...]

Here is the summary with links:
  - Documentation: netvsc: Remove stale "not yet supported" XDP_REDIRECT note
    https://git.kernel.org/netdev/net-next/c/9eab111e7657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


