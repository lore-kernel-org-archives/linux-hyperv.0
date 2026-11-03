Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720416;
	b=Zzzn8vsf+l0T7RRkyY24YN0K+17mQ774AWE3CrACfxK/h/ftFWDwQpnUtU5xfOeNB+g7
	 0LAyBts3pJH7Xu9rrVimHTn9FnG6R6MxncmXL7ZCtTOYo/hJOhZWlNt7UhCdBnZAHKbN7
	 sVTVscubm+tjXilIr2KeJPW2Yp89uqno28JzJi2z27nY7DBDv0K2e1dytrqqkanwSjQb2
	 rWOmx980bZJStXcBHWNY4omSDWUEvQzg3iRE0h8P+YerOiX5YIHJKw6nahs8YjlDy0yQ2
	 ckQHPY2EuTuPQcKz1UCH+ZpysUvEdQFc/doJSvMD5EMu0O5NTgMgxW0/CxI1CLdiSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=snr3WXH9fzeMWS0Dd8T/kR35gWHG9EUZG7bSNvZxhxM=;
	b=ruw7cXjifl5X/wFXYyFgbmyDM1dnpeTz9E8xXoT46idgAzzHZL0iiVze7EZBM9ezYLN6
	 ZXSs0wzY0SpZwVpAsNla4d45XNrQxHx/w75uFxLtzEnNEHfjzTy4NWgAFfzgcW5a5p2f3
	 3mykQDLasKjOaNgIebHBfUQ8x5qxYDTtzR8Xt7XdKh2wI8fT9PtpyFXiTS2pJ9g3bi0iI
	 ItJUXjAbIJ1IbRbRJSwuvFKtELOHf0WI+PGeKszQavthn8QgJH9wNN0K8jyJLNT7QPoXE
	 jBiGTefSGtCS5rn3nNvs+Wye0bcLySSmL3IqIN6ITaS3BHVPuR64CSykgr/acdIL0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aoi4FZZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB63606A327
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aoi4FZZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B91F000C1;
	Tue,  3 Nov 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720415;
	bh=snr3WXH9fzeMWS0Dd8T/kR35gWHG9EUZG7bSNvZxhxM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Aoi4FZZYLL+qHO3EmMDxZXh/Y0/LR84v75DELObPD/8eEaurq8OIs6nAUJ9AHvP/V
	 TspAttaimjuNudMKRh3zJNP7Ey7emAoTBMSUL6DXdE7JBHL4shjv0JsWxiTaPX+DTo
	 MUogG1Nu+VRp+twvfFA05ZZ00muvHLMh7Wp7KPY6DEXamE+UjO9x7RFWPTeg6/TsY5
	 p37P61vU733fbb/7mqtLIK/5mZeGEe3MX116T5xLqhObYqCUwmChffLGa4fBk9MRZw
	 Xc+5oenvka4CMizKb60TPCGhKMMd7aOpjBRwLQriW3XI1LbshvwqRO1cwGd+rbbmle
	 tN4lcyLffbmEQ==
Message-ID: <sashiko-outbox-195628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] mshv: remove deposited pages from direct map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Kulke" <magnuskulke@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261103152416.404545-1-magnuskulke@linux.microsoft.com>
References: <20261103152416.404545-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:40:15 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mshv: unmapped direct-map access to deposited state and stats pages
- [Medium] mshv: hv_remove_deposit_mapping() restores untouched tail PFNs o=
n error
--

commit 13157bed008befe9046572707b45f4f66588f031
Author: Magnus Kulke <magnuskulke@linux.microsoft.com>

mshv: remove deposited pages from direct map

This commit removes pages deposited to the hypervisor via
HVCALL_DEPOSIT_MEMORY from the kernel direct map before hypercall submission
and restores them to the direct map when withdrawn or when depositing fails.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index f811bb5c42a1d..b63f8da1ecc13 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -7,12 +7,65 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/minmax.h>
>  #include <linux/export.h>
> +#include <linux/set_memory.h>
>  #include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
> =20
>  #define HV_DEPOSIT_MAX 512
>  #define HV_DEPOSIT_INP_MAX ((HV_HYP_PAGE_SIZE -  \
>  	offsetof(struct hv_deposit_memory, gpa_page_list)) / sizeof(u64))
> =20
> +static inline int find_consecutive_pfns(const u64 *pfns, int count, int =
start)
> +{
> +	int end;
> +
> +	if (start >=3D count)
> +		return count;
> +
> +	for (end =3D start + 1; end < count; ++end) {
> +		if (pfns[end] !=3D pfns[end - 1] + 1)
> +			break;
> +	}
> +
> +	return end;
> +}
> +
> +/*
> + * Remove pages from the direct map before depositing them. On failure,
> + * restore the mapping and free all supplied pages, leaking pages whose
> + * mappings cannot be restored.
> + */
> +static int hv_remove_deposit_mapping(const u64 *pfns, int count)
> +{
> +	int i, end, ret;
> +	unsigned long addr, size;
> +
> +	for (i =3D 0; i < count; i =3D end) {
> +		end =3D find_consecutive_pfns(pfns, count, i);
> +
> +		ret =3D set_direct_map_invalid_noflush(pfn_to_page(pfns[i]),
> +						   end - i);
> +		if (ret)
> +			goto restore;
> +	}
> +
> +	for (i =3D 0; i < count; i =3D end) {
> +		addr =3D (unsigned long)page_address(pfn_to_page(pfns[i]));
> +
> +		end =3D find_consecutive_pfns(pfns, count, i);
> +
> +		size =3D (unsigned long)(end - i) << PAGE_SHIFT;
> +		flush_tlb_kernel_range(addr, addr + size);
> +	}
> +
> +	return 0;
> +
> +restore:
> +	/* The failing run may have been partially modified too. */
> +	hv_restore_withdrawn_pages(pfns, count);
> +	return ret;
> +}

[Severity: Medium]
When set_direct_map_invalid_noflush() fails on run [i, end) and jumps to
restore, the trailing PFN runs in [end, count) have not been touched and
still have valid default mappings in the direct map.

Passing the full count to hv_restore_withdrawn_pages(pfns, count) runs
set_direct_map_default_noflush() on those untouched pages in [end, count) as
well:

drivers/hv/hv_proc.c:hv_restore_withdrawn_pages() {
    ...
		ret =3D set_direct_map_default_noflush(page, n);

		for (j =3D i; j < end; ++j) {
			page =3D pfn_to_page(pfns[j]);
			if (ret &&
			    WARN_ON_ONCE(set_direct_map_default_noflush(page, 1)))
				continue;
			__free_page(page);
		}
}

On arm64, set_direct_map_default_noflush() calls update_range_prot(), which
unconditionally calls split_kernel_leaf_mapping() before updating PTEs:

arch/arm64/mm/pageattr.c:update_range_prot() {
    ...
	ret =3D split_kernel_leaf_mapping(start, start + size);
	if (WARN_ON_ONCE(ret))
		return ret;
    ...
}

If set_direct_map_invalid_noflush() failed with -ENOMEM while splitting a
large leaf mapping, wouldn't set_direct_map_default_noflush() also fail to
split leaf mappings for the untouched pages in [end, count), triggering
WARN_ON_ONCE() and leaking pages in pfns[end .. count - 1] that were never
removed from the direct map?

Should the restore path only call hv_restore_withdrawn_pages(pfns, end) and
free the untouched pages in [end, count) directly via __free_page()?

[ ... ]

> @@ -125,6 +178,21 @@ static int hv_call_deposit_pages(int node, u64 parti=
tion_id, bool contiguous)
>  		num_pages =3D HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>  	}
> =20
> +	rc =3D hv_remove_deposit_mapping(pfna, num_pages);
> +	if (rc) {
> +		if (lastpfn)
> +			__free_page(pfn_to_page(lastpfn));
> +		goto out_free;
> +	}

[Severity: High]
Does unconditionally removing all deposited pages from the direct map cause
an unhandled page fault when the hypervisor maps VP state pages or stats
pages out of the deposited memory pool?

hv_deposit_memory_node() -> hv_call_deposit_pages() ->
hv_remove_deposit_mapping() marks all deposited pages invalid in the direct
map on both bare-metal root partitions and L1VH partitions.

When mshv_use_overlay_gpfn() is false (such as on bare-metal root partitions
where hv_l1vh_partition() is false, or on L1VH partitions without
vmm_can_provide_overlay_gpfn), hv_map_vp_state_page() and
hv_map_stats_page() do not supply a caller-allocated page. Instead,
HVCALL_MAP_VP_STATE_PAGE and HVCALL_MAP_STATS_PAGE allocate a page from the
partition's deposited memory pool and return its PFN in output->map_locatio=
n:

drivers/hv/mshv_root_hv_call.c:hv_call_map_vp_state_page() {
    ...
		if (!hv_result_needs_memory(status)) {
			if (hv_result_success(status))
				*state_page =3D pfn_to_page(output->map_location);
			local_irq_restore(flags);
			ret =3D hv_result_to_errno(status);
			break;
		}

		local_irq_restore(flags);

		ret =3D hv_deposit_memory(partition_id, status);
    ...
}

drivers/hv/mshv_root_hv_call.c:hv_call_map_stats_page() {
    ...
		ret =3D hv_deposit_memory(hv_current_partition_id, status);
		if (ret)
			return ret;
	} while (!ret);

	*addr =3D page_address(pfn_to_page(pfn));
    ...
}

Those returned PFNs are then converted to direct-map virtual addresses via
page_to_virt() in mshv_partition_ioctl_create_vp() (for
vp->vp_intercept_msg_page, vp->vp_register_page, and vp->vp_ghcb_page) and
page_address() in hv_call_map_stats_page() (as well as memremap(...,
MEMREMAP_WB) for root-partition SynIC pages when secondary CPUs deposit
memory to hv_current_partition_id) without restoring their direct-map PTEs.

When the kernel subsequently dereferences these addresses, for example in
mshv_debugfs_hv_stats_create() reading
stats[HV_HYPERVISOR_COUNTER_LOGICAL_PROCESSORS] or during VP execution in
mshv_vp_ioctl_run_vp() and mshv_vp_handle_intercept(), won't it fault on a
non-present direct-map page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103152416.4045=
45-1-magnuskulke@linux.microsoft.com?part=3D1
