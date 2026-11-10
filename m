Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349808;
	b=aBs0l39+5VnJQamG43Zb6XyBy6jLr9tvL8oWQCtVPFKvIilTwQPl8Dihsa7l+RoPTtk7
	 +VAi/4sBsVnz1WU6VcsKDG0wfkmE3f+kofjz1YJ6rUXAojjTUnBOSRSeT7+xfweR652kv
	 r0Gyo42MENUWxcjGDjU5GtmJIdw2OY9AGchGeCDn2lMPMkRcRd56nmVN0M9BSMT+gmZm+
	 VaUe/ImrxUfXZHQSmPDwWEzL7Cd1v97On28CpWF+EbPnRT5WuSps04Jcs6x+sMx0KyhOt
	 kscAjJaSj0tZpT1/h/zxFU8WIDhSm2gc26GQT7RsXxvQSOKq3F+UVNm5g5zWDuXvbjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TQmL7gJJVDnf6A3aKnu179UsnBqP05f0Vw0xrhHXlVs=;
	b=xcdpgxFC4cqCSJygTHRDI1MN9ImcpUrarn5Du9vLTT1l+NDnkViOa5Hv6mrGb+xPeATb
	 p6+tZ/ZgU1NxtXOq+vojOzEf/TB6DFKp2PYRlnE2sPrEGZrAIeryhWY0scoJY+V02LsPB
	 t/XAYgyYM8NZgwcVLXRdEroHzuByJFCK0CyVpzMcc/7mPd285p/W5ISpjJIRq7pFUOowF
	 1LegQOhSijfYFbdNMHMxINcXaIO4sKVj4zVfo0O03NWgF7Mvi2OgKqxC/i/E4FZMQ9AkT
	 a85F1/TJDfhhn+X1L0wnFhXC6O9KnxPuHuV54B8/jubxTaLQFEr19M5we143tBv1zbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOFvkVat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D419606A33B;
	Tue, 10 Nov 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOFvkVat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9BE1F008A2;
	Tue, 10 Nov 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349808;
	bh=TQmL7gJJVDnf6A3aKnu179UsnBqP05f0Vw0xrhHXlVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UOFvkVatJh7uJAKpoARxS2NDCGtBPaJVyI8wOUg63qOv5ulqQoelLgEctluLmO+6Q
	 V60y3UeyvtG3QZc1wuGIECzjcH8ephq3RsaZJ1eDVDiWZkWjRhLS9FbdwopLd4x5O8
	 3+nSQVJexkQVoH/7ciTiqGduFHaK+CBByT0V1g65Qg9PiiAbuGpzOZgHa16uMvWzDU
	 lk1OHa8cMWRcK223t5n2wYcHNsJbsXB+yaz70s2//7/P/nr3YZoBDeSnGsfLTDWGha
	 nZnubx+iVpFmEz0I2h9wk2Ya0iUqtSDlZsZRsjh1VC1kGUjSvuVqb/Dqexl3Sf1l5D
	 f2g4+LjTcicLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E17339E8A40;
	Tue, 10 Nov 2026 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434980692.92301.5684137736887990228.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:30:06 +0000
References: <20261106123920.162131-1-parri.andrea@gmail.com>
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: sgarzare@redhat.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bobbyeshleman@meta.com, horms@kernel.org,
 leonardi@redhat.com, niuxuewei.nxw@antgroup.com,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 13:39:18 +0100 you wrote:
> The Hyper-V transport is assigned before the asynchronous VMBus channel
> offer completes.  Its zero-initialized hvsock therefore has a NULL chan
> until hvs_open_connection() associates the channel with the socket.
> 
> SIOCINQ can query the assigned transport while the socket is connecting,
> or after connect() fails once the transport has been assigned.  Unlike
> poll(), that path does not check stream_is_active() before calling the
> transport's stream_has_data callback.  hvs_stream_has_data() then passes
> the NULL channel to hvs_channel_readable_payload(), and any user in the
> guest can trigger an oops:
> 
> [...]

Here is the summary with links:
  - [net] hv_sock: Report no unread data before a channel is available
    https://git.kernel.org/netdev/net/c/71b06766b7c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


