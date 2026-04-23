Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4143E4C81;
	Thu, 23 Apr 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942051; cv=none; b=uvMlr3dVUt5v8tDM7to4icpKs5j/cNCBRGqpD2vpFnHn1eIYJfHoG2US4DRexnuA6NpTHm0r0u9yFtb/MH5eUxuY2y42KlV0+6SB6DNawJp7x48qh/h1QsXqSvbnUDDT7q23tB4sKTw/gBlX95opRZiGstvJ/Dl2pNnrhVy++nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942051; c=relaxed/simple;
	bh=CcVRpRrFwUfSfwAItnzPocv4aXz89Ri6TkNEF7/UYKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SqL1WMPT9dqYvVR/qQuYsTQfYop8IpSVkYqHQ/SWaW1I/nm+A0IqquzUz+UTph8IkHCTc0k/PQx+pl4IxWurRKyYoXZOic/reVIofTjzmTES+aFkXlXgkQdGzE1Sa+fO1iH0EaS2YSVRAuw1sWGhxNRL7k2VPaaXb8gBQD16owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2JpiwM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2JpiwM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B4C2BCAF;
	Thu, 23 Apr 2026 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942051;
	bh=CcVRpRrFwUfSfwAItnzPocv4aXz89Ri6TkNEF7/UYKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G2JpiwM1x5IfNRafQOcwTVhS7qaU+oehEbbx9gLqfPTQv5DgsunU6jvngmOTaGobX
	 QdKfhP3qaq+Hs/tYQgAJrd3iXYt2lAlKUOrtKjODRonTKupjsPxok0FMVa9mmhIbOi
	 H2lKA+CMphEvEFk8wOBobcSQ5c3MDyUIBUAnuy6bYLmqeRkHjl0lO1R50NgPeLgtYc
	 xxw0RHpDYiKdMBFxvGafvQEbMrf2roqk8xavhRvNshfIN2CMDTNcR7mpczguGu62nK
	 KDa0mVk/fBUGtha9dHdZrVXs61T+HkZOl1frH/xO2eYBWK6TqjAgl2wXx3xe8LzSG5
	 i0oh9B/i2ZZGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D30380CFFD;
	Thu, 23 Apr 2026 11:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/5] net: mana: Fix probe/remove error path bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694201279.110732.14645010674542588173.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 11:00:12 +0000
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 05:47:34 -0700 you wrote:
> Fix five bugs in mana_probe()/mana_remove() error handling that can
> cause warnings on uninitialized work structs, NULL pointer dereferences,
> masked errors, and resource leaks when early probe steps fail.
> 
> Patches 1-2 move work struct initialization (link_change_work and
> gf_stats_work) to before any error path that could trigger
> mana_remove(), preventing WARN_ON in __flush_work() or debug object
> warnings when sync cancellation runs on uninitialized work structs.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/5] net: mana: Init link_change_work before potential error paths in probe
    https://git.kernel.org/netdev/net/c/cb4a90744bcd
  - [net,v4,2/5] net: mana: Init gf_stats_work before potential error paths in probe
    https://git.kernel.org/netdev/net/c/6e8bc03349fe
  - [net,v4,3/5] net: mana: Guard mana_remove against double invocation
    https://git.kernel.org/netdev/net/c/50271d7ec951
  - [net,v4,4/5] net: mana: Don't overwrite port probe error with add_adev result
    https://git.kernel.org/netdev/net/c/a7fdaf069bd0
  - [net,v4,5/5] net: mana: Fix EQ leak in mana_remove on NULL port
    https://git.kernel.org/netdev/net/c/65267c9c4f28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


