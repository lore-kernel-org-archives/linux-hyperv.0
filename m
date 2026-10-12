Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282747A896;
	Mon, 12 Oct 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827500; cv=none; b=LYcoVuRQ8tnlmrlxntDTUoxexVH5KbGW0X8t3cGX4qGAA6m5UED+hgWrmQyh30UEpm4b8DuIEAJjdu9fuuUl1+oZ/q+gT9qDwK+3hUviglOKq8nNVvJpVaE7pcuTwL3JeotP10y0QJY5qMsEtfDtzzTTVDrISDf6HYZunXNxOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827500; c=relaxed/simple;
	bh=8EEBTF511ETJq4Mm9C2quPFvfKDHChn8bxjmp5fFzN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9/4V2CN4t2LIS9zeAyD9zMnFnOJrDidwa4NkCWmlSDulCHZvx97T1SxG/jNoHAkYjLXcOeLUc7wDKjvicVNygK3r4MbXV51hbIaEh61YO3yyoqvNnfUooStfcxSx3uMrEIFHyryQz7J2jqjlCglKGCZ1opMKc7zlhagWY6xiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fB5YgU/Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fB5YgU/Y"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 0F87F20B7166; Mon, 12 Oct 2026 10:51:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F87F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791827496;
	bh=pxy81f68wAn9b0dFCG+7MRKSJwe2CfB3+1h/k+wpJRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fB5YgU/Y1p1kCuW3/V8u2f4+qHDDKszWxISSF8lALOVg2y8+x34DczdjNYyRd00l4
	 y7RQI6WvMJ7Nkgq3JzKNrCLKCMg50Js8FWXxvdY7sVNMCCImlDzHDiB6J+rYCKvoMA
	 mC72qManyABYfvYS6VV7lruZ1npDiO6fvqm0/FHA=
Date: Mon, 12 Oct 2026 13:51:36 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
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
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] tools: hv: remove unused rte_smp_mb()
Message-ID: <as0eKHYtyIYSlfKP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

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
> 
