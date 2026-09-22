Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F0424D47;
	Tue, 22 Sep 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099374; cv=none; b=sOTF9ydyIXHMwjVXf3cB9hdFEsB7CF2aUGsYaYOisrFUqvDYtwD8PHgkEz2fDYO451PYUebjyJxTWZDxInxOPyE/QUTPmeL5dkoNlOheETUtOZmsIiqpijWmIzRi7GZNU7tvU+H4dRrRaapggFV2zpXFJqoGGzlYWlg8c4m/KlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099374; c=relaxed/simple;
	bh=mpANMFtRd9SAc7LdT/1l7Tgdkg76qlrtgIh9VBhXT7M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tYarqtU4uzz8oPcIfMS8y2poFTirLCwM5Qpkc683qJHGHRl8LjF39IB5K41jLwgwVSpYjqvPejMqQmaZpdHptfKr6uPH4ix8Iawcg4rMehCwyMSc0o+PwsdNJZGsrB3N/ZnDudtms+WySgh0cvUKaw089ky0pgOQD8OyRiqXPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ea1FwfhC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ea1FwfhC"
Received: from [100.64.33.11] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB93A20B7169;
	Tue, 22 Sep 2026 10:48:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB93A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790099324;
	bh=mFGvyJQoMvTsn3uQCRAGro6/eBvU1zbvENWM5sDj6P4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ea1FwfhCUfQJUjX7ARybhZYZsbUokEOppA3Zsj4LUg4T5kQWOVyAKLVrBznCOicAw
	 CytEzgKAm/1Y9n7todY3exNuDO0bTOUle77QH2V/DOXGmGJOhRfjn/9jezI2NbbDey
	 f0jBzFl5SJVgoUXe19LLn1WzW6xQfvfce98Yvhs0=
Message-ID: <4f7cadc5-817c-4163-bac8-1c02a7c6a862@linux.microsoft.com>
Date: Tue, 22 Sep 2026 10:49:30 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V0 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-4-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260921225028.4007330-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/2026 15:50, Mukesh R wrote:
> Add a new file to implement a kernel only virtual IOMMU that works
> with Microsoft Hyper-V hypervisor on privileged VMs aka root VMs. The
> hypervisor claims the IOMMU upon boot, and this driver communicates with
> it for creating and deleting paging domains, attaching of devices, mapping
> and unmapping of pages, etc. During boot, hypervisor automatically creates
> identity and blocked domains, so there is no need to do hypercalls to
> create them.  This is a kernel only driver and only supported on baremetal
> root (and not L1VH root) without any guest passthru support. Support
> for guest device passthru will be added incrementally.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/kernel/pci-dma.c            |   2 +
>  drivers/iommu/Kconfig                |   1 +
>  drivers/iommu/hyperv/Kconfig         |  15 +
>  drivers/iommu/hyperv/Makefile        |   1 +
>  drivers/iommu/hyperv/hv-iommu-root.c | 645 +++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h       |   3 +
>  include/linux/hyperv.h               |   6 +
>  7 files changed, 673 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
> 
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..37fed8c7a8c2 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -8,6 +8,7 @@
>  #include <linux/gfp.h>
>  #include <linux/pci.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/hyperv.h>
>  
>  #include <asm/proto.h>
>  #include <asm/dma.h>
> @@ -103,6 +104,7 @@ void __init pci_iommu_alloc(void)
>  	}
>  	pci_swiotlb_detect();
>  	gart_iommu_hole_init();
> +	hv_iommu_detect();
>  	amd_iommu_detect();
>  	detect_intel_iommu();
>  	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a..3e410e0f3e1d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -197,6 +197,7 @@ source "drivers/iommu/arm/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
>  source "drivers/iommu/iommufd/Kconfig"
>  source "drivers/iommu/riscv/Kconfig"
> +source "drivers/iommu/hyperv/Kconfig"
>  
>  config IRQ_REMAP
>  	bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> new file mode 100644
> index 000000000000..4342043443e7
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Hyper-V IOMMU support
> +
> +config HYPERV_ROOT_IOMMU
> +	bool "Hyper-V root VM IOMMU Device"
> +	depends on HYPERV && X86
> +	select IOMMU_API
> +	default HYPERV
> +	help
> +	  This enables Hyper-V pseudo IOMMU device on a root VM. When running
> +          as privileged VM aka root on Microsoft Hyper-V hypervisor, this must
> +          be enabled for doing any PCI passthru of devices to guest VMs. This
> +          applies to both PFs and VFs. When enabling this, it is best to
> +          disable amd/intel iommus via: intel_iommu=off amd_iommu=off as
> +          the hypervisor really owns the iommu.
> diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
> index 6ef0ef97f3dd..c7e7d0dac2a4 100644
> --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
> new file mode 100644
> index 000000000000..a5268e0e52cc
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,645 @@
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
> +/*
> + * We will not claim these PCI devices. Eg hypervisor debugger is using it
> + * for a dynamic debug session. They cannot be enumerated under static ACPI
> + * device scope.
> + */
> +static char *hv_skip_pci_devs;
> +static int __init hv_iommu_setup_skip(char *str)
> +{
> +	hv_skip_pci_devs = str;
> +	return 1;
> +}
> +/* Eg: hv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> +__setup("hv_iommu_skip=", hv_iommu_setup_skip);
> +
> +static dma_addr_t hv_max_iova_width;
> +static struct iommu_domain_ops hv_paging_domain_ops;
> +
> +/* IOMMU device that we export to the world. HyperV supports max of one */

Nit: HyperV -> MSHV

AIUI, HyperV is MSHV+the Windows virtualization stack. 

> +static struct iommu_device hv_virt_iommu;
> +

<snip>

> +}
> +
> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	unsigned long npages;
> +	u64 status;
> +	struct hv_domain *hvdom = to_hv_domain(immdom);
> +	size_t unmapped, tot_done = 0, size = pgsize * pgcount;
> +
> +	unmapped = hv_iommu_del_tree_mappings(hvdom, iova, size);
> +	if (unmapped < size)
> +		pr_err("%s: could not delete all mappings (%lx:%lx/%lx)\n",
> +		       __func__, iova, unmapped, size);
> +
> +	npages = unmapped >> HV_HYP_PAGE_SHIFT;
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
> +/* Return: must return exact status from the hypercall without changes */
> +static u64 hv_iommu_map_pgs(struct hv_domain *hvdom,
> +			    unsigned long iova, phys_addr_t paddr,
> +			    unsigned long npages, u32 map_flags)
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
> +	return status;
> +}
> +
> +#define HV_MAP_DEVICE_GPA_BATCH_SIZE   \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_device_gpa_pages)) \
> +			/ sizeof(u64))
> +
> +/*
> + * The core VFIO code loops over memory ranges calling this function with the
> + * largest pgsize from HV_IOMMU_PGSIZES. cond_resched() is in vfio_iommu_map.
> + */
> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
> +	u32 map_flags;
> +	int ret;
> +	u64 status;
> +	unsigned long npages, done = 0;
> +	struct hv_domain *hvdom = to_hv_domain(immdom);
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
> +		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    256);
> +			if (ret)
> +				break;
> +			continue;
> +		}
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	if (!hv_result_success(status)) {
> +		size_t done_size = done << HV_HYP_PAGE_SHIFT;
> +
> +		hv_status_err(status, "pgs:%lx/%lx iova:%lx\n",
> +			      done, npages, iova);
> +		/*
> +		 * lookup tree has all mappings [0 - size-1]. Below unmap will
> +		 * only remove from [0 - done], we need to remove second chunk
> +		 * [done+1 - size-1].
> +		 */
> +		hv_iommu_del_tree_mappings(hvdom, iova, size - done_size);
> +		hv_iommu_unmap_pages(immdom, iova - done_size, HV_HYP_PAGE_SIZE,
> +				     done, NULL);
> +		if (mapped)
> +			*mapped = 0;
> +	} else
> +		if (mapped)
> +			*mapped = size;
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
> +	struct hv_domain *hvdom = to_hv_domain(immdom);
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
> +/*
> + * Currently, hypervisor does not provide list of devices it is using
> + * dynamically. So use this to allow users to manually specify devices that
> + * should be skipped. (eg. hypervisor debugger using some network device).
> + */

Maybe a flag, say OwnedByHyp = 1 returned for the root equivalent of the guest driver's
GetLogicalDeviceProperty hypercall can solve this.

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (hv_skip_pci_devs && *hv_skip_pci_devs) {
> +		int rc, parsed, segment, bus, slot, func;
> +		int pos = 0;
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		do {
> +			parsed = 0;
> +
> +			rc = sscanf(hv_skip_pci_devs + pos, " (%x:%x:%x.%x) %n",
> +				    &segment, &bus, &slot, &func, &parsed);
> +
> +			if (rc != 4 || parsed <= 0)
> +				break;
> +
> +			if (pci_domain_nr(pdev->bus) == segment &&
> +			    pdev->bus->number == bus &&
> +			    PCI_SLOT(pdev->devfn) == slot &&
> +			    PCI_FUNC(pdev->devfn) == func) {
> +
> +				dev_info(dev, "skipped by Hyper-V IOMMU\n");
> +				return ERR_PTR(-ENODEV);
> +			}
> +			pos += parsed;
> +
> +		} while (hv_skip_pci_devs[pos]);
> +	}
> +
> +	return &hv_virt_iommu;
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	return generic_device_group(dev);
> +}

Just like the guest driver, this collapses down to return pci_device_group(dev) since
you don't support non-PCI devices.

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
> +	.device_group	    = hv_iommu_device_group,
> +	.get_resv_regions   = hv_iommu_get_resv_regions,
> +	.owner		    = THIS_MODULE,
> +	.identity_domain    = &hv_def_identity_dom.iommu_dom,
> +	.blocked_domain     = &hv_def_blocked_dom.iommu_dom,
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

Since all of these are constants, you could just initialize them with .<field> notation
when you declare the static domains above.

> +
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
> +	hv_max_iova_width = caps.max_iova_width;
> +
> +	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
> +		return rc;
> +	}
> +
> +	/* This must come before iommu_device_register() because the latter
> +	 * calls into the hooks.
> +	 */
> +	hv_initialize_special_domains();

If statically declared as above, no need for this call at all.

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

If there's no difference between HV_DEVICE_DOMAIN_AVAILABLE = 1 and
HV_IOMMU_CAP_PRESENT = 1 combined with HV_IOMMU_CAP_S2 = 1, then we can skip the detect
function and just detect and init all in one like the guest driver.

> +
> +	iommu_detected = 1;
> +	x86_init.iommu.iommu_init = hv_iommu_init;
> +
> +	pci_request_acs();
> +}
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..fa8331c7c3a2 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
>  
>  #define VTPM_BASE_ADDRESS 0xfed40000
>  
> +#define HV_REP_COUNT_MAX        \
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
> +
>  enum hv_partition_type {
>  	HV_PARTITION_TYPE_GUEST,
>  	HV_PARTITION_TYPE_ROOT,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9e109d91aa14..01a69f88cfa7 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1783,4 +1783,10 @@ static inline unsigned long virt_to_hvpfn(void *addr)
>  #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
>  #define page_to_hvpfn(page)	(page_to_pfn(page) * NR_HV_HYP_PAGES_IN_PAGE)
>  
> +#ifdef CONFIG_HYPERV_ROOT_IOMMU
> +void __init hv_iommu_detect(void);
> +#else
> +static inline void hv_iommu_detect(void) { }
> +#endif /* CONFIG_HYPERV_ROOT_IOMMU */
> +
>  #endif /* _HYPERV_H */

