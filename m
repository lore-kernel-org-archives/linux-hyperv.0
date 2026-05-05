Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAC3A6B74;
	Tue,  5 May 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948269; cv=none; b=A68BUjyJJjnmp+/dXTWLwiDXjGN5CAAOhpjAPxOVga7NSnL0AnrM1OUceRxVgUj8WkE3SDTDagxhxftXzVmy/YmjBdgmAW5D8YvB8W7ON14xpEa9Mvt3TnsiV+ZOyfa28Ip9TsVqamjWndFsMK01SJcRgq24fI79zqjhh4e74+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948269; c=relaxed/simple;
	bh=Z6Gbevj3t94Bn8F2V+JHzP+LoO9va/htSsbzoxc88b8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3xtR1rX6otpGW9Xq4+JOQsJ82Nhq+0OgivWHtroxz2uuIpS+d21s52fz9DffqMNBgNpIh5xy/oe8DPLcRn5Vki6ss3cDpe/bf045PuJcah1/mW+32nWQP0j0fLAy89MexHNlDJKOSPp30BXzhsZut00c0uGyfTBeCEsqyZ5WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZkcg8/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZkcg8/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC7C2BCB8;
	Tue,  5 May 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948269;
	bh=Z6Gbevj3t94Bn8F2V+JHzP+LoO9va/htSsbzoxc88b8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZZkcg8/MDq4ggWvXVe5fWN39VF7E10+mkp6SqLE47HP4A7M/lxFUjcBEagN65C7xM
	 L0RIa6NrWQnkEkIJaPstQCErHi7pgHIj4RRE35hhfj/jIoRBDfsxXXDLmTSQyESbTh
	 OrmnTbP463LFLhG1eUYGRonjRGbGuihWvmVq+MXKbDHYMEARfnS6ChhQ/DdYrF6b6b
	 BDxD5ZRM8nt2uiaugL/+6TwfUFevrqyvv70kSjFvfK8Vqkiflhm+6Wh8QjB0FpUH4S
	 FYZ+X80BcnvEcS9N90/zu801SlFAqJcHf1Whmq9ew1u9Lm+u0AFInDEG3nGvwSf+7k
	 sDbpfIl9LZTAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCCB39301A2;
	Tue,  5 May 2026 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: hardening: Reject zero
 max_num_queues
 from GDMA_QUERY_MAX_RESOURCES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794822004.1394832.4803471358610574659.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:30:20 +0000
References: <20260430083627.1873757-1-ernis@linux.microsoft.com>
In-Reply-To: <20260430083627.1873757-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 01:36:21 -0700 you wrote:
> In a CVM environment, hardware responses cannot be trusted. The
> GDMA_QUERY_MAX_RESOURCES command returns resource limits used to
> determine the maximum number of queues.
> 
> In mana_gd_query_max_resources(), gc->max_num_queues is initialized
> from num_online_cpus() and successively clamped by the hardware-reported
> max_eq, max_cq, max_sq, max_rq, and num_msix_usable values. If any of
> these hardware values is zero, gc->max_num_queues becomes zero and the
> function returns success. This leads to a confusing failure later when
> alloc_etherdev_mq() is called with zero queues, returning NULL and
> producing a misleading -ENOMEM error.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: hardening: Reject zero max_num_queues from GDMA_QUERY_MAX_RESOURCES
    https://git.kernel.org/netdev/net-next/c/f7622e58e802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


