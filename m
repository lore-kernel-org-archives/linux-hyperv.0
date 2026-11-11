Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424188;
	b=Gw3ZmTBURt76F8PvkpweS+JqonrTUtVS7t0oweTnv0l6dAjXafsCkuA8ZPzPedyd9j+9
	 dZKNRTXewmuULBF0ZppCd+t8P2bsAUBtwHEHuLgpMLuPoTYdO+UaqxvLLSvAffr/EB1K/
	 hZUscPII6oMEhOlZtEsULe06EFgD/ULXgyjyVgCJVf/rsh6Y9pfIEGXrWyl/XQxeywntS
	 bwDlQj79Qql+/v/12s7DrU5agLBnn4ZHFMjpGang2TKpObmW3GqNdtPIKrqDdYfKyoNnw
	 kCXbFldVQs3eVyq8e8EAVrQYm++hth99qsBtCGt4TGjJKsI2oaXefFjCHtzOapfUYRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424188;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9nXz4XsFyxf6p/xbkIeQCjsAjClLO9LnUnA+aL97b8k=;
	b=GeQPvfCVVQftNZifYkVVlyNaDTga95F9K2IuxtjcPuvR1hRSixLybwKqmx5gMLKzMGL7
	 rp1m2iqsdbtCV1TekH4w/rgB9gRbEGfqR+pQcewnT5WAwxdsOGwTU0Ux9aJ6Y9JowFqEz
	 144JKh4/F2z/7fLyzh8N93IRsapeVV3ySgeLZbuU2Er9yM80CqrzapjrPQ8Ro3n6greRk
	 SOh2/aVWGAG8fkbvkseGElSrXsecolGhbUY3DazwXxUysjw4P/0R3HQCjwRjg/UQyJHhT
	 W1Y8MHpqZeBLUKxZhXf+QLhU9e4Il3EmFChrEhZ+vJpr9JkjMFsztqfBDLJpCI+S+gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFzKR564;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE7606A339;
	Wed, 11 Nov 2026 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFzKR564
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EBD1F00A06;
	Wed, 11 Nov 2026 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424187;
	bh=9nXz4XsFyxf6p/xbkIeQCjsAjClLO9LnUnA+aL97b8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFzKR564G0UiQUdYOgmFp64Zc7kQghLq8rSQs9/kVQoM9daXgTwgHOIJBA4tmvZrP
	 pl6NoDuycNPmuZKQC+tzUKJ2vWwXQC8zrvj43OVZP4oWYZL0WyxpI2BufbHbJlKfq4
	 bRR+95WaVEV3bPIzkVBgR7D0CKAjDBkeQVBHCeXQOgYJMybl3r3qHb/DPBqfzrvX05
	 H0X7U6M4JViBLSxAaSrZ1etmocb0hrvAPh0WYJUIMVJu6D4nAtCFOLHOKh5QBJk04L
	 R3LUfJh51xF61ypZxQbgdKSrvD7fx1TIlT+f7bxfa8TknOwtlBSn1q/knjPjUE/X5U
	 d6pzS9gcNa1iQ==
Date: Wed, 11 Nov 2026 21:09:42 +0200
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
Message-ID: <20261111190942.GT8635@unreal>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <LV2PR11MB6070064A9E674EBDFB1A3B20B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261111081057.GP8635@unreal>
 <LV2PR11MB6070A8BA690DEA91D6675682B2712@LV2PR11MB6070.namprd11.prod.outlook.com>
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
In-Reply-To: <LV2PR11MB6070A8BA690DEA91D6675682B2712@LV2PR11MB6070.namprd11.prod.outlook.com>

On Wed, Nov 11, 2026 at 03:37:13PM +0000, Popov, Pavel E wrote:
> On Wed, Nov 11, 2026 at 10:10:57AM +0200, Leon Romanovsky wrote:
> > Peer-to-peer is a general concept, and the code should reflect that. It is
> > reasonable to expect you to join the effort and help clean it up.
> 
> I'm in. My proposal is to do it after this series, since this one
> unblocks P2PDMA in guests and the cleanup is out of PCI scope: even
> the minimal fix for p2pdma.c alone means changes under arch/x86, so it
> would no longer be a P2PDMA patch but an x86 header series with its
> own maintainers and review. That x86 header series is also the right
> place to drop the same guard from six other files, and I'm ready to
> do it:

If you are ready, why hasn't it been done until now?

The claims of urgency are hard to take seriously: `SKYLAKE_X` was added to
`arch/x86/include/asm/intel-family.h` in 2016, and now, ten years later,
you are asking us to "do it urgently." I strongly suspect that if I don't
bring up P2P at LPC, we won't see this patch for another ten years.

Even now, despite being asked to clean this up before the merge
window, you still haven't done so. Trust is built by following
through, not by making promises.

> 
>   drivers/acpi/mipi-disco-img.c
>   drivers/cpufreq/cpufreq_ondemand.h
>   drivers/gpu/drm/i915/intel_cpu_info.c
>   drivers/char/tpm/tpm.h
>   drivers/crypto/ccp/ccp-dev.c
>   include/linux/platform_data/x86/soc.h
> 
> Bjorn, is v4 OK for v7.5 as is? The x86 header series will follow on
> top.

I disagree. You can't build this on top, as it would need to go through
different trees and would likely cause merge conflicts. The cleanup series
would have to touch the same lines in the PCI subsystem that you are
changing now.

The only sane approach is to do the cleanup first and then build the p2p
changes on top of it.

Thanks

> 
> Thanks,
> Pavel
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Wednesday, November 11, 2026 1:11 AM
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
> > On Wed, Nov 11, 2026 at 03:48:07AM +0000, Popov, Pavel E wrote:
> > > Hi Bjorn,
> > >
> > > Gentle ping on this series. Is this OK for v7.5?
> > 
> > I would say no. An Intel employee was asked to clean up an Intel-created mess
> > while upstreaming an Intel-specific patch.
> > 
> > Peer-to-peer is a general concept, and the code should reflect that. It is
> > reasonable to expect you to join the effort and help clean it up.
> > 
> > Thanks
> > 
> > >
> > > Thanks,
> > > Pavel
> > >
> > > > -----Original Message-----
> > > > From: Popov, Pavel E <pavel.e.popov@intel.com>
> > > > Sent: Tuesday, October 20, 2026 10:38 AM
> > > > To: Bjorn Helgaas <bhelgaas@google.com>; Logan Gunthorpe
> > > > <logang@deltatee.com>
> > > > Cc: Popov, Pavel E <pavel.e.popov@intel.com>; Leon Romanovsky
> > > > <leon@kernel.org>; Lukas Wunner <lukas@wunner.de>; Jim Chow
> > > > <jim.chow@broadcom.com>; Radu Rugina
> > <radu.rugina@broadcom.com>;
> > > > Alexey Makhalov <alexey.makhalov@broadcom.com>; Wei Liu
> > > > <wei.liu@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Nathan
> > > > Ciobanu <nathan.d.ciobanu@linux.intel.com>; bcm-kernel-feedback-
> > > > list@broadcom.com; virtualization@lists.linux.dev; linux-
> > > > hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon
> > > > server CPUs
> > > >
> > > > VMware and Hyper-V expose passthrough devices to guest VMs without
> > > > an explicit host bridge device. Consequently,
> > > > host_bridge_whitelist() cannot automatically identify the underlying
> > > > host bridge structure, causing Peer-to- Peer DMA (P2PDMA) requests
> > > > to be rejected unless the device IDs are explicitly listed in
> > > > pci_p2pdma_whitelist[]. To enable P2PDMA on Intel hosts, this series
> > > > extends cpu_supports_p2pdma(), which so far covers AMD Zen and
> > newer, with an explicit list of Intel Xeon server generations.
> > > >
> > > > Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
> > > > Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by
> > > > carried over; the Xeon list and the check are unchanged.
> > > >
> > > > Changes in v4:
> > > > - Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> > > >   (Logan Gunthorpe, Leon Romanovsky)
> > > > - Keep the #ifdef around the asm/ includes, as these headers exist
> > > >   only on x86 (Bjorn Helgaas)
> > > >
> > > > Changes in v3:
> > > > - Drop the hypervisor check and move the Xeon list into
> > > >   cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
> > > >   Gunthorpe and Leon Romanovsky [1]
> > > > - Fold the VMware and Hyper-V patches into one, as the check no longer
> > > >   depends on the hypervisor
> > > >
> > > > Changes in v2:
> > > > - Replace the Skylake-and-newer threshold with an explicit list of Intel
> > > >   Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
> > > >   Gunthorpe)
> > > > - Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
> > > >   (Logan Gunthorpe)
> > > > - Rebased on current mainline
> > > >
> > > > [1] https://lore.kernel.org/r/20261016153147.GC219304@unreal
> > > >
> > > > v3: https://lore.kernel.org/r/20261020151305.65218-1-
> > > > pavel.e.popov@intel.com
> > > > v2: https://lore.kernel.org/r/20261016223402.19991-1-
> > > > pavel.e.popov@intel.com
> > > > v1: https://lore.kernel.org/r/20261009154034.82321-1-
> > > > pavel.e.popov@intel.com
> > > >
> > > > Pavel Popov (2):
> > > >   PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
> > > >   PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
> > > >
> > > >  drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
> > > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > > >
> > > >
> > > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > > --
> > > > 2.53.0
> > >
> 
