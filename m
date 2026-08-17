Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A7175A5;
	Mon, 17 Aug 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934026; cv=none; b=k17/sOFEgchIP1kqpMHtI7BachxWZ99puM8Xpu8QXUXIFUt1xVE68gfFvs9l4vpun88fYQqrnbcr932if1mz6r8NDg8e5fVFFODKCmJmxaELp7/9WYrkuY2CEcmj3X6LsThVjDL7dcsOf4P4SZ6WiVpkb1adYFTMxtjdKyN6UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934026; c=relaxed/simple;
	bh=7U2BRfTH5wB1Jg2r2jNUdOL8s4lgTdlLMqQYINFEskQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AogwAiEpUoGmkdu9C9joqULwn61UW8qbYGPijbYKDhg1PTcbc6Y/Lp1pvI+rCOVxL+ftW3/1WHsI6HaCzMwHQhDWpOVGIWnII9KXQ3Wg9vPRgbqLW2ZGk7u7XxsF0A5gXs2MKWpSgcmY5w9M2/gZ5bdXYf+WvJ0zD9ZBaZJamoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VB/fDjHp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VB/fDjHp"
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B2FE20B7168;
	Sun, 16 Aug 2026 19:33:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B2FE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786933991;
	bh=Rft+yHVAVUN7/39qSq86ni8RStTmlR07evvRWnD8Zm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VB/fDjHpwDVgc5pusPL+30b0/mp6tGHWmG2JRq57kNawS/S6vtvoWR0MxxuE6TJ/t
	 nmcu8mmlfwdv25jDavM35Zgpfeo1JmPENRr/sk8W0NyZb+3rWky7HTRwmCUMbNT5WI
	 ce6XY+JhQzO87ucfoFJPYXdq//jDZWLBlWODH8m0=
Date: Mon, 17 Aug 2026 10:33:36 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, 
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Message-ID: <rpzpjbalau22m7f2s2ljxm6byzspuewqcu4awfih6qavkkazq6@mpraxcbidlar>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-2-zhangyu1@linux.microsoft.com>
 <BN7PR02MB414806B8395DA93F5F7D7867D4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB414806B8395DA93F5F7D7867D4DA2@BN7PR02MB4148.namprd02.prod.outlook.com>

On Fri, Aug 14, 2026 at 03:31:08PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Tuesday, August 11, 2026 8:50 AM
> > 
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> > Introduce the hypercalls used by the child partition to interact with
> > this facility.
> > 
> > These hypercalls fall into below categories:
> > - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
> >   detect the existence and capabilities of the guest IOMMU.
> > 
> > - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
> >   check whether an endpoint device is managed by the guest IOMMU.
> > 
> > - Domain management: A set of hypercalls is provided to handle the
> >   creation, configuration, and deletion of guest domains, as well as
> >   the attachment/detachment of endpoint devices to/from those domains.
> > 
> > - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
> >   for a domain-selective IOTLB flush (which in its handler may flush
> >   the device TLB as well).
> > 
> 
> [snip]
> 
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
> 
> The static_assert() here is unusual. For all the other hypercall
> inputs/outputs where we rely on the structure definition to
> be correct and the __packed to prevent the compiler from
> adding/changing anything. If there's a reason for this one to be
> different, a comment would help. If there's not really a reason,
> I'd suggest dropping the static_assert() as superfluous.
> 

Thank you, Michael.
Indeed, there's no reason to treat this data structure differently.
Will drop the static_assert() and keep the explicit padding.

B.R.
Yu

> Michael
> 
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
> >  #endif /* _HV_HVHDK_MINI_H */
> > --
> > 2.52.0
> > 
> 
