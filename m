Received: from sender5-of-o55.zoho.com (sender5-of-o55.zoho.com [165.173.182.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402883D45C5;
	Thu,  1 Oct 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854983; cv=pass; b=jicr3U9cYjF0kkCSfsVIovLEbt5rQ/Nj35O9d3EgP4t0Q2UB8GdtbOyazbreVew8kKwC2wXozeF3a3hlrInCjVE2RE53B+MNrgIb+rNER1FGSXNr/PmBCRD1kQDhh+7oXhGHv5UWbeVPr947GdQsDik63SxjXPUK1SxUPHhn9FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854983; c=relaxed/simple;
	bh=Nh0xk1TL6r5IrVYmqatbTkShmgbLIG0cqCk4iBTojgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbj7Teu1zMiNtyFp4mACPvi36hhJPCo0yNGzqV+JOlB+gyN0WxW5cKukaTaEp3BKeFcDuX1P1pCFkTf4vA4pu2Cq+eLwree5zJg1g93EP+zUpRcef+cs14xNlocndRm2o+Piz5kK6pO4V37XBt1g7m/yR+9+xZyXMmchtV0Mu60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Lu2zwi2t; arc=pass smtp.client-ip=165.173.182.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Lu2zwi2t"
ARC-Seal: i=1; a=rsa-sha256; t=1790854968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aY+KPdW11oQkaTpGDlBB5ujRvn8iQAHncnUot/0J6CCWHPRq8eFuMKvGnfziuZNTRSU5I2nAquhGtUWH0ulHtjV4zjSUiBmiRXRaOkAk0Gb9DqB0RPNJT+s6tOaquOBPNZ6ZyLaMFHJFrRUZKctC4irIC9saiBPF8N4NGtTWBkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790854968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GMScdZuE3khjmxnaBfP0hlaSK/ObWwj72tCYDROobPY=; 
	b=Z1OnbJQH7nzf2GgsjvHtOIInjibSAg8/bbcW8ip7MY7jJi+NahA+6UcY5ilqMXdsG48ue0zuTStOIl0UPzWlFIO6gJiUNLzFXAybqnuDJYTjCQ4gZdH/8R5NZpxx12g2qu+V3GoGGPeyc0UQm758b0n3ah7ePge5sjipzqeodOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790854968;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=GMScdZuE3khjmxnaBfP0hlaSK/ObWwj72tCYDROobPY=;
	b=Lu2zwi2tJFXbMTKRe0CnZ4kLTyObxq7eMDHPIa7Kfle8n2mtBGyK7N9khL7R5e4y
	RdJ/LAYUpqSSk2fn4A5bk+lUf1rUtg7lEdKvL4M6LUzEekdlpcMGU7niRX0LNinyxqG
	VnXkmZ621w/CIU2dhY0RpBj821ChKY39/qpcJWCE=
Received: by smtp.zohomail.com with SMTPS id 1790854965750652.7710486324092;
	Thu, 1 Oct 2026 04:42:45 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:42:38 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <20261001-quizzical-cute-finch-c4e2cd@anirudhrb>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.845.86
X-ZohoMailClient: External

On Wed, Sep 30, 2026 at 02:10:47PM +0200, Magnus Kulke wrote:
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
> page is tolerated and triggers a #PF, for which the kernel executes
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
> ---
> Changes since v3:
> - Batch contiguous pages in the restore path
> - Adjusted comment about failure modes
> 
> Changes since v2:
> - Checkpatch format fix
> 
> Changes since RFC:
> - Handle direct-map restoration failures without returning unmapped
>   pages to the allocator.
> - Move freeing of withdrawn pages into the restoration helper.
> ---
>  drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
>  drivers/hv/mshv_root_hv_call.c |  4 +-
>  include/asm-generic/mshyperv.h |  4 ++
>  3 files changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..b056051a5ac5 100644
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
> @@ -110,6 +156,41 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>  
> +/*
> + * Put withdrawn pages back in the direct map. Counterpart to the direct map
> + * removal done by hv_call_deposit_pages().
> + */
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count)
> +{
> +	int i, j, end, n, ret;
> +	struct page *page;
> +
> +	for (i = 0; i < count; i = end) {
> +		page = pfn_to_page(pfns[i]);
> +		/* find consecutive runs of pfns */
> +		for (end = i + 1; end < count; ++end) {
> +			if (pfns[end] != pfns[end - 1] + 1)
> +				break;
> +		}
> +		n = end - i;
> +		ret = set_direct_map_valid_noflush(page, n, true);
> +
> +		for (j = i; j < end; ++j) {
> +			page = pfn_to_page(pfns[j]);
> +			/*
> +			 * Retry individually on failed batch. We don't want
> +			 * to return pages to the allocator that we couldn't mark
> +			 * valid in the direct map.
> +			 */
> +			if (ret &&
> +			    WARN_ON_ONCE(set_direct_map_valid_noflush(page, 1, true)))
> +				continue;
> +			__free_page(page);
> +		}
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

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

