Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754FB23EAAF;
	Tue, 25 Aug 2026 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630738; cv=none; b=HGoautNENsptuWZNFaU7ORjHXpiPYebW3M8SV3uepP5e4G+tarRbqpmZvzmXKGN7wpPT7jkFop5Fs868w31QtDTl7vrfMDTfzjK7Mxuwf6CPkuR2pgTEy9f/ypmBu9QdesRDzqAYghYjl0FaKTxLF/0LmAeaAMW0Ga61g1Oyo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630738; c=relaxed/simple;
	bh=QpqTCbJoZIYrgVoJaY2H70rpoewM3iTmUJKugjrpMPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW+IFUP84Oj5D7NTyiReuiS1HnQrLgC4Mrd7eK3tzcJ5nAmAoxylGRk3NaggMEhSFP986EdCjDBTP2AAg5VBMdmnyzyWEP5fsnBn7/pdZWM3j3r9xHxhooqUh4qQD8+sP1Xc3vLcNhKbzjC7aBWaY0DRoXUn2yI0Sf66mwgDOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oLlAPfLq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oLlAPfLq"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CA7620B7166;
	Mon, 24 Aug 2026 21:05:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CA7620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630703;
	bh=YiGnNrocZA+RgN5w8vwDUF3IenXnMbXBNinWafZfXcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLlAPfLql5co9OiKHOASoUzWjCi4ydUTZrbtC/RKjEveLDYB+H0FJ56Z1uhoQP/6/
	 HaEahdOJ5hONGyqvQxYHgTLXN0FS/sbQ9coPwbR5hyUScgCAKNtRl5LdBSLZPkexVi
	 /106cJHgrJi0r+LF7Rv/7MnWV1HALyrevO4UtqI4=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v3 4/7] mshv: wire SEV-SNP partition ioctls
Date: Tue, 25 Aug 2026 04:04:36 +0000
Message-ID: <20260825040505.826600-5-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825040505.826600-1-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Wire the SEV-SNP partition ioctls for GPA host-access changes,
isolated-page import, PSP guest requests, AP creation, and ordered SNP
partition teardown.

Process userspace page arrays in bounded batches. The host-access ioctl
validates page-aligned guest GPAs and physical contiguity for large-page
requests; isolated import accepts guest PFNs and an explicit page size.
Translate the userspace launch-finish structure field by field into the
packed hypervisor ABI.

Keep encrypted memory regions pinned until GPA mappings are removed, the
partition reaches INSECURE_DIRTY, and host access has been restored. If
any safety-critical teardown phase fails, retain the partition and a
module reference instead of returning inaccessible pages to the host
allocator.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_regions.c      |  10 +-
 drivers/hv/mshv_root.h         |   9 +
 drivers/hv/mshv_root_hv_call.c |  47 ++-
 drivers/hv/mshv_root_main.c    | 627 ++++++++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h    |  12 +
 5 files changed, 691 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..ed93bae0fa15 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -337,7 +337,7 @@ static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
 				       page_count, flags);
 }
 
-static int mshv_region_unmap(struct mshv_mem_region *region)
+int mshv_region_unmap(struct mshv_mem_region *region)
 {
 	return mshv_region_process_range(region, 0,
 					 0, region->nr_pages,
@@ -354,17 +354,19 @@ static void mshv_region_destroy(struct kref *ref)
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		mshv_region_movable_fini(region);
 
-	if (mshv_partition_encrypted(partition)) {
+	if (mshv_partition_encrypted(partition) &&
+	    !partition->snp_host_access_restored) {
 		ret = mshv_region_share(region);
 		if (ret) {
 			pt_err(partition,
-			       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
+			       "Failed to regain access to memory, retaining pinned region: %d\n",
 			       ret);
 			return;
 		}
 	}
 
-	mshv_region_unmap(region);
+	if (!partition->snp_regions_unmapped)
+		mshv_region_unmap(region);
 
 	mshv_region_invalidate(region);
 
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 69226179cfbf..fe89c16d622e 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -139,6 +139,9 @@ struct mshv_partition {
 	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
 	u64 isolation_type;
 	bool import_completed;
+	bool snp_regions_unmapped;
+	bool snp_host_access_restored;
+	bool teardown_quarantined;
 	bool pt_initialized;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *pt_stats_dentry;
@@ -370,6 +373,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
+int mshv_region_unmap(struct mshv_mem_region *region);
 void mshv_region_invalidate(struct mshv_mem_region *region);
 int mshv_region_pin(struct mshv_mem_region *region);
 void mshv_region_put(struct mshv_mem_region *region);
@@ -378,6 +382,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void *, u64 *),
+				   void *completion_data);
+
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index ad5d5089a015..9791df06e137 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1014,6 +1014,41 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 }
 
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
+		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages,
 				  enum hv_isolated_page_type page_type,
@@ -1194,8 +1229,10 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		for (i = 0; i < rep_count; i++) {
 			u64 index = (done + i) << large_shift;
 
-			if (index >= page_struct_count)
+			if (index >= page_struct_count) {
+				local_irq_restore(irq_flags);
 				return -EINVAL;
+			}
 
 			input_page->spa_page_list[i] =
 						page_to_pfn(pages[index]);
@@ -1207,8 +1244,14 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 
 		completed = hv_repcomp(status);
 
-		if (!hv_result_success(status))
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %d + %lu of %llu pages: %s\n",
+			       __func__, done, completed, page_count,
+			       hv_result_to_string(status));
 			return hv_result_to_errno(status);
+		}
+		if (!completed || completed > rep_count)
+			return -EIO;
 
 		done += completed;
 	}
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..d946b4592d5b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -65,6 +65,7 @@ static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
 static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
 static int mshv_init_async_handler(struct mshv_partition *partition);
 static void mshv_async_hvcall_handler(void *data, u64 *status);
+static void mshv_quarantine_partition(struct mshv_partition *partition);
 
 static const union hv_input_vtl input_vtl_zero;
 static const union hv_input_vtl input_vtl_normal = {
@@ -641,6 +642,42 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
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
+			pt_err(partition, "Failed to find region for GFN %#llx\n",
+			       gfn);
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
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -1213,12 +1250,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
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
@@ -1434,6 +1466,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 
 	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
+	if (partition->pt_initialized && mshv_partition_encrypted(partition))
+		return -EBUSY;
 
 	spin_lock(&partition->pt_mem_regions_lock);
 
@@ -1648,6 +1682,409 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
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
+	if (req.vp_id >= MSHV_MAX_VPS)
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
+	struct page **pages;
+	u64 __user *guest_gpas;
+	u64 *gpfns;
+	u64 offset = 0;
+	u32 host_access = 0;
+	u32 flags = 0;
+	bool acquire;
+	long ret = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if ((args.flags & ~MSHV_GPA_HOST_ACCESS_FLAGS_MASK) ||
+	    mshv_field_nonzero(args, rsvd) || !args.page_count ||
+	    !args.guest_gpas)
+		return -EINVAL;
+	if ((args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE)) &&
+	    !IS_ALIGNED(args.page_count,
+			1ULL << (HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT)))
+		return -EINVAL;
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
+		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
+			if (!mshv_pages_are_contiguous_2m(pages, count)) {
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		ret = hv_call_modify_spa_host_access(partition->pt_id, pages,
+						     count, host_access, flags,
+					     acquire);
+		if (ret)
+			break;
+
+		offset += count;
+		cond_resched();
+	}
+
+out:
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
+	u64 *pages;
+	u64 offset = 0;
+	long ret = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.page_type >= MSHV_ISOLATED_PAGE_COUNT ||
+	    args.page_size >= MSHV_ISOLATED_PAGE_SIZE_COUNT ||
+	    mshv_field_nonzero(args, rsvd) || !args.page_count ||
+	    !args.guest_pfns)
+		return -EINVAL;
+
+	guest_pfns = u64_to_user_ptr(args.guest_pfns);
+	pages = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*pages),
+			       GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	while (offset < args.page_count) {
+		u64 count = min_t(u64, args.page_count - offset,
+				  MSHV_USER_PAGE_BATCH_SIZE);
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
+						1ULL << (HV_HYP_LARGE_PAGE_SHIFT -
+							HV_HYP_PAGE_SHIFT))) {
+					ret = -EINVAL;
+					goto import_out;
+				}
+			}
+		}
+
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			break;
+
+		ret = hv_call_import_isolated_pages(partition->pt_id, pages, count,
+						    args.page_type, args.page_size,
+						    mshv_async_hvcall_handler,
+						    partition);
+		if (ret)
+			break;
+
+		offset += count;
+		cond_resched();
+	}
+
+import_out:
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
+	u64 gpfns[2];
+	long ret;
+
+	if (copy_from_user(&req, user_args, sizeof(req)))
+		return -EFAULT;
+
+	gpfns[0] = HVPFN_DOWN(req.req_gpa);
+	gpfns[1] = HVPFN_DOWN(req.rsp_gpa);
+
+	ret = mshv_gpfns_to_pages(partition, gpfns, ARRAY_SIZE(gpfns), pages);
+	if (ret)
+		return ret;
+
+	ret = hv_call_modify_spa_host_access(partition->pt_id, pages,
+					     ARRAY_SIZE(pages), 0, 0, false);
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
+						     host_access, 0, true);
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
@@ -1684,6 +2121,15 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
@@ -1795,6 +2241,79 @@ remove_partition(struct mshv_partition *partition)
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
+static void mshv_quarantine_partition(struct mshv_partition *partition)
+{
+	if (partition->teardown_quarantined)
+		return;
+
+	/* Keep module text and the pinned inaccessible pages alive. */
+	__module_get(THIS_MODULE);
+	partition->teardown_quarantined = true;
+}
+
 /*
  * Tear down a partition and remove it from the list.
  * Partition's refcount must be 0
@@ -1805,6 +2324,9 @@ static void destroy_partition(struct mshv_partition *partition)
 	struct mshv_mem_region *region;
 	struct hlist_node *n;
 	int i;
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	int ret;
+#endif
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1814,7 +2336,87 @@ static void destroy_partition(struct mshv_partition *partition)
 
 	trace_mshv_destroy_partition(partition->pt_id);
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	if (!partition->pt_initialized && mshv_partition_encrypted(partition)) {
+		int region_ret;
+
+		ret = 0;
+		hlist_for_each_entry_safe(region, n,
+					  &partition->pt_mem_regions, hnode) {
+			region_ret = mshv_region_share(region);
+			if (region_ret) {
+				pt_err(partition,
+				       "Failed to restore host access at GFN %#llx: %d\n",
+				       region->start_gfn, region_ret);
+				ret = region_ret;
+			}
+		}
+		if (ret) {
+			pt_err(partition,
+			       "Retaining uninitialized partition with inaccessible SNP pages\n");
+			mshv_quarantine_partition(partition);
+			return;
+		}
+		partition->snp_host_access_restored = true;
+	}
+#endif
+
 	if (partition->pt_initialized) {
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+		if (mshv_partition_encrypted(partition)) {
+			int region_ret;
+
+			ret = 0;
+			hlist_for_each_entry_safe(region, n,
+						  &partition->pt_mem_regions,
+						  hnode) {
+				region_ret = mshv_region_unmap(region);
+				if (region_ret) {
+					pt_err(partition,
+					       "Failed to unmap SNP region at GFN %#llx: %d\n",
+					       region->start_gfn, region_ret);
+					ret = region_ret;
+				}
+			}
+			if (ret) {
+				pt_err(partition,
+				       "Retaining partition after SNP region unmap failure\n");
+				mshv_quarantine_partition(partition);
+				return;
+			}
+
+			ret = destroy_snp_partition_state(partition);
+			if (ret) {
+				pt_err(partition,
+				       "Failed to destroy SNP state: %d; retaining partition\n",
+				       ret);
+				mshv_quarantine_partition(partition);
+				return;
+			}
+
+			ret = 0;
+			hlist_for_each_entry_safe(region, n,
+						  &partition->pt_mem_regions,
+						  hnode) {
+				region_ret = mshv_region_share(region);
+				if (region_ret) {
+					pt_err(partition,
+					       "Failed to restore host access at GFN %#llx: %d\n",
+					       region->start_gfn, region_ret);
+					ret = region_ret;
+				}
+			}
+			if (ret) {
+				pt_err(partition,
+				       "Retaining partition with inaccessible SNP pages\n");
+				mshv_quarantine_partition(partition);
+				return;
+			}
+
+			partition->snp_regions_unmapped = true;
+			partition->snp_host_access_restored = true;
+		}
+#endif
 		/*
 		 * We only need to drain signals for root scheduler. This should be
 		 * done before removing the partition from the partition list.
@@ -1822,6 +2424,8 @@ static void destroy_partition(struct mshv_partition *partition)
 		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 			drain_all_vps(partition);
 
+		remove_partition(partition);
+
 		/* Remove vps */
 		for (i = 0; i < MSHV_MAX_VPS; ++i) {
 			vp = partition->pt_vp_array[i];
@@ -1868,10 +2472,10 @@ static void destroy_partition(struct mshv_partition *partition)
 		hv_call_finalize_partition(partition->pt_id);
 
 		partition->pt_initialized = false;
+	} else {
+		remove_partition(partition);
 	}
 
-	remove_partition(partition);
-
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
 				  hnode) {
 		hlist_del(&region->hnode);
@@ -1883,6 +2487,8 @@ static void destroy_partition(struct mshv_partition *partition)
 	hv_call_delete_partition(partition->pt_id);
 
 	mshv_free_routing_table(partition);
+	if (partition->teardown_quarantined)
+		module_put(THIS_MODULE);
 	kfree(partition);
 }
 
@@ -2039,6 +2645,9 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	case MSHV_PT_ISOLATION_NONE:
 		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
 		break;
+	case MSHV_PT_ISOLATION_SNP:
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
+		break;
 	}
 
 	return 0;
@@ -2074,6 +2683,8 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	mutex_init(&partition->pt_irq_lock);
 
 	init_completion(&partition->async_hypercall);
+	INIT_DELAYED_WORK(&partition->destroy_work,
+			  mshv_partition_destroy_work);
 
 	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
 
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

