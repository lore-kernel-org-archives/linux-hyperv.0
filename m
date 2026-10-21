Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568089;
	b=LH/wroxa0LcI0I7nUQfCsUgd2dvldH+PlPsJ8iUUTs6+kcztlfXCZkZPbzWPumeYCHU5
	 QAv5dYBCWUzQSmt6UEALePTQOIm0K+Rz2tVHvaswKBn67MtcdwER1ygEJKZCumSz416To
	 iem+uqqDxpfQMk3z2n4QFR4fPO0FCLH5tyTtJlWsOvhW+0Kvfo7rwsorxL28LTqGe158v
	 jwa2lCPbnGUoB1XRUPH98LS8/RN7cJ7L8aW652ZFQrw2rAVvwDxhXlwzjiyqzpGgHLdPO
	 OUi05C3igElGem6hhWn0qy8jCeTzYVcRxrDOlK0MD/8rJ5HP3M9W3mX6/ME6yyNSb7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568089;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KCEuU9iLhaE4xmX5lMVG6Z5ZsrQT6GkkcA7RpesUsxo=;
	b=Tg5fvW1Hml+s0x9fGwwNMm0V7d+N+PACyxuL8ejF6Uv9CQ2RvN/Ld5IyIywHQLoyMjdX
	 wKo95PJEG+hQz2ZsSUeWhzxUC4t1dcZPtWXWbumGw7unHOjKmbcb3ie3b2ya0LOyRw/9c
	 1/hf5/GtZcS4WKEsyjyZ0I2jNSfzMet5WOxZmSsl4HxPVvObucEWmnZ29//13oCpnuQGt
	 7w9dMKjiheSMJtgaLWQUW1yTif+EZmIQq1OdmZe4LP9/zykuZWDFuKfPjo/A+q14xoNHk
	 3od1CCsEyIcrBfx4QKfTIG7tkpvH8E7XsAOdiZA8FPqQ9KC5iHamJVR+ZWDJgVLhWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GnUy/kR8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388D606A319;
	Wed, 21 Oct 2026 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnUy/kR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956891F000C9;
	Wed, 21 Oct 2026 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792568089;
	bh=KCEuU9iLhaE4xmX5lMVG6Z5ZsrQT6GkkcA7RpesUsxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GnUy/kR8d+7/vJslSqrtUCJpNg00ZmGXVM0tsfSKoWe9FZis8yY/IfKrdSAMxjvXP
	 j9yl7Lzr59fsDimOlsqVcsTnDRd4fTZeRQt/Df/RLuO203SopNzgGRh0+aJYWUGQTg
	 WWMVj/yWTBqbKTdarAkVI1LZANSSf27mRISp0ElJAmF58JKRsPlGqkc53QkKhPshG/
	 24XRxxoc98+PHs0Zph/NadrKdxP44ZARzPpaZvS2uAh+ogkOXp8KAe1oV1tt2A59KJ
	 af5+IVRHr1n3Ze7XTgPrJ0Vhk9dx8SSZQF5BdMy6ezjgDDI6iKcaRItyfSSXE4Cq4D
	 wr4h9JBOLxPEQ==
Date: Wed, 21 Oct 2026 10:34:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Popov, Pavel E" <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Lukas Wunner <lukas@wunner.de>, Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261021073443.GP64621@unreal>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <20261020184002.GO64621@unreal>
 <LV2PR11MB6070E19D3A0CCA50943D7499B2672@LV2PR11MB6070.namprd11.prod.outlook.com>
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
In-Reply-To: <LV2PR11MB6070E19D3A0CCA50943D7499B2672@LV2PR11MB6070.namprd11.prod.outlook.com>

On Tue, Oct 20, 2026 at 07:37:32PM +0000, Popov, Pavel E wrote:
> Leon,
> 
> The #ifdef CONFIG_X86 in cpu_supports_p2pdma() came with the AMD check.

This is due to poking at `struct cpuinfo_x86`, which is not ideal but
understandable.

> 
> Would it work for you if I move the includes into that single #ifdef
> block, next to the CPU check? Some multi-arch code does the same:
> 
>   https://git.kernel.org/torvalds/c/c7be64355fcc (drivers/acpi/mipi-disco-img.c)
>   https://git.kernel.org/torvalds/c/7f3cfb7943d2 (drivers/cpufreq/cpufreq_ondemand.h)

Once the header files are properly exposed, clean up these other areas as well.

Thanks

> 
> Thanks,
> Pavel
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, October 20, 2026 11:40 AM
> > To: Popov, Pavel E <pavel.e.popov@intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > <logang@deltatee.com>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > <jim.chow@broadcom.com>; Radu Rugina <radu.rugina@broadcom.com>;
> > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> > server CPUs
> > 
> > On Tue, Oct 20, 2026 at 10:37:34AM -0700, Pavel Popov wrote:
> > > VMware and Hyper-V expose passthrough devices to guest VMs without an
> > > explicit host bridge device. Consequently, host_bridge_whitelist()
> > > cannot automatically identify the underlying host bridge structure,
> > > causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> > > device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> > > P2PDMA on Intel hosts, this series extends cpu_supports_p2pdma(),
> > > which so far covers AMD Zen and newer, with an explicit list of Intel
> > > Xeon server generations.
> > >
> > > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > > carried over; the Xeon list and the check are unchanged.
> > >
> > > Changes in v4:
> > > - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> > >   (Logan Gunthorpe, Leon Romanovsky)
> > > - Keep the #ifdef around the asm/ includes, as these headers exist
> > >   only on x86 (Bjorn Helgaas)
> > 
> > I'm confident that this is wrong usage of asm headers.
> > 
> > Thanks
