Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8047535B
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Oct 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932436; cv=none; b=pcMiuTOcvQNT+VYu7G3qkkp/wgpSGsyXy9Sy9pvfts8l9xuE+pYIU3iR8vImDwBbkV/BH2ZedsL6I062GnkWXg6z+02Sa69hSzDv1PT2hFnPb7zj0WMAEmliHFQ+I6LMJo3ptxzCC9uv0Nuv/b2BzIHz40Bgx20ZRi1QojR48t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932436; c=relaxed/simple;
	bh=OZwELl/Fs16OW0EglzgHaz+ygN7ZbGdVvlNyIMYdGRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sr5Rs0UlW1TsTFcG6ExTqZ38GjpLDQl4RnpchCcsLuUblWRtO04e7JIqf7VJZRIYoB4FvlpuwgXYZF8GM51eNK0i1Uvm1zhA6uAFIoYCfH+rzeqRFI02gEXm6tV+T4SSiqi9Ay83Cj4BNAJAhRsTqLNi1ItKU2PI7HXAdXERumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/gbtiec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/gbtiec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9F41F00893;
	Fri,  2 Oct 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932434;
	bh=HS9Vik3tz/Mx+mD/MQ6559CgjWnKy0Sqq7dMCC4t2YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/gbtiecfl5EecWoXW3vWHYEMXl0CNdeSEhhbe3ngKpaC5hUpae6EC2cNfiziwDKP
	 57eB8cXkon5J3ma1QUcewkcGAsVotcACNXxKJvX7J6oIcCXi5a2Avm1f4nrLNej+FV
	 95p63U7GFADswVYPVla+jPSe/JOP7vM9FmdZpJAdWGk7h8uF6FEyK5fEhVXr4o6keG
	 GcuDay+zizhQoZRArBUKMmtGAvhhij3MOF5yMVPahgS9kzPFRl7MEDe/H8tcpj/BZi
	 LQmqQb/fUC58TFTcmfwJoC8oSAAxYAoqIjeTXtXlyjfxQRHSGZzcpMr5e+4U4gQ+wM
	 yrtGNVI+E+4CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261001220552.1793471-4-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
 <20261001220552.1793471-4-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:54 +0000
Message-Id: <20261002091354.9D9F41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: hyperv: kcalloc does not guarantee 256-byte alignment for r=
si_host_call
- [Low] arm64: hyperv: unnecessary early boot memory allocation error handl=
ing
--

commit ef58d4d121fbefca0e2e24ac57c717abd6fc93ba
Author: Kameron Carr <kameroncarr@linux.microsoft.com>
arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms

This commit allocates a per-CPU array of rsi_host_call structures in
hyperv_init() for Realm guests. The array is used to route hypercalls
through the RSI_HOST_CALL interface since Arm CCA Realms cannot issue
Hyper-V hypercalls via HVC.

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
Does kcalloc guarantee the 256-byte alignment required by the RMM ABI for
the RSI_HOST_CALL structure?

When hv_do_rsi_hypercall() passes
virt_to_phys(&hv_hostcall_array[smp_processor_id()]) to rsi_host_call(),
the RMM might reject the hypercall if the physical address is unaligned,
which would break Realm guest booting.

The kcalloc API only guarantees ARCH_KMALLOC_MINALIGN (e.g., 8 or 16 bytes)
and does not respect the __aligned(256) attribute of the type. Furthermore,
when CONFIG_SLUB_DEBUG is enabled, redzones will shift the object pointer
away from natural alignment, ensuring that the 256-byte alignment
requirement is violated.

> +		if (!hv_hostcall_array)
> +			return -ENOMEM;

[Severity: Low]
Is returning -ENOMEM here necessary?

Because hyperv_init() is executed via early_initcall, physical memory
should be available. Complex error handling, cleanup logic, or returning
-ENOMEM in these early boot functions is often unnecessary dead code,
as an allocation failure typically means the system cannot boot anyway.

> +	}
> =20
>  	/* Setup the guest ID */
>  	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);

[ ... ]

> @@ -125,6 +144,11 @@ static int __init hyperv_init(void)
> =20
>  	hyperv_initialized =3D true;
>  	return 0;
> +
> +free_hostcall_mem:
> +	kfree(hv_hostcall_array);
> +	hv_hostcall_array =3D NULL;
> +	return ret;

[Severity: Low]
Can we omit this explicit cleanup path?

As noted above, executing cleanup logic for failures that are fatal
during early boot adds unnecessary code complexity.

>  }
> =20
>  early_initcall(hyperv_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001220552.1793=
471-1-kameroncarr@linux.microsoft.com?part=3D3
