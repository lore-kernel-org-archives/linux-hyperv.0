Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8583DA5B2
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366644; cv=none; b=dwDucbocyrlTKt6FrXrADClzXEehoB0gpeQ2aVx7dUS3d8kTEq2d5NDty+YlhuG8rX5aKL4OXAQsz7TKOcGkNWYrB2qqypiZIbbmE0thmz2tXoLoFGmdVY3DEKJyLqXSdPVYJF0972wlqrldbV/ks+ibus0hSiBWz3K6AMe5LIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366644; c=relaxed/simple;
	bh=HVBnVS6EbxCl7rWoCnIhnyDKBdnpRvQNeF7+vHSO+iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hM+coWgZbYn6R2BFEKGukEhBhv+2ptXthReUDtHqw3TT7pYt46+p7hFdE9V3XTCn5PblJrctd2yzJ/CzIqx8XVVwdvZ7hIxd7ZuLFrgM+yAGWc1nNcLQ1h948AUrEeLTHFyft9cckNaqhHH0Qh150f8hj2kxsY8o/2AcEMmjEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwbPt6sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwbPt6sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F87C1F000E9;
	Mon, 10 Aug 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366643;
	bh=+zdZTTUY7HCgpcxVuJ5+6glUTMVOUPNgosv2beUkM6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwbPt6snDr0DUa5LGLUV7c1zb2xt1+IJ1KGWK75x9KE6zlbeqPRCkJfA/G2jeBSmF
	 N6Re3qzCx0/rS3BdxHXw3QLWpsQtA8Mh1ATb3tf1OX2Cz5OcZbRYtHd8+a3J4Hh7bG
	 3ucDRbAsYvLCAZxexlLPDDaKNSlrZBbJ5MbLcOKY8J8Q0HtG7mrghmhADEYw0mUbPb
	 TRw6+XCIyaQSMp/mZXeKt5XbbKaFQ0ld7h6/YFCsyGiYIrt36oNx4fqUCwsegRQJQl
	 /8d/TV6igJoY39wyZP7kgQei2YT7SmeQVzJy9NtuKqEfFlh1Qg2IXKzj0o2MMKHrFv
	 BwaHlEQg3VEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] mshv: default to safe partition CPU features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-8-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-8-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:57:22 +0000
Message-Id: <20260810125723.0F87C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Legacy V1 API callers requesting nested virtualization will no lon=
ger receive the nested virtualization CPU feature, breaking ABI compatibili=
ty.
--

--- Patch [7]: [PATCH v2 07/13] mshv: default to safe partition CPU feature=
s ---
commit 01e208d51ef280f67802036c435ff766571437ae
Author: Wei Liu <wei.liu@kernel.org>

mshv: default to safe partition CPU features

For legacy create-partition callers, disable all processor and xsave
features first, then enable only the default feature set known to be
supported. Passing an all-zero disabled feature mask can make SEV-SNP
partition creation fail on Hyper-V.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 712f45dcef60c..ad2e708fd7539 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2373,15 +2373,102 @@ static long mshv_ioctl_process_pt_flags(void __u=
ser *user_arg, u64 *pt_flags,
>  	    args.pt_isolation >=3D MSHV_PT_ISOLATION_COUNT)
>  		return -EINVAL;
> =20
> +	memset(cr_props, 0, sizeof(*cr_props));
> +	memset(isol_props, 0, sizeof(*isol_props));
>  	disabled_procs =3D &cr_props->disabled_processor_features;
>  	disabled_xsave =3D &cr_props->disabled_processor_xsave_features;
> =20
> +#if IS_ENABLED(CONFIG_X86_64)
> +	/* Disable all processor features first. */
> +	for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +		disabled_procs->as_uint64[i] =3D U64_MAX;
> +
> +	/* Enable default features that are known to be supported. */
> +	disabled_procs->sse3_support =3D 0;

[ ... ]

> +	disabled_procs->cet_ss_support =3D 0;
> +	disabled_procs->cet_ibt_support =3D 0;
> +	disabled_procs->vmx_exception_inject_support =3D 0;

[Severity: High]
Does this omission break legacy callers requesting nested virtualization?

Since all features are disabled by default (U64_MAX), and
disabled_procs->nested_virt_support is not explicitly set to 0 in this
default list, won't nested virtualization remain disabled for the guest CPU
even if the legacy caller sets MSHV_PT_BIT_NESTED_VIRTUALIZATION?

Later in mshv_ioctl_process_pt_flags(), the creation capability is enabled
if requested:

    if (args.pt_flags & BIT(MSHV_PT_BIT_NESTED_VIRTUALIZATION))
            *pt_flags |=3D HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION=
_CAPABLE;

However, because the CPU feature itself is left disabled by the new safe
defaults list, it appears this will break nested virtualization for V1 ABI
callers.

> +
> +	disabled_xsave->as_uint64 =3D U64_MAX;
> +	disabled_xsave->xsave_support =3D 0;
> +	disabled_xsave->xsaveopt_support =3D 0;
> +	disabled_xsave->avx_support =3D 0;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D7
