Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D9372B57;
	Mon, 22 Jun 2026 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124870; cv=none; b=Qg8oxpADU1/IGlcOWlRb2RX4WhRNcF53tLWH7Un/grOFIWyn/5cuk+0XTi4DWrXQRHOT/sZNaawBg1WogkASLK8qmBHs07L4z5Vqp/9oeGHakccISnYp4P81wBqvambekGdeJ/nQoni9nlAlvufuCh7J5g3kPrR2QQGYFz2avrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124870; c=relaxed/simple;
	bh=H8kkjnVH2sr/aXhdi1kSRMYfYqNlcC9x5Bp4D4zn0YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkTJurmgy6bmrEcYX3OaGyIBntlN4Q4RG9O+Hp5297HQxSAH06R/0rpK+bY1Sf8NewMzCnYnXOviJa5601t7HKbpKTgavWIBF2jmuac1FQRGIU9kzgUMfwS/jBhZB7Gv0Qe3nQP6Zx1Dc7viNQCwaw1NLKxPCJyQ0JGB/yGxoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ294WN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ294WN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD331F000E9;
	Mon, 22 Jun 2026 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782124869;
	bh=DaIWgeqJoY7AB6Acb+TUrH2c1hf7Qtz2kCUERJI3vHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZ294WN1Sf0VVopfavVbVKjPvWMoZVA025jTnK/VJU3ZWXyo/GKqu/jmKkvxS+YFd
	 B4AeyWkEMSKniVe4Qu72FEl64FmHg80kogic/IE7+olw+1n+zBJuKDg9Q+GjWcrU6W
	 OkxI00IbazBLF/IXkFY/8zttcolhCNJ2E2II2Z3Q0Kn8zHRP6gF020JJGdGpxy3RZr
	 b7/HCVPnVwQYk3V2dBVxdzxLxqdZP7nGXG+IFN2WeNE0QHkACmnHOZHdgCwAWrjavx
	 HWnEIUvB4S/LK+GJFt1yVgn8tPU09WGhnldp/N3fhxTTviXWNiyg0Uo73x6LoFTyxk
	 WT6lpLNpsZAFw==
Date: Mon, 22 Jun 2026 11:41:03 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com, jacob.e.keller@intel.com,
	gargaditya@linux.microsoft.com, kees@kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Fall back to standard MTU when PF reports
 adapter_mtu of 0
Message-ID: <20260622104103.GA827683@horms.kernel.org>
References: <20260619055348.467224-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619055348.467224-1-ernis@linux.microsoft.com>

On Thu, Jun 18, 2026 at 10:53:38PM -0700, Erni Sri Satya Vennela wrote:
> Commit d7709812e13d ("net: mana: hardening: Validate adapter_mtu from
> MANA_QUERY_DEV_CONFIG") rejected any adapter_mtu value smaller than
> ETH_MIN_MTU + ETH_HLEN, including 0, returning -EPROTO and failing
> mana_probe().
> 
> Some older PF firmware versions still in the field report
> adapter_mtu as 0 in the MANA_QUERY_DEV_CONFIG response. With the
> hardening check in place, the MANA VF driver now fails to load on
> those hosts, breaking networking entirely for guests.
> 
> MANA hardware always supports the standard Ethernet MTU. Treat a
> reported adapter_mtu of 0 as "the PF did not advertise a value" and
> fall back to ETH_FRAME_LEN, the same value used for the pre-V2
> message version path. Only jumbo frames remain unavailable until
> the PF reports a valid MTU.
> 
> Other small-but-nonzero bogus values are still rejected, preserving
> the original protection against the unsigned-subtraction wrap that
> would otherwise let ndev->max_mtu underflow to a huge value.
> 
> Fixes: d7709812e13d ("net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I agree with your assessment that the issue flagged in the
AI-generated review of this patch on sashiko.dev can be
treated as a follow-up [1].

And I don't think the low priority issue flagged in the AI-generated
review on https://netdev-ai.bots.linux.dev/sashiko/ should impede progress
of this patch.

[1] https://lore.kernel.org/bpf/ajj+5mhswcqhI2z7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/

