Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845704;
	b=zQl/PlYatqkozFcP7QYHiIcU9LSgNEgsnKTzyZdxBTt/a/PwZ8L/I0uveG+PUzEcD39O
	 VYWapGTMOMzs87RKVRpbL9If7O13RdsApb3KRQghV4FiLpw9sSEd6VdaoMO18PaBZPoFZ
	 B38bpnElO6A5+G3ryX6/Uo+kNrkPtVho9BNkNKqP/aX3x1XUuuyXSqclpIxLYmA9Ym/lz
	 nDc8XfxC0wsNX5IbRrwtIivwEDh1bmk1hMr3K1vqGAyHTcCMvFwJM1ICSvT9OZysswqwi
	 EPFqUymFF4V0D6iB0KmAwP240bM2WNGnfonZJMs9AlSo1Y2ws3Zo1V6ZjhPD+cfs+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845704;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=FmmXWVdRKlPeYvexviwuw46I9mYN5w7ULuP4BQ7wPos=;
	b=3OScXO5limReP/aJ3W4Ynk1Ow5QvUP2chqIXEdlkcHdLpjJut3KCaAtpq2hnC/tsNz1a
	 qvYnLvj5SQyXiNIflWBUx4kClw8Xo/l3UeNUqA6utitjQNeNbdITSmABg8t6J+2FVWGVk
	 d7UXhCPOi6kp1TGkWpgR5Qwu+uu7GMFwSK14edqlhlgw9ftkdeXtO4P134Hq5FVTzLT/3
	 J1oNZL3ZA0xCAp2dmSLNXWiYFZ/ghIiyOFUazmno7XWwVvPYhF0g0srmEPvjCMYa4umD8
	 guaUO9hSXO/wmBaPG/oFblje5o+I3s4wkuiyf6owi5YzPq3dIjDkg08IqgICC9KCB7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BMwjrUJ8;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60037606A31C;
	Mon, 16 Nov 2026 16:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60037606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BMwjrUJ8
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C0E620B716A;
	Mon, 16 Nov 2026 08:14:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C0E620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794845696;
	bh=FmmXWVdRKlPeYvexviwuw46I9mYN5w7ULuP4BQ7wPos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMwjrUJ8gREvhRz6TqItstvkqCYyX88nhBpGsvhwPxOyFbv3LfPodU67TrXzZlRlb
	 NKuDoRcxpoWH2sxURRQKNjRtojtj2qUmZVL1/wu4FYKNSds1wy37ii13K5vjO8S4tT
	 nrwtk5aGg2V3ivpvQTcL5u8g96GhH/55fnPafd8s=
Date: Tue, 17 Nov 2026 00:14:59 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/hyperv: Keep a new domain's page tables if
 it cannot be deleted
Message-ID: <3gb5f2c2v3tkpuggzybek5nhmcv3zjgjjyaxtohsdjujrb5gbw@oki5fmryytxf>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
 <20261112195710.1417744-6-oss.patchbox@gmail.com>
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
In-Reply-To: <20261112195710.1417744-6-oss.patchbox@gmail.com>

On Thu, Nov 12, 2026 at 02:57:00PM -0500, Yuho Choi wrote:
> When hv_iommu_domain_alloc_paging() fails to configure a new device
> domain, hv_create_configure_device_domain() deletes the domain again,
> and the caller then frees the page tables with pt_iommu_deinit(). If
> the delete fails as well, the hypervisor still has the domain, which
> may already point at the page tables, and they are freed anyway.
> 
> Create and configure the domain in hv_iommu_domain_alloc_paging()
> itself, and leak the page tables and the domain when the delete fails,
> as hv_iommu_paging_domain_free() does.
> 

My understanding is that, for the newly created domain, current Hyper-V
implementation does not adopt the supplied stage-1 page table root if
HVCALL_CONFIGURE_DEVICE_DOMAIN fails. Therefore, a failed configuration
does not leave these page tables referenced. It is different than the
hv_iommu_paging_domain_free() case.

But I'm OK with keeping this as defensive error handling. Could you update
the commit message(the comment above hv_delete_device_domain() as well) to
distinguish that motivation from the behavior of the current implementation?

B.R.
Yu

> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
> Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  drivers/iommu/hyperv/hv-iommu-guest.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
> index aa1db9db1e97..ef486ffa0be4 100644
> --- a/drivers/iommu/hyperv/hv-iommu-guest.c
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
> @@ -540,10 +540,18 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
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
> +		/* See hv_iommu_paging_domain_free() */
> +		if (hv_delete_device_domain(hv_domain))
> +			return ERR_PTR(ret);
> +		goto err_pt_deinit;
> +	}
> +
>  	return &hv_domain->domain;
>  
>  err_pt_deinit:
> -- 
> 2.43.0
> 
