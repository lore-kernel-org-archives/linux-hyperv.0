Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7A326927;
	Tue, 25 Aug 2026 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630732; cv=none; b=CCDsjdcMEZ+0o/AfoTiTDjV1GxEj2X1eM2G8nJpTz1MP57MUb8c+IPfgG9jwcK8eDfcx5pbVt2ZusrO8sqNJMx1DY9+YUxzUVlqyeZ9yMiV4qllHGqf+HXOYvhGBoQN5IpNBUwzHdsIuGROKt4WJY7Az/lHCnPcGFTpcKf+C+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630732; c=relaxed/simple;
	bh=iKqVv0p0uo0B0sy7SjNsR5Vc9Xkk8PbYKT/DjVZMfEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4b1lqX5CilK6xOeD/WPSNiK6bsRmhYzXI0nc1M/s0d0R40UrZwNfIcEBXkpFYWnrYTEVptskDIWGJ/sM5AZwvycsBiluGWjOfQP6CjtlK/IviHpKMAqhPY3ls7OR2Q04VjOhSREsjKPPSCLzi1LsHRNMRRybZ4O9QC7L37Ijm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dnZ/Oa54; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dnZ/Oa54"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B39A20B7166;
	Mon, 24 Aug 2026 21:04:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B39A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630698;
	bh=0fEKjaM6FSKDsUTik+kZyKA3MYArX8XE3wGi3dBVV0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnZ/Oa54wzAo1ZqNX/62xCYpqbyhYU3SegJlTDWwdeEBOsvJyJfp5yby8zQGCJT+K
	 mgnN+wgLwX6EXDX0bHWI4J6Hd6kvfn+X9xSD+kz9jlcr3mjleZy2+tPsXVGO0sBQL0
	 8an7mplyR8s5q9G57btHWy0ZuQn4ZW4wCVkIHqxk=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v3 3/7] mshv: add SEV-SNP isolated page hypercalls
Date: Tue, 25 Aug 2026 04:04:35 +0000
Message-ID: <20260825040505.826600-4-weh@linux.microsoft.com>
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

Add helpers for importing isolated pages and completing isolated
imports. These operations can complete asynchronously, so preserve the
rep completion count from the initial pending status unless the final
completion supplies a replacement.

Reject zero or oversized progress, report partial progress on failure,
and yield between successful batches so a large userspace request cannot
monopolize a CPU.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  12 ++++
 drivers/hv/mshv_root_hv_call.c | 104 +++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 8abb080938fd..69226179cfbf 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -379,6 +379,18 @@ void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
+				  u64 num_pages,
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
index 48abe338c06f..ad5d5089a015 100644
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
@@ -1010,6 +1014,106 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 }
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
+				  u64 num_pages,
+				  enum hv_isolated_page_type page_type,
+				  enum hv_isolated_page_size page_size,
+				  void (*completion_handler)(void *data,
+							     u64 *status),
+				  void *completion_data)
+{
+	struct hv_input_import_isolated_pages *input;
+	unsigned long remaining = num_pages;
+	unsigned long flags;
+	u64 *gpa = pages;
+	u64 completed;
+	u64 status;
+	int rep_count;
+
+	if (!num_pages)
+		return -EINVAL;
+
+	if (!completion_handler) {
+		pr_err("%s: missing completion handler, page_type=%u\n",
+		       __func__, page_type);
+		return -EINVAL;
+	}
+
+	while (remaining) {
+		rep_count = min_t(unsigned long, remaining,
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
+		completed = hv_repcomp(status);
+		if (hv_result(status) == HV_STATUS_CALL_PENDING) {
+			completion_handler(completion_data, &status);
+			if (hv_repcomp(status))
+				completed = hv_repcomp(status);
+		}
+
+		if (!hv_result_success(status)) {
+			pr_err("%s: completed %llu of %llu, %s\n", __func__,
+			       num_pages - remaining +
+			       min_t(u64, completed, rep_count), num_pages,
+			       hv_result_to_string(status));
+			return hv_result_to_errno(status);
+		}
+		if (!completed || completed > rep_count)
+			return -EIO;
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
+		pr_err("%s: status=%s partition_id=%llu\n", __func__,
+		       hv_result_to_string(status), partition_id);
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
 int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
 				    u64 rsp_pfn,
 				    void (*completion_handler)(void *data,
-- 
2.43.0

