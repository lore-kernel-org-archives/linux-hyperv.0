Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106B33B966;
	Sat,  5 Sep 2026 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573671; cv=none; b=Kpt/7XVgu5ySHt4EYQGcJ0yMD+/n6wb8zJ/r5rd/GgR5raoK4zksmlRVLwmaiQrRtMxIsRxF5upQIfoXZUCnv+K0+0yRb6FvX2q7Bl42vYhjJYZK33vPpWiB0H8ovMWw5SYhPqTnqz5F30mxVCcT6LZHB6axhqkeqCnf1LPjxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573671; c=relaxed/simple;
	bh=wLqG3+4hf6gipd7D4SldzcNMR1qrvoxj+hUY4+YGWls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gZWakEhA/GooJ8PsIyGM54g3S1HAw4vJ9dt6KZ5y/78qZXcKhSzVcB9LCby0aYBJ77rylJIhjirxAzi8zExSkmr9zTKhnU9b23wU7mBdFB1WmiDjyznHxNgRXLmSKf6YBZOomAKDR6mTTAGNfzjIRe50nv5/Yfn/9LtlDNcBGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAjIgZ7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAjIgZ7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC751F00A3D;
	Sat,  5 Sep 2026 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573665;
	bh=0+Rqhc3OUO5kop9xoqVUjhYJq13L2QmKLP8Iryp4pqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LAjIgZ7yQW9HgWT++xsIiv4OizdddNZ3rn25ZdduE5zQnBDWbrW+1V7z8WzMeYJQb
	 SNBLcmKbZxhem4enFGBwaC85R4TkIHX5u2D3vrvj1OAdaxrwRXXKZiOEHgKz3OUpAW
	 mgP9JqxUTRs5wmlYwDzJB7sCMBTlJn/zjPuBgzFmVkU2J7VotrJZ+jVh4bpet5FTMr
	 QUqzbvdaKiEnz/8IR7VkXxEsvWlONGZsCT/gCGi4ulPinLUNHqSiOFU7qGKXK/ES66
	 L8nHniC0pUE6BFQunF3vlcTs4j5pPvKx1H9hLo5tk4kdirkuel8k4VD0D/+CZp/a1G
	 c8WyhGgnz810g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198523924FC0;
	Sat,  5 Sep 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mana: Reserve extra CQ slot for the fence completion
 CQE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857360565.1058005.3571941040925332392.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 02:00:05 +0000
References: <20260901121837.3503240-1-sahilchandna@linux.microsoft.com>
In-Reply-To: <20260901121837.3503240-1-sahilchandna@linux.microsoft.com>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ernis@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 07:17:58 -0500 you wrote:
> The RX completion queue is sized to hold exactly one CQE per posted RX WQE.
> MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
> the packet CQEs. The current sizing reserves no extra slot for it and in
> rare cases, CQ has no guaranteed slot for the fence CQE when it is full of
> packet CQEs. This can lead to dropping the fence completion while the
> driver waits holding RTNL lock throughout the timeout duration.
> Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory()
> requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
> the reservation pushes cq_size past a power-of-two, so round up the CQ size
> in mana_create_rxq().
> 
> [...]

Here is the summary with links:
  - net: mana: Reserve extra CQ slot for the fence completion CQE
    https://git.kernel.org/netdev/net/c/80dd7e754b3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


