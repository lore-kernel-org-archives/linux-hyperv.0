Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F337DAD5
	for <linux-hyperv@vger.kernel.org>; Sat,  3 Oct 2026 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991244; cv=none; b=u8RTltpW4pjEQs2GR6fSA+QXqtPGXN0eXMgdLppuCZCsqOHAQuWxpI+bMGHUphQV+xZQ26XXO4DqOb5X54NHx3yk82Si19bd2pxzPU2EBygApxiTEcXQLWBR40S3+0/L834iMQqU2fvcv9vMuqSPM1ftLiEBBTtLIsXONEsPcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991244; c=relaxed/simple;
	bh=AbaQEbqWTuLtbrCdhtAlWIyaNa0z3sSa0+KW6HTmOHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmuAscx0CofjSIdTd/mywSGOXvXNQdQtVslEp5fCtFCz2MD2wYYqS2hQWDC6/pQCuO7WnGx3T03RDexcaVIpmgh+EL3iboxg2jPtCKVniCsJFVHTcdpTz5hktAlZPe0tqKoZA72w4DpXl9ZGSVSMMjEVAEkgRtQSnwMA8E15Y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+7ij/Lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+7ij/Lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF021F000FF;
	Sat,  3 Oct 2026 01:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991242;
	bh=gm5o5AgKwmiCiUYfMZFW27TffuVHBcyh1g8pONdjWeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+7ij/LquucsP80/gUnEL5gpymVTwYflYwS5Wiw0IYDut2C7+IgIm2M2rI3lw2Bdf
	 lblQZyGHtZeZOG1UBF3Eushxv/lotpn/k1VZkoSPp4r0NG0ZE14SpNENkTKDSD18uB
	 o9NkLtObvpcCyKyJdQjfPW19HpJn++WMadQjBUt3zYeGJgVGfQ2BnWyaW2Aac23zuE
	 WUFrRxwl8sIvi9voNjgt2ZVozZgbPs24ycN+46gVMEsfrGE8AuBvOQkeTOL5SNF6/R
	 jXSqv9urm+yTtHP5Q3c4Sm14zbZw+auTiynN3l1D/TMtzE2/nASvMDJU16IH3Pg6tC
	 L8yFfF9HAUkpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261002215725.2015959-4-kameroncarr@linux.microsoft.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-4-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:01 +0000
Message-Id: <20261003013402.4AF021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: hyperv: kcalloc() violates RSI host call 256-byte alignment
--

commit 15aadbf7702767ee71f473eab885a0900dbd0a76
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms

This commit adds a dynamically allocated array of per-CPU `struct
rsi_host_call` structures for ARM CCA Realms. The memory is allocated using
kcalloc() during hyperv_init() to avoid paying the memory cost on non-Realm
guests.

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..b1657cfabd7d1 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
[ ... ]
> @@ -85,6 +90,20 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
> =20
> +	/*
> +	 * The RSI host-call buffers are only ever used when
> +	 * is_realm_world() is true. Skip the allocation on non-Realm
> +	 * guests. A single contiguous array of nr_cpu_ids entries is
> +	 * allocated; each CPU indexes into it by its processor ID.
> +	 */
> +	if (is_realm_world()) {
> +		hv_hostcall_array =3D kcalloc(nr_cpu_ids,
> +					    sizeof(struct rsi_host_call),
> +					    GFP_KERNEL);

[Severity: High]
Does kcalloc() satisfy the __aligned(256) requirement of struct rsi_host_ca=
ll
when SLUB debugging or KASAN is enabled?

The struct definition explicitly demands 256-byte alignment:

include/linux/arm-smccc-rsi.h:
struct rsi_host_call {
	u16 immediate;
	u8 _padding[6];
	u64 gprs[31];
} __aligned(256);

kcalloc() only receives the size of the structure, not the alignment
constraint. When SLUB debugging is enabled, redzoning metadata is prepended=
 to
the object, shifting the base pointer off the 256-byte boundary. A misalign=
ed
Intermediate Physical Address (IPA) might lead to hardware rejection of the
hypercall by the Realm Management Monitor (RMM).

Additionally, since this allocates a single contiguous array for all CPUs,
does it bypass NUMA locality? Using alloc_percpu() would satisfy the alignm=
ent
constraint natively and allocate memory on local nodes.

> +		if (!hv_hostcall_array)
> +			return -ENOMEM;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002215725.2015=
959-1-kameroncarr@linux.microsoft.com?part=3D3
