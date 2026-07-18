Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7726738B;
	Sat, 18 Jul 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341223; cv=none; b=i0i3Sdp+ugaCUbkRAEbu3IKZ/XrzqSMRS66ijmEVsmAEUaUoJCfstOH6QdQgcLA4haCFYjxM6D9uZCC1iSwxrLmNjpMlq5VBWkIjoZ1Bqc/lIqKmKv8Il22A4GiYDVA0KukRZT5GXDb3/o9TKepgHpFKibnO4MK/5EYjkVihMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341223; c=relaxed/simple;
	bh=lhwgNMXZqp6KYOABag9ODDEc0Rsjc61UKXXm5b2TflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl+4wGXoAHAaZqqikvK2dMOEx4p70+BmXRIJB9z8VhhDYlzW6F+6QTiv+73lJJ4l0G6H7L/jvKEgePyj8t4uvB26aBG/D5nnEkvMAzMXoz4/BB6a/wpvSoQNbuAbGowFPSnDDXwoRRc7U2dnYsmpufR178vVDAOhNqnUGJim/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NfXw75BD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NfXw75BD"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6800720B7172;
	Fri, 17 Jul 2026 19:20:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6800720B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341209;
	bh=FCYqsaK2mb6k+KVJi6/phleqEvnwWe1htuCXkMy0+Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfXw75BDN3RdX46zLo8+0PtVPyFxOqHAKLIIKyufCyi+lGEbSIt4kLMtunlkVgzJ8
	 96Fq9PZUH2jrCmD5TLqkkdS9sZWrggU72jZSU0oi05rjul1CdZ9Kvy0pOSdtULh2ce
	 b8u4+y+QVYioB8o7BT9+2VyxCj6e09wEApOzqDoE=
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
Cc: kys@microsoft.com,
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
Subject: [PATCH V4 8/9] mshv: Populate mmio mappings for PCI passthru
Date: Fri, 17 Jul 2026 19:19:48 -0700
Message-ID: <20260718021949.926306-9-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260718021949.926306-1-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
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
 drivers/hv/mshv_root_hv_call.c | 101 ++++++++++++++++++++++++--------
 drivers/hv/mshv_root_main.c    | 103 +++++++++++++++++++++++++++------
 3 files changed, 165 insertions(+), 42 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index b9880d0bdc4d..c97a1b5da9ad 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -301,7 +301,8 @@ int hv_call_create_partition(u64 flags,
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg, u64 gfn,
+		      u64 mmio_mfn);
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 			  u32 flags, struct page **pages);
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..937225c60473 100644
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
@@ -280,19 +286,66 @@ int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 				   flags, pages, 0);
 }
 
-/* Ask the hypervisor to map guest mmio space */
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
+/*
+ * Ask the hypervisor to map guest mmio space. Don't set HV_MAP_GPA_NOT_CACHED
+ * in hcall flags for slightly better performance, and in that case the guest
+ * stage 1 page table will control caching.
+ */
+int hv_map_mmio_pages(u64 partition_id, struct mshv_mem_region *reg, u64 gfn,
+		      u64 mmio_mfn)
 {
-	int i;
-	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
-		    HV_MAP_GPA_NOT_CACHED;
+	int rc;
+	u32 flags = HV_MAP_GPA_READABLE;
+	u64 hpages, numpgs, numpgs_in_hpage = HPAGE_SIZE / PAGE_SIZE;
+
+	if (reg->hv_map_flags & HV_MAP_GPA_WRITABLE)
+		flags |= HV_MAP_GPA_WRITABLE;
+	if (reg->hv_map_flags & HV_MAP_GPA_EXECUTABLE)
+		flags |= HV_MAP_GPA_EXECUTABLE;
+
+	mmio_mfn = mmio_mfn - (gfn - reg->start_gfn);	/* start of the range */
+
+	numpgs = 0;
+	gfn = reg->start_gfn;
+	while (!HV_PAGE_COUNT_2M_ALIGNED(gfn) &&
+	       !HV_PAGE_COUNT_2M_ALIGNED(mmio_mfn) &&
+	       numpgs < reg->nr_pages) {
+		numpgs++;
+		gfn++;
+	}
 
-	for (i = 0; i < numpgs; i++)
-		if (page_is_ram(mmio_spa + i))
-			return -EINVAL;
+	if (numpgs) {
+		rc = hv_do_map_gpa_hcall(partition_id, reg->start_gfn, numpgs,
+					 flags, NULL, mmio_mfn);
+		if (rc || numpgs == reg->nr_pages)
+			return rc;
+	}
+
+	mmio_mfn = mmio_mfn + numpgs;
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
index a36e54bfa064..6bce4123c5ff 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -641,6 +641,87 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+/*
+ * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
+ * else just return -errno.
+ */
+static int mshv_chk_get_mmio_start_pfn(u64 uaddr, u64 *mmio_pfnp)
+{
+	struct vm_area_struct *vma;
+	bool is_mmio;
+	struct follow_pfnmap_args pfnmap_args;
+	int rc = -EINVAL;
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
+		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
+				      NULL);
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
+	rc = mshv_chk_get_mmio_start_pfn(uaddr, &mmio_mfn);
+	if (rc)
+		goto put_rg_out;
+
+	rc = hv_map_mmio_pages(pt->pt_id, rg, gfn, mmio_mfn);
+
+put_rg_out:
+	mshv_region_put(rg);
+	return rc == 0;
+}
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -699,6 +780,8 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
 	switch (vp->vp_intercept_msg_page->header.message_type) {
+	case HVMSG_UNMAPPED_GPA:
+		return mshv_handle_unmapped_gpa(vp);
 	case HVMSG_GPA_INTERCEPT:
 		return mshv_handle_gpa_intercept(vp);
 	}
@@ -1322,16 +1405,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
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
@@ -1340,7 +1415,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	struct mshv_mem_region *region;
 	struct vm_area_struct *vma;
 	bool is_mmio;
-	ulong mmio_pfn;
 	long ret;
 
 	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
@@ -1350,7 +1424,6 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, mem->userspace_addr);
 	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
-	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
 	mmap_read_unlock(current->mm);
 
 	if (!vma)
@@ -1376,11 +1449,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
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

