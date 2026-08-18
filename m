Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2E11F94F;
	Tue, 18 Aug 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086883; cv=none; b=pogWvsaWO6XpdsEoFAIFhG67voQOXrSQjQOKCUmoD4mgJNEHJKQleZVvbrM5L4A1BSlMDkoWvGNcgX1TnpXCLrcNTsL9cAcWPIWn846aAQu9IvSWMhQQ8MZ0kw9x5JwVFLVLp9lqjbqw0vPL39nf8aMIFXOYTMZQ9AshiLVpALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086883; c=relaxed/simple;
	bh=5KDD5Bs5ub1c1YHeyHXq3iab6itF0MBeBY3ufSogHmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzxLluz2ze+PBCceG5eWpb5f+MTJ4xaptyxnODSbdYBZdjBIzp1F8a3I18RPJvcM1hpiDBzqGCnEIaoo25jZojDmIVBy1XZwzSjKZS7J0L50pAAkX9ir4oss5t4R24LCYn6lcSaXwRgA6puBts5BO02eZSUZR4G3cjZ2ZGqf1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tr0A2eYb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tr0A2eYb"
Received: from localhost (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id AD1E520B7168;
	Tue, 18 Aug 2026 14:00:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD1E520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787086853;
	bh=J26JPKJpfL6rGWib70cDSgUHxb/gQuvSozLEP6D4GnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tr0A2eYbdsemPtsuMtwJhBeNPCOPaTbvZDnDfUP1UPuwfUUzIFsTxSV0/w3vqWMD5
	 /33gluakZu/iVwg/AKGQXMNr3gKHTw2TrJeBXoRSgUGlqrRh/Tupt+LdTqbXsxQVIz
	 sw2WGN9K/d0HTDJ+Mpime240BRBI6/KY51N/6EGU=
Date: Tue, 18 Aug 2026 14:01:19 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
 robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com, Teddy Astie <teddy.astie@vates.tech>
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260818140119.0000507d@linux.microsoft.com>
In-Reply-To: <20260805124838.GP27883@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
	<20260731223427.2554388-8-mrathor@linux.microsoft.com>
	<20260805124838.GP27883@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 5 Aug 2026 09:48:38 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > +/*
> > + * If the current thread is a VMM thread, return the partition id
> > of the VM it
> > + * is managing, else return HV_PARTITION_ID_INVALID.
> > + */
> > +static u64 hv_get_current_partid(void)
> > +{  
> 
> No, you cannot transparently detect VMMs and link them like this. The
> VMM makes it self visible to the iommu driver via the viommu interface
> and you get a kvm FD to fish your partid out of. This is hackery not
> OK.
> 
> You should come with VMM support as a followup once you get a basic
> kernel-only iommu driver working.

Agreed with the plan, we should drop the current-thread based VMM
detection from this series and keep this driver focused on the
kernel-only IOMMU path, use part_id self for the time being.

I have been working on a prototype that is based on viommu/vdevice/hwpt
for "direct attach" model, aka "hypercalls to move the device into the
selected guest" in the discussions of the previous version of this
patch.

It is based on our previous discussions with Xen as well.
[1] https://lore.kernel.org/all/20260509170051.GD9285@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/20260519125206.GY7702@ziepe.ca/

The viommu object for direct attach should also cover the part_id
retrieval from the partition created by mshv or xen.

The rough flow looks like:
- vmm creates an iommufd ctx
- open cdev FD for the assigned device
- bind vfio cdev FD with iommufd
- vmm calls /dev/mshv or xen to create a partition, stores hv allocated
  part_id in its vm FD's file private data
- vmm creates a per vm viommu ojbect of direct attach unique type
- in this hv-iommu-root driver's .viommu_init, fish out the part_id
  from the vm file's private data then stores in hv-iommu's viommu
  struct.
The rest is for direct domain attach, roughly
- allocate a vdevice under the direct type viommu
- allocate a direct type hwpt (new)
- attach the direct hwpt to the cdev, where this driver can intercept
  in its direct domain callback (instead of abusing the paging domain
  attach).

With this flow, the VM identity is explicit through the vIOMMU UAPI
rather than inferred from current tgid.

One open naming question is whether "direct" is the right term for this
object type since it hints 1:1 mapping which it is not. It really is an
externally managed S2 domain/iopt, so "external" may describe the
semantics better, as Teddy called it in [1].

I plan to send out RFC in the next few weeks before LPC. Any
feedback highly appreciated.

+Teddy

Thanks,

Jacob
