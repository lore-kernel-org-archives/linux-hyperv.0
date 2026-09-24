Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB9363C60;
	Thu, 24 Sep 2026 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257897; cv=pass; b=Ib+milg/CTV1SD26vOLe1dx9bKFzjMBmoJR7fsJbGuPQ0aRzBM+qu3laQ8P0fIg4FxZBBnnIgfHoQDuczFx6SKDs6mu8I0vXZUGo1aQOWGD3wdZWi/2U0f+cWdtoVbeu9XTDuxMMeT6pvMDhXzmvfjymEdW5HLiSLbQFVfVEZwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257897; c=relaxed/simple;
	bh=9jAAzu7L0V4Hl0qdlVZ+whEkE+bLweLZhkFpmH6ZgdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWV7A4sop/faC2qIm8OriTy5cwiHjmSMmhvPblwPJoKWNt8sn3lpuUijiEOXIjs1mZd3JdTC3rYup7rV3xXzivDYJBGN5Kngo3M2NjcZ7aEL33jtR2GFt2A3VIuomLZ1gTaGh02jWuaLChQae05YoeWP9+0mD8nWc1P7g6HnKXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=eASH3Dyc; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="eASH3Dyc"
ARC-Seal: i=1; a=rsa-sha256; t=1790257880; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RFKin86g6YNcdDjG5B8xDXfnwI9u5RxfnOGduSugOsUM2fcREBR/IWN2Kd0XHu870QVWcCekeZEIM9LDRchHFgVFxn6GcF5ixdum9PGzlfM0HECo1Wu4CCGuoIBenPVXFfaZvwrhpOE/9zbu7DaqJphAtGgc2ccgSGsZ2K59w08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790257880; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7AgugibO/MEoHQ8Kikz2u61NnM8OGtvR9wPH8In7gDU=; 
	b=DE9gLtJmKU8qQY6+4BqiOWEM5UDb0mgoko/iDW5Vrt0keEcJqVxD6Ps725Sgv2w0ILsAdORysUwv+fHdfA+Wp2jWOlPGa4LRKFn7cvo6ol8DuHARuKBFPJlsCPYN2c0HoWlyKKnuAdDtEi4uPGeQRU1O0JYLsTRj2xqXG3+2Ax4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790257880;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=7AgugibO/MEoHQ8Kikz2u61NnM8OGtvR9wPH8In7gDU=;
	b=eASH3DycQVpf7S4eUIcpJ2wkCZUAZL0W8yws7/JEHRGeY0pU5+CL5bGK+LRp+Xv0
	6dbp88Uay3W5vrCXXA3lFEQJLLiQMTxV/KVgdvHPorp+AzCkqUtAhbMhYL67y9LJgY4
	AsM05uZlAdq7JLP+0/7SlbTnBCsjtC3focg/rjgE=
Received: by smtp.zohomail.com with SMTPS id 1790257876818699.7771668051361;
	Thu, 24 Sep 2026 06:51:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:51:10 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
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
Message-ID: <20260924-outrageous-nebulous-spaniel-7bf6f7@anirudhrb>
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
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.230.26
X-ZohoMailClient: External

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

On arm64 can_set_direct_map() can return false making the
set_direct_map_valid_noflush() call a no-op.

	bool can_set_direct_map(void)
	{
		/*
		 * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
		 * map to be mapped at page granularity, so that it is possible to
		 * protect/unprotect single pages.
		 *
		 * KFENCE pool requires page-granular mapping if initialized late.
		 *
		 * Realms need to make pages shared/protected at page granularity.
		 */
		return rodata_full || debug_pagealloc_enabled() ||
			arm64_kfence_can_set_direct_map() || is_realm_world();
	}

So, there could be some scenarios where this patch doesn't solve the
problem. It is definitely an improvement over what's currently in the
tree though.

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

Should we batch this? (i.e. collect a batch of contiguous PFNs and restore them
at once)

> +		/*
> +		 * HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
> +		 * a 2MiB page, so deposited pages are of 4k granularity and cannot
> +		 * be collapses into a 2MiB page, which would require an allocation

511 is the limit for one deposit call. But after multiple deposit calls,
a deposited range can cover a 2 MiB page.

> +		 * and can potentially fail.

It is unclear to me what requires an allocation and can potentially
fail. Could you please clarify?

> +		 *
> +		 * Should it fail anyway we leak the page, if we would hand it
> +		 * back to the allocator we would introduce faults into random other
> +		 * parts.

I agree this is what we should do. I just don't understand what the
first part of this comment block is talking about.

Thanks,
Anirudh.

