Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019725;
	b=rhLPbKSSCZfzmT6XUolw6YgBKpI1j9EnWGwlukIAc0WDtQhTx9VtrhUmCrl/qB4LOnYg
	 YondDP5edGKsWHwmBbwvnXVxEZhRJ/937tg9K4JhD05BPYxS5guRH+ikTa85DoZxQ97Oa
	 XvFf0jbbGO8W6vM/aGWngYtZRv8jyiBxOyBtkCQng1KBEnBerJN1vZH2fiia1xTE9wBtn
	 j4EJ82ainqsnlUI7+ihah9UkCl6CKrmetn8WvbSr83eiEJzfCwhbj5TlNzdPKeIy1l26V
	 0c2eV6tE0wYXgCQOXucjYVJsLSysO46TJDEaa4l8no6fokaLwwPESop2l+1Gw1aYdsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019725;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=fBwqy9R61SqvFjj6f4NiY/zITihotHz0FIoS201eK7I=;
	b=EjV6y2YLJakpOgU9olb1yah4jsIwCrwKTQLnsWEGLW3HSM1UlDC+GTVhRE9ZGgF9Y5NU
	 hRMvGr8LnOfg0cr1hpAHyV6nQmw0OL9Sd9ZKxdh3JSdAhf1wxigdxZRhtXmO0uWTVWVyR
	 DJ11nfqDqIx4HevXxX2EsM8pBOT5ZWm45UxjZQQkCdn5YvjUsVGYjJy0hUodG2qrGfGdS
	 FOEMofZ9FRSPl6S+Fc6hGNcY+PLYJRrqjfeKfqiKf1wvoI/w/yry2ruT7RZ3B6jXM+KB7
	 7BwI9Ecf2lpbM0uTfi/o2b6UD+Fl4BkqVaq2u3AqdhtyYxhamzlqz8VXLz562wwSx+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hrTbHXNt;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54C606A32E;
	Sat,  7 Nov 2026 02:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B54C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hrTbHXNt
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D322120B7168;
	Fri,  6 Nov 2026 18:48:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D322120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794019724;
	bh=fBwqy9R61SqvFjj6f4NiY/zITihotHz0FIoS201eK7I=;
	h=From:To:Cc:Subject:Date:From;
	b=hrTbHXNt9ndcF1CGr7damsN1KsIduTRZhj3fqmoi8zjdcLh678dPeENCZgnCjN/WX
	 XmgOvhSKhnlPCHPetwiJ1bxgIj82cofwDfM5U8640LWsxTyDX6r231VZjiTXGwnsPW
	 UPCE0RrEL0nl460CV8kOFmC0mX0LXIHhdiQrTfyo=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH] mshv: Do pre-commit before mapping a guest VM GPA
Date: Fri,  6 Nov 2026 18:48:42 -0800
Message-ID: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
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

Pre commit reduces TLB flush overheads in the hypervisor. On systems
with large number of CPUs, there is signficant advantage to doing
this. Pre-commit allows the hypervisor to build all data structs needed
in anticipation of the map gpa hypercall, thus reducing or eliminating
deposit page returns from the map gpa hypercall, and as a result reducing
TLB flushes. In some performance benchmarks, it made the maps of large
ranges almost 30% faster.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c | 52 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  3 ++
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk.h         |  7 +++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index bf0f90515dad..5c44ba8f72b0 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -181,6 +181,54 @@ int hv_call_delete_partition(u64 partition_id)
 	return hv_result_to_errno(status);
 }
 
+/*
+ * Pre commit to reduce TLB flush overheads in the hypervisor. On systems with
+ * large CPUs, there is signficant advantage to doing this. Pre-commit allows
+ * the hypervisor to build all data structs needed in anticipation of the map
+ * gpa hypercall, thus reducing or eliminating deposit page returns from the
+ * map gpa hypercall, and as a result reducing TLB flushes.
+ */
+static int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages)
+{
+	ulong irq_flags;
+	struct hv_input_precommit_gpa_pages *input_page;
+	int rc = 0;
+	u64 status, done = 0;
+
+	while (done < num_pages) {
+		u16 rep_count = min(num_pages - done, HV_REP_COUNT_MAX);
+
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input_page, 0, sizeof(*input_page));
+
+		input_page->partition_id = pt_id;
+		input_page->target_gpa_base = gfn;
+
+		status = hv_do_rep_hypercall(HVCALL_PRECOMMIT_GPA_PAGES,
+					     rep_count, 0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		done += hv_repcomp(status);
+		gfn += hv_repcomp(status);
+
+		if (hv_result_needs_memory(status)) {
+			rc = hv_deposit_memory(pt_id, status);
+			if (rc)
+				break;
+
+		} else if (!hv_result_success(status)) {
+			pr_err("%s: failed to pre commit for gfn %#llx done %llu/%llu, status=%#llx (%s)\n",
+			       __func__, gfn, done, num_pages, status,
+			       hv_result_to_string(hv_result(status)));
+			rc = hv_result_to_errno(status);
+			break;
+		}
+	}
+
+	return rc;
+}
+
 /* Ask the hypervisor to map guest ram pages or the guest mmio space */
 static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 			       u32 flags, struct page **pages, u64 mmio_spa)
@@ -205,6 +253,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		page_count >>= large_shift;
 	}
 
+	ret = hv_pre_commit_gpa(partition_id, gfn, page_struct_count);
+	if (ret)
+		return ret;
+
 	while (done < page_count) {
 		ulong i, completed, remain = page_count - done;
 		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4c9f3353074a..a3d497d99b0b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -28,6 +28,9 @@
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
+#define HV_REP_COUNT_MAX        \
+	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
+
 enum hv_partition_type {
 	HV_PARTITION_TYPE_GUEST,
 	HV_PARTITION_TYPE_ROOT,
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 966945f0504f..16c41ee5079a 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -489,6 +489,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
 #define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
 #define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
+#define HVCALL_PRECOMMIT_GPA_PAGES			0x00be
 #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
 #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
 #define HVCALL_DISPATCH_VP				0x00c2
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 0c89c62c9706..3944e51d0a2d 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -953,4 +953,11 @@ struct hv_input_modify_sparse_spa_page_host_access {
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
 #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
 
+struct hv_input_precommit_gpa_pages {	/* HV_INPUT_PRECOMMIT_GPA_PAGES */
+	u64 partition_id;
+	u32 flags;
+	u32 reserved;
+	u64 target_gpa_base;
+} __packed;
+
 #endif /* _HV_HVHDK_H */
-- 
2.51.2.vfs.0.1

