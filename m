Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A539021F;
	Fri, 14 Aug 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701870; cv=none; b=ksXya1j2b8/DCACDMSMwc1OIp6VlI1LrNkxwgMSVFbF4ojb4hTUS6spN+tTeAoE3CfNMf6WfID++M7Bgc16lE9uJoYP8OmvYBvmEFg5lO8lE6HitQvlyK+BYlOWVxUTucCXLnXPzk2Tc1a7+vhrh0P5hIN4jK9P+q2/fDB27fog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701870; c=relaxed/simple;
	bh=ozyI6ATBVym5AUg56wpSkH8GVDBaSXF93ernbB05OXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC6svgZSaB7IiAQ67eJNpZZqrA7DP6flv7+CUjbJsBYeBcHb/DwLhV2HdZ0iK8g+AlUsd69nRH6x08cTdp4b8pBrQqLbsneSPQjQl1J7bt7J28gBAIs6bOLdQ1GfM2E1VTdN9TaS8kpDPBvbTbvd2MOaHQrWkTECCPhE6cuzkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WAjGJrOt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WAjGJrOt"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1807C20B7168;
	Fri, 14 Aug 2026 03:03:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1807C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786701831;
	bh=uXc+pBOTCtfei91qMJUyjj3DvgN6nVOBDBWaBemrjw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAjGJrOtOdzGEpwtDE2u9P+ydNe3DxneDg0YFMIbjRddT4queqLv8U16BYs3jrfa3
	 8z8Dg20nNGcdZq8wg7HkfiLSvZE8OdTpyCDJhkD8MTfOKWUqzzRvD/YWOYCaNPsrkO
	 jGzfDLurz1apOYgVd5bfuFlbqsxlnG5nMWaC39eQ=
Date: Fri, 14 Aug 2026 18:04:14 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, 
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com, tgopinath@linux.microsoft.com, 
	easwar.hariharan@linux.microsoft.com, baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Message-ID: <lrzifnzu4dx5oictyr2mdhwdycuevhjb7gjnqg7r2ld45glwht@emz2tdjbiz6d>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-2-zhangyu1@linux.microsoft.com>
 <fdc50372-e121-52cd-51ce-1411f143d3ea@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc50372-e121-52cd-51ce-1411f143d3ea@linux.microsoft.com>

On Thu, Aug 13, 2026 at 06:31:07PM -0700, Mukesh R wrote:
> On 8/11/26 08:50, Yu Zhang wrote:
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> > Introduce the hypercalls used by the child partition to interact with
> > this facility.
> > 
> > These hypercalls fall into below categories:
> > - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
> >    detect the existence and capabilities of the guest IOMMU.
> > 
> > - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
> >    check whether an endpoint device is managed by the guest IOMMU.
> > 
> > - Domain management: A set of hypercalls is provided to handle the
> >    creation, configuration, and deletion of guest domains, as well as
> >    the attachment/detachment of endpoint devices to/from those domains.
> > 
> > - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
> >    for a domain-selective IOTLB flush (which in its handler may flush
> >    the device TLB as well).
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > ---
> >   include/hyperv/hvgdk_mini.h |   8 +++
> >   include/hyperv/hvhdk_mini.h | 126 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 134 insertions(+)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 6a4e8b9d570f..5bdbb44da112 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -486,10 +486,16 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
> >   #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
> >   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
> >   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> > +#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
> > +#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
> >   #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> >   #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
> >   #define HVCALL_DISPATCH_VP				0x00c2
> > +#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
> > +#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
> >   #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
> > +#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
> > +#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
> >   #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
> >   #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
> >   #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> > @@ -502,6 +508,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
> >   #define HVCALL_MMIO_READ				0x0106
> >   #define HVCALL_MMIO_WRITE				0x0107
> >   #define HVCALL_DISABLE_HYP_EX                           0x010f
> > +#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
> > +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
> >   #define HVCALL_MAP_STATS_PAGE2				0x0131
> >   /* HV_HYPERCALL_INPUT */
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index 035ba20870f7..1e3eac99886a 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -548,4 +548,130 @@ union hv_device_id {		/* HV_DEVICE_ID */
> >   	} acpi;
> >   } __packed;
> > +/* Device domain types */
> > +#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
> > +
> > +/* ID for default domain and NULL domain */
> > +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> > +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> > +
> > +union hv_device_domain_id {
> > +	u64 as_uint64;
> > +	struct {
> > +		u32 type: 4;
> > +		u32 reserved: 28;
> > +		u32 id;
> > +	} __packed;
> > +};
> > +
> > +struct hv_input_device_domain {
> > +	u64 partition_id;
> > +	union hv_input_vtl owner_vtl;
> > +	u8 padding[7];
> > +	union hv_device_domain_id domain_id;
> > +} __packed;
> > +
> > +union hv_create_device_domain_flags {
> > +	u32 as_uint32;
> > +	struct {
> > +		u32 forward_progress_required: 1;
> > +		u32 inherit_owning_vtl: 1;
> > +		u32 reserved: 30;
> > +	} __packed;
> > +};
> > +
> > +struct hv_input_create_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	union hv_create_device_domain_flags create_device_domain_flags;
> > +	u32 padding;
> > +} __packed;
> > +static_assert(sizeof(struct hv_input_create_device_domain) == 32);
> > +
> > +struct hv_input_delete_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +} __packed;
> > +
> > +struct hv_input_attach_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	union hv_device_id device_id;
> > +} __packed;
> > +
> > +struct hv_input_detach_device_domain {
> > +	u64 partition_id;
> > +	union hv_device_id device_id;
> > +} __packed;
> > +
> > +struct hv_device_domain_settings {
> > +	struct {
> > +		/*
> > +		 * Enable translations. If not enabled, all transaction bypass
> > +		 * S1 translations.
> > +		 */
> > +		u64 translation_enabled: 1;
> > +		u64 blocked: 1;
> > +		/*
> > +		 * First stage address translation paging mode:
> > +		 * 0: 4-level paging (default)
> > +		 * 1: 5-level paging
> > +		 */
> > +		u64 first_stage_paging_mode: 1;
> > +		u64 reserved: 61;
> > +	} flags;
> > +
> > +	/* Address of translation table */
> > +	u64 page_table_root;
> > +} __packed;
> > +
> > +struct hv_input_configure_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	struct hv_device_domain_settings settings;
> > +} __packed;
> > +
> > +struct hv_input_get_iommu_capabilities {
> > +	u64 partition_id;
> > +	u64 reserved;
> > +} __packed;
> > +
> 
> 
> Hi Yu,
> 
> I had mentioned before, please tag the structs properly. Eg:
> 
> struct hv_input_attach_device_domain { /* HV_INPUT_ATTACH_DEVICE_DOMAIN */
> 
> If it causes 80 cols line wrap, put the tag above.
> 
> You can see my patch series for other ones, and lmk if you can't
> find equivalents for remaining in hyperv exported headers.

Fair point. Below are the definitions and tags I think need to be
updated. I would like to align with you on the names. Could you please
check whether this list is correct?

  HV_DEVICE_DOMAIN_TYPE_S1
    HV_DEVICE_DOMAIN_ID_TYPE_S1

  union hv_device_domain_id
    HV_DEVICE_DOMAIN_ID

  struct hv_input_device_domain
    HV_INPUT_DEVICE_DOMAIN

  union hv_create_device_domain_flags
    HV_CREATE_DEVICE_DOMAIN_FLAGS

  struct hv_input_create_device_domain
    HV_INPUT_CREATE_DEVICE_DOMAIN

  struct hv_input_delete_device_domain
    HV_INPUT_DELETE_DEVICE_DOMAIN

  struct hv_input_attach_device_domain
    HV_INPUT_ATTACH_DEVICE_DOMAIN

  struct hv_input_detach_device_domain
    HV_INPUT_DETACH_DEVICE_DOMAIN

  struct hv_device_domain_settings
    HV_DEVICE_DOMAIN_SETTINGS

  struct hv_input_configure_device_domain
    HV_INPUT_CONFIGURE_DEVICE_DOMAIN

  struct hv_input_get_iommu_capabilities
    HV_INPUT_GET_IOMMU_CAPABILITIES

  struct hv_output_get_iommu_capabilities
    HV_OUTPUT_GET_IOMMU_CAPABILITIES

  struct hv_input_flush_device_domain
    HV_INPUT_FLUSH_DEVICE_DOMAIN

  union hv_iommu_flush_va
    HV_IOMMU_GVA_RANGE

  struct hv_input_flush_device_domain_list
    HV_INPUT_FLUSH_DEVICE_DOMAIN_LIST

  enum hv_logical_device_property_code
    HV_LOGICAL_DEVICE_PROPERTY_CODE

  struct hv_input_get_logical_device_property
    HV_INPUT_GET_LOGICAL_DEVICE_PROPERTY

  struct hv_output_get_logical_device_property
    HV_OUTPUT_GET_LOGICAL_DEVICE_PROPERTY

Yu

> 
> Thanks,
> -Mukesh
> 
> > +struct hv_output_get_iommu_capabilities {
> > +	u32 size;
> > +	u16 reserved;
> > +	u8  max_iova_width;
> > +	u8  max_pasid_width;
> > +
> > +#define HV_IOMMU_CAP_PRESENT    BIT_ULL(0)
> > +#define HV_IOMMU_CAP_S2         BIT_ULL(1)
> > +#define HV_IOMMU_CAP_S1         BIT_ULL(2)
> > +#define HV_IOMMU_CAP_S1_5LVL    BIT_ULL(3)
> > +#define HV_IOMMU_CAP_PASID      BIT_ULL(4)
> > +#define HV_IOMMU_CAP_ATS        BIT_ULL(5)
> > +#define HV_IOMMU_CAP_PRI        BIT_ULL(6)
> > +
> > +	u64 iommu_cap;
> > +	u64 pgsize_bitmap;
> > +} __packed;
> > +
> > +enum hv_logical_device_property_code {
> > +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,
> > +};
> > +
> > +struct hv_input_get_logical_device_property {
> > +	u64 partition_id;
> > +	u64 logical_device_id;
> > +	/* Takes values from enum hv_logical_device_property_code. */
> > +	u32 code;
> > +	u32 reserved;
> > +} __packed;
> > +
> > +struct hv_output_get_logical_device_property {
> > +#define HV_DEVICE_IOMMU_ENABLED	BIT_ULL(0)
> > +	u64 device_iommu;
> > +	u64 reserved;
> > +} __packed;
> > +
> > +struct hv_input_flush_device_domain {
> > +	struct hv_input_device_domain device_domain;
> > +	u32 flags;
> > +	u32 reserved;
> > +} __packed;
> > +
> >   #endif /* _HV_HVHDK_MINI_H */
> 
