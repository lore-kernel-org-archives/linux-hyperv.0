Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E130D3EE;
	Thu, 13 Aug 2026 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660160; cv=none; b=PgG2KJ17F5Uk4tMazwdk0tmn0IdADZ0li70ewColu0keHlsLZsusRr0P2GLsU2M3FVSRe8ZL9dQ+1n0wxH1jxCWWpiX9bCBnXxdqFD5HhjezSHvk6pHQQUVgS0pl93/PAnlR/UP0Z3m6rxKOHhCgtAm65O4/PUYAxf42G0wL9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660160; c=relaxed/simple;
	bh=KdxhWZ1GCILuibf5sr6SYLgBjflq8lz7aNob+Yq7F3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azoJQngyVpkfhQv/22GKmgxIsiAU1ecPzDdRwA7TVdzVg0m1lbuALHRCW/h+CkGpzR4MN7Lk8strPED+slDSHHPFlQhkXmQ6Fg7jEdxrP2mVlqmeZstiN+AizoL2SB3Y+pAo6PqK3YyB45n44tPhoVX+tLDeb9T/IFlN/bT1aEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EhyrKtT5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EhyrKtT5"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A046020B7168;
	Thu, 13 Aug 2026 15:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A046020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786660130;
	bh=haqzxaGpYVx3myr2zjNuJ/4zNb3wfAFqCExTcZNVdYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EhyrKtT5w33dNwVku9IP9iY+gPSRT8oIVBCPGqzB5j3rkIhgzKidh/0lwph0EN8aP
	 zLQU5veIzovIIM64Lgs7YTnaq5FYfyRw2oNShhOxdyrueW7MmkPF0xlDpC6E2NgxTa
	 js+zLG83rRGN+vGQowIKDymyVcZFSpNitTy16YI0=
Date: Thu, 13 Aug 2026 15:29:13 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 jgg@ziepe.ca, mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813152913.00003d8a@linux.microsoft.com>
In-Reply-To: <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
	<20260811155022.108148-5-zhangyu1@linux.microsoft.com>
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

Hi Yu,

On Tue, 11 Aug 2026 23:50:20 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> Add a para-virtualized IOMMU driver for Linux guests running on
> Hyper-V. This driver implements stage-1 IO translation within the
> guest OS. It integrates with the Linux IOMMU core, utilizing Hyper-V
> hypercalls for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
> 
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
> 
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
> 
> Guest hibernation and resume are not supported by this initial
> implementation. The guest-owned stage-1 page tables reside in guest
> memory and are preserved in the hibernation image. However, the image
> does not by itself preserve the Hyper-V device-domain objects or their
> device attachments, and the current pvIOMMU interface does not define
> whether or how Hyper-V restores that state.
> 
> To identify a device in its hypercall interface, the driver looks up
> the logical device ID prefix registered for the device's PCI domain
> (see the logical device ID registry in hv_common.c) and combines it
> with the PCI function number of the endpoint device.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan
> <easwar.hariharan@linux.microsoft.com> Signed-off-by: Easwar
> Hariharan <easwar.hariharan@linux.microsoft.com> Signed-off-by: Yu
> Zhang <zhangyu1@linux.microsoft.com> ---
>  arch/x86/hyperv/hv_init.c             |   4 +
>  arch/x86/include/asm/mshyperv.h       |   4 +
>  drivers/iommu/Kconfig                 |   1 +
>  drivers/iommu/hyperv/Kconfig          |  16 +
>  drivers/iommu/hyperv/Makefile         |   1 +
>  drivers/iommu/hyperv/hv-iommu-guest.c | 632
> ++++++++++++++++++++++++++ drivers/iommu/hyperv/iommu.h          |
> 50 ++ 7 files changed, 708 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 55a8b6de2865..094f9f7ddb72 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -578,6 +578,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev =
> x86_init.timers.setup_percpu_clockev;
> x86_init.timers.setup_percpu_clockev =
> hv_stimer_setup_percpu_clockev; +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init = hv_iommu_init;
> +#endif
> +
>  	hv_apic_init();
>  
>  	x86_init.pci.arch_init = hv_pci_init;
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h index f64393e853ee..20d947c2c758
> 100644 --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -313,6 +313,10 @@ static inline void
> mshv_vtl_return_hypercall(void) {} static inline void
> __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {} #endif
>  
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int __init hv_iommu_init(void);
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>  
>  #endif
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a..0d128f377929 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -195,6 +195,7 @@ config MSM_IOMMU
>  source "drivers/iommu/amd/Kconfig"
>  source "drivers/iommu/arm/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
> +source "drivers/iommu/hyperv/Kconfig"
>  source "drivers/iommu/iommufd/Kconfig"
>  source "drivers/iommu/riscv/Kconfig"
>  
> diff --git a/drivers/iommu/hyperv/Kconfig
> b/drivers/iommu/hyperv/Kconfig new file mode 100644
> index 000000000000..37114239b832
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# HyperV paravirtualized IOMMU support
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> +	depends on X86_64 && HYPERV
> +	select IOMMU_API
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_X86_64
> +	select IOMMU_IOVA
> +	default HYPERV
> +	help
> +	  Para-virtualized IOMMU driver for Linux guests running on
> +	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
> +	  flush support to enable DMA isolation for PCI devices
> +	  assigned to the guest.
> diff --git a/drivers/iommu/hyperv/Makefile
> b/drivers/iommu/hyperv/Makefile index 6ef0ef97f3dd..d3b2a259439c
> 100644 --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap-x86.o
> +obj-$(CONFIG_HYPERV_PVIOMMU) += hv-iommu-guest.o
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c
> b/drivers/iommu/hyperv/hv-iommu-guest.c new file mode 100644
> index 000000000000..2a00353ce733
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
> + */
> +
> +#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/generic_pt/iommu.h>
> +#include <linux/pci-ats.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +struct hv_iommu_dev *hv_iommu_device;
> +
> +/*
> + * Identity and blocking domains are static singletons: identity is
> a 1:1
> + * passthrough with no page table, blocking rejects all DMA. Neither
> holds
> + * per-IOMMU state, so one instance suffices even with multiple
> vIOMMUs.
> + */
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> +static struct iommu_ops hv_iommu_ops;
> +
> +static struct hv_iommu_domain hv_identity_domain = {
> +	.domain = {
> +		.type	= IOMMU_DOMAIN_IDENTITY,
> +		.ops	= &hv_iommu_identity_domain_ops,
> +		.owner	= &hv_iommu_ops,
> +	},
> +};
> +
> +static struct hv_iommu_domain hv_blocking_domain = {
> +	.domain = {
> +		.type	= IOMMU_DOMAIN_BLOCKED,
> +		.ops	= &hv_iommu_blocking_domain_ops,
> +		.owner	= &hv_iommu_ops,
> +	},
> +};
> +
> +static inline bool hv_iommu_present(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_PRESENT;
> +}
> +
> +static inline bool hv_iommu_s1_domain_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_S1;
> +}
> +
> +static inline bool hv_iommu_5lvl_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_S1_5LVL;
> +}
> +
> +static inline bool hv_iommu_ats_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_ATS;
> +}
> +
> +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	int ret;
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_create_device_domain *input;
> +
> +	ret = ida_alloc_range(&hv_iommu_device->domain_ids,
> +			      hv_iommu_device->first_domain,
> +			      hv_iommu_device->last_domain,
> GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	hv_domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
> +	hv_domain->device_domain.domain_id.type =
> HV_DEVICE_DOMAIN_TYPE_S1;
> +	hv_domain->device_domain.domain_id.id = ret;
> +	hv_domain->hv_iommu = hv_iommu_device;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain = hv_domain->device_domain;
> +	input->create_device_domain_flags.forward_progress_required
> = 1;
> +	input->create_device_domain_flags.inherit_owning_vtl = 0;
> +	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "HVCALL_CREATE_DEVICE_DOMAIN
> failed\n");
> +		ida_free(&hv_iommu_device->domain_ids,
> +			 hv_domain->device_domain.domain_id.id);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_delete_device_domain(struct hv_iommu_domain
> *hv_domain) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_delete_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain = hv_domain->device_domain;
> +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN
> failed\n"); +
> +	ida_free(&hv_domain->hv_iommu->domain_ids,
> +		 hv_domain->device_domain.domain_id.id);
> +}
> +
> +static int
> +hv_configure_device_domain(struct hv_iommu_domain *hv_domain,
> +			   const struct hv_device_domain_settings
> *settings) +{
> +	struct hv_input_configure_device_domain *input;
> +	unsigned long flags;
> +	u64 status;
> +
nit: Local variable declarations are ordered differently from the
surrounding functions.

> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain = hv_domain->device_domain;
> +	input->settings = *settings;
> +	status = hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN,
> input, NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status,
> +			      "HVCALL_CONFIGURE_DEVICE_DOMAIN
> failed\n"); +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int
> +hv_create_configure_device_domain(struct hv_iommu_domain *hv_domain,
> +				  const struct
> hv_device_domain_settings *settings) +{
> +	int ret;
> +
> +	ret = hv_create_device_domain(hv_domain);
> +	if (ret)
> +		return ret;
> +
> +	ret = hv_configure_device_domain(hv_domain, settings);
> +	if (ret)
> +		hv_delete_device_domain(hv_domain);
> +
> +	return ret;
> +}
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	return cap == IOMMU_CAP_CACHE_COHERENCY;
> +}
> +
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain = hv_domain->device_domain;
> +	status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "HVCALL_FLUSH_DEVICE_DOMAIN
> failed\n"); +}
should this be a WARN_ONCE? flush TLB failure can be catastrophic, not
an ordinary hypercall failure.

> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct
> device *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =
> to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	pdev = to_pci_dev(dev);
> +	dev_dbg(dev, "attaching to domain %d\n",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	ret =
> hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefix);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no IOMMU registration for vPCI
> bus\n");
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain = hv_domain->device_domain;
> +	input->device_id.as_uint64 = (u64)prefix |
> PCI_FUNC(pdev->devfn);
> +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "HVCALL_ATTACH_DEVICE_DOMAIN
> failed\n");
> +	} else {
> +		vdev->hv_domain = hv_domain;
> +
> +		if (domain != &hv_blocking_domain.domain &&
> +		    !pdev->ats_enabled &&
> +		    hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +		    pci_ats_supported(pdev))
> +			pci_enable_ats(pdev, PAGE_SHIFT);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> +					struct device *dev,
> +					struct iommu_domain *old)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =
> to_hv_iommu_domain(domain);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	if (vdev->hv_domain == hv_domain)
> +		return 0;
It may not be needed since the core code will check this. If you keep
this as extra precaution, should this be moved up before ats? since ats
must be disabled already if blocking domain is attached.

> +
> +	ret = hv_iommu_attach_dev(domain, dev, old);
> +
> +	/*
> +	 * Attaching to the blocking domain only asks the hypervisor
> to
> +	 * disable translation and IOPF for the device, so it cannot
> fail
> +	 * unless there is a driver or hypervisor bug. Return the
> hypercall
> +	 * status rather than 0 so that a failure on the DMA
> ownership claim
> +	 * path (VFIO/iommufd) fails the claim instead of leaving
> the device
> +	 * unblocked. WARN since such a failure indicates a bug.
> +	 */
> +	WARN_ON(ret);
> +	return ret;
> +}
> +
> +static int
> +hv_iommu_get_logical_device_property(struct device *dev, u32 code,
> +				     struct
> hv_output_get_logical_device_property *property) +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	int ret;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct hv_input_get_logical_device_property *input;
> +	struct hv_output_get_logical_device_property *output;
> +
> +	ret =
> hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefix);
> +	if (ret)
> +		return ret;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = (struct hv_output_get_logical_device_property
> *)(input + 1);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	input->logical_device_id = (u64)prefix |
> PCI_FUNC(pdev->devfn);
> +	input->code = code;
> +	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY,
> input, output);
> +	*property = *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status,
> +			      "HVCALL_GET_LOGICAL_DEVICE_PROPERTY
> failed\n"); +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property
> device_iommu_property = {0}; +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +
> HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +
> &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu &
> HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev = dev;
> +	vdev->hv_iommu = hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	return pci_device_group(dev);
> +}
> +
> +static int __init hv_initialize_static_domains(void)
> +{
> +	/*
> +	 * Clearing translation_enabled bypasses stage-1
> translation, so DMA
> +	 * addresses are used directly as GPAs. Hyper-V requires
> paging and
> +	 * blocked domains to keep translation_enabled set.
> +	 */
> +	const struct hv_device_domain_settings identity_settings = {
> +		.flags.translation_enabled = 0,
> +	};
> +	const struct hv_device_domain_settings blocked_settings = {
> +		.flags = {
> +			.translation_enabled = 1,
> +			.blocked = 1,
> +		},
> +	};
> +	int ret;
> +
> +	/* Default stage-1 identity domain */
> +	ret = hv_create_configure_device_domain(&hv_identity_domain,
> +						&identity_settings);
> +	if (ret)
> +		return ret;
> +
> +	/* Default stage-1 blocked domain */
> +	ret = hv_create_configure_device_domain(&hv_blocking_domain,
> +						&blocked_settings);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	return 0;
> +
> +delete_identity_domain:
> +	hv_delete_device_domain(&hv_identity_domain);
> +	return ret;
> +}
> +
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
> +					 X86_IOMMU_MSI_RANGE_END -
> +					 X86_IOMMU_MSI_RANGE_START +
> 1,
> +					 0, IOMMU_RESV_MSI,
> GFP_KERNEL);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather
> *iotlb_gather) +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}
> +
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =
> to_hv_iommu_domain(domain); +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);
> +
> +	kfree(hv_domain);
> +}
> +
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
> +	.attach_dev	= hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
> +	.attach_dev	= hv_iommu_blocking_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
> +	.attach_dev	= hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
> +	.iotlb_sync = hv_iommu_iotlb_sync,
> +	.free = hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct
> device *dev) +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_hw_info pt_info;
> +	struct pt_iommu_x86_64_cfg cfg = {};
> +	struct hv_device_domain_settings settings = {
> +		.flags = {
> +			.translation_enabled = 1,
> +		},
> +	};
> +
> +	hv_domain = kzalloc_obj(*hv_domain, GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hv_domain->pt_iommu.nid = dev_to_node(dev);
> +
> +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
> +	cfg.common.hw_max_oasz_lg2 = 52;
> +	/*
> +	 * Hyper-V S1 domains use a 4-level root for IOVA widths up
> to
> +	 * 48 bits. A 5-level root is used only for wider apertures
> when
> +	 * HV_IOMMU_CAP_S1_5LVL is advertised.
> +	 */
> +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 :
> 3; +
> +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64,
> &cfg, GFP_KERNEL);
> +	if (ret)
> +		goto err_free;
> +
> +	/* Constrain to page sizes the hypervisor supports */
> +	hv_domain->domain.pgsize_bitmap &=
> hv_iommu_device->pgsize_bitmap; +
> +	hv_domain->domain.ops = &hv_iommu_paging_domain_ops;
> +
> +	pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64,
> &pt_info);
> +	settings.page_table_root = pt_info.gcr3_pt;
> +	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
> +
> +	ret = hv_create_configure_device_domain(hv_domain,
> &settings);
> +	if (ret)
> +		goto err_pt_deinit;
> +
> +	return &hv_domain->domain;
> +
> +err_pt_deinit:
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +err_free:
> +	kfree(hv_domain);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct iommu_ops hv_iommu_ops = {
> +	.capable		  = hv_iommu_capable,
> +	.domain_alloc_paging	  = hv_iommu_domain_alloc_paging,
> +	.probe_device		  = hv_iommu_probe_device,
> +	.release_device		  = hv_iommu_release_device,
> +	.device_group		  = hv_iommu_device_group,
> +	.get_resv_regions	  = hv_iommu_get_resv_regions,
> +	.owner			  = THIS_MODULE,
> +	.identity_domain	  = &hv_identity_domain.domain,
> +	.blocked_domain		  =
> &hv_blocking_domain.domain,
> +	.release_domain		  =
> &hv_blocking_domain.domain, +};
> +
> +static u64 hv_iommu_detect(struct hv_output_get_iommu_capabilities
> *cap) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = (struct hv_output_get_iommu_capabilities *)(input +
> 1);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES,
> input, output);
> +	*cap = *output;
> +
> +	local_irq_restore(flags);
> +
> +	return status;
> +}
> +
> +static void __init
> +hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +		     struct hv_output_get_iommu_capabilities
> *hv_iommu_cap) +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova
> width to 48.\n");
> +		hv_iommu->max_iova_width = 48;
> +	}
> +
> +	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap;
> +	hv_iommu_device = hv_iommu;
> +}
> +
> +int __init hv_iommu_init(void)
> +{
> +	u64 status;
> +	int ret = 0;
> +	struct hv_iommu_dev *hv_iommu = NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	status = hv_iommu_detect(&hv_iommu_cap);
> +	if (!hv_result_success(status)) {
> +		if (hv_result(status) ==
> HV_STATUS_INVALID_HYPERCALL_CODE)
> +			return -ENODEV;
> +
> +		hv_status_err(status, "HVCALL_GET_IOMMU_CAPABILITIES
> failed\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	if (!hv_iommu_present(hv_iommu_cap.iommu_cap))
> +		return -ENODEV;
> +
> +	if (!hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
> +		pr_err("stage-1 translation not supported:
> cap=%#llx\n",
> +		       hv_iommu_cap.iommu_cap);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Require the base page size. The domain page-size bitmap
> is later
> +	 * restricted to the sizes supported by both iommupt and
> Hyper-V.
> +	 */
> +	if (!(hv_iommu_cap.pgsize_bitmap & PAGE_SIZE)) {
> +		pr_err("unsupported page sizes:
> pgsize_bitmap=0x%llx\n",
> +		       hv_iommu_cap.pgsize_bitmap);
> +		return -ENODEV;
> +	}
> +
> +	iommu_detected = 1;
> +	pci_request_acs();
> +
> +	hv_iommu = kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret = hv_initialize_static_domains();
> +	if (ret)
> +		goto err_free;
> +
> +	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL,
> "%s", "hv-iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_delete_static_domains;
> +	}
> +
> +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops,
> NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("initialized: %u-bit IOVA aperture, page-size bitmap
> %#llx\n",
> +		hv_iommu->max_iova_width, hv_iommu->pgsize_bitmap);
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_delete_static_domains:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +	hv_delete_device_domain(&hv_identity_domain);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> diff --git a/drivers/iommu/hyperv/iommu.h
> b/drivers/iommu/hyperv/iommu.h new file mode 100644
> index 000000000000..a8566d511102
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2024-2025, Microsoft, Inc.
2026?

> + *
> + */
> +
> +#ifndef _HYPERV_IOMMU_H
> +#define _HYPERV_IOMMU_H
> +
> +struct hv_iommu_dev {
> +	struct iommu_device iommu;
> +	struct ida domain_ids;
> +
> +	/* Device configuration */
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 cap;
> +	u64 pgsize_bitmap;
> +
> +	u64 first_domain;
> +	u64 last_domain;
> +};
> +
> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_input_device_domain device_domain;
> +	u64		pgsize_bitmap;
> +};
> +
> +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu, domain);
> +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu_x86_64.iommu,
> domain);
> +struct hv_iommu_endpoint {
> +	struct device *dev;
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_iommu_domain *hv_domain;
> +};
> +
> +#define to_hv_iommu_domain(d) \
> +	container_of(d, struct hv_iommu_domain, domain)
> +
> +#endif /* _HYPERV_IOMMU_H */
With the above nits addressed,

Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

