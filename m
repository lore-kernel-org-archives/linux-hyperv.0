Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838591;
	b=RLkEbuz+Z8yMQtYMuUIMm22LjVs6hGZ+A5bU/iChebOc8OEY3DDPz0sGS0DBra4Q9zz/
	 p1Jsv0povYel//gcBtoU+OJRMLEOP3D6AHRtWrkKhIIhl3Lx8JMF1QfHSjusc+FiNSVJa
	 TRjVIvCTX8BWXP8ck+CX5PziKPRYrsBtPJzvjQ0/Fl/qCLVY+51ESiM85nqWE7AiBM1Xu
	 /1UjmbK/lxfRdkOx0kA1oGfCMz0MEfCpHeMl+Z5eGwD5UH9GoXuWf2NxtwwkPuuBsg2ZY
	 3IyzPR3QAKWnIGB/2mdG9LvpfR57cRq+jUuKM6LqtcAF8407oSLPx9afeND281EKKRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838591;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GyrXWUBurXBVkghpT0lN6xrSdGD8vTyPpGFF1Bmu73k=;
	b=nBFPP4XtkRW5QxDdZRvhBRHJCUe8NPPQ7Cow+ru0J4YUYMEIbglmFaqTrYreEaUAW9Um
	 NM9z/9dTRk4dM/6UnW2gwrTUfBSd/q3n4aVoHE1HDGujUDjMzlVES572CUKvmKAZPT2W5
	 zZOV6rKf86QLQE77pVtPCTBdBeERRAq2M7ppOkjBiNOYW31RVUC4vtWgIcA9ZVm8R+sII
	 79oGJKyFpCbLuv0OoKfntwcOA2YnDiZxb0R3kdVt3HdiyA4P9Qo/grImXzYzmVm/YpFBX
	 TWE9xrg8HCuI0ddn0McemefXYW3rN6ps+W5T1szHHDsYzqS25KQKe90+AtT4jiWEt8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzwY56os;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61623606A31C;
	Mon, 16 Nov 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzwY56os
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A57D1F000C4;
	Mon, 16 Nov 2026 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838591;
	bh=GyrXWUBurXBVkghpT0lN6xrSdGD8vTyPpGFF1Bmu73k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzwY56osqNz3hFKQVjEyO+poKaPnaHr+9P8CYhshWJByraGp3m/YMetcilC406+Uj
	 UtwjFNffucbjWXOzYBvs4DsbVKZP23crBxjVAFCd9EOdlnSPPxt1SHxEtyTwyDiHFA
	 1BG97MQ2r3h98KuqQCi44A5tF15/AkugF1lLlIIJ5op2LfoVbHP+mREGgPALKeol1d
	 khUM75P+YwDCFPGM3kR3VrekpU7nosGheFWjzADFTUee+uZkBWuMA6jc2ddav3L7+D
	 bu76Yi+5NPGpcrTwb/1XPmXIx/kmPTZnYZZJz+LcQgX0GO4jpmK3eWojsLxE1tSXAc
	 7/fraAGDjZ/XA==
Date: Mon, 16 Nov 2026 16:16:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261116141627.GQ11319@unreal>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-4-pavel.e.popov@intel.com>
 <avqhIQ2krd1qgp6K@infradead.org>
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
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>

On Sun, Nov 15, 2026 at 10:22:25PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */
> > +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {
> 
> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?
> 
> (and the fact that the CPU vendors still haven't managed to provide
> a firmware interface to expose the P2P capabilities is just insane)

I'm not a CPU vendor, but I'm working on it.
https://lore.kernel.org/linux-pci/20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com/
https://lpc.events/event/20/contributions/2508/

Thanks
