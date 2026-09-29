Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D843AAF69;
	Tue, 29 Sep 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668496; cv=none; b=HSaB7+PJqagDA8McZubPZhdl3TW4tPF/vDSw3u00lnfO2TrtGTVBnp6twts4wJJqhEdjeFlQQpsNlbtal9OT4QwBRMIXgTcBZ9R2gi1b6vaCNlFwaBQEjFhCSBdp5FKi3+qM6f9mXx3GcioMNM8uVUnNjRn6aNZR2pr+WCq23I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668496; c=relaxed/simple;
	bh=BMIu3XzRkJm+A1W6ZZm3DtEJrTbu/WBqZDXJAhuao4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJiUFPAuE8GxvaIZZkdNr5NORA5t/yfa6ZGMnRBw9gweKEUCLTpCkLNhNSbIjYp4GK9Wl+S25KwdF48wxh75QnjTsBfQyFy9THU9RKgbMDORT2qmkQr7tUAxNBUH6eP21NrEyotA6WLjnAtabxrp5f6QPE+zvmj9E7mGGG6i6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmQLzw4r; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmQLzw4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zT6GlfQft/QJeAy0pckXvrIl9KIiBoLg2QYNryNymLU=; b=bmQLzw4rqkY4fV8qO1gp2+zRk4
	nhnwFpj7IgIbEV0UNBL0AOnauwbzBlCrL0ajhvhUVi+pNnh8SIZRzeefsOeh2Kr+NSn2B/sAIj7Vh
	Cx4AjbKvt+mRby1KlKqiNENB9NvJZhwvbf7gm1HC3bSiE/zr2kOf2x6WRKTNv+D2/KJS9G+aCQfJy
	toxyW81SwYmF7/bHp3ab0R0jpaRE1WptNnL1lIFsaUvgJvNpq1mWDNvoRc/z4pdNqCh2Tcmi+TgDy
	hVZUhCFgMIoSgF2tN4jnyl9609fBdFBT+W9F9gzKS5Fe2LmAP+mdiNLql6o3NqdHV3RMF1f+4q+yR
	ZPnsshtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBSfV-00000002Jcc-0zm7;
	Tue, 29 Sep 2026 07:54:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1E06300446; Tue, 29 Sep 2026 09:54:26 +0200 (CEST)
Date: Tue, 29 Sep 2026 09:54:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86
 encrypted guests
Message-ID: <20260929075426.GQ4120091@noisy.programming.kicks-ass.net>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929040256.543767-3-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929040256.543767-3-zack.rusin@broadcom.com>

On Tue, Sep 29, 2026 at 12:02:51AM -0400, Zack Rusin wrote:
> TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
> definition and placement, and provide page-aligned boundaries so the
> architecture can convert each CPU's whole section before registration.
> 
> Define the boundaries in the SMP template or UP data as appropriate.
> Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 12 ++++++++----
>  include/linux/percpu-defs.h       |  7 ++-----
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 64bc2bfdd2ec..145fcdbbe9db 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h

> @@ -1022,11 +1024,13 @@
>   * Note: We use a separate section so that only this section gets
>   * decrypted to avoid exposing more than we wish.
>   */
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
>  #define PERCPU_DECRYPTED_SECTION					\
>  	. = ALIGN(PAGE_SIZE);						\
> +	__start_percpu_decrypted = .;					\
>  	*(.data..percpu..decrypted)					\
> -	. = ALIGN(PAGE_SIZE);
> +	. = ALIGN(PAGE_SIZE);						\
> +	__end_percpu_decrypted = .;
>  #else
>  #define PERCPU_DECRYPTED_SECTION
>  #endif

So you're page aligning something that will get different protection and
will thus shatter large pages?

That is somewhat uncool. We like large pages, large pages are good.
