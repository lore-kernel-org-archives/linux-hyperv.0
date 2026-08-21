Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E562DCC1F;
	Fri, 21 Aug 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319927; cv=none; b=aUqybH+u5j753+CWGnKxEQtyjcptik/Vfnfs+RDG7d8+ubgEeY40ZgCMkZA97+2Z9ANXhhWPiajkg7cUnRQxMkeDj58IGUp0SqpGs1NcdZlxNgKCZYnrJ6y4n2Tlb0SFj/UK9YQoIfxYkpRAk6Y0uPHGtXILJAmjnK95gu8XXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319927; c=relaxed/simple;
	bh=XZt/wP93io+V1ihPKRMgm+f+8k+9gOd8QkHUKe+b9/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CbHi5LbPx44yHNTCBu/0Z5e6JuBr4Tc8cNAoJWXj07VPQoG6JJroWYfPKuRQYxoNstEssw7nam6xNzqyreppqiSSDA3AcNRFrw3BMM8b+pxwpWhy40IWEP0okNZNySC0F8nIwobxSB75546b94QwTc7GOmZc/LLEcbfy76ONic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l08xwkhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l08xwkhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB931F000E9;
	Fri, 21 Aug 2026 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787319925;
	bh=m8n7kkzdMdTjnqjj5Mbc+6f9BdiDyWSS2yXusFzV2AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l08xwkhIIw+0/4tR+qH+gDqgBbwSJznJkGdg/4h/1+w6TufeuB7Wzgvqg1APKyf9B
	 Qb44CcOn3xCAPflUuqcyezHBDlGnjoLOyuUZ4DY8Kp95/7AVl8nhhxNPmAJZcbUKrV
	 9bZ6WMtNUBNgAjPoXVCmOqlLrpMRrF05/eZXhT/FzY0Xarp+D9LzQmflGZdY3+k84J
	 1GqXj7Se8oBO0tVJoB/JTa1ptttPQJgffrHNMD7qtjeFRqYBAisFNLpVu4duHZQvm3
	 U4OCrLl5gu8zKeCCCu30aLHVCHuLUo+MSLRg/hq4YAALBQ9ADsGsgave7TkGRHQLhf
	 cEOULILBfpnRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260821132654.211730-5-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:45:25 +0000
Message-Id: <20260821134525.ADB931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Page tables are freed before deleting the device domain from the h=
ypervisor, leading to a Use-After-Free risk.
--

--- Patch [4]: [PATCH v4 4/5] iommu/hyperv: Add para-virtualized IOMMU supp=
ort for Hyper-V guest ---
commit 7152dacb77d4624afa4df5d0624b6de801e9959e
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

This commit adds a para-virtualized IOMMU driver for Linux guests on
Hyper-V. It implements stage-1 IO translation in the guest OS and integrates
with the Linux IOMMU core utilizing Hyper-V hypercalls.

> diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv=
/hv-iommu-guest.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-guest.c
[ ... ]
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);

[Severity: High]
Could this cause a use-after-free of guest memory?

The guest kernel frees the page tables by calling pt_iommu_deinit() first,=
=20
returning the physical pages to the allocator while the hypervisor still=20
holds a reference to the page table root for this device domain.=20

If the hypervisor accesses the page tables during the subsequent=20
HVCALL_DELETE_DEVICE_DOMAIN hypercall (for cleanup, nested cache flushes,=20
or shadow unmapping), it might read or write to reallocated memory.

Should hv_delete_device_domain() be called before pt_iommu_deinit(),=20
similar to how teardown is ordered in the hv_iommu_domain_alloc_paging()=20
error path?

> +
> +	kfree(hv_domain);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821132654.2117=
30-1-zhangyu1@linux.microsoft.com?part=3D4
