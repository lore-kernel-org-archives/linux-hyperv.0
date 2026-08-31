Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AFB3DE43B;
	Mon, 31 Aug 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175662; cv=none; b=nne4FU1KRCwXtYQjDxAQNwW3+kpH7GakdOofQeC+eivAf4v7GyUbkcUa0Prrfgk9k0Kif/c8wC4gVMDj/8CSmuuBGqU/POg03tIh+Y7n97IrHvTQoVHihDRAkbOT6G13H/+WJJg+tHcNr7Ypx4MTZUrpRlpRlGzITzrvH0PXB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175662; c=relaxed/simple;
	bh=TX/5IbotdF5blinrzL7t44UaGCU9G+OM+/5rnbEMtoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyTbOF5GvrGUm4FFV1xsGBTl6fR79GKW6NRXrGaEArRSeFkvlwmq212llmpAgyxwfLOaQmkrpb4+Lot0QUoxR9zg3Zt5oT56IkxjIa3/kgYTHt/Dp7F9MYASETRHaf87PW9gSvS5MfYZO/9C0NZrkwUWrCSloCShsSL+zPoVjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bUEPz/aW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bUEPz/aW"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF1C20B710C;
	Mon, 31 Aug 2026 04:27:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF1C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788175623;
	bh=i/JM4TSoeamN5+DkvOWuwEKTbP/oAws1zIvPGgTyFhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUEPz/aWzDlUP5EOaOSDCaa6GWF71kg7HyOwaYMoKe1NMF1+Ioh2vB8Jw5+VMIBdw
	 QhbqDHYBnxuPHiYldFUIjp70a50ej3epqvMUviZOiL1D7NqGVIL4bjmGI8/hnMBP3Y
	 oCjlSVZgHAMgzh6nVge9H41ClE/1NnmK8GljOoUs=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v4 6/9] mshv: wire SEV-SNP partition ioctls
Date: Mon, 31 Aug 2026 11:26:44 +0000
Message-ID: <20260831112704.2851147-7-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831112704.2851147-1-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Wire the SEV-SNP UAPI into partition creation, memory ownership,
isolated-page import, launch completion, PSP guest requests, AP creation,
and teardown.

Publish exact array-entry progress on success and partial failure so
userspace can resume at array + completed. Completed operations are not
rolled back. Validate MBZ fields, initialize completed before every
common copyout, and validate repetition progress, large-page conversion,
PSP GPA alignment, and VMSA GPA alignment. Quarantine uncertain ownership
or unreportable progress.

Track child mappings and released host access per region. On setup
failure, remove any partial child mapping before reacquiring host access.
For initialized and uninitialized SNP partitions alike, unmap every child
mapping, destroy initialized isolation state, restore host access, and
only then unpin. Retain the partition and module on any safety-critical
failure.

Hyper-V transfers root-to-child SPA/SLAT ownership directly; this
intentionally does not alter the root direct map, memory encryption
attributes, or GPA shared-bit encoding.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_regions.c      |  34 +-
 drivers/hv/mshv_root.h         |  16 +-
 drivers/hv/mshv_root_hv_call.c |  71 +++-
 drivers/hv/mshv_root_main.c    | 715 +++++++++++++++++++++++++++++++--
 include/hyperv/hvgdk_mini.h    |  12 +
 5 files changed, 782 insertions(+), 66 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 9feb49d9d9d4..01972d77881b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -199,12 +199,14 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 				   u64 page_offset, u64 page_count,
 				   bool huge_page)
 {
+	u64 completed;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
 	return hv_call_modify_spa_host_access(region->partition->pt_id,
 					      region->mreg_pages + page_offset,
-					      page_count,
+					      page_count, &completed,
 					      HV_MAP_GPA_READABLE |
 					      HV_MAP_GPA_WRITABLE,
 					      flags, true);
@@ -213,10 +215,14 @@ static int mshv_region_chunk_share(struct mshv_mem_region *region,
 int mshv_region_share(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
+	int ret;
 
-	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
-					 mshv_region_chunk_share);
+	ret = mshv_region_process_range(region, flags, 0, region->nr_pages,
+					mshv_region_chunk_share);
+	if (!ret)
+		region->host_access_released = false;
+
+	return ret;
 }
 
 static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
@@ -224,21 +230,26 @@ static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
 				     u64 page_offset, u64 page_count,
 				     bool huge_page)
 {
+	u64 completed;
+	int ret;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pages + page_offset,
-					      page_count, 0,
-					      flags, false);
+	/* A failed release may have made a prefix inaccessible to the host. */
+	region->host_access_released = true;
+	ret = hv_call_modify_spa_host_access(region->partition->pt_id,
+					     region->mreg_pages + page_offset,
+					    page_count, &completed, 0,
+					    flags, false);
+	return ret;
 }
 
 int mshv_region_unshare(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
-	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
+	return mshv_region_process_range(region, flags, 0, region->nr_pages,
 					 mshv_region_chunk_unshare);
 }
 
@@ -373,7 +384,8 @@ static void mshv_region_destroy(struct kref *ref)
 		container_of(ref, struct mshv_mem_region, mreg_refcount);
 
 	/* Callers must retain the list reference until cleanup is certain. */
-	if (WARN_ON_ONCE(region->mapping_may_exist))
+	if (WARN_ON_ONCE(region->mapping_may_exist ||
+			 region->host_access_released))
 		return;
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index a87d9773093c..89753dcbcc07 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -91,6 +91,7 @@ struct mshv_mem_region {
 	u32 hv_map_flags;
 	/* True until a checked hypervisor unmap has completed. */
 	bool mapping_may_exist;
+	bool host_access_released;
 	struct mshv_partition *partition;
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
@@ -164,6 +165,12 @@ do { \
 #define pt_crit(p, fmt, ...)	pt_devprintk(crit, p, fmt, ##__VA_ARGS__)
 #define pt_alert(p, fmt, ...)	pt_devprintk(alert, p, fmt, ##__VA_ARGS__)
 #define pt_err(p, fmt, ...)	pt_devprintk(err, p, fmt, ##__VA_ARGS__)
+#define pt_err_ratelimited(p, fmt, ...) \
+do { \
+	const struct mshv_partition *__pt = (p); \
+	dev_err_ratelimited(__pt->pt_module_dev, pt_fmt(fmt), __pt->pt_id, \
+			    ##__VA_ARGS__); \
+} while (0)
 #define pt_warn(p, fmt, ...)	pt_devprintk(warn, p, fmt, ##__VA_ARGS__)
 #define pt_notice(p, fmt, ...)	pt_devprintk(notice, p, fmt, ##__VA_ARGS__)
 #define pt_info(p, fmt, ...)	pt_devprintk(info, p, fmt, ##__VA_ARGS__)
@@ -338,8 +345,8 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 			struct hv_stats_page *page_addr,
 			const union hv_stats_object_identity *identity);
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
-				   u32 flags, u8 acquire);
+				   u64 page_struct_count, u64 *completed_pages,
+				   u32 host_access, u32 flags, u8 acquire);
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
 				      void *property_value, size_t property_value_sz);
 
@@ -388,6 +395,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void *, u64 *),
+				   void *completion_data);
+
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages, u64 *completed_pages,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb5727529355..48ac6fb808f4 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1046,6 +1046,42 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
 
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void *, u64 *),
+				   void *completion_data)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_set_partition_property *input;
+
+	if (!completion_handler) {
+		pr_err("%s: Missing completion handler\n", __func__);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	input->property_value = property_value;
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input, NULL);
+	local_irq_restore(flags);
+
+	if (unlikely(hv_result(status) == HV_STATUS_CALL_PENDING))
+		completion_handler(completion_data, &status);
+
+	if (!hv_result_success(status)) {
+		pr_err_ratelimited("%s: %s\n", __func__,
+				   hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages, u64 *completed_pages,
 				  enum hv_isolated_page_type page_type,
@@ -1192,19 +1228,20 @@ int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
 #endif
 
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
-				   u32 flags, u8 acquire)
+				   u64 page_struct_count, u64 *completed_pages,
+				   u32 host_access, u32 flags, u8 acquire)
 {
 	struct hv_input_modify_sparse_spa_page_host_access *input_page;
 	u64 status;
-	int done = 0;
+	u64 done = 0;
 	unsigned long irq_flags, large_shift = 0;
 	u64 page_count = page_struct_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
 			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
 
-	if (page_count == 0)
+	if (page_count == 0 || !completed_pages)
 		return -EINVAL;
+	*completed_pages = 0;
 
 	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
 		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
@@ -1214,8 +1251,8 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 	}
 
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain,
+		u64 i, completed, remain = page_count - done;
+		unsigned int rep_count = min_t(u64, remain,
 				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
 
 		local_irq_save(irq_flags);
@@ -1233,8 +1270,10 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		for (i = 0; i < rep_count; i++) {
 			u64 index = (done + i) << large_shift;
 
-			if (index >= page_struct_count)
+			if (index >= page_struct_count) {
+				local_irq_restore(irq_flags);
 				return -EINVAL;
+			}
 
 			input_page->spa_page_list[i] =
 						page_to_pfn(pages[index]);
@@ -1245,11 +1284,23 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
-
-		if (!hv_result_success(status))
-			return hv_result_to_errno(status);
+		if (completed > rep_count) {
+			pr_err_ratelimited("%s: invalid completion count %llu/%u\n",
+					   __func__, completed, rep_count);
+			return -EPROTO;
+		}
 
 		done += completed;
+		*completed_pages += (u64)completed << large_shift;
+		if (!hv_result_success(status)) {
+			pr_err_ratelimited("%s: completed %llu of %llu pages: %s\n",
+					   __func__, *completed_pages,
+					   page_struct_count,
+					   hv_result_to_string(status));
+			return hv_result_to_errno(status);
+		}
+		if (!completed)
+			return -EPROTO;
 	}
 
 	return 0;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 4a15d4bfa925..424b7da680c1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -642,6 +642,45 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int mshv_gpfns_to_pages(struct mshv_partition *partition,
+			       const u64 *gpfns, u64 page_count,
+			       struct page **pages)
+{
+	struct mshv_mem_region *region;
+	u64 i;
+	int ret = 0;
+
+	for (i = 0; i < page_count; i++) {
+		u64 gfn = gpfns[i];
+		u64 offset;
+
+		region = mshv_partition_region_by_gfn_get(partition, gfn);
+		if (!region) {
+			pt_err_ratelimited(partition,
+					   "Failed to find region for GFN %#llx\n",
+					   gfn);
+			return -ERANGE;
+		}
+
+		offset = gfn - region->start_gfn;
+		mutex_lock(&region->mreg_mutex);
+		if (offset >= region->nr_pages || !region->mreg_pages[offset]) {
+			ret = -EFAULT;
+			mutex_unlock(&region->mreg_mutex);
+			mshv_region_put(region);
+			return ret;
+		}
+
+		pages[i] = region->mreg_pages[offset];
+		mutex_unlock(&region->mreg_mutex);
+		mshv_region_put(region);
+	}
+
+	return 0;
+}
+#endif
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -1214,12 +1253,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 static int mshv_init_async_handler(struct mshv_partition *partition)
 {
-	if (completion_done(&partition->async_hypercall)) {
-		pt_err(partition,
-		       "Cannot issue async hypercall while another one in progress!\n");
-		return -EPERM;
-	}
-
+	/* Partition ioctls are serialized by pt_mutex. */
 	reinit_completion(&partition->async_hypercall);
 	return 0;
 }
@@ -1297,51 +1331,51 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 
 	ret = mshv_region_pin(region);
 	if (ret) {
-		pt_err(partition, "Failed to pin memory region: %d\n",
-		       ret);
-		goto err_out;
+		pt_err(partition, "Failed to pin memory region: %d\n", ret);
+		return ret;
 	}
 
-	/*
-	 * For an SNP partition it is a requirement that for every memory region
-	 * that we are going to map for this partition we should make sure that
-	 * host access to that region is released. This is ensured by doing an
-	 * additional hypercall which will update the SLAT to release host
-	 * access to guest memory regions.
-	 */
 	if (mshv_partition_encrypted(partition)) {
+		int recovery_ret;
+
 		ret = mshv_region_unshare(region);
 		if (ret) {
-			pt_err(partition,
-			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
-			       region->start_gfn, ret);
+			pt_err_ratelimited(partition,
+					   "Failed to release host access at GFN %#llx: %d\n",
+					   region->start_gfn, ret);
+			recovery_ret = mshv_region_share(region);
+			if (recovery_ret) {
+				pt_err(partition,
+				       "Failed to recover host access at GFN %#llx: %d; retaining region\n",
+				       region->start_gfn, recovery_ret);
+				return ret;
+			}
 			goto invalidate_region;
 		}
 	}
 
 	ret = mshv_region_map(region);
-	if (ret && mshv_partition_encrypted(partition)) {
-		int shrc;
+	if (!ret)
+		return 0;
 
-		shrc = mshv_region_share(region);
-		if (!shrc)
-			goto invalidate_region;
+	/* A partial map must be removed before host access is reacquired. */
+	if (region->mapping_may_exist)
+		return ret;
 
-		pt_err(partition,
-		       "Failed to share memory region (guest_pfn: %llu): %d\n",
-		       region->start_gfn, shrc);
-		/*
-		 * Don't unpin if marking shared failed because pages are no
-		 * longer mapped in the host, ie root, anymore.
-		 */
-		goto err_out;
-	}
+	if (mshv_partition_encrypted(partition) &&
+	    region->host_access_released) {
+		int recovery_ret = mshv_region_share(region);
 
-	return 0;
+		if (recovery_ret) {
+			pt_err(partition,
+			       "Failed to recover host access after map failure at GFN %#llx: %d; retaining region\n",
+			       region->start_gfn, recovery_ret);
+			return ret;
+		}
+	}
 
 invalidate_region:
 	mshv_region_invalidate(region);
-err_out:
 	return ret;
 }
 
@@ -1424,12 +1458,12 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return 0;
 
 errout:
-	if (region->mapping_may_exist) {
+	if (region->mapping_may_exist || region->host_access_released) {
 		spin_lock(&partition->pt_mem_regions_lock);
 		hlist_add_head(&region->hnode, &partition->pt_mem_regions);
 		spin_unlock(&partition->pt_mem_regions_lock);
 		pt_err(partition,
-		       "Retaining region after uncertain map cleanup at GFN %#llx\n",
+		       "Retaining region with uncertain ownership at GFN %#llx\n",
 		       region->start_gfn);
 		mshv_quarantine_partition(partition);
 	} else {
@@ -1448,6 +1482,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 
 	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
+	if (partition->pt_initialized && mshv_partition_encrypted(partition))
+		return -EBUSY;
 
 	/*
 	 * The list owns one reference. Take a temporary reference and detach
@@ -1479,6 +1515,17 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	if (ret)
 		goto restore_region;
 
+	if (region->host_access_released) {
+		ret = mshv_region_share(region);
+		if (ret) {
+			pt_err_ratelimited(partition,
+					   "Failed to restore host access at GFN %#llx: %ld\n",
+					   region->start_gfn, ret);
+			mshv_quarantine_partition(partition);
+			goto retain_blocked;
+		}
+	}
+
 	up_write(&region->mreg_remap_lock);
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
@@ -1499,6 +1546,14 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	mshv_region_put(region);
 	return ret;
 
+retain_blocked:
+	/* Keep list ownership for quarantined teardown, but forbid remapping. */
+	spin_lock(&partition->pt_mem_regions_lock);
+	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+	spin_unlock(&partition->pt_mem_regions_lock);
+	up_write(&region->mreg_remap_lock);
+	mshv_region_put(region);
+	return ret;
 }
 
 static long
@@ -1689,6 +1744,473 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int set_sev_control_register(struct mshv_vp *vp,
+				    u64 enable_encrypted_state,
+				    u64 vmsa_gpa_page_number)
+{
+	struct hv_register_assoc sev_control = {
+		.name = HV_X64_REGISTER_SEV_CONTROL,
+	};
+
+	sev_control.value.sev_control.enable_encrypted_state =
+		enable_encrypted_state;
+	sev_control.value.sev_control.vmsa_gpa_page_number =
+		vmsa_gpa_page_number;
+
+	return mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+					 1, &sev_control);
+}
+
+static long
+mshv_partition_ioctl_sev_snp_ap_create(struct mshv_partition *partition,
+				       void __user *user_args)
+{
+	struct hv_register_assoc internal_activity = {
+		.name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+		.value.internal_activity.as_uint64 = 0,
+	};
+	struct mshv_sev_snp_ap_create req;
+	struct mshv_vp *vp;
+	long ret;
+
+	if (copy_from_user(&req, user_args, sizeof(req)))
+		return -EFAULT;
+
+	if (req.vp_id >= MSHV_MAX_VPS ||
+	    !IS_ALIGNED(req.vmsa_gpa, MSHV_HV_PAGE_SIZE))
+		return -EINVAL;
+
+	vp = partition->pt_vp_array[req.vp_id];
+	if (!vp)
+		return -EINVAL;
+
+	ret = set_sev_control_register(vp, 1, HVPFN_DOWN(req.vmsa_gpa));
+	if (ret) {
+		vp_err(vp, "Failed to set SEV control register\n");
+		return ret;
+	}
+
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id, 1,
+				    &internal_activity);
+	if (ret)
+		vp_err(vp, "Failed to set internal activity\n");
+
+	return ret;
+}
+
+static bool mshv_pages_are_contiguous_2m(struct page **pages,
+					 u64 page_count)
+{
+	const u64 pages_per_large_page =
+		1ULL << (HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT);
+	u64 i, j;
+
+	if (!IS_ALIGNED(page_count, pages_per_large_page))
+		return false;
+
+	for (i = 0; i < page_count; i += pages_per_large_page) {
+		u64 base_pfn = page_to_pfn(pages[i]);
+
+		if (!IS_ALIGNED(base_pfn, pages_per_large_page))
+			return false;
+		for (j = 1; j < pages_per_large_page; j++)
+			if (page_to_pfn(pages[i + j]) != base_pfn + j)
+				return false;
+	}
+
+	return true;
+}
+
+#define MSHV_USER_PAGE_BATCH_SIZE	4096
+
+static long
+mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *partition,
+					    void __user *user_args)
+{
+	struct mshv_modify_gpa_host_access args;
+	struct page **pages = NULL;
+	u64 __user *guest_gpas;
+	u64 *gpfns = NULL;
+	u64 input_completed;
+	u64 offset = 0;
+	u32 host_access = 0;
+	u32 flags = 0;
+	bool acquire;
+	long ret = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	input_completed = args.completed;
+	args.completed = 0;
+	if ((args.flags & ~MSHV_GPA_HOST_ACCESS_FLAGS_MASK) ||
+	    mshv_field_nonzero(args, rsvd) || input_completed ||
+	    !args.page_count || !args.guest_gpas) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if ((args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE)) &&
+	    !IS_ALIGNED(args.page_count,
+			1ULL << (HV_HYP_LARGE_PAGE_SHIFT -
+				HV_HYP_PAGE_SHIFT))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	guest_gpas = u64_to_user_ptr(args.guest_gpas);
+	gpfns = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*gpfns),
+			       GFP_KERNEL);
+	pages = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*pages),
+			       GFP_KERNEL);
+	if (!gpfns || !pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_READABLE))
+		host_access |= HV_MAP_GPA_READABLE;
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_WRITABLE))
+		host_access |= HV_MAP_GPA_WRITABLE;
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE))
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+	acquire = args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_ACQUIRE);
+
+	while (offset < args.page_count) {
+		u64 count = min_t(u64, args.page_count - offset,
+				  MSHV_USER_PAGE_BATCH_SIZE);
+		u64 completed = 0;
+		u64 i;
+
+		if (copy_from_user(gpfns, guest_gpas + offset,
+				   array_size(count, sizeof(*gpfns)))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		for (i = 0; i < count; i++) {
+			if (!IS_ALIGNED(gpfns[i], MSHV_HV_PAGE_SIZE)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			gpfns[i] = HVPFN_DOWN(gpfns[i]);
+		}
+
+		ret = mshv_gpfns_to_pages(partition, gpfns, count, pages);
+		if (ret)
+			break;
+
+		if ((flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) &&
+		    !mshv_pages_are_contiguous_2m(pages, count)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = hv_call_modify_spa_host_access(partition->pt_id, pages,
+						     count, &completed,
+						     host_access, flags, acquire);
+		if (completed > count) {
+			ret = -EPROTO;
+			completed = 0;
+		}
+		offset += completed;
+		if (ret) {
+			if (ret == -EPROTO)
+				mshv_quarantine_partition(partition);
+			break;
+		}
+		if (completed != count) {
+			ret = -EPROTO;
+			mshv_quarantine_partition(partition);
+			break;
+		}
+		cond_resched();
+	}
+
+out:
+	args.completed = offset;
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		if (offset)
+			mshv_quarantine_partition(partition);
+		ret = -EFAULT;
+	}
+	kvfree(pages);
+	kvfree(gpfns);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partition,
+					   void __user *user_args)
+{
+	struct mshv_import_isolated_pages args;
+	u64 __user *guest_pfns;
+	u64 *pages = NULL;
+	u64 input_completed;
+	u64 offset = 0;
+	long ret = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	input_completed = args.completed;
+	args.completed = 0;
+	if (args.page_type >= MSHV_ISOLATED_PAGE_COUNT ||
+	    args.page_size >= MSHV_ISOLATED_PAGE_SIZE_COUNT ||
+	    mshv_field_nonzero(args, rsvd) || input_completed ||
+	    !args.page_count || !args.guest_pfns) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	guest_pfns = u64_to_user_ptr(args.guest_pfns);
+	pages = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*pages),
+			       GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	while (offset < args.page_count) {
+		u64 count = min_t(u64, args.page_count - offset,
+				  MSHV_USER_PAGE_BATCH_SIZE);
+		u64 completed = 0;
+
+		if (copy_from_user(pages, guest_pfns + offset,
+				   array_size(count, sizeof(*pages)))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (args.page_size == MSHV_ISOLATED_PAGE_SIZE_2MB) {
+			u64 i;
+
+			for (i = 0; i < count; i++) {
+				if (!IS_ALIGNED(pages[i],
+						1ULL <<
+						(HV_HYP_LARGE_PAGE_SHIFT -
+						 HV_HYP_PAGE_SHIFT))) {
+					ret = -EINVAL;
+					goto out;
+				}
+			}
+		}
+
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			break;
+
+		ret = hv_call_import_isolated_pages(partition->pt_id, pages,
+						    count, &completed,
+						    args.page_type,
+						    args.page_size,
+						    mshv_async_hvcall_handler,
+						    partition);
+		if (completed > count) {
+			ret = -EPROTO;
+			completed = 0;
+		}
+		offset += completed;
+		if (ret) {
+			if (ret == -EPROTO)
+				mshv_quarantine_partition(partition);
+			break;
+		}
+		if (completed != count) {
+			ret = -EPROTO;
+			mshv_quarantine_partition(partition);
+			break;
+		}
+		cond_resched();
+	}
+
+out:
+	args.completed = offset;
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		if (offset)
+			mshv_quarantine_partition(partition);
+		ret = -EFAULT;
+	}
+	kvfree(pages);
+	return ret;
+}
+
+static void
+mshv_copy_snp_id_auth_info(struct hv_snp_id_auth_info *dst,
+			   const struct mshv_snp_id_auth_info *src)
+{
+	dst->id_key_algorithm = src->id_key_algorithm;
+	dst->auth_key_algorithm = src->auth_key_algorithm;
+	memcpy(dst->reserved0, src->reserved0, sizeof(dst->reserved0));
+	memcpy(dst->id_block_signature, src->id_block_signature,
+	       sizeof(dst->id_block_signature));
+	memcpy(dst->id_key, src->id_key, sizeof(dst->id_key));
+	memcpy(dst->reserved1, src->reserved1, sizeof(dst->reserved1));
+	memcpy(dst->id_key_signature, src->id_key_signature,
+	       sizeof(dst->id_key_signature));
+	memcpy(dst->author_key, src->author_key, sizeof(dst->author_key));
+}
+
+static long
+mshv_partition_ioctl_complete_isolated_import(struct mshv_partition *partition,
+					      void __user *user_args)
+{
+	union hv_partition_complete_isolated_import_data *import_data;
+	struct mshv_psp_launch_finish_data *psp;
+	struct mshv_complete_isolated_import args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+	if (!args.psp_parameters)
+		return -EINVAL;
+
+	psp = memdup_user(u64_to_user_ptr(args.psp_parameters), sizeof(*psp));
+	if (IS_ERR(psp))
+		return PTR_ERR(psp);
+	if (memchr_inv(psp->reserved, 0, sizeof(psp->reserved))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	import_data = kvzalloc(sizeof(*import_data), GFP_KERNEL);
+	if (!import_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(import_data->psp_parameters.id_block.launch_digest,
+	       psp->id_block.launch_digest,
+	       sizeof(psp->id_block.launch_digest));
+	memcpy(import_data->psp_parameters.id_block.family_id,
+	       psp->id_block.family_id, sizeof(psp->id_block.family_id));
+	memcpy(import_data->psp_parameters.id_block.image_id,
+	       psp->id_block.image_id, sizeof(psp->id_block.image_id));
+	import_data->psp_parameters.id_block.version = psp->id_block.version;
+	import_data->psp_parameters.id_block.guest_svn = psp->id_block.guest_svn;
+	import_data->psp_parameters.id_block.policy.as_uint64 =
+		psp->id_block.policy;
+	mshv_copy_snp_id_auth_info(&import_data->psp_parameters.id_auth_info,
+				   &psp->id_auth_info);
+	memcpy(import_data->psp_parameters.host_data, psp->host_data,
+	       sizeof(psp->host_data));
+	import_data->psp_parameters.id_block_enabled = psp->id_block_enabled;
+	import_data->psp_parameters.author_key_enabled = psp->author_key_enabled;
+
+	ret = mshv_init_async_handler(partition);
+	if (!ret)
+		ret = hv_call_complete_isolated_import(partition->pt_id,
+						       import_data,
+						       mshv_async_hvcall_handler,
+						       partition);
+	if (!ret)
+		partition->import_completed = true;
+
+	kvfree(import_data);
+out:
+	kfree(psp);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_issue_psp_guest_request(struct mshv_partition *partition,
+					     void __user *user_args)
+{
+	struct mshv_issue_psp_guest_request req;
+	u32 host_access = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE;
+	struct page *pages[2];
+	u64 completed;
+	u64 gpfns[2];
+	long ret;
+
+	if (copy_from_user(&req, user_args, sizeof(req)))
+		return -EFAULT;
+	if (!IS_ALIGNED(req.req_gpa, MSHV_HV_PAGE_SIZE) ||
+	    !IS_ALIGNED(req.rsp_gpa, MSHV_HV_PAGE_SIZE)) {
+		pt_err_ratelimited(partition,
+				   "Unaligned PSP request GPAs %#llx/%#llx\n",
+				   req.req_gpa, req.rsp_gpa);
+		return -EINVAL;
+	}
+
+	gpfns[0] = HVPFN_DOWN(req.req_gpa);
+	gpfns[1] = HVPFN_DOWN(req.rsp_gpa);
+
+	ret = mshv_gpfns_to_pages(partition, gpfns, ARRAY_SIZE(gpfns), pages);
+	if (ret)
+		return ret;
+
+	ret = hv_call_modify_spa_host_access(partition->pt_id, pages,
+					     ARRAY_SIZE(pages), &completed,
+					     0, 0, false);
+	if (ret)
+		goto restore_host_access;
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		goto restore_host_access;
+
+	ret = hv_call_issue_psp_guest_request(partition->pt_id,
+					      HVPFN_DOWN(req.req_gpa),
+					      HVPFN_DOWN(req.rsp_gpa),
+					      mshv_async_hvcall_handler,
+					      partition);
+	if (!ret)
+		return 0;
+
+restore_host_access:
+	{
+		int restore_ret;
+
+		restore_ret = hv_call_modify_spa_host_access(partition->pt_id,
+							     pages, ARRAY_SIZE(pages),
+							     &completed, host_access,
+							     0, true);
+		if (restore_ret) {
+			pt_err(partition,
+			       "Failed to restore PSP request page access: %d\n",
+			       restore_ret);
+			mshv_quarantine_partition(partition);
+			if (!ret)
+				ret = restore_ret;
+		}
+	}
+	return ret;
+}
+
+static long mshv_partition_snp_ioctl(unsigned int ioctl,
+				     struct mshv_partition *partition,
+				     unsigned long arg)
+{
+	void __user *uarg = (void __user *)arg;
+
+	if (!mshv_partition_encrypted(partition)) {
+		pt_err(partition,
+		       "Ioctl(%u) not supported for non SEV-SNP partition\n",
+		       ioctl);
+		return -EOPNOTSUPP;
+	}
+
+	switch (ioctl) {
+	case MSHV_MODIFY_GPA_HOST_ACCESS:
+		return mshv_partition_ioctl_modify_gpa_host_access(partition,
+								   uarg);
+	case MSHV_IMPORT_ISOLATED_PAGES:
+		return mshv_partition_ioctl_import_isolated_pages(partition,
+								  uarg);
+	case MSHV_COMPLETE_ISOLATED_IMPORT:
+		return mshv_partition_ioctl_complete_isolated_import(partition,
+								     uarg);
+	case MSHV_ISSUE_PSP_GUEST_REQUEST:
+		return mshv_partition_ioctl_issue_psp_guest_request(partition,
+								    uarg);
+	case MSHV_SEV_SNP_AP_CREATE:
+		return mshv_partition_ioctl_sev_snp_ap_create(partition, uarg);
+	default:
+		return -ENOTTY;
+	}
+}
+#endif
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1730,6 +2252,15 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_ROOT_HVCALL:
 		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
 		break;
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	case MSHV_MODIFY_GPA_HOST_ACCESS:
+	case MSHV_IMPORT_ISOLATED_PAGES:
+	case MSHV_COMPLETE_ISOLATED_IMPORT:
+	case MSHV_ISSUE_PSP_GUEST_REQUEST:
+	case MSHV_SEV_SNP_AP_CREATE:
+		ret = mshv_partition_snp_ioctl(ioctl, partition, arg);
+		break;
+#endif
 	default:
 		ret = -ENOTTY;
 	}
@@ -1842,12 +2373,75 @@ remove_partition(struct mshv_partition *partition)
 	synchronize_rcu();
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int destroy_snp_partition_state(struct mshv_partition *partition)
+{
+	struct hv_register_assoc explicit_suspend = {
+		.name = HV_REGISTER_EXPLICIT_SUSPEND,
+		.value.explicit_suspend.suspended = 1,
+	};
+	struct mshv_vp *vp;
+	int i, ret;
+
+	for (i = 0; i < MSHV_MAX_VPS; i++) {
+		vp = partition->pt_vp_array[i];
+		if (!vp)
+			continue;
+
+		ret = mshv_set_vp_registers(vp->vp_index,
+					    vp->vp_partition->pt_id, 1,
+					    &explicit_suspend);
+		if (ret) {
+			vp_err(vp, "Failed to set explicit suspend\n");
+			return ret;
+		}
+
+		ret = set_sev_control_register(vp, 0, 0);
+		if (ret) {
+			vp_err(vp, "Failed to clear SEV control register\n");
+			return ret;
+		}
+	}
+
+	if (partition->import_completed) {
+		union hv_partition_isolation_control isolation_control = {};
+
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			return ret;
+
+		ret = hv_call_set_partition_property(partition->pt_id,
+						     HV_PARTITION_PROPERTY_ISOLATION_CONTROL,
+					     isolation_control.as_uint64,
+					     mshv_async_hvcall_handler, partition);
+		if (ret) {
+			pt_err(partition, "Failed to clear runnable bit\n");
+			return ret;
+		}
+	}
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		return ret;
+
+	ret = hv_call_set_partition_property(partition->pt_id,
+					     HV_PARTITION_PROPERTY_ISOLATION_STATE,
+					     HV_PARTITION_ISOLATION_INSECURE_DIRTY,
+					     mshv_async_hvcall_handler, partition);
+	if (ret)
+		pt_err(partition,
+		       "Failed to set isolation state to INSECURE_DIRTY\n");
+
+	return ret;
+}
+#endif
+
 static void mshv_quarantine_partition(struct mshv_partition *partition)
 {
 	if (partition->teardown_quarantined)
 		return;
 
-	/* Retain both the partition and the cleanup code indefinitely. */
+	/* Retain the partition, pinned pages, and cleanup code indefinitely. */
 	__module_get(THIS_MODULE);
 	partition->teardown_quarantined = true;
 }
@@ -1862,6 +2456,9 @@ static void destroy_partition(struct mshv_partition *partition)
 	struct mshv_mem_region *region;
 	struct hlist_node *n;
 	int i;
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	int ret;
+#endif
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1901,6 +2498,34 @@ static void destroy_partition(struct mshv_partition *partition)
 			mshv_region_movable_fini(region);
 	}
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	if (mshv_partition_encrypted(partition)) {
+		if (partition->pt_initialized) {
+			ret = destroy_snp_partition_state(partition);
+			if (ret) {
+				pt_err(partition,
+				       "Failed to destroy SNP state: %d; retaining partition\n",
+				       ret);
+				mshv_quarantine_partition(partition);
+				return;
+			}
+		}
+
+		hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+			if (!region->host_access_released)
+				continue;
+			ret = mshv_region_share(region);
+			if (ret) {
+				pt_err(partition,
+				       "Failed to restore host access at GFN %#llx: %d; retaining partition\n",
+				       region->start_gfn, ret);
+				mshv_quarantine_partition(partition);
+				return;
+			}
+		}
+	}
+#endif
+
 	if (partition->pt_initialized) {
 		/*
 		 * We only need to drain signals for root scheduler. This should be
@@ -1909,6 +2534,8 @@ static void destroy_partition(struct mshv_partition *partition)
 		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 			drain_all_vps(partition);
 
+		remove_partition(partition);
+
 		/* Remove vps */
 		for (i = 0; i < MSHV_MAX_VPS; ++i) {
 			vp = partition->pt_vp_array[i];
@@ -1955,10 +2582,10 @@ static void destroy_partition(struct mshv_partition *partition)
 		hv_call_finalize_partition(partition->pt_id);
 
 		partition->pt_initialized = false;
+	} else {
+		remove_partition(partition);
 	}
 
-	remove_partition(partition);
-
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
 				  hnode) {
 		hlist_del_init(&region->hnode);
@@ -2051,7 +2678,7 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 		return -EFAULT;
 
 	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
-	    args.pt_isolation != MSHV_PT_ISOLATION_NONE)
+	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 		return -EINVAL;
 
 	disabled_procs = &cr_props->disabled_processor_features;
@@ -2064,7 +2691,7 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 
 		/* Re-validate v1 fields after second copy_from_user() */
 		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
-		    args.pt_isolation != MSHV_PT_ISOLATION_NONE)
+		    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 			return -EINVAL;
 
 		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
@@ -2128,6 +2755,9 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	case MSHV_PT_ISOLATION_NONE:
 		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
 		break;
+	case MSHV_PT_ISOLATION_SNP:
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
+		break;
 	}
 
 	return 0;
@@ -2163,7 +2793,6 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	mutex_init(&partition->pt_irq_lock);
 
 	init_completion(&partition->async_hypercall);
-
 	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
 
 	INIT_HLIST_HEAD(&partition->pt_devices);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index a53c0f59994a..5553d5c918a7 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -975,6 +975,7 @@ enum hv_register_name {
 	HV_REGISTER_EXPLICIT_SUSPEND				= 0x00000000,
 	HV_REGISTER_INTERCEPT_SUSPEND				= 0x00000001,
 	HV_REGISTER_DISPATCH_SUSPEND				= 0x00000003,
+	HV_REGISTER_INTERNAL_ACTIVITY_STATE			= 0x00000004,
 
 	/* Version - 128-bit result same as CPUID 0x40000002 */
 	HV_REGISTER_HYPERVISOR_VERSION				= 0x00000100,
@@ -1250,6 +1251,16 @@ union hv_arm64_pending_synthetic_exception_event {
 	} __packed;
 };
 
+union hv_internal_activity_register {
+	u64 as_uint64;
+	struct {
+		u64 startup_suspend : 1;
+		u64 halt_suspend : 1;
+		u64 idle_suspend : 1;
+		u64 rsvd_z : 61;
+	} __packed;
+};
+
 union hv_x64_interrupt_state_register {
 	u64 as_uint64;
 	struct {
@@ -1297,6 +1308,7 @@ union hv_register_value {
 	union hv_explicit_suspend_register explicit_suspend;
 	union hv_intercept_suspend_register intercept_suspend;
 	union hv_dispatch_suspend_register dispatch_suspend;
+	union hv_internal_activity_register internal_activity;
 #ifdef CONFIG_ARM64
 	union hv_arm64_interrupt_state_register interrupt_state;
 	union hv_arm64_pending_interruption_register pending_interruption;
-- 
2.43.0

