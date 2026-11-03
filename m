Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676322;
	b=M6HT8OTokj3LgrIjru7qvX7g/J3w3ru5qAg32Mep5eD0Dd4dtqTfn//ASYBAf7yN+Z+E
	 sRbTkmUpQ/MlAtw9IHzNwRSxxu2JRHYHw/5X92QpMbQaP1dxtvwLYmFYwtfpWwEmpV595
	 7STWeTAcP60KarR8hWc1W3sPWfcmlcOSGcivYkQD3SB57xputjRDy6dVPhT4jY27BL/nv
	 Vpkssf5y9+xjDtn4kdJPSfES0Jhba6enrwsVM130e0UqGi+2wdHVbXqdO5+dBRNVeQqRr
	 Nvkuaw/lXMl1X2LpDfO2MONO5c6dbMgTuEgVhCN1uGW2nrqlHu3OiTRo8UssdVpLP0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676322;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ShzVhCZvrbJNJv2myYEwIkGXGb/OlLxWaQtfg7XaiGY=;
	b=LQdqe9Ro6XLcrYvqN//PxqwHW+h2bpOQLFucuY4/L/8ClOo4hfdQUrxmhKViWxrYEpQO
	 nZEIn/nHzugaxts9kjqfMx/UyepvfSjZTrqmxZ8E1aAilebbpy/Zcxg+QFWmjUOI+uwwv
	 gXWZfCcdVcUKpZhfEFCRPt1v9njZV8nl+Gr5ieXOPmbH6Gkw4pHQ2kj32MmX51pOeKvSQ
	 8Kbrr4uUXeQWvZhyd1wpvn3B7NAlYcv+V4PHQ/q9r380idIcFdL7z4veOJ5ZvBXSXZdNa
	 pDhUEm5aTvPMcxg/YUQt1svo8vzKb6XPrrtsGt3pr/wEGJohrf840S9fboA1PHc0lfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdgAkDvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9924606A326
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdgAkDvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978AF1F000C1;
	Tue,  3 Nov 2026 03:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676321;
	bh=ShzVhCZvrbJNJv2myYEwIkGXGb/OlLxWaQtfg7XaiGY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SdgAkDvw2m4zrvXmAZRTtjWycOs6PzTheKmc062iEGg8TGVj+wpc15aUk75PPH84l
	 0GM71D3JJayg7neQQLp1NsKh84Rg/08aoY/nfSQ1aB6YkVcqsGr2oZc3lxki8P3jYL
	 XwBTxQRFLxaHeikYl6PMYDTgTeTYfrbSGvEWbjCai1qddx36B1qfdDZtI+AW0fVwj7
	 D2Aq+eBwxL0aeWRhL2vmzNR7l3BwK7LHxx0Vc/wPydEyfQmS1EnYCxUfU+WsXGibML
	 eYqu5InQ1363Rqw0HOid8fWcvMerrMTS7/f2GxWSZSXSaQi/eeUXK3gpKFuvo/BzKM
	 eFbvAQ/Tv3tJg==
Message-ID: <sashiko-outbox-194512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 5/5] x86/hyperv: Implement root partition IOMMU
 kernel only driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261103025150.3192119-6-mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
 <20261103025150.3192119-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:25:21 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] iommu/hyperv: guest VM boot crash due to partition check in hv_roo=
t_iommu_detect()
- [High] x86/pci-dma: hv_root_iommu_init() overwritten by Intel/AMD IOMMU d=
etect
- [High] iommu/hyperv: hv_iommu_att_dev2dom() fails on HV_STATUS_DEVICE_ALR=
EADY_IN_DOMAIN
- [High] iommu/hyperv: tree corruption on zero or partial unmap in hv_iommu=
_unmap_pages()
- [Medium] iommu/hyperv: spurious hv_status_err() on memory deposit in hv_i=
ommu_map_pgs()
- [Medium] iommu/hyperv: caller gfp_t flags ignored in hv_iommu_add_tree_ma=
pping()
--

commit b814c086ae33fc3b6c22d26fe0a8b5dabc2d2f48
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement root partition IOMMU kernel only driver

This commit adds a kernel-only virtual IOMMU driver for Microsoft Hyper-V
root partitions to manage paging domains, device attachment, and page
mappings via hypercalls. It hooks into pci_iommu_alloc() to detect and
initialize the Hyper-V root IOMMU during boot.

> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 75cf8f6ae8cd0..b383c4549615a 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -8,6 +8,7 @@
>  #include <linux/gfp.h>
>  #include <linux/pci.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/hyperv.h>
> =20
>  #include <asm/proto.h>
>  #include <asm/dma.h>
> @@ -101,6 +102,7 @@ void __init pci_iommu_alloc(void)
>  	}
>  	pci_swiotlb_detect();
>  	gart_iommu_hole_init();
> +	hv_root_iommu_detect();
>  	amd_iommu_detect();
>  	detect_intel_iommu();
>  	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);

[Severity: High]
When hv_root_iommu_detect() succeeds, it sets iommu_detected =3D 1 and
assigns x86_init.iommu.iommu_init =3D hv_root_iommu_init. However,
amd_iommu_detect() and detect_intel_iommu() are called unconditionally
right after it in pci_iommu_alloc().

In drivers/iommu/intel/dmar.c:detect_intel_iommu(), whenever an ACPI DMAR
table with valid DRHD units is present, the assignment to
x86_init.iommu.iommu_init happens outside the !iommu_detected check:

	if (!iommu_detected && dmar_required()) {
		iommu_detected =3D 1;
		/* Make sure ACS will be enabled */
		pci_request_acs();
	}

	x86_init.iommu.iommu_init =3D intel_iommu_init;

Even if the user boots with intel_iommu=3Doff (as suggested in the Kconfig
help text) or firmware sets DMAR_REMAP_OPT_OUT, detect_intel_iommu() still
overwrites x86_init.iommu.iommu_init with intel_iommu_init, which then
sees dmar_policy_off() and exits without initializing any IOMMU.

Similarly, in drivers/iommu/amd/init.c:amd_iommu_detect(), if an ACPI IVRS
table is present and amd_iommu=3Doff was not passed, iommu_go_to_state()
succeeds without checking iommu_detected:

	ret =3D iommu_go_to_state(IOMMU_IVRS_DETECTED);
	if (ret)
		goto disable_snp;

	iommu_detected =3D 1;
	x86_init.iommu.iommu_init =3D amd_iommu_init;

This clobbers hv_root_iommu_init and later runs disable_iommus() against
the physical IOMMU registers owned by Hyper-V.

Won't amd_iommu_detect() and detect_intel_iommu() overwrite
x86_init.iommu.iommu_init on baremetal root partitions where ACPI DMAR or
IVRS tables are exposed?

[ ... ]

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> index 0000000000000..23212c9e44e49
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,602 @@

[ ... ]

> +static int hv_iommu_add_tree_mapping(struct hv_iommu_domain *hvdom, ulon=
g iova,
> +				     phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	ulong irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping =3D kzalloc_obj(struct hv_iommu_mapping, GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;

[Severity: Medium]
As reported by Sashiko on v2 [1], hv_iommu_map_pages() receives a gfp_t
gfp parameter from the IOMMU core and passes it to
hv_deposit_memory_gfp(), but drops it when calling
hv_iommu_add_tree_mapping().

Since mapping is allocated before acquiring hvdom->mappings_lock, should
hv_iommu_add_tree_mapping() accept and use the caller's gfp flags instead
of hardcoding GFP_ATOMIC, which prevents memory reclaim and can fail with
-ENOMEM under memory pressure when called from sleepable GFP_KERNEL
contexts?

> +
> +	mapping->paddr =3D paddr;
> +	mapping->iova.start =3D iova;
> +	mapping->iova.last =3D iova + size - 1;
> +	mapping->flags =3D flags;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, irqflags);
> +	interval_tree_insert(&mapping->iova, &hvdom->mappings_tree);
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +/* If size =3D=3D 0, then last =3D ULONG_MAX. With iova 0, will remove e=
verything */
> +static size_t hv_iommu_del_tree_mappings(struct hv_iommu_domain *hvdom,
> +					 ulong iova, size_t size)
> +{
> +	ulong flags;
> +	size_t unmapped =3D 0;
> +	ulong last =3D iova + size - 1;
> +	struct hv_iommu_mapping *mapping =3D NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
> +	next =3D interval_tree_iter_first(&hvdom->mappings_tree, iova, last);
> +	while (next) {
> +		node =3D next;
> +		mapping =3D container_of(node, struct hv_iommu_mapping, iova);
> +		next =3D interval_tree_iter_next(node, iova, last);
> +
> +		/* Splitting of a mapping is not supported at present */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped +=3D mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &hvdom->mappings_tree);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
> +
> +	return unmapped;
> +}

[ ... ]

> +static int hv_iommu_att_dev2dom(struct hv_iommu_domain *hvdom,
> +				struct pci_dev *pdev)
> +{
> +	ulong flags;
> +	u64 status;
> +	struct hv_input_attach_device_domain *input;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	/* For null domain, hvdom->domid_num =3D=3D HV_DEVICE_DOMAIN_ID_NULL */
> +	input->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D hvdom->domid_num;
> +
> +	input->device_id.as_uint64 =3D hv_build_devid_type_pci(pdev);
> +
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	rc =3D hv_iommu_att_dev2dom(hvdom, pdev);
> +	if (rc)
> +		WARN(1, "Failed to attach pdev:%s\n", pci_name(pdev));
> +
> +	return rc;
> +}

[Severity: High]
In hv_iommu_att_dev2dom(), any hypercall status other than
HV_STATUS_SUCCESS is treated as an error, converted to -EEXIST on
HV_STATUS_DEVICE_ALREADY_IN_DOMAIN, and triggers the WARN(1) in
hv_iommu_attach_dev().

There are two normal paths where HVCALL_ATTACH_DEVICE_DOMAIN returns
HV_STATUS_DEVICE_ALREADY_IN_DOMAIN:

1. At boot, Hyper-V places root partition PCI devices in the Stage 2
   default domain (HV_DEVICE_DOMAIN_ID_DEFAULT), which corresponds to
   hv_def_identity_dom (IOMMU_DOMAIN_IDENTITY). When attaching a device to
   hv_def_identity_dom (for example, when booting with
   iommu.passthrough=3D1 or CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), the devi=
ce
   is already in HV_DEVICE_DOMAIN_ID_DEFAULT.

2. When an iommu_group created by pci_device_group() contains multiple PCI
   devices sharing a DMA requester ID alias (such as devices behind a
   PCIe-to-PCI/PCI-X bridge or multifunction devices with DMA alias
   quirks), hv_build_devid_type_pci() resolves each device in the group to
   the same hv_device_id via pci_for_each_dma_alias(). When
   __iommu_group_set_domain_internal() iterates over group->devices
   calling hv_iommu_attach_dev(), the second aliased device attempts to
   attach the same hv_device_id to the same domain.

By comparison, drivers/iommu/hyperv/hv-iommu-guest.c:hv_iommu_attach_dev()
explicitly ignores HV_STATUS_DEVICE_ALREADY_IN_DOMAIN:

	if (!hv_result_success(status) &&
	    hv_result(status) !=3D HV_STATUS_DEVICE_ALREADY_IN_DOMAIN) {
		hv_status_err(status, "HVCALL_ATTACH_DEVICE_DOMAIN failed\n");
		return hv_result_to_errno(status);
	}

Should hv_iommu_att_dev2dom() also treat
HV_STATUS_DEVICE_ALREADY_IN_DOMAIN as success?

[ ... ]

> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong io=
va,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t unmap_sz, size =3D pgsize * pgcount;
> +
> +	/* For valid input, the hypervisor guarantees unmap will succeed */
> +	unmap_sz =3D hv_iommu_hyp_unmap_pages(immdom, iova, size);
> +	if (unmap_sz !=3D size)
> +		WARN(1, "Failed to unmap device gpa(%lx/%lx)\n", unmap_sz,
> +		     size);
> +
> +	size =3D hv_iommu_del_tree_mappings(hvdom, iova, unmap_sz);
> +	if (size !=3D unmap_sz)
> +		pr_err("%s: could not delete tree mappings (%lx:%lx/%lx)\n",
> +		       __func__, iova, unmap_sz, size);
> +
> +	return size;
> +}

[Severity: High]
As reported by Sashiko on v2 [1], hv_iommu_unmap_pages() and
hv_iommu_del_tree_mappings() can corrupt hvdom->mappings_tree when an
unmap fails, partially completes, or covers a sub-range of a multi-page
mapping:

1. In hv_iommu_del_tree_mappings(), last is computed as:

	ulong last =3D iova + size - 1;

   hv_iommu_domain_free() relies on iova =3D=3D 0 and size =3D=3D 0 wrappin=
g last
   to ULONG_MAX to delete all mappings in the tree. However,
   hv_iommu_unmap_pages() passes unmap_sz directly to
   hv_iommu_del_tree_mappings(hvdom, iova, unmap_sz) without checking if
   unmap_sz =3D=3D 0. If hv_iommu_hyp_unmap_pages() fails on the first batch
   and returns 0 at iova =3D=3D 0 (which is valid since aperture_start is 0=
),
   last underflows to ULONG_MAX and hv_iommu_del_tree_mappings() deletes
   every mapping in the domain even though nothing was unmapped in the
   hypervisor. If iova > 0 and unmap_sz =3D=3D 0, last wraps to iova - 1 and
   interval_tree_iter_first(&hvdom->mappings_tree, iova, iova - 1) will
   still match and delete any mapping spanning across iova - 1 and iova.

2. hv_iommu_map_pages() inserts a single struct hv_iommu_mapping node
   covering [iova, iova + size - 1] for multi-page requests. In
   hv_iommu_del_tree_mappings(), the loop checks:

	if (mapping->iova.start < iova)
		break;

   but never checks if mapping->iova.last > last. If unmap_sz < size (due
   to a partial hypercall unmap or a partial unmap of a multi-page node's
   prefix), hv_iommu_del_tree_mappings() removes and frees the entire
   hv_iommu_mapping node and returns its full size while
   [last + 1, mapping->iova.last] remains mapped in the hypervisor.

3. Because hv_iommu_hyp_unmap_pages() runs before
   hv_iommu_del_tree_mappings() validates the interval tree boundaries, an
   unmap starting in the middle of an existing mapping
   (mapping->iova.start < iova) will unmap the pages in the hypervisor
   first, and then hv_iommu_del_tree_mappings() will break out of the loop
   and return 0, leaving the stale mapping in hvdom->mappings_tree.

Could hv_iommu_unmap_pages() validate the range against
hvdom->mappings_tree before unmapping in the hypervisor, and guard against
unmap_sz =3D=3D 0 and mapping->iova.last > last in
hv_iommu_del_tree_mappings()?

> +
> +/* Return: must return exact status from the hypercall without changes */
> +static u64 hv_iommu_map_pgs(struct hv_iommu_domain *hvdom, ulong iova,
> +			    phys_addr_t paddr, ulong npages, u32 map_flags)
> +{
> +	u64 status;
> +	int i;
> +	struct hv_input_map_device_gpa_pages *input;
> +	unsigned long flags, pfn;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D hvdom->domid_num;
> +	input->map_flags =3D map_flags;
> +	input->target_device_va_base =3D iova;
> +
> +	pfn =3D paddr >> HV_HYP_PAGE_SHIFT;
> +	for (i =3D 0; i < npages; i++, pfn++)
> +		input->gpa_page_list[i] =3D pfn;
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
> +				     input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "npgs:%lx paddr:%llx iova:%lx mf:0x%x\n",
> +			      npages, paddr, iova, map_flags);
> +	return status;
> +}
> +
> +#define HV_MAP_DEVICE_GPA_BATCH_SIZE   \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_device_gpa_pages)) \
> +			/ sizeof(u64))
> +
> +/* NB: cond_resched() is in vfio_iommu_map() */
> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
> +	u32 map_flags;
> +	int ret;
> +	u64 status =3D 0;
> +	ulong npages, sav_iova =3D iova, done =3D 0;
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t size =3D pgsize * pgcount;
> +
> +	map_flags =3D HV_MAP_GPA_READABLE;	/* required */
> +	map_flags |=3D prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret =3D hv_iommu_add_tree_mapping(hvdom, iova, paddr, size, map_flags);
> +	if (ret)
> +		return ret;
> +
> +	npages =3D size >> HV_HYP_PAGE_SHIFT;
> +	while (done < npages) {
> +		ulong completed, remain =3D npages - done;
> +
> +		remain =3D min(remain, HV_MAP_DEVICE_GPA_BATCH_SIZE);
> +
> +		status =3D hv_iommu_map_pgs(hvdom, iova, paddr, remain,
> +					  map_flags);
> +
> +		completed =3D hv_repcomp(status);
> +		done =3D done + completed;
> +		iova =3D iova + (completed << HV_HYP_PAGE_SHIFT);
> +		paddr =3D paddr + (completed << HV_HYP_PAGE_SHIFT);
> +
> +		if (hv_result_needs_memory(status)) {
> +			ret =3D hv_deposit_memory_gfp(hv_current_partition_id,
> +						    status, gfp);
> +			if (ret)
> +				break;
> +			continue;
> +		}
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	if (hv_result_success(status)) {
> +		if (mapped)
> +			*mapped =3D size;
> +	} else {
> +		size_t done_size =3D done << HV_HYP_PAGE_SHIFT;
> +
> +		hv_status_err(status, "pgs:%lx/%lx iova:%lx\n", done, npages,
> +			      sav_iova);
> +
> +		hv_iommu_del_tree_mappings(hvdom, sav_iova, size);
> +
> +		/* Hypervisor guarantees unmap will succeed here */
> +		hv_iommu_hyp_unmap_pages(immdom, sav_iova, done_size);
> +
> +		if (mapped)
> +			*mapped =3D 0;
> +	}
> +
> +	return hv_result_to_errno(status);
> +}

[Severity: Medium]
When HVCALL_MAP_DEVICE_GPA_PAGES returns a status where
hv_result_needs_memory(status) is true so that hv_iommu_map_pages() can
deposit memory via hv_deposit_memory_gfp() and retry, hv_iommu_map_pgs()
checks:

	if (!hv_result_success(status))
		hv_status_err(status, "npgs:%lx paddr:%llx iova:%lx mf:0x%x\n",
			      npages, paddr, iova, map_flags);

Won't this log a false KERN_ERR message every time the hypervisor requests
a normal memory deposit during DMA mapping, and log hv_status_err() twice
when a genuine hypercall failure occurs (once in hv_iommu_map_pgs() and
again in the error path of hv_iommu_map_pages())? Also, if
hv_deposit_memory_gfp() fails with a non-zero ret, its error code is
discarded at the end of hv_iommu_map_pages() in favor of
hv_result_to_errno(status).

[ ... ]

> +static int hv_iommu_get_caps(struct hv_output_get_iommu_capabilities *ca=
ps)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output=
);
> +	*caps =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}

[ ... ]

> +void __init hv_root_iommu_detect(void)
> +{
> +	if (no_iommu || iommu_detected || hv_l1vh_partition())
> +		return;
> +
> +	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
> +		return;
> +
> +	iommu_detected =3D 1;
> +	x86_init.iommu.iommu_init =3D hv_root_iommu_init;
> +
> +	pci_request_acs();
> +}

[Severity: High]
CONFIG_HYPERV_ROOT_IOMMU defaults to CONFIG_HYPERV when CONFIG_MSHV_ROOT
is enabled, so a single kernel image can boot in both root partitions
(HV_PARTITION_TYPE_ROOT) and regular guest VMs (HV_PARTITION_TYPE_GUEST).

In hv_root_iommu_detect(), checking hv_l1vh_partition() only excludes
HV_PARTITION_TYPE_L1VH, not HV_PARTITION_TYPE_GUEST. When a regular guest
VM boots with HV_DEVICE_DOMAIN_AVAILABLE advertised in
ms_hyperv.misc_features (for example, when guest pvIOMMU is enabled),
hv_root_iommu_detect() will set iommu_detected =3D 1 (causing
hv_pviommu_init() to abort with -ENODEV) and register hv_root_iommu_init.

When pci_iommu_init() then runs hv_root_iommu_init() ->
hv_iommu_get_caps(), it dereferences hyperv_pcpu_output_arg:

	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
	...
	*caps =3D *output;

However, drivers/hv/hv_common.c:hv_common_init() only allocates
hyperv_pcpu_output_arg when hv_output_page_exists() is true:

	/* Allocate the per-CPU state for output arg for root */
	if (hv_output_page_exists()) {
		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
		BUG_ON(!hyperv_pcpu_output_arg);
	}

In a regular guest VM, hyperv_pcpu_output_arg is NULL, causing a NULL
pointer dereference during boot.

Should hv_root_iommu_detect() check !hv_root_partition() instead of
hv_l1vh_partition()?

[1] https://lore.kernel.org/r/20260929223622.778617-5-mrathor@linux.microso=
ft.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103025150.3192=
119-1-mrathor@linux.microsoft.com?part=3D5
