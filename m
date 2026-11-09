Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244670;
	b=CAAlhVdsj70PF9F9USU8nTOc6PB6+TOg0VEjIMeioFgPK7Bjltn601I19X43hNKobTR3
	 l7dI4CZN1T3gQ0BGEL8kCsY+QNjTgGqXbWI4Xes2zqdmv+rQ/75bMJG/sZ41f5DF2lwCa
	 juzGjQl+51uYAHuROMn2MblWtpPUnh+OFWAbrm1ocwAjHH2c4lkPs0VqEbTn1V5Ia1GT8
	 2lU1TZwzVOetjL/pH9Of9kA68XsicGX5CB5iJAIYsxIn7s0xA/JPNb/fpgyjqkZXaiq44
	 BfssAKVY+1YyggMHjv8Nnj0Hk7H9/ImUBHQUzjLlETsuKdFEO6HjmPknqw3gsmHegkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244670;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=BADVZ41G8xtkqHq/JNe15jN9JsvXsYZ8vIL7NioPmMk=;
	b=VYx8887MI23NAQm3xMRBzzjEk5WCEp8qPGS5cSW1olowfn9Az38AFgaehTKOQ/v5adsU
	 nZJ31k3XXrL4eOixrgifQM0QQMIjks/3sSjIMKYolqI6/h6/AdlbedljeDY9fGiCWBrFf
	 tTKb7k9tzXCGr4xEtxWX/zgHwwS7C/wTkben8W6l8fgMKCZJpDU0ujRv2htEN+tyMgGzx
	 AnecPvZuO85sdBQNURQv24exV23tzO/i8/I0rnocRgqYzlMBRZl5myQxEbYYbaRQzDEkn
	 LDOQDqjQ/9o1qYKLu1CM5+1BvMtSvsasMDF7t/6VPAPierPE5Vk+VNjopZu4yBTlVsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="QU/gJxUo";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A281606EEB3
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Nov 2026 17:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A281606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QU/gJxUo
Received: from [100.64.200.213] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5607520B7168;
	Mon,  9 Nov 2026 09:17:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5607520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794244667;
	bh=BADVZ41G8xtkqHq/JNe15jN9JsvXsYZ8vIL7NioPmMk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QU/gJxUoSOa+5RryJ9u99LtTMu7Rq/hpiDnhejXwGzVYqv/C0JB7dguLDhGNCGdTV
	 7fGMHlt4pWjmAmp3WKkTnSv7yQyPBSNrf06NRQLIJJQDFReFJBNVba7x3GZhdqad3q
	 ZOrU42tVmxKU5gYPT91vc+24SukMYKsY+uGG2LdE=
Message-ID: <60ae4af7-e191-4d89-ac02-336b2ca2212c@linux.microsoft.com>
Date: Mon, 9 Nov 2026 09:17:52 -0800
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
Cc: easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU kernel
 only driver
To: linux-hyperv@vger.kernel.org
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-6-mrathor@linux.microsoft.com>
 <f2579646-7f77-4dd2-b7ce-ccf702828610@linux.microsoft.com>
 <9d010202-39e4-c424-3a40-0d37b62b17fd@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <9d010202-39e4-c424-3a40-0d37b62b17fd@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/2026 15:39, Mukesh R wrote:
> On 11/6/26 13:54, Easwar Hariharan wrote:
>> On 11/4/2026 18:01, Mukesh R wrote:
>>> Add a new file to implement a kernel only virtual IOMMU that works
>>> on Microsoft Hyper-V hypervisor (aka MSHV) in privileged VMs aka
>>> root VMs. The hypervisor claims the IOMMU upon boot, and this driver
>>> communicates with it for creating and deleting paging domains, attaching
>>> of devices, mapping and unmapping of pages, etc. During boot, hypervisor
>>> automatically creates identity and blocked domains, so there is no need
>>> to do hypercalls to create them. This is a kernel only driver and only
>>> supported on baremetal root (and not L1VH root) without any guest passthru
>>> support. Support for guest device passthru will be added incrementally.
>>>
>>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>>> ---
>>>   arch/x86/kernel/pci-dma.c            |   2 +
>>>   drivers/iommu/hyperv/Kconfig         |  13 +
>>>   drivers/iommu/hyperv/Makefile        |   1 +
>>>   drivers/iommu/hyperv/hv-iommu-root.c | 613 +++++++++++++++++++++++++++
>>>   include/asm-generic/mshyperv.h       |   3 +
>>>   include/linux/hyperv.h               |   6 +
>>>   6 files changed, 638 insertions(+)
>>>   create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c
>>>
>>
>> <snip>
>>
>>>   obj-$(CONFIG_HYPERV_PVIOMMU) += hv-iommu-guest.o
>>> +obj-$(CONFIG_HYPERV_ROOT_IOMMU) += hv-iommu-root.o
>>> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
>>> new file mode 100644
>>> index 000000000000..e0e3e9d4385e
>>> --- /dev/null
>>> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
>>> @@ -0,0 +1,613 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Hyper-V root vIOMMU driver.
>>> + * Copyright (C) 2026, Microsoft, Inc.
>>> + */
>>> +#include <linux/pci.h>
>>> +#include <linux/dma-map-ops.h>
>>> +#include <linux/interval_tree.h>
>>> +#include <linux/hyperv.h>
>>> +#include <asm/iommu.h>
>>> +#include <asm/mshyperv.h>
>>> +#include "../dma-iommu.h"
>>> +
>>> +static dma_addr_t hv_iommu_max_iova;
>>> +static struct iommu_domain_ops hv_paging_domain_ops;
>>> +
>>> +/* IOMMU device that we export to the world. MSHV supports max of one */
>>> +static struct iommu_device hv_virt_iommu;
>>> +
>>> +struct hv_iommu_domain {
>>> +    struct iommu_domain iommu_dom;
>>> +    u32 domid_num;                  /* as opposed to domain_id.type */
>>> +    spinlock_t mappings_lock;          /* protects mappings_tree */
>>> +    struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
>>> +};
>>> +
>>> +#define to_hv_domain(d) container_of(d, struct hv_iommu_domain, iommu_dom)
>>> +
>>> +struct hv_iommu_mapping {
>>> +    phys_addr_t paddr;
>>> +    struct interval_tree_node iova;
>>> +    u32 flags;
>>> +};
>>> +
>>> +/*
>>> + * By default, during boot the hypervisor creates one Stage 2 (S2) default
>>> + * domain. It has two types:
>>> + *   S2 default: access to entire root partition memory. This for the host
>>> + *         maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
>>> + *         is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
>>> + *         (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
>>> + *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
>>> + */
>>> +
>>> +/*
>>> + * Create dummy domains to correspond to hypervisor prebuilt default identity
>>> + * and null domains (dummy because we do not make hypercalls to create them).
>>> + */
>>> +static struct hv_iommu_domain hv_def_identity_dom;
>>> +static struct hv_iommu_domain hv_def_blocked_dom;
>>> +
>>> +/*
>>> + * The hypervisor owns the IOMMU. As such it will choose the best page size
>>> + * and whenever possible use larger page sizes automatically. The map gpa
>>> + * hypercall to map the iova however currently uses only 4K pfns as input.
>>> + * So we specify 4K as the IOMMU PAGE_SIZE.
>>> + */
>>> +#define HV_IOMMU_PGSIZES SZ_4K
>>> +
>>> +static DEFINE_IDA(hv_iommu_domids);   /* unique numeric ids for new domains */
>>> +
>>> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
>>> +{
>>> +    switch (cap) {
>>> +    case IOMMU_CAP_CACHE_COHERENCY:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    }
>>> +}
>>
>> Seems like this could match the guest driver and just be: return cap == IOMMU_CAP_CACHE_COHERENCY.
>>
>> <snip>
>>
>>> +
>>> +static struct iommu_domain_ops hv_paging_domain_ops = {
>>> +    .attach_dev = hv_iommu_attach_dev,
>>> +    .map_pages = hv_iommu_map_pages,
>>> +    .unmap_pages = hv_iommu_unmap_pages,
>>> +    .iova_to_phys = hv_iommu_iova_to_phys,
>>> +    .free = hv_iommu_domain_free,
>>> +};
>>> +
>>> +static struct iommu_ops hv_iommu_ops = {
>>> +    .capable        = hv_iommu_capable,
>>> +    .domain_alloc_paging    = hv_iommu_domain_alloc_paging,
>>> +    .probe_device        = hv_iommu_probe_device,
>>> +    .device_group        = pci_device_group,
>>> +    .get_resv_regions   = hv_iommu_get_resv_regions,
>>> +    .owner            = THIS_MODULE,
>>> +    .identity_domain    = &hv_def_identity_dom.iommu_dom,
>>> +    .blocked_domain     = &hv_def_blocked_dom.iommu_dom,
>>> +    .release_domain     = &hv_def_blocked_dom.iommu_dom,
>>> +};
>>> +
>>> +static const struct iommu_domain_ops hv_special_domain_ops = {
>>> +    .attach_dev = hv_iommu_attach_dev,
>>> +};
>>> +
>>> +static void __init hv_initialize_special_domains(void)
>>> +{
>>> +    hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
>>> +    hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
>>> +    hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
>>> +    hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
>>> +
>>> +    hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
>>> +    hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
>>> +    hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
>>> +    hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
>>> +}
>>> +
>>
>> A net negative 9 lines to initialize these with .field notation, as suggested in v0: https://lore.kernel.org/all/4f7cadc5-817c-4163-bac8-1c02a7c6a862@linux.microsoft.com/
> 
> Huh! which are the 9 lines you are claiming to have removed? are you saying
> the definition part is not a "line"?

It was the diffstat of the diff I pasted below.

 drivers/iommu/hyperv/hv-iommu-root.c | 69 ++++++++++++++++++++++++++++++---------------------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

> 
>> Wasn't super hard to do the 1 forward declaration needed...
> 
> Not a question of hard or not.

I was referencing your response to v0:

"it has dependencies on things declared above it, so not worth forward
declarations etc.."

 Having that upfront in the module provides
> good introduction to a reader, specially since hyperv is all new around
> here and internals are not readily available. Moreover, imo, generally
> just embedding definitions in code abrupts the flow often, and historically
> hasn't been a common practice.
 
I'm having difficulty parsing this, but I *think* you're saying that putting data structure
definitions in between functions hasn't been a common practice, and that may be true,
but I'd just ask you to look at the intel/, amd/, and arm-smmu-v3/ drivers, it's a
well-established pattern in this subsystem.

Thanks,
Easwar (he/him)

> 
> 
>> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/hv-iommu-root.c
>> index e0e3e9d4385e2..4e6bf94413458 100644
>> --- a/drivers/iommu/hyperv/hv-iommu-root.c
>> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
>> @@ -12,6 +12,7 @@
>>   #include "../dma-iommu.h"
>>     static dma_addr_t hv_iommu_max_iova;
>> +static struct iommu_ops hv_iommu_ops;
>>   static struct iommu_domain_ops hv_paging_domain_ops;
>>     /* IOMMU device that we export to the world. MSHV supports max of one */
>> @@ -32,23 +33,6 @@ struct hv_iommu_mapping {
>>       u32 flags;
>>   };
>>   -/*
>> - * By default, during boot the hypervisor creates one Stage 2 (S2) default
>> - * domain. It has two types:
>> - *   S2 default: access to entire root partition memory. This for the host
>> - *         maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
>> - *         is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
>> - *         (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
>> - *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
>> - */
>> -
>> -/*
>> - * Create dummy domains to correspond to hypervisor prebuilt default identity
>> - * and null domains (dummy because we do not make hypercalls to create them).
>> - */
>> -static struct hv_iommu_domain hv_def_identity_dom;
>> -static struct hv_iommu_domain hv_def_blocked_dom;
>> -
>>   /*
>>    * The hypervisor owns the IOMMU. As such it will choose the best page size
>>    * and whenever possible use larger page sizes automatically. The map gpa
>> @@ -488,6 +472,35 @@ static void hv_iommu_get_resv_regions(struct device *dev,
>>       iommu_add_resv_x86_msi_region(head);
>>   }
>>   +static const struct iommu_domain_ops hv_special_domain_ops = {
>> +    .attach_dev = hv_iommu_attach_dev,
>> +};
>> +
>> +/*
>> + * By default, during boot the hypervisor creates one Stage 2 (S2) default
>> + * domain. It has two types:
>> + *   S2 default: access to entire root partition memory. This for the host
>> + *         maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
>> + *         is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
>> + *         (Linux renamed to : HV_DEVICE_DOMAIN_ID_DEFAULT)
>> + *   S2 NULL: Blocks everything, ie, IOMMU_DOMAIN_BLOCKED in linux.
>> + * Create dummy domains to correspond to hypervisor prebuilt default identity
>> + * and null domains (dummy because we do not make hypercalls to create them).
>> + */
>> +static struct hv_iommu_domain hv_def_identity_dom = {
>> +    .iommu_dom.type = IOMMU_DOMAIN_IDENTITY,
>> +    .iommu_dom.ops = &hv_special_domain_ops,
>> +    .iommu_dom.owner = &hv_iommu_ops,
>> +    .domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT, /* 0 */
>> +};
>> +
>> +static struct hv_iommu_domain hv_def_blocked_dom = {
>> +    .iommu_dom.type = IOMMU_DOMAIN_BLOCKED,
>> +    .iommu_dom.ops = &hv_special_domain_ops,
>> +    .iommu_dom.owner = &hv_iommu_ops,
>> +    .domid_num = HV_DEVICE_DOMAIN_ID_NULL,    /* INTMAX */
>> +};
>> +
>>   static struct iommu_domain_ops hv_paging_domain_ops = {
>>       .attach_dev = hv_iommu_attach_dev,
>>       .map_pages = hv_iommu_map_pages,
>> @@ -508,23 +521,6 @@ static struct iommu_ops hv_iommu_ops = {
>>       .release_domain     = &hv_def_blocked_dom.iommu_dom,
>>   };
>>   -static const struct iommu_domain_ops hv_special_domain_ops = {
>> -    .attach_dev = hv_iommu_attach_dev,
>> -};
>> -
>> -static void __init hv_initialize_special_domains(void)
>> -{
>> -    hv_def_identity_dom.iommu_dom.type = IOMMU_DOMAIN_IDENTITY;
>> -    hv_def_identity_dom.iommu_dom.ops = &hv_special_domain_ops;
>> -    hv_def_identity_dom.iommu_dom.owner = &hv_iommu_ops;
>> -    hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_DEFAULT; /* 0 */
>> -
>> -    hv_def_blocked_dom.iommu_dom.type = IOMMU_DOMAIN_BLOCKED;
>> -    hv_def_blocked_dom.iommu_dom.ops = &hv_special_domain_ops;
>> -    hv_def_blocked_dom.iommu_dom.owner = &hv_iommu_ops;
>> -    hv_def_blocked_dom.domid_num = HV_DEVICE_DOMAIN_ID_NULL;    /* INTMAX */
>> -}
>> -
>>   /*
>>    * In general, the hypervisor does not support the capabilities hypercall for
>>    * root partitions, an exception was made for max_iova_width. For IOMMU cap,
>> @@ -571,11 +567,6 @@ static int __init hv_root_iommu_init(void)
>>         hv_iommu_max_iova = DMA_BIT_MASK(caps.max_iova_width);
>>   -    /* This must come before iommu_device_register() because the latter
>> -     * calls into the hooks.
>> -     */
>> -    hv_initialize_special_domains();
>> -
>>       rc = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
>>       if (rc) {
>>           pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", rc);
>>
>>
>> <snip>
>>
>> Thanks,
>> Easwar (he/him)
> 

