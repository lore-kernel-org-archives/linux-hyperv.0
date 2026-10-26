Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025212;
	b=hVkdoRdd+2WlU0z9UG83SDHqPAjJn+jY1NC7A0581x9Dwi51w/YDjHJ5exFOwRg8J2+n
	 o77d3oh+mXDCibJBLi/dNDWqByiOlTf9bDSeQLYMV4UvzOr9ugP1DGY+pJAafEFtVLlYP
	 TvepTo7WaEYZLPipMUeJloTWZMUsvU9kgSKk1QTFM1oiT2mRxY54+UahSKx3DtpuUFrVr
	 9uyKr95MLCrVoxNnCcGBxgbBVsw75r+HmtWPdptOW58mgYnDcnv+C5yJ6brgv9ODF2a5l
	 41yspago8VSy9NqBYb0ovmLSUpoovV4RysrbUFPyCLeQP7rO7k4zV6lTJEu+FZwvnKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xIT6S5d1HDCmugC7oHxfMVvXkqjGEY1sxeALS9PXA/Q=;
	b=K8RgUywkZPGNYvrAJjeU08sbkPg0Vah8w5ZRsCLAhhlevoCyuyM9qkelbSZTH9PXqaf1
	 fIY/gWfn3qIpG947oQTBVR6ITSikheBaYQGX9NfNK3r5KBAdFr3FquXX49z4ZTaTWRxpi
	 QjNf27V7i5XRBW9LRdWs2tiVyv8K6OJROOH3JmpxsCT1+13fQKRV0jqxfmzMKmYkn2l1q
	 eMkW7W8JI9r+dwEvP9LlU3RfLnDt8IeIKKSRzxe4veXDNLDI3te5qtagq16HSTPdJbspo
	 N7Yeg+3f/THwqMZS6Q08bIC/kt1VN9J7hmWYHZLB73w8KwGmXnZlibXs0T3KfqT8T9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6bqmgig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12E606A31B
	for <linux-hyperv@vger.kernel.org>; Mon, 26 Oct 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6bqmgig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4F1F01828;
	Mon, 26 Oct 2026 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025212;
	bh=xIT6S5d1HDCmugC7oHxfMVvXkqjGEY1sxeALS9PXA/Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K6bqmgigWl/6NMfF5s7JFbFbSg6uHNizFRW+rn1OKwJ9BSxvj1nQ23HSzqe8BquN2
	 uNEZATBfL1g9/5ZKCyWEHKUCBZ5l0H8Kbr2QisO24vRJXdZtLJjFgvwjxdvqulCSyY
	 HFtMBHAK8mt7D6Lt66jkP8eAcjaEHwrHYWjhSUF9gZQFxWpTGlE78e0VynCJnkEOPo
	 kDRyn8BYIjRK04zORnw8hE7oSsDVOjLiBvHX7nmeaoAW1fKmr/IZgGIznvXBi7DLii
	 H+ggu9Z/qSs4Gm2EQbXa85dkMNCyCV2fFIKNbF0bnnpAXBoCSzK9MDMy9T4Gbu0SPQ
	 piL/DTC8TTUmw==
Message-ID: <sashiko-outbox-185406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261026141512.2987985-7-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
 <20261026141512.2987985-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:33:31 +0000
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
- [High] mshv: NULL pointer dereference of vp->vp_register_page in mshv_vp_=
dispatch()
- [Medium] mshv: inconsistent HV_SUPPORTS_SEV_SNP_GUESTS guards in SNP paths
--

commit f7de1a4b156916782dca3e11c51b478fa7c24bc8
Author: Wei Liu <wei.liu@kernel.org>

mshv: wire SEV-SNP partition ioctls

This commit wires the SEV-SNP UAPI into partition creation, memory ownership
tracking, isolated-page import, launch completion, PSP guest requests, AP
creation, and partition teardown. It tracks per-page host access permissions
and ownership state in bitmaps on each pinned memory region and restores
host access on failure or teardown.

> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 78508b57b5ad4..40fd775d8d9df 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
[ ... ]
> @@ -376,6 +444,24 @@ extern u8 * __percpu *hv_synic_eventring_tail;
> =20
>  struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
>  					   u64 uaddr, u32 flags);
> +int mshv_region_host_access_init(struct mshv_mem_region *region);
> +int mshv_region_check_duplicate_pfns(struct mshv_mem_region *region);
> +u8 mshv_region_host_access_get(const struct mshv_mem_region *region, u64=
 index);
> +void mshv_region_host_access_set(struct mshv_mem_region *region, u64 ind=
ex,
> +				 u8 state);
> +u8 mshv_make_host_access_state(u8 old_state, u32 host_access, u32 flags);
> +int mshv_apply_region_host_access(struct mshv_mem_region *region,
> +				  u64 index, u64 count, u32 host_access,
> +				  u32 flags,
> +				  struct mshv_host_access_result *result);
> +int mshv_apply_host_access(struct mshv_host_access_page *host_pages,
> +			   u64 count, u32 host_access, u32 flags,
> +			   struct mshv_host_access_result *result);
> +bool mshv_region_host_access_is_baseline(const struct mshv_mem_region *r=
egion);
> +int mshv_validate_modify_gpa_page_count(u64 page_count);
> +bool mshv_u64_array_has_duplicates(u64 *values, u64 count);
> +int mshv_run_snp_teardown(const struct mshv_snp_teardown_ops *ops, void =
*data,
> +			  enum mshv_snp_teardown_phase *failed_phase);
>  int mshv_region_share(struct mshv_mem_region *region);
>  int mshv_region_unshare(struct mshv_mem_region *region);
>  int mshv_region_map(struct mshv_mem_region *region);
> @@ -388,6 +474,11 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_re=
gion *region, u64 gfn);
>  void mshv_region_movable_fini(struct mshv_mem_region *region);
>  bool mshv_region_movable_init(struct mshv_mem_region *region);
> =20
> +int hv_call_set_partition_property(u64 partition_id, u64 property_code,
> +				   u64 property_value,
> +				   void (*completion_handler)(void *, u64 *),
> +				   void *completion_data);
> +
>  #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
>  int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
>  				  u64 num_pages, u64 *completed_pages,
[ ... ]
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 751cbf8d4e824..2bc834767e01f 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1297,69 +1362,82 @@ static int mshv_prepare_pinned_region(struct mshv=
_mem_region *region)
> =20
>  	ret =3D mshv_region_pin(region);
>  	if (ret) {
> -		pt_err(partition, "Failed to pin memory region: %d\n",
> -		       ret);
> -		goto err_out;
> +		pt_err(partition, "Failed to pin memory region: %d\n", ret);
> +		return ret;
>  	}
> =20
> -	/*
> -	 * For an SNP partition it is a requirement that for every memory region
> -	 * that we are going to map for this partition we should make sure that
> -	 * host access to that region is released. This is ensured by doing an
> -	 * additional hypercall which will update the SLAT to release host
> -	 * access to guest memory regions.
> -	 */
>  	if (mshv_partition_encrypted(partition)) {
> -		ret =3D mshv_region_unshare(region);
> +		int recovery_ret;
> +
> +		ret =3D mshv_region_host_access_init(region);
> +		if (ret)
> +			goto invalidate_region;
> +
> +		ret =3D mshv_region_check_duplicate_pfns(region);
>  		if (ret) {
> -			pt_err(partition,
> -			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
> -			       region->start_gfn, ret);
> +			if (ret =3D=3D -EEXIST)
> +				pt_err_ratelimited(partition,
> +						   "Duplicate pinned PFN\n");
> +			else
> +				pt_err_ratelimited(partition,
> +						   "Pinned PFN audit failed: %d\n",
> +						   ret);
>  			goto invalidate_region;
>  		}
> -	}
> -
> -	ret =3D mshv_region_map(region);
> -	if (ret) {
> -		int shrc;
> -
> -		/*
> -		 * A partial map must be removed before host access is
> -		 * restored.
> -		 */
> -		if (region->mapping_may_exist) {
> -			int cleanup_ret =3D mshv_region_unmap(region);
> =20
> -			if (cleanup_ret || region->mapping_may_exist) {
> +		ret =3D mshv_region_unshare(region);
[ ... ]
> @@ -1940,6 +2730,92 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
[ ... ]
> +static void destroy_partition(struct mshv_partition *partition)
> +{
> +	struct mshv_vp *vp;
> +	struct mshv_mem_region *region;
> +	struct hlist_node *n;
> +	bool memory_torn_down =3D false;
> +	int ret;
> +	int i;
> +
> +	if (refcount_read(&partition->pt_ref_count)) {
> +		pt_err(partition,
> +		       "Attempt to destroy partition but refcount > 0\n");
> +		return;
> +	}
> +
> +	trace_mshv_destroy_partition(partition->pt_id);
> +
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +	if (mshv_partition_encrypted(partition)) {
> +		enum mshv_snp_teardown_phase failed_phase;
> +
> +		ret =3D mshv_run_snp_teardown(&mshv_snp_teardown_ops, partition,
> +					    &failed_phase);
> +		if (ret) {
> +			if (failed_phase =3D=3D MSHV_SNP_TEARDOWN_ISOLATION)
> +				pt_err(partition,
> +				       "Failed to destroy SNP isolation: %d\n",
> +				       ret);
> +			mshv_quarantine_partition(partition);
> +			return;
> +		}
> +		memory_torn_down =3D true;
> +	}
> +#endif

[Severity: Medium]
Are the HV_SUPPORTS_SEV_SNP_GUESTS guards consistent across the SNP setup,
teardown, and helper declarations?

In include/hyperv/hvgdk_mini.h, HV_SUPPORTS_SEV_SNP_GUESTS is only defined
under CONFIG_X86, whereas CONFIG_MSHV_ROOT is built on both X86_64 and ARM6=
4.

When HV_SUPPORTS_SEV_SNP_GUESTS is not defined:

1. mshv_ioctl_process_pt_flags() still accepts MSHV_PT_ISOLATION_SNP and se=
ts
   HV_PARTITION_ISOLATION_TYPE_SNP, and mshv_prepare_pinned_region() still
   initializes the host-access bitmaps and unshares pages out of baseline
   when mshv_partition_encrypted(partition) is true. However, the SNP ioctls
   and the mshv_run_snp_teardown() path in destroy_partition() are compiled
   out under #ifdef HV_SUPPORTS_SEV_SNP_GUESTS, leaving no teardown path to
   restore baseline host access before mshv_region_destroy() checks
   WARN_ON_ONCE(!mshv_region_host_access_is_baseline(region)).

2. In drivers/hv/mshv_root.h, mshv_validate_modify_gpa_page_count(),
   mshv_u64_array_has_duplicates(), and hv_call_set_partition_property() are
   declared outside #ifdef HV_SUPPORTS_SEV_SNP_GUESTS (alongside
   mshv_run_snp_teardown()), but their definitions in
   drivers/hv/mshv_root_main.c and drivers/hv/mshv_root_hv_call.c are wrapp=
ed
   inside #ifdef HV_SUPPORTS_SEV_SNP_GUESTS, which will cause link errors on
   ARM64 if KUnit tests or other callers reference them.

Should MSHV_PT_ISOLATION_SNP be rejected in mshv_ioctl_process_pt_flags() w=
hen
HV_SUPPORTS_SEV_SNP_GUESTS is not defined, and should those helper definiti=
ons
and declarations share the same guard?

[ ... ]
> @@ -2167,6 +3045,9 @@ static long mshv_ioctl_process_pt_flags(void __user=
 *user_arg, u64 *pt_flags,
>  	case MSHV_PT_ISOLATION_NONE:
>  		isol_props->isolation_type =3D HV_PARTITION_ISOLATION_TYPE_NONE;
>  		break;
> +	case MSHV_PT_ISOLATION_SNP:
> +		isol_props->isolation_type =3D HV_PARTITION_ISOLATION_TYPE_SNP;
> +		break;
>  	}

[Severity: High]
With MSHV_PT_ISOLATION_SNP now enabled here, can running a VP on an SEV-SNP
partition with the root scheduler dereference a NULL vp->vp_register_page in
mshv_vp_dispatch() when trace_mshv_hvcall_dispatch_vp() is enabled on
CONFIG_X86_64?

When mshv_partition_encrypted(partition) is true,
mshv_partition_ioctl_create_vp() skips mapping HV_VP_STATE_PAGE_REGISTERS a=
nd
leaves vp->vp_register_page as NULL:

drivers/hv/mshv_root_main.c:mshv_partition_ioctl_create_vp() {
    ...
	if (!mshv_partition_encrypted(partition)) {
		ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
					   HV_VP_STATE_PAGE_REGISTERS,
					   input_vtl_zero, &register_page);
		if (ret)
			goto unmap_intercept_message_page;
	}
    ...
	if (!mshv_partition_encrypted(partition))
		vp->vp_register_page =3D page_to_virt(register_page);
    ...
}

The other root-scheduler paths use mshv_vp_interrupt_pending(), which checks
for a NULL vp->vp_register_page before reading interrupt_vectors:

drivers/hv/mshv_root_main.c:mshv_vp_interrupt_pending() {
	if (!vp->vp_register_page)
		return 0;
	return vp->vp_register_page->interrupt_vectors.as_uint64;
}

However, in mshv_vp_ioctl_run_vp() -> mshv_run_vp_with_root_scheduler() ->
mshv_vp_dispatch(), the tracepoint call dereferences vp->vp_register_page
directly with preemption disabled:

drivers/hv/mshv_root_main.c:mshv_vp_dispatch() {
    ...
	trace_mshv_hvcall_dispatch_vp(vp->vp_partition->pt_id,
				      vp->vp_index, flags,
				      output->dispatch_state,
				      output->dispatch_event,
#if defined(CONFIG_X86_64)
				      vp->vp_register_page->interrupt_vectors.as_uint64,
#else
				      0,
#endif
				      status);
    ...
}

Should mshv_vp_dispatch() pass mshv_vp_interrupt_pending(vp) to
trace_mshv_hvcall_dispatch_vp() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026141512.2987=
985-1-weh@linux.microsoft.com?part=3D6
