Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED63C3F66;
	Fri,  4 Sep 2026 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563479; cv=none; b=uIJgqPwZJQeJXO3RRDmAbRdMBXJzUPsc+Y6QcrmnUKL0LzYx5RzDF/wzrFpC7y3gsCuRekYnp/TIZLNA3CxIsfJdiZAFxC9Zq1fAe0y6r+orPjiSkUSmq9/dYtoiFMqAKdG5zmEiUsTcSGxMF8Lt4MJAOftkDYDatO1boCHpVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563479; c=relaxed/simple;
	bh=q7c9eEetwIU8InhZpon4FHGHJ8KERhVjgpu1MhkRTyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vcf1LIINmDTtdm+mq/ThKPbz0Idyt9B/uqj+envVPTAtZqCwy2QyAoAsgMOIiUQKKPzTXiDvORhdOde7O0DZRjynu3HA9yQrJy26iy2cB1absox5thvsAlyayM/Q2YcIlKNITAAG+TKr2D55GCKqaf3u6tAhuMykqnm9LAc6nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr4UIpe6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr4UIpe6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F05C1F00A3E;
	Fri,  4 Sep 2026 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563478;
	bh=wJR6Qjdpj6pk+n7oX4QF/fA4mJOpX3xcxCmNOh0xX5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nr4UIpe6zjP7WOfPcZB5LsldZyb2+S7sIL4JO8u0wZSjEzp6bSJdSOZxxW/+1Rne3
	 Id5C9X28Hd4fuZA2dzimSjlWZNn5l1j3fBAgRh/XJUczkxoV9ylN1XNWorE1BiJlCD
	 Nhc+JS86ZaUOdvioDDmBWz6td64P4DpwyT2XOx0XA2aPnvcyYh6taEldd/rOu9iiZU
	 Jxpje6tmxx3qQ6VDKaiGyvDBE2hhL3WdUULb77yLsmcc1TssGBQU0LPxjv7P6s+5dK
	 BszQFd+jbsBwDoqqjm1aN7wfBPp2MfG1lh0wFrLyx3HIrpD4QDRCk9WCnMlFu7kl0o
	 vTUPNQkjKGj3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E83924A7F;
	Fri,  4 Sep 2026 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: remove unreachable dead code in
 mana_bpf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856341864.1009860.8875923945579009526.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:10:18 +0000
References: 
 <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
In-Reply-To: 
 <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 hamzamahfooz@linux.microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 14:40:10 +0530 you wrote:
> mana_bpf() has a trailing 'return ret;' after a switch statement whose
> every case (XDP_SETUP_PROG and default) already returns unconditionally.
> The statement is therefore unreachable and 'ret' is never used.
> 
> Remove both. No functional change intended.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
> Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: remove unreachable dead code in mana_bpf()
    https://git.kernel.org/netdev/net-next/c/8d5f1bda7e8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


