Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630033B6C13
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2026 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216190; cv=none; b=SfTvjBlYRz4UIQemk2jJ6xS6VB5CxSoXxbeB3C8Tq0ESXROItp3WQwGfprpU+gKx+uugs7pkXxBMgit0V4xEruiE2kPB/QxEUS7nWZTSoOo9QUVTf1Ja/COka/GeLgsFeU28j2vfTI8eZoypIQMN8et/mJuwUDjYVgOTkXRGob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216190; c=relaxed/simple;
	bh=4xD3vN+K5euWXY8NXq0W6tebdcZiaQ7up68XqaCTqdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRENz37KwZ7dbtgPv/J5twNWnTrKzQZVh3JIH7cQl2excLWKo8KTTc3AkDDf81J5V3wQ/jjnBbCCXYctHaVSAnzF/xwXyY0D8+wXGnu5Mnp/lpkcAoC+vENAG+VQ78+SpVvrZA4RIviiaWQoEA2Nkg4vrJ7D+ET4HcAgyaOAgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPW61ErZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPW61ErZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C561F000FF;
	Thu, 24 Sep 2026 02:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216188;
	bh=mA6vbmjdF5+GSvs6VKXZt17mQLr43M6HYqV6DoHAWY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TPW61ErZ5Gw8dF3+4Aroth88pmUeWobeWTSloB/aqGzkRIqpOm8lDBOsSp7aCdub0
	 pvbuYUzf/AeyKt5UKtTR/Zb4mc4b7IeYNp6BsaEZ8kKl5bZvCmiRGP43kfTNWskbto
	 XmoR7SewVGlA8IGKSEUfbbf0jHBAgowrwLcDkB55uCkb3SE7oT9hEyzU3Jctjof8be
	 jUEdklVssy++JZEuMFm3tfcSwPsU9TvMDp+oAsempW6eFEiNZxxGTOPfpOFn6YgOEk
	 dgsSt7S/jAzLVqVxRH6kJ3u24PgjhkyxJtG9uwXvXw/vvzcwoU5Tb+pwkRVWO8zHFD
	 yZX8eSHg6Uhqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260924020221.128762-4-mrathor@linux.microsoft.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 02:16:28 +0000
Message-Id: <20260924021628.B3C561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hyperv: map_pages causes sleep in atomic context by ignoring gfp f=
lag
- [High] hyperv: memory leak and unmap failures due to unsafe interval tree=
 iteration
- [Medium] hyperv: undefined behavior via 64-bit shift in hv_iommu_init()
--

commit a7b3705b617a0eb04fd6acb14622b152cee82c8b
Author: Mukesh R <mrathor@linux.microsoft.com>

    x86/hyperv: Implement root VM IOMMU kernel only driver
   =20
    Add a new file to implement a kernel only virtual IOMMU that works
    with Microsoft Hyper-V hypervisor (aka MSHV) on privileged VMs aka
    root VMs. The hypervisor claims the IOMMU upon boot, and this driver
    communicates with it for creating and deleting paging domains, attaching
    of devices, mapping and unmapping of pages, etc. During boot, hypervisor
    automatically creates identity and blocked domains, so there is no need
    to do hypercalls to create them.  This is a kernel only driver and only
    supported on baremetal root (and not L1VH root) without any guest passt=
hru
    support. Support for guest device passthru will be added incrementally.

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> index 0000000000000..4c6ebaa8fb971
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,656 @@

[ ... ]

> +static size_t hv_iommu_del_tree_mappings(struct hv_domain *hvdom, ulong =
iova,
> +					 size_t size)
> +{
> +	ulong flags;
> +	size_t unmapped =3D 0;
> +	ulong last =3D iova + size - 1;
> +	struct hv_iommu_mapping *mapping =3D NULL;
> +	struct interval_tree_node *node, *next;
> +
> +	spin_lock_irqsave(&hvdom->mappings_lock, flags);
> +	next =3D interval_tree_iter_first(&hvdom->mappings_tree, iova, last);
> +	while (next) {
> +		node =3D next;
> +		mapping =3D container_of(node, struct hv_iommu_mapping, iova);
> +		next =3D interval_tree_iter_next(node, iova, last);
> +
> +		/* Splitting of a mapping is not supported at present */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped +=3D mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &hvdom->mappings_tree);
> +		kfree(mapping);

[Severity: High]
Does this code skip overlapping mappings and leak memory?

This loop removes nodes from an interval tree using interval_tree_remove() =
while
iterating over it using interval_tree_iter_next(). Since interval_tree_remo=
ve()
alters the tree's structure (rebalances it and updates __subtree_last), inv=
oking
interval_tree_iter_next() after the tree has been rebalanced can invalidate=
 the
traversal path.

This can cause the traversal to skip remaining overlapping nodes, leaking m=
emory
and preventing the hypervisor from unmapping those IOVA pages.

> +	}
> +	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
> +
> +	return unmapped;
> +}

[ ... ]

> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{

[ ... ]

> +	npages =3D size >> HV_HYP_PAGE_SHIFT;
> +	while (done < npages) {
> +		ulong completed, remain =3D npages - done;
> +
> +		remain =3D min(remain, HV_MAP_DEVICE_GPA_BATCH_SIZE);
> +
> +		status =3D hv_iommu_map_pgs(hvdom, iova, paddr, remain,
> +					  map_flags);
> +
> +		completed =3D hv_repcomp(status);
> +		done =3D done + completed;
> +		iova =3D iova + (completed << HV_HYP_PAGE_SHIFT);
> +		paddr =3D paddr + (completed << HV_HYP_PAGE_SHIFT);
> +
> +		if (hv_result_needs_memory(status)) {
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    256);

[Severity: High]
Can this sequence cause a "scheduling while atomic" panic?

IOMMU map operations are routinely called from atomic or interrupt contexts,
such as DMA mapping via dma_map_single().

The caller-provided gfp flag is ignored here. The code calls
hv_call_deposit_pages(), which unconditionally allocates memory using GFP_K=
ERNEL
(which can sleep) to satisfy hypervisor page table demands.

> +			if (ret)
> +				break;
> +			continue;
> +		}
> +		if (!hv_result_success(status))
> +			break;
> +	}

[ ... ]

> +static int __init hv_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup =3D &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc =3D hv_iommu_get_caps(&caps);
> +	if (rc)
> +		return rc;
> +
> +	hv_iommu_max_iova =3D ((ulong)1 << caps.max_iova_width) - 1;

[Severity: Medium]
Will this evaluate to 0 if max_iova_width is 64?

If the hypervisor supports 64-bit addressing and returns caps.max_iova_widt=
h as
64, this line will compute (1UL << 64) - 1. On x86-64 architectures, shift =
amounts
are masked modulo 64 (i.e. 64 & 63 =3D 0), so 1UL << 0 =3D 1, resulting in =
1 - 1 =3D 0.

This undefined behavior could corrupt the IOMMU geometry's aperture_end and
break the driver for hardware devices using high IOVAs.

> +
> +	rc =3D iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
> +	if (rc) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924020221.1287=
62-1-mrathor@linux.microsoft.com?part=3D3
