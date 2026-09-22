Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551A3D3CE2;
	Tue, 22 Sep 2026 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050253; cv=none; b=DufuVs7u9DvvWLBuzlFnLMca0jNrl3154Mgb9dt0ivcEWW2UL1Wlo5NArlk9jveDZ1OpZFLJPM1sa1X+PQN+ZEHz2n5/9y4gHnMsGLFYokub1S07YaPGIshL77975gUzXlpZVy4ZlO0O4S+7/glRyFHlb07OMRIzWEMIwJpmUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050253; c=relaxed/simple;
	bh=a1xZzLn3zdkjjhgieqg7txyjVX2v4LU2ITbeQa3SADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9T32xw7bpPWHerVlvw06i3zRiRGyIhXJFulGunqWfWoTBJ49DL/YMzDY25PQMxlYsxf58lpMgg1eKpTg9Whmv2pDNkTPSjyB6HJ4kD1phkP5yawYewVN925ZsrZ93S2eU6+OU8TF/zVzdz7PDfNw54a8RgNIuYeneJ5GcRdvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o0SAp2LK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o0SAp2LK"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C896320B7168;
	Mon, 21 Sep 2026 21:10:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C896320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790050204;
	bh=FFvNQUMvFxVtQSReNycbADifhq8DUGSqWOOlfKSkobQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0SAp2LKSz1y/E9o60nnKktBQAS/F0snJvOAD8qtgupxgYcTjp512Wad7zd/U1tnN
	 gZQ3VE8NnCotJObUgNHaQBTR1dhf2wxDJBObLQv/yEKw/8cWnepcChZEyiotrZRF7l
	 XbzE9NpbtyVAMFS6AMcr9PDWnKI4VFdk+XCA5jqU=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v7 4/9] mshv: add SEV-SNP PSP request hypercall
Date: Tue, 22 Sep 2026 04:10:21 +0000
Message-ID: <20260922041043.171543-5-weh@linux.microsoft.com>
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
index 1fa644e0e437..fca2419df397 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1040,6 +1040,47 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
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

