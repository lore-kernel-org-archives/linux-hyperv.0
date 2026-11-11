Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384662;
	b=ESKa1jjRpq+FwcRvwguYMaHb8Das1DuHPhD4CooiH9bCTlcerup+8TuZZyiXS0IWF2FX
	 pYiZ+jM8uj500QN1UlymYWsbYzIZOeBHU4EjkA6YcXNtI8I86WP3QHo2xep/jejEBcM4l
	 zxKbQE3S7bCVB1cw0AWwt1IVlV6TAGZJH36GBxnESAki8PB4bACRImSKLUDbavZJyrRSR
	 na+JTMFLrD/XBRrejxY0GlYE3dp9ZX9kQgqa9clcAi4aGXdpCnPdQ5Fg98U6SiGLLC7Ut
	 hldNwMsFgmu3dLT42i16AtEwGLThc5SKIuef0BNYLoIdVjE4MCcPJsr4GLVAU5xVbhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iOIeZv+xZF8BtnRxapOwV0sVr/Zsn6NcAiif3hZWdvQ=;
	b=AiU4y21+qYvnu29vpEIeBUFF4CgfBy9tqt1mz7LLtr/rRpaSDEemxEPa/z9TzSWM2SN3
	 NOhlq4LloaHBrC7A3Go43rIg4T3uapuRJfDrHz8AYMLsQ2CUmwTUOt7+OUVellnX2DOGw
	 sxoQB/6Ufk3MSn/d6rzpY782IaQhTzHJvkGI9tWlHpJg7d9bJlfquIEWo0oJyL0i+tr18
	 O9U4+bG8lhZI69C9C1iL4xUfYk+No4fdlzCzKwDteiJD/3BXc4NhW+tU2FYr5bTqR35/C
	 hpF5A1AKKuOGxWH4ThVk/wrEc2F6vZlU7iF15IuZ3c9yHMRxn0t2EyGiMh2VirdQHog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOB+0xhE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD4606A321;
	Wed, 11 Nov 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOB+0xhE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9574A1F00A06;
	Wed, 11 Nov 2026 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384662;
	bh=iOIeZv+xZF8BtnRxapOwV0sVr/Zsn6NcAiif3hZWdvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOB+0xhETQ3vZMIg0adLD9hp5Rtnl/fj7End7gKSDSsjSaVydYMn5xYLPTU7iZneR
	 vRnRQFGdvAvWnkZr0G08cmRHFKhyKXqJTQ5g5ZtxMPCrqY1WXiLoMWeuFMgDsjrEJD
	 KEq+b2/yTwyP6qOyEaBZzGbtW24w1nxNCWc4EN6DyxXnc/FfMbJvmjk9aB6Ck9Qy5b
	 kj6aMu6sybyBYUHrROe65d+AyNn7C5Ka458BaU85qKmdeSq/zr+FnjFuyJv3BZ5QUl
	 lViwhs+HcyXu3CLBoEzUga7BXuEQu50LaDi1LPHxtMakqhDv4D44yUH8Wy7F52BabB
	 i4jPIyOU6r0QQ==
Date: Wed, 11 Nov 2026 10:10:57 +0200
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
Message-ID: <20261111081057.GP8635@unreal>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
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
In-Reply-To: <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>

On Wed, Nov 11, 2026 at 03:48:07AM +0000, Popov, Pavel E wrote:
> Hi Bjorn,
> 
> Gentle ping on this series. Is this OK for v7.5?

I would say no. An Intel employee was asked to clean up an Intel-created
mess while upstreaming an Intel-specific patch.

Peer-to-peer is a general concept, and the code should reflect that. It is
reasonable to expect you to join the effort and help clean it up.

Thanks

> 
> Thanks,
> Pavel
> 
> > -----Original Message-----
> > From: Popov, Pavel E <pavel.e.popov@intel.com>
> > Sent: Tuesday, October 20, 2026 10:38 AM
> > To: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > <logang@deltatee.com>
> > Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Leon Romanovsky
> > <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > <jim.chow@broadcom.com>; Radu Rugina <radu.rugina@broadcom.com>;
> > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
> > CPUs
> > 
> > VMware and Hyper-V expose passthrough devices to guest VMs without an
> > explicit host bridge device. Consequently, host_bridge_whitelist() cannot
> > automatically identify the underlying host bridge structure, causing Peer-to-
> > Peer DMA (P2PDMA) requests to be rejected unless the device IDs are
> > explicitly listed in pci_p2pdma_whitelist[]. To enable P2PDMA on Intel hosts,
> > this series extends cpu_supports_p2pdma(), which so far covers AMD Zen and
> > newer, with an explicit list of Intel Xeon server generations.
> > 
> > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by carried over;
> > the Xeon list and the check are unchanged.
> > 
> > Changes in v4:
> > - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> >   (Logan Gunthorpe, Leon Romanovsky)
> > - Keep the #ifdef around the asm/ includes, as these headers exist
> >   only on x86 (Bjorn Helgaas)
> > 
> > Changes in v3:
> > - Drop the hypervisor check and move the Xeon list into
> >   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
> >   Gunthorpe and Leon Romanovsky [1]
> > - Fold the VMware and Hyper-V patches into one, as the check no longer
> >   depends on the hypervisor
> > 
> > Changes in v2:
> > - Replace the Skylake-and-newer threshold with an explicit list of Intel
> >   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
> >   Gunthorpe)
> > - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
> >   (Logan Gunthorpe)
> > - Rebased on current mainline
> > 
> > [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> > 
> > v3: https://lore.kernel.org/r/20261020151305.65218-1-
> > pavel.e.popov@intel.com
> > v2: https://lore.kernel.org/r/20261016223402.19991-1-
> > pavel.e.popov@intel.com
> > v1: https://lore.kernel.org/r/20261009154034.82321-1-
> > pavel.e.popov@intel.com
> > 
> > Pavel Popov (2):
> >   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> >   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
> > 
> >  drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > 
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > --
> > 2.53.0
> 
