Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CF3E557E
	for <linux-hyperv@vger.kernel.org>; Mon, 14 Sep 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387166; cv=none; b=j5Zqli8CN82KTe7MmWVo/PL+jp/GlgT4KEIhEKdvSPlbjU+dt0H71IdDVM7A9d+N1KUOmkYo0LYkzX4wcpJebyKVE8gePhwbz4unzBi+xfHdm0TWw+RimaJNMkpBibs1OFb2gnWYe6PiCM4kLIIXKxsM91jHLInM+CSnwERtDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387166; c=relaxed/simple;
	bh=ucJTo6na6u2gOpAOzsQzS95hkQmbaYEwHhsqs/iBdL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SQIl11ncc4ET/PSJRjFHsm1kFCYYfN5KWTPQV6Zu9M311PeNQInimxUJMASlQ5YMfMxR7DRUKXqdLHnTaSXBEm0lY19Q2bV9OlKGWN02SdNWaUy4QuV7pZ/erH02rnmu8cFBR1gE7Ke75BW6zpSRzgfXjcLdoLT3Rsh9Zd5Ma6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjgIIAb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjgIIAb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5A91F0089B;
	Mon, 14 Sep 2026 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789387148;
	bh=yXa0jb3pGEuTeht4jLVnFZDaYDq9t9nLjzOQBswJRA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjgIIAb/sdK1vmG0Qzx0ww1VLQudLS3ZT6Xiq8D4nf85RzbgC91p6MlFhZMyjciKX
	 pfDVRMCPItJ7Fv/urmFaxve7EOiIl9wNSw3zyCTtuSiX0Yzgi/xZKbtNxEFuiR82TB
	 IzdbgBDHfHoqvZbFxmT/Xuqi2Dg0p57Z7RbnkA42uSs1ts9cXwM8S/DK36140QZqbS
	 4gCQm2Y6UA85WKBTaZfYrZ/gWjM8VIDXAlX814vVXyVxhWQUsII2cQLRb832fb6M7r
	 mDHuJPp5Onn+BawF8sC3P7Id6qNL2mBcEE8OQWskEo+kkBhs1Lzjm9cZ9iwChY8GUj
	 bm1AgFigjCChA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drivers/hv: remove deposited pages from direct map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Kulke" <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260914114617.27628-1-magnuskulke@linux.microsoft.com>
References: <20260914114617.27628-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:59:07 +0000
Message-Id: <20260914115908.0C5A91F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Failing to restore direct map entries leads to unconditionally fre=
eing unmapped pages into the buddy allocator, causing kernel crashes upon r=
eallocation.
- [Low] The patch calls a non-existent kernel function `set_direct_map_vali=
d_noflush`, which will cause a build failure.

Pre-existing issues:
- [High] Partial success of HVCALL_DEPOSIT_MEMORY causes deposited pages to=
 be erroneously freed back to the buddy allocator.
--

commit 73ea756bd40436738445dd3d28edbd2b8f61584f
Author: Magnus Kulke <magnuskulke@linux.microsoft.com>

drivers/hv: remove deposited pages from direct map

This patch removes deposited pages from the kernel direct map before passing
them to the hypervisor, and restores them when the hypervisor returns them.
This aims to prevent kernel panics if code like load_unaligned_zeropad()
accidentally accesses these deposited pages.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb9..3ab02adf7efb4 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
[ ... ]
> +static int hv_deposit_update_direct_map(struct page **pages, int *counts,
> +					int num_allocations, bool valid)
> +{
> +	int i, err, ret =3D 0;
> +
> +	for (i =3D 0; i < num_allocations; ++i) {
> +		err =3D set_direct_map_valid_noflush(pages[i], counts[i], valid);

[Severity: Low]
Does this code call a function that doesn't exist? The kernel API does not
appear to have a set_direct_map_valid_noflush() function that takes three
arguments, which will cause a build failure.

> +		if (err && !ret)
> +			ret =3D err;
> +	}
> +
> +	if (valid)
> +		return ret;
[ ... ]
> @@ -90,12 +125,15 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32 num_pages)
>  	if (!hv_result_success(status)) {
>  		hv_status_err(status, "\n");
>  		ret =3D hv_result_to_errno(status);
> -		goto err_free_allocations;
> +		goto err_restore_direct_map;
>  	}
> =20
>  	ret =3D 0;
>  	goto free_buf;
> =20
> +err_restore_direct_map:
> +	hv_deposit_update_direct_map(pages, counts, num_allocations, true);
> +
>  err_free_allocations:
>  	for (i =3D 0; i < num_allocations; ++i) {
>  		base_pfn =3D page_to_pfn(pages[i]);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path properly
handle partially deposited pages?

If the HVCALL_DEPOSIT_MEMORY hypercall is interrupted or partially fails,
the hypervisor may have already taken ownership of some pages. The code does
not appear to check hv_repcomp(status) for partially deposited pages before
freeing them all to the buddy allocator. If the kernel dispenses these pages
again, any access could trigger a #GP fault from the hypervisor.

[Severity: High]
If restoring the direct map fails (for instance, due to an ENOMEM when tryi=
ng
to split page tables), the error from hv_deposit_update_direct_map() is
ignored and execution proceeds to err_free_allocations. Could this free
unmapped pages to the buddy allocator, causing a crash when the kernel
later allocates and accesses them?

>  		for (j =3D 0; j < counts[i]; ++j)
>  			__free_page(pfn_to_page(base_pfn + j));
>  	}
[ ... ]
> @@ -110,6 +148,19 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32 num_pages)
>  }
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> =20
> +/*
> + * Put withdrawn pages back in the direct map. Counterpart to the direct=
 map
> + * removal done by hv_call_deposit_pages().
> + */
> +void hv_restore_withdrawn_pages(const u64 *pfns, int count)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; ++i)
> +		set_direct_map_valid_noflush(pfn_to_page(pfns[i]), 1, true);

[Severity: Low]
Does this code call a non-existent function? Similar to the other location
in hv_deposit_update_direct_map(), this appears to use a non-existent
set_direct_map_valid_noflush() API with 3 arguments, which will break the
build.

[Severity: High]
Does this ignore the return value of the mapping restoration?

If the direct map restoration fails, the pages would remain unmapped in the
kernel's direct map. Ignoring this failure can cause the pages to be freed
unmapped into the buddy allocator by the caller.

> +}
> +EXPORT_SYMBOL_GPL(hv_restore_withdrawn_pages);
> +
>  int hv_deposit_memory_node(int node, u64 partition_id,
>  			   u64 hv_status)
>  {
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e5..8c21ad4ba3b07 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -69,6 +69,8 @@ int hv_call_withdraw_memory(u64 count, int node, u64 pa=
rtition_id)
> =20
>  		completed =3D hv_repcomp(status);
> =20
> +		hv_restore_withdrawn_pages(output_page->gpa_page_list, completed);
> +
>  		for (i =3D 0; i < completed; i++)
>  			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
> =20

[Severity: High]
If hv_restore_withdrawn_pages() encounters an error, this loop will return
unmapped pages to the buddy allocator. Could this lead to a #PF and a kernel
panic when the buddy allocator dispenses these unmapped pages to another
subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914114617.2762=
8-1-magnuskulke@linux.microsoft.com?part=3D1
