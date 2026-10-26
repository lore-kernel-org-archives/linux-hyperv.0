Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024122;
	b=Qzf5IdEkPmge5kWZzYZiNWJcTmaStGxCqtqyN54iIkmmEHM9lsxNRd77l8qB/kd17UFK
	 DTlAE+74zEgdD5biHcg+4DEwcLuUwkDcPeZ+QzWGJCjulF/10BZzEfOsBFhBlhkc5lMxe
	 BnfeEgGF6TBOPCEP7UH9A9Uv2KFpT/QEAJfiKkIHh/IsF7burJq1vcoNcwCrxrWXU9oDl
	 cN/8kzEjM1hYTS5sbuiqgMxRoefpzNcacX577IdFoOiJ4Y7JdXn/IzwiXyBPQz7P1wXSz
	 XJM8I0I4hFP9DhLSN+WkHu2Qz2Z9D2kdLlmUJW3Z8cRJEG5UP4f3yN3ZIxB3koPN8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024122;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=cbAPZdTBwToTFg0lJLzNrPTBkWdQsKChzuO4J4KvIxQ=;
	b=MBEIvD4LlykQz7UM8u3woR6G7trGytkuD1X95PmVK9crC7GTtmc5gR995qebTV6H0FWg
	 k+1iIqgFCPBnkkZ7GoOUuupBfpLC2uYBLlVu3NVvrx39h++HjX3TMNKUxCfMNCSTLLcNl
	 4IhE7eohVr+o+TRacoaptH07EXx7reNY9XBTAY+eey218FHNYZfUVF2HPkIlP4IASfiWH
	 vOLAaf5sBi8dZbW3O7dFpojLC3NYdEqy5cQZrmolNAnu85ZkkB8Svj1/4lzl/xlO5UqKB
	 9/N0MEg6x3GFeOiA4GnAjaeIbK/79USQEeueMo1yTYZV2AeDocKPqL2CUOWtC1FeEDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NflEvnQu;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AF606A31A;
	Mon, 26 Oct 2026 14:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A41AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NflEvnQu
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id ABFB220B7169;
	Mon, 26 Oct 2026 07:15:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABFB220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024111;
	bh=cbAPZdTBwToTFg0lJLzNrPTBkWdQsKChzuO4J4KvIxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NflEvnQuBW3QPadmASjFv6hoPT6PcX6P8w8K/ZI9HCaZO16XK6yf3Itq/+xOHZZlc
	 iiOmJ7ppn7CmuEh1NT64gZdDsWQC73JkJa0p0trLXRAXU+ns5CmcSi+DcgVRecPLUB
	 05wvRj4SnXmfHDfK3a65rm7NQHW7qM8LneqzVmFk=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 4/9] mshv: add SEV-SNP PSP request hypercall
Date: Mon, 26 Oct 2026 14:14:51 +0000
Message-ID: <20261026141512.2987985-5-weh@linux.microsoft.com>
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

Add a helper for HVCALL_ISSUE_SNP_PSP_GUEST_REQUEST so MSHV can issue
asynchronous PSP guest requests on behalf of encrypted partitions.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root.h         |  8 +++++++
 drivers/hv/mshv_root_hv_call.c | 41 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index d0770d36defb..fdee3629eb0a 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -388,4 +388,12 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
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
index c8142865f9bb..dd5210b47af3 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1035,6 +1035,47 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
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
+	/* Hyper-V consumes the input before returning CALL_PENDING. */
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
+#endif
+
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 				   u64 page_struct_count, u32 host_access,
 				   u32 flags, u8 acquire)
-- 
2.43.0

