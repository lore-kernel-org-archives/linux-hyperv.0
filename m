Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA8438014;
	Wed, 12 Aug 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558100; cv=none; b=uNt/JrT/xpcT6gLQBjaj3SudtqcPlW7O3ad8ZyIMROGKqne+vIG3qZ4SKOHe0au/5kGbVXpVCRmpVpcUDjI4ERSmM+oPHc4VL3fEKc7PDbrpmETUFJk/JJWLTFqJzrevbr+qYpxkxNHsTSoBSfL0jYmU5HkOhepuW18CxHFWNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558100; c=relaxed/simple;
	bh=2K4QBfuHa1ExQ3BP/1M+Q8X0mWpGN/4J6aPNicKHXhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szLbu/8z8yjTQvmMwBfonFucwD2/aJbGO2ZKNVn4oOU3oX1C+7eXx2zPd4zkfsaQx54Jlj4ozn+MxvOdZiURww94eDj+Y59BkxY3dDhR9UM0IVOo0SiAP8ctwWbASeVFx7NlJLX4M+rrLqnrXdhKUuUPHz8TSaxbhf9snPYpfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=olm2FnUy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="olm2FnUy"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACD6620B7128;
	Wed, 12 Aug 2026 11:07:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACD6620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786558072;
	bh=wFU5mpAjyTwFbqV4yJbosVYJSwP9XcIHjp/tK1XvpO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olm2FnUyFTP59N9B70T+VdBMXVS7cdz2hhlUgSfLteqgder+pduAy5SwXx8YOLiao
	 ljAptd9iNpsALMWxSk2wu+4OIR+D/1zcSk4JUoRycBPWlzQYDvE8rfwG89wT4h8YTU
	 0vT7BGe9Mh9h7JJQMhbIUz35dvMSYcKFmrGT975U=
Date: Wed, 12 Aug 2026 11:08:14 -0700
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
Subject: Re: [PATCH v3 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Message-ID: <20260812110814.00005050@linux.microsoft.com>
In-Reply-To: <20260811155022.108148-2-zhangyu1@linux.microsoft.com>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
	<20260811155022.108148-2-zhangyu1@linux.microsoft.com>
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

On Tue, 11 Aug 2026 23:50:17 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> From: Wei Liu <wei.liu@kernel.org>
> 
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
> 
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
> 
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
> 
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
> 
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush (which in its handler may flush
>   the device TLB as well).
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan
> <easwar.hariharan@linux.microsoft.com> Signed-off-by: Easwar
> Hariharan <easwar.hariharan@linux.microsoft.com> Co-developed-by: Yu
> Zhang <zhangyu1@linux.microsoft.com> Signed-off-by: Yu Zhang
> <zhangyu1@linux.microsoft.com> ---
>  include/hyperv/hvgdk_mini.h |   8 +++
>  include/hyperv/hvhdk_mini.h | 126
> ++++++++++++++++++++++++++++++++++++ 2 files changed, 134
> insertions(+)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 6a4e8b9d570f..5bdbb44da112 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -486,10 +486,16 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */ #define
> HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a #define
> HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af #define
> HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0 +#define
> HVCALL_CREATE_DEVICE_DOMAIN			0x00b1 +#define
> HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2 #define
> HVCALL_SIGNAL_EVENT_DIRECT			0x00c0 #define
> HVCALL_POST_MESSAGE_DIRECT			0x00c1 #define
> HVCALL_DISPATCH_VP				0x00c2 +#define
> HVCALL_DETACH_DEVICE_DOMAIN			0x00c4 +#define
> HVCALL_DELETE_DEVICE_DOMAIN			0x00c5 #define
> HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9 +#define
> HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce +#define
> HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0 #define
> HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7 #define
> HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8 #define
> HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db @@ -502,6
> +508,8 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */ #define HVCALL_MMIO_READ
> 		0x0106 #define HVCALL_MMIO_WRITE
> 		0x0107 #define HVCALL_DISABLE_HYP_EX
>          0x010f +#define HVCALL_GET_IOMMU_CAPABILITIES
> 	0x0125 +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY
> 	0x0127 #define HVCALL_MAP_STATS_PAGE2
> 	0x0131 /* HV_HYPERCALL_INPUT */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 035ba20870f7..1e3eac99886a 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -548,4 +548,130 @@ union hv_device_id {		/*
> HV_DEVICE_ID */ } acpi;
>  } __packed;
>  
> +/* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
> +
> +/* ID for default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type: 4;
> +		u32 reserved: 28;
> +		u32 id;
> +	} __packed;
> +};
> +
> +struct hv_input_device_domain {
> +	u64 partition_id;
> +	union hv_input_vtl owner_vtl;
> +	u8 padding[7];
> +	union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags
> create_device_domain_flags;
> +	u32 padding;
> +} __packed;
> +static_assert(sizeof(struct hv_input_create_device_domain) == 32);
nit, maybe also this to detect ABI drift within. Optional.
static_assert(offsetof(struct hv_input_create_device_domain, padding)
== 28);

> +struct hv_input_delete_device_domain {
> +	struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +	u64 partition_id;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +	struct {
> +		/*
> +		 * Enable translations. If not enabled, all
> transaction bypass
> +		 * S1 translations.
> +		 */
> +		u64 translation_enabled: 1;
> +		u64 blocked: 1;
> +		/*
> +		 * First stage address translation paging mode:
> +		 * 0: 4-level paging (default)
> +		 * 1: 5-level paging
> +		 */
> +		u64 first_stage_paging_mode: 1;
> +		u64 reserved: 61;
> +	} flags;
> +
> +	/* Address of translation table */
> +	u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +	u64 partition_id;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
> +#define HV_IOMMU_CAP_S2         BIT_ULL(1)
> +#define HV_IOMMU_CAP_S1         BIT_ULL(2)
> +#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
> +#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
> +#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
> +#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
> +
> +	u64 iommu_cap;
> +	u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +	u64 partition_id;
> +	u64 logical_device_id;
> +	/* Takes values from enum hv_logical_device_property_code. */
> +	u32 code;
> +	u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED	BIT_ULL(0)
> +	u64 device_iommu;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	u32 flags;
> +	u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
