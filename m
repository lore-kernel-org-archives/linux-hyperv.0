Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BC483811
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282570; cv=none; b=OYUAk/To1urFxvmED+yL26jw5bxpFDcAmUGDBAnWI2X0qDnDRh3UBOhZVAb/zgGs7moP4nL4xS9BYpwVdivrSCWAgNg24G1kY3lNFcZxpO/tTCGhPvkIjxmdCPSNi4muuSJ30oiq5BqIZC27mRrLfnbqrUYhJHUvM7psOagh1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282570; c=relaxed/simple;
	bh=A+AY8NGSTQHol/oPi+Gdr8tuRsNkqi1VomRl+dmrphw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRebzy7H3Q4i9NN/7SskCgypZJKy4BkaxgSqjgKFaGVmSpAVe+EIrMFPU/lZmqlk/VTJhGD98rjCX2eVEYmDA/5Aj+7O6SYI0BrrachlEwrFOtFeBDQTKLoVMbWNwOeKbrjTJWvcwa55966cXYf+LOzPALSiDLgFTDlwANglNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DClX0pay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DClX0pay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1091F000E9;
	Tue,  1 Sep 2026 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282569;
	bh=t6JkAfekKBciD6cKR0UIs4JItP2QhJbf7GXXOgPvbLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DClX0payDt2nCrgiloeQbc2q4muxBFOQwaYC7qrvXD0KtCj5obU767eJ5N2CT/d5d
	 Rj/0FGAl9yBcSXejw5bwXw3d4ghX6/uJoGHNWwA0ak9uBWq5EQ+zIrk+3mjOWkeQie
	 9evpFpS+3MYJv5TAr/O2kP7LI+Nva9q5QvzB6vXe5Mt4GWXiOc4jqFUmqOsHUWS6KV
	 DO9l/efUzSq6rH4KmYIT9MTfQePa4M37KV2fgxiQx+TrSJcQdEIVlym9Z0tiQJglww
	 KS75ZCwyN8XTE+HRWuPdwR8UrJ481ji0IalCZIqyvtFGnAqeGkuW0uC7FnZkZmUEGK
	 T6+H75tRu7dsQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/12] firmware: efi: libstub: x86-stub: Enable VSM
 awareness in efi os indications variable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-5-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-5-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:09:27 +0000
Message-Id: <20260901170928.6B1091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Uninitialized stack memory leak to NVRAM and unintended EFI variab=
le size modification.
- [Medium] Unconditional execution of `efi_set_hv_os_indications()` causes =
an EFI error message on all non-Hyper-V systems.
- [Medium] `efi_set_hv_os_indications()` fails to enable VSM if `OsLoaderIn=
dications` does not already exist.
- [Low] Missing newline character in `efi_info()` output.
--

commit 3d285ae76c7e0c1fdff6a68f110b5b5a021e7b38
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

firmware: efi: libstub: x86-stub: Enable VSM awareness in efi os indication=
s variable

This commit sets bit 0 of the Hyper-V private OsLoaderIndications EFI varia=
ble
during exit_boot() to let the bootloader or firmware know that the OS inten=
ds
to enable VTL1. The variable is written only when supported and when the bit
is not already set.

> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/e=
fi/libstub/x86-stub.c
> index cef32e2c82d8f..ab3cd4fe36599 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c

[ ... ]

> @@ -754,6 +765,47 @@ static efi_status_t exit_boot_func(struct efi_boot_m=
emmap *map,
>  	return EFI_SUCCESS;
>  }
> =20
> +#ifdef CONFIG_HYPERV_VSM
> +static void efi_set_hv_os_indications(void)
> +{
> +	efi_guid_t guid =3D HYPERV_PRIVATE_EFI_NAMESPACE_GUID;
> +	efi_status_t status;
> +	unsigned long size;
> +	u32 attr, val;

[Severity: High]
Since val is declared without zero-initialization, is it possible for
get_efi_var() to copy fewer than 4 bytes if the actual size of the variable
in NVRAM is smaller?

If so, the upper bytes of val might remain as uninitialized stack memory.
When set_efi_var() is subsequently called with size =3D sizeof(val), could
this leak up to 3 bytes of uninitialized kernel stack memory into persistent
NVRAM?=20

Also, could this force the EFI variable to be exactly 4 bytes, potentially
corrupting it if the firmware expects a different size?

> +
> +	size =3D sizeof(val);
> +	status =3D get_efi_var(efi_HvPrivOsloaderIndicationsSupported_name,
> +			     &guid, &attr, &size, &val);
> +	if (status !=3D EFI_SUCCESS) {
> +		efi_err("Could not read Hyper-V OsloaderIndicationsSupported\n");
> +		return;
> +	}
> +
> +	if (!(val & HV_OSLOADER_INDICATION_VSM)) {
> +		efi_info("Hyper-V does not support VSM in OsloaderIndicationsSupported=
\n");
> +		return;
> +	}
> +
> +	size =3D sizeof(val);
> +	status =3D get_efi_var(efi_HvPrivOsloaderIndications_name, &guid, &attr=
, &size, &val);
> +	if (status !=3D EFI_SUCCESS) {
> +		efi_err("Could not read Hyper-V OsLoaderIndications\n");

[Severity: Medium]
If the OsLoaderIndications variable does not exist (for example, on a fresh
OS installation or if not pre-populated by firmware), get_efi_var() will
return EFI_NOT_FOUND.=20

Does treating this as a fatal error prevent VTL1 from being brought up?

Would it be better to handle EFI_NOT_FOUND by assuming val is 0 and
proceeding to create the variable?

> +		return;
> +	}
> +
> +	if (val & HV_OSLOADER_INDICATION_VSM) {
> +		efi_info("VSM is already supported in OsLoaderIndications.");

[Severity: Low]
Does this efi_info() string need a trailing newline character?

Because efi_info() maps to efi_printk() which does not append newlines
automatically, this might cause subsequent EFI console output to be
concatenated onto the same line.

> +		return;
> +	}
> +
> +	val |=3D HV_OSLOADER_INDICATION_VSM;
> +	size =3D sizeof(val);
> +	status =3D set_efi_var(efi_HvPrivOsloaderIndications_name, &guid, attr,=
 size, &val);
> +	if (status !=3D EFI_SUCCESS)
> +		efi_err("Could not set Hyper-V OsLoaderIndications to indicate VSM sup=
port\n");
> +}
> +#endif
> +
>  static efi_status_t exit_boot(struct boot_params *boot_params, void *han=
dle)
>  {
>  	struct setup_data *e820ext =3D NULL;
> @@ -768,6 +820,11 @@ static efi_status_t exit_boot(struct boot_params *bo=
ot_params, void *handle)
>  	if (status !=3D EFI_SUCCESS)
>  		return status;
> =20
> +#ifdef CONFIG_HYPERV_VSM
> +	/* Indicate to bootloader that we will be enabling VTL1 before exiting =
boot services */
> +	efi_set_hv_os_indications();

[Severity: Medium]
Since this function is called unconditionally on all x86 EFI boots when
CONFIG_HYPERV_VSM is enabled, will this cause get_efi_var() to return
EFI_NOT_FOUND on systems without Hyper-V?

It seems this could result in spurious error messages in the boot log for
all non-Hyper-V users because efi_err() is called unconditionally inside
efi_set_hv_os_indications().

Should there be a check for Hyper-V presence before making this call?

> +#endif
> +
>  	/* Might as well exit boot services now */
>  	status =3D efi_exit_boot_services(handle, &priv, exit_boot_func);
>  	if (status !=3D EFI_SUCCESS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D4
