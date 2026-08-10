Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4A73DAACF;
	Mon, 10 Aug 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365980; cv=none; b=QAie9Y1H6Oay6tTTgwxDyKOtvm/iv6wLBecTDTeX6YjAtxMatccXJoJbSitOAdwbacDp23NpDbZRCAFDsUKrHzFxGlxlCEsaCLDoxNdpk6AdxajfREJGCrLghnMlrs45+qLykip8t6TWQoA43YRV7X09m4AAcDwadmRmZ5nTtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365980; c=relaxed/simple;
	bh=g7FxBRxuMIutHFn3n9/nWLsbe4v4NWFt4RirF6L2+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkeI30CYl588Bf+ZBYYtEhp6MH/4WSlpy7gi8D+Q1izE9uy0qzJyj4KpLJ2d600iv8lhGA2IlJ/UDo9F5OgRkb/6wwb22uCYhLcofwMQQhgbdkuDy4LCKiJAUNlrYQulXdBsqsNF2DigWlWXgur8D8HXdG7ElWafUUQ+Dv/b3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OiwhLiMf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OiwhLiMf"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6489520B7166;
	Mon, 10 Aug 2026 05:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6489520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365955;
	bh=OP8H0VNUJo+d1sEMSZm6tGGfQq//RorRcZBtjabtsEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiwhLiMfCiywB9t3NP6W5S5/Fs5OBYdwQEG2cv+XQlLNo+A+00vkOO9ydkWm+/AkC
	 M5g6edkmAs7MwhItpcITK3b9YWW1Q6d4fnOw72VWNpXE0TftlsnlJB3vwkKMwfiCdv
	 MYlQIlg+UuDgs4NjjASYTvOgI+vh6XHdexDKp+6c=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 03/13] mshv: add SEV-SNP isolated page hypercalls
Date: Mon, 10 Aug 2026 12:44:57 +0000
Message-ID: <20260810124527.1409634-4-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810124527.1409634-1-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Add helpers for importing isolated pages and completing isolated
imports.  These are used by SEV-SNP guest launch flows to transfer
isolated page state to the hypervisor.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  12 ++++
 drivers/hv/mshv_root_hv_call.c | 102 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

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
index 48abe338c06f..4e48c1a9a630 100644
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
@@ -1010,6 +1014,104 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
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
+			       num_pages - remaining, num_pages,
+			       hv_result_to_string(status));
+			return hv_result_to_errno(status);
+		}
+		if (!completed || completed > remaining)
+			return -EIO;
+
+		gpa += completed;
+		remaining -= completed;
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

