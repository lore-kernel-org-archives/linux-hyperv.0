Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D962EEE7E;
	Tue, 18 Aug 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096376; cv=none; b=cfspwuFWldk11eD1WD2jlWo6m2deZMQ7bW4W+14T99CWA51PCBs7Zlc8H/07EHe+/3Sx3Y58W24VAEXRBbFWoZI4LMg4noJX1iycMQiha0wy4yiAKJ/kWE0aCJcaQ6BAiXGxB8v/uqIbI/zHz2WhGN1WsH3EJOlqxaeRCFL8MYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096376; c=relaxed/simple;
	bh=nwd3RyznRTSV4M4ELptWVLvjCziCHWfkUzhNAL75aeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fULyaKjRyUiFKQMVwE/v9ywQced6LF+Oki0hhE/0DcIBJSpgNmztMMSwqaWX0TAyy4Kk207RWAVEnDgou43XwmF1Rbxjxux3TuOECGueR7FXiwJl2K70vgOrCNMcRBnBHQ3Ad55hObJcfkNK4Z6LZF3QFKCV6t6EBScRAtRiZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gyQRpmJp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gyQRpmJp"
Received: from [100.75.32.23] (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C3A620B7168;
	Tue, 18 Aug 2026 16:39:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C3A620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787096346;
	bh=6Vg7S5eW4IB5cfpTNUIWwcHhaH3WSmycs7ywYAuFQhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gyQRpmJpJAIddWtyV+PYsOSRd4Y4ptbNhmXBwRU29u68jxyv0HnttSpOLgk3nlOaG
	 RtH513IQbWGx972giQLbl8vYGriA8actQk3dY0u7ejV5thKzDBU8UV7y1w0YzeKBv8
	 gUbLej1IatQUz7iKn0qfQ+pnzAM3d6baevTom9qU=
Message-ID: <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
Date: Tue, 18 Aug 2026 16:39:32 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260805124838.GP27883@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 05:48, Jason Gunthorpe wrote:
> On Fri, Jul 31, 2026 at 03:34:25PM -0700, Mukesh R wrote:
>> +struct iommu_domain_geometry default_geometry = (struct iommu_domain_geometry) {
>> +	.aperture_start = 0,
>> +	.aperture_end = -1UL,
>> +	.force_aperture = true,
>> +};
> 
> This should not exist

Yup, we are working with hyp team on getting the hypercall to query
iommu capabilities for S2 added for root/dom0.

>> +/*
>> + * If the current thread is a VMM thread, return the partition id of the VM it
>> + * is managing, else return HV_PARTITION_ID_INVALID.
>> + */
>> +static u64 hv_get_current_partid(void)
>> +{
> 
> No, you cannot transparently detect VMMs and link them like this. The
> VMM makes it self visible to the iommu driver via the viommu interface
> and you get a kvm FD to fish your partid out of. This is hackery not OK.
> 
> You should come with VMM support as a followup once you get a basic
> kernel-only iommu driver working.

Ok, will do that. FWIW, this was originally done internally in the 5.x
kernel by folks not here anymore, and has been getting ported forward.

Will work with Jacob to exploit the viommu object when his patch is done.

>> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	struct hv_domain *hvdom;
>> +	int rc;
>> +	u32 unique_id;
>> +	u64 ptid = hv_get_current_partid();
>> +
>> +	if (ptid == HV_PARTITION_ID_INVALID)
>> +		return NULL;
>> +
>> +	hvdom = kzalloc_obj(struct hv_domain);
>> +	if (hvdom == NULL)
>> +		return NULL;
>> +
>> +	spin_lock_init(&hvdom->mappings_lock);
>> +	hvdom->mappings_tree = RB_ROOT_CACHED;
>> +
>> +	unique_id = (u32)atomic_inc_return(&hv_unique_id);
>> +	if (unique_id == HV_DEVICE_DOMAIN_ID_S2_NULL)	/* ie, UINTMAX */
>> +		goto out_err;
>> +
>> +	hvdom->domid_num = unique_id;
>> +	hvdom->partid = ptid;
>> +	hvdom->iommu_dom.geometry = default_geometry;
>> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
> 
> This is the only place that needs it, and I somehow doubt -1 is the
> right end value since that isn't supported by most HW.
> 
>> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
>> +			       struct iommu_domain *old)
>> +{
>> +	struct pci_dev *pdev;
>> +	int rc;
>> +	struct hv_domain *hvdom_new = to_hv_domain(immdom);
>> +	struct hv_domain *hvdom_prev = to_hv_domain(old);
>> +
>> +	/* Only allow PCI devices for now */
>> +	if (!dev_is_pci(dev))
>> +		return -EINVAL;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	/* There are no explicit detach calls, hence check if we need to detach
>> +	 * first. Also, in case of guest shutdown, it's the VMM thread that
>> +	 * attaches it back to the hv_def_identity_dom, and hvdom_prev will not
>> +	 * be null then. It is null during boot.
>> +	 */
>> +	if (hvdom_prev && !hv_special_domain(hvdom_prev))
>> +		hv_iommu_detach_dev(hvdom_prev, dev);
> 
> What translation does this set? If it is anything other than blocking
> it is security broken for VFIO.

It uses whatever default was during boot. In case of baremetal dom0/root,
looks like it would be identity domain. So, not blocked.
  
> If it is blocking then why does  this:
> 
>> +	rc = hv_iommu_att_dev2dom(hvdom_new, pdev);
> 
> Attach HV_DEVICE_DOMAIN_ID_S2_NULL ?
> 
>> +	if (rc == 0)
>> +		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */
> 
> The only thing the priv is used for is release_device ?
> 
> It would be better to have a 'detach domain' as the
> release_domain so you don't need this.


Ok, sounds good.

>> +static void hv_iommu_probe_finalize(struct device *dev)
>> +{
>> +	struct iommu_domain *immdom = iommu_get_domain_for_dev(dev);
>> +
>> +	if (immdom && immdom->type == IOMMU_DOMAIN_DMA)
>> +		iommu_setup_dma_ops(dev, immdom);
>> +	else
>> +		set_dma_ops(dev, NULL);
>> +}

> I've forgotten now, but I thought we had reached the point of getting
> rid of this from most drivers? amd and vtd do not implement this, why
> does this need it?

Yeah, this is a much older driver. Will address it.

>> +static void hv_iommu_release_device(struct device *dev)
>> +{
>> +	struct hv_domain *hvdom = dev_iommu_priv_get(dev);
>> +
>> +	/* Need to detach device from device domain if necessary. */
>> +	if (hvdom)
>> +		hv_iommu_detach_dev(hvdom, dev);
> 
> What does "detach" actually do? What translation will be in effect for
> the device?

It puts the device in the default boot domain. In baremetal-dom0
case it would be identity. This is required when device moves from
a device domain to the direct attachment, hyp requires it first be
detached. But, this will go way in the kernel only iommu driver support,
we can then do the add ons for vmm support and direct attaches.

> Ideally you should set the release_domain to blocking or identity and
> arrange things so that is enough to destroy the iommu attachment. But
> I see both blocking and identity do new attaches so IDK what this
> trying to do..
> 
>> +static int hv_iommu_def_domain_type(struct device *dev)
>> +{
>> +	/* The hypervisor always creates this by default during boot */
>> +	return IOMMU_DOMAIN_IDENTITY;
>> +}
> 
> That isn't what this does, it overrides the policy set by Linux. Fully
> functional HW should not implement this function, please remove it.

Ok, will do.

>> +static struct iommu_ops hv_iommu_ops = {
>> +	.capable	    = hv_iommu_capable,
>> +	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
>> +	.probe_device	    = hv_iommu_probe_device,
>> +	.probe_finalize     = hv_iommu_probe_finalize,
>> +	.release_device     = hv_iommu_release_device,
>> +	.def_domain_type    = hv_iommu_def_domain_type,
>> +	.device_group	    = hv_iommu_device_group,
>> +	.default_domain_ops = &(const struct iommu_domain_ops) {
>> +		.attach_dev   = hv_iommu_attach_dev,
>> +		.map_pages    = hv_iommu_map_pages,
>> +		.unmap_pages  = hv_iommu_unmap_pages,
>> +		.iova_to_phys = hv_iommu_iova_to_phys,
>> +		.free	      = hv_iommu_domain_free,
>> +	},
> 
> Please don't use default_domain_ops, this should a new struct
> hv_paging_domain_ops

Ok, this is an old driver from pre 5.x days, so lacks that. Jacob and
I looked at it, and it appeared most drivers except intel were still
using default ops, so we thought that was acceptable. But I will change
it in the next version.


>> +	.owner		    = THIS_MODULE,
>> +	.identity_domain = &hv_def_identity_dom.iommu_dom,
>> +	.blocked_domain  = &hv_null_dom.iommu_dom,
> 
> Can we call null dom blocked dom please?

Sure.

>> +static void __init hv_initialize_special_domains(void)
>> +{
>> +	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
>> +	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
>> +	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
>> +	hv_def_identity_dom.iommu_dom.geometry = default_geometry;
>> +	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_DEFAULT; /* 0 */
>> +
>> +	hv_null_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
>> +	hv_null_dom.iommu_dom.ops = &hv_special_domain_ops;
>> +	hv_null_dom.iommu_dom.owner = &hv_iommu_ops;
>> +	hv_null_dom.iommu_dom.geometry = default_geometry;
>> +	hv_null_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_NULL;  /* INTMAX */
> 
> These ones don't use geometry. Didn't I say this once before?
> 
> Jason

Thanks for the review. I know there is another set of patches for pvIOMMU
ongoing (both came from the same source) and you are probably repeating
things, and I appreciate your patience. I'll also try to look for your
comments in that patch series going forward.

Thanks,
-Mukesh

