Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A43A7F41;
	Tue, 18 Aug 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072712; cv=none; b=LO5YgJfc7G3R6gxHgd1ORfSpOk5LRvLwr5+9LpvKzczyEub/rWhA5oaYk+aHtBanZBD9UsylOGcbjOAtdz7gUyHxD8oQPREy/iuizIgJS18pX+H3nBLmnal7CB1fhQ8umIX+ejSFu6ID8K8zHXYCACRWorSmLlUPfkP/ydZTIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072712; c=relaxed/simple;
	bh=o8uqmtu2MsGYxO7vBcFjs/s2qplCdUuOZKJZo563EbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP7N1VzwUTUL4k2Ww1NrP2TPPj/F9Uw4qqWWTXoHfyT+7rSAplZZyjD+EZWDrAJHWRpf1fh8rGT8NVY4rY8nErBOFRe4Rcld6Gchtm7Dee2OVHSd0JS75oBWcPWANGEjHwYkrIr+mJYXfsX0i/vbTqt4ls0APndMabLc/sLB0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ITSpq1/9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ITSpq1/9"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id F23D620B7168;
	Tue, 18 Aug 2026 10:04:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F23D620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787072682;
	bh=NlBtSV70ulfjhBGAwgGGF0cxo2q372Ho76u9GQgfigo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITSpq1/9eGOUWdNd/mX+x45m42gThC9Q7AtlIbxSgXObZ8NwdctklwBic5gMdyLUR
	 SjY8zZfRxVOcEy1/loR6a74ir/A+oyqRMwmz5bkQ9UL8q85mUtam/J0k+wNFcamEYu
	 t7T++JNskhPLUNvwzPXzAoEaKqRkTDtGFUZ+eI8c=
Date: Wed, 19 Aug 2026 01:05:08 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, 
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Message-ID: <hl7buaatkeq526nyx3utwepujs7ai36biln6frzl4z7zlzk2y6@yukgkwjms7vt>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-3-zhangyu1@linux.microsoft.com>
 <BN7PR02MB4148C2319B12C57B1FA3885ED4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
 <uvvdhtxzqkwbb7ur4pybseocn3c4erk4gbis7yll4cvgusjzke@n2lbeyn532w2>
 <SN6PR02MB4157D48F243A3EA8C94C412ED4A72@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D48F243A3EA8C94C412ED4A72@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Aug 17, 2026 at 05:27:34PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, August 17, 2026 3:38 AM
> > 
> > On Fri, Aug 14, 2026 at 03:31:27PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11, 2026 8:50 AM
> > > >
> 
> [snip]
> 
> > > > +#ifdef CONFIG_HYPERV_PVIOMMU
> > >
> > > Making this code in hv_common.c conditional on HYPERV_PVIOMMU
> > > assumes that the only consumer is the pvIOMMU driver. But my
> > > understanding is that root partition code is also expected to be a
> > > consumer, and I would guess that code is independent of a guest
> > > pvIOMMU. So the #ifdef might need to become more complicated
> > > to also allow the root partition case. I'm thinking it makes sense to
> > > always build this code as part of hv_common.c. Even when building
> > > for a guest only with no root partition code, HYPERV_PVIOMMU
> > > defaults to HYPERV so the pvIOMMU driver will be built anytime
> > > Hyper-V code is included, unless someone goes out of their way to
> > > disable it. Getting rid of all the #ifdef'ery would make the code a bit
> > > cleaner, and I'm looking for an excuse to do so!
> > >
> > > I'd also note that CONFIG_HYPERV_PVIOMMU isn't defined
> > > until Patch 4 of this series. This patch will still build without the
> > > remaining patches, so bisect isn't broken, but it would be with
> > > the equivalent of CONFIG_HYPERV_PVIOMMU=n. It's a little bit
> > > weird to be using a CONFIG_* value before it is created, but maybe
> > > the ordering among the patches is complex and not easily sorted.
> > >
> > 
> > Thank you, Michael!
> > 
> > That makes sense. The trade-off is that a Hyper-V guest without
> > pvIOMMU support will still allocate and populate the registry for
> > its PCI buses. If that small overhead is acceptable, building it
> > unconditionally does make the design simpler. And we do not need
> > to worry about the chicken-and-egg problem when ordering this patch
> > and patch 4. :)
> 
> To me, the small overhead is acceptable. vPCI add/remove
> operations are relatively infrequent, and are not a "fast" path. So
> the overhead is of no real consequence.

Yes. Let's use rhashtable!

> 
> [snip]
> 
> > >
> > > The comment above is written as if the pvIOMMU driver is the only
> > > consumer, which isn't accurate assuming the root partition use case
> > > materializes as expected.  And that also means having "iommu" in the
> > > function name is overly specific. Same with the other function names
> > > with "iommu".  There's really nothing here that is specific to pvIOMMUs.
> > >
> > 
> > Agreed. Will update the comment.
> > 
> > For the function names, I would like to avoid using sth. like
> > hv_register_pci_bus() since that sounds like to register the
> > PCI bus itself. Two options I'm having in mind are:
> > 
> > 	hv_pci_busdata_register()
> > 	hv_pci_busdata_unregister()
> > 	hv_pci_busdata_lookup()
> > 
> > or some more descriptive yet legthy ones, e.g.,
> > 
> > 	hv_pci_bus_register_logical_dev_id_prefix()
> > 	hv_pci_bus_unregister_logical_dev_id_prefix()
> > 	hv_pci_bus_lookup_logical_dev_id_prefix()
> > 
> > Do you have a preference, or any suggestion?
> 
> Or maybe just hv_pci_register_dev_id()? To me, it's
> better to put the verb ("register") first followed by the
> object. "logical_dev_id_prefix" as the object is a bit
> too wordy for my preference.  Just "dev_id" or "busdata"
> is better, even if neither is fully precise.
> 

I would prefer hv_pci_register_dev_id(). "busdata" is kinda
vague and "logical_dev_id_prefix" is too wordy. :)

> [snip]
> 
> > 
> > > Separately, it seems like the existing calls from the Hyper-V vPCI driver should
> > > never duplicate an existing mapping. Your code disallows mapping a domain_nr
> > > to a different logical_dev_id_prefix, but silently allows entering a mapping
> > > that already exists as an exact match. I wonder if that really should be
> > > allowed, as it seems likely such would be followed later by twice removing
> > > the duplicate entry, with the second removal failing. Removing a non-existent
> > > entry is also silently allowed in the unregister function below, with the same
> > > question as to whether that should be allowed.
> > >
> > 
> > Actually, I don't think an exact duplicate registration is a valid case
> > either. So how about we use WARN_ONCE() and return -EEXIST when an entry
> > for the PCI domain is already registered(regardless it is a exact match
> > or not)?
> > 
> > And for unregister, how about we initialize the result to -ENOENT, do the
> > removal if lookup finds the entry, and WARN_ONCE if no entry is really
> > removed?
> 
> Works for me.
> 
> > 
> > > > +}
> > > > +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> > >
> > > This may be overly restrictive if the root partition use case code is in the
> > > mshv_root module.
> > >
> > 
> > Well, I'm not sure. IMHO, the register/unregister side is owned by
> > pci-hyperv, which creates and removes the Hyper-V PCI bus. The guest
> > pvIOMMU or the root driver are only cumsumers of the  lookup.
> > 
> > So maybe the register/unregister exports should remain restricted to
> > pci-hyperv, and if a future module needs the lookup helper, an export
> > can be added for the lookup helper by then (we do not need to export
> > lookup right now for pvIOMMU, which is built-in)?
> > 
> > Am I missing anything?
> 
> You are correct and didn't miss anything. I didn't fully think it through,
> so my comment is bogus. What you propose is fine.
> 

Glad to know that. Thanks!

B.R.
Yu
> Michael
> 
