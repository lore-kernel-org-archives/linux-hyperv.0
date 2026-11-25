Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565466;
	b=K6INtqXbg/WTNHrgEl9jLzJl9RLu6sRWIuYOKe09R0ArHNzLxbFKNym1wl2aqSfGZKbp
	 LDLH0gcxJN9lIlvx4vRj6Sg2YbGVosXPP6iVfKjgIdo96c4G8zJSG1pxaiFu+qDT0ZmzE
	 6LqCBB9GspYwxdeSS9jzU9NXO+8BTeqA4vTNJnOO2NnKWrOwISgdB4yiEdppVht3EXENE
	 mc6oIQAtd5GZDoKujFuH/ILtkaGr2Glnv3vX0wEs9WrT5DEBmFq5s0jk6sdeXks3V8OeY
	 FfMiyMvTS94KIHBAh9mv6jMAUZZbL4R3dFGG/Vj2p34XB77HnS4v/4t7IWdqduda/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565466;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=fEXiIbGziMDZaIaDHSXNfhVUEKOMbotG4nCsPF9NimI=;
	b=tzD/aLSuIcQeV6DTIt4DZOTAgnpsP/cZXJQVMYdLg5g/Xb6eU9Yqsf8lzC4O60p+CONi
	 nX6feynmynY+jqXJ0gPAARgFfohAiuEtgCZg84EYgMx3erDja8M3IMEeFUTz2YA32WYKm
	 yns9zH7qDmnRRV7ovS3Jq9LHebIzS7YWz1Cwfqa5g+8V+XHbqyMN6FAiWR9LaZ3J3ME+o
	 MHutSeW3QY7gk6WO1r7l/50h9n0rOlev0EcVkILjEd8lnQM5McM/05Hsb0U4csPoksDQp
	 66yYt/qt2IpqDt0RoryiTOe2ORv/wozr+zkAZ9Cp6tVwQEm+JCGjSlaM6E1JA0GT15A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RTVXn7Zk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48C606A321;
	Wed, 25 Nov 2026 00:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E48C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RTVXn7Zk
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15CA420B7166;
	Tue, 24 Nov 2026 16:11:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15CA420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795565461;
	bh=fEXiIbGziMDZaIaDHSXNfhVUEKOMbotG4nCsPF9NimI=;
	h=From:To:Cc:Subject:Date:From;
	b=RTVXn7ZkqOZbQ3H630xkuJPXTO3FOH6Q9O8oxu3lWvwzSCXFninFtyB9BUSyPQNXY
	 QU588Pv5ZJFQhud9u9SftPeWP8bsOEal6XEglPyOI9Xy/gYfRfX2WmeBybRoZEX6c6
	 EYMwI3RwunvIL2JhMxn6wMTVFFHmxkqQy4TEd38U=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH v1] mshv: Do pre-commit before mapping a guest VM GPA
Date: Tue, 24 Nov 2026 16:10:54 -0800
Message-ID: <20261125001054.1057035-1-mrathor@linux.microsoft.com>
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

Please note, the memory requirement is same whether the follow up map
gpa calls use large page flag or not. The flags field in the  input
parameter in the pre-commit hypercall does not have any large 
page options/bits.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---

Changes in v1:
 o Don't call pre-commit from hv_do_map_gpa_hcall(), that results in
   multiple calls: first during entire NO_ACCESS map of the ram range,
   then again when the range is actually mapped. Move calls up closer 
   to where the regions are created.


 drivers/hv/mshv_regions.c      |  6 +++++
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_hv_call.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root_main.c    |  5 ++++
 include/asm-generic/mshyperv.h |  3 +++
 include/hyperv/hvgdk_mini.h    |  1 +
 include/hyperv/hvhdk.h         |  7 +++++
 7 files changed, 71 insertions(+)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index dddaade31b5d..fc091405b041 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -266,6 +266,12 @@ static int mshv_region_remap_pages(struct mshv_mem_region *region,
 int mshv_region_map(struct mshv_mem_region *region)
 {
 	u32 map_flags = region->hv_map_flags;
+	int ret;
+
+	ret = hv_pre_commit_gpa(region->partition->pt_id,
+				region->start_gfn, region->nr_pages);
+	if (ret)
+		return ret;
 
 	return mshv_region_remap_pages(region, map_flags,
 				       0, region->nr_pages);
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..bfc11f57d1d8 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -282,6 +282,7 @@ int hv_call_initialize_partition(u64 partition_id);
 int hv_call_finalize_partition(u64 partition_id);
 int hv_call_delete_partition(u64 partition_id);
 int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages);
 int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
 			  u32 flags, struct page **pages);
 int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 6261686c3638..a7168eea34d2 100644
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
+int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages)
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
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..befa2b4e3e34 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1394,6 +1394,11 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		 * the hypervisor track dirty pages, enabling pre-copy live
 		 * migration.
 		 */
+		ret = hv_pre_commit_gpa(region->partition->pt_id,
+					region->start_gfn, region->nr_pages);
+		if (ret)
+			break;
+
 		ret = hv_call_map_gpa_pages(partition->pt_id,
 					    region->start_gfn,
 					    region->nr_pages,
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

