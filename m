Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90228DC4;
	Wed, 12 Aug 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493127; cv=none; b=OIEf7GpZm1vTqCymzTvG/iSCdNcJf9mg2htokbC3yLBqZghl/cifG1QCdgSnY/m36ULv6WIWX61C+9Z1RqIaPleLfQRITUtpdxzGxONhtDO3rt/TxuknrUHvuytlmJpKf671282kDjo2j8V4B5eJxfIcbjU6CmVGaHyNFsuGuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493127; c=relaxed/simple;
	bh=70RWACNEyQn7+QJ+NYOurkIxzjut6EwsK/NE1M6a0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK485EQz3htyiiitKK1s/Fzh9fRRXzx9YwC6QXgHSBZ2//huczrQelMOI1oOs5wWV55o3rqDLwXzlyq/2ozjkMysNnB78q5gOiUPr0uOJ8Zw2Rv2l33UgbkC0wRnVCgnNvxYjqwncuWGo6iQ3kij6bxE8FnYgdmfnjBpARH56NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ahg8JzKM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ahg8JzKM"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id EDC6020B710C;
	Tue, 11 Aug 2026 17:04:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDC6020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786493096;
	bh=vFRVfFWdvf2mQshcVmmw5NSWr7/5EQ6ATsoLVpoGjjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ahg8JzKM6gFQmDisErC+LgvHdp1jmubHl4cyL7gdJJmoKe3LMVDJTBLRCYu07EuoP
	 5cZYZazKr1WtURbB+NulJYWiJMvFACyuuIwsN+xdcNcmohOj/Tt2YQdUoolKr3MSAn
	 3246B8ojaPaxnYCZ4RbR6C098lbiVlHOlbYRd3yk=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V0 2/2] mshv: Redesign hypervisor memory deposit logic
Date: Tue, 11 Aug 2026 17:05:07 -0700
Message-ID: <20260812000507.3809046-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
References: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are few issues/bugs in the deposit memory implementation:
 o It is very slow
 o Contiguous range requirement is ignored, and is critical bug
 o An incorrect assumption is made that contiguous memory size would
   always be power of 2.
 o Two pages are allocated, only one is really needed. This adds to
   overhead.
 o For a 512 page deposit, the allocation is split into two: one for 511
   and second for 1. Thus, an order 9 allocation never happens. A
   contiguous 2M range would significantly improve performance in the
   hypervisor.
 o Since a page is already allocated to collect the frames, there is
   not really a need to use per cpu input page, and hence avoid local
   irq disable.

All of above is addressed by:
 o Start with a full 2M range alloc, thus getting contiguous if available.
 o Allocate only one page in the deposit function and collect 511 pfns
   there. Just use a local variable for last pfn.
 o Use the page as input to hypercall. Since this page is allocated, irq
   disable can be avoided helping speed up the deposit.
 o Fix the contiguous requirement by using kmalloc in such case.
 o A minimum deposit of 2M done universally to overcome bad performance 
   overheads. The hypervisor will always first reuse any unused memory 
   that was previously deposited before asking for more.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           | 180 +++++++++++++++++++++++++++++++--
 drivers/hv/mshv_root_hv_call.c |  10 +-
 include/asm-generic/mshyperv.h |   5 -
 3 files changed, 174 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index d5ce9a032e9c..fd74c286e612 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -9,15 +9,182 @@
 #include <linux/export.h>
 #include <asm/mshyperv.h>
 
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+#define HV_DEPOSIT_MAX 512
+#define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
+	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
+
+static int hv_alloc_contig_pages(int node, u64 *pfna, u64 *lastpfnp,
+				 int num_pages)
+{
+	void *p;
+	int i, tmp;
+	ulong pfn;
+	size_t size = num_pages * HV_HYP_PAGE_SIZE;
+
+	if (num_pages > HV_DEPOSIT_MAX ||
+	    (num_pages == HV_DEPOSIT_MAX && lastpfnp == NULL))
+		return -EINVAL;
+
+	p = kmalloc_node(size, GFP_KERNEL, node);
+	if (p == NULL)
+		return -ENOMEM;
+
+	pfn = PFN_DOWN(virt_to_phys(p));
+	tmp = min(num_pages, HV_DEPOSIT_INP_MAX);
+
+	for (i = 0; i < tmp; i++, pfn++)
+		pfna[i] = pfn;
+
+	if (num_pages == HV_DEPOSIT_MAX)
+		*lastpfnp = pfn;
+
+	return num_pages;
+}
+
+
+/*
+ * Allocate free pages for deposit to hypervisor. pfna[] must be large enough
+ * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return last
+ * pfn in lastpfn.
+ *
+ * Returns : -ENOMEM if zero allocated, else number of pages allocated
+ */
+static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages)
+{
+	struct page *page;
+	int num_allocd, count = 0;
+
+	/* Published ABI, enforce its immutability. */
+	BUILD_BUG_ON(HV_DEPOSIT_INP_MAX != 511);
+
+	if (num_pages > HV_DEPOSIT_MAX ||
+	    (num_pages == HV_DEPOSIT_MAX && lastpfnp == NULL))
+		return -EINVAL;
+
+	while (num_pages) {
+		/* Find highest order we can actually allocate */
+		int order = 31 - __builtin_clz(num_pages);
+
+		while (1) {
+			page = alloc_pages_node(node, GFP_KERNEL, order);
+			if (page || order == 0)
+				break;
+
+			order--;
+		}
+
+		if (page == NULL)
+			break;
+
+		split_page(page, order);
+		num_allocd = 1 << order;
+		num_pages -= num_allocd;
+
+		while (num_allocd && count < HV_DEPOSIT_INP_MAX) {
+			pfna[count++] = page_to_pfn(page++);
+			num_allocd--;
+		}
+
+		if (num_allocd-- && count == HV_DEPOSIT_INP_MAX) {
+			*lastpfnp = page_to_pfn(page);
+			count++;
+			break;
+		}
+	}
+
+	return count ? count : -ENOMEM;
+}
+
+/*
+ * Deposit memory in the hypervisor. A contiguous 2M worth of pfns is utmost
+ * desired, but short of that, we deposit whatever contiguous chunks we can
+ * get.
+ */
+static int hv_call_deposit_memory(int node, u64 partition_id, bool contiguous)
 {
-	return -ENOTSUPP;
+	struct hv_deposit_memory *hc_input;
+	int i, rc, num_pages;
+	u64 status, *pfna, lastpfn = 0;
+
+	BUILD_BUG_ON(HV_MAX_CONTIGUOUS_ALLOCATION_PAGES > HV_DEPOSIT_MAX);
+
+	if (contiguous)
+		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
+	else
+		num_pages = HV_DEPOSIT_MAX;
+
+	hc_input = (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);
+	if (hc_input == NULL)
+		return -ENOMEM;
+
+	hc_input->partition_id = partition_id;
+	pfna = hc_input->gpa_page_list;
+
+	if (contiguous)
+		rc = hv_alloc_contig_pages(node, pfna, &lastpfn, num_pages);
+	else
+		rc = hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages);
+	if (rc < 0)
+		goto out_free;
+
+	num_pages = rc;
+	if (num_pages > HV_DEPOSIT_INP_MAX)
+		num_pages = HV_DEPOSIT_INP_MAX;
+
+	/* We are not using hyperv_pcpu_input_arg, so no need to disable */
+
+	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages,
+				     0, hc_input, NULL);
+	if (!hv_result_success(status)) {
+		hv_status_err(status, "\n");
+		rc = hv_result_to_errno(status);
+		goto out_free_dep_pages;
+	}
+
+	if (lastpfn) {
+		hc_input->gpa_page_list[0] = lastpfn;
+		status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
+					     hc_input, NULL);
+		if (!hv_result_success(status))
+			/* We deposited some earlier, so just free this */
+			__free_page(pfn_to_page(lastpfn));
+	}
+
+	free_page((unsigned long)hc_input);
+	return 0;
+
+out_free_dep_pages:
+	for (i = 0; i < num_pages; i++)
+		__free_page(pfn_to_page(pfna[i]));
+	if (lastpfn)
+		__free_page(pfn_to_page(lastpfn));
+
+out_free:
+	free_page((unsigned long)hc_input);
+	return rc;
 }
-EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
-int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
+int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
 {
-	return -ENOTSUPP;
+	int result = hv_result(hv_status);
+	bool contiguous = false;
+
+	if (result == HV_STATUS_INSUFFICIENT_ROOT_MEMORY ||
+	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY) {
+		if (!hv_root_partition()) {
+			hv_status_err(hv_status,
+				      "Unexpected root memory deposit\n");
+			return -EINVAL;
+		}
+
+		pt_id = HV_PARTITION_ID_SELF;
+	}
+
+	if (result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY ||
+	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY)
+		contiguous = true;
+
+	return hv_call_deposit_memory(node, pt_id, contiguous);
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
@@ -85,8 +252,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 	/* Root VPs don't seem to need pages deposited */
 	if (partition_id != hv_current_partition_id) {
-		/* The value 90 is empirically determined. It may change. */
-		ret = hv_call_deposit_pages(node, partition_id, 90);
+		ret = hv_call_deposit_memory(node, partition_id, false);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..b8d199f95299 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -15,8 +15,6 @@
 #include "mshv_root.h"
 
 /* Determined empirically */
-#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
-#define HV_MAP_GPA_DEPOSIT_PAGES	256
 #define HV_UMAP_GPA_PAGES		512
 
 #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
@@ -140,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
 
 	input.partition_id = partition_id;
 
-	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-				    HV_INIT_PARTITION_DEPOSIT_PAGES);
-	if (ret)
-		return ret;
-
 	do {
 		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
 					       *(u64 *)&input);
@@ -248,8 +241,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		completed = hv_repcomp(status);
 
 		if (hv_result_needs_memory(status)) {
-			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-						    HV_MAP_GPA_DEPOSIT_PAGES);
+			ret = hv_deposit_memory(partition_id, status);
 			if (ret)
 				break;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..c16abaecb65e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -345,7 +345,6 @@ static inline bool hv_parent_partition(void)
 
 bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
@@ -360,10 +359,6 @@ static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
 {
 	return -EOPNOTSUPP;
 }
-static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
-{
-	return -EOPNOTSUPP;
-}
 static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
 {
 	return -EOPNOTSUPP;
-- 
2.51.2.vfs.0.1

