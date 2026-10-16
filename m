Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAC4BFE9E;
	Fri, 16 Oct 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164713; cv=none; b=KABo8M5MaO2y0+h61oiQH1FjTGyqnhvM6zSWOEdIeoMXwZ9DX+zNCDWSDNk2wa4PSLdMWRvkiBYMR3ZBQDMj9B+ZtlihdtNnw0ALQ27Egadq5vvBat2qkofBi7OAkVs8YDKCZieD9ZbCsZDdlBJWdWnb7GWBS3uvx90nERSA5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164713; c=relaxed/simple;
	bh=WIg4HHnEjUHVsNSP6Ww9skvAZqJEB3it+BKgjcJjFnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQgWvYZPt8Cz/y0XeLY2uWc891at9j3gF6Y0OuTdEDTUmyALviTV723ZyiLuPPwCbC3t05zG5R2LKZPJ8kh85A6SKbSJW337KMTFbuc4RP1TyF61imE33aINdt51kwX8gJbawe31HgiCU11z4QfG1OIi0xORLvcM3YxfTp2v54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAJMcmMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAJMcmMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA71F000C5;
	Fri, 16 Oct 2026 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164712;
	bh=O++lRaIEQRbUIBBM+fguL1DG4G6XujE0EDIskOJl7YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAJMcmMZB6D2PSQdNyM5K5a5nMW8gl6tEqgi1bPg+2E4Pc8MGPvf3QvuR/dbPAXIS
	 mfpsKDzu0446eQsVk6Gqbln9NU1ogluBiOkRLb/Cnh2om9xSJoQ3C7d9Y9sJKuak7t
	 A7UbaBFXB85c3uXYCTxTJaUNrfnRvsJY/YROoV10iKhcn6Z4iaCPIPglaVXF+JBz6c
	 XNnsrqhgHrz+/miK661jCnkQUJdp9uPFXtl1ghA1kxjD5+/rubJrLX38PuFwyGiL5w
	 9N/e4iYF6f/po9fzaFpkjzk+/v7C9H/8bKYseu0/Gfib7Pv/11lNGEdAfgbbyWpbHt
	 ZGHS/7994etIQ==
Date: Fri, 16 Oct 2026 18:31:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Popov, Pavel E" <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jim Chow <jim.chow@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Message-ID: <20261016153147.GC219304@unreal>
References: <20261009184923.GE11438@unreal>
 <LV2PR11MB60707DAD12BFBEAB681463B7B2922@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261011054700.GF11438@unreal>
 <LV2PR11MB60708F76EB7D6E5A40E82853B29F2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261012162410.GH219304@unreal>
 <DS7PR11MB6064DA61339B9AB0F52EBED4B29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261012182120.GJ219304@unreal>
 <DS7PR11MB60647FA80C6BE1029982222DB29F2@DS7PR11MB6064.namprd11.prod.outlook.com>
 <20261013122002.GN219304@unreal>
 <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR11MB60704D89055FBC471FF81B31B29B2@LV2PR11MB6070.namprd11.prod.outlook.com>

On Fri, Oct 16, 2026 at 02:55:07PM +0000, Popov, Pavel E wrote:
> Bjorn, Logan,
> 
> Could you consider taking this series despite the NAK, for two reasons:
> 
> - Parity: Linux gives AMD guests preferential treatment

This is misleading. You did not propose adding Intel processors to a whitelist,
for example in `cpu_supports_p2pdma()`. Instead, you explicitly added a check
for whether the system is running in a VM.

> - No alternative: the HMAT solution doesn't exist in Linux yet

This is not how open-source development works. Let's work together to find a
solution that works for everyone.

Thanks

> 
> Thanks,
> Pavel
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, October 13, 2026 5:20 AM
> > To: Popov, Pavel E <pavel.e.popov@intel.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; Jim Chow <jim.chow@broadcom.com>;
> > Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > <logang@deltatee.com>; Radu Rugina <radu.rugina@broadcom.com>; Alexey
> > Makhalov <alexey.makhalov@broadcom.com>; Wei Liu <wei.liu@kernel.org>;
> > Michael Kelley <mhklinux@outlook.com>; Lukas Wunner <lukas@wunner.de>;
> > Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > list@broadcom.com; virtualization@lists.linux.dev; linux-hyperv@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
> > guests on Intel hosts
> > 
> > On Mon, Oct 12, 2026 at 08:01:40PM +0000, Popov, Pavel E wrote:
> > > > Please read all of my responses. I was explicit about why the check
> > > > inside the guest VM produces random results. However, your responses
> > > > continue to focus on the guest, which is not the problem.
> > >
> > > Fair, my earlier replies were about the guest. Taking the host-side
> > > points in turn:
> > >
> > > 1. Host topology decides P2P, the guest cannot see it, and the patch
> > >    says "yes" for every pair regardless.
> > >
> > >    The topology is accounted for where the knowledge is: on the host.
> > >    Which devices land in one VM is decided by the admin, from devices
> > >    VMware has certified for passthrough in the Compatibility Guide,
> > >    and on vSphere 8+ by Device Groups, which hands devices sharing a
> > >    switch or interconnect to a VM as a topology-aware group. Hyper-V
> > >    has no equivalent grouping; DDA is plain passthrough, each device
> > >    assigned to the VM explicitly by the admin.
> > >
> > >    The blanket "yes" is not new either. On bare metal the flags = 0
> > >    whitelist entries say "yes" for any pair of Xeon Scalable root
> > >    buses, across sockets, with no knowledge of BIOS P2P settings. And
> > >    cpu_supports_p2pdma() already bypasses the host bridge check for
> > >    AMD Zen on CPUID alone, in guests included. This series gives Intel
> > >    hosts what the tree already does for AMD; if that is unacceptable
> > >    in principle, it is unacceptable for AMD guests today.
> > 
> > If you had simply added Intel CPUs to the list of supported P2P devices, I might
> > have been willing to accept that. However, you added these two lines:
> > 
> > +	    (hypervisor_is_type(X86_HYPER_VMWARE) ||
> > +	     hypervisor_is_type(X86_HYPER_MS_HYPERV)))
> > 
> > This makes your case quite different from AMD's. Their check was for hypervisor,
> > which leaked to VMs. And, yes, AMD does not work reliably in guest VMs either.
> > For our internal testing, we have carefully curated hypervisor configurations and
> > test VMs, along with custom patches, to test P2P reliably.
> > 
> > >
> > > 2. Regression: consumers that work today via a system-memory fallback
> > >    will take the P2P path and break on hosts that cannot route it.
> > >
> > >    A wrong "yes" fails safely: without host-side P2P the request is
> > >    stopped at the host IOMMU, nothing is corrupted, the same exposure
> > >    an AMD guest has today. An unconditional "no" is worse: it blocks
> > >    P2P on every host that does route it, and the guest's answer
> > >    changes nothing about whether the host routes it.
> > >
> > >    Xeon Scalable routes P2P between any two root ports, which the
> > >    whitelist already encodes. The only hypervisor-side requirement is
> > >    mapping the peer's MMIO into the VM's IOMMU domain, and that is
> > >    what passthrough P2P support means: on ESXi it was an explicit
> > >    per-VM setting for years and is the default since 9.0; Hyper-V does
> > >    it for devices assigned to the same VM, as tested on Windows Server
> > >    2025. The decision is made on the host; the guest only has to stop
> > >    vetoing it.
> > >
> > > 3. The hypervisor must describe it, HMAT is the way, NAK to anything
> > >    that does not fix the hypervisor first.
> > >
> > >    Agreed HMAT is the right source and should take precedence: consult
> > >    it first, this check only where no HMAT exists. The disagreement is
> > >    on "first". Guests on already shipped ESXi and Hyper-V releases
> > >    will never get HMAT, and those stay in production for years; the
> > >    cover letter's note on the adoption timeline was written with
> > >    VMware's input, and Jim can speak to it. Until a hypervisor emits
> > >    HMAT, this fallback is the only path that works.
> > 
> > This is VMware's problem, not the upstream kernel community's. If VMware
> > considers P2P important and its customers agree, VMware can upgrade.
> > 
> > It is no different from any other kernel feature.
> > 
> > Thanks
> > 
> > >
> > > Thanks,
> > > Pavel
> > >
> 
