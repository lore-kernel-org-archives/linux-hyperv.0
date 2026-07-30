Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4125B0A3;
	Thu, 30 Jul 2026 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373245; cv=none; b=Mw+K5DzF+TANTtoD1uLsJz5NsOINAo89s9nmtaLn0ZzdTDwzSshrUldJ/Wye1wfdbPmUddweDTjrPbEAlE+EuDdD9aR72g+lj6Xpag4unn4zZViUe2zMOkV3I15o7ek4gf9F9XLBTo36iPB50252BPHkjKpcaIzRUBXfrDcqT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373245; c=relaxed/simple;
	bh=JwaDcZ2hY8XUK7aURJIplurMp4ppcrhZ+ermUMw/0gk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GNdmw8VcHM/it9cSdwIiyrC/lfjfE6K8Qy0c1vKvAm8vWbITj8YCNkJadHAr7Wpxttuw4kO63lqcK0rq7ZmTc7ZCXvIuW1GBjWezfd7yYBCmj6dYYWN76/B9Z0oEzHjbxyjr5p19QsAIhlMcgMPg7VMyKhwAbS8/TFMFWM+5mH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDGg/tOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDGg/tOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2AE1F000E9;
	Thu, 30 Jul 2026 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373243;
	bh=FUovzDR6iEdwmW95JwjlHbuToRj9lk8EHETGPZirAaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aDGg/tOOQ9A8qtWzkqQ/cxcKCu3fN1BEo00GjZ7d+BOFd5VXR5DXN8ZnVlWH1qWhW
	 9Aiy/FDBAqd0+vVvYNp5X96yFOcuNX0EmR2OMOLGrw5fyZ2+GpvX3aOLkY33BdBaPY
	 Nm7iTyf8RpBLGmEDtBqQAysMG3LvQpm0teQKuwdwLpQNa4KGA6GD0u4VilxzneyNLG
	 pCA7/mymSss/T03ZIqeZh70s9ylTZ8zid/QXD6ckobtBtWfxl0X7c+gCSIMGRDLn43
	 +3heCzYGDKGQvrRHqhvVsSJEg8bL22RYdAFJJkSfGt2O5/3W6bgaCoejONRimxfiEn
	 Pg23pBM0+j2Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 926963926256;
	Thu, 30 Jul 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mana: Return error code from
 mana_create_rxq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537320718.3303028.7515326800235554458.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 01:00:07 +0000
References: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
In-Reply-To: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ernis@linux.microsoft.com, horms@kernel.org, dipayanroy@linux.microsoft.com,
 shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 gargaditya@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 04:37:59 -0700 you wrote:
> mana_create_rxq() returns a struct mana_rxq pointer and returns NULL on
> any failure. The caller, mana_add_rx_queues(), cannot tell what went
> wrong and hardcodes the error as -ENOMEM. As a result the actual failure
> reported by the lower layers (for example -EPROTO from a failed HW
> request) is masked and every RX queue creation failure looks like an
> out-of-memory error.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Return error code from mana_create_rxq()
    https://git.kernel.org/netdev/net/c/e67cc80b50f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


