Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60B3EBF35;
	Fri, 29 May 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072820; cv=none; b=AN+x/A5OKkml1dicFdDpYjOR8hN5HoXnczHFTwUDVKkY3rOgy0688U8bO5a06ZEzfKv3IYs38Fz8Qi840nmOYYKUtndyle6AxcXo0VLlkeSOSX2HkeprFWNk3FJaDl9um6XZ9UK7wtsmYeYpCbboAkrfmijtxPCevc3t55wDmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072820; c=relaxed/simple;
	bh=RLCMblZAmO9z8lqczvJS97ibYbLBIdR04Q/p2oNSLf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5o22ulQYFMoOE6SxAs+/LWUtoxOfA9iSRB4OaG3DDHJwgj+zrRUDnESLudLatceyz/L9xCtCnFmPReGurk1Ysg2rHS1So/ohhptQcpku6X43jPJgAeQcZ81HhiGngIbXP88038qP6pUdBejefJ5x0wcqfkqnxMJ7UYxVA8L8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGkKy2zW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGkKy2zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519101F00899;
	Fri, 29 May 2026 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072819;
	bh=P+/SyUCoUE5/t/HWSx8+Y8GgHzZUz0dCGkswepvYttI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGkKy2zWjzfTC8a5uRbZ1yVlD15PB2mkm6EwMj65ERCPoZsqZF1iJwq6HW6um+9wb
	 I8InSk+H++UAzQCA71Pg3cuN4HBpu6uHZsEjtBHHL2D4zeN/ZAWHiwsPJ8Nr1YvTq/
	 A+MQT5kFXPYTzd5iGPI7F2fFLfqEda6dT8mQ7meCJ8lOJKtvJPLAxNCeB+o5FIgeUr
	 GEnTNmmuBK+WwDqVckpyFnYUEQuQ2zd/SLxxs5F/EVaatc/NckaL8OUnXc+bRNDLG1
	 BkJRy6EDfIYJuugBCa4e+DkOWMfFHb5pbv297gcoeDzod1HIWBXFM9q+ZfnjLuh7gi
	 2+jv+SOvqViRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when
 using ACRN for calibration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260529144435.704127-10-seanjc@google.com>
References: <20260529144435.704127-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:40:18 +0000
Message-Id: <20260529164019.519101F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditionally setting X86_FEATURE_TSC_KNOWN_FREQ skips TSC ref=
inement even if the hypervisor fails to provide a valid TSC frequency.
--

commit 44594dfd95dd7a3adcfc1b7f3c8d37e15ed4e143
Author: Sean Christopherson <seanjc@google.com>

x86/acrn: Mark TSC frequency as known when using ACRN for calibration

This commit marks the TSC frequency as known when using ACRN's PV CPUID
information, assuming the hypervisor explicitly provides it.

> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> index ad8f2da8003b3..0303fe6a2efa7 100644
> --- a/arch/x86/kernel/cpu/acrn.c
> +++ b/arch/x86/kernel/cpu/acrn.c
> @@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
>  {
>  	/* Install system interrupt handler for ACRN hypervisor callback */
>  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> +
> +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

[Severity: Medium]
Does this unconditionally skip TSC refinement even if the hypervisor fails
to provide a valid TSC frequency?

ACRN TSC frequency is obtained via acrn_get_tsc_khz(), which queries
cpuid_eax(ACRN_CPUID_TIMING_INFO). If the hypervisor does not support this
leaf or returns 0, the kernel falls back to early hardware calibration
(e.g., PIT/HPET via x86_platform.calibrate_tsc()).

Because X86_FEATURE_TSC_KNOWN_FREQ is unconditionally forced here,
init_tsc_clocksource() will assume the frequency is known and skip the
refined calibration phase. This regression locks in the imprecise early
calibration and could cause time drift.

I see this regression was addressed in a later commit b0e7d8e1edd52
("x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code")
which correctly gates the capability setting on known_tsc_khz !=3D 0.

>  }
> =20
>  static bool acrn_x2apic_available(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D9
