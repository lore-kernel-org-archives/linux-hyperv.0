Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719463;
	b=yGyVM4wLLMtahT1duLela8oGlA3qsyFvZQrYHQ0CKo9yFz9S9C7WMgmnmbg6S3RJCayG
	 YBdKS3k5TOoM/9QUfOBAYCep9QBPSVPe8sZyA7dBDUig7+YL6EpnluA/3SKhYPR6VLreN
	 RVH2TSWyJoRZePRHHv84NwAX8L0IveadJ+Wscv+O+eF0cp64to5GdoEs1FRhrjNJ+GCs9
	 GdtdZ/tU6VSsLGsDnINr4Sebr9M8ctojR1OAozXExBHRz3NTzsg/1nsd1XOHVGR7S9wDp
	 uiIjc9bEYFTfpC7+GFizuLhLQZYBu8zmm38KFU4eim3xiV0fH9l+juRnFhl6VRFGqKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719463;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=l+02KwoSSXlWZVcs84FeV0oKegrze6AbX9iD/mlqVd4=;
	b=TjXIgDP7dyQWW2p8sn8YM2RBMiJjuJPLLHqUI9xARj+3EPvr84yuth1b9YBguDQGggjB
	 pxluVEXvSSp186qUic7gQPjzccCcLU/K6sMbKrT5Aw89SNr586mwUsjQU143IAgU7KvWI
	 sOPao/IhUCRtbj/Zv3DLaULcwKssI+kE5vUj/nx8ZJ/eUX3RVTw8AURho6f/jfT5k7Z7A
	 xxcDWoC0SS9fAv08LvqBpuqNIdOJTEXWNxCrlezbE27NEVNOZevVm12eCRO4IKW2RBDpH
	 4L+WcDvGaZlfQLx8oiARrIaH5cBjXAMDmRBoRT7t7hEW2w13ocsaR53x1Wfp6e4HBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=o5LstHbq;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4196606A324;
	Tue,  3 Nov 2026 15:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4196606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=o5LstHbq
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DE7B20B7166;
	Tue,  3 Nov 2026 07:24:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DE7B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793719447;
	bh=l+02KwoSSXlWZVcs84FeV0oKegrze6AbX9iD/mlqVd4=;
	h=From:To:Cc:Subject:Date:From;
	b=o5LstHbq9g0Fbbs4Zu//WA+Sw0Jag8Fg0dmGOtyrdjfT9altZawohqrCho6qLITjJ
	 jJ9dhptq4P0iGdYy2VzIqWR7+AwaPuKX9c3ehQ9Z9pa/6xTdbY9hww00w6ZexwrBxd
	 sS3YHGHL1GAgZEMSxfWs2WGj3ruDdVZpQjn5gR28=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Wei Liu <liuwe@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mukesh R <mrathor@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-kernel@vger.kernel.org,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v5] mshv: remove deposited pages from direct map
Date: Tue,  3 Nov 2026 16:24:16 +0100
Message-Id: <20261103152416.404545-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
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

We want to avoid flushing the TLB in the loop, so we use
set_direct_map_invalid_noflush() when marking a deposited page invalid
and flush the affected page ranges in one go ourselves. In the opposite
direction this is not required:

  > If a paging-structure entry is modified to change the P flag from
  > 0 to 1, no invalidation is necessary. This is because no TLB entry
  > or paging-structure cache entry is created with information from a
  > paging-structure entry in which the P flag is 0.

(Intel SDM Vol. 3, 4.10.4.3)

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Changes since v4:

- Adjusted for set_direct_map_{default,invalid}_noflush() signature
  changes
- Stop direct-map removal at first failure, restore/free supplied
  pages within the helper
- Leak only pages that cannot be restored
- Extract contiguous pfn-run detection into helper

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
 drivers/hv/hv_proc.c           | 112 +++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_hv_call.c |   4 +-
 include/asm-generic/mshyperv.h |   4 ++
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index f811bb5c42a1..b63f8da1ecc1 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -7,12 +7,65 @@
 #include <linux/cpuhotplug.h>
 #include <linux/minmax.h>
 #include <linux/export.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
+#include <asm/tlbflush.h>
 
 #define HV_DEPOSIT_MAX 512
 #define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
 	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
 
+static inline int find_consecutive_pfns(const u64 *pfns, int count, int start)
+{
+	int end;
+
+	if (start >= count)
+		return count;
+
+	for (end = start + 1; end < count; ++end) {
+		if (pfns[end] != pfns[end - 1] + 1)
+			break;
+	}
+
+	return end;
+}
+
+/*
+ * Remove pages from the direct map before depositing them. On failure,
+ * restore the mapping and free all supplied pages, leaking pages whose
+ * mappings cannot be restored.
+ */
+static int hv_remove_deposit_mapping(const u64 *pfns, int count)
+{
+	int i, end, ret;
+	unsigned long addr, size;
+
+	for (i = 0; i < count; i = end) {
+		end = find_consecutive_pfns(pfns, count, i);
+
+		ret = set_direct_map_invalid_noflush(pfn_to_page(pfns[i]),
+						   end - i);
+		if (ret)
+			goto restore;
+	}
+
+	for (i = 0; i < count; i = end) {
+		addr = (unsigned long)page_address(pfn_to_page(pfns[i]));
+
+		end = find_consecutive_pfns(pfns, count, i);
+
+		size = (unsigned long)(end - i) << PAGE_SHIFT;
+		flush_tlb_kernel_range(addr, addr + size);
+	}
+
+	return 0;
+
+restore:
+	/* The failing run may have been partially modified too. */
+	hv_restore_withdrawn_pages(pfns, count);
+	return ret;
+}
+
 /*
  * Allocate free pages for deposit to hypervisor. pfna[] must be large enough
  * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return last
@@ -84,7 +137,7 @@ static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
 static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 {
 	struct hv_deposit_memory *hc_input;
-	int i, rc, num_pages;
+	int i, rc, num_pages, completed;
 	u64 status, *pfna, lastpfn = 0;
 	bool trunc_extra = false;
 
@@ -125,6 +178,21 @@ static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
 	}
 
+	rc = hv_remove_deposit_mapping(pfna, num_pages);
+	if (rc) {
+		if (lastpfn)
+			__free_page(pfn_to_page(lastpfn));
+		goto out_free;
+	}
+
+	if (lastpfn) {
+		rc = hv_remove_deposit_mapping(&lastpfn, 1);
+		if (rc) {
+			hv_restore_withdrawn_pages(pfna, num_pages);
+			goto out_free;
+		}
+	}
+
 	/* Not using hyperv_pcpu_input_arg, so no need to disable interrupts */
 
 	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages, 0,
@@ -139,7 +207,7 @@ static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 
 		if (!hv_result_success(status) && hv_repcomp(status) == 0)
 			/* We deposited lot earlier, so give it a go */
-			__free_page(pfn_to_page(lastpfn));
+			hv_restore_withdrawn_pages(&lastpfn, 1);
 	}
 
 	free_page((unsigned long)hc_input);
@@ -148,17 +216,51 @@ static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
 err_free_dep_pages:
 	hv_status_err(status, "\n");
 	rc = hv_result_to_errno(status);
+	completed = hv_repcomp(status);
 
-	for (i = hv_repcomp(status); i < num_pages; i++)
-		__free_page(pfn_to_page(pfna[i]));
+	hv_restore_withdrawn_pages(pfna + completed, num_pages - completed);
 	if (lastpfn)
-		__free_page(pfn_to_page(lastpfn));
+		hv_restore_withdrawn_pages(&lastpfn, 1);
 
 out_free:
 	free_page((unsigned long)hc_input);
 	return rc;
 }
 
+/*
+ * Put withdrawn pages back in the direct map and free them. Counterpart to
+ * the direct map removal done by hv_call_deposit_pages(). Leak the pages
+ * that failed to be restored.
+ */
+void hv_restore_withdrawn_pages(const u64 *pfns, int count)
+{
+	int i, j, end, n, ret;
+	struct page *page;
+
+	for (i = 0; i < count; i = end) {
+		page = pfn_to_page(pfns[i]);
+
+		end = find_consecutive_pfns(pfns, count, i);
+
+		n = end - i;
+		ret = set_direct_map_default_noflush(page, n);
+
+		for (j = i; j < end; ++j) {
+			page = pfn_to_page(pfns[j]);
+			/*
+			 * Retry individually on failed batch. We don't want
+			 * to return pages to the allocator that we couldn't mark
+			 * valid in the direct map.
+			 */
+			if (ret &&
+			    WARN_ON_ONCE(set_direct_map_default_noflush(page, 1)))
+				continue;
+			__free_page(page);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
+
 int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
 {
 	int result = hv_result(hv_status);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index b8d199f95299..80256ddaa768 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -44,7 +44,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 	struct page *page;
 	u16 completed;
 	u64 status, withdrawn = 0;
-	int i;
 	unsigned long flags;
 
 	page = alloc_page(GFP_KERNEL);
@@ -67,8 +66,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 
 		completed = hv_repcomp(status);
 
-		for (i = 0; i < completed; i++)
-			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
 
 		if (!hv_result_success(status)) {
 			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4c9f3353074a..b4dc9cbf0fa6 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -347,6 +347,7 @@ static inline bool hv_parent_partition(void)
 
 bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
+void hv_restore_withdrawn_pages(const u64 *pfns, int count);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
@@ -361,6 +362,9 @@ static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
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

