Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BB51588F;
	Fri,  9 Oct 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571768; cv=none; b=FKHqtmRROuqeGbW7Fyc9BHtaLqIqdouAWOvD1lPmpVZKC7+8yPgSAUgOXlxqaq4jjOPCOsEwLtRV8f6l46osYs8HIPURmyz52JgJuiiCu5j0ixUvUREoMD69kMFW2wkKzNdCD2L+v7wE7Dh0zP3FpKwxWw0kdmyLSO3FeFcJuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571768; c=relaxed/simple;
	bh=uOY7u33qZImZWfII90Eh3x9t61Gwy2+XVoqcFMQeYDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLlLdw7zCunGnMys7TKST5ISnHZ+4/PQMnHDOFNkZ4LGdDs5KoqzIuQlQYFuWUBLeyci8lrUBKw9SKJ82qyRU5k2H5S5h4bu952eZAabWIGJ3PxtOgEg+2cOVqXGqtioStgKMLPPcleXY5ahkoUKeGlW6k6ctfaKOQ8A7sjWILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS2jN6UP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS2jN6UP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70A1F000FF;
	Fri,  9 Oct 2026 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791571767;
	bh=nI+4ZhJ3OabRWz0RuPm/3tIbNca4hC4lhUSNvlGkfWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HS2jN6UPPAIeptzf38HH1aHQooE+M0r9XVBnh9M2fzNJ1I2ff9fgFgql5ybytogPz
	 CPCVfdCgqtbK+fi0U9MpXZrvC2Zin79VW+aQ3cxa6Bj0jbFKyWXXG7kuGU3glYR3mw
	 l7f+HvPym5z7gjAl2DFc/UN2iZ0hxWa5TWDVYJ8XnRKfWSWEwARFx45qiKKQ6YN+sk
	 HYovVG/dHw9xEebLABQ7zHFEBctAYcCLfnQsVFU9n5S+bKk+xIvbI+91YS46Th+nYD
	 9dryDPyKvn5cVlpa5Q32Jofu6pbZonJxd0aOwnvM5CvI+p6wArb24Z9QVosGRDlno5
	 ZAOeR9Vd3Fuqw==
Date: Fri, 9 Oct 2026 21:49:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Popov, Pavel E" <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jim Chow <jim.chow@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Message-ID: <20261009184923.GE11438@unreal>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas>
 <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>

On Fri, Oct 09, 2026 at 06:21:49PM +0000, Popov, Pavel E wrote:
> > 1. Note where `hypervisor_supports_p2pdma()` is called: before
> >    `host_bridge_whitelist()`. This means the code ignores the hypervisor
> >    topology. The claim that the VM has a virtual bridge, causing
> >    `pci_p2pdma_whitelist()` to fail, describes exactly how P2P is expected
> >    to work today.
> 
> It does not ignore the topology. The check is reached only after the
> common-upstream-bridge walk and the ACS checks have failed, at the point
> where the host bridge allowlist is consulted.

Since the request comes from a VM, we always take the "skip" path,
regardless of the topology.

<...>

> 
> > 2. We are not developing an alternative solution. This is the right
> >    solution, and there is broad agreement that it is the only reliable
> >    way to enable P2P in VMs, for ALL emulation software stacks.
> 
> Agreed, and the cover letter says so. Our understanding is that HMAT
> becomes the primary source of P2PDMA information and the allowlist
> remains as a fallback; the hypervisor check is part of that fallback,
> not a competing path. When the HMAT lookup lands it takes precedence in
> the same decision path, and this check only matters where no HMAT is
> exposed. The adoption timeline of HMAT in hypervisors is uncertain, and
> guests on existing hypervisor releases will not get it at all, so the
> fallback is needed for both new and existing deployments.

I won't worry for hypervisors, they have enough brilliant developers to
take the upstream code to their codebase.

> 
> 
> > 3. This problem has existed and been known for at least the past eight
> >    years, since Logan upstreamed P2P support. The claim "we need it now
> >    and ASAP" is not valid at all.
> 
> The problem is old, the demand is not. Passing several accelerators
> through to one guest and expecting them to talk to each other is a
> recent requirement

This is not correct, at least for mlx5 devices. The need was already recognized
in 2020 in commit 90da7dc8206a ("RDMA/mlx5: Support dma-buf based userspace
memory region").

> and today P2PDMA does not work at all for
> passthrough devices in VMware or Hyper-V guests on Intel hosts. The
> series does not claim urgency beyond that: a working path exists now,
> HMAT does not yet, and the two do not conflict.
> 
> 
> > 4. The proposed hack does not solve the P2P-in-VM problem; it only makes it work
> >    in some random cases. An HMAT-based solution will still be needed, even on systems
> >    that use this hack.
> 
> It makes it work on Xeon Scalable hosts under VMware and Hyper-V, which
> is where passthrough accelerators are deployed today.

This is a very Intel-centric view. The vast majority of systems probably run on ARM
and use QEMU.

> Nothing more is claimed. I agree HMAT is still needed on top for latency, bandwidth and
> ordering attributes.
> 

The primary goal of HMAT is to eliminate the need for whitelists and to
simulate a P2P route for the VM that accounts for the hypervisor topology.
Latency and bandwidth are secondary considerations.

Thanks
