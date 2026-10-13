Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B47489FDD;
	Tue, 13 Oct 2026 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791868119; cv=none; b=PGxaZiihdQ8itFsNB80CtNTlvNW0a6spllZS352f6fs/WKQ50hqf9Mvii87HNiH5lxwILr3NdcDYCKrP+nJIcgyt6n6pUGFldgFq5nX8KYS5t6akcwLgPnSzMomONNZTHAVZYcRIg39weMBdzIFUFHhFap7F1n4ObJiTHz9mdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791868119; c=relaxed/simple;
	bh=quFYZL3Bg1C23rCThL1h0xIu3RFShF3qt7zvf+bLB3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLcL9YC8S51NEeG08aviJ/dRwVdzKAM3iPqVTH2k5N4j8+sqR0RrtOmi5gE6HkfsGuiZC3eFmv1x1A0UH2xpYjeBx3ijmPeJooHb344dgXW8pJScOi4QlauhozV/NMqoDsFsnt6f/AtaI80URCr9r8To6G8hbTDm3xt5fNOE8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q6MT9EAd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q6MT9EAd"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 9A46B20B7166; Mon, 12 Oct 2026 22:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A46B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791868114;
	bh=l+kJuSRZteE7cny6/fj0ftoe8qqZSdqYOhrIpJPavRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6MT9EAd8JMvUgU1C7xwgqjWhTCD7DbT5JN3F5tivVTv2XRZmHmBeabg7sbni3+D5
	 EYGKmMrF3DRIm4Al0pIlNqZ/peo8w4AJ140eirTstaNpLrmOQmYxhkTe9Lp7mJOgZN
	 h17+fP2CXQ87pg+MdgaI/DlnRh7AyHdEthwag1IY=
Date: Mon, 12 Oct 2026 22:08:34 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mary Hardy <maryhardy@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] tools: hv: remove unused rte_smp_mb()
Message-ID: <as280s8tzM+cmuB5@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261011223358.2327625-12-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011223358.2327625-12-sashal@kernel.org>

On Sun, Oct 11, 2026 at 06:33:40PM -0400, Sasha Levin wrote:
> rte_smp_mb() has never been used, and its "static inline __always_inline"
> declares inline twice, so clang warns:
> 
>   vmbus_bufring.c:61:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
>   vmbus_bufring.c:62:1: warning: unused function 'rte_smp_mb' [-Wunused-function]
> 
> Remove it.
> 
> Fixes: 45bab4d746510 ("tools: hv: Add vmbus_bufring")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/hv/vmbus_bufring.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
> index bac32c1109df8..23542e59a2ee9 100644
> --- a/tools/hv/vmbus_bufring.c
> +++ b/tools/hv/vmbus_bufring.c
> @@ -58,12 +58,6 @@ void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
>  	br->dsize = blen - sizeof(struct vmbus_bufring);
>  }
>  
> -static inline __always_inline void
> -rte_smp_mb(void)
> -{
> -	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
> -}
> -
>  static inline int
>  rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
>  {
> -- 
> 2.53.0

Acked-by: Saurabh Sengar <ssengar@linux.microsoft.com>
