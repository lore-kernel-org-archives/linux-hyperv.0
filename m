Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAE3B5F50;
	Wed,  1 Jul 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936202; cv=none; b=p8IUHbpRZDuzirVW/Zqx6LzkU7VUu2UePnskyKBXTtXQ8UZL479QhJtQTk4aNGmZDuCDKl1PsLFqu8oz+nNHUFtsKQSFTMySMmE5XE6Nv/zb1VN90/IFMstOx2kERWy6NY6Y2DeyDCZ83AKnp7AHQMC2SPja6uNoXCsc54K3n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936202; c=relaxed/simple;
	bh=x7tFlxF5of4YKLMPxqD+GQpsbFx+88eqbvNFwzinKLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPt59sVNRpHq0XFlC00dhuU0cujufJllmPHLTSnBPOvaqPfLzIF7G8SRB2GfHbpjWml2MWDU86+nECD9WaveohFpeDOXGYveHeWW7UQSMbgLLt3d6nwJ8xkFQhSELYwpLdpH5hrTEif6nz8brvf8t00VDfBNF+/qxl2IHYZxwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt1Fsom8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt1Fsom8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256EF1F000E9;
	Wed,  1 Jul 2026 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936201;
	bh=C2ck7X4AgRfpoad+mHUEN4qBEgaZCuv6Nl5e825SYmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bt1Fsom8j7+EKvrom42Bs4dWYsZKC8GOWoy3ColT8RxCGxpPcmO0hL26tH9Mvlmzo
	 QWRmh0y4X7UfTm8CU7hzpZ4C6WNAFWfsr4yEJmVHlW0uU6BAqbekeckgMY0tpbv2OB
	 7DfNkEf5iDSTSYCnh8vJG85u1dj3gEsO4eyxXVxlrPFsPVpuKZXvB+U91BtnGAuiwt
	 pb5wmy+teesKuz7CqaYDbLpTiZGX9n/SBfmNveJw3k9azRU/yZc0hWGbtbHLroo4HP
	 SNnsRpP63uNDUkn/JZ46960ufSURaFODY5w+OuZO+kB7csuu3wIbSVLfTBiU7ppwQZ
	 7Ggr2YK/jv5aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/51] x86/kvm: Mark TSC as reliable when it's
 constant and nonstop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260701193212.749551-23-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-23-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:03:20 +0000
Message-Id: <20260701200321.256EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally forcing X86_FEATURE_TSC_RELIABLE bypasses SMP cros=
s-CPU TSC synchronization checks, which will cause time to go backwards for=
 guests running on hosts with unsynchronized TSCs.
--

commit fb8fd2f8d18aabaf24f424391748d58e9427bdf7
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Mark TSC as reliable when it's constant and nonstop

This commit marks the TSC as reliable if KVM enumerates it as constant
and nonstop. This aims to prevent the TSC from occasionally being marked
unstable when the host is under moderate or heavy load.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 909d3e5e5bcd5..1cef54e1e7d9e 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
[ ... ]
> @@ -1040,7 +1041,16 @@ static void __init kvm_init_platform(void)
>  		}
>  	}
> =20
> -	kvmclock_init();
> +        /*
> +         * If the TSC counts at a constant frequency across P/T states a=
nd in
> +         * deep C-states, treat the TSC reliable, as guaranteed by KVM.
> +         */
> +	tsc_is_reliable =3D boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC);
> +	if (tsc_is_reliable)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);

[Severity: High]
Does setting X86_FEATURE_TSC_RELIABLE here bypass SMP cross-CPU TSC
synchronization checks?

Forcing X86_FEATURE_TSC_RELIABLE based only on CONSTANT_TSC and NONSTOP_TSC,
without verifying if the hypervisor actually guarantees cross-CPU
synchronization (e.g., via KVM_FEATURE_CLOCKSOURCE_STABLE_BIT), sets
tsc_clocksource_reliable =3D 1.

This bypasses the synchronization check in check_tsc_sync_source():

arch/x86/kernel/tsc_sync.c:check_tsc_sync_source() {
    ...
    if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable)
        return;
    ...
}

Could this cause time to go backwards for guests running on hosts with
unsynchronized TSCs when threads migrate between vCPUs?

> +
> +	kvmclock_init(tsc_is_reliable);
>  	x86_platform.apic_post_init =3D kvm_apic_init;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D22
