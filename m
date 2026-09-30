Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9A4BD780;
	Wed, 30 Sep 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770256; cv=none; b=KpgQUYgGeUTXXKeB4nokVbKu+pJXZ5qiwwZewDYB7HZD9FeHKY0m45LVP0581ZGiWdxAL+hl9Hl7o/qhhTheSvnM97qMuHeUsEZxd2oRXKUtPfarBXgEJv4kf5v24vOr/IPKgw59msaNUhAM/RKcsB2Sl7+wIvI4L1yeeouqQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770256; c=relaxed/simple;
	bh=G7QjSA/Y4sG74nKjyIyZyP6nbB0BlhLCIhAd6Va3DSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvzmD88EK3/T7sCVafu1UII3xzlHizXonp6i1VZlaIcI/HxF6hcq9qE2tPKwaO9BhhcXQs4hM80BFSzOmO14X38FBtROhMxHYRQpbfdynHaYaGQsMff+k34j0wHXsup4N+DMuzskpWi9vkfPTjXAeeGsmYwpe8y8lXIAzQcyGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f3ydGbJv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f3ydGbJv"
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c0608.dip0.t-ipconnect.de [62.156.6.8])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19F8720B7168;
	Wed, 30 Sep 2026 05:09:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19F8720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790770201;
	bh=vYRLWBXGdoDcpMwuTrTdFAAs9Gv+Lg1m3KfKI6grgAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f3ydGbJvTGGfTJaHnAUX/NohCSOBp14D/J1WACBdK/NaJ5N6/iaFPBnyWRdj1hA1o
	 kcvZfVzwMY1clW7PQZTHBm2wxj2NxeH7Y2nortVv0Y5yTR0R66nD3SxHmJUVPnuYtf
	 1nUc40MravFEAMr1KPlTOgzkhLwkFDOfYe4enmtw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: [PATCH v4] drivers/hv: remove deposited pages from direct map
Date: Wed, 30 Sep 2026 14:10:47 +0200
Message-Id: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
ownership of those pages and per contract revokes root partition
access to them, raising a #GP on access from the L1VH root partition.

However, the pages remain mapped in the kernel direct map, so kernel
code may still access them even though the hypervisor has revoked
access.

Helpers such as "load_unaligned_zeropad()" deliberately read past the
end of a buffer and across page boundaries. A read into an unmapped
page is tolerated and triggers a #PF, for which the kernel executes
a fixup in the exception table.

If such a call steps into a page that has been deposited, the access
raises a #GP by the hypervisor from which the above handler cannot
recover and the kernel panics:

  Oops: general protection fault, maybe for address 0xff1100941a3dfffc
  RIP: 0010:csum_partial+0xe5/0x110

This condition will appear on L1VH system that have created L2
partitions (and hence deposited pages) and exercise networking code
paths such as csum_partial() can trigger this condition when a buffer
ends close to a page boundary (e.g fffc in the above example).

The fix is to remove the deposited pages from the direct map before
they are passed to the hypervisor, and restore them when the hypervisor
returns them again.

We want to avoid flushing the TLB in the loop, so we use the _noflush()
variant of set_direct_map_valid() when marking a deposited page invalid
and flush the affected page ranges in one go ourselves. In the opposite
direction this is not required:

  > If a paging-structure entry is modified to change the P flag from
  > 0 to 1, no invalidation is necessary. This is because no TLB entry
  > or paging-structure cache entry is created with information from a
  > paging-structure entry in which the P flag is 0.

(Intel SDM Vol. 3, 4.10.4.3)

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
Changes since v3:
- Batch contiguous pages in the restore path
- Adjusted comment about failure modes

Changes since v2:
- Checkpatch format fix

Changes since RFC:
- Handle direct-map restoration failures without returning unmapped
  pages to the allocator.
- Move freeing of withdrawn pages into the restoration helper.
---
 drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
 drivers/hv/mshv_root_hv_call.c |  4 +-
 include/asm-generic/mshyperv.h |  4 ++
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..b056051a5ac5 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -7,7 +7,9 @@
 #include <linux/cpuhotplug.h>
 #include <linux/minmax.h>
 #include <linux/export.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
+#include <asm/tlbflush.h>
 
 /*
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
@@ -15,6 +17,35 @@
  */
 #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
+/*
+ * Add or remove a set of physically contiguous page runs from the kernel
+ * direct map. Once a page has been deposited the hypervisor owns it and
+ * revokes root partition access to it.
+ */
+static int hv_deposit_update_direct_map(struct page **pages, int *counts,
+					int num_allocations, bool valid)
+{
+	int i, err, ret = 0;
+
+	for (i = 0; i < num_allocations; ++i) {
+		err = set_direct_map_valid_noflush(pages[i], counts[i], valid);
+		if (err && !ret)
+			ret = err;
+	}
+
+	if (valid)
+		return ret;
+
+	for (i = 0; i < num_allocations; ++i) {
+		unsigned long addr = (unsigned long)page_address(pages[i]);
+		unsigned long size = (unsigned long)counts[i] << PAGE_SHIFT;
+
+		flush_tlb_kernel_range(addr, addr + size);
+	}
+
+	return ret;
+}
+
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
@@ -72,6 +103,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	}
 	num_allocations = i;
 
+	ret = hv_deposit_update_direct_map(pages, counts, num_allocations, false);
+	if (ret)
+		goto err_restore_direct_map;
+
 	local_irq_save(flags);
 
 	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	if (!hv_result_success(status)) {
 		hv_status_err(status, "\n");
 		ret = hv_result_to_errno(status);
-		goto err_free_allocations;
+		goto err_restore_direct_map;
 	}
 
 	ret = 0;
 	goto free_buf;
 
+err_restore_direct_map:
+	/*
+	 * We don't want to return pages to the allocator if weren't able to
+	 * mark them valid in the direct map.
+	 */
+	if (hv_deposit_update_direct_map(pages, counts, num_allocations, true)) {
+		WARN(1, "leaking %d page block(s) that could not be set to valid\n",
+		     num_allocations);
+		goto free_buf;
+	}
+
 err_free_allocations:
 	for (i = 0; i < num_allocations; ++i) {
 		base_pfn = page_to_pfn(pages[i]);
@@ -110,6 +156,41 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
+/*
+ * Put withdrawn pages back in the direct map. Counterpart to the direct map
+ * removal done by hv_call_deposit_pages().
+ */
+void hv_restore_withdrawn_pages(const u64 *pfns, int count)
+{
+	int i, j, end, n, ret;
+	struct page *page;
+
+	for (i = 0; i < count; i = end) {
+		page = pfn_to_page(pfns[i]);
+		/* find consecutive runs of pfns */
+		for (end = i + 1; end < count; ++end) {
+			if (pfns[end] != pfns[end - 1] + 1)
+				break;
+		}
+		n = end - i;
+		ret = set_direct_map_valid_noflush(page, n, true);
+
+		for (j = i; j < end; ++j) {
+			page = pfn_to_page(pfns[j]);
+			/*
+			 * Retry individually on failed batch. We don't want
+			 * to return pages to the allocator that we couldn't mark
+			 * valid in the direct map.
+			 */
+			if (ret &&
+			    WARN_ON_ONCE(set_direct_map_valid_noflush(page, 1, true)))
+				continue;
+			__free_page(page);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
+
 int hv_deposit_memory_node(int node, u64 partition_id,
 			   u64 hv_status)
 {
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..150a0c63ebc8 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -46,7 +46,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 	struct page *page;
 	u16 completed;
 	u64 status, withdrawn = 0;
-	int i;
 	unsigned long flags;
 
 	page = alloc_page(GFP_KERNEL);
@@ -69,8 +68,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 
 		completed = hv_repcomp(status);
 
-		for (i = 0; i < completed; i++)
-			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
 
 		if (!hv_result_success(status)) {
 			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..397c8ec0ce9a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -346,6 +346,7 @@ static inline bool hv_parent_partition(void)
 bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+void hv_restore_withdrawn_pages(const u64 *pfns, int count);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
@@ -364,6 +365,9 @@ static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_page
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void hv_restore_withdrawn_pages(const u64 *pfns, int count) { }
+
 static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

