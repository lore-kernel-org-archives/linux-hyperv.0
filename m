Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618623;
	b=HuQN0RY1chrbxG0CdYkQKlFpLeV3q6kR+ckUi3J+HPlR7xm0Nb6sjCwPI9RKm4sa+P0B
	 9/Tju7eALgxjPQsFRL4PjZJZ7FabSJkkPFG5ywwk3fFMd8SYu4IkgkRnSXoF46tab+7Lz
	 +fywsVFFtM2D1ZnOh1ZyeEEEV5MNxuRWynVqAfUbW3iAVNVFBICdacRvu5Tr87U/zz7L6
	 69jDKP5+dxiqJQfQnJ+yDBEHTXnZ3qDmBp5TTej2garda/8xAtjmUbIAdZUM9NomTnKgA
	 VlCtqvnTz1AMO5jyYZfpMO72y5YsbXpAl0GMzRkiO3QaUfiJQgfbV+o6kQPY6DcRACA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618623;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=4nWjT99PVm81cq5tCJCUKK6PtMijT0ed/MV7VyHZhag=;
	b=tprqjoDqgAjQ4hMp8VXPLuwPIwrFmb3QG6R1ClLu4GexQPEQ9YgpcNn6dTfIyBeg9aN5
	 /bFqWcWpmbPPlBOTddW4dfopxw29AyvMxjZ7AZp9GKECxriWuZvFxg24w4Nzn4BQsUWKY
	 lKQy40GAP7itMo+uHquLmZ6YLl7Rua+fayZmHFxLor3gkJWm/O7o5uGsTrf2YvxnK3sdt
	 yPw9CZEbYqdD5nW1i7ANeuJ8X5G8JqGcCXwMHekS7ghrrTuoEAADtqNaX81pqEO61VbSn
	 +XDl7ZRt9syoWr4lpyZipSn45H1m3UzAt+cJncSW+V3IwU7LShhR9xddbKPdFekGiPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=HXyQWkPx;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68B606A31A;
	Wed, 21 Oct 2026 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B68B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=HXyQWkPx
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92F8220B7166;
	Wed, 21 Oct 2026 14:36:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92F8220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792618607;
	bh=4nWjT99PVm81cq5tCJCUKK6PtMijT0ed/MV7VyHZhag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HXyQWkPx9cB9CqsHKC8o/KXVFd1NBac0E8kb97MqGMqeA51V6acg3u4/WMhK4LFKu
	 14HaabkeshTJnu0dnxSdlFEA82SPXq3/t2bJR4saSus9xId6FEW+xfcIPb0obRB1FD
	 ixsqx+ZtbwHqU0cjouH26TDSBInJX3RiOhyHswUU=
Message-ID: <c01d422c-5277-010b-ff14-dfe5fec6a7bb@linux.microsoft.com>
Date: Wed, 21 Oct 2026 14:36:53 -0700
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 4/4] x86/hyperv: Implement root partition IOMMU kernel
 only driver
Content-Language: en-US
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org
Cc: jgg@nvidia.com, jacob.pan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
 <20260929223622.778617-5-mrathor@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260929223622.778617-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason and Joerg,

I am going to rebase due to all the patches that went it and crank
out a new version. Do you have any more comments/concerns, I think I have
addressed all your concerns. Pl lmk.

Thanks,
-Mukesh


On 9/29/26 15:36, Mukesh R wrote:
> Add a new file to implement a kernel only virtual IOMMU that works
> with Microsoft Hyper-V hypervisor (aka MSHV) on privileged VMs aka
> root VMs. The hypervisor claims the IOMMU upon boot, and this driver
> communicates with it for creating and deleting paging domains, attaching
> of devices, mapping and unmapping of pages, etc. During boot, hypervisor
> automatically creates identity and blocked domains, so there is no need
> to do hypercalls to create them.  This is a kernel only driver and only
> supported on baremetal root (and not L1VH root) without any guest passthru
> support. Support for guest device passthru will be added incrementally.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>   arch/x86/kernel/pci-dma.c            |   2 +
>   drivers/iommu/Kconfig                |   1 +
>   drivers/iommu/hyperv/Kconfig         |  15 +
>   drivers/iommu/hyperv/Makefile        |   1 +
>   drivers/iommu/hyperv/hv-iommu-root.c | 608 +++++++++++++++++++++++++++
>   include/asm-generic/mshyperv.h       |   3 +
>   include/linux/hyperv.h               |   6 +
>   7 files changed, 636 insertions(+)
>   create mode 100644 drivers/iommu/hyperv/Kconfig
>   create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
> 
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..37fed8c7a8c2 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -8,6 +8,7 @@
>   #include <linux/gfp.h>
>   #include <linux/pci.h>
>   #include <linux/amd-iommu.h>
> +#include <linux/hyperv.h>
>   
>   #include <asm/proto.h>
>   #include <asm/dma.h>
> @@ -103,6 +104,7 @@ void __init pci_iommu_alloc(void)
>   	}
>   	pci_swiotlb_detect();
>   	gart_iommu_hole_init();
> +	hv_iommu_detect();
>   	amd_iommu_detect();
>   	detect_intel_iommu();
>   	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a..3e410e0f3e1d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -197,6 +197,7 @@ source "drivers/iommu/arm/Kconfig"
>   source "drivers/iommu/intel/Kconfig"
>   source "drivers/iommu/iommufd/Kconfig"
>   source "drivers/iommu/riscv/Kconfig"
> +source "drivers/iommu/hyperv/Kconfig"
>   
>   config IRQ_REMAP
>   	bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> new file mode 100644
> index 000000000000..b9be8de4d901
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Hyper-V IOMMU support
> +
> +config HYPERV_ROOT_IOMMU
> +	bool "Hyper-V IOMMU Device in root partition"
> +	depends on HYPERV && X86 && PCI_MSI && MSHV_ROOT
> +	select IOMMU_API
> +	default HYPERV
> +	help
> +	  This enables Hyper-V pseudo IOMMU device. When running as privileged
> +          VM aka root on Microsoft Hyper-V hypervisor, this must be enabled
> +          for doing any PCI passthru of devices to guest VMs. This applies to
> +          both PFs and VFs. When enabling this, it is best to disable amd/intel
> +          iommus via: intel_iommu=off amd_iommu=off as the hypervisor really
> +          owns the iommu.
> diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
> index 6ef0ef97f3dd..c7e7d0dac2a4 100644
> --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
> new file mode 100644
> index 000000000000..2502db5624de
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hyper-V root vIOMMU driver.
> + * Copyright (C) 2026, Microsoft, Inc.
> + */
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/interval_tree.h>
> +#include <linux/hyperv.h>
> +#include <asm/iommu.h>
> +#include <asm/mshyperv.h>
> +#include "../dma-iommu.h"
> +
> +static dma_addr_t hv_iommu_max_iova;
> +static struct iommu_domain_ops hv_paging_domain_ops;
> +
> +/* IOMMU device that we export to the world. MSHV supports max of one */
> +static struct iommu_device hv_virt_iommu;
> +
> +struct hv_iommu_domain {
> +	struct iommu_domain iommu_dom;
> +	u32 domid_num;			      /* as opposed to domain_id.type */
> +	spinlock_t mappings_lock;	      /* protects mappings_tree */
> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
> +};
> +
> +#define to_hv_domain(d) container_of(d, struct hv_iommu_domain, iommu_dom)
> +
> +struct hv_iommu_mapping {
> +	phys_addr_t paddr;
> +	struct interval_tree_node iova;
> +	u32 flags;
> +};
> +
> +/*
> + * By default, during boot the hypervisor creates one Stage 2 (S2) default
> + * domain. It has two types:
> + *   S2 default: access to entire root partition memory. This for the host
> + *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
> + *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
> + *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
> + */
> +
> +/*
> + * Create dummy domains to correspond to hypervisor prebuilt default identity
> + * and null domains (dummy because we do not make hypercalls to create them).
> + */
> +static struct hv_iommu_domain hv_def_identity_dom;
> +static struct hv_iommu_domain hv_def_blocked_dom;
> +
> +/*
> + * The hypervisor owns the IOMMU. As such it will choose the best page size
> + * and whenever possible use larger page sizes automatically. The map gpa
> + * hypercall to map the iova however currently uses only 4K pfns as input.
> + * So we specify 4K as the IOMMU PAGE_SIZE.
> + */
> +#define HV_IOMMU_PGSIZES SZ_4K
> +
> +static DEFINE_IDA(hv_iommu_domids);   /* unique numeric ids for new domains */
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int hv_iommu_add_tree_mapping(struct hv_iommu_domain *hvdom, ulong iova,
> +				     phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	ulong irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping = kzalloc_obj(struct hv_iommu_mapping, GFP_ATOMIC);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	mapping->paddr = paddr;
> +	mapping->iova.start = iova;
> +	mapping->iova.last = iova + size - 1;
> +	mapping->flags = flags;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, irqflags);
> +	interval_tree_insert(&mapping->iova, &hvdom->mappings_tree);
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, irqflags);
> +
> +	return 0;
> +}
> +
> +/* If size == 0, then last = ULONG_MAX. With iova 0, will remove everything */
> +static size_t hv_iommu_del_tree_mappings(struct hv_iommu_domain *hvdom,
> +					 ulong iova, size_t size)
> +{
> +	ulong flags;
> +	size_t unmapped = 0;
> +	ulong last = iova + size - 1;
> +	struct hv_iommu_mapping *mapping = NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
> +	next = interval_tree_iter_first(&hvdom->mappings_tree, iova, last);
> +	while (next) {
> +		node = next;
> +		mapping = container_of(node, struct hv_iommu_mapping, iova);
> +		next = interval_tree_iter_next(node, iova, last);
> +
> +		/* Splitting of a mapping is not supported at present */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped += mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &hvdom->mappings_tree);
> +		kfree(mapping);
> +	}
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
> +
> +	return unmapped;
> +}
> +
> +/* Create a new device domain in the hypervisor */
> +static int hv_iommu_create_hyp_devdom(struct hv_iommu_domain *hvdom)
> +{
> +	u64 status;
> +	struct hv_input_device_domain *ddp;
> +	struct hv_input_create_device_domain *input;
> +	ulong flags;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	ddp = &input->device_domain;
> +	ddp->partition_id = HV_PARTITION_ID_SELF;
> +	ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
> +	ddp->domain_id.id = hvdom->domid_num;
> +
> +	input->create_device_domain_flags.forward_progress_required = 1;
> +	input->create_device_domain_flags.inherit_owning_vtl = 0;
> +
> +	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct hv_iommu_domain *hvdom;
> +	int rc;
> +
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	hvdom = kzalloc_obj(struct hv_iommu_domain);
> +	if (hvdom == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree = RB_ROOT_CACHED;
> +
> +	rc = ida_alloc_range(&hv_iommu_domids,
> +			     HV_DEVICE_DOMAIN_ID_S2_DEFAULT + 1,
> +			     HV_DEVICE_DOMAIN_ID_S2_NULL - 1, GFP_KERNEL);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	hvdom->domid_num = rc;
> +	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
> +	hvdom->iommu_dom.geometry.aperture_start = 0;
> +	hvdom->iommu_dom.geometry.aperture_end = hv_iommu_max_iova;
> +	hvdom->iommu_dom.geometry.force_aperture = true;
> +	hvdom->iommu_dom.ops = &hv_paging_domain_ops;
> +
> +	rc = hv_iommu_create_hyp_devdom(hvdom);
> +	if (rc)
> +		goto out_err1;
> +
> +	return &hvdom->iommu_dom;
> +
> +out_err1:
> +	ida_free(&hv_iommu_domids, hvdom->domid_num);
> +out_err:
> +	kfree(hvdom);
> +	return ERR_PTR(rc);
> +}
> +
> +static void hv_iommu_domain_free(struct iommu_domain *immdom)
> +{
> +	ulong flags;
> +	u64 status;
> +	struct hv_input_delete_device_domain *input;
> +	struct hv_input_device_domain *ddp;
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +
> +	/* Cleanup any remaining. 0 for size results in ULONG_MAX as the last */
> +	hv_iommu_del_tree_mappings(hvdom, 0, 0);
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	ddp = &input->device_domain;
> +	memset(input, 0, sizeof(*input));
> +
> +	ddp->partition_id = HV_PARTITION_ID_SELF;
> +	ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
> +	ddp->domain_id.id = hvdom->domid_num;
> +
> +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
> +				 NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	ida_free(&hv_iommu_domids, hvdom->domid_num);
> +	kfree(hvdom);
> +}
> +
> +/*
> + * Attach a device to the default domain, or the null domain, or to a domain
> + * previously created in the hypervisor.
> + */
> +static int hv_iommu_att_dev2dom(struct hv_iommu_domain *hvdom,
> +				struct pci_dev *pdev)
> +{
> +	ulong flags;
> +	u64 status;
> +	struct hv_input_attach_device_domain *input;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	/* For null domain, hvdom->domid_num == HV_DEVICE_DOMAIN_ID_S2_NULL */
> +	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id = hvdom->domid_num;
> +
> +	input->device_id.as_uint64 = hv_build_devid_type_pci(pdev);
> +
> +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +
> +	pdev = to_pci_dev(dev);
> +
> +	rc = hv_iommu_att_dev2dom(hvdom, pdev);
> +	if (rc)
> +		WARN(1, "Failed to attach pdev:%s\n", pci_name(pdev));
> +
> +	return rc;
> +}
> +
> +static u64 hv_iommu_unmap_batch(u32 domid_num, ulong iova, u16 count)
> +{
> +	ulong flags;
> +	struct hv_input_unmap_device_gpa_pages *input;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id = domid_num;
> +	input->target_device_va_base = iova;
> +
> +	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, count,
> +				     0, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "iova:0x%lx count:0x%x\n", iova, count);
> +
> +	return status;
> +}
> +
> +static size_t hv_iommu_hyp_unmap_pages(struct iommu_domain *immdom, ulong iova,
> +				       size_t size)
> +{
> +	u64 status;
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +	size_t tot_done = 0;
> +	ulong npages = size >> HV_HYP_PAGE_SHIFT;
> +
> +	while (npages) {
> +		int done, count = min(npages, HV_REP_COUNT_MAX);
> +
> +		status = hv_iommu_unmap_batch(hvdom->domid_num, iova, count);
> +
> +		done = hv_repcomp(status);
> +		tot_done += done;
> +		npages -= done;
> +		iova += done << HV_HYP_PAGE_SHIFT;
> +
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	return tot_done << HV_HYP_PAGE_SHIFT;
> +}
> +
> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +	size_t unmap_sz, size = pgsize * pgcount;
> +
> +	/* For valid input, the hypervisor guarantees unmap will succeed */
> +	unmap_sz = hv_iommu_hyp_unmap_pages(immdom, iova, size);
> +	if (unmap_sz != size)
> +		WARN(1, "Failed to unmap device gpa(%lx/%lx)\n", unmap_sz,
> +		     size);
> +
> +	size = hv_iommu_del_tree_mappings(hvdom, iova, unmap_sz);
> +	if (size != unmap_sz)
> +		pr_err("%s: could not delete tree mappings (%lx:%lx/%lx)\n",
> +		       __func__, iova, unmap_sz, size);
> +
> +	return size;
> +}
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
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id = hvdom->domid_num;
> +	input->map_flags = map_flags;
> +	input->target_device_va_base = iova;
> +
> +	pfn = paddr >> HV_HYP_PAGE_SHIFT;
> +	for (i = 0; i < npages; i++, pfn++)
> +		input->gpa_page_list[i] = pfn;
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
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
> +	u64 status = 0;
> +	ulong npages, sav_iova = iova, done = 0;
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +	size_t size = pgsize * pgcount;
> +
> +	map_flags = HV_MAP_GPA_READABLE;	/* required */
> +	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret = hv_iommu_add_tree_mapping(hvdom, iova, paddr, size, map_flags);
> +	if (ret)
> +		return ret;
> +
> +	npages = size >> HV_HYP_PAGE_SHIFT;
> +	while (done < npages) {
> +		ulong completed, remain = npages - done;
> +
> +		remain = min(remain, HV_MAP_DEVICE_GPA_BATCH_SIZE);
> +
> +		status = hv_iommu_map_pgs(hvdom, iova, paddr, remain,
> +					  map_flags);
> +
> +		completed = hv_repcomp(status);
> +		done = done + completed;
> +		iova = iova + (completed << HV_HYP_PAGE_SHIFT);
> +		paddr = paddr + (completed << HV_HYP_PAGE_SHIFT);
> +
> +		if (hv_result_needs_memory(status)) {
> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    4, gfp);
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
> +			*mapped = size;
> +	} else {
> +		size_t done_size = done << HV_HYP_PAGE_SHIFT;
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
> +			*mapped = 0;
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static phys_addr_t hv_iommu_iova_to_phys(struct iommu_domain *immdom,
> +					 dma_addr_t iova)
> +{
> +	unsigned long flags;
> +	struct hv_iommu_mapping *mapping;
> +	struct interval_tree_node *node;
> +	u64 paddr = 0;
> +	struct hv_iommu_domain *hvdom = to_hv_domain(immdom);
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
> +	node = interval_tree_iter_first(&hvdom->mappings_tree, iova, iova);
> +	if (node) {
> +		mapping = container_of(node, struct hv_iommu_mapping, iova);
> +		paddr = mapping->paddr + (iova - mapping->iova.start);
> +	}
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
> +
> +	return paddr;
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	return &hv_virt_iommu;
> +}
> +
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *reg;
> +
> +	/* reserve the entire LAPIC region */
> +	reg = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0, IOMMU_RESV_MSI,
> +				      GFP_KERNEL);
> +	if (reg)
> +		list_add_tail(&reg->list, head);
> +}
> +
> +static struct iommu_domain_ops hv_paging_domain_ops = {
> +	.attach_dev = hv_iommu_attach_dev,
> +	.map_pages = hv_iommu_map_pages,
> +	.unmap_pages = hv_iommu_unmap_pages,
> +	.iova_to_phys = hv_iommu_iova_to_phys,
> +	.free = hv_iommu_domain_free,
> +};
> +
> +static struct iommu_ops hv_iommu_ops = {
> +	.capable	    = hv_iommu_capable,
> +	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
> +	.probe_device	    = hv_iommu_probe_device,
> +	.device_group	    = pci_device_group,
> +	.get_resv_regions   = hv_iommu_get_resv_regions,
> +	.owner		    = THIS_MODULE,
> +	.identity_domain    = &hv_def_identity_dom.iommu_dom,
> +	.blocked_domain     = &hv_def_blocked_dom.iommu_dom,
> +	.release_domain     = &hv_def_blocked_dom.iommu_dom,
> +};
> +
> +static const struct iommu_domain_ops hv_special_domain_ops = {
> +	.attach_dev = hv_iommu_attach_dev,
> +};
> +
> +static void __init hv_initialize_special_domains(void)
> +{
> +	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
> +	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
> +	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
> +	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_DEFAULT; /* 0 */
> +
> +	hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
> +	hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
> +	hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
> +	hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_NULL; /* INTMAX */
> +}
> +
> +/*
> + * In general, the hypervisor does not support the capabilities hypercall for
> + * root partitions, an exception was made for max_iova_width. For IOMMU cap,
> + * hv_iommu_detect() below checks for HV_DEVICE_DOMAIN_AVAILABLE which
> + * supersedes HV_IOMMU_CAP_PRESENT. As for the pgsize_bitmap cap, see comment
> + * above HV_IOMMU_PGSIZES.
> + */
> +static int hv_iommu_get_caps(struct hv_output_get_iommu_capabilities *caps)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output);
> +	*caps = *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup = &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc = hv_iommu_get_caps(&caps);
> +	if (rc)
> +		return rc;
> +
> +	hv_iommu_max_iova = DMA_BIT_MASK(caps.max_iova_width);
> +
> +	/* This must come before iommu_device_register() because the latter
> +	 * calls into the hooks.
> +	 */
> +	hv_initialize_special_domains();
> +
> +	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = iommu_device_register(iommup, &hv_iommu_ops, NULL);
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_register failed: %d\n", rc);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("Hyper-V IOMMU initialized\n");
> +
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(iommup);
> +	return rc;
> +}
> +
> +void __init hv_iommu_detect(void)
> +{
> +	if (no_iommu || iommu_detected || hv_l1vh_partition())
> +		return;
> +
> +	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
> +		return;
> +
> +	iommu_detected = 1;
> +	x86_init.iommu.iommu_init = hv_iommu_init;
> +
> +	pci_request_acs();
> +}
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index af65dd3e3725..a35e30b87815 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
>   
>   #define VTPM_BASE_ADDRESS 0xfed40000
>   
> +#define HV_REP_COUNT_MAX        \
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
> +
>   enum hv_partition_type {
>   	HV_PARTITION_TYPE_GUEST,
>   	HV_PARTITION_TYPE_ROOT,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9e109d91aa14..01a69f88cfa7 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1783,4 +1783,10 @@ static inline unsigned long virt_to_hvpfn(void *addr)
>   #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
>   #define page_to_hvpfn(page)	(page_to_pfn(page) * NR_HV_HYP_PAGES_IN_PAGE)
>   
> +#ifdef CONFIG_HYPERV_ROOT_IOMMU
> +void __init hv_iommu_detect(void);
> +#else
> +static inline void hv_iommu_detect(void) { }
> +#endif /* CONFIG_HYPERV_ROOT_IOMMU */
> +
>   #endif /* _HYPERV_H */

