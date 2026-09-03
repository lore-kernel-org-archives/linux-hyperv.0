Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC823386C08;
	Thu,  3 Sep 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460513; cv=none; b=IZtAkBNcrKKoVCvVMdT2hMeqKqLCjc79yOnfL0YJm5Tfj8FugYuxYPSKbYoOC1d1aOeToR0prVkNLXwPDtjoLIO2BZftrVdSR1wTslNwmVdad8bP8BFh/YcM8eUXHXM9iqDLhmks8e9oreeN7LpeKpsVY9RznqG1Jf2OXrDxyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460513; c=relaxed/simple;
	bh=43mdiHaCmVw4lh5uZBuyYQddJtGrgUvSEQWty28tGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orxDSVnphPy6tYnxYczZIDWEYq9cBDywj8iY9TNj4N12CJq0esogEZS+SYGjTtRq+oIa6fllimqWfeY9pH5xNf339t2k2XDL3tCxBEcPmZ0JMDTavdp9vojZXm1mP0T5uP05iCoYmo5LKz7Gb65hznpTRVbdJxlp+nqLg2zpW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fe71vBMk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fe71vBMk"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id B677A20B7166;
	Thu,  3 Sep 2026 11:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B677A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788460464;
	bh=8/NZgxnUp6cEAd5Dos89q6NrUmWGEnITwiItP4wt7uE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fe71vBMk8tmzdqZgdwUCFTmyq1Dfcj8J1lp7nw5tTX8fk2fEpvt9kGzjlG3EBKfih
	 d9qumk8ylbVVvGJPCIYoK7/0B7AX8mKdvcgv2+3J2VDypPP28IDL3JsTShEt2lv9pT
	 7HgnsZHxnGLAw+VRovRQHEt7YarY3e15pw9yafYM=
Date: Thu, 3 Sep 2026 11:34:59 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, Alex Williamson
 <alex@shazbot.org>, hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
 wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
 namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, jacob.pan@linux.microsoft.com, Teddy Astie
 <teddy.astie@vates.tech>
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for
 VFIO to build upon
Message-ID: <20260903113459.00006639@linux.microsoft.com>
In-Reply-To: <20260903144236.GK4157646@nvidia.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
	<20260731223427.2554388-4-mrathor@linux.microsoft.com>
	<20260902111905.000079d4@linux.microsoft.com>
	<20260903144236.GK4157646@nvidia.com>
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

On Thu, 3 Sep 2026 11:42:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 02, 2026 at 11:19:05AM -0700, Jacob Pan wrote:
> 
> > If we do want to support this kvm-vfio bridge semantics beyond kvm,
> > maybe this should be abstracted as a generic VFIO "hypervisor
> > partition" association, with hypervisor-specific get/put callbacks,
> > rather than adding an MSHV-only copy of the KVM hook.
> > +Alex  
> 
> I don't like this patch at all.
> 
> I think we should try to harmonize all these sort of "external" cases
> as best we can. mshv, confidential compute, xen, etc all have a very
> similar shape.
> 
> I am discussing here with Aneesh an approach to use the viommu almost
> exclusively for this.
> 
> https://lore.kernel.org/all/20260902235609.GG2890729@ziepe.ca/
> 
> Can you imagine a way to do that for your stuff?
> 
> In that case I imagine the iommufd vdevice create is what attaches the
> vfio device to the partition, not a seperate ioctl over in some other
> driver. When the viommu is created it knows what partition it is
> affiliated with because it took in a FD that describes that partition.
Yes, viommu/vdevice model maps well in my POC/RFC(WIP) without new
ioctls.

vdevice is attached to the vm partition via viommu (holds vm_fd). i.e.
	struct iommu_vdevice_alloc alloc = {
		.size = sizeof(alloc),
		.viommu_id = viommu_id,
		.dev_id = dev_id,
		.virt_id = vm_device_id, //vmm assigned
	};
	int rc;

	rc = do_ioctl(iommufd, IOMMU_VDEVICE_ALLOC, &alloc,
		      "IOMMU_VDEVICE_ALLOC");

In our case, we don't need a vdevice_init op since all we need is the
virt_id, hyperv iommu driver will retrieved the vmm assigned logical
device ID (virt_id) by existing API:

static int hyperv_iommu_external_attach_dev(struct iommu_domain *domain,
					   struct device *dev,
					   struct iommu_domain *old)
{
	ret = iommufd_viommu_get_vdev_id(external_domain->viommu, dev,
					 &vdev_id);

Then use vdev_id for the hypercall to attach external domain.

I currently have a new IOMMU_VIOMMU_TYPE_MSHV with:

/**
 * struct iommu_viommu_mshv - Microsoft Hypervisor virtual IOMMU
 *                            (IOMMU_VIOMMU_TYPE_MSHV)
 * @vm_fd: MSHV partition file descriptor
 * @flags: Must be 0
 * @__reserved: Must be 0
 */
struct iommu_viommu_mshv {
	__s32 vm_fd;
	__u32 flags;
	__aligned_u64 __reserved;
};

That is MSHV-specific only because the fd validation and partition-ID
lookup are MSHV-specific today. I think this could be generalized later
into a common "external/hypervisor partition" vIOMMU type with
driver-specific fd validation/get/put semantics.

Thanks,

Jacob
