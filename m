Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E82E266C
	for <linux-hyperv@vger.kernel.org>; Mon, 21 Sep 2026 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031866; cv=none; b=CqpiiOMwK55J+k0KTJc7HK0KimHQQFoUSvTnZxxH1Udnlzi6Xsu5Xdu1hrjjEFldptGadH0lP3a8INhpOFOlhlPlRB7ckjLcwXC3jtOvmEi8U5Ur3Ey93aM7VnugXS+IPamQI+Gr/8NmKvN75j03jPVXRu341LN3OBDs/MEaQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031866; c=relaxed/simple;
	bh=If2W+fhEti6pmKYAWSmHr7q4uP7gCjlEm4p+uixMn0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J7r0czicwZk+wBsJr6ZwAAt/SxEtfeTCZqkSko0gn6TSLxslIg6ihseWvgS4075VRcuxQul9Ish+SDTN5ynCaIZ7sDsWhF6yyiPI1T6d/ybklLqg/dtE9fU9NlAQTcLh3Zote1xMczrZdyo34IU18x846t8RZZcecu7DF6im/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9Oi2ofa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9Oi2ofa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45FE1F000FF;
	Mon, 21 Sep 2026 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790031864;
	bh=opIKO1Uy4rtdTzR24tyGykLxP3pjQzjJELcHJ/GAJys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9Oi2ofaIh3LFYd1YLMN8YJeLIbP6HI846YB5PGBoqZ5AV3aF9XZHsupR3rnBhgzu
	 vcToN2d2VUzs9+7dZJI8bEi8FDmt3t5mmb0cGjoK+VO+fuuGSJfHVY3NL3sJI4CaE2
	 6xO+y/FTIrWI+LUWf0uCbaVGVXNXu0xHEYiWpY/xmuMDEQVzrDgne5/VjW/JYya7N8
	 fBGLoXB0ofiyCzL0tLb4Fuyi/wZ3ol60gJUD673je3niyTGHLM7TyT2MfrXvAY1HNr
	 86YRq9OBN+h27yuCKBGNho5aeK15ZHLSoAAK2+vxbdv9CsDgn6SS8bf4/lrMy3jJce
	 CRtPEU1svNXeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V0 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260921225028.4007330-4-mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:04:24 +0000
Message-Id: <20260921230424.B45FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] iommu: Flawed partial unmap logic causes memory leak and over-unma=
p in hv_iommu_map_pages
- [High] iommu: Incorrect assignment of IOVA aperture_end restricts DMA add=
ress space
--

commit c33bf0d2ad36d04023ab67f38b30621e50f3b924
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement root VM IOMMU kernel only driver

Adds a new kernel-only virtual IOMMU driver that works with the Microsoft
Hyper-V hypervisor on privileged root VMs. The driver communicates with the
hypervisor for managing paging domains and device mappings.

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> index 0000000000000..a5268e0e52cc2
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,645 @@
[ ... ]
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
[ ... ]
> +	hvdom->domid_num =3D unique_id;
> +
> +	hvdom->iommu_dom.pgsize_bitmap =3D HV_IOMMU_PGSIZES;
> +	hvdom->iommu_dom.geometry.aperture_start =3D 0;
> +	hvdom->iommu_dom.geometry.aperture_end =3D hv_max_iova_width;

[Severity: High]
Does this directly assign the bit-width value to the maximum address bounda=
ry
instead of creating an address mask?

The hypervisor capability max_iova_width returns the bit-width of the
supported IOVA space (e.g., 39 or 48 bits), not the maximum memory address
mask. Since the IOMMU core uses aperture_end as the absolute maximum address
for IOVA allocations, this seems to restrict the DMA address space to a
scalar bit-width value, which could cause any DMA mapping requested above
address 39 or 48 to fail.

> +	hvdom->iommu_dom.geometry.force_aperture =3D true;
> +	hvdom->iommu_dom.ops =3D &hv_paging_domain_ops;
[ ... ]
> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
[ ... ]
> +	if (!hv_result_success(status)) {
> +		size_t done_size =3D done << HV_HYP_PAGE_SHIFT;
> +
> +		hv_status_err(status, "pgs:%lx/%lx iova:%lx\n",
> +			      done, npages, iova);
> +		/*
> +		 * lookup tree has all mappings [0 - size-1]. Below unmap will
> +		 * only remove from [0 - done], we need to remove second chunk
> +		 * [done+1 - size-1].
> +		 */
> +		hv_iommu_del_tree_mappings(hvdom, iova, size - done_size);
> +		hv_iommu_unmap_pages(immdom, iova - done_size, HV_HYP_PAGE_SIZE,
> +				     done, NULL);

[Severity: High]
If a batched mapping operation fails midway, does this error path
inadvertently leak mappings and over-unmap pages?

When splitting the software tree mapping, the error path calls
hv_iommu_del_tree_mappings(), which blocks removing the unmapped tail becau=
se
it does not support splitting:

drivers/iommu/hyperv/hv-iommu-root.c:hv_iommu_del_tree_mappings() {
    ...
    /* Splitting of a mapping is not supported at present */
    if (mapping->iova.start < iova)
        break;
    ...
}

Subsequently, does the head unmap via hv_iommu_unmap_pages() delete the
entire software node and use its full original size to unmap pages from the
hypervisor?

This seems like it would send out-of-bounds unmap requests for pages never
successfully mapped, and abandon the correctly mapped pages since the
software node is destroyed.

> +		if (mapped)
> +			*mapped =3D 0;
> +	} else
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921225028.4007=
330-1-mrathor@linux.microsoft.com?part=3D3
