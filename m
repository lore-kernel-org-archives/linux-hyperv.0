Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675876;
	b=PG4wptiCAqLIQKIBmLg5ajxiRfqdjyAxFvAu88DEO9syv7hDsk+9Om/fMsYNihvuREqJ
	 DQGhlEekiH3+za6w7pZurVdftxEQuzarijl9HfZM8lihHpPjTKKYWEBwBQ6V1PBRYc/Co
	 SR2yccuSqrwQ6JEiZOR3L/hdErZWaOwfqQZRR3SyI2XraHCs7Bs0uLf74sZcMu3sFzmn+
	 5ogkHvoH9ZOrGjsi/gmVx/30R9V4YMpHsu3gNtpMtL3WgnHWUyPs31/xSXA1RJncMp292
	 fY4qSyTmxcRnNfOHfOPIEBwm89nEXLZKwgl1UGF1GdQ9L2tzistub/Kod2LDoozG2uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675876;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Bq8RxOjp221zCtPe1b7ySNgeViySYgXEXgz3pYeX0SQ=;
	b=z/ZbWGJnp8H0LX5pTg9ory/VIg/QfX7NNTVHL6xgospdzfeMQdTqSgBd65afE8xPoX0g
	 oXRlz7tz6z980Ow9FKVYL9nDzNaxNextFb/HirIhO6Ibitb5AYXN90tbVG6ci7xCFWvxz
	 slnooWV4cGODVYLgAh6BvXglSbqSEb2y/JG5AMfx9wCdXLeGMY4qXZgr0MwN0wKtHHmez
	 w2rsy+TZ9Htby8zhtQtbp4VmpbM9Q+hAu7+jfmO50LkOp1QfAOWvnjox5ThlhdrSUxUnj
	 NyOVIvEj1quNBNPAmRcSbu8oPFi76A8FYWLV2K8O0QfpLvTrGf9T0Q+IRb2wjB1BcSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RyF6tFSs;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31378606A324;
	Tue,  3 Nov 2026 03:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31378606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RyF6tFSs
Received: from [192.168.166.159] (unknown [67.168.101.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8037E20B7166;
	Mon,  2 Nov 2026 19:17:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8037E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793675861;
	bh=Bq8RxOjp221zCtPe1b7ySNgeViySYgXEXgz3pYeX0SQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RyF6tFSsYqXm9Tp4+4N/XOnFIwW2lrHGXaHlZIlq4MPN0j0IplShWpzIYBlPy5MeV
	 oQMB05jEY1RJ1LDQ/KzVf+VSv0kRgouPv9xpRLvjldr4wQyiXc/XmqIP+RzmhWXX8J
	 onuVe6gt7rrUN7PgRRsxwVrTk6FI+cNaV5ZOY9Ds=
Message-ID: <dc41f6b6-413f-4340-9579-6853f2d5d565@linux.microsoft.com>
Date: Mon, 2 Nov 2026 19:17:55 -0800
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
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V3 3/5] mshv: Import data structs around device domains
 from hyperv headers
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
 <20261103025150.3192119-4-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261103025150.3192119-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/2026 18:51, Mukesh R wrote:
> Copy/import from Hyper-V public headers, definitions and hypercalls that
> are related to checking for device domain availibility, and mapping and
> unmapping of device pages.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 ++++
>  include/hyperv/hvhdk_mini.h | 15 +++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 966945f0504f..606b16f43e16 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -327,6 +327,8 @@ union hv_hypervisor_version_info {
>  /* stimer Direct Mode is available */
>  #define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
>  
> +#define HV_DEVICE_DOMAIN_AVAILABLE			BIT(24)
> +
>  /*
>   * Implementation recommendations. Indicates which behaviors the hypervisor
>   * recommends the OS implement for optimal performance.
> @@ -489,6 +491,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
>  #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
> +#define HVCALL_MAP_DEVICE_GPA_PAGES			0x00b3
> +#define HVCALL_UNMAP_DEVICE_GPA_PAGES			0x00b4
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 57b70efe60d4..2bb757e00d86 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -549,6 +549,7 @@ union hv_device_id {		/* HV_DEVICE_ID */
>  } __packed;
>  
>  /* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S2	0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
>  #define HV_DEVICE_DOMAIN_TYPE_S1	1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
>  
>  /* ID for default domain and NULL domain */
> @@ -657,6 +658,20 @@ struct hv_output_get_iommu_capabilities {
>  	u64 pgsize_bitmap;
>  } __packed;
>  
> +struct hv_input_map_device_gpa_pages { /* HV_INPUT_MAP_DEVICE_GPA_PAGES */
> +struct hv_input_device_domain device_domain;

Nit: Needs whitespace

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
>  /* HV_LOGICAL_DEVICE_PROPERTY_CODE */
>  enum hv_logical_device_property_code {
>  	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU = 10,

