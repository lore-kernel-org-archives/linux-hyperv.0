Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEE476690
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117323; cv=none; b=NJqfD/QllrGgZ7B/ifZbDMkkUekMnZWQRcW7Bwu+RuZOME6kIX06MUQEKdORKP0xKovw4LYXe3eixqLSdUgWWv/4eCcaH/UV+AE7sx6fZaW1afdy1PFGAxwqaUzvMbnvvtOz71T65nu0Pw5+018mrEIqm1TmNl1AK63oEZqPL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117323; c=relaxed/simple;
	bh=72MsQjy6D3L7SsvHD6ubRPldvYSRu8I1zGyEym+GlsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Leucu6/wHL7k7By8GjAgdJ6KHHLGTf55bPU28QI00kpk9bUbUwW17eO7XEehrISVlvod1e+xyShZgH8Wv/hxjuHRv+CHca91IpwdbXRhtw0703vOMA/2pa5ISaZNAXJJMm4a6sKGFkbQADsqil4H162gKRh8OiMmz4p4RYZYAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntCHfkkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntCHfkkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A51F00A3A;
	Fri,  7 Aug 2026 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117321;
	bh=XJDjdH5Tgn+/KfoBe21ckVnyBZLMXmZoJhDQvNnW8KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntCHfkkFsjskBpus3hPSiQbkHY/aoUPPV43Gj3aFN7lXjaYOV8ixfy+tfEXIcNxBR
	 PtP4OTbwv9s3C+MkDSslXIGzTthDNYTt7rGQa2+UjXnF9mPUAwmwA1RXh6sfkS92bT
	 Ow9ZAKFZkPD+8KUb7ISrZgKXk4rjysDU6wI2NmeoiPlgxsDrM5GvRw9sAqeFvIYs+L
	 3jch62KExAYlU7G4bji3cC7HUwhQI01KBrDAZihnnhV9yEHhQYGzgF1fIE4tv4iCgi
	 VfhuEBID0gCgg6vwNq/MnRUfMZS2yCC6M8QpGn9+DKwYnGkgHfsS3OFBuWvhDvExS3
	 F/JqkkiF4GYxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/13] mshv: define full processor and xsave feature
 masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-10-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-10-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:42:00 +0000
Message-Id: <20260807154201.327A51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized kernel stack memory is leaked to the hypervisor on=
 non-x86 architectures when the legacy v1 ioctl is used.
- [Low] Typo in the bitfield name `vrew_clear_supported` (should be `verw_c=
lear_supported`).
--

--- Patch [9]: [PATCH v1 09/13] mshv: define full processor and xsave featu=
re masks ---
commit 758f4dc3eb51bb86e9e77dff7703639f92529960
Author: Wei Liu <wei.liu@kernel.org>

mshv: define full processor and xsave feature masks

Add the missing processor and xsave feature bit definitions and use
them when constructing the default disabled-feature mask, so legacy
SNP partition creation applies a complete, well-defined feature mask.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 729916e1eacff..c81a8d0493c19 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2406,11 +2406,21 @@ static long mshv_ioctl_process_pt_flags(void __us=
er *user_arg, u64 *pt_flags,
[ ... ]
>  	disabled_xsave->as_uint64 =3D U64_MAX;
>  	disabled_xsave->xsave_support =3D 0;
>  	disabled_xsave->xsaveopt_support =3D 0;
>  	disabled_xsave->avx_support =3D 0;
> +	disabled_xsave->xsave_comp_support =3D 0;
> +	disabled_xsave->xsave_supervisor_support =3D 0;
>  #endif
> =20
>  	/* Check if user provided newer struct with feature fields */

[Severity: Medium]
Does this leave disabled_xsave uninitialized on non-x86 architectures when
using the legacy v1 ioctl?

When MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES is not set on ARM64, the fallback
initialization that clears disabled_xsave->as_uint64 is skipped because it =
is
nested inside the v2 struct check block further down in
mshv_ioctl_process_pt_flags().

This leaves 8 bytes of uninitialized kernel stack in
creation_properties.disabled_processor_xsave_features (allocated in
mshv_ioctl_create_partition()), which is then passed to the hypervisor via
hv_call_create_partition().

This appears to have been introduced earlier in this patch series in the co=
mmit
"mshv: default to safe partition CPU features" when the original else block
clearing the legacy features was removed.

> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 691ac495a095d..54b0e671a028f 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -231,7 +231,47 @@ union hv_partition_processor_features {
>  		u64 fzlrep_movsb : 1;
>  		u64 fsrep_stosb : 1;
>  		u64 fsrep_cmpsb : 1;
> -		u64 reserved_bank1 : 42;
[ ... ]
> +		u64 sbpb_supported : 1;
> +		u64 ibpb_br_type_supported : 1;
> +		u64 srso_no_supported : 1;
> +		u64 srso_user_kernel_no_supported : 1;
> +		u64 vrew_clear_supported : 1;

[Severity: Low]
This isn't a bug, but there is a typo in the bitfield name vrew_clear_suppo=
rted,
it should be verw_clear_supported.

> +		u64 tsa_l1_no_supported : 1;
> +		u64 tsa_sq_no_supported : 1;
> +		u64 lass_support : 1;
> +		u64 reserved_bank1 : 2;
>  	} __packed;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D9
