Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A303F12D0
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Aug 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178047; cv=none; b=TUaxJd7v6WgsT3i/ZZMCIv5d5mbI+yUE5gKeKeTEFkr7Ty/mXpQHlJFlN73xnlpD77VvxXJFgiUn7g+4VeGk8ex0F0eEaHV4pChD6humOQrjpAnUZYUgiV3svnWWs08dPdXqUjAw58x4gnyNmteVbFKsHVeaDa9C9KtqMm/9quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178047; c=relaxed/simple;
	bh=hSNCDuYWw49A/30BG37S2fPhDKihdk0F/jh8EIkkLMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lij5HJfwPWSK1aLTlGMnk/KGc5d7t936Rh4IOv9kSSdRwH4PX/oqxpQGfSa1u9QxS3qiR0RVMpfVq5PH+IFvvZtqu+caq7kGSCvdW8UuRAdLRcdMtJjCDmNnhbibVtGZ937IZG/iuCwH3K64gggcnbRiP3km4Ds8fokczzJrdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSeNup/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSeNup/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70731F000E9;
	Mon, 31 Aug 2026 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178046;
	bh=hpqfNv0BqE5dO+1Eb2R/Q6miw/LMuRoOYELXiVPmm3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSeNup/B7StXM7tBfE6U1I2FTyB83gpcy+3Id6Z4eXc34GAVmZ2PZ33T+A3zhdh8Z
	 NlQyePDNPnYtad7y12DCLOJRwr/jh8sSRcRd20Jk9PqpYvedxQQmA3bPon5zek7fv4
	 nl1Nr3PUDheDFkpQVAejnzu80eh2jAfmISY/M9h40Faf90KtH0VRHKILb8/ubsk+0p
	 gj9C5P9Z/ArPQxrPh86gjvSl8lVOuoVkd09KgZYqA2FS5HOXZQw7bh2phylbX0nKq7
	 9xt5DUw0fL+/OVFXXpzyJ3xDDf95zG/mB4kXbhcStbG10jHWKJ9eNjAPHAaGh/vxtA
	 vKLHIYw1qym4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] mshv: wire SEV-SNP partition ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260831112704.2851147-7-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260831112704.2851147-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 12:07:25 +0000
Message-Id: <20260831120725.C70731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Error recovery paths unconditionally attempt to re-acquire host ac=
cess for all pages in a request or region, guaranteeing failure and trigger=
ing unwarranted partition quarantine.
- [High] `MSHV_MODIFY_GPA_HOST_ACCESS` alters host access without updating =
the region's `host_access_released` flag, causing host access to be permane=
ntly leaked or double-acquired during teardown.
- [High] Releasing host access fails to set the MAKE_EXCLUSIVE flag, causin=
g the hypercall to use partition_id 0 and failing to assign the memory to t=
he guest partition.
--

commit f76d3f5042ec21e318f98c3b6d0b444fad2c8e2d
Author: Wei Liu <wei.liu@kernel.org>

mshv: wire SEV-SNP partition ioctls

This commit wires the SEV-SNP UAPI into partition creation, memory ownershi=
p,
isolated-page import, launch completion, PSP guest requests, AP creation,
and teardown. It implements tracking for child mappings and released host
access per region, with error handling for partial maps and teardowns.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 4a15d4bfa925a..424b7da680c16 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1297,51 +1331,51 @@ static int mshv_prepare_pinned_region(struct mshv=
_mem_region *region)
[ ... ]
>  	if (mshv_partition_encrypted(partition)) {
> +		int recovery_ret;
> +
>  		ret =3D mshv_region_unshare(region);
>  		if (ret) {
> -			pt_err(partition,
> -			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
> -			       region->start_gfn, ret);
> +			pt_err_ratelimited(partition,
> +					   "Failed to release host access at GFN %#llx: %d\n",
> +					   region->start_gfn, ret);
> +			recovery_ret =3D mshv_region_share(region);

[Severity: High]
Does the error recovery path in mshv_prepare_pinned_region() (in
drivers/hv/mshv_root_main.c) unconditionally attempt to re-acquire host
access for all pages in the region?

If mshv_region_unshare(region) fails partway through the region,
mshv_region_share(region) will iterate over the entire region from 0 to
nr_pages.

Will this blindly hit the exact same page that caused the initial unshare to
fail, predictably turning a localized failure into an unrecoverable failure
that permanently quarantines the partition?

> +			if (recovery_ret) {
> +				pt_err(partition,
> +				       "Failed to recover host access at GFN %#llx: %d; retaining re=
gion\n",
> +				       region->start_gfn, recovery_ret);
> +				return ret;
> +			}
>  			goto invalidate_region;
>  		}
>  	}
[ ... ]
> @@ -1689,6 +1744,473 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
[ ... ]
> +static long
> +mshv_partition_ioctl_modify_gpa_host_access(struct mshv_partition *parti=
tion,
> +					    void __user *user_args)
> +{
[ ... ]
> +	while (offset < args.page_count) {
> +		u64 count =3D min_t(u64, args.page_count - offset,
> +				  MSHV_USER_PAGE_BATCH_SIZE);
> +		u64 completed =3D 0;
> +		u64 i;
[ ... ]
> +		ret =3D hv_call_modify_spa_host_access(partition->pt_id, pages,
> +						     count, &completed,
> +						     host_access, flags, acquire);

[Severity: High]
Will releasing host access via mshv_partition_ioctl_modify_gpa_host_access()
in drivers/hv/mshv_root_main.c fail to assign the memory to the guest
partition?

When userspace issues this ioctl with acquire=3Dfalse to make pages exclusi=
ve
to the guest, the flags variable lacks the
HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE bit.

Because the MAKE_EXCLUSIVE flag is omitted, the underlying helper
hv_call_modify_spa_host_access() will not populate
input_page->partition_id and it will default to 0. Does this mistakenly
assign the memory to the root partition instead of the guest?

[Severity: High]
Does mshv_partition_ioctl_modify_gpa_host_access() in
drivers/hv/mshv_root_main.c alter host access without updating the region's
host_access_released flag?

When userspace successfully unshares pages here, the change in hypervisor
state is not recorded in the kernel's region tracking.

Because destroy_partition() relies on the host_access_released boolean,
will it skip restoring host access during teardown, leading to host access
being permanently leaked or double-acquired, and causing a host hardware
memory encryption violation when the memory is later reused?

> +		if (completed > count) {
> +			ret =3D -EPROTO;
> +			completed =3D 0;
> +		}
[ ... ]
> +static long
> +mshv_partition_ioctl_issue_psp_guest_request(struct mshv_partition *part=
ition,
> +					     void __user *user_args)
> +{
[ ... ]
> +	ret =3D hv_call_modify_spa_host_access(partition->pt_id, pages,
> +					     ARRAY_SIZE(pages), &completed,
> +					     0, 0, false);

[Severity: High]
Is the HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE flag similarly missing
here in mshv_partition_ioctl_issue_psp_guest_request()
(drivers/hv/mshv_root_main.c)?

The flags parameter is passed as 0. Will this also cause the hypercall to
use partition_id 0 and fail to assign the memory to the guest partition?

> +	if (ret)
> +		goto restore_host_access;
> +
> +	ret =3D mshv_init_async_handler(partition);
> +	if (ret)
> +		goto restore_host_access;
> +
> +	ret =3D hv_call_issue_psp_guest_request(partition->pt_id,
> +					      HVPFN_DOWN(req.req_gpa),
> +					      HVPFN_DOWN(req.rsp_gpa),
> +					      mshv_async_hvcall_handler,
> +					      partition);
> +	if (!ret)
> +		return 0;
> +
> +restore_host_access:
> +	{
> +		int restore_ret;
> +
> +		restore_ret =3D hv_call_modify_spa_host_access(partition->pt_id,
> +							     pages, ARRAY_SIZE(pages),
> +							     &completed, host_access,
> +							     0, true);

[Severity: High]
Does this recovery path in mshv_partition_ioctl_issue_psp_guest_request()
ignore the completed variable from the original failure?

By passing ARRAY_SIZE(pages) instead of the number of successfully released
pages, it attempts to restore pages that were never released (or failed to
release), guaranteeing that the hypervisor will reject this operation again.

Could this predictable secondary failure trigger an unwarranted partition
quarantine and memory leak?

> +		if (restore_ret) {
> +			pt_err(partition,
> +			       "Failed to restore PSP request page access: %d\n",
> +			       restore_ret);
> +			mshv_quarantine_partition(partition);
> +			if (!ret)
> +				ret =3D restore_ret;
> +		}
> +	}
> +	return ret;
> +}
[ ... ]
> @@ -1901,6 +2498,34 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
[ ... ]
> +#ifdef HV_SUPPORTS_SEV_SNP_GUESTS
> +	if (mshv_partition_encrypted(partition)) {
> +		if (partition->pt_initialized) {
> +			ret =3D destroy_snp_partition_state(partition);
> +			if (ret) {
> +				pt_err(partition,
> +				       "Failed to destroy SNP state: %d; retaining partition\n",
> +				       ret);
> +				mshv_quarantine_partition(partition);
> +				return;
> +			}
> +		}
> +
> +		hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
> +			if (!region->host_access_released)
> +				continue;
> +			ret =3D mshv_region_share(region);

[Severity: High]
Does this teardown code in destroy_partition()
(drivers/hv/mshv_root_main.c) rely entirely on the desynchronized
host_access_released boolean?

Because mshv_partition_ioctl_modify_gpa_host_access() alters host access
without updating this flag, will this skip restoring host access for regions
that were dynamically unshared by userspace, leading to improper cleanup and
host kernel crashes upon page reuse?

> +			if (ret) {
> +				pt_err(partition,
> +				       "Failed to restore host access at GFN %#llx: %d; retaining pa=
rtition\n",
> +				       region->start_gfn, ret);
> +				mshv_quarantine_partition(partition);
> +				return;
> +			}
> +		}
> +	}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831112704.2851=
147-1-weh@linux.microsoft.com?part=3D6
