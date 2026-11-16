Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838788;
	b=lZholywKJ39tK0/fmEYb5tRU5HoPk4dzazq7WxRW1OvcnkhvVzSSD5zBiWNbHLs8WTbV
	 Addl2ROAArfDxos2FsHn8Bo9bZtS32gyd+nrOGkLTclvLlKIz3ooT0L2KUFDR/f46gRxI
	 xiInhP6tTEWKzhV/BmnZWVkoihXSXaekb3/Z2szoSLYKgzLwMDkT+s3t5KiZFhSuaNyZy
	 rFtDs5lgWVA1NsoRca8ItH+UjLlwdhqedDt7F9XI+dGDVGTD/YFr7s0DXfhexTWX3C0Sl
	 I8KxFktqQ6PdvbitdRUyeZ/v/oY5Ym7LsJ1u7hUXg0TNOmitYzUXFovFYGTs6upyOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838788;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KtO7Ht6jSpfSTlRd7xeD/Bac9rtM55oLiggt6Jv1YKw=;
	b=UEXKWPhJ/Pnp1VeVJp6S3ST3+kwXKzY1zWZP6wD0LO/UBFrjhMvgS96Mzlm0rd7CUORO
	 /XOP56FkphOSNgIlg53L2qt0wALsxwSmbHDqlr2sil9UQxmXCht10yZidT592SDeqvW6Y
	 8YM+AJulBlFsHqAIASLWcSGCKABZToCzIOPOvrl5aE9KvBua9I/v7leGcwn3sO1T7iUOa
	 ImkM5vzKjaZNxk4oiHLPEhkdsZudM2PY/78IKh+0RH2jOxMO1i5pPzvB5hbkon6QBJY01
	 Zc+bV4cwWfYkDLHOL0sHJ7z/S7aIySzcBW5z+Od57gawaSUrypuT2KSjfox6SjyJSAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIpAISeq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E660606A336;
	Mon, 16 Nov 2026 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIpAISeq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FF71F00926;
	Mon, 16 Nov 2026 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838787;
	bh=KtO7Ht6jSpfSTlRd7xeD/Bac9rtM55oLiggt6Jv1YKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bIpAISeqlviHKiMf061xdbJUrKqyYW0rUXfttF0N+nBmIz0okl1A/KisPJh+8/r2z
	 CC3Jag/o4IV8Ms1Qzy0OHarA2IzLXvhKvPMHVTc9FFwiSvPRRYtMTTqzEcToy9IVlU
	 exZh8rggxPsWCUp951e4YeVolyrmmg9Wee9Rx8X/ZO123DySYzuXw2fzDVFm4wDC8N
	 BkmDWkM8KnhyGiVqGFDCTGJ0wUxcxavwhJYZEw8rZHLiKC/rOsYMqv28y4fPMunbJ5
	 qk3Q2UBizg1RAT6o8n2b3aca2g+uV8ShHA/aPr+HVhbFrGnPUGzPfNijlqvMeO4Hdb
	 Bk+PDAauMfgZQ==
Date: Mon, 16 Nov 2026 16:19:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>, Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of
 cpu_supports_p2pdma()
Message-ID: <20261116141944.GS11319@unreal>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-3-pavel.e.popov@intel.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111234439.4098-3-pavel.e.popov@intel.com>

On Wed, Nov 11, 2026 at 04:44:38PM -0700, Pavel Popov wrote:
> cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
> function body. Put the whole function under #ifdef CONFIG_X86 instead,
> with a stub returning false for !CONFIG_X86.
> 
> No functional change.
> 
> Suggested-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
>  drivers/pci/p2pdma.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
