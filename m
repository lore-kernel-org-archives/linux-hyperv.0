Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52574389445;
	Wed,  4 Feb 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188406; cv=none; b=ERJ2oI9CDbdpkBCarfrKB5+pxHArK+3+fSIUm4Wn5HsR9r+L9jodtIC0kCH7w3jzrW7KInKvdkQ64D64+HCZXlhc1khqd9EVg8gfg51qQFrV6fChPAAvqE1wZUfUs9JWy7BQcjoYvZ3h0/Q4gzLtaTrNJiNgyUw+CpikMFtXYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188406; c=relaxed/simple;
	bh=vGiY9GmwDbUBwaxFva7JqRb/m4TmWeO0zjuP80QOw50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yib63+nElJCcb2jNDkgjnHHOYSlV9QsDSHJnegLyHmsgfH4t9Hy1UI6kJStXci9r8fEbcj4b7pfs2lUZu63+H8n6Wu+lTNyYQYNRMCVEBpAfck8d4kja7qECfaTNGjqxmC+OkkNDNqXpFo5iqYYPitl1qXZ1s5xLE48JLM04BqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSonIUQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSonIUQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9B7C4CEF7;
	Wed,  4 Feb 2026 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188405;
	bh=vGiY9GmwDbUBwaxFva7JqRb/m4TmWeO0zjuP80QOw50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSonIUQJq52yRO4c+4uSXImCWazSVKsD0X3VkJOqGmUrOZ/0xeeIHenXhuHzIzZUy
	 LeRtroRpyc0X0y8FgM4SgzLIQtVLFVtz+nTCtLyYhSC0qZBrEkfUCGzmrT/ZpN9OP+
	 inmjJqXM3R54ADZkjzAukN5VGL1X9chCPnxzp5M+csXGvNBV4vsgIFcuckza+gShJj
	 c67Q27LTHn8HxLuv6GQCmSkAkQbxU/A/9jZ9oQXDfwXIecJTHKGPuyBgIKThFlzZ6/
	 EWmts2ZScKVCxqyqGBCcMCT4/oDitmRYxlGl6QDdg0uhgi1eL7ttl6EmPBUh312R5D
	 CMv57Cq6is1tQ==
Date: Wed, 4 Feb 2026 07:00:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Message-ID: <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>

On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
> with related guest support enabled:

So all it takes to reproduce this is to enabled PREEMPT_RT?

Asking because ...

>  	struct pt_regs *old_regs = set_irq_regs(regs);
> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	if (mshv_handler)
>  		mshv_handler();

... to err on the safe side we should probably do the same for
mshv_handler as well.

Note we don't support RT yet, but if issues are found we might as well
just fix them up.

How urgent do you want this patch to get applied?

Thanks,
Wei

>  
> -	if (vmbus_handler)
> -		vmbus_handler();
> +	if (vmbus_handler) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			vmbus_irqd_wake();
> +		else
> +			vmbus_handler();
> +	}
>  
>  	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
>  		apic_eoi();
> @@ -174,6 +216,10 @@ void hv_setup_mshv_handler(void (*handler)(void))
>  
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
> +		BUG_ON(smpboot_register_percpu_thread(&vmbus_irq_threads));
> +		vmbus_irq_initialized = true;
> +	}
>  	vmbus_handler = handler;
>  }
>  
> @@ -181,6 +227,8 @@ void hv_remove_vmbus_handler(void)
>  {
>  	/* We have no way to deallocate the interrupt gate */
>  	vmbus_handler = NULL;
> +	smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> +	vmbus_irq_initialized = false;
>  }
>  
>  /*
> -- 
> 2.51.0
