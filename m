Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D84D17AD;
	Mon, 12 Oct 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829286; cv=none; b=ML8Swq/hJMIDcLVlGMLQ6OxQM4de0UhaSa+6/tji6+UbYBbpfMMVI9RIAqJ6Mr1mf85HDBNy8uFtqciVza72Dv468OV5YYcZYxqVBE4tZAu//HJE4UUfJtUeCWvUNly6mUyx8vcHLwl21vatVOc7GIc3lPu+GwHh4pTk/hcj8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829286; c=relaxed/simple;
	bh=GokQC8PwSMPms7h9TUvMR7EX3GCXm6AF9xv3+ZiKNmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RozsrOIG9mLzWpPoudefoJnJSGhTHKGarUz9tuHBOOaa+29/UXTWPwrl6bYJIDg82MQ7AjPqabrNMnz49ViIDikz/7THm70xI1gP+ao/kQ0zXnzK9pZkMAoz3u72E5YHJgYRTHXogi5Mf0Rc3Jmm3SnmTY1jzDPIHfo2TmBtPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRcP+6YD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRcP+6YD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288491F0089B;
	Mon, 12 Oct 2026 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829284;
	bh=/aD7zxrJKQIFMiKB+gxigqy0JMoHWjODlkczBalS5sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FRcP+6YD3v/0s/Ilz1oTwJ9tasghp5Up4LVtAEi8Lue37ZeJebd0rC6wAlyQC88n/
	 sfPAU1nHDdNmqioY4cfB+OKDlPkO6HKNuWxzmQDA6FbZuUEd+cwdBlHH5d8wQWXIpc
	 y+aBKK6NSIzE1+9YUmNJAiMX42rT8/8GJrNRtak2AnYg6j9rYjuY0938MB0eczeqlx
	 eke9wjBNdJfV7BI1K87Uj7FARvcvxF9ItRd62DdK24FTDTCwgSZIc6VA+lqHvdwXPY
	 OyCXAZaIvfJY1zB39yZLvBZnO0mejec8Q5+Rbid/0pUwyYRKzNzQsXolM0vTGHRco8
	 c447J6S4WVWxg==
Date: Mon, 12 Oct 2026 21:21:20 +0300
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
Message-ID: <20261012182120.GJ219304@unreal>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas>
 <20261009180847.GD11438@unreal>
 <LV2PR11MB6070D3FCBC3EAED4FA0191EFB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>

On Mon, Oct 12, 2026 at 04:45:08PM +0000, Popov, Pavel E wrote:
> > I'm not following your reasoning here. In the cover letter, you say that
> > VMware reviewed your work. If VMware wants to provide P2P support to its
> > users, it can add the necessary support itself. As for Microsoft, there's
> > no need to worry; it can handle the ACPI changes just fine.
> 
> The cover letter sentence on this, "their adoption timeline in
> hypervisors remains uncertain", was written with VMware's input; Jim,
> Radu and Alexey are on CC and can speak for ESXi. But whatever VMware
> and Microsoft do in future releases, guests on already shipped ESXi and
> Hyper-V versions are not going to get HMAT, and those stay in production
> for years. On them, passthrough GPUs, NICs and NVMe drives have no P2PDMA
> at all without a kernel-side fallback.
> 
> > Of course not. P2P operation depends on the hypervisor topology, which
> > the proposed code does not account for.
> 
> The guest topology is what the code already evaluates, unchanged: the
> common upstream bridge walk and the ACS checks run first, and the new
> check is reached only after they fail, right where cpu_supports_p2pdma()
> already bypasses the host bridge lookup for AMD Zen. What the guest sees
> is a flat topology:
> 
> VMware, four GPUs:
> 
>   -+-[0000:00]-+-00.0  Intel 440BX/ZX/DX Host bridge
>    |           +-07.x  PIIX4 ISA/IDE/ACPI, VMCI, SVGA
>    +-[0000:02]-+-00.0  VMware PVSCSI
>    |           +-01.0  VMware VMXNET3
>    |           ...
>    \-[0000:03]-+-00.0  Intel GPU
>                +-01.0  Intel GPU
>                +-02.0  Intel GPU
>                \-03.0  Intel GPU
> 
> Hyper-V, four GPUs:
> 
>   -[2fc0:00]---00.0  Intel GPU
>   -[542b:00]---00.0  Intel GPU
>   -[5c71:00]---00.0  Intel GPU
>   -[9624:00]---00.0  Intel GPU
> 
> The passthrough devices sit directly on root buses with no host bridge
> device and no root ports; on Hyper-V each is alone in its own PCI
> domain. There is no upstream bridge to share, no ACS to evaluate, and
> the host bridge lookup lands on the endpoint itself. The topology
> carries no routing information, so the check falls back to the CPU model
> and hypervisor type. HMAT would provide what the topology cannot; when
> your HMAT-based detection lands it should be consulted first, so this
> check is never reached where HMAT exists.

Please read all of my responses. I was explicit about why the check inside
the guest VM produces random results. However, your responses continue
to focus on the guest, which is not the problem.

In the meantime, add:
Nacked-by: Leon Romanovsky <leon@kernel.org>

to any patches that do not fix the hypervisor first.

Thanks
