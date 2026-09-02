Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F631409270;
	Wed,  2 Sep 2026 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340266; cv=none; b=ofnnj7OcuKlkZ4+fypJ5NsLeqvt44/I7A8p/oF9JMFQ8jk/8Ri2VRPZRGP6wTjZSepIM0qhgL54LojRQDnTRK+KLmRoQFn/hqjNqRulWEN5crjnP4AGf/jE/JfW97W3Rk/UkMIRLTeHiIG+Ys06f6ZvaJpsbjSB2fAMCnJh+B54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340266; c=relaxed/simple;
	bh=HKnpFDZpmWd43daQqAXOR/dJZnDNA5xtg7iuRcr3hkA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DRnLF2K18OVWR3Akom8RC5ygBF3D8pehRWT1LWofk6+WM1UlLn4ckofjP/xvLoby14EDHDdRG9bP+p2Mj04dYA4MjNC77jY9UYEK8IwrA44h5hP4U5aLd+cwkH/x2YuJQ1O2n5V6gxZxyA6vVB5NcwPqI/R3u5FAOLyGRh48zhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7fwRP9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7fwRP9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3BB1F000E9;
	Wed,  2 Sep 2026 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788340264;
	bh=vi+t1XuQPp0QQfSw0Pmppgp9Eec27Jzg5OE9cR5C3TU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n7fwRP9EUBlhjuZy1QP+513sh5R6BidHPRyC7gPOiHBKmBJEt8J3xb5MOGo5QO9KC
	 xt9Bhzy65M9an43ymAuSbJfpdzmFx5zahHofB7Mjzi49cu3SGJJfk7dtxNkQRayvmE
	 u+vcN/yx/RvKiNEtfqiCTvm7l3wX2buYBMrhpjsHFK/IQiLB7pVsrRvsc9UjugaJi6
	 y34pJPgvHX4g7uLQN1FmJbQddiRsppanRU7BIeZ8O449Kuxntb12EY6OALiFmE9lhZ
	 4DMBAIVKBM/sGRi9/5zNhwjm/8QWk/Qa9SKwn2OJYSd/fw072VtZA6lGdzBEr4aPoP
	 smMUBp0EDiG/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABA3926275;
	Wed,  2 Sep 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for
 CoCo
 VMs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178834020640.2165204.6609360204744972790.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 09:10:06 +0000
References: <20260828212325.2309515-1-decui@microsoft.com>
In-Reply-To: <20260828212325.2309515-1-decui@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Aug 2026 14:23:25 -0700 you wrote:
> This basically reverts the Feb 2021 change:
> commit 96854bbda24f ("hv_netvsc: Restrict configurations on isolated guests")
> 
> In Feb 2021, PCI device assignment for CoCo VMs on Hyper-V was not
> supported: if the host offered a PCI VF NIC device to the VM, the VM
> couldn't handle it properly, so the 2021 commit was made to tell the host
> "I'm unable to handle SR-IOV NICs, so please don't offer a VF to me".
> If the host offers a VF NIC to the VM anyway, the change to
> netvsc_receive_inband() ignores the VF NIC.
> 
> [...]

Here is the summary with links:
  - [net-next] hv_netvsc: Advertise the SR-IOV capability for CoCo VMs
    https://git.kernel.org/netdev/net-next/c/d0ec95a8a4e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


