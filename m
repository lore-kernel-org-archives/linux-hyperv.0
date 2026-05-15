Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F684386C25
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876189; cv=none; b=tHFqoPRD48yKmk9ogmnXHkvudIrgzAdggdOK5oN1MN+N8xIdDjfbD9ZRyWiKge4KQ06JysmE3QUEvpatzzknmFRjLHbQxyrAWDhTtCjFaLdOO30cYWVwCHS/zbCwftKjcJYeV3tOGYXhRCkaC4CDDXTu8kGC91q0uUl/q7zQSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876189; c=relaxed/simple;
	bh=+LE8ciODWJx0Uj/lVjPOmW9g9d68dIt4jurrnGfGR94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vz/jEXFS2ityRz5YAqBiGV7oCejzzYSnhKobBJgTpELS0tjptSYHaxiXN86VhBTfbGxWyRyTaAtWrMe0InVzJM5S92jn7pvVLCmcpo3O+JJ7tiIW7HF5i0Cea+1/fbpEZZHXy7uyV2lReUBSRA/86PNibT+d+/t9l0hdLAmJD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk1GNJEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk1GNJEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C5C2BCB3;
	Fri, 15 May 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778876188;
	bh=+LE8ciODWJx0Uj/lVjPOmW9g9d68dIt4jurrnGfGR94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hk1GNJEEPK/AKsOqt9iGZSt1utYUlOW5lxln4isl0E6ioW3MCXVUO8LVJzZSr/PxK
	 I2UHGjtQIII/PWtimPHBLSD3RcWtEoUYtaRrXNjQUKhcJ11M1oET+xB4xxk1Y69oid
	 Xq1ZHt1/zD71Wyfz7PlMpKdy6CVOntixDA7gAbdkGlc6YaaXLOnmczceqSJs18sSyb
	 AX2aLVI3mAFdosYUig9+HUHhLOlCAXwSdEEXfErhefpMgE/a3EJf1qyVmdapsorNj0
	 PrJOBLd+9HM71O0LY1MMc8nHbHQb6AA1D+DklGF6evN4rRF35Sa5t2y6PXO8506vWp
	 lwdtAHuxoKIng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 32/41] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-33-seanjc@google.com>
References: <20260515191942.1892718-33-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:16:28 +0000
Message-Id: <20260515201628.9E3C5C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious WARN_ON stack trace on every boot for CoCo (SEV-SNP/TDX=
) guests under KVM.
--

commit e57255e4d076143a67d0e6e44f914aec31aed8c7
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Rejects attempts to override TSC calibration with lesser routine

This commit adds a sanity check when registering a TSC frequency calibration
routine to ensure the incoming routine is as robust as the outgoing one,
rejecting it with a warning if it is not. This prevents replacing a trusted
calibration source with a less trusted one.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 98bef1d06fa9d..7a261214fa3ef 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1319,8 +1319,13 @@ void tsc_register_calibration_routines(unsigned lo=
ng (*calibrate_tsc)(void),
> =20
>  	if (properties & TSC_FREQUENCY_KNOWN)
>  		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
> +		return;
> +
>  	if (properties & TSC_RELIABLE)
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
> +		return;

Will this cause a spurious warning stack trace on every boot for CoCo
(SEV-SNP/TDX) guests under KVM?

For KVM CoCo guests, CoCo registers first via tsc_early_init(), setting both
TSC_FREQUENCY_KNOWN and X86_FEATURE_TSC_RELIABLE.

KVM then registers second via kvmclock_init(). At this point in the patch
series, KVM only passes TSC_FREQUENCY_KNOWN, so the properties & TSC_RELIAB=
LE
check is false, and it falls through to this WARN_ON. Since CoCo already set
the capability, the condition evaluates to true.

I see this is fixed later in the series by the commit "x86/kvmclock: Mark T=
SC
as reliable when it's constant and nonstop", which modifies KVM to pass
TSC_FREQ_KNOWN_AND_RELIABLE on modern hardware, preventing this warning.

Could the patch ordering be adjusted to prevent this intermediate regressio=
n?

> =20
>  	x86_platform.calibrate_tsc =3D calibrate_tsc;
>  	if (calibrate_cpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D32
