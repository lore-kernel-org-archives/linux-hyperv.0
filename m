Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C214B0488;
	Thu,  6 Aug 2026 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060537; cv=none; b=YS5VSi/RRuUFmicP3QU52JAlqA8O43xZG6H8ZGDJXMhZrGMytiCETflKM8E1sRG9FMnGtnje8Jc2Ub71FVGqggHat7x4iMrptnkDjvqgTe6A9dpZDgtzFRUf1NZ7CSRVq6akNP8OuEFZ2lhMqzfctT0sAaUEidnT8omEYS2iWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060537; c=relaxed/simple;
	bh=7WLNfMz1Gbl5Jpq79HpX8W1c0VhYvOB50LOMpiCq66s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nuje3OgqaDCHXWwuwJyXbuLAZPUiW+8Qym39+N6OVtVbJC+ieHxN36KUJc1xnoUsETr/hMKGnancGOzw/GfaJ0rrgXzkPaIIeu8P9963ZNmlGCZJYYtB+ZnXKasxR+BOVPmzjoQFNq9d/NtrQ5kpKhgDzPlHFXgYcNxHGoeyg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwLfB4BS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwLfB4BS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F41A1F000E9;
	Thu,  6 Aug 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786060536;
	bh=EZywgeu2KMUchYx837WzIhIye1RN8pPl2DG+DJbnzUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwLfB4BScSZt3YN4TpdAcmJ7Ot1NmY8rwoy+zKVkM/myjmeMCxgMhc8eJMkjlTSwE
	 T7xRg0Ah465GFTGRR0Na5Ww1NosgLfkkJe8g0ETlySny/y1yYW/htUUo/ix7+KhOY5
	 HW6yxWVxXstniz6RDe78dHzvem6priAtd01Yie/6WLInU0DIaNgG1tpgcwc4S4DO9r
	 uf38XUjIrAVVgUV3dS3enNUQY8c6AiqpZw8dbfIUnUzZ161ZJIja/lRpMB4DyAIEiX
	 nhwJwuZGwbyhFhRV+0iPOOFbT0x2bhtqElblFVo96PGr9PZ2U2/53FlGp3UCTSEJKY
	 G8RRJqCyC/IXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/51] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260806233609.212337-7-seanjc@google.com>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 23:55:35 +0000
Message-Id: <20260806235536.2F41A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch attempts to decouple CPU frequency from Secure TSC fre=
quency for SNP guests, but a downstream core x86 check defeats this logic i=
f the frequencies differ by more than 10%.
--

--- Patch [6]: [PATCH v6 06/51] x86/sev: Don't override CPU frequency calib=
ration for SNP's Secure TSC ---
commit fde9a60ee57bc9ae26f0e19e9b9a2405fdf1fe11
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC

This commit removes the override of the kernel's CPU frequency calibration
routine for SNP guests with Secure TSC. It aims to allow the CPU frequency
to be calibrated independently of the TSC frequency.

> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index ed0ac52a765e0..665de1aea0ee9 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
> =20
>  	snp_tsc_freq_khz =3D SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->t=
sc_factor);
> =20
> -	x86_platform.calibrate_cpu =3D securetsc_get_tsc_khz;

[Severity: Medium]
Does this actually decouple the frequencies if they differ significantly?

If the independent CPU calibration determines a frequency that differs from=
=20
the Secure TSC frequency by more than 10%, the core x86 code will still=20
overwrite it.

Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c:

        if (cpu_khz =3D=3D 0)
                cpu_khz =3D tsc_khz;
        else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
                cpu_khz =3D tsc_khz;

Will this downstream sanity check silently clamp cpu_khz back to tsc_khz=20
anyway, defeating the patch's attempt to keep them separate when APERF/MPER=
F=20
values diverge?

>  	x86_platform.calibrate_tsc =3D securetsc_get_tsc_khz;
> =20
>  	early_memunmap(mem, PAGE_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806233609.2123=
37-1-seanjc@google.com?part=3D6
