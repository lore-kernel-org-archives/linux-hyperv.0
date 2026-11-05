Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916879;
	b=g/1cKVW9/wNmAUq0DxFoP9m3TjGdPVeQXCh0ucy95VKECxc3F/cOIUjBR/NZPAkCbvBO
	 ONA6hRYiqidr9a5wz2waMJN+3JeRPf9zt5cc8iLRIYWSDi6rT2HcFBtVJHW3CHh4k8pZu
	 EbowM7DEO5Q9pIaCKPmzEQYAVvBTcKnvU2aMKo0iwjkg4HvmH2jhaQjheuSHf523zSO1X
	 uoo7CU8jrgPY+BTNqDRr603MjllUyRdfVbL1PZDm7QlrNMJCL5qLXEjpNBQv/uGD9w5Q+
	 uSto0mNSM0EW11MZtHJQoRKEbeJhdKYl9VWgdLr3GY9cLSRnTivgpItG6ITqDlhXMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916879;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=08xVfqwoODhdy7Z5d43JBdvRsvLM4il+VNHhvskDFF0=;
	b=SLbLGWm1OfpIdzzxf5KyeA7vKoM+57n/qfmfHpqcxjTIoV2JBYYBan5ttOfnF0jaJ7BP
	 3k5l/IdiAiUv8emtKOxiqdSUnW4Q6mIc6z3EX3kzXz4TnkxphtG1LP3f6cJzZnyWPxm+y
	 6XgwUOQBwrbHdh6GQfp5wCn8EJt6/ZVh9wsE8frkClkyyEiAp04BlMBNLZbpWDaLnALUW
	 dVbU86z1HCyV8rlL/iPR8Ga6PlFzhpLgcuoUXeDLiQddrQa713VLdQDTZS2hOkjEaveJl
	 CJ4DdrnCxI1uc7Y8ZIvco7708H98WT4Sg6lbzkfRW3s03RNiwIjRmD8IQ1Kz1hwF7jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="Aa/Ir+WX";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B24606A329;
	Thu,  5 Nov 2026 22:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B24606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Aa/Ir+WX
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB48120B7167;
	Thu,  5 Nov 2026 14:14:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB48120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793916862;
	bh=08xVfqwoODhdy7Z5d43JBdvRsvLM4il+VNHhvskDFF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aa/Ir+WX1H0Ko9TPtatYspe0gu2F5PzZuWlQLEQ2FqIVIXJDN9GaWZzINB55qH9km
	 oiujQMpQQ5V3HVkeokWtV9BxZqhzNzSCyqZikhFHzL29NmMHWiJy2opEgOgd/mHMjJ
	 02rR1s9YNBcScvDQ9JSz+bI81jMPBdlZN/zK5aO0=
Date: Thu, 5 Nov 2026 14:14:27 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Yu Zhang
 <zhangyu1@linux.microsoft.com>, Easwar Hariharan
 <easwar.hariharan@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v1] iommu/hyperv: Don't free a paging domain the
 hypervisor did not delete
Message-ID: <20261105141427.00005946@linux.microsoft.com>
In-Reply-To: <20261105192738.70664-2-oss.patchbox@gmail.com>
References: <20261105192738.70664-2-oss.patchbox@gmail.com>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yuho,

On Thu,  5 Nov 2026 14:27:08 -0500
Yuho Choi <oss.patchbox@gmail.com> wrote:

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
> page tables and the domain if the hypervisor fails to delete it.
> 
> Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU
> support for Hyper-V guest") Signed-off-by: Yuho Choi
> <oss.patchbox@gmail.com> ---
> Compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
> W=1); I have no Hyper-V guest with the para-virtualized IOMMU to test
> it on.
> 
>  drivers/iommu/hyperv/hv-iommu-guest.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c
> b/drivers/iommu/hyperv/hv-iommu-guest.c index
> 876a22f21f1e..205c642c8d40 100644 ---
> a/drivers/iommu/hyperv/hv-iommu-guest.c +++
> b/drivers/iommu/hyperv/hv-iommu-guest.c @@ -107,7 +107,7 @@ static
> int hv_create_device_domain(struct hv_iommu_domain *hv_domain) return
> hv_result_to_errno(status); }
>  
> -static void hv_delete_device_domain(struct hv_iommu_domain
> *hv_domain) +static int hv_delete_device_domain(struct
> hv_iommu_domain *hv_domain) {
>  	u64 status;
>  	unsigned long flags;
> @@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct
> hv_iommu_domain *hv_domain) 
>  	local_irq_restore(flags);
>  
> -	if (!hv_result_success(status))
> +	if (!hv_result_success(status)) {
> +		/* The domain still exists, so its ID cannot be
> reused */ hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN
> failed\n");
> +		return hv_result_to_errno(status);
> +	}
>  
>  	ida_free(&hv_domain->hv_iommu->domain_ids,
>  		 hv_domain->device_domain.domain_id.id);
> +	return 0;
>  }
>  
>  static int
> @@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct
> iommu_domain *domain) {
>  	struct hv_iommu_domain *hv_domain =
> to_hv_iommu_domain(domain); 
> +	/*
> +	 * If the hypervisor still has the domain, it may still use
> its page
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
Looks good but I think it is incomplete.

if both hv_configure_device_domain and hv_delete_device_domain both
fails in hv_create_configure_device_domain, then unwind code will do
pt_iommu_deinit thus have the same UAF problem.

        ret = hv_create_configure_device_domain(hv_domain, &settings);
        if (ret)
                goto err_pt_deinit;

        return &hv_domain->domain;

err_pt_deinit:
        pt_iommu_deinit(&hv_domain->pt_iommu); 

hv_create_configure_device_domain(struct hv_iommu_domain
*hv_domain, const struct hv_device_domain_settings *settings)
{
        int ret;

        ret = hv_create_device_domain(hv_domain);
        if (ret)
                return ret;

        ret = hv_configure_device_domain(hv_domain, settings);
        if (ret)
                hv_delete_device_domain(hv_domain);//fails here

        return ret;
}
