Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024123;
	b=xiDZlKAZsCMj7DJBqCN5DX5g11rZmDdOI+BdtM+R3O9k/JLKQHs6d0JH6NO5VZ3mKrw9
	 ZZc1Rnhupcgjj4pwKJw1Va0eZr0i6kib6ov6Ws/JqnZ9YZwJyrh2QSvBkmRn3854MK8y4
	 WLjr+AhLC5v0o4liPtdO9DNk9sRUpcU6g/s11v4hCbZz6/gbruXeRK89svO9Gmwyp2wKq
	 glfPJQ4UPAESiQPBbZrvxiJmqDIV3QZYtp9Yi636LiCGFUs+yM9kxTAm4aov6q0MPDquw
	 tP6MIxZwbVAp8309Nm6+ewaTr1tNaZ7zuE7jvHQ/ZjirSUNaBGhQGscducJNn6gA2Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024123;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=m/dNufpOXrvvMHmD6R4jBXUrm2M++eMJQnBb/8+Fz2k=;
	b=vsWY2oBBVXlAMnN3JjHJ9soKJ0PigUra87QoOAdS7FXaCgnISmIOMegqykIzOjQq08WZ
	 VYYBE5AJi/x1PzG6+TOcApdI9ssC2rjDMWn857V3iEUa3Yvnxc/1jpIBhd2vcMZmD8dzk
	 9ZFbgxv91dBiESvU+tOeDfr1eLS/JP8iwkqbG4k/gUdb513Velwn0Gt5NTEaiPXc9PuvY
	 l4rcVEwWVs6C25fxka5iWg0UqKqVIGtYwPlRep2sNtjy/6fJnrML79FvmQ86WnI0wWhoM
	 LkpFUDljMk49h8wyvrD8JJKz8O9Dv+iPG2CDATynCsEL+/+j79f4Rp4KbqW1oxmoDiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hLbNtpXw;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA63606A31D;
	Mon, 26 Oct 2026 14:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA63606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hLbNtpXw
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5DBB20B7166;
	Mon, 26 Oct 2026 07:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5DBB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024112;
	bh=m/dNufpOXrvvMHmD6R4jBXUrm2M++eMJQnBb/8+Fz2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLbNtpXwL0UbyoRHxukNo40rdBdfC5Y8Ht0QiPb6RXBY78WXxSNu+P5HUPPkwdFT4
	 FRfipmGlHzZRxmIiitCEarQP7vQNpEBY0yFbHLyXD4MNaoNJNyab4m11nkhTnUYJtC
	 so3ar2HHyKZmTVuOBg9uMDWbDUD8Vb0JA2J3HgLU=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 5/9] mshv: add SEV-SNP isolated page hypercalls
Date: Mon, 26 Oct 2026 14:14:52 +0000
Message-ID: <20261026141512.2987985-6-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026141512.2987985-1-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Add wrappers for importing isolated pages and completing an isolated
partition import. Support synchronous and pending completion and batch
repetition calls within the Hyper-V input page.

Preserve the asynchronous completion result and encode its bounded
repetition count in the standard hypercall status field. Keep the distinct,
currently unused substatus out of the result bits. Return exact bounded
import progress on both success and failure, reject malformed completion
counts, and rate-limit guest-driven failures.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  12 ++++
 drivers/hv/mshv_root_hv_call.c | 111 +++++++++++++++++++++++++++++++++
 drivers/hv/mshv_synic.c        |  10 ++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index fdee3629eb0a..78508b57b5ad 100644
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
index dd5210b47af3..3be9c1f1f157 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -14,6 +14,10 @@
 
 #include "mshv_root.h"
 
+#define HV_ISOLATED_PAGE_BATCH_SIZE					       \
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_import_isolated_pages)) /  \
+	 sizeof(u64))
+
 /* Determined empirically */
 #define HV_UMAP_GPA_PAGES		512
 
@@ -1036,6 +1040,113 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
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
+					   __func__, *completed_pages,
+					   num_pages,
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
index 92fd9fb2071a..da842c21156a 100644
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

