Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3A3D34B3;
	Tue, 20 Jan 2026 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947454; cv=none; b=t9SrHaHRU3lwoL97U4VxK9vEpsSapfEzWn8Qa9118qr4rE7DWY3zto/qq+8tcXWmqXtOMVjpwDEqux+Tt0MORovIs6wvGudRgpRv18GtVrtQFe2AQZXyVSmpMx0nMER/hXAUYlO9Ugak/ZEYpZQpTcmJQSFuka2QgI3EzVVY5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947454; c=relaxed/simple;
	bh=aU59GdrIczm0M5nJaTBTD4FlTAuOi9VYMcX9lTgNnqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ3aotPQxbeZXwsOYGdXIimSic2JVGtI2ItnKYRKs47PuDCjlOe7UVu3AYbcyMtU6DW9A6q9e8fI5bBHStlDkSIgMdMm6TVozJlfs4RzQHrTJ7DhBVU85GanaMZebe0ivrRBH/zBCrm+SL5wFfCXn0nthaQTBYVSdWJmo/I98UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JoszuDD/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JoszuDD/"
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD17020B716A;
	Tue, 20 Jan 2026 14:17:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD17020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768947446;
	bh=Dvl+8B7mnk1aPoHAx/TJDHGSG8tbL3V20aP8f8Vj3+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoszuDD/aoCCFFZ1PTZGeW3UErubIvihzLaH1MOVE3lbw5m5bqG6G8ISinw57dkWF
	 0+uEhM/crqNkSWCAVY2utnIZ5oZZwqxYhxoUlzMH3ohKBbWL1cfLjanypp96A3blLE
	 0JCMTJ+CG8gaEvz06yNE4QhWWmM2FvT7zFlVXdrM=
Date: Tue, 20 Jan 2026 14:17:24 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 09/15] mshv: Import data structs around device domains
 and irq remapping
Message-ID: <aW_-9KO2DrVvmvSs@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-10-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-10-mrathor@linux.microsoft.com>

On Mon, Jan 19, 2026 at 10:42:24PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Import/copy from Hyper-V public headers, definitions and declarations that
> are related to attaching and detaching of device domains and interrupt
> remapping, and building device ids for those purposes.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  11 ++++
>  include/hyperv/hvhdk_mini.h | 112 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
> 

<snip>

> +/* ID for stage 2 default domain and NULL domain */
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

Shouldn't the inner struct be packed instead?

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

Why should the union be packed?

Thanks,
Stanislav

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
> -- 
> 2.51.2.vfs.0.1
> 
