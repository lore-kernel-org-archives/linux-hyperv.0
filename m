Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228073;
	b=c3rQshZ8Qf/b8TO11JPb3HKer3K5VHOvSQV/E0JO5aO4O2v79kl4fO7tcaYI1TowYs7Z
	 179bMXli7X8b1ZRxUhB0Ep6XyEp0GTgy8lCGNL1P7R8Nh3IAUpdMmfuWfKPFXyLzt2hiV
	 ZkgmgQBcVz0sxPC3YdeEfuQi+tVqBX3o1+KrokuuwW4DLMtqye7y7ksGLpkePwfAhOOkT
	 1yldNDPJM5q4Bm/J2wQsYa0IR0pGMaDTDF9ZX2jEhN2d9MjFXK/Yva/a3YmD9UL5mu42o
	 9VB14S8lp6+fND7im2wCcqxkK3te6XWFYMEjhJJnfeumoNHwLjpvsc3sBjuOHmoyboQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228073;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=7+8g5pkqznWF0/NMUevwwS8BVQE4WdpcK06r/3WMI2Q=;
	b=s/pzEYOf3oAKmIs4yj+r+nsfqPUpCaMlr5fjNN8sOXxNlFT+evMzJB4LX3zljuWRbP5D
	 fKw+5bBVHs4Jwyu+S0vqP7d5Yb9UV93QSTQPJPbvuZflX5HBpaCTDLSUJ/Ew0zfQgCCVT
	 k0nRVJLt8APxUvDX4xsPYiB7SdDowlD42p/dBDkQnkqsC9YKuLWfiTthkqXBkka5AGB6I
	 L72tWrzA3nFOtCFsF5RqrIqAAPxhQrxfjNQmdbeaIq3uOsC1cuHxDKwD59coxkKyQgtES
	 W89EU8ofcI9PAmZRKv4nnocc1Ed0gGlXUkooU63nwWpbFweaNiCae8lN1eH9ggTHxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gLE36HT9;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D6606A322;
	Wed, 28 Oct 2026 22:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39D6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gLE36HT9
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C99020B7167;
	Wed, 28 Oct 2026 15:54:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C99020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793228060;
	bh=7+8g5pkqznWF0/NMUevwwS8BVQE4WdpcK06r/3WMI2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLE36HT9fqQt6iIgFwHM6Jc2snULgvCq/610k0O/kLWoHopT19tPWRJHNGCBFM+xH
	 W3sVwv0LzjLVrfM07s9yuRC25LGDpu3FTfNVfyPAcwiDYYIretP+1yKw/yl1/AGUFQ
	 nWGIybtSowGpBR8lF33xk3juu4Wuy9DWwU9Xy5J4=
Message-ID: <49a7b3b0-5314-c028-d0e6-a46e65ed880d@linux.microsoft.com>
Date: Wed, 28 Oct 2026 15:54:30 -0700
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/26 05:10, Magnus Kulke wrote:
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
>    Oops: general protection fault, maybe for address 0xff1100941a3dfffc
>    RIP: 0010:csum_partial+0xe5/0x110
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
>    > If a paging-structure entry is modified to change the P flag from
>    > 0 to 1, no invalidation is necessary. This is because no TLB entry
>    > or paging-structure cache entry is created with information from a
>    > paging-structure entry in which the P flag is 0.
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
>    pages to the allocator.
> - Move freeing of withdrawn pages into the restoration helper.
> ---
>   drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
>   drivers/hv/mshv_root_hv_call.c |  4 +-
>   include/asm-generic/mshyperv.h |  4 ++
>   3 files changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb..b056051a5ac5 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -7,7 +7,9 @@
>   #include <linux/cpuhotplug.h>
>   #include <linux/minmax.h>
>   #include <linux/export.h>
> +#include <linux/set_memory.h>
>   #include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
>   
>   /*
>    * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> @@ -15,6 +17,35 @@
>    */
>   #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
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

I realize I am late to the review, so if too late, please ignore.
If the caller is going to not continue on error but will revert,
what is the reason to keep going on error then?

And this function should undo it itself if there is error instead
of forcing the caller to do it imo. It could just undo the part which
is done.

Thanks,
-Mukesh


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
>   /* Deposits exact number of pages. Must be called with interrupts enabled.  */
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   {
> @@ -72,6 +103,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   	}
>   	num_allocations = i;
>   
> +	ret = hv_deposit_update_direct_map(pages, counts, num_allocations, false);
> +	if (ret)
> +		goto err_restore_direct_map;
> +
>   	local_irq_save(flags);
>   
>   	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   	if (!hv_result_success(status)) {
>   		hv_status_err(status, "\n");
>   		ret = hv_result_to_errno(status);
> -		goto err_free_allocations;
> +		goto err_restore_direct_map;
>   	}
>   
>   	ret = 0;
>   	goto free_buf;
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
>   err_free_allocations:
>   	for (i = 0; i < num_allocations; ++i) {
>   		base_pfn = page_to_pfn(pages[i]);
> @@ -110,6 +156,41 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   }
>   EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
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
>   int hv_deposit_memory_node(int node, u64 partition_id,
>   			   u64 hv_status)
>   {
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index cb55d4d4be2e..150a0c63ebc8 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -46,7 +46,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>   	struct page *page;
>   	u16 completed;
>   	u64 status, withdrawn = 0;
> -	int i;
>   	unsigned long flags;
>   
>   	page = alloc_page(GFP_KERNEL);
> @@ -69,8 +68,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
>   
>   		completed = hv_repcomp(status);
>   
> -		for (i = 0; i < completed; i++)
> -			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> +		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
>   
>   		if (!hv_result_success(status)) {
>   			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index bf601d67cecb..397c8ec0ce9a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -346,6 +346,7 @@ static inline bool hv_parent_partition(void)
>   bool hv_result_needs_memory(u64 status);
>   int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>   int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count);
>   int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>   int hv_call_notify_all_processors_started(void);
>   bool hv_lp_exists(u32 lp_index);
> @@ -364,6 +365,9 @@ static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_page
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline void hv_restore_withdrawn_pages(const u64 *pfns, int count) { }
> +
>   static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
>   {
>   	return -EOPNOTSUPP;

