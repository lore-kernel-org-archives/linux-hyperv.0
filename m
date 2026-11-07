Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021068;
	b=de2zURtNjQXSLjEH3JGyfwLHPNSxeP7crJJzWpmhayDvCkwZe/svGfzosdiw4VuXdJeA
	 02fIp0rCERDwOaqqjOUpAMFTyVAiIhtnmTl14dn1DnJwpecHlg0A4vPmVL/qHNjFc3tCh
	 1cCm78AIhYFGXkDtFM3+U/FbnEn4ooUVVCjme16f9sPLWM1oP1+aVvqE35ocyaYMCvS7T
	 P0wbYULtnowysLbDlhcZGo16zGo7xo9w7EMYPD0mNWmaFobeq8KntN7DH/j71c4ozxdDl
	 7U03ZVJ+8fOBXR9oftii5I0OsWrmbaaTzYrm/HxmKnQujUmupxvVGR1GOvZOVPI3GnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021068;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+WIEGkEDk4msd5RGo+fdCqf+NZbyFHtwfqYkIXxk5Gk=;
	b=Eul7Kp+mOnW9+YLXo+3Sz+1iJacgeS3vTX2jWAqkJzMjtaK6Pq+VAmpaWRsNufbLX+de
	 mltf1VzzKHvBUJehIVVr5BJGJyLJPPJ2fowuLK/pp2K234b7eEvyUgKW+5R732psAn9pD
	 mpPwZBauG560OCCvNND4lM0z0tOBObBJGJuxh/RBjJ5DqbE5Xko82UMaZCKa8OyPwz1GG
	 12qS3EosWVk2JCscMY5ETUhnArmO9Ha3RQyIHL31VykHMq+GMJixec35LxEGIy/LpT5i8
	 g1YSyPr8qpcQa4V8l9I/iJSmON1VIYwMM1HjFyxpEYQTC5ajBucdnYQTBMxmpzST48A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLY6mpH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF211606A32C
	for <linux-hyperv@vger.kernel.org>; Sat,  7 Nov 2026 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLY6mpH2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2171F008A1;
	Sat,  7 Nov 2026 03:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794021067;
	bh=+WIEGkEDk4msd5RGo+fdCqf+NZbyFHtwfqYkIXxk5Gk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dLY6mpH2G68Js3hzX8fL38SrhZp+oEO6SiYKZFn0/pMYvSkCf09uhykCnSGjZUgPr
	 HQ01rf+lHNt34u6joGXn+/yinhploqcORtfIczUGRuX2ndRDCFNiHz6SuprdrSvYie
	 WSol2+hQX8jEiRE0wdPRp5feUbiFeUsE6MorqNqDB/xAd4CIy96ov2wptz+O9u2tLX
	 DIMHmX96LZR+oaem1OkMmtNvcvo6M7eZADc3P9lIBrGPBr8tzPhtiMP/jwEY4nT8oo
	 Db3/cQeHSkqMkN/L4Te1vrHUsXbpeFyo9xVV/zuBitbrd0bGPJ3eBEHq4XWKuqkBhC
	 oWjWJgjH9dhdQ==
Message-ID: <sashiko-outbox-202522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: Do pre-commit before mapping a guest VM GPA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
References: <20261107024842.3929415-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 03:11:07 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mshv: GFP_KERNEL allocation in hv_pre_commit_gpa() during MMU
  invalidation
--

commit 326d99247cfb889e00e7b24f8217bcbc574b15e8
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Do pre-commit before mapping a guest VM GPA

This commit adds an HVCALL_PRECOMMIT_GPA_PAGES step before mapping guest
GPAs in hv_do_map_gpa_hcall() to pre-allocate hypervisor data structures
and reduce TLB flushes.

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e761addda50e1..595d044fb9264 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -181,6 +181,54 @@ int hv_call_delete_partition(u64 partition_id)
>  	return hv_result_to_errno(status);
>  }
> =20
> +/*
> + * Pre commit to reduce TLB flush overheads in the hypervisor. On system=
s with
> + * large CPUs, there is signficant advantage to doing this. Pre-commit a=
llows
> + * the hypervisor to build all data structs needed in anticipation of th=
e map
> + * gpa hypercall, thus reducing or eliminating deposit page returns from=
 the
> + * map gpa hypercall, and as a result reducing TLB flushes.
> + */
> +static int hv_pre_commit_gpa(u64 pt_id, u64 gfn, u64 num_pages)
> +{
> +	ulong irq_flags;
> +	struct hv_input_precommit_gpa_pages *input_page;
> +	int rc =3D 0;
> +	u64 status, done =3D 0;
> +
> +	while (done < num_pages) {
> +		u16 rep_count =3D min(num_pages - done, HV_REP_COUNT_MAX);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input_page, 0, sizeof(*input_page));
> +
> +		input_page->partition_id =3D pt_id;
> +		input_page->target_gpa_base =3D gfn;
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_PRECOMMIT_GPA_PAGES,
> +					     rep_count, 0, input_page, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		done +=3D hv_repcomp(status);
> +		gfn +=3D hv_repcomp(status);
> +
> +		if (hv_result_needs_memory(status)) {
> +			rc =3D hv_deposit_memory(pt_id, status);
> +			if (rc)
> +				break;
> +
> +		} else if (!hv_result_success(status)) {
> +			pr_err("%s: failed to pre commit for gfn %#llx done %llu/%llu, status=
=3D%#llx (%s)\n",
> +			       __func__, gfn, done, num_pages, status,
> +			       hv_result_to_string(hv_result(status)));
> +			rc =3D hv_result_to_errno(status);
> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  /* Ask the hypervisor to map guest ram pages or the guest mmio space */
>  static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
>  			       u32 flags, struct page **pages, u64 mmio_spa)
> @@ -205,6 +253,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64=
 gfn, u64 page_struct_count,
>  		page_count >>=3D large_shift;
>  	}
> =20
> +	ret =3D hv_pre_commit_gpa(partition_id, gfn, page_struct_count);
> +	if (ret)
> +		return ret;

[Severity: High]
Can calling hv_pre_commit_gpa() unconditionally here sleep and enter
direct reclaim from an MMU notifier invalidation callback?

mshv_region_interval_invalidate() calls mshv_region_remap_pages() with
HV_MAP_GPA_NO_ACCESS while holding region->mreg_mutex inside
mmu_notifier_invalidate_range_start(), including when
!mmu_notifier_range_blockable(range):

drivers/hv/mshv_regions.c:mshv_region_interval_invalidate() {
	...
	if (mmu_notifier_range_blockable(range))
		mutex_lock(&region->mreg_mutex);
	else if (!mutex_trylock(&region->mreg_mutex))
		goto out_fail;

	mmu_interval_set_seq(mni, cur_seq);

	ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
				      page_offset, page_count);
	...
}

That reaches hv_do_map_gpa_hcall(), which now calls hv_pre_commit_gpa()
with page_struct_count (4K pages, with input_page->flags =3D 0 even when the
region was mapped with HV_MAP_GPA_LARGE_PAGE).  If the hypervisor asks for
more memory (for example to shatter a 2M SLAT entry into 4K entries),
hv_deposit_memory() -> hv_call_deposit_pages() allocates pages with
GFP_KERNEL.  This sleeps in non-blockable MMU notifier context, triggers a
lockdep splat on __mmu_notifier_invalidate_range_start_map in
fs_reclaim_acquire(), and can deadlock if direct reclaim re-enters
mshv_region_interval_invalidate() on region->mreg_mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107024842.3929=
415-1-mrathor@linux.microsoft.com?part=3D1
