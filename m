Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959E2F0C74
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115752; cv=none; b=SzQyTSckgUcD7WY5FyWT6oZzy1pqRZMBVuU36a4CjV4towsKMU91GgDlLno+q5c/sSm02/TcrJcfJTgj4aUoQLZGwCz16fIE+KqtvyzIU3U9pWaOVPayfAz7BBf7Kh4tfbOlnUv36E6LLcxJgfV5J1f+nxBV/QrIzWJCinSJpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115752; c=relaxed/simple;
	bh=0PVzGNLFAY6LxtPu0lzZ9hOSHAUXjWuziFw39/EblhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l1s2oM3a4tbUsuk9UW91WqzpixXN5YV8dVpXkP2yGdI/bnsncdhV1ks2RnxHIVdQTHG01rZn6VQxozEeoReqi+4hE6ed2sq2On1VTIraVR2Izyg3E62RiGZW+Yw22VXZ7VY03D7UH9CwyhGqmFwYA4zCG23HPyI3sy8xmSGYY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdwd4dCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdwd4dCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1361F00A3A;
	Fri,  7 Aug 2026 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115751;
	bh=/+bf3+lWnhTvzuP1CsnbTN/NrSNlHPBqM7LvuPgRb7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rdwd4dCNw5w8xw5aGJRJdguFYr94pTz3Zbj6iwFMqYK9ZRiEyHju9qihCqCv1oKn/
	 99t82wioCLbQHJP+rR3gIcQYEgj3qzu93OdKRc7rhE2K3IUqDX/LX679VWY0vjvHF/
	 nY/S0Eko9nh4uTstRJsXFME7jA7xukAgFIZzcgSftcXJtQcHzXHkvjfmDvvNxsB6OE
	 haMYN2XF1bg8b+TfgkjOH76Eh9PEtEzhQIQ3dQNQEVnCI+ztHzlA0IM/E/HLq7A8vz
	 ogxoJUoeV2/pjFUfpzS1YevLaXNVIwaoi0lxY0Wp6VyHn03G4kvq4DSt9SIhwosN6K
	 0zu/G+obZTCFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/13] mshv: default to safe partition CPU features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-8-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-8-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:15:50 +0000
Message-Id: <20260807151551.6C1361F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Functional regression and uninitialized stack memory use on ARM64 =
for legacy partition creation.

Pre-existing issues:
- [Medium] TOCTOU double-fetch race allows validation and use of flag-gated=
 parameters outside their flag gate.
--

--- Patch [7]: [PATCH v1 07/13] mshv: default to safe partition CPU feature=
s ---
commit 85299e9eb98a0db0daae1adea69f8e739d17d8db
Author: Wei Liu <wei.liu@kernel.org>

mshv: default to safe partition CPU features

For legacy create-partition callers, disable all processor and xsave
features first, then enable only the default feature set known to be
supported. Passing an all-zero disabled feature mask can make SEV-SNP
partition creation fail on Hyper-V.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index cc38507570ac4..11d3c86050b45 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2333,6 +2333,86 @@ static long mshv_ioctl_process_pt_flags(void __use=
r *user_arg, u64 *pt_flags,
>  	disabled_procs =3D &cr_props->disabled_processor_features;
>  	disabled_xsave =3D &cr_props->disabled_processor_xsave_features;
> =20
> +	/* Disable all processor features first. */
> +	for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +		disabled_procs->as_uint64[i] =3D U64_MAX;
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +	/* Enable default features that are known to be supported. */

[ ... ]

> +	disabled_xsave->as_uint64 =3D U64_MAX;
> +	disabled_xsave->xsave_support =3D 0;
> +	disabled_xsave->xsaveopt_support =3D 0;
> +	disabled_xsave->avx_support =3D 0;
> +#endif
> +
>  	/* Check if user provided newer struct with feature fields */
>  	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
>  		if (copy_from_user(&args, user_arg, sizeof(args)))
>  			return -EFAULT;

[Severity: Medium]
This is a pre-existing issue, but does this second fetch from userspace
introduce a race condition?

If a concurrent userspace thread clears the MSHV_PT_BIT_CPU_AND_XSAVE_FEATU=
RES
flag between the first and second fetch, args.pt_flags will be overwritten
with the new value. The code does not re-verify the flag before proceeding =
to
validate and use extended v2 fields like args.pt_num_cpu_fbanks.

This could allow the kernel to operate on uninitialized userspace garbage.

[ ... ]

> @@ -2371,16 +2451,6 @@ static long mshv_ioctl_process_pt_flags(void __use=
r *user_arg, u64 *pt_flags,
>  		if (mshv_field_nonzero(args, pt_rsvd2))
>  			return -EINVAL;
>  #endif
> -	} else {
> -		/*
> -		 * v1 behavior: try to enable everything. The hypervisor will
> -		 * disable features that are not supported. The banks can be
> -		 * queried via the get partition property hypercall.
> -		 */
> -		for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> -			disabled_procs->as_uint64[i] =3D 0;
> -
> -		disabled_xsave->as_uint64 =3D 0;
>  	}
> =20
>  	/* Only support EXO partitions */

[Severity: High]
Does removing this fallback initialization break legacy v1 callers on ARM64?

With this code removed, disabled_procs->as_uint64[i] is unconditionally set
to U64_MAX earlier in mshv_ioctl_process_pt_flags(), which disables all
processor features. Because the new default initializations are inside an
#if IS_ENABLED(CONFIG_X86_64) block, ARM64 callers never get those defaults
nor the old 0 initialization.

Additionally, disabled_xsave points to the disabled_processor_xsave_features
field of cr_props (which is on the stack in mshv_ioctl_create_partition).
Since it is no longer initialized to 0 here for non-x86 v1 callers, will it
send uninitialized stack memory to the hypervisor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D7
