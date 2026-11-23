Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426403;
	b=pnNr65fNshkJSXWUwx+Xi/exbrUL4TWYIL5+CJk3sEoO+EBVtNOT9CMdwgdDy+p0ivha
	 dafJLUt1E1tzL8GaGqz1Q6hTJBud4KrwtFDYsDzlrrtVysdjw+Xe0r1ap6uPAyD0DlvPN
	 BIef8rgYPNS66W1Nnlb0kDAr0pKZXDyEXKndAZS8R15WhjsXYgX7ViyVXljDW1TdWQMp3
	 2AE1GYNYBeBt3uyHRDb2Igyt+Ye1xomwC4xA6mpWAId+7SvkQne7WzRweLrXMfdh8ukc+
	 8S2bTD1LvCrbvUJD3G01e5lqNZZpW02L9qeR8p4B6+GoHcUL8aH25Bepcwl9qHcdK4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426403;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=jKhKtTQjIJE6EfezE1d2i+cGBwefJa4Rpfrdc7KyzQg=;
	b=FU9P/5hbMeZbPTIWsKPrs9bgWxL0nvISZnvsG99gDI3z2J0vfIn7nGa0l1FftOBVoZks
	 hKtaOE9KpdB/G85WBjQVjnxs4YdgddlDsCDyFXvrKsGZMBMbhOwGCpMxEUxZGzctn0S7P
	 dlVuxfO9ow9hXG7WdN8pVgMoUvRl4Z7MUEcQoKNVSZxME0LL03r2E6ZVWpGqewMBPr6af
	 oVCHM8KqiGTGea41TN6UIn17fJfRD5Tjy+HkiH7sRJeQe5sW7n5Dn1vBh6wE5UtWVo5Pw
	 qaCJMAREL1xUSvADeNOD/q8Z/KY6tpyK+21xx/4MfGQvLtJz7x0SGtPN4nPGz7/QwfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MBHCxdZZ;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE76606A32E;
	Mon, 23 Nov 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE76606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MBHCxdZZ
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D05E20B7167;
	Mon, 23 Nov 2026 01:33:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D05E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795426392;
	bh=jKhKtTQjIJE6EfezE1d2i+cGBwefJa4Rpfrdc7KyzQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBHCxdZZeHLGsZAYcZ5DvIphhCAlf1qfltfp4ConW7vvy4yWxm+cNC17BJmr7jZf0
	 xBfznlulWTDhnmupSW8O/8COGnre75kK6seImc56vpMhqPifFHWg6baTnw4IDhrBb/
	 SvGDfDUNQUcHbFt/c419OhfGpiL2hbtvtF8uiOkI=
Date: Mon, 23 Nov 2026 17:33:13 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
Message-ID: <hfqiba643klm6y2onbgipn3hc3obyywhn25wl7daqdf4uu3tlq@52oylmrpaujg>
References: <20261123060419.119078-4-oss.patchbox@gmail.com>
 <20261123060419.119078-6-oss.patchbox@gmail.com>
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
In-Reply-To: <20261123060419.119078-6-oss.patchbox@gmail.com>

On Mon, Nov 23, 2026 at 06:01:56AM +0000, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). The
> page tables are freed even if the delete fails and the hypervisor
> still has the domain.
> 
> The current Hyper-V implementation does not adopt the page table root
> when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, so the page tables are not
> referenced in this case today. This change is defensive: it avoids
> relying on that while the hypervisor still has the domain.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index aa1db9db1e97..0110a1529a23 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -540,10 +540,23 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
>  	settings.page_table_root = pt_info.gcr3_pt;
>  	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
>  
> -	ret = hv_create_configure_device_domain(hv_domain, &settings);
> +	ret = hv_create_device_domain(hv_domain);
>  	if (ret)
>  		goto err_pt_deinit;
>  
> +	ret = hv_configure_device_domain(hv_domain, &settings);
> +	if (ret) {
> +		/*
> +		 * The current hypervisor does not adopt the page table root
> +		 * when the configure call fails. Still, keep the page tables
> +		 * while it has the domain, as hv_iommu_paging_domain_free()
> +		 * does.
> +		 */
> +		if (hv_delete_device_domain(hv_domain))
> +			return ERR_PTR(ret);
> +		goto err_pt_deinit;
> +	}
> +
>  	return &hv_domain->domain;
>  
>  err_pt_deinit:
> -- 
> 2.56.1
> 

Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>

B.R.
Yu
