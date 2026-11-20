Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141242;
	b=dbohYzilXuU6DnZBTLyp+kbGIErG+luv+/t7d8PNa9p3lLML3UEoUZZ3Wpcqi/RG2SrU
	 RC8fA2/6nDzeoeIDhsoxbQGjUIZ8h7HrV0Bmy2AwL8p/+mqpu0/miHZcllmZm/Fi0Pw65
	 MvDG+igtvsx8+XZD0amjBXrxrRlEFSiWNfvSC9h3hUZUKeay1DDzkFpYTMY3wyS/TT62y
	 A8lGlW4JuL+SwjyvPPvPYCTYEpGLlXT/xqXWThMAI+dDDAvefZBMaD9RzfKs49lfM4Kat
	 CqSCvVKFANWEn7SMsXovlzZawSKTfQRVlkqmwhYV6QfUJVakENq2vQ4jcCzRQbsWhBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EmYI5tzf7gzsYUknqLxpGtoTGud1N3SXwABjZhLM5vE=;
	b=p3MEbksMoLA50wlJtS8wr/UXSFvndlnj2brC+audKm3Dz9g/CFFUYOR4lkgleV/spmWG
	 PjIXVXsbgEneIMSUrjglD/jchCUVNhyOt91vKm1Zf+pD9tgLyuuqgFu0rDCgg/yhJQzzZ
	 6xeVfDc57QOBdY1jSwB+EWOXWvAb1GKIPqN0cSAN1plK2nXLll/rhwP/bgD56C8T2UZuc
	 s2oj1SmjJk9C+Q+jqkDrKS3rhsYk2TT/O1lyNJVdnvf2uEc8n4nVk1mCxKyW9rTGiEkvs
	 zUuKL9kTcx68wNIK26SA9uNOAlW+h9eNafQXgcICqTVqJRimAywOs6V/bDccGaIvUWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHk9wRax;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC58606A320
	for <linux-hyperv@vger.kernel.org>; Fri, 20 Nov 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHk9wRax
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928C81F000C6;
	Fri, 20 Nov 2026 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141242;
	bh=EmYI5tzf7gzsYUknqLxpGtoTGud1N3SXwABjZhLM5vE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dHk9wRaxE3eIkezxnKbtd3zZZ0JGu4ddWX4nUQRtmVyEP3sDybo1VEFBT9wgyfq+i
	 G606V7CFBJOKgXwqtKctFNZkuuMg9cdktRMuolrjBBgrWy3dSawUwk/uFsIwpN8c7m
	 c+DjgklSI6V4A5jhcsfTzWlmxGkObtJD1fg/1J/FetjWScyF+sKTxsQTkhQUYIur/V
	 4QrifK4orqsurIlci+5r+LtjoIUiLltHD2iVFYorny5wILw8A/56qIGE3GobocBCIs
	 HgsEp42rBYMQWWLcZhHu7UrlmITfTMmBvNOIMmmn2xJUnKnUTVBlxfP5DvXFkaD05H
	 f0qPL8ESSH3qQ==
Message-ID: <sashiko-outbox-224348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: Handle completions on repeat hypercall failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261120020858.3597446-1-mrathor@linux.microsoft.com>
References: <20261120020858.3597446-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 02:20:42 +0000
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
- [Low] mshv: missing Fixes trailer for commit 621191d709b1
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] mshv: reclaim lock inversion in hv_do_map_gpa_hcall() under
  mreg_mutex [1]
--

commit f6f04457a79d386b8628402d94d80fb4ab5e158c
Author: Mukesh R <mrathor@linux.microsoft.com>

> mshv: Handle completions on repeat hypercall failures
>
> When a repeat hypercall fails, it could still have completed some of the
> entries requested. Fix places where completions are not checked in case
> of repeat hypercall failures. Also, add error prints in couple places
> with correct partial completion counts when repeat hypercall fails.
>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

[Severity: Low]
All four modified helpers were introduced with the status check placed
before accounting for hv_repcomp(status).  Should this include:

  Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /=
dev/mshv to VMMs")

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e761addda50e1..6261686c36382 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -239,6 +239,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 =
gfn, u64 page_struct_count,
>  		local_irq_restore(irq_flags);
> =20
>  		completed =3D hv_repcomp(status);
> +		done +=3D completed;
> =20
>  		if (hv_result_needs_memory(status)) {
>  			ret =3D hv_deposit_memory(partition_id, status);

[Severity: High]
This problem wasn't introduced by this patch, but can calling
hv_deposit_memory() here cause a reclaim lock inversion on
region->mreg_mutex [1]?

mshv_region_range_fault() and mshv_region_interval_invalidate() call
mshv_region_remap_pages() -> ... -> hv_do_map_gpa_hcall() while holding
region->mreg_mutex.  When hv_result_needs_memory(status) is true,
hv_deposit_memory() allocates pages with GFP_KERNEL via
hv_call_deposit_pages() and hv_alloc_dep_pages(), which can enter direct
reclaim and invoke the MMU interval notifier callback on the same region:

mshv_region_range_fault()
  mutex_lock(&region->mreg_mutex)
  mshv_region_remap_pages()
    ...
      hv_do_map_gpa_hcall()
        hv_deposit_memory()
          ...
            hv_call_deposit_pages()
              get_zeroed_page(GFP_KERNEL)
                <direct reclaim>
                  mmu_notifier_invalidate_range_start()
                    mshv_region_interval_invalidate()
                      mutex_lock(&region->mreg_mutex)  <-- deadlock

[1] https://sashiko.dev/#/bug/linux-5f8ad8fe-ef3b-459b-a784-e85fb87d7746

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120020858.3597=
446-1-mrathor@linux.microsoft.com?part=3D1
