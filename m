Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6F1E8332;
	Mon, 24 Aug 2026 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787532537; cv=none; b=XANaqQhClTThoIIopbi8yUqbK44sNOPp713cMrMDBdSh5TNeMppGNVT47IMDVCrujcIVFw+B16u4BBPl6hFPT7PZDHRREY9OBBQNeumLwpZTxALg9AScfUX4QfFmhis8h8J5XcGLIkO2WedjwXtKUAy9Ec9YfQ9nS94ofINXYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787532537; c=relaxed/simple;
	bh=e6kWe5uWuYqU4SgkF17T3iZhuGjj6j5lXH/cPrLIe9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjYQV8v6fG+pWV/rr54OPqChACMGUvakT9FiU8VG2QCRl5nZ6FYrnV74CB5NjkhO28JxNC/+Xi6njHA595ijhj2prK4yXhFQu9HO0z8AgP+Suv7DNbrdOHI1qM/F+c8avLOf3lWLIQo6oVS9AWLEdwpXLwwb1U323xjqKU6AXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKEt0DrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKEt0DrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9C91F000E9;
	Mon, 24 Aug 2026 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787532535;
	bh=2i0zIYgQKXwjQY+Ihjr4rqhjvC5NmSYNmtChgIjaDqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKEt0DrYK4Q08VpGGU6hqSWN+BIlFeKsCX2Bs/JXh3wBFIITBbdqiPzmJs1y98qL+
	 GZsfwIw31LZfj3UowJ67/DW/p/tda3hK4K/32wO5hggI8bUTVqx85kHk7UZcWKBEHG
	 3xjQyM9IzI27KwgGycU221icwDes2fyzpEEthohZiTZ114yLPIn2b3uHC8o0jNF75V
	 4rXEuTIvyW9xRvPZDvsC5xE4Ix7cxFjm4U0jiTCyPMLsifAmPvkEPqTLD088Tr7eGT
	 FCjUWNVV1zFR6Cb13pDKnWDMUB3hjwrOtQHPo8KMLaRRCxAISY6H1fBPVzMKNacMqL
	 U9tQr3yoeEHFg==
Date: Sun, 23 Aug 2026 17:48:54 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, wei.liu@kernel.org, mhkelley58@gmail.com
Subject: Re: [PATCH V0 1/2] mshv: Stub out deposit memory functions
Message-ID: <20260824004854.GJ3566091@liuwe-devbox-debian-v2.local>
References: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
 <20260812000507.3809046-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812000507.3809046-2-mrathor@linux.microsoft.com>

On Tue, Aug 11, 2026 at 05:05:06PM -0700, Mukesh R wrote:
> Stub out deposit memory functions so adding of new redesigned functions
> is much eaiser to review.
> 

This leaves the system in a broken state. It can break bisection.

Can yo try this:

  Patch 1: rename hv_call_deposit_pages to hv_call_deposit_pages_old,
  and then hv_call_deposit_pages calls the _old variant.
  Patch 2: introduce the new scheme.
  Patch 3: drop the _old variant.

Hopefully this can make the diff more reviewable.

If this proves to be not as useful as I think, I can squash both patches
when I apply the patch series.

Wei

> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c | 126 ++-----------------------------------------
>  1 file changed, 3 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..d5ce9a032e9c 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -9,135 +9,15 @@
>  #include <linux/export.h>
>  #include <asm/mshyperv.h>
>  
> -/*
> - * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> - * are GPAs.
> - */
> -#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> -
> -/* Deposits exact number of pages. Must be called with interrupts enabled.  */
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
> -	struct page **pages, *page;
> -	int *counts;
> -	int num_allocations;
> -	int i, j, page_count;
> -	int order;
> -	u64 status;
> -	int ret;
> -	u64 base_pfn;
> -	struct hv_deposit_memory *input_page;
> -	unsigned long flags;
> -
> -	if (num_pages > HV_DEPOSIT_MAX)
> -		return -E2BIG;
> -	if (!num_pages)
> -		return 0;
> -
> -	/* One buffer for page pointers and counts */
> -	page = alloc_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -	pages = page_address(page);
> -
> -	counts = kzalloc_objs(int, HV_DEPOSIT_MAX);
> -	if (!counts) {
> -		free_page((unsigned long)pages);
> -		return -ENOMEM;
> -	}
> -
> -	/* Allocate all the pages before disabling interrupts */
> -	i = 0;
> -
> -	while (num_pages) {
> -		/* Find highest order we can actually allocate */
> -		order = 31 - __builtin_clz(num_pages);
> -
> -		while (1) {
> -			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> -			if (pages[i])
> -				break;
> -			if (!order) {
> -				ret = -ENOMEM;
> -				num_allocations = i;
> -				goto err_free_allocations;
> -			}
> -			--order;
> -		}
> -
> -		split_page(pages[i], order);
> -		counts[i] = 1 << order;
> -		num_pages -= counts[i];
> -		i++;
> -	}
> -	num_allocations = i;
> -
> -	local_irq_save(flags);
> -
> -	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -
> -	input_page->partition_id = partition_id;
> -
> -	/* Populate gpa_page_list - these will fit on the input page */
> -	for (i = 0, page_count = 0; i < num_allocations; ++i) {
> -		base_pfn = page_to_pfn(pages[i]);
> -		for (j = 0; j < counts[i]; ++j, ++page_count)
> -			input_page->gpa_page_list[page_count] = base_pfn + j;
> -	}
> -	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> -				     page_count, 0, input_page, NULL);
> -	local_irq_restore(flags);
> -	if (!hv_result_success(status)) {
> -		hv_status_err(status, "\n");
> -		ret = hv_result_to_errno(status);
> -		goto err_free_allocations;
> -	}
> -
> -	ret = 0;
> -	goto free_buf;
> -
> -err_free_allocations:
> -	for (i = 0; i < num_allocations; ++i) {
> -		base_pfn = page_to_pfn(pages[i]);
> -		for (j = 0; j < counts[i]; ++j)
> -			__free_page(pfn_to_page(base_pfn + j));
> -	}
> -
> -free_buf:
> -	free_page((unsigned long)pages);
> -	kfree(counts);
> -	return ret;
> +	return -ENOTSUPP;
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>  
> -int hv_deposit_memory_node(int node, u64 partition_id,
> -			   u64 hv_status)
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
>  {
> -	u32 num_pages = 1;
> -
> -	switch (hv_result(hv_status)) {
> -	case HV_STATUS_INSUFFICIENT_MEMORY:
> -		break;
> -	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> -		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> -		break;
> -
> -	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> -		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> -		fallthrough;
> -	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> -		if (!hv_root_partition()) {
> -			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> -			return -ENOMEM;
> -		}
> -		partition_id = HV_PARTITION_ID_SELF;
> -		break;
> -
> -	default:
> -		hv_status_err(hv_status, "Unexpected!\n");
> -		return -ENOMEM;
> -	}
> -	return hv_call_deposit_pages(node, partition_id, num_pages);
> +	return -ENOTSUPP;
>  }
>  EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
>  
> -- 
> 2.51.2.vfs.0.1
> 
