Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D504B049D;
	Fri,  7 Aug 2026 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061094; cv=none; b=pKngF0ppAVsw71PmzpIEYktOZsZvADz6TdX1CuNYDP60eO5gBiDhSnuOUsm2BPAv9YRFRu97nFHXqk9Ixpgq92CJsdl3TRu7FUHFTQtXv34XOy5yJyFbIHR8TPYL1XfnYMt2tEChQJhzl/b6adxwENZ7gXoZa7b2lfkmDAAvVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061094; c=relaxed/simple;
	bh=mmHD8T5M1dan+YmMPKR9gL5IrtP73LPdwaqxkwIDiRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdX/76SZeALJQ3Lec0mui1wxpuvcm+FO8dNScLWy28vEqv1c9SOQdw3tnUds3L/Jba7KLbWZ4g0RAget3eOJEwiu0NZvITSXovZHB9KxXuNu1toCE478N//hXh4npQ6sjnE8NJy7UPk4qjPNGicWiewF18xRE2imTeSy6ztX9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYavdR3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYavdR3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB171F00A3A;
	Fri,  7 Aug 2026 00:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061093;
	bh=lmjCXrLIFPFtW3D/d3XAGDi9zGOMWSkwdU7tYKKC03w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYavdR3AZjBMeNGL3uXryKSMcLJzgAYgS+x6QTBzYVvDf2O4NBZ4mI169dnKeGdtl
	 IhWFhMY6suWZl3A6PouLbGV84Vm6r66nuOTQRYXIISYgmW7cWUQavRyihTY+ahiS/K
	 74EfQqU5fNC8Vv5E2zW8ZGfmKaBHM75u4qE7MVNXLZ5m7CN6X3PHBTSFJl9+FWlbD9
	 AUFk++3Jz5EOtPeIIFID1vtZcPm9ZcmI4JP2jU5EonjVpcW8/F5aEHa3h5uPC36+3K
	 R6wqBxvs43RlGQMDfEpCSzFjz1yUPE8uS24YYCLsMj/eGqYSdPvCjavLp2kGFgmQ7O
	 z/p/O985OiMbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/51] x86/kvm: Get CPU base frequency from CPUID
 when it's available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260806233609.212337-25-seanjc@google.com>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-25-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 00:04:52 +0000
Message-Id: <20260807000453.0EB171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch's intent to decouple CPU base frequency from TSC frequ=
ency is silently defeated by core x86 timekeeping logic if the explicitly e=
numerated frequencies diverge by more than 10%.
--

--- Patch [24]: [PATCH v6 24/51] x86/kvm: Get CPU base frequency from CPUID=
 when it's available ---
commit 950176e6b76f307f2a6acf272049d92426a49766
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Get CPU base frequency from CPUID when it's available

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 255a24a99f288..83b9351f28100 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
[ ... ]
> @@ -1043,6 +1049,14 @@ static void __init kvm_init_platform(void)
>  		}
>  	}
> =20
> +	/*
> +	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
> +	 * frequency isn't necessarily the same as the TSC frequency.
> +	 */
> +	kvm_cpu_khz_cpuid =3D __cpu_khz_from_cpuid();
> +	if (kvm_cpu_khz_cpuid)
> +		x86_init.hyper.get_cpu_khz =3D kvm_get_cpu_khz;
> +
[Severity: Medium]
Will this actually decouple the CPU base frequency from the TSC frequency if
they diverge by more than 10%?

Looking at determine_cpu_tsc_frequencies() in arch/x86/kernel/tsc.c, it see=
ms
there is a legacy sanity check that overrides the explicitly enumerated CPU
frequency if it diverges too much from the TSC frequency:

arch/x86/kernel/tsc.c:determine_cpu_tsc_frequencies() {
...
    else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
        cpu_khz =3D tsc_khz;
...
}

During boot, KVM sets x86_init.hyper.get_cpu_khz to return the CPUID.0x16
frequency. The core x86 tsc_early_init() reads this and passes it to
determine_cpu_tsc_frequencies().

Doesn't this mean the core timekeeping logic will silently overwrite the
explicitly enumerated CPU frequency with the TSC frequency in these cases,
neutralizing the intent of this patch?

>  	/*
>  	 * If the TSC counts at a constant frequency across P/T states and in
>  	 * deep C-states, treat the TSC reliable, as guaranteed by KVM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806233609.2123=
37-1-seanjc@google.com?part=3D24
