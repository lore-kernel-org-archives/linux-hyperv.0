Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC7544470A;
	Mon, 14 Sep 2026 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386385; cv=none; b=WzP3nwSvaAADydIV60voXa4JUD14ldKg/FXv9mOcn1X+PXNeTJEI9CuGICgelGpJ62EmLabtfzeCMH4u/k0/YN2buyJI80Su44YOTXxA4uYjm41g6cZUZC9OLmqlHPBMHXUNUp7QhgzcrcX9XcQAimI0V6syLkWEdeJICezMwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386385; c=relaxed/simple;
	bh=bTE5MXIvqSiIZe5i+49lO4aoO1UQoLMV88Vli15QSPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXhKNKFZsFjj04c+MQ2jHtquGd4FNU3L0lM6Yy+QxJVCpdRUx5v/IL/CDOAzXdONBofmRADWiAGjPbxtlBw77Qs/9w+gXduqPM9sdhwFLIwF8Rb9e4sQ5UmiztRQw2RFGdIma325CgDnhGhjjI5DXRgoaBdmILSsvUUWLBnk2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RlWcAYlz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RlWcAYlz"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACB6B20B7168;
	Mon, 14 Sep 2026 04:45:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACB6B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789386340;
	bh=79zZtpmo8YK6M8lOBOuuMDodxRd5Y13bD5Fuxjb9XZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=RlWcAYlzSS1vrigLLKTk9VqMycQPw3r+6pkBLogzRLzKxNAwaimWjfroOlGH+uZCe
	 e/xERgpSPiYlIF9LWerAL29wAPrE+ArpA3Bcr7cdXq7bNYdsBHjH5CckMwLayYl26R
	 IqIxRirYQIBDvNfMR22IozMmUVb4UTH5y2/vamso=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Long Li <longli@microsoft.com>
Subject: [RFC PATCH] drivers/hv: remove deposited pages from direct map
Date: Mon, 14 Sep 2026 13:46:17 +0200
Message-Id: <20260914114617.27628-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(RFC b/c feedback from arm64 maintainers to access the impact is
pending)

hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
ownership of those pages and per contract revokes root partition
access to them, raising a #GP on access from the L1VH root partition.

However, the pages remain mapped in the kernel direct map, so kernel
code may still access them even though the hypervisor has revoked
access.

Helpers such as "load_unaligned_zeropad()" deliberately read past the
end of a buffer and across page boundaries. A read into an unmapped
page is tolerated and triggers a #PF, for which the kernel executed
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
 drivers/hv/hv_proc.c           | 53 +++++++++++++++++++++++++++++++++-
 drivers/hv/mshv_root_hv_call.c |  2 ++
 include/asm-generic/mshyperv.h |  4 +++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..3ab02adf7efb 100644
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
@@ -90,12 +125,15 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	if (!hv_result_success(status)) {
 		hv_status_err(status, "\n");
 		ret = hv_result_to_errno(status);
-		goto err_free_allocations;
+		goto err_restore_direct_map;
 	}
 
 	ret = 0;
 	goto free_buf;
 
+err_restore_direct_map:
+	hv_deposit_update_direct_map(pages, counts, num_allocations, true);
+
 err_free_allocations:
 	for (i = 0; i < num_allocations; ++i) {
 		base_pfn = page_to_pfn(pages[i]);
@@ -110,6 +148,19 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
+/*
+ * Put withdrawn pages back in the direct map. Counterpart to the direct map
+ * removal done by hv_call_deposit_pages().
+ */
+void hv_restore_withdrawn_pages(const u64 *pfns, int count)
+{
+	int i;
+
+	for (i = 0; i < count; ++i)
+		set_direct_map_valid_noflush(pfn_to_page(pfns[i]), 1, true);
+}
+EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
+
 int hv_deposit_memory_node(int node, u64 partition_id,
 			   u64 hv_status)
 {
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..8c21ad4ba3b0 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -69,6 +69,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
 
 		completed = hv_repcomp(status);
 
+		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
+
 		for (i = 0; i < completed; i++)
 			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
 
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

