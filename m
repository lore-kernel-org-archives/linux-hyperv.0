Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABA3AB29C;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967852; cv=none; b=uHBs/eqHLIvxa8WONbBGshpLPi085n7squnfFu/0B+fDNAe3LVhPUFmNtqNxOZ2AFMIBZcP7YUu51yMDVrS9fprQZycUYbtO9UPtRa/IU6C9/yewYJY1hrnlx1RQcRPyAOkP5GvEKf6GGSgznbkKWiXbLtZQ1M5s4Y5yKp2neEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967852; c=relaxed/simple;
	bh=XhUlM6BGLQdoKRgV5m1mUgb5JD0UF9cyT+NL3ECG4Oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tzvsjmsvpLo9cVbL/571KAXvLdSdvtWAP2e6BatvKRgAf5n1uyO/U93+2hokSdjQs+X+M/YijwFZnR1kIWfPWA14H0Oroxvc2s+Hlhgp+sMVCwTcXo/dmOAxhu7LA8nLwwqEOc3DdTfmhgTpcBd7IT0UcISzZ3s8579uDSjFqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWn8teTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWn8teTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C7C2BCAF;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967852;
	bh=XhUlM6BGLQdoKRgV5m1mUgb5JD0UF9cyT+NL3ECG4Oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iWn8teTQ+jTCjBnpOqLhiQDAmQypPO5FjJCA4VfZg4BsNWahCnpppOoqze+vT9I0W
	 fxijmp0y1oXCHM2dgY7P4nlIbsYDe9/sXA7/GCsn9OjerNkH/Pa7PApJEudXSBR3Z+
	 BDLAzdWnDbjLh7I/JkQXRXGer5NNN6F5EAQwj0LAfy6KJpk+uStz0A8Hb7MuHIdust
	 wX0xn3JfMFDtceEjWbnmoqDnnl4RvmaChgCaBS9eEEUuu1KXO/XCp42ghCyHVuXVJl
	 H1/8oeTSBRkUWxN8H1GLEGl4ljnotAYQh7u3/W9qX1TSUgl5E0BkfodZevVar0UNnz
	 i1W/YnhMGlfvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D1E38111D6;
	Thu, 23 Apr 2026 18:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177696781354.700507.8576235951589562643.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:10:13 +0000
References: <20260423064811.1371749-1-decui@microsoft.com>
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 longli@microsoft.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 niuxuewei.nxw@antgroup.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 23:48:11 -0700 you wrote:
> Commit f63152958994 fixes a regression, however it fails to report an
> error for malformed/short packets -- normally we should never see such
> packets, but let's report an error for them just in case.
> 
> Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_sock: Return -EIO for malformed/short packets
    https://git.kernel.org/netdev/net/c/3d1f20727a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


