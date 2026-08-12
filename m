Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94E4204E;
	Wed, 12 Aug 2026 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493126; cv=none; b=iJmY4E0OfDvvHYLkKtU9ayDg+y6GKDZD1ghe159i4rSRlt7guGcBZO+4LOPrpsBX8XFJGakh/YRRgcyTQhjUyaR4MglO6kIN9toRmd9KfR9QNH8A8AqNoeXTvHoq3JS15UEzIE70ODmvzZRXJmsJ17O39IwGof4BcW2v/iXgY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493126; c=relaxed/simple;
	bh=1NgHFM2Vg0yBu2SLL+GefWAHrRdz78dFOui9uBucu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+CjMUHcpx710kKiw/wkAWABm/RxHad+/zJsn9ljbUxiiI2Kw1ZiARbrFFxCvATASllu15VQA/yziZddTLs7ci9XO3KYn7moBoM71Y2xl8+HgxvkPdQC0nBl7xVIfU4YGNRvMsJCJNP2WG0zjqDnbg6ieExOJiZp1ofI6y2kDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KqNGn01P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KqNGn01P"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CD9020B7168;
	Tue, 11 Aug 2026 17:04:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CD9020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786493095;
	bh=U6vqpB/pHLHFQfy/VQj0XgJau/ZvOHIFmfxHxQMM40o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqNGn01PY7jBeBy6ISxY5At9MdK5J8IDZBnBmIB1SuEVfrr9TqEdky8QnElI+8HpC
	 HOSjT0Q+upy5f9eJQSJZJrsocQ7Jy0xFyYLDgugMrmm343IQbtFcNVTb78GGncRXTV
	 eARFYBcCw1KIEk855uyy9w+/JjqK1TY59kySZNL4=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	wei.liu@kernel.org,
	mhkelley58@gmail.com,
	mrathor@linux.microsoft.com
Subject: [PATCH V0 1/2] mshv: Stub out deposit memory functions
Date: Tue, 11 Aug 2026 17:05:06 -0700
Message-ID: <20260812000507.3809046-2-mrathor@linux.microsoft.com>
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

Stub out deposit memory functions so adding of new redesigned functions
is much eaiser to review.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/hv_proc.c | 126 ++-----------------------------------------
 1 file changed, 3 insertions(+), 123 deletions(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..d5ce9a032e9c 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -9,135 +9,15 @@
 #include <linux/export.h>
 #include <asm/mshyperv.h>
 
-/*
- * See struct hv_deposit_memory. The first u64 is partition ID, the rest
- * are GPAs.
- */
-#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
-
-/* Deposits exact number of pages. Must be called with interrupts enabled.  */
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
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
-	if (num_pages > HV_DEPOSIT_MAX)
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
-	counts = kzalloc_objs(int, HV_DEPOSIT_MAX);
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
+	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
-int hv_deposit_memory_node(int node, u64 partition_id,
-			   u64 hv_status)
+int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
 {
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
-	return hv_call_deposit_pages(node, partition_id, num_pages);
+	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
 
-- 
2.51.2.vfs.0.1

