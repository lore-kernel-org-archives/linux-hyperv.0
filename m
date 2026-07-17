Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AB39281B;
	Fri, 17 Jul 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295643; cv=none; b=HC/OMXo1unQ84UhiJ/gIK3aL5rUJnBIQ0rKWwil7wk1WjmoT7Pf6OW2gLuVhwo5XuPN5ncG4M6DRxGlwbKiJK8u1g6uXZh9GXvBsogBJh21+y1P4UuSh0yLVm06EHU6iIFma/EaJ0JQC+pxWD1CyQ41CWFzm5/W8qzWCss4Mag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295643; c=relaxed/simple;
	bh=qw913owOwee9juq7g5V9fR/kbC4QPRPGki76M0Zli3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C51/ByI2U40U40tUGCP93sGmBKe5uVLL36Dke01+BjVCXKJPJwLLi8NXxDgr9083iS0ILDQnRvDkvcAqm67P2tB68fCjf1aWooiUBQ58f7o5tX3jsbCEaanvt5COetR8532YVEQKXQfjxOHJrkPMrQLQS5PkxP+6L0BpgS44U3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKqBy27R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKqBy27R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D5A1F000E9;
	Fri, 17 Jul 2026 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295642;
	bh=lPWl/fcDZzQsiAjslA7JI02PnI5xdychDwv0+B16Nv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kKqBy27RptL6rriWWj0IygmUf5XjSNVMOq8/yMJjD4eApYSl21IITd/mCjyWYria1
	 VZHmYpwVMEYy8zsvNDsHHVADV/KFwUKQFqRon8wZN0fF7Uf9uYsqwoC06TxUvQLJ3I
	 U6nHHyh0HNRR07CVeuGlhot6yNyUBljmov1/nHkLZx7ykabXII15hwG2fVG+va/0SA
	 CdZdJxe/6q2nd0M4ccE84pLdbvfoGjBjgOMdRxdd00ip7wIhCJ23kbZAomZz9XvF3q
	 dm7EctBY+RmmV3U62RtTNDq5xokGn7F5XVLIC2HLyzX3nm8KvnJAfkcBZ0AM/RIgO+
	 rrx+WicLWOIfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F2380CEE7;
	Fri, 17 Jul 2026 13:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: mana: Add handler for sriov configure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178429561463.1724817.13808697155660997427.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 13:40:14 +0000
References: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
In-Reply-To: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org, paulros@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jul 2026 12:27:29 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add callback function for the pci_driver / sriov_configure.
> 
> It asks the NIC to provide certain number of VFs, or disable
> VFs if the request is zero.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: mana: Add handler for sriov configure
    https://git.kernel.org/netdev/net-next/c/ce6b4d3216b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


