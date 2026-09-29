Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C03B42C5
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722111; cv=none; b=ptuRcgW2ZX3J+wrbpY+5Gbta/T5r6UqYclAfUW8OvxbFHnjWd6j0xgcegL2wUdwLHSCmvWwPOQs1EIqgbDJmYe8hnbPKYfoLPKvT2Kuaq03aJI597DuUMk5MAFkZ0DHJv3uQELZdIJWltUvIKyvDPWbtJFaqA+mTWu8Vb08yf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722111; c=relaxed/simple;
	bh=xwjSR/j8K7BVQsjAq9GGdTnsGAT/bQcYbKoUGJP2/N0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bh5Om1Lo0JOPLAbb1bDETF25qKwa5DkR+M45MGtHItvLYWR66ZKuw2fHy/MPeOjB40IG/ASM905I32zpDGoLROXxV+meRcQBBTBLPBC0cmokzv3VdL2rcEanEbYFkQ88ntdicdjgKSBsZtkanmSnxD+QOjrasGpB5Pv2WQJFX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj4TMTkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj4TMTkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2ED1F000FF;
	Tue, 29 Sep 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790722109;
	bh=j/mzTBctLroCw4FEAEi9gydlBNxTRWioQqvBV7BB3YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aj4TMTkfZLenh5VlHCMDSr7+dkOAlbLad+pKqDLJSlJhPbvZDf6LL6ZIn2N4+6vEr
	 PoeasE9Xnkwg9vY/ZRgbF7uaPBPpmbMs/zkYDN2Dr9wk2pim0ZQIB6SmlmLxYFrC79
	 upVr+lnYJCQAwQhQoUcerwzGnS/buOEb2JiSuMRQHjFB17jGe3NgqmpaDgeIr7+2dL
	 TWRWpkFPXQd/V06l4gK7GC61ZYurK1oc3oEWLrI6AIjJmpMdZw16Abn55mwOQL5q74
	 Tc169RwZOr/XwKCrzUujyESPLKvoyc2Y2sq6oAW1d8K2/Usr6kEo/YtrYC2ZbN3ZpW
	 oWqLoiK5ODPiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 4/4] x86/hyperv: Implement root partition IOMMU
 kernel only driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260929223622.778617-5-mrathor@linux.microsoft.com>
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
 <20260929223622.778617-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:48:29 +0000
Message-Id: <20260929224829.AF2ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iommu/hyperv: hardware and software state desynchronization on par=
tial unmaps
- [Medium] iommu/hyperv: caller-provided GFP flags are ignored in hv_iommu_=
map_pages
- [Low] iommu/hyperv: missing select INTERVAL_TREE in Kconfig causes build =
failure
--

commit 3a4e409fbf35c471ff4e423714deeda11c2192b2
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement root partition IOMMU kernel only driver

This commit adds a kernel-only virtual IOMMU driver for Microsoft Hyper-V
running on root partitions. It registers the IOMMU device, creates identity
and blocked domains, and handles device attachment and page mappings.

> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> new file mode 100644
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Hyper-V IOMMU support
> +
> +config HYPERV_ROOT_IOMMU
> +	bool "Hyper-V IOMMU Device in root partition"
> +	depends on HYPERV && X86 && PCI_MSI && MSHV_ROOT
> +	select IOMMU_API

[Severity: Low]
Does this config need to select INTERVAL_TREE?=20

The driver relies on interval_tree_insert and interval_tree_remove, which
can cause a build failure if no other selected module provides the interval
tree API.

[ ... ]

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
[ ... ]
> +static int hv_iommu_add_tree_mapping(struct hv_iommu_domain *hvdom, ulon=
g iova,
> +				     phys_addr_t paddr, size_t size, u32 flags)
> +{
> +	ulong irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping =3D kzalloc_obj(struct hv_iommu_mapping, GFP_ATOMIC);

[Severity: Medium]
Is it intentional to hardcode GFP_ATOMIC for this allocation?

Looking at hv_iommu_map_pages, the caller provides a gfp parameter:

static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
                              phys_addr_t paddr, size_t pgsize, size_t pgco=
unt,
                              int prot, gfp_t gfp, size_t *mapped)

This provided gfp parameter is discarded when hv_iommu_map_pages calls
hv_iommu_add_tree_mapping. Using GFP_ATOMIC instead of the caller-provided
flags can cause allocations to fail under memory pressure.

[ ... ]

> +static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong io=
va,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	struct hv_iommu_domain *hvdom =3D to_hv_domain(immdom);
> +	size_t unmap_sz, size =3D pgsize * pgcount;
> +
> +	/* For valid input, the hypervisor guarantees unmap will succeed */
> +	unmap_sz =3D hv_iommu_hyp_unmap_pages(immdom, iova, size);
> +	if (unmap_sz !=3D size)
> +		WARN(1, "Failed to unmap device gpa(%lx/%lx)\n", unmap_sz,
> +		     size);
> +
> +	size =3D hv_iommu_del_tree_mappings(hvdom, iova, unmap_sz);
> +	if (size !=3D unmap_sz)
> +		pr_err("%s: could not delete tree mappings (%lx:%lx/%lx)\n",
> +		       __func__, iova, unmap_sz, size);
> +
> +	return size;
> +}

[Severity: High]
Can this sequence cause a permanent desynchronization between the hardware
and software tracking states?

If a partial unmap is requested, hv_iommu_hyp_unmap_pages irreversibly modi=
fies
the hypervisor hardware state first. Then, hv_iommu_del_tree_mappings is ca=
lled
to update the software tracking tree.

If the unmap forces a split, hv_iommu_del_tree_mappings bails out and retur=
ns 0:

        /* Splitting of a mapping is not supported at present */
        if (mapping->iova.start < iova)
                break;

Returning the 0 unmapped size from the software tree instead of the actual
hardware unmapped size causes the IOMMU core unmap loop to terminate
prematurely. This leaks IOVA space while the hardware has already unmapped
the pages.

Could the software tree boundary be checked prior to executing the hypercal=
l,
or should the core receive the actual hardware unmapped size instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929223622.7786=
17-1-mrathor@linux.microsoft.com?part=3D4
