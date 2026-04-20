Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFE12F585;
	Mon, 20 Apr 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689120; cv=none; b=JuZmncB9PfXDan+O+4YVLescz1yk/YQcI8ncvj2vyUA7OHbuap65KkyAPHu97K/1jl4S9ZZh9nmirajZ75WbgPWmCMXOjJ/Hlj8+hKRtXLMWDUhMKsKJNB0UXxfPlvgLUSjo05nwQhisjdzNtNqqdOMho3vedH6K3rTCX6krkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689120; c=relaxed/simple;
	bh=8UXIXdh53adTO00GBOTE6XeRJRUI/UNXzkaHNp+9EAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOXKgtqaK3VR1s2pZFAon1c6DGBEqPAcrSQa7jxtuLFbk2mI2BIY8kVmN0exPsjPtTgVYsS/YUU9HCvkkJbPhHuR2gGEUb05ai2ro5O2iIB7hJoa866eI3ZEMi1JWEWqOnTHFHrK99rFLHEWgIiqOOluElBKjWVni3jGV/aMKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uod/RAxq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uod/RAxq"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0705A20B7128; Mon, 20 Apr 2026 05:45:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0705A20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689119;
	bh=yZ8gk9CH6j9JDtSoAjnvLHTLhA5RjWScx9Eyq5zdLi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uod/RAxqjy90m6cY5YNIHovekEKelzGunJ/OkJWFn8MoC6LADwLZSp96k7fKdWoQE
	 jNP5rbXe2a2b7NKBaszWols7Ro7ZEMez4fdFt8HgvXDggTLcpGZlPOQ3Wz2fGtARCZ
	 REKrl/pPV2nGrjr+fCTVmRdtST7fmqhkyTKDGDGQ=
Date: Mon, 20 Apr 2026 05:45:18 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: haiyangz@microsoft.com, davem@davemloft.net, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-kernel@vger.kernel.org,
	kuba@kernel.org, kotaranov@microsoft.com,
	stephen@networkplumber.org, andrew+netdev@lunn.ch,
	kys@microsoft.com, wei.liu@kernel.org, shirazsaleem@microsoft.com,
	kees@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	edumazet@google.com, decui@microsoft.com, leon@kernel.org,
	gargaditya@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	netdev@vger.kernel.org, shacharr@microsoft.com
Subject: Re: [PATCH net v3 4/5] net: mana: Don't overwrite port probe error
 with add_adev result
Message-ID: <aeYf3tL8YCRfDJ/Z@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260415080944.732901-5-ernis@linux.microsoft.com>
 <20260417141014.218936-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141014.218936-1-horms@kernel.org>

On Fri, Apr 17, 2026 at 03:10:14PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Don't overwrite port probe error with add_adev result
> 
> In mana_probe(), if mana_probe_port() fails for any port, the error
> is stored in 'err' and the loop breaks. However, the subsequent
> unconditional 'err = add_adev(gd, "eth")' overwrites this error.
> If add_adev() succeeds, mana_probe() returns success despite ports
> being left in a partially initialized state (ac->ports[i] == NULL).
> Only call add_adev() when there is no prior error, so the probe
> correctly fails and triggers mana_remove() cleanup.
> 
> > In mana_probe(), if mana_probe_port() fails for any port, the error
> > is stored in 'err' and the loop breaks. However, the subsequent
> > unconditional 'err = add_adev(gd, "eth")' overwrites this error.
> > If add_adev() succeeds, mana_probe() returns success despite ports
> > being left in a partially initialized state (ac->ports[i] == NULL).
> >
> > Only call add_adev() when there is no prior error, so the probe
> > correctly fails and triggers mana_remove() cleanup.
> >
> > Fixes: ced82fce77e9 ("net: mana: Probe rdma device in mana driver")
> 
> The existing Fixes: tag points to commit ced82fce77e9 ("net: mana: Probe
> rdma device in mana driver"), but was the bug actually introduced there?
> 
> Looking at the commit history, commit a69839d4327d ("net: mana: Add support
> for auxiliary device") added the unconditional 'err = add_adev(gd);' call
> that overwrites the error from mana_probe_port(). Commit ced82fce77e9 only
> modified the add_adev signature from add_adev(gd) to add_adev(gd, "eth")
> but did not introduce the buggy pattern.
> 
> Should the Fixes: tag be:
>     Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")

Thankyou for the correction, Simon.
I'll make this change in the next version.

- Vennela
