Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92874C14;
	Sat, 12 Sep 2026 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171420; cv=none; b=dD8viqF/sM/rKJMSnjL+7iRRH9dFksDvPE2s93VDCBWwR64vUBKfJ0eIp4FDbVLYkzN9KQpVzl3jYVckQaQzttw9QVhdTxjplOLWgV0GQEMe6MrSB5VnPgHrcR0xcCgQ8Ap2QfSLvR8Ayv4tGLY2zF/JLuL56CUHz/wwNHHgnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171420; c=relaxed/simple;
	bh=Mt294p71DI4BZ0u8z7Z3x7X2CPaY1VAbkEQlw1QAXfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX2YfyTn8EBtSvqYa4p/7ljyQ6QjmmYFceWaeB6+eiWgZj9fXQRvyU++LzhB7klt6nnEIyq/myYqY5A/zUJbeXfHqs7BlfwMra/933zdlxMW/ghxxM8DCs48AzldXLBip2WZs50rPbyJ6eVV/Ron4F8xQTL8BUUj+JN/1CRWytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W7Wfdwml; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W7Wfdwml"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9750F20B716A;
	Fri, 11 Sep 2026 17:02:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9750F20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789171374;
	bh=B5d0o0fXN6uDKm28l8fppnurj3UFuA1lkh2v2wNdAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7Wfdwmlynan+8UCuJFR+2juMErp4zySvIxpxWDcB/ZSJzexcmNekavSUTpY8Z91b
	 JhwCAbujwkQXVsN9/9fwWr/OYqLVyNaSCRQ25IsfoazvBvfy8sql3LS5QWJks8Os2d
	 gkog1Ezp29dx1+JIlKwNn+LeBQMKqZBOFx/FlkVY=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V2 3/3] mshv: Remove unused *_old memory deposit functions
Date: Fri, 11 Sep 2026 17:03:18 -0700
Message-ID: <20260912000318.2959621-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
References: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the renamed *_old functions, done for ease of review.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_proc.c | 129 -------------------------------------------
 1 file changed, 129 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index df39a5c587ca..f811bb5c42a1 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -183,135 +183,6 @@ int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
-/*
- * See struct hv_deposit_memory. The first u64 is partition ID, the rest
- * are GPAs.
- */
-#define HV_DEPOSIT_MAX_OLD (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
-
-/* Deposits exact number of pages. Must be called with interrupts enabled.  */
-static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num_pages)
-{
-	struct page **pages, *page;
-	int *counts;
-	int num_allocations;
-	int i, j, page_count;
-	int order;
-	u64 status;
-	int ret;
-	u64 base_pfn;
-	struct hv_deposit_memory *input_page;
-	unsigned long flags;
-
-	if (num_pages > HV_DEPOSIT_MAX_OLD)
-		return -E2BIG;
-	if (!num_pages)
-		return 0;
-
-	/* One buffer for page pointers and counts */
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-	pages = page_address(page);
-
-	counts = kzalloc_objs(int, HV_DEPOSIT_MAX_OLD);
-	if (!counts) {
-		free_page((unsigned long)pages);
-		return -ENOMEM;
-	}
-
-	/* Allocate all the pages before disabling interrupts */
-	i = 0;
-
-	while (num_pages) {
-		/* Find highest order we can actually allocate */
-		order = 31 - __builtin_clz(num_pages);
-
-		while (1) {
-			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
-			if (pages[i])
-				break;
-			if (!order) {
-				ret = -ENOMEM;
-				num_allocations = i;
-				goto err_free_allocations;
-			}
-			--order;
-		}
-
-		split_page(pages[i], order);
-		counts[i] = 1 << order;
-		num_pages -= counts[i];
-		i++;
-	}
-	num_allocations = i;
-
-	local_irq_save(flags);
-
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	input_page->partition_id = partition_id;
-
-	/* Populate gpa_page_list - these will fit on the input page */
-	for (i = 0, page_count = 0; i < num_allocations; ++i) {
-		base_pfn = page_to_pfn(pages[i]);
-		for (j = 0; j < counts[i]; ++j, ++page_count)
-			input_page->gpa_page_list[page_count] = base_pfn + j;
-	}
-	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
-				     page_count, 0, input_page, NULL);
-	local_irq_restore(flags);
-	if (!hv_result_success(status)) {
-		hv_status_err(status, "\n");
-		ret = hv_result_to_errno(status);
-		goto err_free_allocations;
-	}
-
-	ret = 0;
-	goto free_buf;
-
-err_free_allocations:
-	for (i = 0; i < num_allocations; ++i) {
-		base_pfn = page_to_pfn(pages[i]);
-		for (j = 0; j < counts[i]; ++j)
-			__free_page(pfn_to_page(base_pfn + j));
-	}
-
-free_buf:
-	free_page((unsigned long)pages);
-	kfree(counts);
-	return ret;
-}
-
-static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id, u64 hv_status)
-{
-	u32 num_pages = 1;
-
-	switch (hv_result(hv_status)) {
-	case HV_STATUS_INSUFFICIENT_MEMORY:
-		break;
-	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
-		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
-		break;
-
-	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
-		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
-		fallthrough;
-	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
-		if (!hv_root_partition()) {
-			hv_status_err(hv_status, "Unexpected root memory deposit\n");
-			return -ENOMEM;
-		}
-		partition_id = HV_PARTITION_ID_SELF;
-		break;
-
-	default:
-		hv_status_err(hv_status, "Unexpected!\n");
-		return -ENOMEM;
-	}
-	return hv_call_deposit_pages_old(node, partition_id, num_pages);
-}
-
 bool hv_result_needs_memory(u64 status)
 {
 	switch (hv_result(status)) {
-- 
2.51.2.vfs.0.1

