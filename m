Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F83B774F;
	Tue, 29 Sep 2026 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721395; cv=none; b=Xcn6+Rswbmt7aiAStmLS/fEP6CsDzNn/KzSTIbdKQHC2fYezWkmA/2NDexAcL5pjmrbLDcG6YMP+DDBhikdzjDYjYe147qkoz7RDa1sqzWTWo3raZNged+t95Sr38OlUJZGU74xHcZTrR6KCazN8VqLfSAnX8vobJJamGcVKYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721395; c=relaxed/simple;
	bh=XrlS4j2ym67Nadudj2nnICnK+UOg6EzZ3N5iVhLHtpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esd5HNv5/YWPIYegOQeK8ln1ea5w6Kc352m6CBntyWBpBn2goScJlgJDAI3pd2/2jjYxkVzPvbw/5BvjAv8bATwMZ1s3ZB7kGrbwm2coadhztI3YTQd9YjhB2NY08A4cawS+nlOyIrgkJOsSV5APVcaz12DCgAtfc4pa2oYB0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QOMzOJIt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QOMzOJIt"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 495EA20B716A;
	Tue, 29 Sep 2026 15:35:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 495EA20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790721341;
	bh=iXJtYZrPDgTihy0OwCsy2bPoc3grbkXyieDRn57gQkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOMzOJItk20qhjsuBwZ2NGV7lfBlVVwLlS6OVR7kMucBAOLTatboyD65b2naY3vB0
	 4cUP7F00ei95qJOEwRVLlWj5CtjAkEBX0d9W9Wq1RuGZVVKAHaYn5DSjRfuhcNBcN7
	 JStENekZBaV6amrHLnQwwnp7naUMJnUC1WHSQliM=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V2 1/4] mshv: Add gfp_flags parameter to hv_call_deposit_pages()
Date: Tue, 29 Sep 2026 15:36:19 -0700
Message-ID: <20260929223622.778617-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260929223622.778617-1-mrathor@linux.microsoft.com>
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently GFP_KERNEL is hard coded in hv_call_deposit_pages(). Add
gfp_flags parameter so it can be called in atomic context from
map_pages callback in struct iommu_domain_ops and other places in
future.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/hv_proc.c           | 14 +++++++-------
 drivers/hv/mshv_root_hv_call.c |  6 ++++--
 include/asm-generic/mshyperv.h |  6 ++++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..ce4276d37d45 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -15,8 +15,8 @@
  */
 #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
-/* Deposits exact number of pages. Must be called with interrupts enabled.  */
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages,
+			  gfp_t gfp_flags)
 {
 	struct page **pages, *page;
 	int *counts;
@@ -35,12 +35,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		return 0;
 
 	/* One buffer for page pointers and counts */
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(gfp_flags);
 	if (!page)
 		return -ENOMEM;
 	pages = page_address(page);
 
-	counts = kzalloc_objs(int, HV_DEPOSIT_MAX);
+	counts = kzalloc_objs(int, HV_DEPOSIT_MAX, gfp_flags);
 	if (!counts) {
 		free_page((unsigned long)pages);
 		return -ENOMEM;
@@ -54,7 +54,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 		order = 31 - __builtin_clz(num_pages);
 
 		while (1) {
-			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
+			pages[i] = alloc_pages_node(node, gfp_flags, order);
 			if (pages[i])
 				break;
 			if (!order) {
@@ -137,7 +137,7 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
 	}
-	return hv_call_deposit_pages(node, partition_id, num_pages);
+	return hv_call_deposit_pages(node, partition_id, num_pages, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
@@ -206,7 +206,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	/* Root VPs don't seem to need pages deposited */
 	if (partition_id != hv_current_partition_id) {
 		/* The value 90 is empirically determined. It may change. */
-		ret = hv_call_deposit_pages(node, partition_id, 90);
+		ret = hv_call_deposit_pages(node, partition_id, 90, GFP_KERNEL);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb55d4d4be2e..bd975239f3bc 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -141,7 +141,8 @@ int hv_call_initialize_partition(u64 partition_id)
 	input.partition_id = partition_id;
 
 	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-				    HV_INIT_PARTITION_DEPOSIT_PAGES);
+				    HV_INIT_PARTITION_DEPOSIT_PAGES,
+				    GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -249,7 +250,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 
 		if (hv_result_needs_memory(status)) {
 			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
-						    HV_MAP_GPA_DEPOSIT_PAGES);
+						    HV_MAP_GPA_DEPOSIT_PAGES,
+						    GFP_KERNEL);
 			if (ret)
 				break;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..af65dd3e3725 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -345,7 +345,8 @@ static inline bool hv_parent_partition(void)
 
 bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages,
+			  gfp_t gfp_flags);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
@@ -360,7 +361,8 @@ static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
 {
 	return -EOPNOTSUPP;
 }
-static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+static inline int hv_call_deposit_pages(int node, u64 partition_id,
+					u32 num_pages, gfp_t gfp_flags)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.51.2.vfs.0.1

