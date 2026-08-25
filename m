Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75031212542;
	Tue, 25 Aug 2026 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630725; cv=none; b=CCKUehV04GiiVvjMqUe0yKDcxIyK9Ju843rFVaH186O6wU5Zk9yF8TQsCTZfUDP6t+AZu4guWIy2snIuGAJaf/4E3IyRv+Gll7DqVK24bTD90kLdxFkHRTfXQH+5VM40HnTqFQQ3tFnA5U8m+hkZo0A3plKW9PpCoimAzmCLkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630725; c=relaxed/simple;
	bh=Kaa17ZKcRoUM+YHwZX7T6vI3U3w+TtSlvEKxfdVDOT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8CGcJqLJmLwwVqvNr85kGUCilrYz6/g3VBPZPieqklDV8PLJ8zq3MqCYjTQqNMMGUtXQvBd2/tP7RTtPQroiGnBHhk+ojJA2G6aHJ4AES9LuDXcqVR2/43Kn+S4DwxbJHrwdrU+go6cb52CGC2VvP8bPv3kfdBM5/+kGo+pvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eOkhwLdD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eOkhwLdD"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3694D20B6F08;
	Mon, 24 Aug 2026 21:04:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3694D20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630692;
	bh=IUvwZ3gZVRK1me3rw3VS6tnTMH+w3KbspdoFS9VeDfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOkhwLdDO4BsYkICaGCBvdZyrVqI70RWNrQLUrLk9b+KCCZIApOsIvus51ndGxoX/
	 J5Th61XA6fW5Ioli9RTQMhXJaltSwwAb0TO84tDm5Tj8e5JCLGb/lsAEvhq+nAK77p
	 EfcRUXWRHrsnpmSCyGfXte35XtwM3IX791215jKo=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v3 2/7] mshv: add SEV-SNP PSP request hypercall
Date: Tue, 25 Aug 2026 04:04:34 +0000
Message-ID: <20260825040505.826600-3-weh@linux.microsoft.com>
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

Add a helper for HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST so MSHV can issue
asynchronous PSP guest requests on behalf of encrypted partitions.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  8 +++++++
 drivers/hv/mshv_root_hv_call.c | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..8abb080938fd 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -378,4 +378,12 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
+				    u64 rsp_pfn,
+				    void (*completion_handler)(void *data,
+							       u64 *status),
+				    void *completion_data);
+#endif
+
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..48abe338c06f 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1009,6 +1009,45 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 	return ret;
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
+				    u64 rsp_pfn,
+				    void (*completion_handler)(void *data,
+							       u64 *status),
+				    void *completion_data)
+{
+	struct hv_input_issue_psp_guest_request *input;
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
+	input->request_page = req_pfn;
+	input->response_page = rsp_pfn;
+	status = hv_do_hypercall(HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST, input,
+				 NULL);
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
+#endif
+
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
 				   u32 flags, u8 acquire)
-- 
2.43.0

