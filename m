Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2345431E70;
	Wed,  1 Jul 2026 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935183; cv=none; b=htI2WqULbcc62zPLTaS7pC9tAFAvTmKEYX2grRD1gWJ7YLgf4bJJEDvspE3r5BKHNOkFBxWepu3EoFjd0Z7PfgX4GWD/Jqj6+i9/Im5/lUU5Yn1x+bcyzKZO/Akp1y4lMAIed8wbvdAT6iI/zryPvazu75weQ8V+biE0vpPFcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935183; c=relaxed/simple;
	bh=gTqmPrSJkxG+rQXWJxdRhZrx2hwkzuaVslqB4VQDh1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PvwUnmZgFISk/5YZdGdK5zgOK2apU/79mJGikam3LzDIocW518Jawd/WH/DZcuXfCk53N6oRptqAc3E5MsEOZYHFuLwxZ4wX48kT/GLYSu5A0n1BbQjHr+LD77SDLomF0z09dtfTXiGjrbWwRvQBfub3txLqUong9LcBGRYY1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftOPJmjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftOPJmjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD691F000E9;
	Wed,  1 Jul 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935181;
	bh=UgyHLN8l2Yl0gsNzeUY9m8Up+tR/5lYEoMJTF5aAu6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftOPJmjNFjUQH2Kish3G/WUaKn2OODu461lx854Tn84bZ70tHs1sv94V06+DJXAzD
	 KDW/TAyR379wIZY1/4BHo2m+O1d3Abk7yDACe3Y4W65rSdshl6UYgsqrej+PJ1X9OQ
	 ImjOZJ+4bkOF6CSJ6JO45KQMQlUGWAtxZrFZAV5nF7+CuwoZcoOrzLwKOKqlY7dBin
	 02CgpqomQ24qj+pT3+fNgeLMbRMIcNIgYPvLeHhB5AImPqiuo8iiurknnFtO+63qGm
	 Y8eD5GX76Y07XD17ibIlfuIK8FqljT3OUphXGsWV/FoAL9dz+D913eokZrKZr4pfBg
	 DAV45Mf7ExWsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/51] x86/apic: Provide helpers to set local APIC
 timer period in hz and khz
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260701193212.749551-2-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:46:20 +0000
Message-Id: <20260701194621.4BD691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `apic_set_timer_period_khz()` and `apic_set_timer_period_hz(=
)` helper functions accept a `const char *source` argument which is never u=
sed, resulting in dead code and a silent loss of boot diagnostic logging on=
 platforms where logging was removed.
--

commit 4fb576b0d909663c9b3e6628dbed45d329c08a5d
Author: Sean Christopherson <seanjc@google.com>

x86/apic: Provide helpers to set local APIC timer period in hz and khz

This commit adds APIs to set the local APIC timer period, abstracting the
HZ math previously open-coded by external callers. It also changes the
lapic_timer_period variable to be local to apic.c.

> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index aa1e19979aa8e..8d3d930576fd7 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c

[ ... ]

> @@ -796,6 +796,16 @@ bool __init apic_needs_pit(void)
>  	return lapic_timer_period =3D=3D 0;
>  }
> =20
> +void apic_set_timer_period_khz(u64 period_khz, const char *source)
> +{
> +	lapic_timer_period =3D mul_u64_u32_div(period_khz, 1000, HZ);
> +}
> +
> +void apic_set_timer_period_hz(u64 period_hz, const char *source)
> +{
> +	lapic_timer_period =3D div_u64(period_hz, HZ);
> +}

[Severity: Medium]
It looks like the source parameter is accepted by apic_set_timer_period_khz=
()
and apic_set_timer_period_hz() in arch/x86/kernel/apic/apic.c but is never
used. Was it intended to log the frequency using this source string?

> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 185d4f677ec0f..87beecec76f04 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -646,10 +646,7 @@ static void __init ms_hyperv_init_platform(void)
>  		u64	hv_lapic_frequency;
> =20
>  		rdmsrq(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
> -		hv_lapic_frequency =3D div_u64(hv_lapic_frequency, HZ);
> -		lapic_timer_period =3D hv_lapic_frequency;
> -		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
> -			lapic_timer_period);
> +		apic_set_timer_period_hz(hv_lapic_frequency, "Hyper-V hypervisor");
>  	}
> =20

[ ... ]

> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 34b73573b108d..36f779dd311dc 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -424,9 +424,7 @@ static void __init vmware_platform_setup(void)
> =20
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		/* Skip lapic calibration since we know the bus frequency. */
> -		lapic_timer_period =3D ecx / HZ;
> -		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
> -			ecx);
> +		apic_set_timer_period_hz(ecx, "VMware hypervisor");
>  #endif

[Severity: Medium]
These changes remove the pr_info() logging of the APIC frequency during ear=
ly
boot APIC initialization in ms_hyperv_init_platform()
(arch/x86/kernel/cpu/mshyperv.c) and vmware_platform_setup()
(arch/x86/kernel/cpu/vmware.c).

Since the new apic_set_timer_period_hz() helper does not log this informati=
on,
does this result in an unintended loss of boot diagnostic logging on these
platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D1
