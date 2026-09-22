Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE93E123F;
	Tue, 22 Sep 2026 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050261; cv=none; b=CBQ3X1lrmy8sPgg7MixSc7OQ9QdxysO7WZg0Wy2FmrC3R/LLGuAZ6zC238oQWxw6vQYQgftxy/5NZEe806V7zH9QHL5t3eZ4mLjvlvuv9uCYE1j64rqes5r0k19VZ/OAN7FNXbWZrSY3VFu9vrhH1bEh+ANqIkUIbr0or7Gegn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050261; c=relaxed/simple;
	bh=XQ7KxYb4XGTdLCejuoWNbxGBxyTR6FkDW5xF6v8e6kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDDlHSwFzQQJQRkDVsn/9b7VotoNcvhl5+hXIIoGQXo5+05AN4ZtupQz6b+CTishFQUATnbv21yvA5DuLf67MC3BN0NxP6gerbXsdwpiqCGW8HPMulYpfadafgXtx/6DNzCbEgpSvyWg2l5d5lmOO04orfIJxytBXs5j34a8aMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FNQOpyKy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FNQOpyKy"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 44E5120B716A;
	Mon, 21 Sep 2026 21:10:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44E5120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790050207;
	bh=P+l1ZtSeBmbOGpjkuaIla/KyOL0hsYhkHEO6cdns7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNQOpyKy3wNr1Hbcl0dhfsFkcM/IOhU4+9DMvaAAPUjLwWwNEbk84hyveqnGfWnBi
	 82A7SxDbJb33zreDmEREFaxgbO9z4gai3//+lMuaXMePuOeBfrNqlJbRu2QZ1H6c8/
	 Z7NZuT/foM/rLxN11G0RQAa8019vKkO1p6ZxXq9E=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v7 6/9] mshv: wire SEV-SNP partition ioctls
Date: Tue, 22 Sep 2026 04:10:23 +0000
Message-ID: <20260922041043.171543-7-weh@linux.microsoft.com>
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

Wire the SEV-SNP UAPI into partition creation, memory ownership,
isolated-page import, launch completion, PSP guest requests, AP creation,
and teardown.

Track host READ/WRITE permissions and shared/exclusive ownership for
every pinned 4K page with compact bitmaps. The initial baseline is host
RW/shared; completed setup releases become host-none/exclusive. Track an
uncertain state and a nonbaseline count so teardown restores only known
changed pages and unpins only after every page is known baseline.

Keep the ACQUIRE/RELEASE opcode independent from ownership. Preserve
caller flags, supply the child partition ID only for MAKE_EXCLUSIVE, and
use partition ID zero for ACQUIRE+MAKE_SHARED and permission-only calls.
State transitions derive READ/WRITE from host_access; explicit
MAKE_EXCLUSIVE or MAKE_SHARED changes ownership, while no ownership flag
preserves the current state.

Report only the trusted completed prefix in 4K-page units, including 2M
conversion. Update state only for that prefix and quarantine impossible
completion counts. Reject duplicate request GPAs, duplicate backing
PFNs, and pinned PFN aliases across regions. Validate 2M GPA grouping,
alignment, and physical contiguity across region boundaries.

Bound MODIFY_GPA_HOST_ACCESS to 65536 4K-page array entries, including
512 entries per requested 2M page. Reject larger requests before variable
allocation or side effects, with completed initialized to zero. Use
rescheduling sorts for whole-request duplicate detection and periodically
reschedule long user-controlled normalization, resolution, validation,
reference-release, region scanning, state update, and hypercall batching
loops.

Allow a fatal signal to stop isolated-page import between completed
batches. Return -EINTR with the exact completed prefix so userspace can
resume safely without abandoning an in-flight asynchronous hypercall.

On setup failure, restore only the pages whose explicit exclusive release
completed. Generic MODIFY changes permissions while preserving
ownership. PSP requests preserve each page's ownership, save exact
original permissions, transition only pages needing host access removed,
and restore successful transitions with ACQUIRE or RELEASE selected from
the permission delta. A successful PSP request deliberately leaves the
request and response pages host-none for guest consumption; later
explicit access changes or teardown restore them.

Keep result normalization, current-state transition application, 2M
completion conversion, duplicate detection, and teardown phase
sequencing in small internal helpers. A follow-up KUnit object can inject
completed/error/uncertain results and mock teardown callbacks without
replacing production hypercall code.

For initialized and uninitialized SNP partitions alike, unmap every child
mapping, destroy initialized isolation state, then restore host access.
Exclusive pages use ACQUIRE+RW+MAKE_SHARED; shared pages with reduced
permissions use ACQUIRE+RW without an ownership flag. Group restoration
only across pages with identical tracked state.

Hyper-V transfers root-to-child SPA/SLAT ownership directly; this
intentionally does not alter the root direct map, memory encryption
attributes, or GPA shared-bit encoding.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_regions.c      |  344 ++++++++++-
 drivers/hv/mshv_root.h         |   94 ++-
 drivers/hv/mshv_root_hv_call.c |  138 ++++-
 drivers/hv/mshv_root_main.c    | 1031 +++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h    |   12 +
 include/uapi/linux/mshv.h      |    6 +
 6 files changed, 1501 insertions(+), 124 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index b08b2709bf11..7a51133d9973 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -7,11 +7,13 @@
  * Authors: Microsoft Linux virtualization team
  */
 
+#include <linux/bitmap.h>
 #include <linux/hmm.h>
 #include <linux/hyperv.h>
 #include <linux/kref.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/xarray.h>
 
 #include <asm/mshyperv.h>
 
@@ -105,6 +107,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 		if (stride != mshv_chunk_stride(page, gfn + count,
 						page_count - count))
 			break;
+		mshv_user_loop_cond_resched(count);
 	}
 
 	ret = handler(region, flags, page_offset, count, stride > 1);
@@ -152,6 +155,7 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 		if (!region->mreg_pages[page_offset]) {
 			page_offset++;
 			page_count--;
+			mshv_user_loop_cond_resched(page_count);
 			continue;
 		}
 
@@ -164,6 +168,7 @@ static int mshv_region_process_range(struct mshv_mem_region *region,
 
 		page_offset += ret;
 		page_count -= ret;
+		cond_resched();
 	}
 
 	return 0;
@@ -194,51 +199,336 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 	return region;
 }
 
-static int mshv_region_chunk_share(struct mshv_mem_region *region,
-				   u32 flags,
-				   u64 page_offset, u64 page_count,
-				   bool huge_page)
+int mshv_region_host_access_init(struct mshv_mem_region *region)
+{
+	unsigned int nr_pages;
+	unsigned int longs;
+	size_t bytes;
+
+	if (region->nr_pages > UINT_MAX)
+		return -E2BIG;
+
+	nr_pages = region->nr_pages;
+	longs = BITS_TO_LONGS(nr_pages);
+	bytes = array_size(longs, sizeof(unsigned long));
+	region->host_access_read = kvcalloc(4, bytes, GFP_KERNEL);
+	if (!region->host_access_read)
+		return -ENOMEM;
+
+	region->host_access_write = region->host_access_read + longs;
+	region->host_access_exclusive = region->host_access_write + longs;
+	region->host_access_uncertain =
+		region->host_access_exclusive + longs;
+	bitmap_fill(region->host_access_read, nr_pages);
+	bitmap_fill(region->host_access_write, nr_pages);
+	return 0;
+}
+
+int mshv_region_check_duplicate_pfns(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	struct mshv_mem_region *existing;
+	DEFINE_XARRAY(pfns);
+	u64 i;
+	int ret = 0;
+
+	lockdep_assert_held(&partition->pt_mutex);
+
+	/*
+	 * Use a temporary index so alias rejection has no permanent per-page
+	 * memory cost. xa_insert() also rejects duplicate PFNs within region.
+	 */
+	for (i = 0; i < region->nr_pages; i++) {
+		ret = xa_insert(&pfns, page_to_pfn(region->mreg_pages[i]),
+				region, GFP_KERNEL);
+		if (ret) {
+			if (ret == -EBUSY)
+				ret = -EEXIST;
+			goto out;
+		}
+		mshv_user_loop_cond_resched(i + 1);
+	}
+
+	hlist_for_each_entry(existing, &partition->pt_mem_regions, hnode) {
+		if (existing->mreg_type != MSHV_REGION_TYPE_MEM_PINNED)
+			continue;
+		for (i = 0; i < existing->nr_pages; i++) {
+			mshv_user_loop_cond_resched(i + 1);
+			if (!xa_load(&pfns,
+				     page_to_pfn(existing->mreg_pages[i])))
+				continue;
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+out:
+	xa_destroy(&pfns);
+	return ret;
+}
+
+static bool mshv_host_access_state_is_baseline(u8 state)
+{
+	return state == MSHV_HOST_ACCESS_BASELINE;
+}
+
+u8 mshv_region_host_access_get(const struct mshv_mem_region *region, u64 index)
+{
+	u8 state = 0;
+
+	if (WARN_ON_ONCE(!region->host_access_read ||
+			 index >= region->nr_pages))
+		return MSHV_HOST_ACCESS_UNCERTAIN;
+
+	if (test_bit(index, region->host_access_read))
+		state |= MSHV_HOST_ACCESS_READ;
+	if (test_bit(index, region->host_access_write))
+		state |= MSHV_HOST_ACCESS_WRITE;
+	if (test_bit(index, region->host_access_exclusive))
+		state |= MSHV_HOST_ACCESS_EXCLUSIVE;
+	if (test_bit(index, region->host_access_uncertain))
+		state |= MSHV_HOST_ACCESS_UNCERTAIN;
+	return state;
+}
+
+void mshv_region_host_access_set(struct mshv_mem_region *region, u64 index,
+				 u8 state)
+{
+	u8 old = mshv_region_host_access_get(region, index);
+
+	if (mshv_host_access_state_is_baseline(old) &&
+	    !mshv_host_access_state_is_baseline(state))
+		region->host_nonbaseline_pages++;
+	else if (!mshv_host_access_state_is_baseline(old) &&
+		 mshv_host_access_state_is_baseline(state))
+		region->host_nonbaseline_pages--;
+
+	assign_bit(index, region->host_access_read,
+		   state & MSHV_HOST_ACCESS_READ);
+	assign_bit(index, region->host_access_write,
+		   state & MSHV_HOST_ACCESS_WRITE);
+	assign_bit(index, region->host_access_exclusive,
+		   state & MSHV_HOST_ACCESS_EXCLUSIVE);
+	assign_bit(index, region->host_access_uncertain,
+		   state & MSHV_HOST_ACCESS_UNCERTAIN);
+}
+
+static void
+mshv_region_host_access_mark_uncertain(struct mshv_mem_region *region,
+				       u64 index, u64 count)
+{
+	u64 i;
+
+	for (i = 0; i < count; i++) {
+		u8 state = mshv_region_host_access_get(region, index + i);
+
+		mshv_region_host_access_set(region, index + i, state | MSHV_HOST_ACCESS_UNCERTAIN);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+}
+
+static int
+mshv_host_access_normalize_result(struct mshv_host_access_result *result,
+				  u64 count)
+{
+	if (result->completed > count) {
+		result->completed = 0;
+		result->uncertain = true;
+		result->error = -EPROTO;
+	} else if (!result->error && result->completed != count) {
+		result->uncertain = true;
+		result->error = -EPROTO;
+	}
+
+	return result->error;
+}
+
+u8 mshv_make_host_access_state(u8 old_state, u32 host_access, u32 flags)
+{
+	/* Permissions are replaced; only explicit flags change ownership. */
+	u8 state = old_state & (MSHV_HOST_ACCESS_EXCLUSIVE |
+			      MSHV_HOST_ACCESS_UNCERTAIN);
+
+	if (host_access & HV_MAP_GPA_READABLE)
+		state |= MSHV_HOST_ACCESS_READ;
+	if (host_access & HV_MAP_GPA_WRITABLE)
+		state |= MSHV_HOST_ACCESS_WRITE;
+
+	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE) {
+		state |= MSHV_HOST_ACCESS_EXCLUSIVE;
+		state &= ~MSHV_HOST_ACCESS_UNCERTAIN;
+	} else if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED) {
+		state &= ~(MSHV_HOST_ACCESS_EXCLUSIVE |
+			   MSHV_HOST_ACCESS_UNCERTAIN);
+	}
+
+	return state;
+}
+
+int
+mshv_apply_region_host_access(struct mshv_mem_region *region, u64 index,
+			      u64 count, u32 host_access, u32 flags,
+			      struct mshv_host_access_result *result)
+{
+	u64 i;
+
+	mshv_host_access_normalize_result(result, count);
+	for (i = 0; i < result->completed; i++) {
+		u8 old_state = mshv_region_host_access_get(region, index + i);
+		u8 state = mshv_make_host_access_state(old_state, host_access,
+						       flags);
+
+		mshv_region_host_access_set(region, index + i, state);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	if (result->uncertain) {
+		u64 remaining = count - result->completed;
+		u64 uncertain_index = index + result->completed;
+
+		mshv_region_host_access_mark_uncertain(region, uncertain_index,
+						       remaining);
+	}
+
+	return result->error;
+}
+
+static u8 mshv_host_access_page_state(const struct mshv_host_access_page *page)
+{
+	return mshv_region_host_access_get(page->region, page->index);
+}
+
+static void mshv_host_access_page_set(struct mshv_host_access_page *page,
+				      u8 state)
+{
+	mshv_region_host_access_set(page->region, page->index, state);
+}
+
+int
+mshv_apply_host_access(struct mshv_host_access_page *host_pages,
+		       u64 count, u32 host_access, u32 flags,
+		       struct mshv_host_access_result *result)
+{
+	u64 i;
+
+	mshv_host_access_normalize_result(result, count);
+	for (i = 0; i < result->completed; i++) {
+		struct mshv_host_access_page *host_page = &host_pages[i];
+		u8 old_state = mshv_host_access_page_state(host_page);
+		u8 state = mshv_make_host_access_state(old_state, host_access,
+						       flags);
+
+		mshv_host_access_page_set(host_page, state);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	if (result->uncertain) {
+		for (i = result->completed; i < count; i++) {
+			struct mshv_host_access_page *host_page = &host_pages[i];
+			u8 old = mshv_host_access_page_state(host_page);
+
+			mshv_host_access_page_set(host_page,
+						  old | MSHV_HOST_ACCESS_UNCERTAIN);
+			mshv_user_loop_cond_resched(i + 1);
+		}
+	}
+
+	return result->error;
+}
+
+bool mshv_region_host_access_is_baseline(const struct mshv_mem_region *region)
+{
+	return !region->host_access_read || !region->host_nonbaseline_pages;
+}
+
+static int
+mshv_region_modify_host_access(struct mshv_mem_region *region, u32 flags,
+			       u64 page_offset, u64 page_count, bool huge_page,
+			       u32 host_access, bool acquire)
 {
+	struct mshv_host_access_result result;
+
 	if (huge_page)
 		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
 
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pages + page_offset,
-					      page_count,
+	mshv_modify_host_access(region->partition->pt_id,
+				region->mreg_pages + page_offset, page_count,
+				host_access, flags, acquire, &result);
+
+	/*
+	 * completed is always a trusted count in 4K pages, including for 2M
+	 * entries. The result helper is intentionally hypercall-independent so
+	 * KUnit can inject partial and impossible completions.
+	 */
+	return mshv_apply_region_host_access(region, page_offset, page_count,
+					     host_access, flags, &result);
+}
+
+static int mshv_region_chunk_share(struct mshv_mem_region *region,
+				   u32 flags, u64 page_offset,
+				   u64 page_count, bool huge_page)
+{
+	return mshv_region_modify_host_access(region, flags, page_offset,
+					      page_count, huge_page,
 					      HV_MAP_GPA_READABLE |
-					      HV_MAP_GPA_WRITABLE,
-					      flags, true);
+					      HV_MAP_GPA_WRITABLE, true);
 }
 
 int mshv_region_share(struct mshv_mem_region *region)
 {
-	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
+	u64 offset = 0;
+	int state_error = 0;
+	int ret;
+
+	while (offset < region->nr_pages) {
+		u64 count;
+		u32 flags;
+		u8 state = mshv_region_host_access_get(region, offset);
 
-	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
-					 mshv_region_chunk_share);
+		if (state & MSHV_HOST_ACCESS_UNCERTAIN) {
+			state_error = -EUCLEAN;
+			offset++;
+			mshv_user_loop_cond_resched(offset);
+			continue;
+		}
+		if (mshv_host_access_state_is_baseline(state)) {
+			offset++;
+			mshv_user_loop_cond_resched(offset);
+			continue;
+		}
+
+		flags = state & MSHV_HOST_ACCESS_EXCLUSIVE ?
+			HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED : 0;
+		/* One call may cover only pages with identical restore state. */
+		for (count = 1; offset + count < region->nr_pages; count++) {
+			u8 next = mshv_region_host_access_get(region,
+							      offset + count);
+
+			if (next != state)
+				break;
+			mshv_user_loop_cond_resched(count);
+		}
+
+		ret = mshv_region_process_range(region, flags, offset, count,
+						mshv_region_chunk_share);
+		if (ret)
+			return ret;
+		offset += count;
+	}
+	return state_error;
 }
 
 static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
-				     u32 flags,
-				     u64 page_offset, u64 page_count,
-				     bool huge_page)
+				     u32 flags, u64 page_offset,
+				     u64 page_count, bool huge_page)
 {
-	if (huge_page)
-		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
-
-	return hv_call_modify_spa_host_access(region->partition->pt_id,
-					      region->mreg_pages + page_offset,
-					      page_count, 0,
-					      flags, false);
+	return mshv_region_modify_host_access(region, flags, page_offset,
+					      page_count, huge_page, 0, false);
 }
 
 int mshv_region_unshare(struct mshv_mem_region *region)
 {
 	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
 
-	return mshv_region_process_range(region, flags,
-					 0, region->nr_pages,
+	return mshv_region_process_range(region, flags, 0, region->nr_pages,
 					 mshv_region_chunk_unshare);
 }
 
@@ -373,12 +663,14 @@ static void mshv_region_destroy(struct kref *ref)
 		container_of(ref, struct mshv_mem_region, mreg_refcount);
 
 	/* Callers must retain the list reference until cleanup is certain. */
-	if (WARN_ON_ONCE(region->mapping_may_exist))
+	if (WARN_ON_ONCE(region->mapping_may_exist ||
+			 !mshv_region_host_access_is_baseline(region)))
 		return;
 
 	if (region->mreg_type == MSHV_REGION_TYPE_MEM_MOVABLE)
 		mshv_region_movable_fini(region);
 
+	kvfree(region->host_access_read);
 	mshv_region_invalidate(region);
 	vfree(region);
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 78508b57b5ad..f27a6c119c3d 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -91,6 +91,15 @@ struct mshv_mem_region {
 	u32 hv_map_flags;
 	/* True until a checked hypervisor unmap has completed. */
 	bool mapping_may_exist;
+	/*
+	 * SNP host access is tracked per 4K page. The four bitmaps are one
+	 * contiguous allocation rooted at host_access_read.
+	 */
+	unsigned long *host_access_read;
+	unsigned long *host_access_write;
+	unsigned long *host_access_exclusive;
+	unsigned long *host_access_uncertain;
+	u64 host_nonbaseline_pages;
 	struct mshv_partition *partition;
 	enum mshv_region_type mreg_type;
 	struct mmu_interval_notifier mreg_mni;
@@ -101,6 +110,49 @@ struct mshv_mem_region {
 	struct page *mreg_pages[];
 };
 
+enum mshv_host_access_state {
+	MSHV_HOST_ACCESS_READ = BIT(0),
+	MSHV_HOST_ACCESS_WRITE = BIT(1),
+	MSHV_HOST_ACCESS_EXCLUSIVE = BIT(2),
+	MSHV_HOST_ACCESS_UNCERTAIN = BIT(3),
+};
+
+#define MSHV_HOST_ACCESS_BASELINE \
+	(MSHV_HOST_ACCESS_READ | MSHV_HOST_ACCESS_WRITE)
+
+#define MSHV_USER_PAGE_BATCH_SIZE	4096
+#define MSHV_USER_LOOP_RESCHED_INTERVAL	1024
+
+static inline void mshv_user_loop_cond_resched(u64 completed)
+{
+	if (IS_ALIGNED(completed, MSHV_USER_LOOP_RESCHED_INTERVAL))
+		cond_resched();
+}
+
+struct mshv_host_access_page {
+	struct page *page;
+	struct mshv_mem_region *region;
+	u64 index;
+};
+
+struct mshv_host_access_result {
+	u64 completed;
+	int error;
+	bool uncertain;
+};
+
+enum mshv_snp_teardown_phase {
+	MSHV_SNP_TEARDOWN_UNMAP,
+	MSHV_SNP_TEARDOWN_ISOLATION,
+	MSHV_SNP_TEARDOWN_RESTORE,
+};
+
+struct mshv_snp_teardown_ops {
+	int (*unmap)(void *data);
+	int (*isolation)(void *data);
+	int (*restore)(void *data);
+};
+
 struct mshv_irq_ack_notifier {
 	struct hlist_node link;
 	unsigned int irq_ack_gsi;
@@ -164,6 +216,12 @@ do { \
 #define pt_crit(p, fmt, ...)	pt_devprintk(crit, p, fmt, ##__VA_ARGS__)
 #define pt_alert(p, fmt, ...)	pt_devprintk(alert, p, fmt, ##__VA_ARGS__)
 #define pt_err(p, fmt, ...)	pt_devprintk(err, p, fmt, ##__VA_ARGS__)
+#define pt_err_ratelimited(p, fmt, ...) \
+do { \
+	const struct mshv_partition *__pt = (p); \
+	dev_err_ratelimited(__pt->pt_module_dev, pt_fmt(fmt), __pt->pt_id, \
+			    ##__VA_ARGS__); \
+} while (0)
 #define pt_warn(p, fmt, ...)	pt_devprintk(warn, p, fmt, ##__VA_ARGS__)
 #define pt_notice(p, fmt, ...)	pt_devprintk(notice, p, fmt, ##__VA_ARGS__)
 #define pt_info(p, fmt, ...)	pt_devprintk(info, p, fmt, ##__VA_ARGS__)
@@ -338,8 +396,17 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 			struct hv_stats_page *page_addr,
 			const union hv_stats_object_identity *identity);
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
-				   u32 flags, u8 acquire);
+				   u64 page_struct_count, u64 *completed_pages,
+				   bool *completion_uncertain,
+				   u32 host_access, u32 flags, bool acquire);
+void mshv_modify_host_access(u64 partition_id, struct page **pages,
+			     u64 page_count, u32 host_access, u32 flags,
+			     bool acquire, struct mshv_host_access_result *result);
+int mshv_validate_host_access_flags(u32 flags, bool acquire);
+u64 mshv_host_access_partition_id(u64 partition_id, u32 flags);
+int mshv_repcomp_to_page_count(u64 repcomp, u64 rep_count,
+			       unsigned int page_shift,
+			       u64 *completed_pages);
 int hv_call_get_partition_property_ex(u64 partition_id, u64 property_code, u64 arg,
 				      void *property_value, size_t property_value_sz);
 
@@ -376,6 +443,24 @@ extern u8 * __percpu *hv_synic_eventring_tail;
 
 struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 					   u64 uaddr, u32 flags);
+int mshv_region_host_access_init(struct mshv_mem_region *region);
+int mshv_region_check_duplicate_pfns(struct mshv_mem_region *region);
+u8 mshv_region_host_access_get(const struct mshv_mem_region *region, u64 index);
+void mshv_region_host_access_set(struct mshv_mem_region *region, u64 index,
+				 u8 state);
+u8 mshv_make_host_access_state(u8 old_state, u32 host_access, u32 flags);
+int mshv_apply_region_host_access(struct mshv_mem_region *region,
+				  u64 index, u64 count, u32 host_access,
+				  u32 flags,
+				  struct mshv_host_access_result *result);
+int mshv_apply_host_access(struct mshv_host_access_page *host_pages,
+			   u64 count, u32 host_access, u32 flags,
+			   struct mshv_host_access_result *result);
+bool mshv_region_host_access_is_baseline(const struct mshv_mem_region *region);
+int mshv_validate_modify_gpa_page_count(u64 page_count);
+bool mshv_u64_array_has_duplicates(u64 *values, u64 count);
+int mshv_run_snp_teardown(const struct mshv_snp_teardown_ops *ops, void *data,
+			  enum mshv_snp_teardown_phase *failed_phase);
 int mshv_region_share(struct mshv_mem_region *region);
 int mshv_region_unshare(struct mshv_mem_region *region);
 int mshv_region_map(struct mshv_mem_region *region);
@@ -388,6 +473,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gfn);
 void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void *, u64 *),
+				   void *completion_data);
+
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages, u64 *completed_pages,
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index cb5727529355..5d0f2f6cd104 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -1046,6 +1046,42 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 
 #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
 
+int hv_call_set_partition_property(u64 partition_id, u64 property_code,
+				   u64 property_value,
+				   void (*completion_handler)(void *, u64 *),
+				   void *completion_data)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_set_partition_property *input;
+
+	if (!completion_handler) {
+		pr_err("%s: Missing completion handler\n", __func__);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	input->property_value = property_value;
+	status = hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input, NULL);
+	local_irq_restore(flags);
+
+	if (unlikely(hv_result(status) == HV_STATUS_CALL_PENDING))
+		completion_handler(completion_data, &status);
+
+	if (!hv_result_success(status)) {
+		pr_err_ratelimited("%s: %s\n", __func__,
+				   hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	return 0;
+}
+
 int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
 				  u64 num_pages, u64 *completed_pages,
 				  enum hv_isolated_page_type page_type,
@@ -1191,20 +1227,55 @@ int hv_call_issue_psp_guest_request(u64 partition_id, u64 req_pfn,
 }
 #endif
 
+int mshv_validate_host_access_flags(u32 flags, bool acquire)
+{
+	if ((flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE) &&
+	    (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED))
+		return -EINVAL;
+	if ((acquire &&
+	     (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)) ||
+	    (!acquire &&
+	     (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED)))
+		return -EINVAL;
+	return 0;
+}
+
+u64 mshv_host_access_partition_id(u64 partition_id, u32 flags)
+{
+	return flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE ?
+		partition_id : 0;
+}
+
+int mshv_repcomp_to_page_count(u64 repcomp, u64 rep_count,
+			       unsigned int page_shift,
+			       u64 *completed_pages)
+{
+	if (repcomp > rep_count)
+		return -EPROTO;
+	if (check_shl_overflow(repcomp, page_shift, completed_pages))
+		return -EOVERFLOW;
+	return 0;
+}
+
 int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
-				   u64 page_struct_count, u32 host_access,
-				   u32 flags, u8 acquire)
+				   u64 page_struct_count, u64 *completed_pages,
+				   bool *completion_uncertain,
+				   u32 host_access, u32 flags, bool acquire)
 {
 	struct hv_input_modify_sparse_spa_page_host_access *input_page;
 	u64 status;
-	int done = 0;
+	u64 done = 0;
+	u64 completed_4k;
 	unsigned long irq_flags, large_shift = 0;
+	int ret;
 	u64 page_count = page_struct_count;
 	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
 			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
 
-	if (page_count == 0)
+	if (!page_count || !completed_pages || !completion_uncertain)
 		return -EINVAL;
+	*completed_pages = 0;
+	*completion_uncertain = false;
 
 	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
 		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
@@ -1213,31 +1284,34 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		page_count >>= large_shift;
 	}
 
+	ret = mshv_validate_host_access_flags(flags, acquire);
+	if (ret)
+		return ret;
+
 	while (done < page_count) {
-		ulong i, completed, remain = page_count - done;
-		int rep_count = min(remain,
-				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
+		u64 i, completed, remain = page_count - done;
+		unsigned int rep_count = min_t(u64, remain,
+			HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
 
 		local_irq_save(irq_flags);
 		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
 		memset(input_page, 0, sizeof(*input_page));
-		/* Only set the partition id if you are making the pages
-		 * exclusive
-		 */
+		/* ACQUIRE and permission-only RELEASE require partition_id zero. */
 		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
-			input_page->partition_id = partition_id;
+			input_page->partition_id =
+				mshv_host_access_partition_id(partition_id, flags);
 		input_page->flags = flags;
 		input_page->host_access = host_access;
 
 		for (i = 0; i < rep_count; i++) {
 			u64 index = (done + i) << large_shift;
 
-			if (index >= page_struct_count)
+			if (index >= page_struct_count) {
+				local_irq_restore(irq_flags);
 				return -EINVAL;
-
+			}
 			input_page->spa_page_list[i] =
-						page_to_pfn(pages[index]);
+				page_to_pfn(pages[index]);
 		}
 
 		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
@@ -1245,12 +1319,40 @@ int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
-
-		if (!hv_result_success(status))
-			return hv_result_to_errno(status);
+		ret = mshv_repcomp_to_page_count(completed, rep_count, large_shift, &completed_4k);
+		if (ret) {
+			*completion_uncertain = true;
+			pr_err_ratelimited("%s: invalid completion count %llu/%u\n",
+					   __func__, completed, rep_count);
+			return ret;
+		}
 
 		done += completed;
+		*completed_pages += completed_4k;
+		if (!hv_result_success(status)) {
+			pr_err_ratelimited("%s: completed %llu of %llu pages: %s\n",
+					   __func__, *completed_pages,
+					   page_struct_count,
+					   hv_result_to_string(status));
+			return hv_result_to_errno(status);
+		}
+		if (!completed) {
+			*completion_uncertain = true;
+			return -EPROTO;
+		}
+		cond_resched();
 	}
 
 	return 0;
 }
+
+void mshv_modify_host_access(u64 partition_id, struct page **pages,
+			     u64 page_count, u32 host_access, u32 flags,
+			     bool acquire, struct mshv_host_access_result *result)
+{
+	result->error = hv_call_modify_spa_host_access(partition_id, pages,
+						       page_count,
+						       &result->completed,
+						       &result->uncertain,
+						       host_access, flags, acquire);
+}
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index de6519ac677b..8db975571992 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -20,6 +20,8 @@
 #include <linux/io.h>
 #include <linux/cpuhotplug.h>
 #include <linux/random.h>
+#include <linux/sched/signal.h>
+#include <linux/sort.h>
 #include <asm/mshyperv.h>
 #include <linux/hyperv.h>
 #include <linux/notifier.h>
@@ -642,6 +644,74 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int
+mshv_gpfns_to_host_pages(struct mshv_partition *partition, const u64 *gpfns,
+			 u64 page_count,
+			 struct mshv_host_access_page *host_pages)
+{
+	struct mshv_mem_region *region;
+	u64 i;
+	int ret = 0;
+
+	for (i = 0; i < page_count; i++) {
+		u64 offset;
+
+		region = mshv_partition_region_by_gfn_get(partition, gpfns[i]);
+		if (!region) {
+			pt_err_ratelimited(partition,
+					   "Failed to find region for GFN %#llx\n",
+					   gpfns[i]);
+			ret = -ERANGE;
+			goto put_pages;
+		}
+
+		offset = gpfns[i] - region->start_gfn;
+		mutex_lock(&region->mreg_mutex);
+		if (region->mreg_type != MSHV_REGION_TYPE_MEM_PINNED ||
+		    !region->host_access_read || offset >= region->nr_pages ||
+		    !region->mreg_pages[offset]) {
+			ret = -EFAULT;
+			mutex_unlock(&region->mreg_mutex);
+			mshv_region_put(region);
+			goto put_pages;
+		}
+
+		host_pages[i].page = region->mreg_pages[offset];
+		host_pages[i].region = region;
+		host_pages[i].index = offset;
+		mutex_unlock(&region->mreg_mutex);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	return 0;
+
+put_pages:
+	while (i) {
+		i--;
+		mshv_region_put(host_pages[i].region);
+		mshv_user_loop_cond_resched(page_count - i);
+	}
+	return ret;
+}
+
+static void mshv_host_pages_put(struct mshv_host_access_page *host_pages,
+				u64 page_count)
+{
+	u64 i;
+
+	for (i = 0; i < page_count; i++) {
+		mshv_region_put(host_pages[i].region);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+}
+
+static u8 mshv_host_page_state(const struct mshv_host_access_page *host_page)
+{
+	return mshv_region_host_access_get(host_page->region, host_page->index);
+}
+
+#endif
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -1214,12 +1284,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 static int mshv_init_async_handler(struct mshv_partition *partition)
 {
-	if (completion_done(&partition->async_hypercall)) {
-		pt_err(partition,
-		       "Cannot issue async hypercall while another one in progress!\n");
-		return -EPERM;
-	}
-
+	/* Partition ioctls are serialized by pt_mutex. */
 	reinit_completion(&partition->async_hypercall);
 	return 0;
 }
@@ -1297,66 +1362,82 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 
 	ret = mshv_region_pin(region);
 	if (ret) {
-		pt_err(partition, "Failed to pin memory region: %d\n",
-		       ret);
-		goto err_out;
+		pt_err(partition, "Failed to pin memory region: %d\n", ret);
+		return ret;
 	}
 
-	/*
-	 * For an SNP partition it is a requirement that for every memory region
-	 * that we are going to map for this partition we should make sure that
-	 * host access to that region is released. This is ensured by doing an
-	 * additional hypercall which will update the SLAT to release host
-	 * access to guest memory regions.
-	 */
 	if (mshv_partition_encrypted(partition)) {
-		ret = mshv_region_unshare(region);
+		int recovery_ret;
+
+		ret = mshv_region_host_access_init(region);
+		if (ret)
+			goto invalidate_region;
+
+		ret = mshv_region_check_duplicate_pfns(region);
 		if (ret) {
-			pt_err(partition,
-			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
-			       region->start_gfn, ret);
+			if (ret == -EEXIST)
+				pt_err_ratelimited(partition,
+						   "Duplicate pinned PFN\n");
+			else
+				pt_err_ratelimited(partition,
+						   "Pinned PFN audit failed: %d\n",
+						   ret);
 			goto invalidate_region;
 		}
-	}
 
-	ret = mshv_region_map(region);
-	if (ret) {
-		int shrc;
-
-		/* A partial map must be removed before host access is restored. */
-		if (region->mapping_may_exist) {
-			int cleanup_ret = mshv_region_unmap(region);
-
-			if (cleanup_ret || region->mapping_may_exist) {
+		ret = mshv_region_unshare(region);
+		if (ret) {
+			pt_err_ratelimited(partition,
+					   "Failed to release host access at GFN %#llx: %d\n",
+					   region->start_gfn, ret);
+			recovery_ret = mshv_region_share(region);
+			if (recovery_ret ||
+			    !mshv_region_host_access_is_baseline(region)) {
 				pt_err(partition,
-				       "Failed to clean up mapping at GFN %#llx after map failure: %d; retaining region\n",
-				       region->start_gfn, cleanup_ret);
+				       "Failed to recover exact host access at GFN %#llx: %d; retaining region\n",
+				       region->start_gfn, recovery_ret);
 				return ret;
 			}
+			goto invalidate_region;
 		}
+	}
 
-		if (!mshv_partition_encrypted(partition))
-			return ret;
+	ret = mshv_region_map(region);
+	if (!ret)
+		return 0;
 
-		shrc = mshv_region_share(region);
-		if (!shrc)
-			goto invalidate_region;
+	/* A partial map must be removed before host access is reacquired. */
+	if (region->mapping_may_exist) {
+		int cleanup_ret = mshv_region_unmap(region);
 
-		pt_err(partition,
-		       "Failed to share memory region (guest_pfn: %llu): %d\n",
-		       region->start_gfn, shrc);
-		/*
-		 * Do not unpin if restoring host access failed because the
-		 * pages are no longer mapped in the host.
-		 */
-		goto err_out;
+		if (cleanup_ret || region->mapping_may_exist) {
+			pt_err(partition,
+			       "Failed to clean up mapping at GFN %#llx after map failure: %d; retaining region\n",
+			       region->start_gfn, cleanup_ret);
+			return ret;
+		}
 	}
 
-	return 0;
+	if (mshv_partition_encrypted(partition) &&
+	    !mshv_region_host_access_is_baseline(region)) {
+		int recovery_ret = mshv_region_share(region);
+
+		if (recovery_ret ||
+		    !mshv_region_host_access_is_baseline(region)) {
+			pt_err(partition,
+			       "Failed to recover exact host access after map failure at GFN %#llx: %d; retaining region\n",
+			       region->start_gfn, recovery_ret);
+			return ret;
+		}
+	}
 
 invalidate_region:
+	kvfree(region->host_access_read);
+	region->host_access_read = NULL;
+	region->host_access_write = NULL;
+	region->host_access_exclusive = NULL;
+	region->host_access_uncertain = NULL;
 	mshv_region_invalidate(region);
-err_out:
 	return ret;
 }
 
@@ -1450,7 +1531,8 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		mutex_unlock(&region->mreg_mutex);
 		if (!mapping_may_exist)
 			goto put_region;
-	} else if (!region->mapping_may_exist) {
+	} else if (!region->mapping_may_exist &&
+		   mshv_region_host_access_is_baseline(region)) {
 		goto put_region;
 	}
 
@@ -1458,7 +1540,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
 	spin_unlock(&partition->pt_mem_regions_lock);
 	pt_err(partition,
-	       "Retaining region after uncertain map cleanup at GFN %#llx\n",
+	       "Retaining region with uncertain ownership at GFN %#llx\n",
 	       region->start_gfn);
 	mshv_quarantine_partition(partition);
 	return ret;
@@ -1478,6 +1560,8 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 
 	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
 		return -EINVAL;
+	if (partition->pt_initialized && mshv_partition_encrypted(partition))
+		return -EBUSY;
 
 	/*
 	 * The list owns one reference. Take a temporary reference and detach
@@ -1510,6 +1594,17 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	if (ret)
 		goto restore_region;
 
+	if (!mshv_region_host_access_is_baseline(region)) {
+		ret = mshv_region_share(region);
+		if (ret || !mshv_region_host_access_is_baseline(region)) {
+			pt_err_ratelimited(partition,
+					   "Failed to restore host access at GFN %#llx: %ld\n",
+					   region->start_gfn, ret);
+			mshv_quarantine_partition(partition);
+			goto retain_blocked;
+		}
+	}
+
 	mutex_unlock(&region->mreg_mutex);
 	up_write(&region->mreg_fault_lock);
 
@@ -1532,6 +1627,15 @@ mshv_unmap_user_memory(struct mshv_partition *partition,
 	mshv_region_put(region);
 	return ret;
 
+retain_blocked:
+	/* Keep list ownership for quarantined teardown, but forbid remapping. */
+	spin_lock(&partition->pt_mem_regions_lock);
+	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+	spin_unlock(&partition->pt_mem_regions_lock);
+	mutex_unlock(&region->mreg_mutex);
+	up_write(&region->mreg_fault_lock);
+	mshv_region_put(region);
+	return ret;
 }
 
 static long
@@ -1722,6 +1826,612 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int set_sev_control_register(struct mshv_vp *vp,
+				    u64 enable_encrypted_state,
+				    u64 vmsa_gpa_page_number)
+{
+	struct hv_register_assoc sev_control = {
+		.name = HV_X64_REGISTER_SEV_CONTROL,
+	};
+
+	sev_control.value.sev_control.enable_encrypted_state =
+		enable_encrypted_state;
+	sev_control.value.sev_control.vmsa_gpa_page_number =
+		vmsa_gpa_page_number;
+
+	return mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+					 1, &sev_control);
+}
+
+static long
+mshv_partition_ioctl_sev_snp_ap_create(struct mshv_partition *partition,
+				       void __user *user_args)
+{
+	struct hv_register_assoc internal_activity = {
+		.name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+		.value.internal_activity.as_uint64 = 0,
+	};
+	struct mshv_sev_snp_ap_create req;
+	struct mshv_vp *vp;
+	long ret;
+
+	if (copy_from_user(&req, user_args, sizeof(req)))
+		return -EFAULT;
+
+	if (req.vp_id >= MSHV_MAX_VPS ||
+	    !IS_ALIGNED(req.vmsa_gpa, MSHV_HV_PAGE_SIZE))
+		return -EINVAL;
+
+	vp = partition->pt_vp_array[req.vp_id];
+	if (!vp)
+		return -EINVAL;
+
+	ret = set_sev_control_register(vp, 1, HVPFN_DOWN(req.vmsa_gpa));
+	if (ret) {
+		vp_err(vp, "Failed to set SEV control register\n");
+		return ret;
+	}
+
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id, 1,
+				    &internal_activity);
+	if (ret)
+		vp_err(vp, "Failed to set internal activity\n");
+
+	return ret;
+}
+
+static int mshv_u64_cmp(const void *lhs, const void *rhs)
+{
+	u64 a = *(const u64 *)lhs;
+	u64 b = *(const u64 *)rhs;
+
+	return (a > b) - (a < b);
+}
+
+static bool
+mshv_host_pages_are_valid_2m(const u64 *gpfns,
+			     const struct mshv_host_access_page *host_pages,
+			     u64 page_count)
+{
+	const u64 pages_per_large_page =
+		1ULL << (HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT);
+	u64 i, j;
+
+	if (!IS_ALIGNED(page_count, pages_per_large_page))
+		return false;
+
+	for (i = 0; i < page_count; i += pages_per_large_page) {
+		u64 base_pfn = page_to_pfn(host_pages[i].page);
+
+		if (!IS_ALIGNED(gpfns[i], pages_per_large_page) ||
+		    !IS_ALIGNED(base_pfn, pages_per_large_page))
+			return false;
+		for (j = 1; j < pages_per_large_page; j++) {
+			if (gpfns[i + j] != gpfns[i] + j ||
+			    page_to_pfn(host_pages[i + j].page) != base_pfn + j)
+				return false;
+			mshv_user_loop_cond_resched(i + j + 1);
+		}
+	}
+	return true;
+}
+
+int mshv_validate_modify_gpa_page_count(u64 page_count)
+{
+	if (!page_count)
+		return -EINVAL;
+	if (page_count > MSHV_MODIFY_GPA_HOST_ACCESS_MAX_PAGES)
+		return -E2BIG;
+	return 0;
+}
+
+bool mshv_u64_array_has_duplicates(u64 *values, u64 count)
+{
+	u64 i;
+
+	sort_nonatomic(values, count, sizeof(*values), mshv_u64_cmp, NULL);
+	for (i = 1; i < count; i++) {
+		if (values[i - 1] == values[i])
+			return true;
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	return false;
+}
+
+static long
+mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *partition,
+					    void __user *user_args)
+{
+	struct mshv_modify_gpa_host_access args;
+	struct mshv_host_access_page *host_pages = NULL;
+	struct page **pages = NULL;
+	u64 __user *guest_gpas;
+	u64 *duplicates = NULL;
+	u64 *gpfns = NULL;
+	u64 input_completed;
+	u64 offset = 0;
+	u32 host_access = 0;
+	u32 flags = 0;
+	bool acquire;
+	long ret = 0;
+	u64 i;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	input_completed = args.completed;
+	args.completed = 0;
+	ret = mshv_validate_modify_gpa_page_count(args.page_count);
+	if (ret)
+		goto out;
+	if ((args.flags & ~MSHV_GPA_HOST_ACCESS_FLAGS_MASK) ||
+	    mshv_field_nonzero(args, rsvd) || input_completed ||
+	    !args.guest_gpas) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	guest_gpas = u64_to_user_ptr(args.guest_gpas);
+	gpfns = vmemdup_array_user(guest_gpas, args.page_count,
+				   sizeof(*gpfns));
+	if (IS_ERR(gpfns)) {
+		ret = PTR_ERR(gpfns);
+		gpfns = NULL;
+		goto out;
+	}
+	host_pages = kvmalloc_array(args.page_count, sizeof(*host_pages),
+				    GFP_KERNEL);
+	duplicates = kvmalloc_array(args.page_count, sizeof(*duplicates),
+				    GFP_KERNEL);
+	pages = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*pages),
+			       GFP_KERNEL);
+	if (!host_pages || !duplicates || !pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < args.page_count; i++) {
+		if (!IS_ALIGNED(gpfns[i], MSHV_HV_PAGE_SIZE)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		gpfns[i] = HVPFN_DOWN(gpfns[i]);
+		duplicates[i] = gpfns[i];
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	if (mshv_u64_array_has_duplicates(duplicates, args.page_count)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = mshv_gpfns_to_host_pages(partition, gpfns, args.page_count,
+				       host_pages);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < args.page_count; i++) {
+		duplicates[i] = page_to_pfn(host_pages[i].page);
+		mshv_user_loop_cond_resched(i + 1);
+	}
+	if (mshv_u64_array_has_duplicates(duplicates, args.page_count)) {
+		ret = -EINVAL;
+		goto out_put_pages;
+	}
+
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE)) {
+		if (!mshv_host_pages_are_valid_2m(gpfns, host_pages,
+						  args.page_count)) {
+			ret = -EINVAL;
+			goto out_put_pages;
+		}
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+	}
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_READABLE))
+		host_access |= HV_MAP_GPA_READABLE;
+	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_WRITABLE))
+		host_access |= HV_MAP_GPA_WRITABLE;
+	acquire = args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_ACQUIRE);
+
+	while (offset < args.page_count) {
+		struct mshv_host_access_result result = {};
+		u64 count = min_t(u64, args.page_count - offset,
+				  MSHV_USER_PAGE_BATCH_SIZE);
+
+		for (i = 0; i < count; i++)
+			pages[i] = host_pages[offset + i].page;
+
+		mshv_modify_host_access(partition->pt_id, pages, count,
+					host_access, flags, acquire, &result);
+		ret = mshv_apply_host_access(host_pages + offset, count,
+					     host_access, flags, &result);
+		if (result.uncertain)
+			mshv_quarantine_partition(partition);
+		offset += result.completed;
+		if (ret)
+			break;
+		cond_resched();
+	}
+
+out_put_pages:
+	mshv_host_pages_put(host_pages, args.page_count);
+out:
+	args.completed = offset;
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		if (offset)
+			mshv_quarantine_partition(partition);
+		ret = -EFAULT;
+	}
+	kvfree(pages);
+	kvfree(duplicates);
+	kvfree(host_pages);
+	kvfree(gpfns);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partition,
+					   void __user *user_args)
+{
+	struct mshv_import_isolated_pages args;
+	u64 __user *guest_pfns;
+	u64 *pages = NULL;
+	u64 input_completed;
+	u64 offset = 0;
+	long ret = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	input_completed = args.completed;
+	args.completed = 0;
+	if (args.page_type >= MSHV_ISOLATED_PAGE_COUNT ||
+	    args.page_size >= MSHV_ISOLATED_PAGE_SIZE_COUNT ||
+	    mshv_field_nonzero(args, rsvd) || input_completed ||
+	    !args.page_count || !args.guest_pfns) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	guest_pfns = u64_to_user_ptr(args.guest_pfns);
+	pages = kvmalloc_array(MSHV_USER_PAGE_BATCH_SIZE, sizeof(*pages),
+			       GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	while (offset < args.page_count) {
+		u64 count = min_t(u64, args.page_count - offset,
+				  MSHV_USER_PAGE_BATCH_SIZE);
+		u64 completed = 0;
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		if (copy_from_user(pages, guest_pfns + offset,
+				   array_size(count, sizeof(*pages)))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (args.page_size == MSHV_ISOLATED_PAGE_SIZE_2MB) {
+			u64 i;
+
+			for (i = 0; i < count; i++) {
+				if (!IS_ALIGNED(pages[i],
+						1ULL <<
+						(HV_HYP_LARGE_PAGE_SHIFT -
+						 HV_HYP_PAGE_SHIFT))) {
+					ret = -EINVAL;
+					goto out;
+				}
+				mshv_user_loop_cond_resched(i + 1);
+			}
+		}
+
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			break;
+
+		ret = hv_call_import_isolated_pages(partition->pt_id, pages,
+						    count, &completed,
+						    args.page_type,
+						    args.page_size,
+						    mshv_async_hvcall_handler,
+						    partition);
+		if (completed > count) {
+			ret = -EPROTO;
+			completed = 0;
+		}
+		offset += completed;
+		if (ret) {
+			if (ret == -EPROTO)
+				mshv_quarantine_partition(partition);
+			break;
+		}
+		if (completed != count) {
+			ret = -EPROTO;
+			mshv_quarantine_partition(partition);
+			break;
+		}
+		cond_resched();
+	}
+
+out:
+	args.completed = offset;
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		if (offset)
+			mshv_quarantine_partition(partition);
+		ret = -EFAULT;
+	}
+	kvfree(pages);
+	return ret;
+}
+
+static void
+mshv_copy_snp_id_auth_info(struct hv_snp_id_auth_info *dst,
+			   const struct mshv_snp_id_auth_info *src)
+{
+	dst->id_key_algorithm = src->id_key_algorithm;
+	dst->auth_key_algorithm = src->auth_key_algorithm;
+	memcpy(dst->reserved0, src->reserved0, sizeof(dst->reserved0));
+	memcpy(dst->id_block_signature, src->id_block_signature,
+	       sizeof(dst->id_block_signature));
+	memcpy(dst->id_key, src->id_key, sizeof(dst->id_key));
+	memcpy(dst->reserved1, src->reserved1, sizeof(dst->reserved1));
+	memcpy(dst->id_key_signature, src->id_key_signature,
+	       sizeof(dst->id_key_signature));
+	memcpy(dst->author_key, src->author_key, sizeof(dst->author_key));
+}
+
+static long
+mshv_partition_ioctl_complete_isolated_import(struct mshv_partition *partition,
+					      void __user *user_args)
+{
+	union hv_partition_complete_isolated_import_data *import_data;
+	struct mshv_psp_launch_finish_data *psp;
+	struct mshv_complete_isolated_import args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+	if (!args.psp_parameters)
+		return -EINVAL;
+
+	psp = memdup_user(u64_to_user_ptr(args.psp_parameters), sizeof(*psp));
+	if (IS_ERR(psp))
+		return PTR_ERR(psp);
+	if (memchr_inv(psp->reserved, 0, sizeof(psp->reserved))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	import_data = kvzalloc(sizeof(*import_data), GFP_KERNEL);
+	if (!import_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(import_data->psp_parameters.id_block.launch_digest,
+	       psp->id_block.launch_digest,
+	       sizeof(psp->id_block.launch_digest));
+	memcpy(import_data->psp_parameters.id_block.family_id,
+	       psp->id_block.family_id, sizeof(psp->id_block.family_id));
+	memcpy(import_data->psp_parameters.id_block.image_id,
+	       psp->id_block.image_id, sizeof(psp->id_block.image_id));
+	import_data->psp_parameters.id_block.version = psp->id_block.version;
+	import_data->psp_parameters.id_block.guest_svn = psp->id_block.guest_svn;
+	import_data->psp_parameters.id_block.policy.as_uint64 =
+		psp->id_block.policy;
+	mshv_copy_snp_id_auth_info(&import_data->psp_parameters.id_auth_info,
+				   &psp->id_auth_info);
+	memcpy(import_data->psp_parameters.host_data, psp->host_data,
+	       sizeof(psp->host_data));
+	import_data->psp_parameters.id_block_enabled = psp->id_block_enabled;
+	import_data->psp_parameters.author_key_enabled = psp->author_key_enabled;
+
+	ret = mshv_init_async_handler(partition);
+	if (!ret)
+		ret = hv_call_complete_isolated_import(partition->pt_id,
+						       import_data,
+						       mshv_async_hvcall_handler,
+						       partition);
+	if (!ret)
+		partition->import_completed = true;
+
+	kvfree(import_data);
+out:
+	kfree(psp);
+	return ret;
+}
+
+static u32 mshv_host_access_to_hv(u8 state)
+{
+	u32 access = 0;
+
+	if (state & MSHV_HOST_ACCESS_READ)
+		access |= HV_MAP_GPA_READABLE;
+	if (state & MSHV_HOST_ACCESS_WRITE)
+		access |= HV_MAP_GPA_WRITABLE;
+	return access;
+}
+
+static int
+mshv_restore_psp_pages(struct mshv_partition *partition,
+		       struct mshv_host_access_page *host_pages,
+		       const u8 *original, const u8 *transitioned,
+		       u64 transitioned_count)
+{
+	int first_error = 0;
+	u64 i;
+
+	for (i = 0; i < transitioned_count; i++) {
+		struct mshv_host_access_page *host_page =
+			&host_pages[transitioned[i]];
+		struct mshv_host_access_result result = {};
+		struct page *page = host_page->page;
+		u32 current_access =
+			mshv_host_access_to_hv(mshv_host_page_state(host_page));
+		u32 original_access =
+			mshv_host_access_to_hv(original[transitioned[i]]);
+		bool acquire;
+		int ret;
+
+		if (current_access == original_access)
+			continue;
+		/* Restore permissions without changing the saved ownership. */
+		acquire = !!(original_access & ~current_access);
+
+		mshv_modify_host_access(partition->pt_id, &page, 1,
+					original_access, 0, acquire, &result);
+		ret = mshv_apply_host_access(host_page, 1, original_access, 0,
+					     &result);
+		if (ret && !first_error)
+			first_error = ret;
+	}
+	return first_error;
+}
+
+static long
+mshv_partition_ioctl_issue_psp_guest_request(struct mshv_partition *partition,
+					     void __user *user_args)
+{
+	struct mshv_issue_psp_guest_request req;
+	struct mshv_host_access_page host_pages[2];
+	struct page *transition_pages[2];
+	u8 transitioned[2];
+	u8 original[2];
+	struct mshv_host_access_result result = {};
+	u64 transitioned_count = 0;
+	u64 gpfns[2];
+	long ret;
+	u64 i;
+
+	if (copy_from_user(&req, user_args, sizeof(req)))
+		return -EFAULT;
+	if (!IS_ALIGNED(req.req_gpa, MSHV_HV_PAGE_SIZE) ||
+	    !IS_ALIGNED(req.rsp_gpa, MSHV_HV_PAGE_SIZE) ||
+	    req.req_gpa == req.rsp_gpa) {
+		pt_err_ratelimited(partition,
+				   "Invalid PSP request GPAs %#llx/%#llx\n",
+				   req.req_gpa, req.rsp_gpa);
+		return -EINVAL;
+	}
+
+	gpfns[0] = HVPFN_DOWN(req.req_gpa);
+	gpfns[1] = HVPFN_DOWN(req.rsp_gpa);
+	ret = mshv_gpfns_to_host_pages(partition, gpfns,
+				       ARRAY_SIZE(gpfns), host_pages);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(host_pages); i++) {
+		struct mshv_host_access_page *host_page = &host_pages[i];
+
+		original[i] = mshv_host_page_state(host_page);
+		if (original[i] & MSHV_HOST_ACCESS_UNCERTAIN) {
+			ret = -EIO;
+			mshv_quarantine_partition(partition);
+			goto out_put_pages;
+		}
+		if (!(original[i] &
+		      (MSHV_HOST_ACCESS_READ | MSHV_HOST_ACCESS_WRITE)))
+			continue;
+		transitioned[transitioned_count] = i;
+		transition_pages[transitioned_count] = host_pages[i].page;
+		transitioned_count++;
+	}
+
+	if (transitioned_count) {
+		struct mshv_host_access_page transition_host_pages[2];
+
+		for (i = 0; i < transitioned_count; i++)
+			transition_host_pages[i] = host_pages[transitioned[i]];
+
+		mshv_modify_host_access(partition->pt_id, transition_pages,
+					transitioned_count, 0, 0, false, &result);
+		ret = mshv_apply_host_access(transition_host_pages,
+					     transitioned_count, 0, 0, &result);
+		if (result.uncertain)
+			mshv_quarantine_partition(partition);
+		transitioned_count = result.completed;
+		if (ret)
+			goto restore_host_access;
+	}
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		goto restore_host_access;
+
+	ret = hv_call_issue_psp_guest_request(partition->pt_id, gpfns[0],
+					      gpfns[1],
+					      mshv_async_hvcall_handler,
+					      partition);
+	if (!ret) {
+		/*
+		 * The guest consumes the encrypted response while these pages stay
+		 * host-none; explicit access changes or teardown restore them later.
+		 */
+		goto out_put_pages;
+	}
+
+restore_host_access:
+	{
+		int restore_ret;
+
+		restore_ret = mshv_restore_psp_pages(partition, host_pages,
+						     original, transitioned,
+						     transitioned_count);
+		if (restore_ret) {
+			pt_err(partition,
+			       "Failed to restore exact PSP page access: %d\n",
+			       restore_ret);
+			mshv_quarantine_partition(partition);
+			if (!ret)
+				ret = restore_ret;
+		}
+	}
+out_put_pages:
+	mshv_host_pages_put(host_pages, ARRAY_SIZE(host_pages));
+	return ret;
+}
+
+static long mshv_partition_snp_ioctl(unsigned int ioctl,
+				     struct mshv_partition *partition,
+				     unsigned long arg)
+{
+	void __user *uarg = (void __user *)arg;
+
+	if (!mshv_partition_encrypted(partition)) {
+		pt_err(partition,
+		       "Ioctl(%u) not supported for non SEV-SNP partition\n",
+		       ioctl);
+		return -EOPNOTSUPP;
+	}
+
+	switch (ioctl) {
+	case MSHV_MODIFY_GPA_HOST_ACCESS:
+		return mshv_partition_ioctl_modify_gpa_host_access(partition,
+								   uarg);
+	case MSHV_IMPORT_ISOLATED_PAGES:
+		return mshv_partition_ioctl_import_isolated_pages(partition,
+								  uarg);
+	case MSHV_COMPLETE_ISOLATED_IMPORT:
+		return mshv_partition_ioctl_complete_isolated_import(partition,
+								     uarg);
+	case MSHV_ISSUE_PSP_GUEST_REQUEST:
+		return mshv_partition_ioctl_issue_psp_guest_request(partition,
+								    uarg);
+	case MSHV_SEV_SNP_AP_CREATE:
+		return mshv_partition_ioctl_sev_snp_ap_create(partition, uarg);
+	default:
+		return -ENOTTY;
+	}
+}
+#endif
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1763,6 +2473,15 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_ROOT_HVCALL:
 		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
 		break;
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	case MSHV_MODIFY_GPA_HOST_ACCESS:
+	case MSHV_IMPORT_ISOLATED_PAGES:
+	case MSHV_COMPLETE_ISOLATED_IMPORT:
+	case MSHV_ISSUE_PSP_GUEST_REQUEST:
+	case MSHV_SEV_SNP_AP_CREATE:
+		ret = mshv_partition_snp_ioctl(ioctl, partition, arg);
+		break;
+#endif
 	default:
 		ret = -ENOTTY;
 	}
@@ -1875,38 +2594,106 @@ remove_partition(struct mshv_partition *partition)
 	synchronize_rcu();
 }
 
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int destroy_snp_partition_state(struct mshv_partition *partition)
+{
+	struct hv_register_assoc explicit_suspend = {
+		.name = HV_REGISTER_EXPLICIT_SUSPEND,
+		.value.explicit_suspend.suspended = 1,
+	};
+	struct mshv_vp *vp;
+	int i, ret;
+
+	for (i = 0; i < MSHV_MAX_VPS; i++) {
+		vp = partition->pt_vp_array[i];
+		if (!vp)
+			continue;
+
+		ret = mshv_set_vp_registers(vp->vp_index,
+					    vp->vp_partition->pt_id, 1,
+					    &explicit_suspend);
+		if (ret) {
+			vp_err(vp, "Failed to set explicit suspend\n");
+			return ret;
+		}
+
+		ret = set_sev_control_register(vp, 0, 0);
+		if (ret) {
+			vp_err(vp, "Failed to clear SEV control register\n");
+			return ret;
+		}
+	}
+
+	if (partition->import_completed) {
+		union hv_partition_isolation_control isolation_control = {};
+
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			return ret;
+
+		ret = hv_call_set_partition_property(partition->pt_id,
+						     HV_PARTITION_PROPERTY_ISOLATION_CONTROL,
+					     isolation_control.as_uint64,
+					     mshv_async_hvcall_handler, partition);
+		if (ret) {
+			pt_err(partition, "Failed to clear runnable bit\n");
+			return ret;
+		}
+	}
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		return ret;
+
+	ret = hv_call_set_partition_property(partition->pt_id,
+					     HV_PARTITION_PROPERTY_ISOLATION_STATE,
+					     HV_PARTITION_ISOLATION_INSECURE_DIRTY,
+					     mshv_async_hvcall_handler, partition);
+	if (ret)
+		pt_err(partition,
+		       "Failed to set isolation state to INSECURE_DIRTY\n");
+
+	return ret;
+}
+#endif
+
 static void mshv_quarantine_partition(struct mshv_partition *partition)
 {
 	if (partition->teardown_quarantined)
 		return;
 
-	/* Retain both the partition and the cleanup code indefinitely. */
+	/* Retain the partition, pinned pages, and cleanup code indefinitely. */
 	__module_get(THIS_MODULE);
 	partition->teardown_quarantined = true;
 }
 
-/*
- * Tear down a partition and remove it from the list.
- * Partition's refcount must be 0
- */
-static void destroy_partition(struct mshv_partition *partition)
+int mshv_run_snp_teardown(const struct mshv_snp_teardown_ops *ops, void *data,
+			  enum mshv_snp_teardown_phase *failed_phase)
 {
-	struct mshv_vp *vp;
-	struct mshv_mem_region *region;
-	struct hlist_node *n;
-	int i;
+	int ret;
 
-	if (refcount_read(&partition->pt_ref_count)) {
-		pt_err(partition,
-		       "Attempt to destroy partition but refcount > 0\n");
-		return;
-	}
+	*failed_phase = MSHV_SNP_TEARDOWN_UNMAP;
+	ret = ops->unmap(data);
+	if (ret)
+		return ret;
 
-	trace_mshv_destroy_partition(partition->pt_id);
+	*failed_phase = MSHV_SNP_TEARDOWN_ISOLATION;
+	ret = ops->isolation(data);
+	if (ret)
+		return ret;
+
+	*failed_phase = MSHV_SNP_TEARDOWN_RESTORE;
+	return ops->restore(data);
+}
+
+static int mshv_partition_unmap_regions(void *data)
+{
+	struct mshv_partition *partition = data;
+	struct mshv_mem_region *region;
 
 	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
 		bool was_blocked;
-		int unmap_ret;
+		int ret;
 
 		/* Stop new lookup users before draining in-flight remappers. */
 		spin_lock(&partition->pt_mem_regions_lock);
@@ -1916,19 +2703,17 @@ static void destroy_partition(struct mshv_partition *partition)
 
 		down_write(&region->mreg_fault_lock);
 		mutex_lock(&region->mreg_mutex);
-		unmap_ret = mshv_region_unmap(region);
-		if (unmap_ret) {
+		ret = mshv_region_unmap(region);
+		if (ret) {
 			spin_lock(&partition->pt_mem_regions_lock);
 			WRITE_ONCE(region->faults_blocked, was_blocked);
 			spin_unlock(&partition->pt_mem_regions_lock);
 			mutex_unlock(&region->mreg_mutex);
 			up_write(&region->mreg_fault_lock);
-
 			pt_err(partition,
-			       "Failed to unmap region at GFN %#llx: %d; retaining partition\n",
-			       region->start_gfn, unmap_ret);
-			mshv_quarantine_partition(partition);
-			return;
+			       "Failed to unmap region at GFN %#llx: %d\n",
+			       region->start_gfn, ret);
+			return ret;
 		}
 		mutex_unlock(&region->mreg_mutex);
 		up_write(&region->mreg_fault_lock);
@@ -1937,6 +2722,92 @@ static void destroy_partition(struct mshv_partition *partition)
 			mshv_region_movable_fini(region);
 	}
 
+	return 0;
+}
+
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+static int mshv_partition_destroy_isolation(void *data)
+{
+	struct mshv_partition *partition = data;
+
+	if (!partition->pt_initialized)
+		return 0;
+	return destroy_snp_partition_state(partition);
+}
+
+static int mshv_partition_restore_host_access(void *data)
+{
+	struct mshv_partition *partition = data;
+	struct mshv_mem_region *region;
+	int ret;
+
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		if (mshv_region_host_access_is_baseline(region))
+			continue;
+		ret = mshv_region_share(region);
+		if (ret || !mshv_region_host_access_is_baseline(region)) {
+			pt_err(partition,
+			       "Failed to restore host access at GFN %#llx: %d\n",
+			       region->start_gfn, ret);
+			return ret ?: -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
+static const struct mshv_snp_teardown_ops mshv_snp_teardown_ops = {
+	.unmap = mshv_partition_unmap_regions,
+	.isolation = mshv_partition_destroy_isolation,
+	.restore = mshv_partition_restore_host_access,
+};
+#endif
+
+/*
+ * Tear down a partition and remove it from the list.
+ * Partition's refcount must be 0
+ */
+static void destroy_partition(struct mshv_partition *partition)
+{
+	struct mshv_vp *vp;
+	struct mshv_mem_region *region;
+	struct hlist_node *n;
+	bool memory_torn_down = false;
+	int ret;
+	int i;
+
+	if (refcount_read(&partition->pt_ref_count)) {
+		pt_err(partition,
+		       "Attempt to destroy partition but refcount > 0\n");
+		return;
+	}
+
+	trace_mshv_destroy_partition(partition->pt_id);
+
+#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
+	if (mshv_partition_encrypted(partition)) {
+		enum mshv_snp_teardown_phase failed_phase;
+
+		ret = mshv_run_snp_teardown(&mshv_snp_teardown_ops, partition,
+					    &failed_phase);
+		if (ret) {
+			if (failed_phase == MSHV_SNP_TEARDOWN_ISOLATION)
+				pt_err(partition,
+				       "Failed to destroy SNP isolation: %d\n",
+				       ret);
+			mshv_quarantine_partition(partition);
+			return;
+		}
+		memory_torn_down = true;
+	}
+#endif
+	if (!memory_torn_down) {
+		ret = mshv_partition_unmap_regions(partition);
+		if (ret) {
+			mshv_quarantine_partition(partition);
+			return;
+		}
+	}
+
 	if (partition->pt_initialized) {
 		/*
 		 * We only need to drain signals for root scheduler. This should be
@@ -1945,6 +2816,8 @@ static void destroy_partition(struct mshv_partition *partition)
 		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
 			drain_all_vps(partition);
 
+		remove_partition(partition);
+
 		/* Remove vps */
 		for (i = 0; i < MSHV_MAX_VPS; ++i) {
 			vp = partition->pt_vp_array[i];
@@ -1991,10 +2864,10 @@ static void destroy_partition(struct mshv_partition *partition)
 		hv_call_finalize_partition(partition->pt_id);
 
 		partition->pt_initialized = false;
+	} else {
+		remove_partition(partition);
 	}
 
-	remove_partition(partition);
-
 	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
 				  hnode) {
 		hlist_del_init(&region->hnode);
@@ -2087,7 +2960,7 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 		return -EFAULT;
 
 	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
-	    args.pt_isolation != MSHV_PT_ISOLATION_NONE)
+	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 		return -EINVAL;
 
 	disabled_procs = &cr_props->disabled_processor_features;
@@ -2100,7 +2973,7 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 
 		/* Re-validate v1 fields after second copy_from_user() */
 		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
-		    args.pt_isolation != MSHV_PT_ISOLATION_NONE)
+		    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 			return -EINVAL;
 
 		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
@@ -2164,6 +3037,9 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	case MSHV_PT_ISOLATION_NONE:
 		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
 		break;
+	case MSHV_PT_ISOLATION_SNP:
+		isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
+		break;
 	}
 
 	return 0;
@@ -2199,7 +3075,6 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 	mutex_init(&partition->pt_irq_lock);
 
 	init_completion(&partition->async_hypercall);
-
 	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
 
 	INIT_HLIST_HEAD(&partition->pt_devices);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index a53c0f59994a..5553d5c918a7 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -975,6 +975,7 @@ enum hv_register_name {
 	HV_REGISTER_EXPLICIT_SUSPEND				= 0x00000000,
 	HV_REGISTER_INTERCEPT_SUSPEND				= 0x00000001,
 	HV_REGISTER_DISPATCH_SUSPEND				= 0x00000003,
+	HV_REGISTER_INTERNAL_ACTIVITY_STATE			= 0x00000004,
 
 	/* Version - 128-bit result same as CPUID 0x40000002 */
 	HV_REGISTER_HYPERVISOR_VERSION				= 0x00000100,
@@ -1250,6 +1251,16 @@ union hv_arm64_pending_synthetic_exception_event {
 	} __packed;
 };
 
+union hv_internal_activity_register {
+	u64 as_uint64;
+	struct {
+		u64 startup_suspend : 1;
+		u64 halt_suspend : 1;
+		u64 idle_suspend : 1;
+		u64 rsvd_z : 61;
+	} __packed;
+};
+
 union hv_x64_interrupt_state_register {
 	u64 as_uint64;
 	struct {
@@ -1297,6 +1308,7 @@ union hv_register_value {
 	union hv_explicit_suspend_register explicit_suspend;
 	union hv_intercept_suspend_register intercept_suspend;
 	union hv_dispatch_suspend_register dispatch_suspend;
+	union hv_internal_activity_register internal_activity;
 #ifdef CONFIG_ARM64
 	union hv_arm64_interrupt_state_register interrupt_state;
 	union hv_arm64_pending_interruption_register pending_interruption;
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 9c665f47ce71..5b80ec9afbd6 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -231,6 +231,12 @@ enum {
 #define MSHV_GPA_HOST_ACCESS_FLAGS_MASK \
 	((1 << MSHV_GPA_HOST_ACCESS_BIT_COUNT) - 1)
 
+/*
+ * Maximum guest_gpas array entries. page_count is always a count of 4K
+ * pages, including LARGE_PAGE requests where each 2M group uses 512 entries.
+ */
+#define MSHV_MODIFY_GPA_HOST_ACCESS_MAX_PAGES	65536
+
 struct mshv_modify_gpa_host_access {
 	__u8 flags;
 	__u8 rsvd[7];
-- 
2.43.0

