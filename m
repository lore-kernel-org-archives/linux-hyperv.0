Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274A3F58D7;
	Tue, 22 Sep 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099319; cv=none; b=uT5h6cd48UCgLN7s3xKvB5S0lNsbZDXfFb8Qo/5HRUTQlE4eL7bNQlIoP/7QBZeCwC1DRKr6WqSQJZUXNeBs2jW5ePSBFVzB85lhHSaWLfcrEYeNJexKT8az6ZXZLOAPVR6XtvY/vpiabAu5+HtcgtuP8PcQeXGqalBbwQUOJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099319; c=relaxed/simple;
	bh=kTMLjMI+3oMuAoDSiZMej474ZxKZI3kbzbymSlScGsM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DLgAsu+tQ1VDzkxRlyP/6iAjScyUtjNHL0Uycd69/byUR34rbPzjeRReMnjZDu/P6FOQw++wSSfSfwiLFdjnXwZvgulhZOwZR/cw5+kBiWUFr2rAtcqzN0j2BElf/mi3u4ZnhvgMhMYnfOZQCTpwc3GsyuHIwO0Iq7hwI1Z+Os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KxMELhnc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KxMELhnc"
Received: from [100.64.33.11] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5FD1D20B7168;
	Tue, 22 Sep 2026 10:47:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FD1D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790099269;
	bh=wsgw9fWrjcXbBDbnqUOexzVuRcPNKuwRNMM/Jpa/tZ0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KxMELhncJzXbLhooDXbbKXhkD6UEFuwfgozmzuvWomrQKtpw0PAVPn+v+CfEsEMyH
	 RvQ4YmHtEnAhrKgIMWH8KcWad/pxWNHaFxWxknl1p8tg5MW35pawt9mX0XYSu/07TB
	 gcuXyrJ4CmF/uBm3AbJjm3yfkfBBTz52vEO7Bm1Y=
Message-ID: <5b292db7-1d55-4aef-9053-be2156c6e886@linux.microsoft.com>
Date: Tue, 22 Sep 2026 10:48:36 -0700
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
Subject: Re: [PATCH V0 2/3] mshv: Import data structs around device domains
 from hyperv headers
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-3-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260921225028.4007330-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/2026 15:50, Mukesh R wrote:
> Copy/import from Hyper-V public headers, definitions and declarations that
> are related to creating iommu domains in the hypervisor, attaching devices
> to them, doing the reverse, etc.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  9 ++++
>  include/hyperv/hvhdk_mini.h | 90 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 6a4e8b9d570f..3b74f3c0229d 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -326,6 +326,8 @@ union hv_hypervisor_version_info {
>  /* stimer Direct Mode is available */
>  #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
>  
> +#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
> +

For my understanding, how is ms_hyperv.misc_features.HV_DEVICE_DOMAIN_AVAILABLE = 1
different from HV_IOMMU_CAP_PRESENT = 1 combined with HV_IOMMU_CAP_S2 = 1?
It seems like there is room to combine forces with the guest driver and just go with
the latter.

>  /*
>   * Implementation recommendations. Indicates which behaviors the hypervisor
>   * recommends the OS implement for optimal performance.
> @@ -486,9 +488,15 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> +#define HVCALL_CREATE_DEVICE_DOMAIN                     0x00b1
> +#define HVCALL_ATTACH_DEVICE_DOMAIN                     0x00b2
> +#define HVCALL_MAP_DEVICE_GPA_PAGES                     0x00b3
> +#define HVCALL_UNMAP_DEVICE_GPA_PAGES                   0x00b4
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> +#define HVCALL_DETACH_DEVICE_DOMAIN                     0x00c4
> +#define HVCALL_DELETE_DEVICE_DOMAIN                     0x00c5
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
> @@ -502,6 +510,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
>  #define HVCALL_DISABLE_HYP_EX                           0x010f
> +#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
>  #define HVCALL_MAP_STATS_PAGE2				0x0131
>  
>  /* HV_HYPERCALL_INPUT */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 035ba20870f7..3bb052fd6e06 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -548,4 +548,94 @@ union hv_device_id {		/* HV_DEVICE_ID */
>  	} acpi;
>  } __packed;
>  
> +/* 3 domain types: stage 1, stage 2, and SOC */
> +#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
> +#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */


> +#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* HV_DEVICE_DOMAIN_ID_TYPE_SOC */

I don't think this domain type is used in patch 3, perhaps we bring it in when needed?

> +
> +/* ID for stage 2 default domain and NULL domain */

I think this comment would be more useful if it related the MSHV default and NULL domains to
the Linux equivalents of identity and blocking respectively. As it stands, it just repeats the
names of the defines it is a comment for.

> +#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type : 4;
> +		u32 reserved : 28;
> +		u32 id;
> +	};
> +} __packed;
> +
> +struct hv_input_device_domain { /* HV_INPUT_DEVICE_DOMAIN */
> +	u64 partition_id;
> +	union hv_input_vtl owner_vtl;
> +	u8 padding[7];
> +	union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {	/* HV_CREATE_DEVICE_DOMAIN_FLAGS */
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required : 1;
> +		u32 inherit_owning_vtl : 1;
> +		u32 reserved : 30;
> +	} __packed;
> +} __packed;
> +
> +struct hv_input_create_device_domain {	/* HV_INPUT_CREATE_DEVICE_DOMAIN */
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;
> +
> +struct hv_input_delete_device_domain {	/* HV_INPUT_DELETE_DEVICE_DOMAIN */
> +	struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {	/* HV_INPUT_ATTACH_DEVICE_DOMAIN */
> +	struct hv_input_device_domain device_domain;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {	/* HV_INPUT_DETACH_DEVICE_DOMAIN */
> +	u64 partition_id;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +/* HV_INPUT_GET_IOMMU_CAPABILITIES */
> +struct hv_input_get_iommu_capabilities {
> +	u64 partition_id;
> +	u64 reserved;
> +} __packed;
> +
> +#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
> +#define HV_IOMMU_CAP_S2         BIT_ULL(1)
> +#define HV_IOMMU_CAP_S1         BIT_ULL(2)
> +#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
> +#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
> +#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
> +#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
> +
> +struct hv_output_get_iommu_capabilities { /* HV_OUTPUT_GET_IOMMU_CAPABILITIES */
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 iommu_cap;          /* HV_IOMMU_CAP_* above */
> +	u64 pgsize_bitmap;
> +} __packed;
> +
> +struct hv_input_map_device_gpa_pages {	/* HV_INPUT_MAP_DEVICE_GPA_PAGES */
> +	struct hv_input_device_domain device_domain;
> +	union hv_input_vtl target_vtl;
> +	u8 padding[3];
> +	u32 map_flags;
> +	u64 target_device_va_base;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_input_unmap_device_gpa_pages {  /* HV_INPUT_UNMAP_DEVICE_GPA_PAGES */
> +	struct hv_input_device_domain device_domain;
> +	u64 target_device_va_base;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */

