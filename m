Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377962;
	b=ZgVCdgAPD2XvkRFJ3aOVlhcGjQETaxxhatF9KJHq52nMSzD79fD2oHGjCm/K4NwylYQS
	 p/XGAyhnqMDPYXdTiG0gkRdtLNUOUnczbNMbVuw+m2UEK/n/wpWJITNv5+McXxTjUO8lU
	 dfS4+RhWn15orLF12E6zNnbiVqrn4yArC4kdhsI1RfgPyMNW9U27AQouexd5E0QFiWQIz
	 Mw4EmyVrNEztyFCu3jWteKrj/qTcbRLUWKprlHwTu22mZMBNw7SVrVlLjdP2a+x8IZzKP
	 6fwUSlZi5XFbLfNQaAzNEFfcNZ4OxLjnXLrqLtNS0mXPg+I23gqaP5QIR8e3SAWKtdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377962;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=FMEwmBkQndICakuCevOg7NjuCq3ZeSX3FR1RZ51o3Ss=;
	b=vLztWJJn8iDEERS4L/b4Qd2WHUEUlmFjA1FEnHt+4rWQXW7fUggzYUAf+83nrBKeKtUg
	 ZtgqqAOphryunREszWQEHuFBxarhzBTn00I+XoqQmAo67iZeEyPDOsa5LP3j2nipBSdP6
	 sla8U8QRlg073yCZKd7EoSLq+QcU+dq87snIarpZ95xwptv3zNUyWUiX03dhcS5znqhYO
	 f8LWcjh2CKKugdm6jnibemqNK2VrYh5Y+1P6RK3Z7qvK/a6roNtFqB1kil3NyzyS5yvwu
	 ndGbyDKiE7AQpJ5Ll9yRSzVQnEssJXtuemBOT0ZiTVjyVsvXzgkNfeO7Zld4lTjzh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iifJERn7;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E091606A326;
	Wed, 11 Nov 2026 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E091606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iifJERn7
Received: from localhost (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24D3120B7168;
	Tue, 10 Nov 2026 22:19:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24D3120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794377957;
	bh=FMEwmBkQndICakuCevOg7NjuCq3ZeSX3FR1RZ51o3Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iifJERn7Lzk46rS5hTgy/x0HfWbhdfmDkHliezKtR8jXduPUtCd3x38WL/JMtkWNk
	 fkk3wHu5Rzu5Jod0hPU5rpoUwZjJW91AAPPdzHYXOZrKQoBIBxvgdCjRm26bqDJoLg
	 fKklJLhKBdDcu0M7429o6erb+LFLviXSwGn7YQqc=
Date: Tue, 10 Nov 2026 22:19:05 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU
 kernel only driver
Message-ID: <20261110221905.000009e2@linux.microsoft.com>
In-Reply-To: <20261105020106.3496339-6-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
	<20261105020106.3496339-6-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

On Wed,  4 Nov 2026 18:01:06 -0800
Mukesh R <mrathor@linux.microsoft.com> wrote:

> Add a new file to implement a kernel only virtual IOMMU that works
> on Microsoft Hyper-V hypervisor (aka MSHV) in privileged VMs aka
> root VMs. The hypervisor claims the IOMMU upon boot, and this driver
> communicates with it for creating and deleting paging domains,
> attaching of devices, mapping and unmapping of pages, etc. During
> boot, hypervisor automatically creates identity and blocked domains,
> so there is no need to do hypercalls to create them. This is a kernel
> only driver and only supported on baremetal root (and not L1VH root)
> without any guest passthru support. Support for guest device passthru
> will be added incrementally.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/kernel/pci-dma.c            |   2 +
>  drivers/iommu/hyperv/Kconfig         |  13 +
>  drivers/iommu/hyperv/Makefile        |   1 +
>  drivers/iommu/hyperv/hv-iommu-root.c | 613
> +++++++++++++++++++++++++++ include/asm-generic/mshyperv.h       |
> 3 + include/linux/hyperv.h               |   6 +
>  6 files changed, 638 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
>=20
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 75cf8f6ae8cd..560d8a4f6e1d 100644
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
> @@ -103,6 +104,7 @@ void __init pci_iommu_alloc(void)
>  	gart_iommu_hole_init();
>  	amd_iommu_detect();
>  	detect_intel_iommu();
> +	hv_root_iommu_detect();
>  	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
>  }
> =20
> diff --git a/drivers/iommu/hyperv/Kconfig
> b/drivers/iommu/hyperv/Kconfig index f2f993f647c3..6ba5125ed501 100644
> --- a/drivers/iommu/hyperv/Kconfig
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -13,3 +13,16 @@ config HYPERV_PVIOMMU
>  	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
>  	  flush support to enable DMA isolation for PCI devices
>  	  assigned to the guest.
> +
> +config HYPERV_ROOT_IOMMU
> +	bool "Hyper-V IOMMU Device in root partition"
> +	depends on HYPERV && X86 && PCI_MSI && MSHV_ROOT
What requires =A0PCI_MSI=A0 here?

> +	select IOMMU_API
> +	default HYPERV
> +	help
> +	  This enables Hyper-V pseudo IOMMU device. When running as
> privileged
> +	  VM aka root on Microsoft Hyper-V hypervisor, this must be
> enabled
> +	  for doing any PCI passthru of devices to guest VMs. This
> applies to
> +	  both PFs and VFs. When enabling this, it is best to
> disable amd/intel
> +	  iommus via: intel_iommu=3Doff amd_iommu=3Doff as the
> hypervisor really
> +	  owns the iommu.
> diff --git a/drivers/iommu/hyperv/Makefile
> b/drivers/iommu/hyperv/Makefile index d3b2a259439c..04c66b4409a3
> 100644 --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IRQ_REMAP) +=3D hv-irq-remap-x86.o
>  obj-$(CONFIG_HYPERV_PVIOMMU) +=3D hv-iommu-guest.o
> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) +=3D hv-iommu-root.o
> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c
> b/drivers/iommu/hyperv/hv-iommu-root.c new file mode 100644
> index 000000000000..e0e3e9d4385e
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,613 @@
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
I don't think we need it, virtio iommu driver calls
iommu_dma_get_resv_regions() but hv does not.

> +static dma_addr_t hv_iommu_max_iova;
> +static struct iommu_domain_ops hv_paging_domain_ops;
> +
> +/* IOMMU device that we export to the world. MSHV supports max of
> one */ +static struct iommu_device hv_virt_iommu;
> +
> +struct hv_iommu_domain {
> +	struct iommu_domain iommu_dom;
> +	u32 domid_num;			      /* as opposed to
> domain_id.type */
> +	spinlock_t mappings_lock;	      /* protects
> mappings_tree */
> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup
> tree */ +};
> +
> +#define to_hv_domain(d) container_of(d, struct hv_iommu_domain,
> iommu_dom) +
> +struct hv_iommu_mapping {
> +	phys_addr_t paddr;
> +	struct interval_tree_node iova;
> +	u32 flags;
> +};
> +
> +/*
> + * By default, during boot the hypervisor creates one Stage 2 (S2)
> default
> + * domain. It has two types:
> + *   S2 default: access to entire root partition memory. This for
> the host
> + *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu
> subsystem, and
> + *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the
> hypervisor.
> + *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
> + *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
> + */
> +
> +/*
> + * Create dummy domains to correspond to hypervisor prebuilt default
> identity
> + * and null domains (dummy because we do not make hypercalls to
> create them).
> + */
> +static struct hv_iommu_domain hv_def_identity_dom;
> +static struct hv_iommu_domain hv_def_blocked_dom;
> +
> +/*
> + * The hypervisor owns the IOMMU. As such it will choose the best
> page size
> + * and whenever possible use larger page sizes automatically. The
> map gpa
> + * hypercall to map the iova however currently uses only 4K pfns as
> input.
> + * So we specify 4K as the IOMMU PAGE_SIZE.
> + */
> +#define HV_IOMMU_PGSIZES SZ_4K
> +
> +static DEFINE_IDA(hv_iommu_domids);   /* unique numeric ids for new
> domains */ +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
Maybe add a comment here to explain it is true for x86_64 mshv
platforms, but need to be revisited if this driver expands to other
architectures.

> +	default:
> +		return false;
> +	}
> +}
> +
> +static int hv_iommu_add_tree_mapping(struct hv_iommu_domain *hvdom,
> ulong iova,
> +				     phys_addr_t paddr, size_t size,
> u32 flags,
> +				     gfp_t gfp)
> +{
> +	ulong irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping =3D kzalloc_obj(struct hv_iommu_mapping, gfp);
> +	if (!mapping)
> +		return -ENOMEM;
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
> +/* If both size and iova are 0, then last =3D ULONG_MAX will remove
> everything */ +static size_t hv_iommu_del_tree_mappings(struct
> hv_iommu_domain *hvdom,
> +					 ulong iova, size_t size)
> +{
> +	ulong flags;
> +	size_t unmapped =3D 0;
> +	ulong last =3D iova + size - 1;
> +	struct hv_iommu_mapping *mapping =3D NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
nit: use scoped_guard(spinlock_irqsave, &hvdom->mappings_lock) ?

> +	next =3D interval_tree_iter_first(&hvdom->mappings_tree, iova,
> last);
> +	while (next) {
> +		node =3D next;
> +		mapping =3D container_of(node, struct
> hv_iommu_mapping, iova);
> +		next =3D interval_tree_iter_next(node, iova, last);
> +
> +		/* Splitting of a mapping is not supported at
> present */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped +=3D mapping->iova.last - mapping->iova.start
> + 1; +
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
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	ddp =3D &input->device_domain;
> +	ddp->partition_id =3D HV_PARTITION_ID_SELF;
> +	ddp->domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	ddp->domain_id.id =3D hvdom->domid_num;
> +
> +	input->create_device_domain_flags.forward_progress_required
> =3D 1;
> +	input->create_device_domain_flags.inherit_owning_vtl =3D 0;
> +
> +	status =3D hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct
> device *dev) +{
> +	struct hv_iommu_domain *hvdom;
> +	int rc;
> +
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	hvdom =3D kzalloc_obj(struct hv_iommu_domain);
> +	if (hvdom =3D=3D NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree =3D RB_ROOT_CACHED;
> +
> +	rc =3D ida_alloc_range(&hv_iommu_domids,
> +			     HV_DEVICE_DOMAIN_ID_DEFAULT + 1,
> +			     HV_DEVICE_DOMAIN_ID_NULL - 1,
> GFP_KERNEL);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	hvdom->domid_num =3D rc;
> +	hvdom->iommu_dom.pgsize_bitmap =3D HV_IOMMU_PGSIZES;
> +	hvdom->iommu_dom.geometry.aperture_start =3D 0;
> +	hvdom->iommu_dom.geometry.aperture_end =3D hv_iommu_max_iova;
> +	hvdom->iommu_dom.geometry.force_aperture =3D true;
> +	hvdom->iommu_dom.ops =3D &hv_paging_domain_ops;
> +
> +	rc =3D hv_iommu_create_hyp_devdom(hvdom);
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
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +
> +	/* Cleanup any remaining. 0 for size results in ULONG_MAX as
> the last */
> +	hv_iommu_del_tree_mappings(hvdom, 0, 0);
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	ddp =3D &input->device_domain;
> +	memset(input, 0, sizeof(*input));
> +
> +	ddp->partition_id =3D HV_PARTITION_ID_SELF;
> +	ddp->domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	ddp->domain_id.id =3D hvdom->domid_num;
> +
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
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
> + * Attach a device to the default domain, or the null domain, or to
> a domain
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
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	/* For null domain, hvdom->domid_num =3D=3D
> HV_DEVICE_DOMAIN_ID_NULL */
> +	input->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type =3D
> HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D hvdom->domid_num;
> +
> +	input->device_id.as_uint64 =3D hv_build_devid_type_pci(pdev);
> +
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input,
> NULL);
> +	local_irq_restore(flags);
> +
> +	if (hv_result_success(status) ||
> +	    hv_result(status) =3D=3D HV_STATUS_DEVICE_ALREADY_IN_DOMAIN)
> +		return 0;
> +
> +	hv_status_err(status, "\n");
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct
> device *dev,
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
> +		WARN(1, "Failed to attach pdev:%s\n",
> pci_name(pdev)); +
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
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	input->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_domain.domain_id.type =3D
> HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D domid_num;
> +	input->target_device_va_base =3D iova;
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES,
> count,
> +				     0, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "iova:0x%lx count:0x%x\n",
> iova, count); +
> +	return status;
> +}
> +
> +static size_t hv_iommu_hyp_unmap_pages(struct iommu_domain *immdom,
> ulong iova,
> +				       size_t size)
> +{
> +	u64 status;
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t tot_done =3D 0;
> +	ulong npages =3D size >> HV_HYP_PAGE_SHIFT;
> +
> +	while (npages) {
> +		int done, count =3D min(npages, HV_REP_COUNT_MAX);
> +
> +		status =3D hv_iommu_unmap_batch(hvdom->domid_num,
> iova, count); +
> +		done =3D hv_repcomp(status);
> +		tot_done +=3D done;
> +		npages -=3D done;
> +		iova +=3D done << HV_HYP_PAGE_SHIFT;
> +
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	return tot_done << HV_HYP_PAGE_SHIFT;
> +}
> +
> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom,
> ulong iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t unmap_sz, size =3D pgsize * pgcount;
> +
> +	/* For valid input, the hypervisor guarantees unmap will
> succeed */
> +	unmap_sz =3D hv_iommu_hyp_unmap_pages(immdom, iova, size);
> +	if (unmap_sz !=3D size)
> +		WARN(1, "Failed to unmap device gpa(%lx/%lx)\n",
> unmap_sz,
> +		     size);
> +
> +	if (unmap_sz =3D=3D 0)
> +		return 0;
> +
> +	size =3D hv_iommu_del_tree_mappings(hvdom, iova, unmap_sz);
> +	if (size !=3D unmap_sz)
> +		pr_err("%s: could not delete tree mappings
> (%lx:%lx/%lx)\n",
> +		       __func__, iova, unmap_sz, size);
> +
> +	return size;
> +}
> +
> +/* Return: must return exact status from the hypercall without
> changes */ +static u64 hv_iommu_map_pgs(struct hv_iommu_domain
> *hvdom, ulong iova,
> +			    phys_addr_t paddr, ulong npages, u32
> map_flags) +{
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
> +	input->device_domain.domain_id.type =3D
> HV_DEVICE_DOMAIN_TYPE_S2;
> +	input->device_domain.domain_id.id =3D hvdom->domid_num;
> +	input->map_flags =3D map_flags;
> +	input->target_device_va_base =3D iova;
> +
> +	pfn =3D paddr >> HV_HYP_PAGE_SHIFT;
> +	for (i =3D 0; i < npages; i++, pfn++)
> +		input->gpa_page_list[i] =3D pfn;
> +
> +	status =3D hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES,
> npages, 0,
> +				     input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status) &&
> !hv_result_needs_memory(status))
> +		hv_status_err(status, "npgs:%lx paddr:%llx iova:%lx
> mf:0x%x\n",
> +			      npages, paddr, iova, map_flags);
> +	return status;
> +}
> +
> +#define HV_MAP_DEVICE_GPA_BATCH_SIZE   \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct
> hv_input_map_device_gpa_pages)) \
> +			/ sizeof(u64))
> +
> +/* NB: cond_resched() is in vfio_iommu_map() */
map_pages()=A0 is not VFIO-specific, so it cannot depend on
vfio_iommu_map()=A0 providing scheduling points. This comment is not
relevant.

> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong
> iova,
> +			      phys_addr_t paddr, size_t pgsize,
> size_t pgcount,
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
Why required? If the core asks for write-only, this still grant read
access? VT-d S2 PTE has separate R W bits.

Maybe reject write-only if mshv cannot handle it.
if ((prot & IOMMU_WRITE) && !(prot & IOMMU_READ))
    return -EINVAL;

> +	map_flags |=3D prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
> +
> +	ret =3D hv_iommu_add_tree_mapping(hvdom, iova, paddr, size,
> map_flags,
> +					gfp);
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
> +			ret =3D
> hv_deposit_memory_gfp(hv_current_partition_id,
> +						    status, gfp);
> +			if (ret)
> +				break;
> +			continue;
> +		}
> +		if (!hv_result_success(status))
> +			break;
> +	}
> +
> +	if (ret =3D=3D 0)
> +		ret =3D hv_result_to_errno(status);
> +
> +	if (hv_result_success(status)) {
> +		if (mapped)
> +			*mapped =3D size;
> +	} else {
> +		size_t done_size =3D done << HV_HYP_PAGE_SHIFT;
> +
> +		hv_status_err(status, "pgs:%lx/%lx iova:%lx\n",
> done, npages,
> +			      sav_iova);
> +
> +		hv_iommu_del_tree_mappings(hvdom, sav_iova, size);
> +
> +		/* Hypervisor guarantees unmap will succeed here */
> +		hv_iommu_hyp_unmap_pages(immdom, sav_iova,
> done_size); +
> +		if (mapped)
> +			*mapped =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static phys_addr_t hv_iommu_iova_to_phys(struct iommu_domain *immdom,
> +					 dma_addr_t iova)
> +{
> +	unsigned long flags;
> +	struct hv_iommu_mapping *mapping;
> +	struct interval_tree_node *node;
> +	u64 paddr =3D 0;
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
 guard(spinlock_irqsave)(&hvdom->mappings_lock);
some other places too.

> +	node =3D interval_tree_iter_first(&hvdom->mappings_tree, iova,
> iova);
> +	if (node) {
> +		mapping =3D container_of(node, struct
> hv_iommu_mapping, iova);
> +		paddr =3D mapping->paddr + (iova -
> mapping->iova.start);
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
> +	iommu_add_resv_x86_msi_region(head);
> +}
> +
> +static struct iommu_domain_ops hv_paging_domain_ops =3D {
> +	.attach_dev =3D hv_iommu_attach_dev,
> +	.map_pages =3D hv_iommu_map_pages,
> +	.unmap_pages =3D hv_iommu_unmap_pages,
> +	.iova_to_phys =3D hv_iommu_iova_to_phys,
> +	.free =3D hv_iommu_domain_free,
> +};
> +
> +static struct iommu_ops hv_iommu_ops =3D {
> +	.capable	    =3D hv_iommu_capable,
> +	.domain_alloc_paging	=3D hv_iommu_domain_alloc_paging,
> +	.probe_device	    =3D hv_iommu_probe_device,
> +	.device_group	    =3D pci_device_group,
> +	.get_resv_regions   =3D hv_iommu_get_resv_regions,
> +	.owner		    =3D THIS_MODULE,
> +	.identity_domain    =3D &hv_def_identity_dom.iommu_dom,
> +	.blocked_domain     =3D &hv_def_blocked_dom.iommu_dom,
> +	.release_domain     =3D &hv_def_blocked_dom.iommu_dom,
> +};
> +
> +static const struct iommu_domain_ops hv_special_domain_ops =3D {
> +	.attach_dev =3D hv_iommu_attach_dev,
> +};
> +
> +static void __init hv_initialize_special_domains(void)
> +{
> +	hv_def_identity_dom.iommu_dom.type =3D IOMMU_DOMAIN_IDENTITY;
> +	hv_def_identity_dom.iommu_dom.ops =3D &hv_special_domain_ops;
> +	hv_def_identity_dom.iommu_dom.owner =3D &hv_iommu_ops;
> +	hv_def_identity_dom.domid_num =3D HV_DEVICE_DOMAIN_ID_DEFAULT;
> /* 0 */ +
> +	hv_def_blocked_dom.iommu_dom.type =3D IOMMU_DOMAIN_BLOCKED;
> +	hv_def_blocked_dom.iommu_dom.ops =3D &hv_special_domain_ops;
> +	hv_def_blocked_dom.iommu_dom.owner =3D &hv_iommu_ops;
> +	hv_def_blocked_dom.domid_num =3D HV_DEVICE_DOMAIN_ID_NULL;
> /* INTMAX */ +}
> +
> +/*
> + * In general, the hypervisor does not support the capabilities
> hypercall for
> + * root partitions, an exception was made for max_iova_width. For
> IOMMU cap,
> + * hv_root_iommu_detect() below checks for
> HV_DEVICE_DOMAIN_AVAILABLE which
> + * supersedes HV_IOMMU_CAP_PRESENT. As for the pgsize_bitmap cap,
> see comment
> + * above HV_IOMMU_PGSIZES.
> + */
> +static int hv_iommu_get_caps(struct hv_output_get_iommu_capabilities
Should be __init since it is only called by a __init function?

> *caps) +{
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
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES,
> input, output);
> +	*caps =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_root_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup =3D &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc =3D hv_iommu_get_caps(&caps);
> +	if (rc)
> +		return rc;
> +
> +	hv_iommu_max_iova =3D DMA_BIT_MASK(caps.max_iova_width);
> +
> +	/* This must come before iommu_device_register() because the
> latter
> +	 * calls into the hooks.
> +	 */
> +	hv_initialize_special_domains();
> +
> +	rc =3D iommu_device_sysfs_add(iommup, NULL, NULL, "%s",
> "hyperv-iommu");
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_sysfs_add failed:
> %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc =3D iommu_device_register(iommup, &hv_iommu_ops, NULL);
> +	if (rc) {
> +		pr_err("Hyper-V: iommu_device_register failed:
> %d\n", rc);
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
> +void __init hv_root_iommu_detect(void)
> +{
> +	if (no_iommu || iommu_detected || hv_l1vh_partition())
> +		return;
> +
> +	/* This is set for root partitions only, it is never set for
> non-root */
> +	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
> +		return;
> +
> +	iommu_detected =3D 1;
> +	x86_init.iommu.iommu_init =3D hv_root_iommu_init;
> +
> +	pci_request_acs();
> +}
> diff --git a/include/asm-generic/mshyperv.h
> b/include/asm-generic/mshyperv.h index 2584e693d7b3..ad02d6956ae3
> 100644 --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
> =20
>  #define VTPM_BASE_ADDRESS 0xfed40000
> =20
> +#define HV_REP_COUNT_MAX        \
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
> +
>  enum hv_partition_type {
>  	HV_PARTITION_TYPE_GUEST,
>  	HV_PARTITION_TYPE_ROOT,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index e85a1a043eac..8aa752e8c4e1 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1823,4 +1823,10 @@ static inline unsigned long virt_to_hvpfn(void
> *addr) #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
>  #define page_to_hvpfn(page)	(page_to_pfn(page) *
> NR_HV_HYP_PAGES_IN_PAGE)=20
> +#ifdef CONFIG_HYPERV_ROOT_IOMMU
> +void __init hv_root_iommu_detect(void);
> +#else
> +static inline void hv_root_iommu_detect(void) { }
nit: add __init to be consistent? also it may save memory if the stub
is not empty in the future.

With above addressed,
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

> +#endif /* CONFIG_HYPERV_ROOT_IOMMU */
> +
>  #endif /* _HYPERV_H */

