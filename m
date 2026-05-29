Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF71371877;
	Fri, 29 May 2026 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078335; cv=none; b=mUMF3YZq5L9Uxb1Hg9LPP2cIvVXVyrRmvGnQJAm/sAQKbm8mind4J8BLIOHyxc9+SlGN1RN9+QqgChziHMDfadyl8leC18Gg5+vZlpqznavhGyD8YfEJKSAAjfPWFNshsHuYqMon7oWT+rk9n/6MTuyJifpp0gWE1WYiYQXJg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078335; c=relaxed/simple;
	bh=QRFwGjaGfpEiJ1hcK64zGX54Y28kDK0mhA93vbyxTFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kMaE9CDBaQXuRr/kRMGNFZMMcAiyaYsLMnVIAVyIVP9w0rdPAFJZQn41VmYN2KTpCeDir477dHHRZvwGreeIopXvo33xg1AYCXn6Hik28T/HQByVtUJNH2aRMzOA8O9ydT9H9XewxNN2sVvefqL4RDXmjQ+jq+Eg/s1+VsZv6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URs206Ro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URs206Ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7D81F00898;
	Fri, 29 May 2026 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078327;
	bh=SQr3og31PMWCayYuIpduWCZ8NmICPUo0xc0Gt6mx6W8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=URs206Ros2+ZQzwBCx6JlEDrx9nYvoQH0GWiQ6/FTO1J853m7W59lldZXl7VPs/kU
	 XHUeZO1dmuXvrN7YB5csn7FUq3zTX/MsomZ8cJaJ5RbZG318XHOrhQ7ht+AAeSpIFP
	 R82QPcCv3jJcxov7Oi9A3LPb/kd7Q9lRuTuwg8aBQAXiuiyNoOk89dFVNF3COr+l/d
	 OFRDLIHgXEYYFdPbafb8DJ5xwU8Jhl4QgPrlC4gtQKsAAlGhRyfNpG4BmGgBf/T1Ap
	 Ks90P5Ke45YjAPqp4NfPTxZRiZPJwUwzSLAuVm3ghMQpdEfgcMVnsUoHBuIdIp9ZyK
	 ApgJjYwrWCgxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV
 CPUID Timing Info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260529144435.704127-19-seanjc@google.com>
References: <20260529144435.704127-19-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 18:12:06 +0000
Message-Id: <20260529181207.5E7D81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A 32-bit intermediate integer overflow occurs when calculating `la=
pic_timer_period`, which can lead to a severely misconfigured APIC timer an=
d an interrupt storm.
- [Low] Incorrect indentation using spaces instead of tabs.
--

commit 40284f144fdfd7a76b8fc8d36344d0fc35eb4b65
Author: Sean Christopherson <seanjc@google.com>
x86/kvm: Get local APIC bus frequency from PV CPUID Timing Info

This commit updates KVM guest initialization to configure the APIC timer
period using the local APIC bus frequency reported directly via the PV CPUID
timing info leaf, bypassing the need for calibration.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 4fe9c69bf40b3..c1139182121d5 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c

[ ... ]

> @@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
>  			x86_init.hyper.get_tsc_khz =3D kvm_get_tsc_khz;
>  			x86_init.hyper.get_cpu_khz =3D kvm_get_tsc_khz;
>  		}
> +
> +#ifdef CONFIG_X86_LOCAL_APIC
> +		/* The leaf also includes the local APIC bus/timer frequency.*/
> +		apic_khz =3D cpuid_ebx(timing_info_leaf);
> +		if (apic_khz)
> +	               lapic_timer_period =3D apic_khz * 1000 / HZ;

[Severity: High]
Could the intermediate multiplication of apic_khz * 1000 overflow here?

Since apic_khz is a u32, the multiplication is evaluated in 32-bit unsigned
arithmetic. If the hypervisor reports an APIC timer frequency greater than
~4.29 GHz (apic_khz > 4294967), this calculation will silently overflow.
The wrapped, drastically smaller value divided by HZ would yield a tiny
lapic_timer_period.

Would this configure the guest's local APIC timer to fire almost continuous=
ly
and cause an immediate interrupt storm? Modern processor clocks can exceed
4.3 GHz, and hypervisors sometimes match virtual APIC frequencies to the ho=
st
TSC frequency. An untrusted host could also intentionally provide a large
value to crash the guest.

[Severity: Low]
This isn't a bug, but the indentation for this assignment uses spaces
instead of tabs.

> +#endif
>  	}
> =20
>          /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529144435.7041=
27-1-seanjc@google.com?part=3D18
