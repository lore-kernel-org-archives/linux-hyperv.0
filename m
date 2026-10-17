Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87C3BB66B;
	Sat, 17 Oct 2026 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223307; cv=none; b=nzt/lFhRRIzwKyfR7p1zbx2OT7Z3U4YqYwTJQYUCHJWwMqg6uOGKgzbtfHmrE+GYgdVXbVa1ZXAfuBNXU58mPBtE20yPXWDqouPYnAKFg+kVPlFdxQ4AOGsqa40FKcileu+TTx45I/JI/1lUwj8sLhibZMq8D/u8zJWpr9jQE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223307; c=relaxed/simple;
	bh=LJ0L8lNXH+iKRyYZ0J+y5TKtnpyQoG4JfCwMuUNWYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcN0pi2DX+9ZD5Rjr9zMQ0DiW1g6teQ7XlVJo60153pqdnjkQJoJCLKdixYbB/NfZ81OF/fiz6GpJQkjzB0fHimK4h0EAJA3+ggm36ZU1uzQ/3Y4i63LfpdceRduIYSszkBZjzm20B2IttAG2huIoBN5Vo77NvIlbMZEKHo4NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSjVg3/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSjVg3/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C451F000C4;
	Sat, 17 Oct 2026 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223304;
	bh=INiyZA4QBulgrv+B43Bh/g4Z2yhYtj+aBp4s+wjME0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSjVg3/f2f2IEHckEWsa9j7DHSQukPCfT7RXxa/yYO0b0df1HJMWEmHTDMwVgMr+u
	 /6XSZLjbZC5h15RxWGPzfFrICilQQnRaYwSrS1RvJl3r19Ha8860qIcttrip7DPIdM
	 ezQVjpLZ3tPQnuT6iiaHLyovMIeTDyjCyXyNobOrZDCRJKIxGcFaSlbnyjJS2AStlC
	 8t9Zzg3k0lZrCgYmMXwjhiB5l+sUc0HlnUAD+lSo3KE+1KEPSrXwARiPFo1eNZXI7D
	 NQYcunCW90DQsgo1qEN+NR6LhoUlQTXdPu66ndYhy3s2Ntug5iQ8vbu6QzBqGo/ZKT
	 B7ReR+DgDeuZA==
Date: Sat, 17 Oct 2026 10:48:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Popov, Pavel E" <pavel.e.popov@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jim Chow <jim.chow@broadcom.com>,
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
Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
 Intel hosts
Message-ID: <20261017074820.GD219304@unreal>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
 <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>

On Sat, Oct 17, 2026 at 12:31:49AM +0000, Popov, Pavel E wrote:
> Logan,
> 
> > Why does this now need to be related to the hypervisor? Wouldn't it
> > make sense to do this check regardless of whether VMware is involved?
> 
> The whitelist decides per host bridge, and a global CPU check would
> override it on these CPUs, for example:
> 
> - It allows VMD domains, CXL 1.1 devices and other RCiEPs, which are
>   not whitelisted.
> - It overrides the emulated topology in KVM/QEMU guests, which already
>   decides P2P there.
> - It makes the existing QAT, DSA and IAA whitelist entries pointless,
>   since any RCiEP would be allowed.
> 
> Limiting it to the hypervisor keeps the whitelist logic unchanged on
> bare metal and in other guests.

Logan,

You can see how convoluted and illogical this discussion has become.

Initially, Pavel was told that P2P inside a VM is not working reliably
(to put it mildly). His response was that he wanted Intel to provide
the same poor experience that AMD currently provides. We agreed.

Now he points out that AMD's solution does not work well and proposes
keeping his hack, which will not work any better.

Moreover, it is unrealistic to expect users to run this software and VMware's
code only on machines certified by Broadcom. It shows complete
misunderstanding of users.

His claim that HMAT's future is unclear is also inaccurate. Half the work
had already been done: p2p ACS had been cleaned up and was waiting for
Bjorn to pick it up; an initial version of the HMAT specification had
been drafted and verified against the current kernel implementation;
and the community had been consulted and had endorsed the approach at
LPC. The remaining work is to update the specification, move it through
the code-first process, and implement it in QEMU.

The direction is clear, and developer time has been allocated. This will
happen.

Thanks

> 
> Thanks,
> Pavel
> 
> > -----Original Message-----
> > From: Logan Gunthorpe <logang@deltatee.com>
> > Sent: Friday, October 16, 2026 3:55 PM
> > To: Popov, Pavel E <pavel.e.popov@intel.com>; Bjorn Helgaas
> > <bhelgaas@google.com>
> > Cc: Jim Chow <jim.chow@broadcom.com>; Radu Rugina
> > <radu.rugina@broadcom.com>; Alexey Makhalov
> > <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>; Michael
> > Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>; Leon
> > Romanovsky <leonro@nvidia.com>; Nathan Ciobanu
> > <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests
> > on Intel hosts
> > 
> > 
> > 
> > On 2026-10-16 16:34, Pavel Popov wrote:
> > > +#ifdef CONFIG_X86
> > > +/* CPUs whose host bridges support p2pdma, see pci_p2pdma_whitelist[]
> > > +*/ static const struct x86_cpu_id hypervisor_p2pdma_cpu_ids[] = {
> > > +	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
> > > +	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
> > > +	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> > > +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
> > > +	{}
> > > +};
> > > +
> > > +static bool hypervisor_supports_p2pdma(void) {
> > > +	/* Hypervisor hides host topology, allow p2pdma on whitelisted CPUs
> > */
> > > +	if (hypervisor_is_type(X86_HYPER_VMWARE))
> > > +		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
> > > +
> > > +	return false;
> > > +}
> > One quick thought, after a very quick pass at this:
> > 
> > Why does this now need to be related to the hypervisor? Wouldn't it make
> > sense to do this check regardless of whether VMWare is involved?
> > 
> > Logan
