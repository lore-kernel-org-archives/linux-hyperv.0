Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212319;
	b=2aRwVL8TvNGRs2pp9/XEAefdG6VhNrBvRFmDYxCI1bAaEHQDKMlQz81gK3iTTSbfX1mZ
	 wOCKIIpKTkjEXUfc6090MN288QXCEXvJBVf9nXwMPdlxvL4xOKTW4DXA0hgQFdri9lSKO
	 OUsGgE265/R3Jh0JpG8GiLhmjDs/y9y+iFiWk8qzp90pWZnEMY7YChAKIbr121u+az8ly
	 uq0BRIwtAXko1abPGhzVDQaaSMP8kzhQseEGmuU3s/6tZjO6MsWvKB6N70tamb+HNPnVX
	 WiQdR+9adWVvT97cGWq5xfzCGp+tnt2JcecKGAZDO2WGXPBdxw6YxhDEft1Zz+uZJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ghhDGGx/7hBw9mEgNWE6Bl/InzcO7uxTtfNEwQ2pmxw=;
	b=kyHSN5TkkYuayuvLs+wOH+8xf2t7L6794OQZWsMho+TU2PpSA/bLAq8mRAKMs+Qtvth8
	 eaOUpfn5mtoqOHOWkur2x04D2B8QuobBiSXnHT1MpxA4QqKy+ds0WYPg6p4Ldim5/SPDG
	 /348zuuHUp32W6ZEm2ew++WWLZY+gwqNw5VS6tEo0QPzFP/Pj4UOrpQ2pRATSa4QAvhAF
	 XgZrK9qi7u3YuiQdGfP2PwfBvaE7HTvHbCQpO/aERl+0czkoQ+byor4tESwAm+v/TSMRE
	 P4f4AkBqhP2LGGt9hrjp50JY8nOhZtEmkzFrkRlTzeljqec6qnPlYm6YuI/WA1WA2aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhLpJxgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEF606A31A;
	Wed, 28 Oct 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhLpJxgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F741F01828;
	Wed, 28 Oct 2026 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212318;
	bh=ghhDGGx/7hBw9mEgNWE6Bl/InzcO7uxTtfNEwQ2pmxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GhLpJxgtyXWQ7mZOZKpfocS1u06EHb9nWfYVIMeHLYr4P+qRzlMXx+Ly6QWN9kT8s
	 UfyJ0frrdtufoypkRrRugecF/QkjcPt5fr5veWk9FfEJCAqR9STE22xK1fUOvcwoaj
	 HIPcm65NZTnn6ShHcVHyqBf9pNaXZJXAaAmVW97GNZtBjzH30euB6ciKfeVR8J/ib2
	 O9Gd6abrZ3Hfj5oKXTxVSKDhFiQzlzOYL7b/7n7z7hhdKNFCvqRhpuLWkUkmnQUXH0
	 AURiPuLeye9kFVqJWT/zjsElrAsruR4aobCEVlqxL45W7ZQCHqUgpjqfYpdZpU4+bp
	 B4qEJk5dL29tw==
Date: Wed, 28 Oct 2026 11:31:57 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Wei Liu <liuwe@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Message-ID: <20261028183157.GA3595008@liuwe-devbox-debian-v2.local>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
 <07246cb1-1154-4b66-9a05-209f04a2b427@leemhuis.info>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07246cb1-1154-4b66-9a05-209f04a2b427@leemhuis.info>

On Wed, Oct 28, 2026 at 07:28:15PM +0100, Thorsten Leemhuis wrote:
> On 9/30/26 14:10, Magnus Kulke wrote:
> > hv_call_deposit_pages() donates pages (deposit) to hypervisor for L2
> > guest on L1VH systems via HVCALL_DEPOSIT_MEMORY. The hypervisor takes
> > ownership of those pages and per contract revokes root partition
> > access to them, raising a #GP on access from the L1VH root partition.
> > 
> > However, the pages remain mapped in the kernel direct map, so kernel
> > code may still access them even though the hypervisor has revoked
> > access.
> 
> Wei, Magnus, this patch showed up in -next today and broke my daily
> Fedora builds on x86_64 and arm64 which use the rawhide config as base.
> Reverting it made the build succeed.
> 

Can you share the kconfig?

Thanks,
Wei

> """
> > drivers/hv/hv_proc.c: In function ‘hv_deposit_update_direct_map’:
> > drivers/hv/hv_proc.c:32:23: error: implicit declaration of function ‘set_direct_map_valid_noflush’; did you mean ‘set_direct_map_invalid_noflush’? [-Wimplicit-function-declaration]
> >    32 |                 err = set_direct_map_valid_noflush(pfn_to_page(pfns[i]),
> >       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                       set_direct_map_invalid_noflush
> > make[4]: *** [scripts/Makefile.build:316: drivers/hv/hv_proc.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [scripts/Makefile.build:598: drivers/hv] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [scripts/Makefile.build:598: drivers] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [/builddir/build/BUILD/kernel-7.4.0-build/kernel-next-20261028/linux-7.4.0-0.0.next.20261028.509.vanilla.fc46.x86_64/Makefile:2252: .] Error 2
> > make: *** [Makefile:256: __sub-make] Error 2
> """
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/11219444-next-next-all/builder-live.log.gz
> 
> Ciao, Thorsten
> 
> > Helpers such as "load_unaligned_zeropad()" deliberately read past the
> > end of a buffer and across page boundaries. A read into an unmapped
> > page is tolerated and triggers a #PF, for which the kernel executes
> > a fixup in the exception table.
> > 
> > If such a call steps into a page that has been deposited, the access
> > raises a #GP by the hypervisor from which the above handler cannot
> > recover and the kernel panics:
> > 
> >   Oops: general protection fault, maybe for address 0xff1100941a3dfffc
> >   RIP: 0010:csum_partial+0xe5/0x110
> > 
> > This condition will appear on L1VH system that have created L2
> > partitions (and hence deposited pages) and exercise networking code
> > paths such as csum_partial() can trigger this condition when a buffer
> > ends close to a page boundary (e.g fffc in the above example).
> > 
> > The fix is to remove the deposited pages from the direct map before
> > they are passed to the hypervisor, and restore them when the hypervisor
> > returns them again.
> > 
> > We want to avoid flushing the TLB in the loop, so we use the _noflush()
> > variant of set_direct_map_valid() when marking a deposited page invalid
> > and flush the affected page ranges in one go ourselves. In the opposite
> > direction this is not required:
> > 
> >   > If a paging-structure entry is modified to change the P flag from
> >   > 0 to 1, no invalidation is necessary. This is because no TLB entry
> >   > or paging-structure cache entry is created with information from a
> >   > paging-structure entry in which the P flag is 0.
> > 
> > (Intel SDM Vol. 3, 4.10.4.3)
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> > Changes since v3:
> > - Batch contiguous pages in the restore path
> > - Adjusted comment about failure modes
> > 
> > Changes since v2:
> > - Checkpatch format fix
> > 
> > Changes since RFC:
> > - Handle direct-map restoration failures without returning unmapped
> >   pages to the allocator.
> > - Move freeing of withdrawn pages into the restoration helper.
> > ---
> >  drivers/hv/hv_proc.c           | 83 +++++++++++++++++++++++++++++++++-
> >  drivers/hv/mshv_root_hv_call.c |  4 +-
> >  include/asm-generic/mshyperv.h |  4 ++
> >  3 files changed, 87 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 57b2c64197cb..b056051a5ac5 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -7,7 +7,9 @@
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/minmax.h>
> >  #include <linux/export.h>
> > +#include <linux/set_memory.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/tlbflush.h>
> >  
> >  /*
> >   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
> > @@ -15,6 +17,35 @@
> >   */
> >  #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
> >  
> > +/*
> > + * Add or remove a set of physically contiguous page runs from the kernel
> > + * direct map. Once a page has been deposited the hypervisor owns it and
> > + * revokes root partition access to it.
> > + */
> > +static int hv_deposit_update_direct_map(struct page **pages, int *counts,
> > +					int num_allocations, bool valid)
> > +{
> > +	int i, err, ret = 0;
> > +
> > +	for (i = 0; i < num_allocations; ++i) {
> > +		err = set_direct_map_valid_noflush(pages[i], counts[i], valid);
> > +		if (err && !ret)
> > +			ret = err;
> > +	}
> > +
> > +	if (valid)
> > +		return ret;
> > +
> > +	for (i = 0; i < num_allocations; ++i) {
> > +		unsigned long addr = (unsigned long)page_address(pages[i]);
> > +		unsigned long size = (unsigned long)counts[i] << PAGE_SHIFT;
> > +
> > +		flush_tlb_kernel_range(addr, addr + size);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /* Deposits exact number of pages. Must be called with interrupts enabled.  */
> >  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >  {
> > @@ -72,6 +103,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >  	}
> >  	num_allocations = i;
> >  
> > +	ret = hv_deposit_update_direct_map(pages, counts, num_allocations, false);
> > +	if (ret)
> > +		goto err_restore_direct_map;
> > +
> >  	local_irq_save(flags);
> >  
> >  	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > @@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >  	if (!hv_result_success(status)) {
> >  		hv_status_err(status, "\n");
> >  		ret = hv_result_to_errno(status);
> > -		goto err_free_allocations;
> > +		goto err_restore_direct_map;
> >  	}
> >  
> >  	ret = 0;
> >  	goto free_buf;
> >  
> > +err_restore_direct_map:
> > +	/*
> > +	 * We don't want to return pages to the allocator if weren't able to
> > +	 * mark them valid in the direct map.
> > +	 */
> > +	if (hv_deposit_update_direct_map(pages, counts, num_allocations, true)) {
> > +		WARN(1, "leaking %d page block(s) that could not be set to valid\n",
> > +		     num_allocations);
> > +		goto free_buf;
> > +	}
> > +
> >  err_free_allocations:
> >  	for (i = 0; i < num_allocations; ++i) {
> >  		base_pfn = page_to_pfn(pages[i]);
> > @@ -110,6 +156,41 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> >  }
> >  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> >  
> > +/*
> > + * Put withdrawn pages back in the direct map. Counterpart to the direct map
> > + * removal done by hv_call_deposit_pages().
> > + */
> > +void hv_restore_withdrawn_pages(const u64 *pfns, int count)
> > +{
> > +	int i, j, end, n, ret;
> > +	struct page *page;
> > +
> > +	for (i = 0; i < count; i = end) {
> > +		page = pfn_to_page(pfns[i]);
> > +		/* find consecutive runs of pfns */
> > +		for (end = i + 1; end < count; ++end) {
> > +			if (pfns[end] != pfns[end - 1] + 1)
> > +				break;
> > +		}
> > +		n = end - i;
> > +		ret = set_direct_map_valid_noflush(page, n, true);
> > +
> > +		for (j = i; j < end; ++j) {
> > +			page = pfn_to_page(pfns[j]);
> > +			/*
> > +			 * Retry individually on failed batch. We don't want
> > +			 * to return pages to the allocator that we couldn't mark
> > +			 * valid in the direct map.
> > +			 */
> > +			if (ret &&
> > +			    WARN_ON_ONCE(set_direct_map_valid_noflush(page, 1, true)))
> > +				continue;
> > +			__free_page(page);
> > +		}
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
> > +
> >  int hv_deposit_memory_node(int node, u64 partition_id,
> >  			   u64 hv_status)
> >  {
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index cb55d4d4be2e..150a0c63ebc8 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -46,7 +46,6 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
> >  	struct page *page;
> >  	u16 completed;
> >  	u64 status, withdrawn = 0;
> > -	int i;
> >  	unsigned long flags;
> >  
> >  	page = alloc_page(GFP_KERNEL);
> > @@ -69,8 +68,7 @@ int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
> >  
> >  		completed = hv_repcomp(status);
> >  
> > -		for (i = 0; i < completed; i++)
> > -			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> > +		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
> >  
> >  		if (!hv_result_success(status)) {
> >  			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index bf601d67cecb..397c8ec0ce9a 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -346,6 +346,7 @@ static inline bool hv_parent_partition(void)
> >  bool hv_result_needs_memory(u64 status);
> >  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
> >  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> > +void hv_restore_withdrawn_pages(const u64 *pfns, int count);
> >  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> >  int hv_call_notify_all_processors_started(void);
> >  bool hv_lp_exists(u32 lp_index);
> > @@ -364,6 +365,9 @@ static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_page
> >  {
> >  	return -EOPNOTSUPP;
> >  }
> > +
> > +static inline void hv_restore_withdrawn_pages(const u64 *pfns, int count) { }
> > +
> >  static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
> >  {
> >  	return -EOPNOTSUPP;
> 
