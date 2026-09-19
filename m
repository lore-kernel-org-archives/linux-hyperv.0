Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7D547048;
	Sat, 19 Sep 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860653; cv=none; b=YTVZAYGHBO0gSC+kjzI4OBKDTGVOktPw75jrsyIZ0glslBLb0GkEZl1JrxtdP0LDcwrN0qiv9YLkNYeYHYrGJG411QPBxvmfOzPWoJMwcTlIe002Fabvfgvh8hTdaBG7ktcTYS3wlNGmT0hb4VuHWfAco6ucR9BZnSnWkv2H3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860653; c=relaxed/simple;
	bh=1SNjiLz//D/+JdOBP5UiCox8l5ktCQkHhQA0O5Mkhgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjBnJWrsMtqD3qcycC+buEy8F3YPod9TpCzIhFp2+SOSEJ9SnmyTr65X/qScbCzn+9xY6ojQ26Tl0H3uca178/BUYAG5lmqZif1wcVUdFLDgP3E6DY0RoVqTLJJnUFYtN7n3QEnQA3Lmo1h1CqYIUkLFYtbh6BH2znx/aQWkheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB2QMiUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB2QMiUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F491F000FF;
	Sat, 19 Sep 2026 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860651;
	bh=mj8M0PwW+jXzbWLeEFYP+h6cvIZxjs/2Fn94KwzRq5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HB2QMiUkZfigzZ/NyZdaMEmM9MsoCx/tEIcINXc/LVczL0kM72d6ehYf6vbvQ4Och
	 Gc2zGpIXLMJrq3IWUCNYMJ4BJPyp4ezOKpuyQdEkOHoP+JsTqSNYtRX8GOwBvfKWr1
	 zc3oVI+7+XlI/CMJsy5jvN/UkOarr6FwB06gK7cQZYFHRw0HQmnx4Rv6k7WL/qsO8U
	 d6EjJrROWLqbDXywSH0GTkEcsDvP01zu9QWYxFmDVNmA8XoYDLRzKmJiEkvdIfPlsc
	 n9caA1PFVdLFsSXo3hNCXL2oxcuhmoiJpz38TC3J211ecyQCuC+brysRGxH2eUD95l
	 DqHDtsqart+Ig==
Date: Sat, 19 Sep 2026 16:30:50 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Message-ID: <20260919233050.GF1008213@liuwe-devbox-debian-v2.local>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>

On Thu, Sep 17, 2026 at 10:10:52PM +0200, Magnus Kulke wrote:
> hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> ownership of those pages and per contract revokes root partition
> access to them, raising a #GP on access from the L1VH root partition.
> 
> However, the pages remain mapped in the kernel direct map, so kernel
> code may still access them even though the hypervisor has revoked
> access.
> 
> Helpers such as "load_unaligned_zeropad()" deliberately read past the
> end of a buffer and across page boundaries. A read into an unmapped
> page is tolerated and triggers a #PF, for which the kernel executed
> a fixup in the exception table.
> 
> If such a call steps into a page that has been deposited, the access
> raises a #GP by the hypervisor from which the above handler cannot
> recover and the kernel panics:
> 
>   Oops: general protection fault, maybe for address 0xff1100941a3dfffc
>   RIP: 0010:csum_partial+0xe5/0x110
> 
> This condition will appear on L1VH system that have created L2
> partitions (and hence deposited pages) and exercise networking code
> paths such as csum_partial() can trigger this condition when a buffer
> ends close to a page boundary (e.g fffc in the above example).
> 
> The fix is to remove the deposited pages from the direct map before
> they are passed to the hypervisor, and restore them when the hypervisor
> returns them again.
> 
> We want to avoid flushing the TLB in the loop, so we use the _noflush()
> variant of set_direct_map_valid() when marking a deposited page invalid
> and flush the affected page ranges in one go ourselves. In the opposite
> direction this is not required:
> 
>   > If a paging-structure entry is modified to change the P flag from
>   > 0 to 1, no invalidation is necessary. This is because no TLB entry
>   > or paging-structure cache entry is created with information from a
>   > paging-structure entry in which the P flag is 0.
> 
> (Intel SDM Vol. 3, 4.10.4.3)
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

None of the code added is arch-specific. Hopefully ARM64 is okay.

I will wait for Souradeep and Anirudh's review on the ARM64 side before
taking further action.

Wei

> ---
> Changes since v2:
> - Checkpatch format fix
> 
> Changes since RFC:
> - Handle direct-map restoration failures without returning unmapped
>   pages to the allocator.
> - Move freeing of withdrawn pages into the restoration helper.
> ---
>  drivers/hv/hv_proc.c           | 77 +++++++++++++++++++++++++++++++++-
>  drivers/hv/mshv_root_hv_call.c |  4 +-
>  include/asm-generic/mshyperv.h |  4 ++
>  3 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..2a392b45205d 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -7,7 +7,9 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/minmax.h>
>  #include <linux/export.h>
> +#include <linux/set_memory.h>
>  #include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
>  
>  /*
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> @@ -15,6 +17,35 @@
>   */
>  #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>  
> +/*
> + * Add or remove a set of physically contiguous page runs from the kernel
> + * direct map. Once a page has been deposited the hypervisor owns it and
> + * revokes root partition access to it.
> + */
> +static int hv_deposit_update_direct_map(struct page **pages, int *counts,
> +					int num_allocations, bool valid)
> +{
> +	int i, err, ret = 0;
> +
> +	for (i = 0; i < num_allocations; ++i) {
> +		err = set_direct_map_valid_noflush(pages[i], counts[i], valid);
> +		if (err && !ret)
> +			ret = err;
> +	}
> +
> +	if (valid)
> +		return ret;
> +
> +	for (i = 0; i < num_allocations; ++i) {
> +		unsigned long addr = (unsigned long)page_address(pages[i]);
> +		unsigned long size = (unsigned long)counts[i] << PAGE_SHIFT;
> +
> +		flush_tlb_kernel_range(addr, addr + size);
> +	}
> +
> +	return ret;
> +}
> +
>  /* Deposits exact number of pages. Must be called with interrupts enabled.  */
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
> @@ -72,6 +103,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  	}
>  	num_allocations = i;
>  
> +	ret = hv_deposit_update_direct_map(pages, counts, num_allocations, false);
> +	if (ret)
> +		goto err_restore_direct_map;
> +
>  	local_irq_save(flags);
>  
>  	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  	if (!hv_result_success(status)) {
>  		hv_status_err(status, "\n");
>  		ret = hv_result_to_errno(status);
> -		goto err_free_allocations;
> +		goto err_restore_direct_map;
>  	}
>  
>  	ret = 0;
>  	goto free_buf;
>  
> +err_restore_direct_map:
> +	/*
> +	 * We don't want to return pages to the allocator if weren't able to
> +	 * mark them valid in the direct map.
> +	 */
> +	if (hv_deposit_update_direct_map(pages, counts, num_allocations, true)) {
> +		WARN(1, "leaking %d page block(s) that could not be set to valid\n",
> +		     num_allocations);
> +		goto free_buf;
> +	}
> +
>  err_free_allocations:
>  	for (i = 0; i < num_allocations; ++i) {
>  		base_pfn = page_to_pfn(pages[i]);
> @@ -110,6 +156,35 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>  
> +/*
> + * Put withdrawn pages back in the direct map. Counterpart to the direct map
> + * removal done by hv_call_deposit_pages().
> + */
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count)
> +{
> +	int i, ret = 0;
> +	struct page *page;
> +
> +	for (i = 0; i < count; ++i) {
> +		page = pfn_to_page(pfns[i]);
> +		ret = set_direct_map_valid_noflush(page, 1, true);
> +		/*
> +		 * HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
> +		 * a 2MiB page, so deposited pages are of 4k granularity and cannot
> +		 * be collapses into a 2MiB page, which would require an allocation
> +		 * and can potentially fail.
> +		 *
> +		 * Should it fail anyway we leak the page, if we would hand it
> +		 * back to the allocator we would introduce faults into random other
> +		 * parts.
> +		 */
> +		if (WARN_ON_ONCE(ret))
> +			continue;
> +		__free_page(page);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
> +
>  int hv_deposit_memory_node(int node, u64 partition_id,
>  			   u64 hv_status)
>  {
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index cb55d4d4be2e..150a0c63ebc8 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -46,7 +46,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>  	struct page *page;
>  	u16 completed;
>  	u64 status, withdrawn = 0;
> -	int i;
>  	unsigned long flags;
>  
>  	page = alloc_page(GFP_KERNEL);
> @@ -69,8 +68,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>  
>  		completed = hv_repcomp(status);
>  
> -		for (i = 0; i < completed; i++)
> -			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
>  
>  		if (!hv_result_success(status)) {
>  			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..397c8ec0ce9a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -346,6 +346,7 @@ static inline bool hv_parent_partition(void)
>  bool hv_result_needs_memory(u64 status);
>  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_notify_all_processors_started(void);
>  bool hv_lp_exists(u32 lp_index);
> @@ -364,6 +365,9 @@ static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_page
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void hv_restore_withdrawn_pages(const u64 *pfns, int count) { }
> +
>  static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.34.1
> 
