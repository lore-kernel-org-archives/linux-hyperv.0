Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCD3E49D3;
	Tue, 22 Sep 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050250; cv=none; b=lCyWaXftnD+JITbYK5Ep3LW+bxzDnuRnFFHusrtWgOLUDp622laqqrCFVjFqPbPFAYUIzRgDXtG+Jfmi243ae3SBU2fHWmC6gGK6N0IB8PU7rzAi0Wau8QYxBbx+I7bvxQthJNMI35x7fOTG+tHf1AzbeFbIDga8uLXeQDMMrlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050250; c=relaxed/simple;
	bh=nzYrwSI9gkTVuRGQcW+Fbc/lPF0r3vdlptk9R6uMlyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilwJfclIxWvxv4Fi+1LaBRwk+V/iytVzNNZ8BzTG6VzMAqclCnNPplWgB9ywaxmpwd8ic49pwFQL1W61gcDbSBqxMFEFQtVBh8uORg2lgJB2Gu29nB2fs8pKJeJQ7brcsj4cBbdddgjbYFtPdV+Z+hRXiIUeTgQrRit7Nsj50TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c6jOe+r6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c6jOe+r6"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5D7620B7168;
	Mon, 21 Sep 2026 21:09:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5D7620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790050199;
	bh=QPeRybLwfpl4jgJkhq1gva7iM6BZfX0gRl5AZ1csD7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6jOe+r6Q/TTTY5+l6GwzH227htvVpzs1liMX7cgw9F16wbIQ5nmbuDLkRwnihdRY
	 gL8JxYEpa0cImVByICYZrpgiWoIIv4rjaU5TCBZXyVZ+ak20UEhXzgkJLXhSinDj4A
	 hpQqTw1P/p77PbHjLA1NHoXqiHYd88Y3MYKaMWgE=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v7 1/9] mshv: retain memory regions until unmap succeeds
Date: Tue, 22 Sep 2026 04:10:18 +0000
Message-ID: <20260922041043.171543-2-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922041043.171543-1-weh@linux.microsoft.com>
References: <20260918115741.3791682-1-weh@linux.microsoft.com>
 <20260922041043.171543-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Hu <weh@microsoft.com>

Do not remove a region from the partition list or unpin its pages until
a checked UnmapGpaPages hypercall has completed. Validate repetition
progress so malformed zero or oversized completion counts cannot spin or
conceal partial state.

Each failed pinned-map chunk first rolls back that chunk. If earlier
chunks may still be mapped, attempt a checked full-region unmap before
restoring encrypted host access and invalidating the unpublished region.
Preserve the original map error. If cleanup fails or remains uncertain,
retain the region, partition, and module rather than allowing the child
partition to access freed pages. Keep fallible hypervisor cleanup out of
the kref release callback.

For movable regions, use the fault rwsem only as a GPA-fault admission
and notifier-lifetime gate. Serialize the initial NO_ACCESS map with the
region mutex, matching notifier, fault, and unmap coverage. The MMU
interval notifier serializes directly with that mutex, publishes its
sequence after locking, and skips a NO_ACCESS remap only after a checked
unmap proves no mapping remains.

Explicit unmap and partition teardown block and drain faults with the
write side, then take the region mutex around the checked hypervisor
unmap. Restore list visibility and fault admission on failure. Remove the
interval notifier only after dropping both locks.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/hv/mshv_regions.c      | 180 +++++++++++++++++----------------
 drivers/hv/mshv_root.h         |  14 ++-
 drivers/hv/mshv_root_hv_call.c |  81 ++++++++++-----
 drivers/hv/mshv_root_main.c    | 151 ++++++++++++++++++++++++---
 4 files changed, 301 insertions(+), 125 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..b08b2709bf11 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -188,6 +188,8 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
 
 	kref_init(&region->mreg_refcount);
+	mutex_init(&region->mreg_mutex);
+	init_rwsem(&region->mreg_fault_lock);
 
 	return region;
 }
@@ -245,13 +247,21 @@ static int mshv_region_chunk_remap(struct mshv_mem_region *region,
 				   u64 page_offset, u64 page_count,
 				   bool huge_page)
 {
+	bool chunk_mapping_may_exist;
+	int ret;
+
 	if (huge_page)
 		flags |= HV_MAP_GPA_LARGE_PAGE;
 
-	return hv_call_map_gpa_pages(region->partition->pt_id,
-				     region->start_gfn + page_offset,
-				     page_count, flags,
-				     region->mreg_pages + page_offset);
+	ret = hv_call_map_gpa_pages(region->partition->pt_id,
+				    region->start_gfn + page_offset,
+				    page_count, flags,
+				    region->mreg_pages + page_offset,
+				    &chunk_mapping_may_exist);
+	if (chunk_mapping_may_exist)
+		region->mapping_may_exist = true;
+
+	return ret;
 }
 
 static int mshv_region_remap_pages(struct mshv_mem_region *region,
@@ -337,37 +347,39 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				       page_count, flags);
 }
 
-static int mshv_region_unmap(struct mshv_mem_region *region)
+int mshv_region_unmap(struct mshv_mem_region *region)
 {
-	return mshv_region_process_range(region, 0,
-					 0, region->nr_pages,
-					 mshv_region_chunk_unmap);
+	int ret;
+
+	if (!region->mapping_may_exist)
+		return 0;
+
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_PINNED)
+		ret = mshv_region_process_range(region, 0, 0, region->nr_pages,
+						mshv_region_chunk_unmap);
+	else
+		ret = hv_call_unmap_gpa_pages(region->partition->pt_id,
+					      region->start_gfn,
+					      region->nr_pages, 0);
+	if (!ret)
+		region->mapping_may_exist = false;
+
+	return ret;
 }
 
 static void mshv_region_destroy(struct kref *ref)
 {
 	struct mshv_mem_region *region =
 		container_of(ref, struct mshv_mem_region, mreg_refcount);
-	struct mshv_partition *partition = region->partition;
-	int ret;
+
+	/* Callers must retain the list reference until cleanup is certain. */
+	if (WARN_ON_ONCE(region->mapping_may_exist))
+		return;
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		mshv_region_movable_fini(region);
 
-	if (mshv_partition_encrypted(partition)) {
-		ret = mshv_region_share(region);
-		if (ret) {
-			pt_err(partition,
-			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
-			       ret);
-			return;
-		}
-	}
-
-	mshv_region_unmap(region);
-
 	mshv_region_invalidate(region);
-
 	vfree(region);
 }
 
@@ -382,54 +394,18 @@ int mshv_region_get(struct mshv_mem_region *region)
 }
 
 /**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
- * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
+ * mshv_region_range_fault - Fault and map pages for a movable region.
+ * @region: Memory region receiving the GPA fault.
+ * @page_offset: First page in the region.
+ * @page_count: Number of pages to fault.
  *
- * This function performs the following steps:
- * 1. Reads the notifier sequence for the HMM range.
- * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
-					  struct hmm_range *range)
-{
-	int ret;
-
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mreg_mni.mm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&region->mreg_mutex);
-
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
-		mutex_unlock(&region->mreg_mutex);
-		cond_resched();
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-/**
- * mshv_region_range_fault - Handle memory range faults for a given region.
- * @region: Pointer to the memory region structure.
- * @page_offset: Offset of the page within the region.
- * @page_count: Number of pages to handle.
+ * mreg_fault_lock is only an admission and lifetime gate. A teardown writer
+ * sets faults_blocked before taking the write side, which prevents new faults
+ * and drains faults that can still remap the region. On an HMM retry, drop the
+ * gate and mmap_lock before trying again so a waiting writer cannot create a
+ * fairness cycle. The notifier never takes mreg_fault_lock.
  *
- * This function resolves memory faults for a specified range of pages
- * within a memory region. It uses HMM (Heterogeneous Memory Management)
- * to fault in the required pages and updates the region's page array.
+ * Lock order for one attempt is mreg_fault_lock -> mmap_lock -> mreg_mutex.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -440,6 +416,7 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 		.notifier = &region->mreg_mni,
 		.default_flags = HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
 	};
+	struct mm_struct *mm;
 	unsigned long *pfns;
 	int ret;
 	u64 i;
@@ -452,21 +429,44 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
 	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
 
-	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
-	} while (ret == -EBUSY);
+retry:
+	down_read(&region->mreg_fault_lock);
+	if (READ_ONCE(region->faults_blocked) ||
+	    !mmget_not_zero(region->mreg_mni.mm)) {
+		ret = -ECANCELED;
+		goto out_unlock_faults;
+	}
+	mm = region->mreg_mni.mm;
 
+	mmap_read_lock(mm);
+	range.notifier_seq = mmu_interval_read_begin(range.notifier);
+	ret = hmm_range_fault(&range);
 	if (ret)
-		goto out;
+		goto out_unlock_mmap;
+
+	mutex_lock(&region->mreg_mutex);
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
+		mutex_unlock(&region->mreg_mutex);
+		ret = -EBUSY;
+		goto out_unlock_mmap;
+	}
 
 	for (i = 0; i < page_count; i++)
 		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
 
 	ret = mshv_region_remap_pages(region, region->hv_map_flags,
 				      page_offset, page_count);
-
 	mutex_unlock(&region->mreg_mutex);
-out:
+
+out_unlock_mmap:
+	mmap_read_unlock(mm);
+	mmput(mm);
+out_unlock_faults:
+	up_read(&region->mreg_fault_lock);
+	if (ret == -EBUSY) {
+		cond_resched();
+		goto retry;
+	}
 	kfree(pfns);
 	return ret;
 }
@@ -486,10 +486,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn)
 
 	ret = mshv_region_range_fault(region, page_offset, page_count);
 
-	WARN_ONCE(ret,
+	WARN_ONCE(ret && ret != -ECANCELED,
 		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_offset %llu, page_count %llu\n",
 		  region->partition->pt_id, region->start_uaddr,
-		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
+		  region->start_uaddr +
+		  (region->nr_pages << HV_HYP_PAGE_SHIFT),
 		  gfn, page_offset, page_count);
 
 	return !ret;
@@ -531,6 +532,12 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 	page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
 	page_count = HVPFN_DOWN(mend - mstart);
 
+	/*
+	 * mmap_lock is already held by the notifier core. Take only the region
+	 * mutex here; taking the fair fault rwsem would deadlock behind an unmap
+	 * writer that is waiting for this mutex. Publish the sequence after the
+	 * mutex is acquired even when a checked unmap proved no mapping remains.
+	 */
 	if (mmu_notifier_range_blockable(range))
 		mutex_lock(&region->mreg_mutex);
 	else if (!mutex_trylock(&region->mreg_mutex))
@@ -538,15 +545,15 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
-	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
-				      page_offset, page_count);
-	if (ret)
-		goto out_unlock;
+	if (region->mapping_may_exist) {
+		ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
+					      page_offset, page_count);
+		if (ret)
+			goto out_unlock;
+	}
 
 	mshv_region_invalidate_pages(region, page_offset, page_count);
-
 	mutex_unlock(&region->mreg_mutex);
-
 	return true;
 
 out_unlock:
@@ -567,7 +574,11 @@ static const struct mmu_interval_notifier_ops mshv_region_mni_ops = {
 
 void mshv_region_movable_fini(struct mshv_mem_region *region)
 {
+	if (!region->mni_registered)
+		return;
+
 	mmu_interval_notifier_remove(&region->mreg_mni);
+	region->mni_registered = false;
 }
 
 bool mshv_region_movable_init(struct mshv_mem_region *region)
@@ -581,7 +592,6 @@ bool mshv_region_movable_init(struct mshv_mem_region *region)
 	if (ret)
 		return false;
 
-	mutex_init(&region->mreg_mutex);
-
+	region->mni_registered = true;
 	return true;
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..d0770d36defb 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -8,6 +8,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/semaphore.h>
 #include <linux/sched.h>
 #include <linux/srcu.h>
@@ -88,10 +89,15 @@ struct mshv_mem_region {
 	u64 start_gfn;
 	u64 start_uaddr;
 	u32 hv_map_flags;
+	/* True until a checked hypervisor unmap has completed. */
+	bool mapping_may_exist;
 	struct mshv_partition *partition;
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
 	struct mutex mreg_mutex;	/* protects region pages remapping */
+	struct rw_semaphore mreg_fault_lock;
+	bool faults_blocked;
+	bool mni_registered;
 	struct page *mreg_pages[];
 };
 
@@ -139,6 +145,7 @@ struct mshv_partition {
 	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
 	u64 isolation_type;
 	bool import_completed;
+	bool teardown_quarantined;
 	bool pt_initialized;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *pt_stats_dentry;
@@ -281,9 +288,11 @@ int hv_call_create_partition(u64 flags,
 int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa,
+			   u64 numpgs, bool *mapping_may_exist);
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
-			  u32 flags, struct page **pages);
+			  u32 flags, struct page **pages,
+			  bool *mapping_may_exist);
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 			    u32 flags);
 int hv_call_delete_vp(u64 partition_id, u32 vp_index);
@@ -370,6 +379,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
+int mshv_region_unmap(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..1fa644e0e437 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -190,14 +190,19 @@ int hv_call_delete_partition(u64 partition_id)
 
 /* Ask the hypervisor to map guest ram pages or the guest mmio space */
 static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
-			       u32 flags, struct page **pages, u64 mmio_spa)
+			       u32 flags, struct page **pages, u64 mmio_spa,
+			       bool *mapping_may_exist)
 {
 	struct hv_input_map_gpa_pages *input_page;
 	u64 status, *pfnlist;
 	unsigned long irq_flags, large_shift = 0;
-	int ret = 0, done = 0;
 	u64 page_count = page_struct_count;
+	u64 done = 0;
+	bool cleanup_needed = false;
+	int ret = 0;
 
+	if (mapping_may_exist)
+		*mapping_may_exist = false;
 	if (page_count == 0 || (pages && mmio_spa))
 		return -EINVAL;
 
@@ -213,8 +218,9 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
+		u64 i, completed, remain = page_count - done;
+		unsigned int rep_count = min_t(u64, remain,
+					       HV_MAP_GPA_BATCH_SIZE);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -224,49 +230,62 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		input_page->map_flags = flags;
 		pfnlist = input_page->source_gpa_page_list;
 
-		for (i = 0; i < rep_count; i++)
+		for (i = 0; i < rep_count; i++) {
 			if (flags & HV_MAP_GPA_NO_ACCESS) {
 				pfnlist[i] = 0;
 			} else if (pages) {
 				u64 index = (done + i) << large_shift;
 
-				if (index >= page_struct_count) {
-					ret = -EINVAL;
-					break;
-				}
 				pfnlist[i] = page_to_pfn(pages[index]);
 			} else {
 				pfnlist[i] = mmio_spa + done + i;
 			}
-		if (ret)
-			break;
+		}
 
 		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
 					     input_page, NULL);
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
+		if (completed > rep_count) {
+			cleanup_needed = true;
+			ret = -EIO;
+			break;
+		}
+		done += completed;
 
 		if (hv_result_needs_memory(status)) {
 			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
 						    HV_MAP_GPA_DEPOSIT_PAGES);
 			if (ret)
 				break;
-
-		} else if (!hv_result_success(status)) {
+			continue;
+		}
+		if (!hv_result_success(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
-
-		done += completed;
+		if (!completed) {
+			cleanup_needed = true;
+			ret = -EIO;
+			break;
+		}
 	}
 
-	if (ret && done) {
+	if (ret && (done || cleanup_needed)) {
 		u32 unmap_flags = 0;
+		int unmap_ret;
 
 		if (flags & HV_MAP_GPA_LARGE_PAGE)
 			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
-		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
+		/* Unmap the full request so no unknown partial mapping survives. */
+		unmap_ret =
+			hv_call_unmap_gpa_pages(partition_id, gfn,
+						page_struct_count, unmap_flags);
+		if (unmap_ret && mapping_may_exist)
+			*mapping_may_exist = true;
+	} else if (!ret && mapping_may_exist) {
+		*mapping_may_exist = true;
 	}
 
 	return ret;
@@ -274,16 +293,18 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 /* Ask the hypervisor to map guest ram pages */
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
-			  u32 flags, struct page **pages)
+			  u32 flags, struct page **pages,
+			  bool *mapping_may_exist)
 {
 	return hv_do_map_gpa_hcall(partition_id, gpa_target, page_count,
-				   flags, pages, 0);
+				   flags, pages, 0, mapping_may_exist);
 }
 
 /* Ask the hypervisor to map guest mmio space */
-int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
+int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa,
+			   u64 numpgs, bool *mapping_may_exist)
 {
-	int i;
+	u64 i;
 	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
 		    HV_MAP_GPA_NOT_CACHED;
 
@@ -292,7 +313,7 @@ int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
 			return -EINVAL;
 
 	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
-				   mmio_spa);
+				   mmio_spa, mapping_may_exist);
 }
 
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
@@ -301,7 +322,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 	struct hv_input_unmap_gpa_pages *input_page;
 	u64 status, page_count = page_count_4k;
 	unsigned long irq_flags, large_shift = 0;
-	int ret = 0, done = 0;
+	u64 done = 0;
+	int ret = 0;
 
 	if (page_count == 0)
 		return -EINVAL;
@@ -315,8 +337,9 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 	}
 
 	while (done < page_count) {
-		ulong completed, remain = page_count - done;
-		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
+		u64 completed, remain = page_count - done;
+		unsigned int rep_count = min_t(u64, remain,
+					       HV_UMAP_GPA_PAGES);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -329,10 +352,18 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
+		if (completed > rep_count) {
+			ret = -EIO;
+			break;
+		}
 		if (!hv_result_success(status)) {
 			ret = hv_result_to_errno(status);
 			break;
 		}
+		if (!completed) {
+			ret = -EIO;
+			break;
+		}
 
 		done += completed;
 	}
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..4e7812d8958f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -65,6 +65,7 @@ static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
 static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
 static int mshv_init_async_handler(struct mshv_partition *partition);
 static void mshv_async_hvcall_handler(void *data, u64 *status);
+static void mshv_quarantine_partition(struct mshv_partition *partition);
 
 static const union hv_input_vtl input_vtl_zero;
 static const union hv_input_vtl input_vtl_normal = {
@@ -1319,9 +1320,24 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 	}
 
 	ret = mshv_region_map(region);
-	if (ret && mshv_partition_encrypted(partition)) {
+	if (ret) {
 		int shrc;
 
+		/* A partial map must be removed before host access is restored. */
+		if (region->mapping_may_exist) {
+			int cleanup_ret = mshv_region_unmap(region);
+
+			if (cleanup_ret || region->mapping_may_exist) {
+				pt_err(partition,
+				       "Failed to clean up mapping at GFN %#llx after map failure: %d; retaining region\n",
+				       region->start_gfn, cleanup_ret);
+				return ret;
+			}
+		}
+
+		if (!mshv_partition_encrypted(partition))
+			return ret;
+
 		shrc = mshv_region_share(region);
 		if (!shrc)
 			goto invalidate_region;
@@ -1330,8 +1346,8 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 		       "Failed to share memory region (guest_pfn: %llu): %d\n",
 		       region->start_gfn, shrc);
 		/*
-		 * Don't unpin if marking shared failed because pages are no
-		 * longer mapped in the host, ie root, anymore.
+		 * Do not unpin if restoring host access failed because the
+		 * pages are no longer mapped in the host.
 		 */
 		goto err_out;
 	}
@@ -1392,18 +1408,23 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		/*
 		 * For movable memory regions, remap with no access to let
 		 * the hypervisor track dirty pages, enabling pre-copy live
-		 * migration.
+		 * migration. The notifier is already registered, so serialize
+		 * this initial map with notifier, fault, and unmap operations.
 		 */
+		mutex_lock(&region->mreg_mutex);
 		ret = hv_call_map_gpa_pages(partition->pt_id,
 					    region->start_gfn,
 					    region->nr_pages,
-					    HV_MAP_GPA_NO_ACCESS, NULL);
+					    HV_MAP_GPA_NO_ACCESS, NULL,
+					    &region->mapping_may_exist);
+		mutex_unlock(&region->mreg_mutex);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
 		ret = hv_call_map_mmio_pages(partition->pt_id,
 					     region->start_gfn,
 					     mmio_pfn,
-					     region->nr_pages);
+					     region->nr_pages,
+					     &region->mapping_may_exist);
 		break;
 	}
 
@@ -1421,6 +1442,28 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return 0;
 
 errout:
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE) {
+		bool mapping_may_exist;
+
+		mutex_lock(&region->mreg_mutex);
+		mapping_may_exist = region->mapping_may_exist;
+		mutex_unlock(&region->mreg_mutex);
+		if (!mapping_may_exist)
+			goto put_region;
+	} else if (!region->mapping_may_exist) {
+		goto put_region;
+	}
+
+	spin_lock(&partition->pt_mem_regions_lock);
+	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+	spin_unlock(&partition->pt_mem_regions_lock);
+	pt_err(partition,
+	       "Retaining region after uncertain map cleanup at GFN %#llx\n",
+	       region->start_gfn);
+	mshv_quarantine_partition(partition);
+	return ret;
+
+put_region:
 	mshv_region_put(region);
 	return ret;
 }
@@ -1431,33 +1474,64 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 		       struct mshv_user_mem_region *mem)
 {
 	struct mshv_mem_region *region;
+	long ret;
 
 	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
 
+	/*
+	 * The list owns one reference. Take a temporary reference and detach
+	 * under the lookup lock before waiting for existing remappers. This
+	 * prevents a zero-ref region from being reinserted on unmap failure.
+	 */
 	spin_lock(&partition->pt_mem_regions_lock);
-
 	region = mshv_partition_region_by_gfn(partition, mem->guest_pfn);
-	if (!region) {
+	if (!region || !mshv_region_get(region)) {
 		spin_unlock(&partition->pt_mem_regions_lock);
 		return -ENOENT;
 	}
 
-	/* Paranoia check */
 	if (region->start_uaddr != mem->userspace_addr ||
 	    region->start_gfn != mem->guest_pfn ||
 	    region->nr_pages != HVPFN_DOWN(mem->size)) {
 		spin_unlock(&partition->pt_mem_regions_lock);
+		mshv_region_put(region);
 		return -EINVAL;
 	}
 
-	hlist_del(&region->hnode);
-
+	WRITE_ONCE(region->faults_blocked, true);
+	hlist_del_init(&region->hnode);
 	spin_unlock(&partition->pt_mem_regions_lock);
 
-	mshv_region_put(region);
+	/* Drain admitted faults, then serialize against the notifier remap. */
+	down_write(&region->mreg_fault_lock);
+	mutex_lock(&region->mreg_mutex);
+	ret = mshv_region_unmap(region);
+	if (ret)
+		goto restore_region;
+
+	mutex_unlock(&region->mreg_mutex);
+	up_write(&region->mreg_fault_lock);
+
+	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
+		mshv_region_movable_fini(region);
 
+	/* Drop the detached list ownership and the temporary reference. */
+	mshv_region_put(region);
+	mshv_region_put(region);
 	return 0;
+
+restore_region:
+	/* Restore lookup visibility before allowing remappers to proceed. */
+	spin_lock(&partition->pt_mem_regions_lock);
+	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+	WRITE_ONCE(region->faults_blocked, false);
+	spin_unlock(&partition->pt_mem_regions_lock);
+	mutex_unlock(&region->mreg_mutex);
+	up_write(&region->mreg_fault_lock);
+	mshv_region_put(region);
+	return ret;
+
 }
 
 static long
@@ -1658,6 +1732,11 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	if (mutex_lock_killable(&partition->pt_mutex))
 		return -EINTR;
 
+	if (partition->teardown_quarantined) {
+		ret = -EIO;
+		goto out;
+	}
+
 	switch (ioctl) {
 	case MSHV_INITIALIZE_PARTITION:
 		ret = mshv_partition_ioctl_initialize(partition);
@@ -1688,6 +1767,7 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = -ENOTTY;
 	}
 
+out:
 	mutex_unlock(&partition->pt_mutex);
 	return ret;
 }
@@ -1795,6 +1875,16 @@ remove_partition(struct mshv_partition *partition)
 	synchronize_rcu();
 }
 
+static void mshv_quarantine_partition(struct mshv_partition *partition)
+{
+	if (partition->teardown_quarantined)
+		return;
+
+	/* Retain both the partition and the cleanup code indefinitely. */
+	__module_get(THIS_MODULE);
+	partition->teardown_quarantined = true;
+}
+
 /*
  * Tear down a partition and remove it from the list.
  * Partition's refcount must be 0
@@ -1814,6 +1904,39 @@ static void destroy_partition(struct mshv_partition *partition)
 
 	trace_mshv_destroy_partition(partition->pt_id);
 
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		bool was_blocked;
+		int unmap_ret;
+
+		/* Stop new lookup users before draining in-flight remappers. */
+		spin_lock(&partition->pt_mem_regions_lock);
+		was_blocked = READ_ONCE(region->faults_blocked);
+		WRITE_ONCE(region->faults_blocked, true);
+		spin_unlock(&partition->pt_mem_regions_lock);
+
+		down_write(&region->mreg_fault_lock);
+		mutex_lock(&region->mreg_mutex);
+		unmap_ret = mshv_region_unmap(region);
+		if (unmap_ret) {
+			spin_lock(&partition->pt_mem_regions_lock);
+			WRITE_ONCE(region->faults_blocked, was_blocked);
+			spin_unlock(&partition->pt_mem_regions_lock);
+			mutex_unlock(&region->mreg_mutex);
+			up_write(&region->mreg_fault_lock);
+
+			pt_err(partition,
+			       "Failed to unmap region at GFN %#llx: %d; retaining partition\n",
+			       region->start_gfn, unmap_ret);
+			mshv_quarantine_partition(partition);
+			return;
+		}
+		mutex_unlock(&region->mreg_mutex);
+		up_write(&region->mreg_fault_lock);
+
+		if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
+			mshv_region_movable_fini(region);
+	}
+
 	if (partition->pt_initialized) {
 		/*
 		 * We only need to drain signals for root scheduler. This should be
@@ -1874,7 +1997,7 @@ static void destroy_partition(struct mshv_partition *partition)
 
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
 				  hnode) {
-		hlist_del(&region->hnode);
+		hlist_del_init(&region->hnode);
 		mshv_region_put(region);
 	}
 
@@ -1883,6 +2006,8 @@ static void destroy_partition(struct mshv_partition *partition)
 	hv_call_delete_partition(partition->pt_id);
 
 	mshv_free_routing_table(partition);
+	if (partition->teardown_quarantined)
+		module_put(THIS_MODULE);
 	kfree(partition);
 }
 
-- 
2.43.0

