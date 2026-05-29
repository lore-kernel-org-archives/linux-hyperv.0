Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7335C197;
	Fri, 29 May 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069487; cv=none; b=M8qZ0QawEX/h9Ahxs0FnZIdDnG8sXTV8P6pXWaGTzlhFS71M9krBU4r7AmzLSmqMggCHf6XBk5aDPAYkYgexawrfJVR0Tgywt3Hl0uW+4hHA+E2KbjD0dia99W1vkhsjJJPi4RH/YnYghs0qB/ztPQEw/rI0OUoXGD6vUTOJHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069487; c=relaxed/simple;
	bh=mvCMBoAcEOriwrY+Fq3bhYdf5LmF3q0G90gqgfjvaU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mWgE3dDNDhozblUk1bRRbYIQB2bRIXuBWhuZ42aQWq8fE1D6lEFUzMq92yLDnu4thvRsbBoMhHiHN+9mPQgB8Rk7/QYtFjkEOvSaG6YJYb05Zvsmsm+/oyCqaXSKGGammbAXf/Ra4vkWsOwkDffCRBn53wjkF8HXtV4d30+VcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFhr/I56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFhr/I56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255551F00893;
	Fri, 29 May 2026 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069486;
	bh=Q6hCl32IGgQrFnFWIaD6HnQKOxmpfRmWxCKxyryTLFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFhr/I56R3cteTSFIVMDJ/tlnS6mKfOckiM0kS78Jz003574cw/0/XLKat4kjrpQB
	 C3KmUu90TqjNs8xAb/FSkVQ1+KhRTZc7dPgv1ZsXa983TCOZvHgt+fbhrJfkaFgbK6
	 TYMcO0yA0uGBiy7x7HQY/czdWv9Co1ryjrQCH8jO8J8oHMoNhv0ablIhhrFzxdAhOe
	 iHwx5fXDLYRpMsGH62kldyfFn1MbNps1YGQVmeiH9sZBAIHGzOsru5fbSkvFi9luwb
	 19tpziQVL3ZpPUqzLj6b/J74MtWRYIy1atPbliE1+AfT5ApfizEND7l5M6hh4qGFA6
	 IIx6/lyKbdZsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/47] x86/sev: Don't override CPU frequency
 calibration for SNP's Secure TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-5-seanjc@google.com>
References: <20260529144435.704127-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 15:44:45 +0000
Message-Id: <20260529154446.255551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `calibrate_cpu` override for SEV-SNP Secure TSC guest=
s incorrectly assumes that `cpu_khz` and `tsc_khz` should be decoupled for =
APERF/MPERF calculations. On AMD architectures, the MPERF register architec=
turally increments at the P0 frequency, which matches the invariant TSC fre=
quency. The kernel calculates effective frequency using `(cpu_khz * APERF) =
/ MPERF`, so `cpu_khz` must exactly equal the MPERF tick rate (`tsc_khz`) f=
or correct results. Furthermore, because `cpu_khz_from_cpuid()` is disabled=
 for non-Intel CPUs, removing this override forces SEV-SNP guests to fall b=
ack to untrusted PV clocks or legacy PIT calibration. PIT calibration invol=
ves thousands of I/O port reads, causing `#VC` VMGEXITs that significantly =
increase boot latency, and forces the guest to trust the hypervisor's timer=
 emulation, violating the security model of Secure TSC.
--

commit d8a832435bc58075d8e63ea3016b822abba9433c
Author: Sean Christopherson <seanjc@google.com>

x86/sev: Don't override CPU frequency calibration for SNP's Secure TSC

This commit removes the override of the CPU frequency calibration routine
for SEV-SNP guests using Secure TSC. It asserts that CPU frequency should
not be strictly tied to the TSC frequency when features like APERF/MPERF
are exposed to the guest.

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

[Severity: High]
Does removing this override lead to incorrect APERF/MPERF effective frequen=
cy
calculations and boot latency regressions?

On AMD architectures, the MPERF register architecturally increments at the =
P0
frequency, which matches the invariant TSC frequency. Because the kernel
calculates effective frequency using (cpu_khz * APERF) / MPERF, cpu_khz
must exactly equal the MPERF tick rate (the TSC frequency) for correct resu=
lts.

Furthermore, because cpu_khz_from_cpuid() is disabled for non-Intel CPUs,
does removing this override force SEV-SNP guests to fall back to untrusted =
PV
clocks or legacy PIT calibration?

Legacy PIT calibration involves thousands of I/O port reads, which cause #VC
VMGEXITs. This significantly increases boot latency and forces the guest to
trust the hypervisor's timer emulation, which appears to violate the securi=
ty
model of Secure TSC.

>  	x86_platform.calibrate_tsc =3D securetsc_get_tsc_khz;
> =20
>  	early_memunmap(mem, PAGE_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D4
