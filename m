Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.59.206.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212145;
	b=Z3ifeejHs2G7ZZcvYHvChGQaSsyC++mAqz649rb//JyhhkBvHL3zQ/G8xPnO2584Yyiu
	 S3ggXRYzeDf5wRi8uWyl2SpITW8sFL4m3Kvn7umZhf9dp0kjddnAWBDTV1G/mXek/iCzb
	 dTC5AAo71lW7GJAl0M+tHdsYo6czRVCtaCjkabtUJcT3di2UfN4a6RPHWAoz9P9Ricl/Y
	 XdYUqL6M5+E8Wfpu2L2SWBUA5wgBMTxlmQWB+aEwubPlouLRQ0rSZAjj9rkEWT4bWMe26
	 JZAIL6jJaKpcmPYXcCag4jMayYEBt/EbPIzhdAmOGNP262SyJN+fogtMOmrh22mor/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212145;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=lSqJHM83HEGMB/dALp36Vpi95BnuVUaKo4Yx3v2mjGI=;
	b=BG1HYVHMCPTg0VEkczQBs93ftAvYg9MT2yCwpuIGiw6+eDFYWFGeaafTtd2V6ShLYrk5
	 c8uT++68HIbW7gz6GFpALw60i6slaKHKEsrsxGWbAhjvnwfPLgu9PeMnsC/eE+0oUA5p3
	 NZm8oP4bauYpOPvsXtpTRyVhSQq0Tav+iWbTpZz/qYLIN2eYSxS02/ZtwlubG6kYR3IxL
	 IeiThvCm7c9BIWlxWoBLmIIzMY800sYmgAqFzG61AOoHrxdeIjuvjz8GOoEcRCL+d4sU2
	 UD5VggYqOq6ZrroY2nxHmv9paqYcGa9tQTuZ8vz0bcKXVq1FRadwiubT/fh/aYmwXEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=GClSd0E4;
	arc=none smtp.remote-ip=194.59.206.189
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330A606A31D;
	Wed, 28 Oct 2026 18:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3330A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=GClSd0E4
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jFG8F185Zz4Yny;
	Wed, 28 Oct 2026 19:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793212109;
	bh=VBA7+aH0ah5aQc//ee4BUr0sp5oFph24masVhDF9LDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GClSd0E4a4+FwTWXzckpXzBgN99BYGmffnTxc5+O2fDqqe1RwvNEWokEtdYguqMnC
	 jBXpeVS2aCjF0PRQsjy7Li5NquCIZJV7GYh0zeSPCclQ1aq4BAU6YQS7eFcg9DXCUe
	 7QNKuEYw+qnv3aGJ+QHLM2hH2jzaT7Bin0JPFaMb0Js76mCbXtnxghXeb8k6ZFE29o
	 HZFnoJjvKUYNBmbvGiTAc5/MwNwh6kfpEOZDXPrylXkAcWm6HizdUkqRUSCWbmh2wh
	 /+MT3j1+rX8u5VCLdk5E9+OjKpeghi5ymWTaydTXQO8b/szwKeWdEkwFtOdefuBqPN
	 t7w+eHEqxvTmQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jFG8F0Pgjz7x7G;
	Wed, 28 Oct 2026 19:28:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jFG8C0QkDz8tdL;
	Wed, 28 Oct 2026 19:28:26 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B70DA5FA29;
	Wed, 28 Oct 2026 19:28:17 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <07246cb1-1154-4b66-9a05-209f04a2b427@leemhuis.info>
Date: Wed, 28 Oct 2026 19:28:15 +0100
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179321209847.3573970.1932748380206728237@mxe9fb.netcup.net>
X-NC-CID: U17wed8QA5AkefoeP/1F4TRwVnOSmSu6v35YJZdNN5vvYRo2aGA=

On 9/30/26 14:10, Magnus Kulke wrote:
> hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> ownership of those pages and per contract revokes root partition
> access to them, raising a #GP on access from the L1VH root partition.
> 
> However, the pages remain mapped in the kernel direct map, so kernel
> code may still access them even though the hypervisor has revoked
> access.

Wei, Magnus, this patch showed up in -next today and broke my daily
Fedora builds on x86_64 and arm64 which use the rawhide config as base.
Reverting it made the build succeed.

"""
> drivers/hv/hv_proc.c: In function ‘hv_deposit_update_direct_map’:
> drivers/hv/hv_proc.c:32:23: error: implicit declaration of function ‘set_direct_map_valid_noflush’; did you mean ‘set_direct_map_invalid_noflush’? [-Wimplicit-function-declaration]
>    32 |                 err = set_direct_map_valid_noflush(pfn_to_page(pfns[i]),
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                       set_direct_map_invalid_noflush
> make[4]: *** [scripts/Makefile.build:316: drivers/hv/hv_proc.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:598: drivers/hv] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:598: drivers] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builddir/build/BUILD/kernel-7.4.0-build/kernel-next-20261028/linux-7.4.0-0.0.next.20261028.509.vanilla.fc46.x86_64/Makefile:2252: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2
"""
Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/11219444-next-next-all/builder-live.log.gz

Ciao, Thorsten

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

