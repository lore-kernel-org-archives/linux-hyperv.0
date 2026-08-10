Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C823C140F
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367233; cv=none; b=KgDxzsWsbNsGmeeua+bmYB8uExz3ro7vUQAQVwUDS1LAie9plDWlXXLpqXrzFAejofmt+KD0ON59ZMMVzOKVGMqwvfJe6BkYKEistTSJc5YNSRV0KxHTcha3fMv8e5oQYKVqRLnSFk5KB6UCAjgzw9BEHj981Lv4OIcupCaCoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367233; c=relaxed/simple;
	bh=FVuJUiIdYxokpry3SGVTUB3AItGMMx7g6AeFlREff84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fcV0v9EI1l3AAGpSi9iZhw1sGoFUACOyciN16W+t9ljwY+b87gyAcENT9fNS7yQLRZuHNcDMdTbyRHf8Xbar5qMQqFoSnvEpOix0tvJzHquZYZK4oBKYzv5cNe2WQZ7R3Uv/tBq3YEQdUYDWygvOv+dPzONvO89CL7wN3HakksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nneBa3z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nneBa3z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298451F000E9;
	Mon, 10 Aug 2026 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367231;
	bh=bMaz/1CXRMSoNCQf3Jip3+rMs8HE1D+q0Gfjn/VvCBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nneBa3z6Cxw8ZROpoCdB560JVIU+x3dak6f6rkyzPYniOXLXG9SiYYbRzzNXtSEN7
	 ZF/IKhbG6MyJXkZ7zQy65BxjjLG+qNcAeCsq+CKbkTFDLVO8776JLS/1FSYeomgdVk
	 VZ24DzIcFbnQkyqqDOsjSovwvH327pWrS9C6WdMykVXds1de0RKsq2sVup0ojbUzcl
	 1eXjbPPCugp0Auv1j/gppHhqrXQvmgDMmDsKMtmL231YBIt6uRa6OJWo1YmnOQv2+5
	 y8ShiJTaFrvNO8oRPtyyPPt5yRfTi1KvlBeJMrvDNg74IXvSv/TlqFO7bSmhMXipW/
	 BQQB1UHl+A0XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-5-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-5-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:07:10 +0000
Message-Id: <20260810130711.298451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] Guest memory regions are unpinned and freed back to the host a=
llocator before the hypervisor restores host access, leading to fatal RMP v=
iolations.
- [High] Inconsistent handling of the user-provided guest_pfns array betwee=
n SEV-SNP ioctls, causing correct input to be corrupted.
- [High] Potential CPU stall in hv_call_import_isolated_pages() due to unbo=
unded loop over user-provided page count without cond_resched().
- [High] Unbounded retry loop in destroy_partition() if destroy_snp_partiti=
on_state() fails.
- [High] Module unload race with the delayed_work 'destroy_work' causes a U=
se-After-Free kernel panic.
- [High] hv_call_set_partition_property compares the raw 64-bit status to H=
V_STATUS_CALL_PENDING without masking, breaking the completion handler.

Pre-existing issues:
- [High] Inverted logic in mshv_init_async_handler()'s completion check per=
manently bricks the partition on stray completions.
--

--- Patch [4]: [PATCH v2 04/13] mshv: wire SEV-SNP partition ioctls ---
commit 903e3452cece23d95187a14a4beb770df83a5add
Author: Wei Liu <wei.liu@kernel.org>

mshv: wire SEV-SNP partition ioctls

Wire the SEV-SNP partition ioctls for GPA host-access changes,
isolated-page import, PSP guest requests, AP creation, and SNP partition
teardown.

The GPA host-access ioctl converts the guest addresses to GFNs before
issuing the hypercall. The PSP guest-request path restores host access
to the request/response pages if the hypercall fails, so a failed request
does not leave guest pages inaccessible to the host.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 4e48c1a9a6308..6d42fdd2c573f 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
[ ... ]
> @@ -1014,6 +1014,41 @@ int hv_unmap_stats_page(enum hv_stats_object_type =
type,
>  }
> =20
>  #ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +int hv_call_set_partition_property(u64 partition_id, u64 property_code,
> +				   u64 property_value,
> +				   void (*completion_handler)(void *, u64 *),
> +				   void *completion_data)
> +{
[ ... ]
> +	status =3D hv_do_hypercall(HVCALL_SET_PARTITION_PROPERTY, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (unlikely(status =3D=3D HV_STATUS_CALL_PENDING))

[Severity: High]
Does this code incorrectly compare the raw 64-bit status to
HV_STATUS_CALL_PENDING without masking it?

All other hypercalls use the macro hv_result(status) =3D=3D HV_STATUS_CALL_=
PENDING
to strip diagnostic and reserved bits. If this comparison fails because of
upper bits being set, the hypercall completion handler is bypassed, causing
the function to fail with an error when it should wait. This would lead the
partition destruction into an infinite retry loop.

> +		completion_handler(completion_data, &status);
[ ... ]
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 146726cc4e9ba..8c87dd8e0378f 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1625,6 +1668,289 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
[ ... ]
> +static long
> +mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
[ ... ]
> +	for (i =3D 0; i < args.page_count; i++)
> +		gpfns[i] =3D HVPFN_DOWN(gpfns[i]);
> +

[Severity: High]
Are we inconsistent in how we handle the user-provided guest_pfns array
between SEV-SNP ioctls?

Here, the code applies HVPFN_DOWN() to a field named guest_pfns, treating it
as a GPA instead of a PFN. This shifts the PFNs right by 12 bits, corrupting
the values.=20

However, in mshv_partition_ioctl_import_isolated_pages(), the identically
named guest_pfns array is passed directly to the hypercall without
downshifting. This mismatch breaks the API contract and can lead to memory
corruption or hypercall failures when incorrect physical addresses are
provided to the hypervisor.

[ ... ]
> +static long
> +mshv_partition_ioctl_import_isolated_pages(struct mshv_partition *partit=
ion,
> +					   void __user *user_args)
> +{
[ ... ]
> +	ret =3D mshv_init_async_handler(partition);

[Severity: High]
This is a pre-existing issue, but does mshv_init_async_handler() have inver=
ted
logic in its completion check that permanently bricks the partition?

mshv_init_async_handler() has this check:

    if (completion_done(&partition->async_hypercall)) {
        pt_err(partition, "Cannot issue async hypercall while another one i=
n progress!\n");
        return -EPERM;
    }

completion_done() returns true if a completion is completed (done > 0). The
function incorrectly assumes another operation is in progress, when in fact=
 it
means the completion is fully resolved. If a spurious completion fires, it
permanently denies service for any further asynchronous hypercalls for the
partition.

> +	if (ret)
> +		goto out;
> +
> +	ret =3D hv_call_import_isolated_pages(partition->pt_id, pages,
> +					    args.page_count, args.page_type,
> +					    HV_ISOLATED_PAGE_SIZE_4KB,
> +					    mshv_async_hvcall_handler,
> +					    partition);

[Severity: High]
Can this lead to a CPU stall and kernel watchdog panic?

Userspace can invoke MSHV_IMPORT_ISOLATED_PAGES with a massive page_count.
The while (remaining) loop inside hv_call_import_isolated_pages() will
continuously issue synchronous hypercalls based on this unbounded
user-supplied page count without ever calling cond_resched(), monopolizing
the processor.

[ ... ]
> @@ -1782,6 +2191,9 @@ static void destroy_partition(struct mshv_partition=
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

[Severity: Critical]
Does this unpin and free guest memory regions back to the host allocator
before the hypervisor restores host access?

The code calls mshv_region_put() to free the memory to the host buddy
allocator BEFORE destroy_snp_partition_state() successfully transitions the
partition state to INSECURE_DIRTY. If the host reallocates and writes to
these pages before the transition completes, it triggers a fatal RMP violat=
ion
and a Machine Check Exception (MCE).

> +
> +			ret =3D destroy_snp_partition_state(partition);
> +			if (ret) {
> +				pt_err(partition,
> +				       "Failed to destroy SNP state: %d; retrying\n",
> +				       ret);
> +				schedule_delayed_work(&partition->destroy_work, HZ);
> +				return;

[Severity: High]
Could this error path cause an unbounded infinite retry loop?

If the hypervisor rejects an idempotent state transition during partition
destruction, the error path unconditionally schedules a retry without a max=
imum
retry limit. Because it reschedules destroy_partition() entirely, previously
successful state transitions will be repeated, potentially failing
indefinitely.

[ ... ]
> @@ -2051,6 +2485,8 @@ mshv_ioctl_create_partition(void __user *user_arg, =
struct device *module_dev)
>  	mutex_init(&partition->pt_irq_lock);
> =20
>  	init_completion(&partition->async_hypercall);
> +	INIT_DELAYED_WORK(&partition->destroy_work,
> +			  mshv_partition_destroy_work);

[Severity: High]
Might this delayed work cause a Use-After-Free kernel panic on module unloa=
d?

If partition destruction fails and defers via this destroy_work, and usersp=
ace
closes the file descriptor, the module reference count will reach zero. The
module exit routine mshv_parent_partition_exit() fails to iterate over
remaining partitions or call cancel_delayed_work_sync(). If an administrator
unloads the module before the delayed work fires, the workqueue will execute
unmapped text.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D4
