Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2B390CAB;
	Fri,  7 Aug 2026 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110740; cv=none; b=Szdw5T0uTPeneoIt38VnEWmeCu4aMGeYqApErTfi/IOG7JI6UtyzEqNtVJE8K7pzeAuEG2iuouj8fA0tUVGeDve8xCJJ0LIK9FTZqyMwuXicT71nGWOZyN8IJpcnagDM5bhgjqeutXvJDao5Ekw3GlgR0QnXl4mU/ntav91WNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110740; c=relaxed/simple;
	bh=AkRtvNfqDN25zpzA66wfTCxidgaaQvO7kCQuVcRnQuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5W1gBtynvTW4bVHrmcEdIJduru+DH8ju174NHSajsqPpJ2SKoW+AkLIwtl6f8qVfL0SQG+D0CwXyLpuaXlGWodEivxbz45gxS45g9q1rIPSUNEKip/ap4KCoPi+9cAglsVByKgXrSivXkhe5Eh5W9q0phPT2slS2Eu5tIoNc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tgfj0ccD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tgfj0ccD"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9BECE20B7128;
	Fri,  7 Aug 2026 06:51:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BECE20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110711;
	bh=+ZxppWj+D2qJCVf56Tq5wobMw+LToWlowhPQBU7FhPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tgfj0ccDY+GPikXE2nPXvxTtC4ukEI7KJTzeiBWt4WOVzKvnXCECylWD016oId5hm
	 hDOBsbK/3elsxO5dIbcFN6HfhwJBS8Q9YKlSbgTp06MJxc60X0AnlJ78OudD5zyEcu
	 2rMQp3skBsumEFEFrz0q/caDvGLTUhq/pXJvVPOg=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 04/13] mshv: wire SEV-SNP partition ioctls
Date: Fri,  7 Aug 2026 13:51:10 +0000
Message-ID: <20260807135134.303943-5-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Wire the SEV-SNP partition ioctls for GPA host-access changes,
isolated-page import, PSP guest requests, AP creation, and SNP partition
teardown.

The GPA host-access ioctl converts the guest addresses to GFNs before
issuing the hypercall. The PSP guest-request path restores host access
to the request/response pages if the hypercall fails, so a failed request
does not leave guest pages inaccessible to the host.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |   5 +
 drivers/hv/mshv_root_hv_call.c |  35 +++
 drivers/hv/mshv_root_main.c    | 391 +++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h    |  12 +
 4 files changed, 443 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 69226179cfbf..0e6d4ce25112 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -378,6 +378,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
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
index 9ddc8dd73da7..bf5636a9ef6a 100644
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
+	if (unlikely(status == HV_STATUS_CALL_PENDING))
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
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 146726cc4e9b..3590a8ea24b5 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -115,6 +115,9 @@ static u16 mshv_passthru_hvcalls[] = {
 	HVCALL_GET_PARTITION_PROPERTY,
 	HVCALL_GET_PARTITION_PROPERTY_EX,
 	HVCALL_SET_PARTITION_PROPERTY,
+	HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST,
+	HVCALL_COMPLETE_ISOLATED_IMPORT,
+	HVCALL_IMPORT_ISOLATED_PAGES,
 	HVCALL_INSTALL_INTERCEPT,
 	HVCALL_GET_VP_REGISTERS,
 	HVCALL_SET_VP_REGISTERS,
@@ -142,6 +145,8 @@ static bool mshv_hvcall_is_async(u16 code)
 {
 	switch (code) {
 	case HVCALL_SET_PARTITION_PROPERTY:
+	case HVCALL_IMPORT_ISOLATED_PAGES:
+	case HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST:
 		return true;
 	default:
 		break;
@@ -641,6 +646,42 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
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
@@ -1625,6 +1666,260 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
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
+static long
+mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *partition,
+					    void __user *user_args)
+{
+	struct mshv_modify_gpa_host_access args;
+	struct page **pages;
+	u64 *gpfns;
+	u64 i;
+	u32 host_access = 0;
+	u32 flags = 0;
+	bool acquire;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if ((args.flags & ~MSHV_GPA_HOST_ACCESS_FLAGS_MASK) ||
+	    mshv_field_nonzero(args, rsvd) || !args.page_count)
+		return -EINVAL;
+
+	gpfns = vmemdup_user((char __user *)user_args +
+			     offsetof(struct mshv_modify_gpa_host_access,
+				      guest_pfns),
+			     size_mul(sizeof(*gpfns), args.page_count));
+	if (IS_ERR(gpfns))
+		return PTR_ERR(gpfns);
+
+	pages = kcalloc(args.page_count, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto free_gpfns;
+	}
+
+	for (i = 0; i < args.page_count; i++)
+		gpfns[i] = HVPFN_DOWN(gpfns[i]);
+
+	ret = mshv_gpfns_to_pages(partition, gpfns, args.page_count, pages);
+	if (ret)
+		goto free_pages;
+
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_READABLE))
+		host_access |= HV_MAP_GPA_READABLE;
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_WRITABLE))
+		host_access |= HV_MAP_GPA_WRITABLE;
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE))
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+	acquire = args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_ACQUIRE);
+
+	ret = hv_call_modify_spa_host_access(partition->pt_id, pages,
+					     args.page_count, host_access,
+					     flags, acquire);
+
+free_pages:
+	kfree(pages);
+free_gpfns:
+	kvfree(gpfns);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partition,
+					   void __user *user_args)
+{
+	struct mshv_import_isolated_pages args;
+	u64 *pages;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.page_type >= MSHV_ISOLATED_PAGE_COUNT ||
+	    mshv_field_nonzero(args, rsvd) || !args.page_count)
+		return -EINVAL;
+
+	pages = vmemdup_user((char __user *)user_args +
+			     offsetof(struct mshv_import_isolated_pages,
+				      guest_pfns),
+			     size_mul(sizeof(*pages), args.page_count));
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		goto out;
+
+	ret = hv_call_import_isolated_pages(partition->pt_id, pages,
+					    args.page_count, args.page_type,
+					    HV_ISOLATED_PAGE_SIZE_4KB,
+					    mshv_async_hvcall_handler,
+					    partition);
+
+out:
+	kvfree(pages);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_complete_isolated_import(struct mshv_partition *partition,
+					      void __user *user_args)
+{
+	struct mshv_complete_isolated_import *args;
+	long ret;
+
+	args = memdup_user(user_args, sizeof(*args));
+	if (IS_ERR(args))
+		return PTR_ERR(args);
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		goto out;
+
+	ret = hv_call_complete_isolated_import(partition->pt_id,
+					       &args->import_data,
+					       mshv_async_hvcall_handler,
+					       partition);
+	if (!ret)
+		partition->import_completed = true;
+
+out:
+	kfree(args);
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
+		return ret;
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
+	hv_call_modify_spa_host_access(partition->pt_id, pages,
+				       ARRAY_SIZE(pages), host_access, 0, true);
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
@@ -1661,6 +1956,15 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
@@ -1772,6 +2076,69 @@ remove_partition(struct mshv_partition *partition)
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
 /*
  * Tear down a partition and remove it from the list.
  * Partition's refcount must be 0
@@ -1782,6 +2149,9 @@ static void destroy_partition(struct mshv_partition *partition)
 	struct mshv_mem_region *region;
 	struct hlist_node *n;
 	int i;
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	int ret;
+#endif
 
 	if (refcount_read(&partition->pt_ref_count)) {
 		pt_err(partition,
@@ -1792,6 +2162,24 @@ static void destroy_partition(struct mshv_partition *partition)
 	trace_mshv_destroy_partition(partition->pt_id);
 
 	if (partition->pt_initialized) {
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+		if (mshv_partition_encrypted(partition)) {
+			hlist_for_each_entry_safe(region, n,
+						  &partition->pt_mem_regions,
+						  hnode) {
+				hlist_del(&region->hnode);
+				mshv_region_put(region);
+			}
+
+			ret = destroy_snp_partition_state(partition);
+			if (ret) {
+				pt_err(partition,
+				       "Failed to destroy SNP state: %d\n",
+				       ret);
+				return;
+			}
+		}
+#endif
 		/*
 		 * We only need to drain signals for root scheduler. This should be
 		 * done before removing the partition from the partition list.
@@ -2016,6 +2404,9 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	case MSHV_PT_ISOLATION_NONE:
 		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
 		break;
+	case MSHV_PT_ISOLATION_SNP:
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
+		break;
 	}
 
 	return 0;
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

