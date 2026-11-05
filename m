Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853274;
	b=lmN5CJB6k7z/xmXgw2sqK7Lnbf36d8+8I1kMcfKQ6UL/xPk6m4ywsKecE0i9QCdTXyt7
	 fCfiYD823FqE2gEApMblYZ2xUtncGTuDp62hAFyo7V4fWnbx6aYbgu0MY4OgHP+r1e/ho
	 OakcYjlhCfzCMBF8cof7SALIeHPj4HJtKvljpOaTj6Tt3hw7Y4isWcjzQXQnE9FggLcIN
	 t2RFV/RAZse5+mXNtc41bqdMiS5nwKc+2IFAyBMVzf5Anri8S7pnI55IdYzf8X4gU2aJ4
	 SbelkzgYfVdgebr6H6+aQGccIw8CzCSlR2VlL8WEe4DGYV6hz5W+Mi09mcEkAedxrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853274;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=uybwsAJQuB7JYpjUDH4A7OxDLSrNrGRSbd7CyU7FLoA=;
	b=DiJ9Ia5o0rbYgVnMe9iSCqMvmYB+aiROGJ6s63PtcENorza1evDjJXOF2WFaQZqLFIHA
	 VR6eLt92+fI3PnqkkB3aSVESTgw9l9Ob7pl7hCPyAhgXUl218gzdoMi4J7dREf/A9OLXX
	 sOQplzmcMAQywstz4Ylio7zRBwOQZEFZQnP4RfNt/G+PVfJcz9vxvI89Rv1Q+fH5u6iD4
	 teb2wbDJsx7hONcWnw3zkslu3mOYG1dvb3YDJ0pb1anw7rmUCrGH3CbTj/e1ftQiG6S41
	 +BzUgPn1YnV+uOi45wwGeA15aOKj4RadvIVebRNNlay5WYDsyFxizrPsTW5CQb5IMSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBI1fbuT;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0420E606A335;
	Thu,  5 Nov 2026 04:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0420E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBI1fbuT
Received: from [192.168.166.159] (unknown [67.168.101.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26DFC20B7168;
	Wed,  4 Nov 2026 20:34:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26DFC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793853257;
	bh=uybwsAJQuB7JYpjUDH4A7OxDLSrNrGRSbd7CyU7FLoA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IBI1fbuTwD+Mh2OnOY0JrkHzfSgXQNIRc7sEUtfZifblMLrC5P0ImROdvMimnb8/s
	 r2jdnbTxTYBTdXcVgT4dWaIYMd6ZJ90dyFGZ2pfZkk+CKtaXbSyHV+aJvfL5HOBW0G
	 MTD+MmvCwofQHLzmOMtERvlFNs55y3S0+4P2RqwE=
Message-ID: <9558730f-42d5-4d90-8fe8-f6d1c150164f@linux.microsoft.com>
Date: Wed, 4 Nov 2026 20:34:32 -0800
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
Subject: Re: [PATCH V4 4/5] iommu/hyperv: Only call pviommu init on non-root
 VMs
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-5-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105020106.3496339-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 18:01, Mukesh R wrote:
> Next patch introduces root iommu init. Since both can co-exist, set
> x86 iommu_init to pviommu init only on non-root VMs. Also, rename
> hv_iommu_init() to hv_pviommu_init().

[...]Lastly, check for null iommu_init
> before assignement as suggested by one of the pviommu authors.

You no longer do this below. Also, please wait a week or so before spinning
a new revision to collect additional comments.

With that fixed,

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c             | 3 ++-
>  arch/x86/include/asm/mshyperv.h       | 2 +-
>  drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b90e6f487533..ea50708c3ae6 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -580,7 +580,8 @@ void __init hyperv_init(void)
>  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
>  
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -	x86_init.iommu.iommu_init = hv_iommu_init;
> +	if (!hv_root_partition())
> +		x86_init.iommu.iommu_init = hv_pviommu_init;
>  #endif
>  
>  	hv_apic_init();
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 24b19cd28a05..c95d75ae645e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -320,7 +320,7 @@ static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>  #endif
>  
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -int __init hv_iommu_init(void);
> +int __init hv_pviommu_init(void);
>  #endif
>  
>  #include <asm-generic/mshyperv.h>
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index 876a22f21f1e..a40a8ceb3261 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -601,7 +601,7 @@ hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
>  	hv_iommu_device = hv_iommu;
>  }
>  
> -int __init hv_iommu_init(void)
> +int __init hv_pviommu_init(void)
>  {
>  	u64 status;
>  	int ret = 0;

