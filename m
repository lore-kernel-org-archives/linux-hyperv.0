Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C848987C;
	Fri, 31 Jul 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538128; cv=none; b=bD7lurBnOiNIMH9GBdwTbmz8KIrqmJoy1mbEXTjg1d7BrfRbvRd8TNnJjUX6XJ8C853mhpsGVMqDw9NFXToZRb83KI01sPEP9XxW+SHX4/gx7VMUiZfgIsVjupfhVM7pyeYte1tKYiiJPWuk2tEsoKi8M9wU1kQpgUcdRhX7F7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538128; c=relaxed/simple;
	bh=6KqkmZ8KDgIo3XVtM358Q8mtSyxfOr/zcZH6p1IP70U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MyF9Q6OzNjarrklZfhS/HB8eVNBh/S23DlxZ2hOhsKN12Ct4ZsyWfv4z01CQaawaf5AsI2XDd6JilbJpowb2P4TQ+mNZohX4wnc4kPzVQucMZvAes2h+UqW1PTun7d7JJ9AFWelmQNagndwmhTK8FX2QDqh4ccmRiAWQza4Qjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBd7nPXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBd7nPXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5571F00AC4;
	Fri, 31 Jul 2026 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538127;
	bh=/sLLwvWfy5LFQK9R2lMuUgqRvPv0GwVzztb6UNH80i4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBd7nPXAOVcbLk2Zr1C6qkKNBCKxrW/6uUgT5DmXKZ3OMQF0oFcRgONY74kuft1gu
	 7f3kTyrnnZXeCWRy+IESBua5TBqbOdU25cJwQKAvEkXOvMGbnNHIYp98/gyLfmahgb
	 VeEcei2bw5p2OtIeeQzqhGmVZUzIqkpxYJnvqe28EScv0d7f68Y6FhJ6Bq/h9c8ZCo
	 eZPr0YHg6mqkzOHvLKE36yharkvBe3SfpU8zD/FhQRphMPmqdc09eXB3EwRApv3jwZ
	 FKCyIUVVDVtd6+lOP5NZaTST3kgjLE+e2m8aA8oJP3DEwbEN+xgKN65tNXFNDDE2dF
	 JcqY7nrCSl8Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-8-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:48:46 +0000
Message-Id: <20260731224846.BD5571F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Broken partial unmapping logic incorrectly removes entire mapping =
ranges, leaks mappings, and causes catastrophic error rollback failures.
- [High] Calling dev_iommu_priv_set() in attach_dev callback without holdin=
g iommu_probe_device_lock causes a lockdep violation.
- [High] hv_iommu_map_pages ignores the caller's gfp_t argument and calls a=
 potentially sleeping function.
- [Medium] Atomic counter wrap-around in domain ID allocation risks collidi=
ng with reserved hypervisor domain IDs.
- [Low] The __setup callback hv_iommu_setup_skip incorrectly returns 0, cau=
sing the kernel to treat the command-line argument as an unknown parameter.
--

--- Patch [7]: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU -=
--
commit cdb89379b7cc5351b8dae8a1be7ede22f440c196
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement Hyper-V virtual IOMMU

Add a new file to implement a virtual IOMMU that works with Microsoft Hyper=
-V
hypervisor. The driver communicates with the hypervisor for creating and=20
deleting paging domains and mapping pages. The default domain type is=20
IDENTITY.

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> index 0000000000000..97ddd69560318
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c
> @@ -0,0 +1,706 @@
[ ... ]
> +static char *pci_devs_to_skip;
> +static int __init hv_iommu_setup_skip(char *str)
> +{
> +	pci_devs_to_skip =3D str;
> +
> +	return 0;
> +}

[Severity: Low]
Should this __setup callback return 1? Returning 0 causes the kernel to
treat the command-line argument as an unknown parameter and pass it to
the init process as an environment variable.

[ ... ]
> +static size_t hv_iommu_del_tree_mappings(struct hv_domain *hvdom,
> +					 unsigned long iova, size_t size)
> +{
> +	unsigned long flags;
> +	size_t unmapped =3D 0;
> +	unsigned long last =3D iova + size - 1;
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

[Severity: High]
How does this code handle partial unmaps? If an unmap request starts in the
middle of a mapping, doesn't the break statement here leave the memory
mapped? Furthermore, if the request starts at the beginning but is smaller
than the full mapping, this removes the entire node and returns its full si=
ze,
prompting the caller to erroneously unmap the full region from hardware.

[ ... ]
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
> +	struct hv_domain *hvdom;
> +	int rc;
> +	u32 unique_id;
> +	u64 ptid =3D hv_get_current_partid();
> +
> +	if (ptid =3D=3D HV_PARTITION_ID_INVALID)
> +		return NULL;
> +
> +	hvdom =3D kzalloc_obj(struct hv_domain);
> +	if (hvdom =3D=3D NULL)
> +		return NULL;
> +
> +	spin_lock_init(&hvdom->mappings_lock);
> +	hvdom->mappings_tree =3D RB_ROOT_CACHED;
> +
> +	unique_id =3D (u32)atomic_inc_return(&hv_unique_id);
> +	if (unique_id =3D=3D HV_DEVICE_DOMAIN_ID_S2_NULL)	/* ie, UINTMAX */
> +		goto out_err;

[Severity: Medium]
What happens when this 32-bit atomic counter wraps around? Since it will wr=
ap
to 0 (which is HV_DEVICE_DOMAIN_ID_S2_DEFAULT), could this new domain
improperly map to the hypervisor's default domain and cause hypercall
failures? Should an IDA allocator be used instead?

[ ... ]
> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_domain *hvdom_new =3D to_hv_domain(immdom);
> +	struct hv_domain *hvdom_prev =3D to_hv_domain(old);
[ ... ]
> +	rc =3D hv_iommu_att_dev2dom(hvdom_new, pdev);
> +
> +	if (rc =3D=3D 0)
> +		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */

[Severity: High]
Can this trigger a lockdep splat? The core function dev_iommu_priv_set()
requires iommu_probe_device_lock to be held, but this attach_dev callback
executes with group->mutex held. Is it safe to use this private field for
dynamic domain state?

> +	else {
> +		if (hvdom_prev && !hv_special_domain(hvdom_prev))
> +			WARN(1, "Failed to attach dev:%s\n", pci_name(pdev));
> +		dev_iommu_priv_set(dev, NULL);
> +	}
> +
> +	return rc;
> +}
[ ... ]
> +static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
> +			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			      int prot, gfp_t gfp, size_t *mapped)
> +{
[ ... ]
> +		if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +						    hv_current_partition_id,
> +						    256);

[Severity: High]
Does this sequence sleep in atomic context? The IOMMU map_pages callback can
be invoked in atomic contexts (such as inside interrupt handlers) and is
passed a gfp_t argument. However, this ignores the gfp argument and calls
hv_call_deposit_pages(), which allocates pages using GFP_KERNEL.

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

[Severity: High]
Is the error cleanup path unmapping memory that was never mapped? If a
multi-page map fails halfway, it tries to unmap the unmapped portion, which
hits the break condition in hv_iommu_del_tree_mappings() discussed earlier.
This fails to remove the node and then erroneously issues a hypercall to
unmap the entire size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D7
