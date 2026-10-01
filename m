Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDCA3CB2E5;
	Thu,  1 Oct 2026 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838248; cv=none; b=Pn4t2l0hr4leMm7OhituEa1Nk5QMCWxGdGBaLFuD5qItNkD5PeintV33rhXpV0kbI3Z6pv8AYbrQgSD+etJ3QbLxcBllb0tYqYDugtZsMPS88c4kJyVCvnD05+P819e0yNeytm/j9zyqN4NU5fZvNZtP+FXUafmvqlxeR90ocl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838248; c=relaxed/simple;
	bh=fIVg/qCK8bc3PRzo2uBoAgkiv+c1u7fkLS8h4+ocM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCPljDI0rQh6V5vLd82+17Q1NG4IYv6hWKMIVymyJ2DCD9FGfmiqoDftyUNhCug4/vWXvSCnOlkOY22l1bepvmbB19zmYoZ4MyRqjIODM5Lj8c8UedVK8Yg+w/QIUXWjLFX2pRj4dTkOukFVS4Km4NUKXGN0tZYYMgT17zJCHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QC6XGWq8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QC6XGWq8"
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 1DF6B20B7166; Thu,  1 Oct 2026 00:03:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DF6B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790838189;
	bh=rVMMwSLrZ6Yj0EbL+XCFPDeC66kDPYbXu+68xDBjVfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QC6XGWq8mH8FuT5EvHtbBBP8D0/Kyz+dOZjmajx1P3UF2sZk+Ux581ieJ7+roaoeE
	 IE6AwzoFrLvf/RoMJ75aJRB+zE5tA3wOBeWGGlFq8ZG5KcqLGLWDM83nRhs3ofrqFQ
	 hzbFdaoe2lXNTOp0qAREOpeBv2w7rj0XYAhQDU3E=
Date: Thu, 1 Oct 2026 00:03:09 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, wei.liu@kernel.org, mhkelley58@gmail.com
Subject: Re: [PATCH V2 2/3] mshv: Redesign hypervisor memory deposit logic
Message-ID: <ar4FrdqJ2X8NkSYl@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260912000318.2959621-1-mrathor@linux.microsoft.com>
 <20260912000318.2959621-3-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912000318.2959621-3-mrathor@linux.microsoft.com>

On Fri, Sep 11, 2026 at 05:03:17PM -0700, Mukesh R wrote:
> The current memory deposit implementation has a few issues and bugs:
>  o It is very slow: one of the main contributions to slow VM creations
>    and boot is many hypercalls repeatedly coming back with insufficient
>    memory. On Hyper-V, a hypercall returns with such status whenever it
>    cannot complete due to lack of memory in the hypervisor and needs more.
>  o Contiguous range requirement is broken, and is critical bug
>  o An incorrect assumption is made that contiguous memory size would
>    always be power of 2.
>  o Two pages are allocated, only one is really needed. Extra alloc adds
>    to the overhead.
>  o For a 512 page deposit, the allocation is split into two: one for 511
>    and second for 1. Thus, an order 9 allocation never happens. A
>    contiguous 2M range, if possible, greatly improves performance
>    in the hypervisor as it can be mapped as large page whenever possible.
>    Also, removing extra allocation reduces overhead in linux.
>  o Since a page is already allocated to collect the frames, there is
>    not really a need to use per cpu input page, and hence avoid local
>    irq disable.
>  o In hv_call_deposit_pages(), in case of error, under err_free_allocations
>    label, all pages are freed without checking status to see if some pages
>    were deposited. This is a critical bug as it would free pages that hyp
>    may be using.
> 
> All of above is addressed by:
>  o Allocate 2M by default, this is the recommendation from the hypervisor
>    team, and greatly improves performance. Depositing one or few pages
>    at a time results in lot of insufficient memory returns from hypercalls.
>  o Always start with a full 2M range allocation, thus getting contiguous if
>    available. In cases where possible, the deposits are much faster.
>  o Allocate only one page in the deposit function and collect 511 pfns
>    there. Just use a local variable for last pfn.
>  o Use the page as input to hypercall. Since this page is locally allocated,
>    irq disable can be avoided helping speed up the deposit.
>  o Fix the physical contiguous memory enforcement..
>  o Lastly, remove pre-deposits hv_call_create_vp() and
>    hv_call_initialize_partition() as they were removed internally while
>    ago, most likely because they didn't help much.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c           | 194 +++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_hv_call.c |  10 +-
>  include/asm-generic/mshyperv.h |   5 -
>  3 files changed, 175 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57864bb5bcd8..df39a5c587ca 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -9,6 +9,180 @@
>  #include <linux/export.h>
>  #include <asm/mshyperv.h>
>  
> +#define HV_DEPOSIT_MAX 512
> +#define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
> +	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
> +
> +/*
> + * Allocate free pages for deposit to hypervisor. pfna[] must be large enough
> + * to hold HV_DEPOSIT_INP_MAX (511) pages. If num_pages is 512, return last
> + * pfn in lastpfn. If @single, then it must be a single allocation (not split
> + * over multiple contiguous ranges).
> + *
> + * Returns: number of pages allocated or -ENOMEM
> + */
> +static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp, int num_pages,
> +			      bool single)
> +{
> +	struct page *page;
> +	int num_allocd, count = 0;
> +
> +	/* Published ABI, enforce its immutability. */
> +	BUILD_BUG_ON(HV_DEPOSIT_INP_MAX != 511);
> +
> +	if (num_pages > HV_DEPOSIT_MAX ||
> +	    (num_pages == HV_DEPOSIT_MAX && lastpfnp == NULL))
> +		return -EINVAL;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		int order = 31 - __builtin_clz(num_pages);
> +		gfp_t gfp_flags = GFP_KERNEL;
> +
> +		if (!single)
> +			gfp_flags |= __GFP_NOWARN;
> +
> +		while (1) {
> +			page = alloc_pages_node(node, gfp_flags, order);
> +			if (page || order == 0 || single)
> +				break;
> +
> +			order--;
> +		}
> +
> +		if (page == NULL)
> +			break;
> +
> +		split_page(page, order);
> +		num_allocd = 1 << order;
> +		num_pages -= num_allocd;
> +
> +		while (num_allocd && count < HV_DEPOSIT_INP_MAX) {
> +			pfna[count++] = page_to_pfn(page++);
> +			num_allocd--;
> +		}
> +
> +		if (num_allocd-- && count == HV_DEPOSIT_INP_MAX) {
> +			*lastpfnp = page_to_pfn(page);
> +			count++;
> +			break;
> +		}
> +	}
> +
> +	return count ? count : -ENOMEM;
> +}
> +
> +/*
> + * Deposit memory in the hypervisor. Even if @contiguous is false, a contiguous
> + * 2M worth of pfns is utmost desired for performance reasons. But short of
> + * that, we deposit whatever contiguous chunks we can get. If @contiguous is
> + * true, then the entire range has to be physically contiguous. Note, in that
> + * case, upon withdrawl, hypervisor could return any page in between the range,
> + * so we must split that also. Lastly, HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is
> + * not guaranteed to always be power of 2.
> + */
> +static int hv_call_deposit_pages(int node, u64 partition_id, bool contiguous)
> +{
> +	struct hv_deposit_memory *hc_input;
> +	int i, rc, num_pages;
> +	u64 status, *pfna, lastpfn = 0;
> +	bool trunc_extra = false;
> +
> +	BUILD_BUG_ON(HV_MAX_CONTIGUOUS_ALLOCATION_PAGES > HV_DEPOSIT_MAX);
> +
> +	if (contiguous) {
> +		num_pages = roundup_pow_of_two(
> +					  HV_MAX_CONTIGUOUS_ALLOCATION_PAGES);
> +		trunc_extra = num_pages != HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +	} else {
> +		num_pages = HV_DEPOSIT_MAX;
> +	}
> +
> +	hc_input = (struct hv_deposit_memory *)get_zeroed_page(GFP_KERNEL);
> +	if (hc_input == NULL)
> +		return -ENOMEM;
> +
> +	hc_input->partition_id = partition_id;
> +	pfna = hc_input->gpa_page_list;
> +
> +	rc = hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages, contiguous);
> +	if (rc < 0)
> +		goto out_free;
> +
> +	num_pages = rc;
> +	if (num_pages > HV_DEPOSIT_INP_MAX)
> +		num_pages = HV_DEPOSIT_INP_MAX;
> +
> +	if (contiguous && trunc_extra) {
> +		for (i = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES; i < num_pages; i++)
> +			__free_page(pfn_to_page(pfna[i]));
> +
> +		if (lastpfn) {
> +			__free_page(pfn_to_page(lastpfn));
> +			lastpfn = 0;
> +		}
> +
> +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +	}
> +
> +	/* Not using hyperv_pcpu_input_arg, so no need to disable interrupts */
> +
> +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, num_pages, 0,
> +				     hc_input, NULL);
> +	if (!hv_result_success(status))
> +		goto err_free_dep_pages;
> +
> +	if (lastpfn) {
> +		hc_input->gpa_page_list[0] = lastpfn;
> +		status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY, 1, 0,
> +					     hc_input, NULL);
> +
> +		if (!hv_result_success(status) && hv_repcomp(status) == 0)
> +			/* We deposited lot earlier, so give it a go */
> +			__free_page(pfn_to_page(lastpfn));
> +	}
> +
> +	free_page((unsigned long)hc_input);
> +	return 0;
> +
> +err_free_dep_pages:
> +	hv_status_err(status, "\n");
> +	rc = hv_result_to_errno(status);
> +
> +	for (i = hv_repcomp(status); i < num_pages; i++)
> +		__free_page(pfn_to_page(pfna[i]));
> +	if (lastpfn)
> +		__free_page(pfn_to_page(lastpfn));
> +
> +out_free:
> +	free_page((unsigned long)hc_input);
> +	return rc;
> +}
> +
> +int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
> +{
> +	int result = hv_result(hv_status);
> +	bool contiguous = false;
> +
> +	if (result == HV_STATUS_INSUFFICIENT_ROOT_MEMORY ||
> +	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY) {
> +		if (!hv_root_partition()) {
> +			hv_status_err(hv_status,
> +				      "Unexpected root memory deposit\n");
> +			return -EINVAL;
> +		}
> +
> +		pt_id = HV_PARTITION_ID_SELF;
> +	}
> +
> +	if (result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY ||
> +	    result == HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY)
> +		contiguous = true;
> +
> +	return hv_call_deposit_pages(node, pt_id, contiguous);
> +}
> +EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> +
>  /*
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>   * are GPAs.
> @@ -109,12 +283,6 @@ static int hv_call_deposit_pages_old(int node, u64 partition_id, u32 num_pages)
>  	return ret;
>  }
>  
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> -{
> -	return hv_call_deposit_pages_old(node, partition_id, num_pages);
> -}
> -EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> -
>  static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id, u64 hv_status)
>  {
>  	u32 num_pages = 1;
> @@ -144,12 +312,6 @@ static int __maybe_unused hv_deposit_memory_node_old(int node, u64 partition_id,
>  	return hv_call_deposit_pages_old(node, partition_id, num_pages);
>  }
>  
> -int hv_deposit_memory_node(int node, u64 partition_id, u64 hv_status)
> -{
> -	return hv_deposit_memory_node_old(node, partition_id, hv_status);
> -}
> -EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> -
>  bool hv_result_needs_memory(u64 status)
>  {
>  	switch (hv_result(status)) {
> @@ -212,14 +374,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  	unsigned long irq_flags;
>  	int ret = 0;
>  
> -	/* Root VPs don't seem to need pages deposited */
> -	if (partition_id != hv_current_partition_id) {
> -		/* The value 90 is empirically determined. It may change. */
> -		ret = hv_call_deposit_pages(node, partition_id, 90);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	do {
>  		local_irq_save(irq_flags);
>  
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index cb55d4d4be2e..b8d199f95299 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -15,8 +15,6 @@
>  #include "mshv_root.h"
>  
>  /* Determined empirically */
> -#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> -#define HV_MAP_GPA_DEPOSIT_PAGES	256
>  #define HV_UMAP_GPA_PAGES		512
>  
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> @@ -140,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
>  
>  	input.partition_id = partition_id;
>  
> -	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -				    HV_INIT_PARTITION_DEPOSIT_PAGES);
> -	if (ret)
> -		return ret;
> -
>  	do {
>  		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>  					       *(u64 *)&input);
> @@ -248,8 +241,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  		completed = hv_repcomp(status);
>  
>  		if (hv_result_needs_memory(status)) {
> -			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -						    HV_MAP_GPA_DEPOSIT_PAGES);
> +			ret = hv_deposit_memory(partition_id, status);
>  			if (ret)
>  				break;
>  
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..c16abaecb65e 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -345,7 +345,6 @@ static inline bool hv_parent_partition(void)
>  
>  bool hv_result_needs_memory(u64 status);
>  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_notify_all_processors_started(void);
>  bool hv_lp_exists(u32 lp_index);
> @@ -360,10 +359,6 @@ static inline int hv_deposit_memory_node(int node, u64 partition_id, u64 status)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> -{
> -	return -EOPNOTSUPP;
> -}
>  static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.51.2.vfs.0.1
> 
