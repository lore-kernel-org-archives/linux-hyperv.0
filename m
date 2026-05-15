Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE2336888
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874337; cv=none; b=qHW1NsIrNcRGTazLXcZP7aEJZOuqZVYhykuvdGcHis9EupWfw2JYYWaebKWrmT7addAG2scE2OTtdOo9d52FGQACVX5RMLlSYAlXwPw0x6Mrior3PuMBzrqjwWtnaxB6RoUnqifPn+yEg10ybZmIr4GMxSlRkM8iXS1zCz5DNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874337; c=relaxed/simple;
	bh=lqkVOvyJgJ+p2q4qXIgoYIArflNHaFHg9R3AhpCiZiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YCj6iNHTXCVT6+QaMlB5CU/YY3Ei3lhyf/LGOBj1wDekWi7khUxL9g92CrzIBQ06OvSdCnub8rM+IdqyLEfV/w5g6JbcjXSlYvGhNauM767GfOpMpEcZkOzvjB8hONkBpQSrlJjJb2zw1Eq0Eaog+W3zvfiJEal03tbvsJnHBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njTjUc29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njTjUc29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B84C2BCB0;
	Fri, 15 May 2026 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874336;
	bh=lqkVOvyJgJ+p2q4qXIgoYIArflNHaFHg9R3AhpCiZiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=njTjUc29JWMHmoQqviunZSjJH8tT+CHSqnMlbIWhmBJS928nQs+dsYCDAAvZVrn54
	 CGLKzRLoTnudwCdFpB2m46j0+MW5EBvvqUZj9+v0GUCUwZwh7i6IH8cRgwQ4zZHyrH
	 m69SXFTsfD/olzBfxxwuGvu2LE6c/MvM/EE+DANd2aIIujHnjmiJ71R6rdVPq72cdt
	 rqyYzzeXR3Hwog0WWr0KmX73sTEkFvsW/yMqL3ssxXdOkGROty7kqkTYb2ioHgmOoj
	 OqxGYnIR8lMYbaAqf78Xey+qQboGojbifxc0XRLm5WRppKeP8DYipTRR6MUogBe+wn
	 KNIvDQmK6jiHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as
 params to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-32-seanjc@google.com>
References: <20260515191942.1892718-32-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:45:33 +0000
Message-Id: <20260515194535.56B84C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hyper-V VMs with an invariant TSC but no frequency MSRs lose the X=
86_FEATURE_TSC_RELIABLE capability.
--

commit 0c0fbc4f0451c30c0e87e0e3591ea4f487eff75c
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration

This commit adds a tsc_properties parameter to the paravirtual TSC
calibration registration routine to consolidate feature flag tracking.
It updates various hypervisor initialization paths to pass combined flags
instead of manually setting the CPU capabilities.

> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -516,8 +516,13 @@ static void __init ms_hyperv_init_platform(void)
> =20
>  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
> -		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz);
> -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> +		enum tsc_properties tsc_properties =3D TSC_FREQUENCY_KNOWN;
> +
> +		if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> +			tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
> +
> +		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz,
> +						  tsc_properties);
>  	}

[ ... ]

> @@ -629,7 +634,6 @@ static void __init ms_hyperv_init_platform(void)
>  		 * is called.
>  		 */
>  		wrmsrq(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
> -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}

If a Hyper-V VM exposes an invariant TSC but lacks the frequency MSRs,
does it bypass the tsc_register_calibration_routines() block entirely?

Without the standalone setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE) call
here, it looks like these VMs will lose the reliable flag.

Will this inadvertently enable the TSC watchdog, potentially causing a
performance regression if the system falsely marks the TSC as unstable due
to virtualization scheduling delays?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D31
