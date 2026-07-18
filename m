Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1472BB1D;
	Sat, 18 Jul 2026 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342102; cv=none; b=JZC9eKByDFpqMOaZGjL12MW98dXurHs0a+rCux8nzpnmJ2Fm/7nVDPoY4b32wFlpFhwz43oJbONNdRECZ8mSg0mnZguEfu1uctwkWjsOs0H+CnD5Pc8WdmoIxDhEwhGIQtJdgaLhBRJJvDGmMBIPX3SxCz+DWecVpYNL6KfU/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342102; c=relaxed/simple;
	bh=+EyYaF5aYvu6gLBaiSSSo4t/iodIqMGAH1Hh+gBeOwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fDI7RVvIIIk5cEhGByQLQRzh4johp/HIqF2w1nZYd/+pLrvVXsTQ5WmyCkphRp/p6qkm1SoxmJFqBxVAk0XFW77R5uCDe1ng9KRrjSa83bgE2ccwxAWRrJzFmPnTT/PyCqTcr0q8uepZyqtVTKh0nnPcvLxgh52ZbYxdc9tAdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o17+JpCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o17+JpCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2DE1F000E9;
	Sat, 18 Jul 2026 02:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784342100;
	bh=kb6PcxH5SePSKB7L5FKXyWGv3yDC7L5yfAZ314O98zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o17+JpCqZ8A2I1txBrmSwdbiTSXp2xSyVLntuu4d0sfcXjm2YsFOWink3IiPDwuBt
	 xuRBkFq43nQcvgJibMlSCX4OnZHrRVbH+C3cmficMBzd8Zbq5ih0z+BdDyUbdMxCyC
	 krTXe5NQtCVl24XOHDi9UB0b4kH912/RzYYFyUodXvwT/V5rQFCOxA71qFNnrRlirj
	 rtSJoio2mj/3q26yIZJhtAsdPIDEXdVGCUVvyQa9r+ZGbUaLeAgmTg0DVSAKdztbFs
	 pBZb+pU0TCOE3no3HR+cyphDdUlsEAp6kNKA02hzobtBk2YUtQZyiQU37TwjniM4h6
	 Id81cHzfmxvbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-8-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-8-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:34:59 +0000
Message-Id: <20260718023500.CA2DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Partial IOMMU unmaps corrupt the interval tree state and silently =
leak DMA mappings in the hypervisor, allowing potential DMA use-after-free.
- [High] `hv_iommu_domain_alloc_paging` unconditionally rejects domain allo=
cation if the calling process is not an active VMM, breaking VFIO for host =
applications.
- [High] The `hv_iommu_map_pages` callback ignores the caller-provided `gfp=
` flags and implicitly uses `GFP_KERNEL`, risking sleep-in-atomic panics.
- [High] Unsafe interval tree iteration during node removal breaks RB-tree =
invariants and causes memory corruption or skipped nodes.
- [Medium] The `pci_devs_to_skip` string parsing logic incorrectly aborts o=
n a successful parse, completely breaking the `hv_iommu_skip=3D` boot param=
eter.
- [Medium] `hv_iommu_domain_free` does not free remaining `hv_iommu_mapping=
` nodes in the `mappings_tree`, leading to a memory leak.
- [Medium] Failure in `hv_iommu_attach_dev` leaves the hardware detached wh=
ile failing to restore the device to its previous domain.
--

--- Patch [7]: [PATCH V4 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU -=
--
commit eedf8d68fd442834b8bd7d597c6c152d43c81395
Author: Mukesh R <mrathor@linux.microsoft.com>
Subject: x86/hyperv: Implement Hyper-V virtual IOMMU

This commit adds a new virtual IOMMU driver for Microsoft Hyper-V. The
hypervisor claims the IOMMU upon boot, and this driver communicates with
it to create and delete paging domains, map and unmap pages, and handle
default identity domains.

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c

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

[Severity: High]
The commit message explicitly mentions support for host apps like SPDK, but
could this check unintentionally reject domain allocation for them?=20

Since host applications like SPDK are standard userspace processes rather
than mshv VMM threads, hv_get_current_partid() will return
HV_PARTITION_ID_INVALID, which blocks the allocation entirely.

[ ... ]

> +static void hv_iommu_domain_free(struct iommu_domain *immdom)
> +{
> +	unsigned long flags;
> +	u64 status;
> +	struct hv_input_delete_device_domain *input;
> +	struct hv_input_device_domain *ddp;
> +	struct hv_domain *hvdom =3D to_hv_domain(immdom);
> +
> +	if (hv_special_domain(hvdom))
> +		return;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	ddp =3D &input->device_domain;
> +	memset(input, 0, sizeof(*input));
> +
> +	ddp->partition_id =3D HV_PARTITION_ID_SELF;
> +	ddp->domain_id.type =3D HV_DEVICE_DOMAIN_TYPE_S2;
> +	ddp->domain_id.id =3D hvdom->domid_num;
> +
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
> +				 NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	kfree(hvdom);
> +}

[Severity: Medium]
When an IOMMU domain is destroyed, does this leave the dynamically allocated
nodes inside hvdom->mappings_tree leaked?=20

The function frees the hvdom structure but there does not appear to be a
cleanup loop iterating over and freeing the struct hv_iommu_mapping objects
left in the tree.

[ ... ]

> +static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	struct pci_dev *pdev;
> +	int rc;
> +	struct hv_domain *hvdom_new =3D to_hv_domain(immdom);
> +	struct hv_domain *hvdom_prev =3D to_hv_domain(old);
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	/* There are no explicit detach calls, hence check first if we need
> +	 * to detach first. Also, in case of guest shutdown, it's the VMM
> +	 * thread that attaches it back to the hv_def_identity_dom, and
> +	 * hvdom_prev will not be null then. It is null during boot.
> +	 */
> +	if (hvdom_prev && !hv_special_domain(hvdom_prev))
> +		hv_iommu_detach_dev(hvdom_prev, dev);
> +
> +	rc =3D hv_iommu_att_dev2dom(hvdom_new, pdev);
> +
> +	if (rc =3D=3D 0)
> +		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */
> +	else
> +		dev_iommu_priv_set(dev, NULL);
> +
> +	return rc;
> +}

[Severity: Medium]
If the device successfully detaches from the old domain but the new attach
hypercall fails, is the hardware left in limbo?=20

Since there is no rollback to re-attach the device to the previous domain,
the subsystem logic might believe the device is safely detached and handle
the error, while the hardware is left without an assigned domain.

[ ... ]

> +static int hv_iommu_add_tree_mapping(struct hv_domain *hvdom,
> +				     unsigned long iova, phys_addr_t paddr,
> +				     size_t size, u32 flags)
> +{
> +	unsigned long irqflags;
> +	struct hv_iommu_mapping *mapping;
> +
> +	mapping =3D kzalloc_obj(struct hv_iommu_mapping);
> +	if (!mapping)
> +		return -ENOMEM;

[Severity: High]
Can this allocation trigger a panic by sleeping in atomic context?=20

The kzalloc_obj macro implicitly uses a GFP_KERNEL allocation by default.
The caller, hv_iommu_map_pages(), receives a gfp_t parameter specifically
because DMA mapping operations can be called with GFP_ATOMIC inside
interrupt handlers, but that parameter is discarded before calling this
function.

[ ... ]

> +static size_t hv_iommu_del_tree_mappings(struct hv_domain *hvdom,
> +					unsigned long iova, size_t size)
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

[Severity: High]
Is it safe to use a cached next pointer for interval tree iteration after
modifying the tree?=20

Calling interval_tree_remove() later in this loop restructures the
underlying RB-tree and changes parent and child relationships. Continuing
the iteration with a pre-cached pointer on the mutated tree might break the
iterator's traversal logic, leading to skipped nodes or memory corruption.

> +
> +		/* Trying to split a mapping? Not supported for now. */
> +		if (mapping->iova.start < iova)
> +			break;
> +
> +		unmapped +=3D mapping->iova.last - mapping->iova.start + 1;
> +
> +		interval_tree_remove(node, &hvdom->mappings_tree);
> +		kfree(mapping);
> +	}
> +	spin_lock_irqrestore(&hvdom->mappings_lock, flags);
> +
> +	return unmapped;
> +}

[Severity: High]
What happens if a caller unmaps a subset of a mapping?=20

If the unmap starts exactly at the IOVA, hv_iommu_del_tree_mappings()
removes the entire node from the tree and returns the node's full size.
Then, hv_iommu_unmap_pages() only unmaps the originally requested size
from the hypervisor.=20

This appears to permanently lose the remainder of the mapping from the
tree while leaving it mapped in the hypervisor, causing a desync and
potential DMA memory leak.

[ ... ]

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> +		int rc, pos =3D 0;
> +		int parsed;
> +		int segment, bus, slot, func;
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		do {
> +			parsed =3D 0;
> +
> +			rc =3D sscanf(pci_devs_to_skip + pos, " (%x:%x:%x.%x) %n",
> +				    &segment, &bus, &slot, &func, &parsed);
> +			if (rc)
> +				break;

[Severity: Medium]
Does this condition inadvertently terminate the loop on a successful parse?

The sscanf function returns the number of successfully matched items. If
the configuration string is parsed correctly, rc will be greater than zero
and the loop will immediately break before checking the parsed fields or
matching the devices to skip.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D7
