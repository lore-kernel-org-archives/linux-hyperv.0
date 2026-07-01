Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95F431E7B;
	Wed,  1 Jul 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935456; cv=none; b=qoC/f1365qfU9jaqjumHDoWjmJQTzPenTd0X05eBucpF6fyyI/IDrnDtFmBmNHrCSGtyjfn+8GV26iY6k91VbfUjKtRbbxLzmR1GSEA8HbPbpuYT5NjiCHuL8INiTMaJjBLQ5Y1RW8yiAh2PhwuzSr6Hm3VlT2ZdZTmc2tv5inU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935456; c=relaxed/simple;
	bh=eYhtb0XvQpUtbcf+rnITUGR35rrPRLvD8ReVC509tCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWHsGp0Dm2p6D2vWl5WHi7nkO7fr8bgeJK9hf+lE4gc7CXVOMjyOZmYfGzBsHYRNfY7NM3w74wJXKqMV/BaYiRHJdmV5WxsfnSjKMG3wk5uYlbPBnvBDcFbSL2djnGnA5beWkAVB0ZRh1mhOKQGBmfmnJz4Nm25rAIK5GmRrkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5RGdOUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5RGdOUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364E1F00A3A;
	Wed,  1 Jul 2026 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935455;
	bh=z9VpTnB5zyF3sgGJjhDR32sq8ZvFq7NBFrWPyRwEOCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5RGdOUstLXJNXlVFBLbg/jk7UX+xqbhAcNek75N1nX8SCY5V0DqzSDbDB2KU5kQT
	 UvY7nxW90uluEELz/p1rdaKUzC/E9LK5Oc4Yp6xjoPgjs6QeHTmmAIyfZbGZ/FDLcW
	 dvc3dXlK77LWQnYongGF1vxc4SalZyMp7npfe2MCIuCSnGOGv7Xj2PCRuAlRQYlDxu
	 Ph6/QeLFZJsNMp2JiZxZVugsWMJd1DE37MfgnuPUv2uNstt2z2xYdDuCqWpG3JydlC
	 mfdXTOIxMGBufObFn0SKNefWIxCR3EDpbjjO8rmN22aIcDHlLYrf+P7vaFm2+9MxBL
	 3xuNrtrq5GGLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/51] x86/tsc: Fold native_calibrate_cpu() into
 recalibrate_cpu_khz()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-18-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-18-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:50:54 +0000
Message-Id: <20260701195055.6364E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The refactoring in `recalibrate_cpu_khz()` introduces a race con=
dition where the global variable `cpu_khz` is temporarily set to 0 for up t=
o 150ms during runtime CPU frequency recalibration. This exposes the system=
 to invalid state reads.
--

commit 34cf1b98d726e6c329bdefbd5c9712901d8b4bc8
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: Fold native_calibrate_cpu() into recalibrate_cpu_khz()

This commit folds the implementation of native_calibrate_cpu() directly into
recalibrate_cpu_khz() to remove an extra CONFIG_SMP=3Dn ifdef block. This c=
hange
aims to clarify the intentional use of early versus late calibration routin=
es.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 9764ac758081f..6ed6f8f012ebf 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
[ ... ]
> @@ -944,7 +929,9 @@ void recalibrate_cpu_khz(void)
>  	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
>  		return;
> =20
> -	cpu_khz =3D native_calibrate_cpu();
> +	cpu_khz =3D native_calibrate_cpu_early();
> +	if (!cpu_khz)
> +		cpu_khz =3D native_calibrate_cpu_late();

[Severity: Medium]
Does this expose a race condition by temporarily assigning 0 to the global
cpu_khz variable?

On a UP kernel during cpufreq transitions, if early calibration fails, the
global cpu_khz is directly assigned 0. It remains 0 while
native_calibrate_cpu_late() executes, which can take ~150ms and enables
interrupts.

Could this lead to sysfs readers via arch_freq_get_on_cpu() observing a 0
frequency, or the NMI watchdog being misconfigured with a 0 sample period if
toggled during this window?=20

The previous implementation used a local variable inside native_calibrate_c=
pu()
to hold the intermediate state, preventing concurrent readers from seeing an
invalid 0 value before the slow fallback calibration completes.

>  	tsc_khz =3D native_calibrate_tsc();
>  	if (tsc_khz =3D=3D 0)
>  		tsc_khz =3D cpu_khz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D17
