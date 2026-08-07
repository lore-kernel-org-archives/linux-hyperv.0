Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2D25F988
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116649; cv=none; b=HX/J7DHKKyWK3LHx8c8W64dkgIQpXszqM454ghy0a0sPvDeNL53UOqOhYUVcrO2/Gx+jnhmb9hrj4/uuWSTYaaoPVSgru01Z7m3VViI3xd4D5B3TBqPjPtL11Xp6jwaqpBTkHWQy0GzKFEMqhc6Z7aDdjxEc/g6ZJxhZx1VDMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116649; c=relaxed/simple;
	bh=ltmHC23QIdWj15JLP0h9Lc/tvDrib/glR6LA/Cizk4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYCFbA10WNRk6/XOrlKYOxhhYHb6JlzA+BfP/ign6Piv8IykjNyYHJ2C45XgjYrcBot5KVuCmYPFm6uKa3QEClT9GU0ovpLgyxRKX5gNRW2T9OwQzgP0WAYc5oj68xWyi3OyfODaqbevWp9mNJqM/SR8j0xBp69NGTYZnqwz5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQDORWyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQDORWyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6691F000E9;
	Fri,  7 Aug 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116648;
	bh=qYDOKBd+h2vbXzlvRqO5pO4uhy0JDneZzGoQeyXn5Bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQDORWyrN/2NYxghQVNAW+Isqmbv/0F90M6O9VVF0hNtkJYF290eHxiQpEYbKtZ0B
	 8TOBYdH8PTL+XUnvAdc8/Q38AWUfeeWW7wO7LTlUgbL7rWgWByw0XLYPftN165kHXE
	 tcKTxacKT6ptkPnedJRGsjYC3bUwywzQpGzB6t34hfewtO36YDua39pzKl/NfGPbjV
	 USmReLhwDDbyj/X3YlrRpca0J/82qzilluvaBO4cLFBdSFVXaeAfr5IJmwl4hfMN/p
	 Tc/gNBkczJcW+h7ysU6CKfIuTzlJhj/lyKOaPxDNoIPr08637gsETVWTpV4mjyZeJr
	 rAwis/ECNK18w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/13] mshv: accept partial CPU feature banks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-9-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-9-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:30:47 +0000
Message-Id: <20260807153047.CF6691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Kernel stack memory leak to the hypervisor on ARM64 when the MSH=
V_PT_BIT_CPU_AND_XSAVE_FEATURES flag is omitted.
--

--- Patch [8]: [PATCH v1 08/13] mshv: accept partial CPU feature banks ---
commit f76ad6e0838cf1ac9e5affb070dfe61ab6bea40d
Author: Wei Liu <wei.liu@kernel.org>

mshv: accept partial CPU feature banks

Allow userspace to provide fewer than MSHV_NUM_CPU_FEATURES_BANKS banks
for the create-partition v2 ioctl. Preserve the default disabled-feature
mask for omitted banks instead of rejecting the ioctl or overwriting all
banks.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 11d3c86050b45..729916e1eacff 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2423,20 +2423,12 @@ static long mshv_ioctl_process_pt_flags(void __us=
er *user_arg, u64 *pt_flags,
>  		    args.pt_isolation >=3D MSHV_PT_ISOLATION_COUNT)
>  			return -EINVAL;
> =20
> -		if (args.pt_num_cpu_fbanks !=3D MSHV_NUM_CPU_FEATURES_BANKS ||
> +		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
>  		    mshv_field_nonzero(args, pt_rsvd) ||
>  		    mshv_field_nonzero(args, pt_rsvd1))
>  			return -EINVAL;
> =20
> -		/*
> -		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
> -		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
> -		 * (i.e. 2).
> -		 *
> -		 * Further banks (index >=3D 2) will be modifiable as 'early'
> -		 * properties via the set partition property hypercall.
> -		 */
> -		for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +		for (i =3D 0; i < args.pt_num_cpu_fbanks; i++)
>  			disabled_procs->as_uint64[i] =3D args.pt_cpu_fbanks[i];
> =20
>  #if IS_ENABLED(CONFIG_X86_64)

[Severity: Medium]
Does this code leak uninitialized kernel stack memory to the hypervisor on
ARM64?

When a user calls the MSHV_CREATE_PARTITION ioctl without the
MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES flag, the initialization of
disabled_processor_xsave_features appears to be skipped on ARM64.

In mshv_ioctl_create_partition(), creation_properties is allocated on the
kernel stack uninitialized:

    struct hv_partition_creation_properties creation_properties;

If the MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES flag is omitted, the block below
is skipped in mshv_ioctl_process_pt_flags():

    if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {

The default initialization of disabled_processor_xsave_features is
conditionally excluded via #if IS_ENABLED(CONFIG_X86_64), leaving it
uninitialized on ARM64.

Later, hv_call_create_partition() copies the entire structure to the
hypercall input page:

    memcpy(&input->partition_creation_properties, &creation_properties,
           sizeof(creation_properties));

Could this send 8 bytes of uninitialized kernel stack memory to the
hypervisor, potentially causing it to disable random XSAVE features for the
guest VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D8
