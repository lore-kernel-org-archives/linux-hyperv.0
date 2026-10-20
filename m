Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514310;
	b=UgxmryG7O1Co8JhzWhaRYaZrKyHkN+RiI1iBMIe4Ke8ylXToGW+eGo+DYBx8EMZd6DFU
	 CufCY19zlnYmIzV9z13TJakLEpF+dBj06Tgwy4khv3YghEolD8J7rEqzkKWRi1pe6FoND
	 SUsgO2YkQIJ8Mu0BWTdxKiNaoyHanO/v2NbVIqNsFRPgrtR3JVsFQCZsrZibB/j16xFsF
	 M0hC0hRDb2tQukdZdsbfBQ1OmLP2Ruy5SOKUn2GxSbKJyOBz+CBKCdGxpGFHgEXirDBqb
	 tdYnooCkJoTqX3IbX+OF4PFCfBRL3NhcfAC3txENSLgnfORbep7Fmv97XT3ciTP6qWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514310;
	h=Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Q5Xt0UyWQsUyZE4GjIfeTD7EOcY9CWq9fj7d2Ed+wQ4=;
	b=jxdUwnzV0mGPt+DYwczp3wlHEf3Wc+pI64m1Wj1cEViKdv486UIhGXtWxlxeWOEHQAPB
	 wfKYaF1KJ31SjYblyYdfAbgkKqU5BSWWdWDEDwP+15JD9o/ANAN+fiLTLk4oBnjkSpapd
	 97upKbN8zLBnwX9WhakE2z6pyz2VMgNUnjAK2s4zANnNh54nd2tJBE2cRThjLlx2b+03y
	 TieYCrkYPs/IrboE665K3sLX2KxcnWWkpKqlwD9ETmpE5fImwhMhtAo+nnjqwE2SKlosl
	 j2Y/BznXgbqGsLTi0FGHrXxStOtYRY5Aj7T5BOHDMaU1Qtd2QVZMkKZiScJ13B9PpRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30E606D508;
	Tue, 20 Oct 2026 16:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ACF1F000C4;
	Tue, 20 Oct 2026 16:38:29 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:37:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Lukas Wunner <lukas@wunner.de>, Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Message-ID: <20261020163758.GA2342476@bhelgaas>
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
In-Reply-To: <20261020161447.GN64621@unreal>

On Tue, Oct 20, 2026 at 07:14:47PM +0300, Leon Romanovsky wrote:
> On Tue, Oct 20, 2026 at 08:13:05AM -0700, Pavel Popov wrote:
> > Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> > upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> > VMware guests, passthrough devices appear directly on virtual root
> > buses without host bridge devices. In Hyper-V guests, each passthrough
> > device appears in a PCI domain of its own without a host bridge
> > device. Consequently, P2PDMA checks evaluate endpoint Device IDs
> > against the host bridge whitelist, causing P2PDMA requests to fail
> > regardless of host support.
> > 
> > This affects discrete devices such as GPUs, NICs and NVMe drives.
> > 
> > Add an explicit list of the Intel Xeon server generations from
> > Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
> > CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> > restrictions. AMD Zen and newer are already covered by
> > cpu_supports_p2pdma(), so only Intel entries are needed.
> > 
> > Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> > cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
> > 
> > Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> > ---
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
> > v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
> > v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com
> > 
> >  drivers/pci/p2pdma.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 9334eb314663..2650d605d87d 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -21,6 +21,11 @@
> >  #include <linux/seq_buf.h>
> >  #include <linux/xarray.h>
> >  
> > +#ifdef CONFIG_X86
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> > +#endif
> > +
> >  struct pci_p2pdma {
> >  	struct gen_pool *pool;
> >  	bool p2pmem_published;
> > @@ -519,6 +524,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
> >  	seq_buf_printf(buf, "%s;", pci_name(pdev));
> >  }
> >  
> > +#ifdef CONFIG_X86
> 
> Do we really need all these #ifdefs? I'm pretty sure they're not
> needed for the includes.

Apparently we do.  I experimentally removed them and cross-compiled
for arm64:

  drivers/pci/p2pdma.c:24:10: fatal error: asm/cpu_device_id.h: No such file or directory
     24 | #include <asm/cpu_device_id.h>
	|          ^~~~~~~~~~~~~~~~~~~~~

