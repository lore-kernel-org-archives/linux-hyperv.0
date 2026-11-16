Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844705;
	b=SEVVFG1HlYdMGzzRH6e1zR803R9ccrgXImoQ+ChfmIj7+r0zC7KsE8KVZ55U6092CWJ4
	 mVl3AkWenCILcLzBkMhP96wDS2h86U80LBcMgbf6FC/2eA3r1aPFUWAGNT42tiHWPQZRu
	 Ry5vR22SLbya4/01GXwDkoOyR0IS/5q7muEptKSsktNYcvGYwmkdk+M6W6TnbEQEgrz7h
	 VXBizV2VOQnEitDTl2KptewrGAQczngzgrv4IaAL6X0lghnu4jvP5Dq8wqX7bu7hVCVhC
	 KwhPfIiAyatfOnwuAJsX6nll9NtzQS9PVn0uDWdxtTWmlUAGNXCnAZAvotPkHxw2bSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844705;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=u4SFVD7jxf9RuHxTJCNcwPNhfgv8lj7Sm/PppY2wowY=;
	b=rqFukH+4p02RvjZC1WVo2be9GHIIIB4EW1DGKvQWLjAb59xMs+EiZLoIUBZWgxs7z9I/
	 0cvRqJGuov04Xa0JN46g7Hb6EqRBPL51OufeeKmuIO0DelQD2AOq1Ca5NLMCK14pHr/sU
	 5nNhs8ZI6Iqrjow/hksgkOANM3PqOdwpBxgx2MY3epomeEumoCjHYgr1dFKVmblIQi0Xz
	 BDNPTxlo4i3lD3GfXuBv1MhApNk7Z0jMzEDaAMxGWoiMYxpwARzb7TU3tqy6JEihrjh6w
	 jqySDBsOhhA+cmUhbey6aj3wUBF6X0E+3kjCh91rbHMs+HgNQ0RfcW5Y+BJYhDSJysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=loQEIcb2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B503606A323;
	Mon, 16 Nov 2026 15:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B503606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=loQEIcb2
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 301BC20B7168;
	Mon, 16 Nov 2026 07:58:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 301BC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794844697;
	bh=u4SFVD7jxf9RuHxTJCNcwPNhfgv8lj7Sm/PppY2wowY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loQEIcb2c0PH3xTtaO4N/BcjSBsGzV+Qn6Ka1RCJcvrh7+BEXzpo2pMvSn3dmAkuy
	 qgBv1BzG2UuVC5gmT0+vIeqk6ktzLeNYnq3t+I8LB3Rcka/nc1e4Z2F37YYy93qlC0
	 JXQbiR6a3R++PzfiSIbtihHj/U9Il5T2Ujwm/zX8=
Date: Mon, 16 Nov 2026 23:58:21 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <wvvoqqavra5lvqi3hnvcgl4y3jzbk3b2f6h7vlkwpksjuqgoqm@rhzwlj2ieozi>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-5-oss.patchbox@gmail.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112195710.1417744-5-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:56:59PM -0500, Yuho Choi wrote:
> hv_iommu_paging_domain_free() frees all page-table pages with
> pt_iommu_deinit() and only then asks the hypervisor to delete the
> device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
> fails, hv_delete_device_domain() only logs the error, returns the
> domain ID to the IDA, and the domain is freed anyway.
> 
> The hypervisor then keeps a device domain whose page tables have been
> freed and can be reused for anything. The ID is also handed out again
> by the next paging domain allocation, while the hypervisor still has a
> domain with that ID.
> 
> Delete the domain before freeing its page tables, and keep the ID, the
> page tables and the domain if the hypervisor fails to delete it. WARN
> when the delete fails, as the domain is then leaked.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index 9f4fa4315091..aa1db9db1e97 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -107,7 +107,7 @@ static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
>  	return hv_result_to_errno(status);
>  }
>  
> -static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> +static int hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
>  {
>  	u64 status;
>  	unsigned long flags;
> @@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
>  
>  	local_irq_restore(flags);
>  
> -	if (!hv_result_success(status))
> -		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
> +	/* If the domain still exists, its ID cannot be reused */
> +	if (WARN(!hv_result_success(status),
> +		 "HVCALL_DELETE_DEVICE_DOMAIN failed: %#llx (%s)\n",
> +		 status, hv_result_to_string(status)))
> +		return hv_result_to_errno(status);
>  
>  	ida_free(&hv_domain->hv_iommu->domain_ids,
>  		 hv_domain->device_domain.domain_id.id);
> +	return 0;
>  }
>  
>  static int
> @@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
>  {
>  	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
>  
> +	/*
> +	 * If the hypervisor still has the domain, it may still use its page
> +	 * tables, so leak them.
> +	 */
> +	if (hv_delete_device_domain(hv_domain))
> +		return;
> +
>  	/* Free all remaining mappings */
>  	pt_iommu_deinit(&hv_domain->pt_iommu);
>  
> -	hv_delete_device_domain(hv_domain);
> -
>  	kfree(hv_domain);
>  }
>  
> -- 
> 2.43.0
> 

Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>

B.R.
Yu

