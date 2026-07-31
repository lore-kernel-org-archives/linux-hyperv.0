Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD2381AE5;
	Fri, 31 Jul 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537298; cv=none; b=HVl3AzgXirbl8YH+M8YtjnzmeXJNOuVoUWkG9m9gJLWJInDS9AuCCqEhFmq95oq8mvNn541eDeOFOrRQwgyFtMs+1XkJk1hZygaerD1zfY//Qor/w1V15Svx0uzzy4clmt8QMHkqvqDf6s2a4VtIE91MT5QTt1qtWKsZi9bBN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537298; c=relaxed/simple;
	bh=075KUmm+gUh/07l0oIXj1lK/D3XZ0YOUdQI1Lr4zm1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuVrPAUPsKMreGT/oRtkwbuOW4YTcE8r0VYGw36IOWWW/bmZKmMw4ldEhY8AUFnNFXU+YNblzgQdVbib1ICchwuPlXGt3jpNdCQb01bdxUFKAOfYC3K3NnMsOWqQpc26+F3yXOFL4PNMQZf5Kn8RuZgq9HmIRw+mRiv/JLxXieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ct3y3rQQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ct3y3rQQ"
Received: from mrdev.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CC3820B7168;
	Fri, 31 Jul 2026 15:34:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CC3820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785537278;
	bh=q3RUoem/CWob/gsRy8Ga2CFoe46R/sD2HmxeikpW4iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ct3y3rQQJ3r5GjmqVm2zojCUh3idtfpT24ZpA3Il1NZD5Bth+8FPFfwFNcqr5CQMK
	 ghmtVmarZIL1u7g6QCpamTKoCBHg/TXd1s/YCZmXIDd/8302Jn89u6U0VI07cm0tkQ
	 x67ChlyNJ0Vqdy7UReyR7wzWcE+1u4+DjvzqRWyY=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH v5 8/9] mshv: Populate mmio mappings for PCI passthru
Date: Fri, 31 Jul 2026 15:34:26 -0700
Message-ID: <20260731223427.2554388-9-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon guest accesses, in case of missing mmio mappings, the hypervisor
generates unmapped gpa intercepts. In this path, lookup the PCI
resource pfn for the guest gpa, and ask the hypervisor to map it
via hypercall. The PCI resource pfn is maintained by the VFIO driver,
and obtained via fixup_user_fault() call (similar to KVM). Try to use
2M page size as much as possible for significant performance gains.

Also, remove existing code that is using vma->vm_pgoff to map mmio
space, it is broken and will cause panics.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |   3 +-
 drivers/hv/mshv_root_hv_call.c | 104 +++++++++++++++++++++-------
 drivers/hv/mshv_root_main.c    | 120 ++++++++++++++++++++++++++++-----
 3 files changed, 185 insertions(+), 42 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 43114df3cbf0..2ef781cf8e83 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -301,7 +301,8 @@ int hv_call_create_partition(u64 flags,
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg,
+		      u64 mmio_mfn);
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 			  u32 flags, struct page **pages);
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..4f6eb3a2aed0 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -189,31 +189,33 @@ int hv_call_delete_partition(u64 partition_id)
 }
 
 /* Ask the hypervisor to map guest ram pages or the guest mmio space */
-static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
-			       u32 flags, struct page **pages, u64 mmio_spa)
+static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_count,
+			       u32 flags, struct page **pages, u64 mmio_mfn)
 {
 	struct hv_input_map_gpa_pages *input_page;
 	u64 status, *pfnlist;
 	unsigned long irq_flags, large_shift = 0;
-	int ret = 0, done = 0;
-	u64 page_count = page_struct_count;
-
-	if (page_count == 0 || (pages && mmio_spa))
-		return -EINVAL;
+	int i, ret = 0, done = 0;
+	u64 adj_page_count = page_count;
 
-	if (flags & HV_MAP_GPA_LARGE_PAGE) {
-		if (mmio_spa)
+	if (mmio_mfn) {
+		if (pages)
 			return -EINVAL;
+		for (i = 0; i < page_count; i++)
+			if (page_is_ram(mmio_mfn + i))
+				return -EINVAL;
+	}
 
+	if (flags & HV_MAP_GPA_LARGE_PAGE) {
 		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
 			return -EINVAL;
 
 		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
-		page_count >>= large_shift;
+		adj_page_count >>= large_shift;
 	}
 
-	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
+	while (done < adj_page_count) {
+		ulong i, completed, remain = adj_page_count - done;
 		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
 
 		local_irq_save(irq_flags);
@@ -230,13 +232,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 			} else if (pages) {
 				u64 index = (done + i) << large_shift;
 
-				if (index >= page_struct_count) {
+				if (index >= page_count) {
 					ret = -EINVAL;
 					break;
 				}
 				pfnlist[i] = page_to_pfn(pages[index]);
 			} else {
-				pfnlist[i] = mmio_spa + done + i;
+				pfnlist[i] = mmio_mfn +
+						((done + i) << large_shift);
 			}
 		if (ret)
 			break;
@@ -254,6 +257,9 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 				break;
 
 		} else if (!hv_result_success(status)) {
+			pr_err("%s: failed to map pages at gfn %#llx: completed %u/%llu, flags=%#x, status=%#llx (%s)\n",
+			       __func__, gfn, done, page_count, flags, status,
+			       hv_result_to_string(hv_result(status)));
 			ret = hv_result_to_errno(status);
 			break;
 		}
@@ -280,19 +286,69 @@ int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 				   flags, pages, 0);
 }
 
-/* Ask the hypervisor to map guest mmio space */
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
+/*
+ * Ask the hypervisor to map guest mmio space. Don't set HV_MAP_GPA_NOT_CACHED
+ * in hcall flags for slightly better performance, and in that case the guest
+ * stage 1 page table will control caching.
+ */
+int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg,
+		      u64 mmio_mfn)
 {
-	int i;
-	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
-		    HV_MAP_GPA_NOT_CACHED;
+	int rc;
+	u64 gfn, start_mmio_mfn, hpages;
+	u32 flags = HV_MAP_GPA_READABLE;
+	u64 numpgs = 0, numpgs_in_hpage = HPAGE_SIZE / PAGE_SIZE;
 
-	for (i = 0; i < numpgs; i++)
-		if (page_is_ram(mmio_spa + i))
-			return -EINVAL;
+	if (reg->hv_map_flags & HV_MAP_GPA_WRITABLE)
+		flags |= HV_MAP_GPA_WRITABLE;
+	if (reg->hv_map_flags & HV_MAP_GPA_EXECUTABLE)
+		flags |= HV_MAP_GPA_EXECUTABLE;
+
+	/*
+	 * Any significantly large range is expected to be properly aligned,
+	 * so keep it simple.
+	 */
+	gfn = reg->start_gfn;
+	start_mmio_mfn = mmio_mfn;
+	while (!HV_PAGE_COUNT_2M_ALIGNED(gfn) &&
+	       !HV_PAGE_COUNT_2M_ALIGNED(mmio_mfn) &&
+	       numpgs < reg->nr_pages) {
+		numpgs++;
+		gfn++;
+		mmio_mfn++;
+	}
+
+	if (numpgs) {
+		rc = hv_do_map_gpa_hcall(partition_id, reg->start_gfn, numpgs,
+					 flags, NULL, start_mmio_mfn);
+		if (rc || numpgs == reg->nr_pages)
+			return rc;
+	}
+
+	numpgs = reg->nr_pages - numpgs;
+
+	if (numpgs < numpgs_in_hpage)
+		return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags,
+					   NULL, mmio_mfn);
+
+	for (hpages = 0; numpgs >= numpgs_in_hpage;) {
+		hpages++;
+		numpgs = numpgs - numpgs_in_hpage;
+	}
+	rc = hv_do_map_gpa_hcall(partition_id, gfn, hpages * numpgs_in_hpage,
+				 flags | HV_MAP_GPA_LARGE_PAGE, NULL, mmio_mfn);
+	if (rc)
+		return rc;
+
+	if (numpgs) {
+		gfn = gfn + hpages * numpgs_in_hpage;
+		mmio_mfn = mmio_mfn + hpages * numpgs_in_hpage;
+
+		rc = hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
+					 mmio_mfn);
+	}
 
-	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
-				   mmio_spa);
+	return rc;
 }
 
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 79456388bba9..14a640750ccf 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -641,6 +641,96 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+/*
+ * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
+ * else just return -errno.
+ */
+static int mshv_chk_get_mmio_start_pfn(u64 uaddr, u64 *mmio_pfnp, bool wr)
+{
+	struct vm_area_struct *vma;
+	bool is_mmio;
+	struct follow_pfnmap_args pfnmap_args;
+	int rc = -EINVAL;
+	enum fault_flag prot = wr ? FAULT_FLAG_WRITE : 0;
+
+	mmap_read_lock(current->mm);
+	vma = vma_lookup(current->mm, uaddr);
+	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
+	if (!is_mmio)
+		goto unlock_mmap_out;
+
+	pfnmap_args.vma = vma;
+	pfnmap_args.address = uaddr;
+
+	rc = follow_pfnmap_start(&pfnmap_args);
+	if (rc) {
+		rc = fixup_user_fault(current->mm, uaddr, prot, NULL);
+		if (rc)
+			goto unlock_mmap_out;
+
+		rc = follow_pfnmap_start(&pfnmap_args);
+		if (rc)
+			goto unlock_mmap_out;
+	}
+
+	*mmio_pfnp = pfnmap_args.pfn;
+	follow_pfnmap_end(&pfnmap_args);
+
+unlock_mmap_out:
+	mmap_read_unlock(current->mm);
+	return rc;
+}
+
+/*
+ * Check if the unmapped gpa belongs to mmio space. If yes, resolve it.
+ *
+ * Returns: True if valid mmio intercept and handled, else false.
+ */
+static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
+{
+	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
+	u64 gfn, uaddr, mmio_mfn;
+	struct mshv_mem_region *rg;
+	bool writable;
+	int rc = -EINVAL;
+	struct mshv_partition *pt = vp->vp_partition;
+#if defined(CONFIG_X86_64)
+	struct hv_x64_memory_intercept_message *msg =
+		(struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
+#elif defined(CONFIG_ARM64)
+	struct hv_arm64_memory_intercept_message *msg =
+		(struct hv_arm64_memory_intercept_message *)hvmsg->u.payload;
+#endif
+
+	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
+
+	rg = mshv_partition_region_by_gfn_get(pt, gfn);
+	if (rg == NULL)
+		return false;
+	if (rg->mreg_type != MSHV_REGION_TYPE_MMIO)
+		goto put_rg_out;
+
+	uaddr = rg->start_uaddr + ((gfn - rg->start_gfn) << HV_HYP_PAGE_SHIFT);
+
+	writable = rg->hv_map_flags & HV_MAP_GPA_WRITABLE;
+	rc = mshv_chk_get_mmio_start_pfn(uaddr, &mmio_mfn, writable);
+	if (rc)
+		goto put_rg_out;
+
+	mmio_mfn = mmio_mfn - (gfn - rg->start_gfn);   /* start of the range */
+
+	/* Map the entire mmio region now. mmap lock not needed because we
+	 * are just mapping GPA to static device addresses, and the above
+	 * mshv_partition_region_by_gfn_get() gets a hold on the region and
+	 * hence its GPA. Unmap will occur when region ref count goes to 0.
+	 */
+	rc = hv_map_mmio_pages(pt->pt_id, rg, mmio_mfn);
+
+put_rg_out:
+	mshv_region_put(rg);
+	return rc == 0;
+}
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -699,6 +789,8 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
 	switch (vp->vp_intercept_msg_page->header.message_type) {
+	case HVMSG_UNMAPPED_GPA:
+		return mshv_handle_unmapped_gpa(vp);
 	case HVMSG_GPA_INTERCEPT:
 		return mshv_handle_gpa_intercept(vp);
 	}
@@ -1322,16 +1414,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 }
 
 /*
- * This maps two things: guest RAM and for pci passthru mmio space.
- *
- * mmio:
- *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
- *  - Two things need to happen for mapping mmio range:
- *	1. mapped in the uaddr so VMM can access it.
- *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
- *
- *   This function takes care of the second. The first one is managed by vfio,
- *   and hence is taken care of via vfio_pci_mmap_fault().
+ * This is called for both user ram and mmio space. The mmio space is not
+ * mapped here, but later during intercept on demand.
  */
 static long
 mshv_map_user_memory(struct mshv_partition *partition,
@@ -1340,7 +1424,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	struct mshv_mem_region *region;
 	struct vm_area_struct *vma;
 	bool is_mmio;
-	ulong mmio_pfn;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1350,12 +1433,19 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, mem->userspace_addr);
 	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
 	mmap_read_unlock(current->mm);
 
 	if (!vma)
 		return -EINVAL;
 
+	if (is_mmio) {
+		size_t vma_sz = vma->vm_end - vma->vm_start;
+
+		/* Upon mmio intercept, entire region is mapped */
+		if (mem->size > vma_sz)
+			return -EPERM;
+	}
+
 	ret = mshv_partition_create_region(partition, mem, &region,
 					   is_mmio);
 	if (ret)
@@ -1376,11 +1466,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 					    region->nr_pages,
 					    HV_MAP_GPA_NO_ACCESS, NULL);
 		break;
-	case MSHV_REGION_TYPE_MMIO:
-		ret = hv_call_map_mmio_pages(partition->pt_id,
-					     region->start_gfn,
-					     mmio_pfn,
-					     region->nr_pages);
+	default:
 		break;
 	}
 
-- 
2.51.2.vfs.0.1

