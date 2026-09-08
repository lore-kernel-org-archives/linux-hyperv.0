Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD27331A56;
	Tue,  8 Sep 2026 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833637; cv=none; b=IClP+5T/OIITL+zB7pZC1+RGyaeQKcpMFhNEo2IHlBqNJNML+2xKg/xp9Lze9EPppA/ihE+4D9lK9fnfYYSzzXDfZL9xFXjvu2asUuFh7nDnIj2AxRaAjfapq1q8Zkl5ObGqeOrACfXkqbq7btKCrJLYepHvrvfU2EOek1VBACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833637; c=relaxed/simple;
	bh=bgC11ADyUT2qR2XTFMdrMQNAyr2QK1n7HlurnnjeKtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEni8aYyT3Tk35bAzPbFND6ns1+mEJfUgYsTT8BIQzghA+ITPHTf8qsSUFO2Rp5aAdKGpVH2JqpIxqF+yP6I5ImPXy5UgraUrjdZcfyKbJ06StJBix9UoL0/2nx4gjFDWC/ePwlTZCGGR9gsrzfrQGrTvcF9KP9YNZA/ANlPiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WJCkTNB9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WJCkTNB9"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 735EA20B7001;
	Mon,  7 Sep 2026 19:13:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 735EA20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788833596;
	bh=r052JvtVOfdMBLZT7qlDdXdnY3xSoimEYtLMcJ/0mjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJCkTNB9DSRvu5kKQuFpEO5/2dPLsclT09o+hYN4F6i/irlLEFGetchrVwyZm73wz
	 9GTsrkARa58tD5ASNxaIALOUjFciP64G2loo5plSnQTcBPgyLbQ+m6/buyc3AbvNXQ
	 v6he6jenBT8GO+yCrwWaK4dT1/BM5ilDRy2Gp6UQ=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V1 3/3] mshv: Remove unused *_old memory deposit functions
Date: Mon,  7 Sep 2026 19:13:40 -0700
Message-ID: <20260908021340.2548924-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
References: <20260908021340.2548924-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the renamed *_old functions.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/hv_proc.c | 129 -------------------------------------------
 1 file changed, 129 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 0ebede0bc8b4..dfae4b933fa9 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -187,135 +187,6 @@ int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
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

