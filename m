Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6E485CDA
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282617; cv=none; b=W4LY7IKL8NRV+Uj/xGVa4rsImcCXx9adIgboAtdJrvLVahctMgAv8MTk2BT8w3qZ8X3UHJudENfOU8Y8qsBujJtMx/lZNd+4VS3Cl1dmBfwhJxUh5pxjL52Zn6IwhylFiS6VbtjDzhOZ9SuMkoAhr2A+QRZ8frk0poHN5C6P+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282617; c=relaxed/simple;
	bh=lDCnZq9AlDEqt2Gb2HsUZnLNRyg6fywR0cmD8MyRMew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qT8vhSO5OYOqVTXLXg3SWnjSRjzh17lDtEIP+Qzfxq/gPX52SlqX8PidqcDh43Y/Fa3Iv8v2fguty4QgOoMmUHI3Scrygu4bFH2cLrXILWeZAKRuMd6XaMSMKCv9iOjxwkSD8i589VOFMO7iRWut2/6WMN6OC6AjCXQugyIhB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKEHn4Mf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKEHn4Mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14DE1F000E9;
	Tue,  1 Sep 2026 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282615;
	bh=uaj7vguPcJkMyxI6JTZMuCUx77wPPhK4VVl36xv6ucQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKEHn4Mf2qXXMbLry29UVXgOtV/C25YO8lIWyBaDK5A/MvAxUEOhXsa346eWj8toz
	 hf1FcXuxcEl0sSScmjgMuZVcJbX1klDlYmp5il9Pv5+8niaGyMX2r8fbi+5in3Q41d
	 /y76CcZ08DOZQNC3CpOeKhkOoRbmfNrHI94NOMKrrc1zlcwuai4M561hSee0Eid9zp
	 xuekezGJmFs4VIfWsiODoOmYf8nPfloeAGq2XcliXP/GJMTOuwqqou/kXGWrFw9tqA
	 lcjATSBsy2rfmJiLOVNI7/dN3yIXEfpeE7GifnjonOz5vSOwmP6OiKEVs16YRguK5l
	 ECfI7cDqYNRcQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/12] drivers: hv: Reserve memory for VSM secure
 kernel during early boot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-4-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-4-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:10:14 +0000
Message-Id: <20260901171014.A14DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The automatic memory reservation fallback is never executed if the=
 `securekernel` parameter is omitted from the kernel command line.
- [High] Manual string parsing of boot_command_line uses a fragile substrin=
g match, misparsing unrelated parameters and ignoring the pre-parsed setup =
argument.
- [Medium] The `__setup` handler returns 0 on success and -EINVAL on failur=
e, inverting the API contract and leaking the parameter to the init process.
- [Low] parse_securekernel_simple fails to validate trailing characters aft=
er parsing the base address.
--

commit c057f006b3a9db9a754349283e3c7dd23550b133
Author: Thara Gopinath <tgopinath@linux.microsoft.com>
Date:   Tue Sep 1 16:55:17 2026 +0000

    drivers: hv: Reserve memory for VSM secure kernel during early boot

The VSM secure kernel runs in VTL1 and requires its memory to be reserved
early. This commit introduces a driver to handle early boot reservation of
this memory, either parsed from the securekernel=3D command line parameter =
or
calculated automatically as a fallback.

> diff --git a/drivers/hv/hv_vsm_securekernel.c b/drivers/hv/hv_vsm_securek=
ernel.c
> new file mode 100644
> index 0000000000000..f90f6204b4d18
> --- /dev/null
> +++ b/drivers/hv/hv_vsm_securekernel.c
[ ... ]
> +static int __init parse_securekernel_simple(char *cmdline,
> +					    unsigned long long *securekernel_size,
> +					    unsigned long long *securekernel_base)
> +{
> +	char *cur =3D cmdline;
> +
> +	*securekernel_size =3D memparse(cmdline, &cur);
> +	if (cmdline =3D=3D cur) {
> +		pr_warn("securekernel: memory value expected\n");
> +		return -EINVAL;
> +	}
> +
> +	if (*cur =3D=3D '@') {
> +		*securekernel_base =3D memparse(cur + 1, &cur);
> +	} else if (*cur !=3D ' ' && *cur !=3D '\0') {

[Severity: Low]
Does this code skip trailing character validation if @ was found?

Because the validation is inside an else if, if a user specifies a base
address with trailing non-space characters (e.g., securekernel=3D16M@2G_foo=
),
memparse() consumes the valid number, but the remaining garbage characters
are silently ignored without raising an error.

> +		pr_warn("securekernel: unrecognized char: %c\n", *cur);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static __init char *get_last_securekernel(char *cmdline, const char *nam=
e)
> +{
> +	char *p =3D cmdline, *sk_cmdline =3D NULL;
> +
> +	/* find securekernel and use the last one if there are more */
> +	p =3D strstr(p, name);
> +	while (p) {
> +		sk_cmdline =3D p;
> +		p =3D strstr(p + 1, name);

[Severity: High]
Does this unbounded substring search misparse unrelated parameters?

Because it lacks word-boundary or prefix validation, strstr() will match
the substring anywhere in the command line. The driver could misparse
independent kernel parameters (e.g., nosecurekernel=3D100M).

Furthermore, since it explicitly searches for the last occurrence, an unrel=
ated
parameter at the end of the command line containing the substring secureker=
nel=3D
could overwrite a valid reservation parameter.

> +	}
> +
> +	if (!sk_cmdline)
> +		return NULL;
> +
> +	return sk_cmdline;
> +}
[ ... ]
> +static int __init hv_vsm_seckernel_mem_init(char *__unused)

[Severity: High]
Is it intentional to discard the correctly pre-parsed parameter value provi=
ded
by the __setup infrastructure?

The __setup() macro already does exact matching and provides the specific
parameter value to the callback via its argument. By explicitly ignoring th=
is
argument (naming it __unused) and implementing a custom parser over the glo=
bal
boot_command_line, the driver uses a fragile manual parsing routine instead
of the established API.

> +{
> +	unsigned long long securekernel_size =3D 0, securekernel_base =3D 0;
> +	int ret;
[ ... ]
> +	/* Default: Find the base address automatically */
> +	if (!securekernel_base) {
> +		securekernel_base =3D memblock_phys_alloc_range(securekernel_size, SEC=
KERNEL_ALIGN,
> +							      0, SECKERNEL_ADDR_MAX);
> +		if (!securekernel_base) {
> +			pr_err("%s: Securekernel reservation failed-VSM will not be enabled.\=
n",
> +			       __func__);
> +			return -EINVAL;

[Severity: Medium]
Will returning -EINVAL (non-zero) on the error path incorrectly tell the
kernel's parser that the parameter was successfully handled?

The kernel API documentation requires __setup handlers to return 1 (or
non-zero) if handled and 0 if not. Returning a non-zero error code treats
the failed parameter as successfully consumed.

> +		}
> +	}
> +
> +	pr_info("Reserving %ldMB of memory at 0x%llx(%ld MB) for securekernel(S=
ystem RAM:%ldMB)\n",
> +		(unsigned long)(securekernel_size >> 20),
> +		securekernel_base,
> +		(unsigned long)(securekernel_base >> 20),
> +		(unsigned long)(memblock_phys_mem_size() >> 20));
> +
> +	sk_res.start =3D securekernel_base;
> +	sk_res.end   =3D securekernel_base + securekernel_size - 1;
> +	insert_resource(&iomem_resource, &sk_res);
> +
> +	return 0;

[Severity: Medium]
Will returning 0 on the success path inform the kernel's setup infrastructu=
re
that the parameter was not handled?

This causes the kernel to erroneously pass the securekernel=3D... parameter=
 as
an environment variable to the init process. The handler should return 1 wh=
en
the parameter is successfully handled.

> +}
> +__setup("securekernel", hv_vsm_seckernel_mem_init);

[Severity: High]
Can the automatic memory reservation fallback ever execute if the parameter=
 is
omitted from the kernel command line?

Functions registered with __setup() are only invoked by init/main.c if the
target string matches a command-line parameter. If absent, the initializati=
on
function is completely bypassed, meaning the core feature (automatic memory
reservation) fails entirely by default, and the VSM secure kernel will not =
boot
due to lack of reserved memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D3
