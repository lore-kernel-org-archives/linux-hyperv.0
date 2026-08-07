Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F21281369
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113950; cv=none; b=MAIDLtm+I1GNvQL9Q3+alYYXdfZAX0TUVJDkfqwvvFu9eVHwZGwN+WsWyx+iXihJcn9CGGaQRdu5P1cvcHxYaj1+sqFvVZD2XMiw+bb3bDDZFbA9VT8YV8AyBRWOPS93j3NFZhsoDGRJj0F//DtXIq1yTyhu5XDTvQOwYRHo7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113950; c=relaxed/simple;
	bh=EZmYjWAOif0Wr5MUbvyN1p6T/nRD6VIJFBQ5coL0wsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtZrd/Hc+tCOBbau9ZA/iOWGJkGWGecgFlFQFLERwOLNYbFo3AQ86YQiA0MajLzNwxYUvM119PylG7NsBxIKmgDBo/P5aEFrYeeY27l8D2x6NlqWNQX9oLQAzFNZ0f0UxeaStdqGlFwG1GnuHqrPP3P6ad0jJ5D0yJB7QjmEgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuJwAYvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuJwAYvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1291F000E9;
	Fri,  7 Aug 2026 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113947;
	bh=IMznl2OHG0/AC3169KetRd29OfWRybx6kcdvMsoj8o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VuJwAYvDZHgR+BdMBNkWaogXhpETDYO6oUXoaFSlZOU2cKkVxrn1SI3rw6XXrVGaz
	 nud8jGir0sVsJ8QIrsCKL2yC00VUAoXoD3nHG2IHr0++iNqs1kcmn9KTzbPoNfkRWN
	 HfNPFuraRcsk5sJXdEqicN/eIfU5RF2vwVP7GNluxlIKJZ1THvl7r9dhPOTebTXBWh
	 iv44OjoXupJN9xS4ZEFfy/9Atk2Le5yuXDp4qGeHCboYsOBxC9bW7Jf+adm4VEzt2I
	 xCGoyNnyFPYrBaSGEKxihOT53tPRUVvMCUEdPs5RKXLviGqn3iLkSZeebhew7yCOxA
	 VAjWBxhibubvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-5-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-5-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:45:47 +0000
Message-Id: <20260807144547.CC1291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] The `MSHV_MODIFY_GPA_HOST_ACCESS` ioctl lacks physical contigu=
ity validation when `MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE` is specified, all=
owing a malicious guest to alter host access for arbitrary physical memory.
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) race condition in `mshv_=
gpfns_to_pages()` drops the region lock without pinning pages, allowing use=
-after-free of `struct page` pointers.
- [High] A failure in `destroy_snp_partition_state()` aborts `destroy_parti=
tion()` early, permanently leaking the partition struct, its virtual proces=
sors (VPs), memory regions, and hypervisor resources.
- [High] Unbounded `kcalloc` of user-controlled `page_count` in `mshv_parti=
tion_ioctl_modify_gpa_host_access` can trigger `MAX_ORDER` kernel warnings =
and unexpected allocation failures.
- [High] Stale `completed` rep count in `hv_call_import_isolated_pages()` a=
nd `mshv_ioctl_passthru_hvcall()` causes an infinite loop during asynchrono=
us rep hypercalls.

Pre-existing issues:
- [Critical] Missing `local_irq_restore` on the error path in `hv_call_modi=
fy_spa_host_access()` permanently disables interrupts.
- [High] A flawed completion check in `mshv_init_async_handler()` permanent=
ly bricks the partition after the first async hypercall completes.
- [High] The passthrough hypercall ioctl (`mshv_ioctl_passthru_hvcall`) lea=
ks uninitialized kernel memory to userspace due to allocating output pages =
without `__GFP_ZERO`.
--

--- Patch [4]: [PATCH v1 04/13] mshv: wire SEV-SNP partition ioctls ---
commit bad2199bf3a355afbf48396c10943374ce6f9e11
Author: Wei Liu <wei.liu@kernel.org>
Subject: mshv: wire SEV-SNP partition ioctls

Wire the SEV-SNP partition ioctls for GPA host-access changes,
isolated-page import, PSP guest requests, AP creation, and SNP partition
teardown.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -1014,6 +1014,41 @@ int hv_unmap_stats_page(...)
[ ... ]
> +int hv_call_import_isolated_pages(u64 partition_id, u64 *pages,
> +				  u64 num_pages,
> +				  enum hv_isolated_page_type page_type,
> +				  enum hv_isolated_page_size page_size,
> +				  void (*completion_handler)(void *data,
> +							     u64 *status),
> +				  void *completion_data)
> +{
[ ... ]
> +	while (remaining) {
[ ... ]
> +		completed =3D hv_repcomp(status);
> +		if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING)
> +			completion_handler(completion_data, &status);
> +
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: completed %llu of %llu, %s\n", __func__,
> +			       num_pages - remaining, num_pages,
> +			       hv_result_to_string(status));
> +			return hv_result_to_errno(status);
> +		}
> +
> +		gpa +=3D completed;
> +		remaining -=3D completed;
> +	}

[Severity: High]
Will this cause an infinite loop during asynchronous rep hypercalls?

When the hypercall returns HV_STATUS_CALL_PENDING, completed is evaluated
as 0 before the completion_handler is invoked. After the handler updates
the status with the final result, completed is never recalculated.=20

This means remaining -=3D completed subtracts 0, causing the loop to spin
indefinitely and hanging the kernel thread.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -641,6 +646,42 @@ mshv_partition_region_by_gfn_get(struct mshv_partiti=
on *p, u64 gfn)
> +static int mshv_gpfns_to_pages(struct mshv_partition *partition,
> +			       const u64 *gpfns, u64 page_count,
> +			       struct page **pages)
> +{
[ ... ]
> +		offset =3D gfn - region->start_gfn;
> +		mutex_lock(&region->mreg_mutex);
> +		if (offset >=3D region->nr_pages || !region->mreg_pages[offset]) {
> +			ret =3D -EFAULT;
> +			mutex_unlock(&region->mreg_mutex);
> +			mshv_region_put(region);
> +			return ret;
> +		}
> +
> +		pages[i] =3D region->mreg_pages[offset];
> +		mutex_unlock(&region->mreg_mutex);
> +		mshv_region_put(region);
> +	}

[Severity: Critical]
Does this drop the region lock without pinning the returned pages?

The struct page pointers are copied into the pages array under the region
mutex, but the lock is dropped without elevating the page reference count
with get_page().=20

A concurrent thread or user action like munmap could trigger the MMU
interval notifier, unmap the pages, and return them to the allocator.

Later, when hv_call_modify_spa_host_access() processes these pointers via
page_to_pfn(), it might trick the hypervisor into revoking host access to
memory that has already been reallocated to another process or the kernel.

> @@ -1625,6 +1666,260 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
> +static long
> +mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
[ ... ]
> +	if ((args.flags & ~MSHV_GPA_HOST_ACCESS_FLAGS_MASK) ||
> +	    mshv_field_nonzero(args, rsvd) || !args.page_count)
> +		return -EINVAL;
> +
> +	gpfns =3D vmemdup_user((char __user *)user_args +
> +			     offsetof(struct mshv_modify_gpa_host_access,
> +				      guest_pfns),
> +			     size_mul(sizeof(*gpfns), args.page_count));
> +	if (IS_ERR(gpfns))
> +		return PTR_ERR(gpfns);
> +
> +	pages =3D kcalloc(args.page_count, sizeof(*pages), GFP_KERNEL);
> +	if (!pages) {
> +		ret =3D -ENOMEM;
> +		goto free_gpfns;
> +	}

[Severity: High]
Could this unbounded allocation trigger kernel warnings or unexpected failu=
res?

The args.page_count parameter is user-controlled and directly passed to
kcalloc with GFP_KERNEL. Since kcalloc relies on contiguous physical memory
allocation, passing an excessively large count could exceed the MAX_ORDER
limit.=20

This would trigger a loud kernel warning stack trace and fail the request.
Should this cap the page count or fallback to kvcalloc instead?

> +	for (i =3D 0; i < args.page_count; i++)
> +		gpfns[i] =3D HVPFN_DOWN(gpfns[i]);
> +
> +	ret =3D mshv_gpfns_to_pages(partition, gpfns, args.page_count, pages);
> +	if (ret)
> +		goto free_pages;
> +
> +	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_READABLE))
> +		host_access |=3D HV_MAP_GPA_READABLE;
> +	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_WRITABLE))
> +		host_access |=3D HV_MAP_GPA_WRITABLE;
> +	if (args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE))
> +		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
> +	acquire =3D args.flags & BIT(MSHV_GPA_HOST_ACCESS_BIT_ACQUIRE);
> +
> +	ret =3D hv_call_modify_spa_host_access(partition->pt_id, pages,
> +					     args.page_count, host_access,
> +					     flags, acquire);

[Severity: Critical]
Can a malicious guest exploit the large page flag to alter host access for
arbitrary physical memory?

When MSHV_GPA_HOST_ACCESS_BIT_LARGE_PAGE is passed,
hv_call_modify_spa_host_access() iterates in 512-page chunks, extracts the
PFN from only the first struct page, and passes it to the hypervisor as the
base of a contiguous 2MB large page:

drivers/hv/mshv_root_hv_call.c:hv_call_modify_spa_host_access()
        for (i =3D 0; i < rep_count; i++) {
                u64 index =3D (done + i) << large_shift;
                if (index >=3D page_struct_count)
                        return -EINVAL;
                input_page->spa_page_list[i] =3D
                                        page_to_pfn(pages[index]);
        }

However, mshv_gpfns_to_pages() resolves the user-provided GFNs into struct
page pointers completely independently. If a user provides 512 unrelated
GFNs, the hypervisor might grant or revoke permissions on the 2MB physical
block starting at the first page's PFN, bypassing validation.

[Severity: Critical]
This is a pre-existing issue, but wiring up this ioctl exposes a pre-existi=
ng
error path that leaves local interrupts disabled.

In the underlying hv_call_modify_spa_host_access() function, local IRQs are
disabled via local_irq_save(), but an early return on invalid indices fails
to restore them:

drivers/hv/mshv_root_hv_call.c:hv_call_modify_spa_host_access()
        local_irq_save(irq_flags);
        ...
        for (i =3D 0; i < rep_count; i++) {
                u64 index =3D (done + i) << large_shift;
                if (index >=3D page_struct_count)
                        return -EINVAL;
                ...
        }
        ...
        local_irq_restore(irq_flags);

Returning -EINVAL without calling local_irq_restore() will permanently
disable hardware interrupts on the executing CPU.

> +static long
> +mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partit=
ion,
> +					   void __user *user_args)
> +{
[ ... ]
> +	ret =3D mshv_init_async_handler(partition);
> +	if (ret)
> +		goto out;

[Severity: High]
This is a pre-existing issue, but will this permanently block async
hypercalls after the very first one completes?

The mshv_init_async_handler() function uses completion_done() to check if
an async hypercall is in progress:

drivers/hv/mshv_root_main.c:mshv_init_async_handler()
        if (completion_done(&partition->async_hypercall)) {
                pt_err(partition,
                       "Cannot issue async hypercall while another one in p=
rogress!\n");
                return -EPERM;
        }

However, completion_done() returns true if a completion has already finished
successfully (count > 0). If any previous async hypercall has completed,
this will always evaluate to true, returning -EPERM for all future async
hypercalls and breaking the teardown path for the partition.

> @@ -1661,6 +1956,15 @@ mshv_partition_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>  	case MSHV_ROOT_HVCALL:
>  		ret =3D mshv_ioctl_passthru_hvcall(partition, true, uarg);
>  		break;

[Severity: High]
This is a pre-existing issue, but could this passthrough ioctl leak
uninitialized kernel memory to userspace?

The mshv_ioctl_passthru_hvcall() function allocates the output page without
GFP_ZERO:

drivers/hv/mshv_root_main.c:mshv_ioctl_passthru_hvcall()
        pages_order =3D args.out_ptr ? 1 : 0;
        page =3D alloc_pages(GFP_KERNEL, pages_order);
        ...
        if (!ret && output_pg &&
            copy_to_user((void __user *)args.out_ptr, output_pg, args.out_s=
z))
                ret =3D -EFAULT;

If a user requests a large out_sz, and the hypervisor writes fewer bytes to
the output buffer, the remaining uninitialized bytes from the kernel
allocation are copied to userspace.

> @@ -1782,6 +2149,9 @@ static void destroy_partition(struct mshv_partition=
 *partition)
[ ... ]
>  	if (partition->pt_initialized) {
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +		if (mshv_partition_encrypted(partition)) {
> +			hlist_for_each_entry_safe(region, n,
> +						  &partition->pt_mem_regions,
> +						  hnode) {
> +				hlist_del(&region->hnode);
> +				mshv_region_put(region);
> +			}
> +
> +			ret =3D destroy_snp_partition_state(partition);
> +			if (ret) {
> +				pt_err(partition,
> +				       "Failed to destroy SNP state: %d\n",
> +				       ret);
> +				return;
> +			}
> +		}
> +#endif

[Severity: High]
Does this early return permanently leak the partition and its resources?

If destroy_snp_partition_state() fails and returns a non-zero code, this
triggers an early return. The partition's reference count is already 0 at
this point.

Because the function returns early, the rest of destroy_partition() is
skipped entirely. The virtual processors are never removed, state pages
remain mapped, and the partition is never deleted from the hypervisor,
leaving the resources permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D4
