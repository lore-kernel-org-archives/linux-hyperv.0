Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AF4749C9
	for <linux-hyperv@vger.kernel.org>; Wed, 30 Sep 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770903; cv=none; b=i7PMjBAAbdL9C3yQS0iOeIoeh4EQuP21WQSX0i/z+/rgLqEi9cLIN9huEu43wpa50Gd2sVY8/NApkzXs0r/9tzf26uTJglLyyarVzhfgeP3G3ljiXZYIQPQ5eFsc0Jg0MHcNYO9f3CRLroPxUmDlhL2HDbl20Acm1vhn81OtIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770903; c=relaxed/simple;
	bh=mNJb+7YaJWYUDrIkn/WqvvtNV2G4f1T/W5wP/refZcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srM+U7Su/5QtTDLQO3gTbUCTN/w4FzNDMjj14P+GdBw/8XoFaJ2eg+B60XRBSmUJDVHjqUCZGo1+XI3dFC3d6fDahvyX986q9npfvaggKsGX25y5YMQh06cy+VtFELNSvYrHq5ADHaH/TzvcFo70QgTs796SD+E+bCFph3C3s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+Es4ZwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+Es4ZwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5CB1F000FF;
	Wed, 30 Sep 2026 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770901;
	bh=xQb+Iet5iAeFwD6MyamtxG10bp0P733/0k3Lp19AdpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+Es4ZwYATAnMn3KOZn9DCBqgt7gHCJ18WcszI9RBME/PpULdhw5a84RFDPWdzSmd
	 VkOYqqQLRkrJFIu5qiQX/svPq3sU7se50zcWPuCdUx3S/2cjLjeqFmVWNlSKcxkKaS
	 ylwkbKGuzC3MtJO6r8EhMhyqqNTRS55otYKMC8pAfmhqknT+S6pRJo5WvVTndK+1db
	 o0SCPIZiOcTNaEALsdgyrbLtQ0h9XbHHXJJjzHN6qHkNdBY61FR6aeeATp763xXTV1
	 U4VYaey6uFenQKA+lw0haORjoY4U6715Hk02lNbjK0mW/y6zK6BfUuzErhAZG5aGS7
	 ivjtk2Ly/Y1Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drivers/hv: remove deposited pages from direct map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Kulke" <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
References: <20260930121047.19993-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:21:41 +0000
Message-Id: <20260930122141.9D5CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm: memory leak of successfully restored pages on error path in =
hv_call_deposit_pages()
- [Low] build: invocation of non-existent function set_direct_map_valid_nof=
lush()
--

commit 702a398988acd774f1ea0597061a05c15e6ab245
Author: Magnus Kulke <magnuskulke@linux.microsoft.com>

drivers/hv: remove deposited pages from direct map

This commit removes deposited pages from the kernel direct map before passi=
ng
them to the hypervisor to prevent #GP faults on accidental access. It also
restores the direct map entries when the pages are returned.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb9..b056051a5ac59 100644
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
Does this code cause a build failure? The function
set_direct_map_valid_noflush() does not appear to exist in the kernel API.
The set_memory.h header provides set_direct_map_invalid_noflush() and
set_direct_map_default_noflush(), rather than a single multiplexed function
with a boolean flag.

> +		if (err && !ret)
> +			ret =3D err;
> +	}
> +
> +	if (valid)
> +		return ret;

[ ... ]

> @@ -90,12 +125,23 @@ int hv_call_deposit_pages(int node, u64 partition_id=
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
> +	/*
> +	 * We don't want to return pages to the allocator if weren't able to
> +	 * mark them valid in the direct map.
> +	 */
> +	if (hv_deposit_update_direct_map(pages, counts, num_allocations, true))=
 {
> +		WARN(1, "leaking %d page block(s) that could not be set to valid\n",
> +		     num_allocations);
> +		goto free_buf;
> +	}

[Severity: Medium]
Does this error path leak successfully restored pages?

In hv_deposit_update_direct_map(), batch processing continues even if one
block fails, but the function returns the first error it encounters.

If a non-zero error is returned here, the goto skips the err_free_allocatio=
ns
loop. This permanently leaks all pages in the batch, including the ones that
were successfully marked as valid in the direct map again.

> +
>  err_free_allocations:
>  	for (i =3D 0; i < num_allocations; ++i) {
>  		base_pfn =3D page_to_pfn(pages[i]);

[ ... ]

> @@ -110,6 +156,41 @@ int hv_call_deposit_pages(int node, u64 partition_id=
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
> +	int i, j, end, n, ret;
> +	struct page *page;
> +
> +	for (i =3D 0; i < count; i =3D end) {
> +		page =3D pfn_to_page(pfns[i]);

[ ... ]

> +		for (j =3D i; j < end; ++j) {
> +			page =3D pfn_to_page(pfns[j]);
> +			/*
> +			 * Retry individually on failed batch. We don't want
> +			 * to return pages to the allocator that we couldn't mark
> +			 * valid in the direct map.
> +			 */
> +			if (ret &&
> +			    WARN_ON_ONCE(set_direct_map_valid_noflush(page, 1, true)))

[Severity: Low]
As mentioned above, set_direct_map_valid_noflush() does not exist in the
kernel API. Should this call set_direct_map_default_noflush() instead?

> +				continue;
> +			__free_page(page);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930121047.1999=
3-1-magnuskulke@linux.microsoft.com?part=3D1
