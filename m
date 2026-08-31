Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB7280037;
	Mon, 31 Aug 2026 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175657; cv=none; b=oOgxhWFGNwb9tc1Ny4o85tHW6a8Ca6M77z4lCnQkNAU8V2HrObsMCk0Zh218lYgE4uWie9tYbDfXgv/Ggqusith5w2VKW2bvHcniTE5gdtxpp9/imag3oYH0g6sSC5b8Vr8S75LDy+XBjcUC6C9QHHiMpCUORUop5zNof7LpsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175657; c=relaxed/simple;
	bh=wuUyQ79WRSZlqXYuzIUtOu7cifRch3TKdnJMGyATOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELP31ni+p/MH72lWznuXOw6BYecpThGroRakRVUTHgXVgd9rY+XHgij/ySGx5eyTrfwnva/5Jz1KE0c/1P1onIXjhEZrUL0oQEdMQzTOG23xYhSvn3jhzr0PjCQZo/LEo5gO+LBCUP4dH/RxMnZkhNY4eU5fAvBwlAuIYsLZc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=psj2Vl6w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="psj2Vl6w"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA07320B710C;
	Mon, 31 Aug 2026 04:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA07320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788175620;
	bh=k9VSobYNvkdjDDhiAUEsNGFvAwLjD+fVNq1Nvx+Gp7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psj2Vl6wvz7alAP0uFRR06Zx8az5gfqZDt6djd9LwXkHNc96aND2CxIE5bIR8is5i
	 lAAo0EIqt6DINhFLR1DfWM33FIawkAVHItjxQxdVt9pX37LDXK5svIk7NNTYHP4CYn
	 FLDtFxb/jo2bZdtLibwuO0D1F8ls7OkgZMHn9cUw=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v4 5/9] mshv: add SEV-SNP isolated page hypercalls
Date: Mon, 31 Aug 2026 11:26:43 +0000
Message-ID: <20260831112704.2851147-6-weh@linux.microsoft.com>
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

Add wrappers for importing isolated pages, completing the import,
modifying sparse SPA host access, and setting partition properties.
Support synchronous and pending completion and batch repetition calls
within the Hyper-V input page.

Preserve the asynchronous completion result and encode its bounded
repetition count in the standard hypercall status field. Keep the
distinct, currently unused substatus out of the result bits. Return exact
bounded import progress on both success and failure, reject malformed
completion counts, and rate-limit guest-driven failures.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  12 ++++
 drivers/hv/mshv_root_hv_call.c | 110 +++++++++++++++++++++++++++++++++
 drivers/hv/mshv_synic.c        |  10 ++-
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 2150019b588c..a87d9773093c 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -389,6 +389,18 @@ void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
+				  u64 num_pages, u64 *completed_pages,
+				  enum hv_isolated_page_type page_type,
+				  enum hv_isolated_page_size page_size,
+				  void (*completion_handler)(void *data,
+							     u64 *status),
+				  void *completion_data);
+int hv_call_complete_isolated_import(u64 partition_id,
+				     union hv_partition_complete_isolated_import_data *import_data,
+				     void (*completion_handler)(void *data,
+								u64 *status),
+				     void *completion_data);
 int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
 				    u64 rsp_pfn,
 				    void (*completion_handler)(void *data,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index fca2419df397..cb5727529355 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -14,6 +14,10 @@
 
 #include "mshv_root.h"
 
+#define HV_ISOLATED_PAGE_BATCH_SIZE					       \
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_import_isolated_pages)) /  \
+	 sizeof(u64))
+
 /* Determined empirically */
 #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
 #define HV_MAP_GPA_DEPOSIT_PAGES	256
@@ -1041,6 +1045,112 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 }
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+
+int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
+				  u64 num_pages, u64 *completed_pages,
+				  enum hv_isolated_page_type page_type,
+				  enum hv_isolated_page_size page_size,
+				  void (*completion_handler)(void *data,
+							     u64 *status),
+				  void *completion_data)
+{
+	struct hv_input_import_isolated_pages *input;
+	u64 remaining = num_pages;
+	unsigned long flags;
+	u64 *gpa = pages;
+	u64 completed;
+	u64 status;
+	int rep_count;
+
+	if (!num_pages || !completed_pages)
+		return -EINVAL;
+	*completed_pages = 0;
+
+	if (!completion_handler) {
+		pr_err("%s: missing completion handler, page_type=%u\n",
+		       __func__, page_type);
+		return -EINVAL;
+	}
+
+	while (remaining) {
+		rep_count = min_t(u64, remaining,
+				  HV_ISOLATED_PAGE_BATCH_SIZE);
+
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+		input->partition_id = partition_id;
+		input->page_type = page_type;
+		input->page_size = page_size;
+		memcpy(input->page_number, gpa, rep_count * sizeof(*gpa));
+		status = hv_do_rep_hypercall(HVCALL_IMPORT_ISOLATED_PAGES,
+					     rep_count, 0, input, NULL);
+		local_irq_restore(flags);
+
+		if (hv_result(status) == HV_STATUS_CALL_PENDING)
+			completion_handler(completion_data, &status);
+
+		completed = hv_repcomp(status);
+		if (completed > rep_count) {
+			pr_err_ratelimited("%s: invalid completion count %llu/%d\n",
+					   __func__, completed, rep_count);
+			return -EPROTO;
+		}
+		*completed_pages += completed;
+
+		if (!hv_result_success(status)) {
+			pr_err_ratelimited("%s: completed %llu of %llu, %s\n",
+					   __func__, *completed_pages, num_pages,
+					   hv_result_to_string(status));
+			return hv_result_to_errno(status);
+		}
+		if (!completed)
+			return -EPROTO;
+
+		gpa += completed;
+		remaining -= completed;
+		cond_resched();
+	}
+
+	return 0;
+}
+
+int hv_call_complete_isolated_import(u64 partition_id,
+				     union hv_partition_complete_isolated_import_data *import_data,
+				     void (*completion_handler)(void *data,
+								u64 *status),
+				     void *completion_data)
+{
+	struct hv_input_complete_isolated_import *input;
+	unsigned long flags;
+	u64 status;
+
+	if (!completion_handler) {
+		pr_err("%s: missing completion handler\n", __func__);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->import_data = *import_data;
+	status = hv_do_hypercall(HVCALL_COMPLETE_ISOLATED_IMPORT, input, NULL);
+	local_irq_restore(flags);
+
+	if (hv_result(status) == HV_STATUS_CALL_PENDING)
+		completion_handler(completion_data, &status);
+
+	if (!hv_result_success(status)) {
+		pr_err_ratelimited("%s: status=%s partition_id=%llu\n",
+				   __func__, hv_result_to_string(status),
+				   partition_id);
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
 int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
 				    u64 rsp_pfn,
 				    void (*completion_handler)(void *data,
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index c77688b8d23c..0fdbae1e053c 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -159,7 +159,15 @@ static bool mshv_async_call_completion_isr(struct hv_message *msg)
 		goto unlock_out;
 	}
 
-	partition->async_hypercall_status = async_msg->status;
+	/* No current completion caller consumes the distinct substatus. */
+	(void)async_msg->sub_status;
+	partition->async_hypercall_status =
+		(u64)async_msg->status & ~HV_HYPERCALL_REP_COMP_MASK;
+	partition->async_hypercall_status |=
+		(min_t(u64, async_msg->completion_count,
+		       HV_HYPERCALL_REP_COMP_MASK >>
+		       HV_HYPERCALL_REP_COMP_OFFSET) <<
+		 HV_HYPERCALL_REP_COMP_OFFSET);
 	complete(&partition->async_hypercall);
 
 	handled = true;
-- 
2.43.0

