Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827F4B0493;
	Thu,  6 Aug 2026 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060559; cv=none; b=f8LdZFbiY3YZSCB5vXHAYbEE2+zJYJv1k0ReoXphiL2aea+Z3De7bTQaJHsKCfqX6JGqVUhGlijwKGowcePEOtgXpmOxI+3ldPIoqcOy6ibwOPYZX4n9GD2Hx9DfejCerAoyFOBP+ZNt7+L3ockvgvvYE9Bmu9Lj+z+bttuOcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060559; c=relaxed/simple;
	bh=dQntU5FXmYNZtQ2RoCkp2Pvvfi7OjYSUDt7UNpumY/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oz+oJ3bjI3BiuSSw806/nh9r59eOGZX6mb7HPEoJWabXnYJfTq5bHERPkFkM3lZzw31cDlS/AMuhsmXbrBlhcaoQrU2tZMZG1vqTPhvqJSrEYIuiry2NsGdaxjrE3x5l/FzgumuhKUb9C0/obb/5H9E8fB171g5lXk04JNWU02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYAGwcIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYAGwcIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E261F000E9;
	Thu,  6 Aug 2026 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786060557;
	bh=CgXACmNMqlE7Jl6umTP3DS7LsdhQkHH86lmVzPY7vrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYAGwcImWosx64uhl4G8/wJNzlYmc7jzF85QYX7RPck/a/I9Tum3FfPY6Y2m1qrDO
	 j5f0Mh0/BiHm7SMadxJyrLrvnGtZqFcz3sdLmzJwPy3gdrJToTTgWMbjMygEKgHU9u
	 +BiOmsAWBTBQx5fZOHhELOGoOJaxfNlrBuei/feSo5kuriYHTgQGG1Zc142VJiOPaP
	 bVlb3pFqSGfHjKcsslrYBUkdmIU0Yw+jTkWBHj2sHeGDkUxPrC9WtgQoJDBEEsNnem
	 zDUU63TA6sl5CdDPlVEeFQaPuY5GWaYODo0sMkwN54eBAEl6Dm+u59NNN7szWMuomx
	 JPIXGDzjjpQww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/51] x86/tsc: Ensure that TSC recalibration doesn't
 run if TSC frequency is known
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260806233609.212337-4-seanjc@google.com>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 23:55:56 +0000
Message-Id: <20260806235557.75E261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Valid virtual machine configurations with legacy CPU models will=
 trigger a spurious WARN_ON_ONCE (and potential kernel panic) due to hyperv=
isor paravirt clocks.
--

--- Patch [3]: [PATCH v6 03/51] x86/tsc: Ensure that TSC recalibration does=
n't run if TSC frequency is known ---
commit dd99d8caeb7628be679eca32563aa6618e548028
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Ensure that TSC recalibration doesn't run if TSC frequency is known

This commit adds a warning and bails from recalibrate_cpu_khz() if
X86_FEATURE_TSC_KNOWN_FREQ is set. This is intended to catch out-of-spec
hardware states on ancient CPUs where recalibration is attempted post-boot.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
[ ... ]
> @@ -930,6 +930,9 @@ void recalibrate_cpu_khz(void)
>  	if (!boot_cpu_has(X86_FEATURE_TSC))
>  		return;
> =20
> +	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
> +		return;
> +

[Severity: Medium]
Will this trigger spurious warnings on valid virtual machine configurations?

The commit message mentions that hitting this requires concocting an
impossible CPU model like combining a P4 signature with CPUID 0x15. However,
hypervisor paravirt clocks (like kvmclock, vmware, or mshyperv)
unconditionally call setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ) during
early boot, regardless of the emulated CPU generation.

If a VM is configured with a legacy CPU model (e.g. -cpu athlon) and runs
an SMP=3Dn kernel, the powernow-k7 cpufreq driver can successfully load and
explicitly call recalibrate_cpu_khz(). Since the paravirt clock already
forced the TSC_KNOWN_FREQ feature, cpu_feature_enabled() will evaluate to
true and trigger this WARN_ON_ONCE, which can escalate to a fatal kernel
panic on systems with panic_on_warn enabled.

Does this warning need to account for paravirtualized clocks setting this
feature flag on legacy CPU models?

>  	cpu_khz =3D x86_platform.calibrate_cpu();
>  	tsc_khz =3D x86_platform.calibrate_tsc();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806233609.2123=
37-1-seanjc@google.com?part=3D3
