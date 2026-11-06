Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002063;
	b=HeUzbDl7HnAhZCi7CuIpsldV2Q/j8hp3J8C1BV+v/TyaWhtohO+kzUBks6zZGH61yTbI
	 Nahg/pgMVwH2DtiHdIxCCSIWCMd37tNI4oIj5HTyHoLxikaddZgxnHaoSdhudFgUC9nGh
	 AWFG+J77SIhhLVaJg8EEE/qBeB5dvJdj43yktch3pIZf9hm3pe9oHDeq74yEhGDbAU848
	 QckK9Dw31COgvxyn8pwPN/SIOn1zoP1bUUljR27hf7LBmbWVqVXd0Ujuz4qs6RXodNaCW
	 J3SVY/k1nkdpBN0VPkIh97fPa9a+7dKiqcdSd0fSN5uWyvu+D/HPNOuARfusUi2VNTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002063;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=yyG3/C4sSe8q2vVSmzW+YYQuFCTp/2rYI6RLncmBMUU=;
	b=4VNPnn3/s6BfngR2be3KsFzm338G+0trmjNzUckO1n2wE0CLvIv5hjF+W+bRt6tt3V37
	 K6mvQWQoDcEUoG8Q8OD6MFPH+vMtEneGS4nZ5XAhPZnKC5nFoj1+Qku7pdj8z/g1A/hUm
	 0t941xb32c58qupnjtHOdVm+TxfZRojg5QApv5rkxjYQp5vbQhMVdkTmn7RQGOQxcg3MW
	 Dp22eyiPStYzhc+9w7yNuxXI0V632jZJZvJiogNctyQo8zutnnFEsH5CLsF/XQoOxUli1
	 toZXVvhe1vno4AIA70Wv+yUcFpp9gN0PeNLpyDtP2CVMbKB4LHbH7MuyvYcMlo/VVfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="luEF/yXr";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBB606A32C;
	Fri,  6 Nov 2026 21:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EBB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=luEF/yXr
Received: from [100.64.128.135] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id A0FDB20B7167;
	Fri,  6 Nov 2026 13:54:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0FDB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794002061;
	bh=yyG3/C4sSe8q2vVSmzW+YYQuFCTp/2rYI6RLncmBMUU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=luEF/yXrwfgOgHbmvsqs5naNWzhoye+JTvtwt5YlcXWkjERc6MzQj+RrweFxVVYgp
	 +XtNj9+1OQrk1TWotNYjRmvovsu59l3jwI7JVs+IMiYyriyINi+vUv83dQniS0yxNM
	 1EG9Jn7YwUM4Pz/rp+utLgm3lGWzemkxPo83FDKg=
Message-ID: <f2579646-7f77-4dd2-b7ce-ccf702828610@linux.microsoft.com>
Date: Fri, 6 Nov 2026 13:54:19 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU kernel
 only driver
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-6-mrathor@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105020106.3496339-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 18:01, Mukesh R wrote:
> Add a new file to implement a kernel only virtual IOMMU that works
> on Microsoft Hyper-V hypervisor (aka MSHV) in privileged VMs aka
> root VMs. The hypervisor claims the IOMMU upon boot, and this driver
> communicates with it for creating and deleting paging domains, attaching
> of devices, mapping and unmapping of pages, etc. During boot, hypervisor
> automatically creates identity and blocked domains, so there is no need
> to do hypercalls to create them. This is a kernel only driver and only
> supported on baremetal root (and not L1VH root) without any guest passthru
> support. Support for guest device passthru will be added incrementally.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/kernel/pci-dma.c            |   2 +
>  drivers/iommu/hyperv/Kconfig         |  13 +
>  drivers/iommu/hyperv/Makefile        |   1 +
>  drivers/iommu/hyperv/hv-iommu-root.c | 613 +++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h       |   3 +
>  include/linux/hyperv.h               |   6 +
>  6 files changed, 638 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
> 

<snip>

>  obj-$(CONFIG_HYPERV_PVIOMMU) += hv-iommu-guest.o
> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
> new file mode 100644
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
> + *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
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

Seems like this could match the guest driver and just be: return cap == IOMMU_CAP_CACHE_COHERENCY.

<snip>

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
> +	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
> +
> +	hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
> +	hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
> +	hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
> +	hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
> +}
> +

A net negative 9 lines to initialize these with .field notation, as suggested in v0: https://lore.kernel.org/all/4f7cadc5-817c-4163-bac8-1c02a7c6a862@linux.microsoft.com/

Wasn't super hard to do the 1 forward declaration needed...

diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
index e0e3e9d4385e2..4e6bf94413458 100644
--- a/drivers/iommu/hyperv/hv-iommu-root.c
+++ b/drivers/iommu/hyperv/hv-iommu-root.c
@@ -12,6 +12,7 @@
 #include "../dma-iommu.h"
 
 static dma_addr_t hv_iommu_max_iova;
+static struct iommu_ops hv_iommu_ops;
 static struct iommu_domain_ops hv_paging_domain_ops;
 
 /* IOMMU device that we export to the world. MSHV supports max of one */
@@ -32,23 +33,6 @@ struct hv_iommu_mapping {
 	u32 flags;
 };
 
-/*
- * By default, during boot the hypervisor creates one Stage 2 (S2) default
- * domain. It has two types:
- *   S2 default: access to entire root partition memory. This for the host
- *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
- *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
- *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
- *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
- */
-
-/*
- * Create dummy domains to correspond to hypervisor prebuilt default identity
- * and null domains (dummy because we do not make hypercalls to create them).
- */
-static struct hv_iommu_domain hv_def_identity_dom;
-static struct hv_iommu_domain hv_def_blocked_dom;
-
 /*
  * The hypervisor owns the IOMMU. As such it will choose the best page size
  * and whenever possible use larger page sizes automatically. The map gpa
@@ -488,6 +472,35 @@ static void hv_iommu_get_resv_regions(struct device *dev,
 	iommu_add_resv_x86_msi_region(head);
 }
 
+static const struct iommu_domain_ops hv_special_domain_ops = {
+	.attach_dev = hv_iommu_attach_dev,
+};
+
+/*
+ * By default, during boot the hypervisor creates one Stage 2 (S2) default
+ * domain. It has two types:
+ *   S2 default: access to entire root partition memory. This for the host
+ *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
+ *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
+ *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
+ *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
+ * Create dummy domains to correspond to hypervisor prebuilt default identity
+ * and null domains (dummy because we do not make hypercalls to create them).
+ */
+static struct hv_iommu_domain hv_def_identity_dom = {
+	.iommu_dom.type = IOMMU_DOMAIN_IDENTITY,
+	.iommu_dom.ops = &hv_special_domain_ops,
+	.iommu_dom.owner = &hv_iommu_ops,
+	.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT, /* 0 */
+};
+
+static struct hv_iommu_domain hv_def_blocked_dom = {
+	.iommu_dom.type = IOMMU_DOMAIN_BLOCKED,
+	.iommu_dom.ops = &hv_special_domain_ops,
+	.iommu_dom.owner = &hv_iommu_ops,
+	.domid_num = HV_DEVICE_DOMAIN_ID_NULL,    /* INTMAX */
+};
+
 static struct iommu_domain_ops hv_paging_domain_ops = {
 	.attach_dev = hv_iommu_attach_dev,
 	.map_pages = hv_iommu_map_pages,
@@ -508,23 +521,6 @@ static struct iommu_ops hv_iommu_ops = {
 	.release_domain     = &hv_def_blocked_dom.iommu_dom,
 };
 
-static const struct iommu_domain_ops hv_special_domain_ops = {
-	.attach_dev = hv_iommu_attach_dev,
-};
-
-static void __init hv_initialize_special_domains(void)
-{
-	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
-	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
-	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
-	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
-
-	hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
-	hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
-	hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
-	hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
-}
-
 /*
  * In general, the hypervisor does not support the capabilities hypercall for
  * root partitions, an exception was made for max_iova_width. For IOMMU cap,
@@ -571,11 +567,6 @@ static int __init hv_root_iommu_init(void)
 
 	hv_iommu_max_iova = DMA_BIT_MASK(caps.max_iova_width);
 
-	/* This must come before iommu_device_register() because the latter
-	 * calls into the hooks.
-	 */
-	hv_initialize_special_domains();
-
 	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
 	if (rc) {
 		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);


<snip>

Thanks,
Easwar (he/him)
