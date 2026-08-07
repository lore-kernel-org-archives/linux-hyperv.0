Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D024B049E;
	Fri,  7 Aug 2026 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061293; cv=none; b=f+tziO1g1Pu2N9OIf4aBBy6IIdyKxqR7kXUzlrGllqFx9p5hJeYomQWyIe4pVDpXGaiYzpDMKTojX/QMfJu+0Ac4x2bVOTKOKayx/P0WakbL68bn+QWAcHEgJ5qU67i/Yg834fh/adxP+kRGW+TQw429thGnGAR+yg98daNT6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061293; c=relaxed/simple;
	bh=FWdJH+609JBqyQYy38/G+aJ0xVS8XCPo0VpdrJUvePk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UFMxhHT2uGYdl+5XCOX3jtM2vrMNqnPt6xX9YP968A6bDfQka2PhNVa9yxaQ04gRsunjKxt5zRh0agOFBjwqqWeXVf1+62XBBRsW3hJou8ZzrCmETe2qmw86vC2SzpAmaLNAgNqFfGsCkao+PmZCxUSKiKtXMXhH65igaeGh+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7gOY3i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7gOY3i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A6C1F000E9;
	Fri,  7 Aug 2026 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061291;
	bh=3LtXzaMrAvJxHCFQ0hSe3iPzxWuGqsIdcsrTqp8uFeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7gOY3i0HxSbSULqoGVYw+6W63ThoNyaCsrREBqXUexJ3yC3mtPEYotHgUl7uerDa
	 ohcj9r7MvhWBcaUlYTYxQTDv4l2zL2aEWAPG8gKyo9gADDpx7j3okY88dul65EPvSk
	 M9dSED7tGQ4kgO5xEm7KBhzwbUjRc4BAkyypMjN3FutU2XL0l0b/q5MZEUoJk22c8A
	 8Q9YaE7oZQE6hg+TVwGNOQsb3wX8/Lyb2AXaVzivPDN70lRNHA5PGynGZl6tvwCK9W
	 +4UmHFgD5wM1hSmwW/TbXSqBX0Uxn2A0FRgUiijjqBpyb6cOCfyrT/ObBTxRgS01g/
	 FzmKLAFa/NuTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 51/51] x86/kvm: Get local APIC bus frequency from PV
 CPUID Timing Info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260806233609.212337-52-seanjc@google.com>
References: <20260806233609.212337-1-seanjc@google.com>
 <20260806233609.212337-52-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 00:08:10 +0000
Message-Id: <20260807000811.19A6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation of the APIC timer frequency provided by an untr=
usted CPUID leaf allows a malicious hypervisor to cause a guest interrupt s=
torm or timer freeze.
--

--- Patch [51]: [PATCH v6 51/51] x86/kvm: Get local APIC bus frequency from=
 PV CPUID Timing Info ---
commit f6ea787ae688819e70ecd70def270210b8842a87
Author: Sean Christopherson <seanjc@google.com>

x86/kvm: Get local APIC bus frequency from PV CPUID Timing Info

When running as a KVM guest with PV timing info provided by the host, this
commit updates the code to use the local APIC bus frequency reported in
CPUID.0x40000010.EBX for the APIC timer period instead of calibrating it.

> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b954238b09fc0..edeff41c03c2a 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
[ ... ]
> @@ -1054,6 +1054,11 @@ static void __init kvm_init_platform(void)
>  			x86_init.hyper.get_tsc_khz =3D kvm_get_tsc_khz;
>  			x86_init.hyper.get_cpu_khz =3D kvm_get_tsc_khz;
>  		}
> +
> +		/* The leaf also includes the local APIC bus/timer frequency.*/
> +		apic_khz =3D cpuid_ebx(timing_info_leaf);
> +		if (apic_khz)
> +			apic_set_timer_frequency_khz(apic_khz, "KVM hypervisor");

[Severity: High]
Does this code allow an untrusted hypervisor to cause a guest interrupt sto=
rm
or timer freeze?

In a Confidential Computing (CoCo) environment, the hypervisor could provid=
e a
maliciously small value for apic_khz in CPUID leaf 0x40000010.EBX. When this
value is passed to apic_set_timer_frequency_khz(), it calculates and stores
lapic_timer_period.

Later, calibrate_APIC_clock() bypasses its normal safety checks when
lapic_timer_period is already set:

arch/x86/kernel/apic/apic.c:calibrate_APIC_clock() {
    ...
	if (!lapic_init_clockevent()) {
		apic_pr_verbose("lapic timer already calibrated %d\n", lapic_timer_period=
);
		/*
		 * Direct calibration methods must have an always running
		 * local APIC timer, no need for broadcast timer.
		 */
		lapic_clockevent.features &=3D ~CLOCK_EVT_FEAT_DUMMY;
		return 0;
	}
    ...
}

This early return skips the subsequent check:
if (lapic_timer_period < (1000000 / HZ))

Could a malicious hypervisor provide a small enough value that causes the
timer interval (TMICT) to become 1 or 0, stopping the local timer entirely
or causing an endless interrupt storm?

>  	}
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806233609.2123=
37-1-seanjc@google.com?part=3D51
