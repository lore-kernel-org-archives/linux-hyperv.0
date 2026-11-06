Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008353;
	b=SRWjp4FDASC4VYCqe3ABfZr674CYfit/Rp5jzSTIDI1816w3EtVYJDsbyWJjMPJ5fovg
	 t34e4wTNY/C50OSDuy67FrFMyapScr9ImyrFUqVT6PPPa45eJDHizFmssPzt72gFpUkY+
	 /gaON85PLTYpCGYt3U/TKoXwU9+Ecqv6vp8steNCDHFS+q7dR4gjEidqXzNh8kuTKcmk5
	 wc8lqcfWNKzmzr7kuhumA5niLAv3mSkqHI3ZHF5MyX3b+AanEoRva6YYZhwYTn9Bcd/xY
	 msAI74kdZrGkglmQtwfiOqqDJUYVF/w1Y2ancCrZqpgMWyh6BKXYueWnbeKwn2CtNNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008353;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=dSVjWjVS37eJkJx4AfljuSAWmmeX+B1EZDTjXdnakOc=;
	b=qJ6QikJpdZFWY4xvNJWXRXxJBzlnqVVQPs8XW2oXr0QuhVUw4nMUnzvpvQ0/dRdZHSEv
	 KQ3KeYe34lI7Njhr4BSmUFOPQN0AEqz57BkcpN+tpxehSmh70QxUlesvvVeC/UUR+gFwx
	 ygsStsYiLo5HvmhBcVC95n1qMcMif1tQUynZTEUO8az0ZIQUayMxQQFUnN8tOW2ZBqij7
	 3DlP4BhLkmBx5Qotg8jK7GeuvyOjAaPxt+oEFUJaFR3JUohw4Q5mOR9D/r8i5wTwfLvpH
	 Mtja5DhONjDfVybnppuuaSxnVVnD1Izn4jEgoojZbvERRu2aGA4WwtgH5EC919OyQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ND4TOGV+;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B914606A326;
	Fri,  6 Nov 2026 23:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B914606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ND4TOGV+
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5796E20B7167;
	Fri,  6 Nov 2026 15:39:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5796E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794008351;
	bh=dSVjWjVS37eJkJx4AfljuSAWmmeX+B1EZDTjXdnakOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ND4TOGV+aGqUZOIj4OZuLSw3/mcPp20ktiiySs5dmViHZrnrkFLlndkSgmvQZEnx5
	 C2qv4cxIsY0feeBoqqIDewz9wKTObvwNYTaQLJRIVNIL0H9yDiVCeDUUDFdPR0C5Is
	 vRGSTEFfhUwgvzlVybkZUvTL/GAyNtmS3T43/T8U=
Message-ID: <9d010202-39e4-c424-3a40-0d37b62b17fd@linux.microsoft.com>
Date: Fri, 6 Nov 2026 15:39:10 -0800
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
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU kernel
 only driver
Content-Language: en-US
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-6-mrathor@linux.microsoft.com>
 <f2579646-7f77-4dd2-b7ce-ccf702828610@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <f2579646-7f77-4dd2-b7ce-ccf702828610@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 13:54, Easwar Hariharan wrote:
> On 11/4/2026 18:01, Mukesh R wrote:
>> Add a new file to implement a kernel only virtual IOMMU that works
>> on Microsoft Hyper-V hypervisor (aka MSHV) in privileged VMs aka
>> root VMs. The hypervisor claims the IOMMU upon boot, and this driver
>> communicates with it for creating and deleting paging domains, attaching
>> of devices, mapping and unmapping of pages, etc. During boot, hypervisor
>> automatically creates identity and blocked domains, so there is no need
>> to do hypercalls to create them. This is a kernel only driver and only
>> supported on baremetal root (and not L1VH root) without any guest passthru
>> support. Support for guest device passthru will be added incrementally.
>>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   arch/x86/kernel/pci-dma.c            |   2 +
>>   drivers/iommu/hyperv/Kconfig         |  13 +
>>   drivers/iommu/hyperv/Makefile        |   1 +
>>   drivers/iommu/hyperv/hv-iommu-root.c | 613 +++++++++++++++++++++++++++
>>   include/asm-generic/mshyperv.h       |   3 +
>>   include/linux/hyperv.h               |   6 +
>>   6 files changed, 638 insertions(+)
>>   create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
>>
> 
> <snip>
> 
>>   obj-$(CONFIG_HYPERV_PVIOMMU) += hv-iommu-guest.o
>> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
>> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
>> new file mode 100644
>> index 000000000000..e0e3e9d4385e
>> --- /dev/null
>> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
>> @@ -0,0 +1,613 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Hyper-V root vIOMMU driver.
>> + * Copyright (C) 2026, Microsoft, Inc.
>> + */
>> +#include <linux/pci.h>
>> +#include <linux/dma-map-ops.h>
>> +#include <linux/interval_tree.h>
>> +#include <linux/hyperv.h>
>> +#include <asm/iommu.h>
>> +#include <asm/mshyperv.h>
>> +#include "../dma-iommu.h"
>> +
>> +static dma_addr_t hv_iommu_max_iova;
>> +static struct iommu_domain_ops hv_paging_domain_ops;
>> +
>> +/* IOMMU device that we export to the world. MSHV supports max of one */
>> +static struct iommu_device hv_virt_iommu;
>> +
>> +struct hv_iommu_domain {
>> +	struct iommu_domain iommu_dom;
>> +	u32 domid_num;			      /* as opposed to domain_id.type */
>> +	spinlock_t mappings_lock;	      /* protects mappings_tree */
>> +	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
>> +};
>> +
>> +#define to_hv_domain(d) container_of(d, struct hv_iommu_domain, iommu_dom)
>> +
>> +struct hv_iommu_mapping {
>> +	phys_addr_t paddr;
>> +	struct interval_tree_node iova;
>> +	u32 flags;
>> +};
>> +
>> +/*
>> + * By default, during boot the hypervisor creates one Stage 2 (S2) default
>> + * domain. It has two types:
>> + *   S2 default: access to entire root partition memory. This for the host
>> + *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
>> + *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
>> + *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
>> + *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
>> + */
>> +
>> +/*
>> + * Create dummy domains to correspond to hypervisor prebuilt default identity
>> + * and null domains (dummy because we do not make hypercalls to create them).
>> + */
>> +static struct hv_iommu_domain hv_def_identity_dom;
>> +static struct hv_iommu_domain hv_def_blocked_dom;
>> +
>> +/*
>> + * The hypervisor owns the IOMMU. As such it will choose the best page size
>> + * and whenever possible use larger page sizes automatically. The map gpa
>> + * hypercall to map the iova however currently uses only 4K pfns as input.
>> + * So we specify 4K as the IOMMU PAGE_SIZE.
>> + */
>> +#define HV_IOMMU_PGSIZES SZ_4K
>> +
>> +static DEFINE_IDA(hv_iommu_domids);   /* unique numeric ids for new domains */
>> +
>> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
>> +{
>> +	switch (cap) {
>> +	case IOMMU_CAP_CACHE_COHERENCY:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
> 
> Seems like this could match the guest driver and just be: return cap == IOMMU_CAP_CACHE_COHERENCY.
> 
> <snip>
> 
>> +
>> +static struct iommu_domain_ops hv_paging_domain_ops = {
>> +	.attach_dev = hv_iommu_attach_dev,
>> +	.map_pages = hv_iommu_map_pages,
>> +	.unmap_pages = hv_iommu_unmap_pages,
>> +	.iova_to_phys = hv_iommu_iova_to_phys,
>> +	.free = hv_iommu_domain_free,
>> +};
>> +
>> +static struct iommu_ops hv_iommu_ops = {
>> +	.capable	    = hv_iommu_capable,
>> +	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
>> +	.probe_device	    = hv_iommu_probe_device,
>> +	.device_group	    = pci_device_group,
>> +	.get_resv_regions   = hv_iommu_get_resv_regions,
>> +	.owner		    = THIS_MODULE,
>> +	.identity_domain    = &hv_def_identity_dom.iommu_dom,
>> +	.blocked_domain     = &hv_def_blocked_dom.iommu_dom,
>> +	.release_domain     = &hv_def_blocked_dom.iommu_dom,
>> +};
>> +
>> +static const struct iommu_domain_ops hv_special_domain_ops = {
>> +	.attach_dev = hv_iommu_attach_dev,
>> +};
>> +
>> +static void __init hv_initialize_special_domains(void)
>> +{
>> +	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
>> +	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
>> +	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
>> +	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
>> +
>> +	hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
>> +	hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
>> +	hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
>> +	hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
>> +}
>> +
> 
> A net negative 9 lines to initialize these with .field notation, as suggested in v0: https://lore.kernel.org/all/4f7cadc5-817c-4163-bac8-1c02a7c6a862@linux.microsoft.com/

Huh! which are the 9 lines you are claiming to have removed? are you saying
the definition part is not a "line"?

> Wasn't super hard to do the 1 forward declaration needed...

Not a question of hard or not. Having that upfront in the module provides
good introduction to a reader, specially since hyperv is all new around
here and internals are not readily available. Moreover, imo, generally
just embedding definitions in code abrupts the flow often, and historically
hasn't been a common practice.

Thanks,
-Mukesh


> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
> index e0e3e9d4385e2..4e6bf94413458 100644
> --- a/drivers/iommu/hyperv/hv-iommu-root.c
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -12,6 +12,7 @@
>   #include "../dma-iommu.h"
>   
>   static dma_addr_t hv_iommu_max_iova;
> +static struct iommu_ops hv_iommu_ops;
>   static struct iommu_domain_ops hv_paging_domain_ops;
>   
>   /* IOMMU device that we export to the world. MSHV supports max of one */
> @@ -32,23 +33,6 @@ struct hv_iommu_mapping {
>   	u32 flags;
>   };
>   
> -/*
> - * By default, during boot the hypervisor creates one Stage 2 (S2) default
> - * domain. It has two types:
> - *   S2 default: access to entire root partition memory. This for the host
> - *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
> - *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
> - *		 (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
> - *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
> - */
> -
> -/*
> - * Create dummy domains to correspond to hypervisor prebuilt default identity
> - * and null domains (dummy because we do not make hypercalls to create them).
> - */
> -static struct hv_iommu_domain hv_def_identity_dom;
> -static struct hv_iommu_domain hv_def_blocked_dom;
> -
>   /*
>    * The hypervisor owns the IOMMU. As such it will choose the best page size
>    * and whenever possible use larger page sizes automatically. The map gpa
> @@ -488,6 +472,35 @@ static void hv_iommu_get_resv_regions(struct device *dev,
>   	iommu_add_resv_x86_msi_region(head);
>   }
>   
> +static const struct iommu_domain_ops hv_special_domain_ops = {
> +	.attach_dev = hv_iommu_attach_dev,
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
> + * Create dummy domains to correspond to hypervisor prebuilt default identity
> + * and null domains (dummy because we do not make hypercalls to create them).
> + */
> +static struct hv_iommu_domain hv_def_identity_dom = {
> +	.iommu_dom.type = IOMMU_DOMAIN_IDENTITY,
> +	.iommu_dom.ops = &hv_special_domain_ops,
> +	.iommu_dom.owner = &hv_iommu_ops,
> +	.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT, /* 0 */
> +};
> +
> +static struct hv_iommu_domain hv_def_blocked_dom = {
> +	.iommu_dom.type = IOMMU_DOMAIN_BLOCKED,
> +	.iommu_dom.ops = &hv_special_domain_ops,
> +	.iommu_dom.owner = &hv_iommu_ops,
> +	.domid_num = HV_DEVICE_DOMAIN_ID_NULL,    /* INTMAX */
> +};
> +
>   static struct iommu_domain_ops hv_paging_domain_ops = {
>   	.attach_dev = hv_iommu_attach_dev,
>   	.map_pages = hv_iommu_map_pages,
> @@ -508,23 +521,6 @@ static struct iommu_ops hv_iommu_ops = {
>   	.release_domain     = &hv_def_blocked_dom.iommu_dom,
>   };
>   
> -static const struct iommu_domain_ops hv_special_domain_ops = {
> -	.attach_dev = hv_iommu_attach_dev,
> -};
> -
> -static void __init hv_initialize_special_domains(void)
> -{
> -	hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
> -	hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
> -	hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
> -	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
> -
> -	hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
> -	hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
> -	hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
> -	hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
> -}
> -
>   /*
>    * In general, the hypervisor does not support the capabilities hypercall for
>    * root partitions, an exception was made for max_iova_width. For IOMMU cap,
> @@ -571,11 +567,6 @@ static int __init hv_root_iommu_init(void)
>   
>   	hv_iommu_max_iova = DMA_BIT_MASK(caps.max_iova_width);
>   
> -	/* This must come before iommu_device_register() because the latter
> -	 * calls into the hooks.
> -	 */
> -	hv_initialize_special_domains();
> -
>   	rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
>   	if (rc) {
>   		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
> 
> 
> <snip>
> 
> Thanks,
> Easwar (he/him)

