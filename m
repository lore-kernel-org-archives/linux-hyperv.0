Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA24472554
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665524; cv=none; b=HeQZ3/1X8uGBDBcqW2u+bHTkK0Hyg7dFCmXeexIq3W3F278uRAr/7kn9LoPZ6tu2z1dpPIDF4IWyUVPBHoxf1cFLFRAqsve+A5gVYKIHRg3KbT0kwNg2hHtHxaWuC+pq2lPx8hwztd5yKm6khahpv4wpcmwJm8NuddoYlsMvLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665524; c=relaxed/simple;
	bh=WQaqORI60j+f9BmqLpXO9AoWVxebfjPj81x0xNZDCLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eITC9qc02d8nW5IlFh+VS1ZBhP0+F6pcbmY0U1qTSIEzRy0Ml6tCsGNv0t8FZMCaTedGb3+ERKBIPG98mVOyklB/HkO0WCtnFvE98VAoMfuE48U5vtOwtEvaEN9ZXC+BtkRirtNxMteV4LGSwym8+P+WZEfVek5W+XG3IV3vAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpEytw+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpEytw+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A601F00A3A;
	Tue, 21 Jul 2026 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665522;
	bh=6yK2T40EKMneOvOSOkNtbquqj0/m6wjOn3PTBJtJ80s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpEytw+1p44sgQTY0JORux/nqXroOOkCOl2738jIGZC2M+2TwvFDkAbg0P0sfJFkq
	 v7/UWxNGVhKhn7AB3rijYBlmFdw8xtRqh75f7UhJl5tKK7p/b35qKuQy+jcW0/KVgC
	 5klyoXqphIntnpktUv9Nz8S1xdLrvvXY7Cw36oZZBajVr6UWrWs2PmiGDR9NoLFrIn
	 iVqtnfiPyeTCn9Q1TAp8ZHOAwZeSo/t3qjqKqNb7KuKEtIPHj3fOua1vhh+o4uCspw
	 whoKTlFSiTXo5uXbHSjRkNHR7bro3ja6Pr3wBJQod0cQ24z9euRtJgoPpkvsrgNyIY
	 55YYDcwPWJtZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721201148.1441143-4-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-4-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:25:22 +0000
Message-Id: <20260721202522.A1A601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kcalloc does not guarantee the 256-byte alignment required by =
the RSI host call structure, leading to RSI hypercall failures and boot cra=
shes.
- [Low] Unnecessary complex error handling and cleanup logic for an early b=
oot memory allocation failure.
--

--- Patch [3]: [PATCH v3 3/6] arm64: hyperv: Add per-CPU RSI host call infr=
astructure for CCA Realms ---
commit d6de874ec14c2f54fe70b4639d2b20bb51fd11c9
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms

This patch introduces a per-CPU array of rsi_host_call structures to
support Hyper-V hypercalls in Arm CCA Realm guests. The array is
allocated dynamically during hyperv_init() so that non-Realm guests pay
no memory overhead.

> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..d9010e64ddd7c 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
[ ... ]
> @@ -85,6 +90,20 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
> =20
> +	/*
> +	 * The RSI host-call buffers are only ever used when
> +	 * is_realm_world() is true. Skip the allocation on non-Realm
> +	 * guests. A single contiguous array of nr_cpu_ids entries is
> +	 * allocated; each CPU indexes into it by its processor ID.
> +	 */
> +	if (is_realm_world()) {
> +		hv_hostcall_array =3D kcalloc(nr_cpu_ids,
> +					    sizeof(struct rsi_host_call),
> +					    GFP_KERNEL);

[Severity: Critical]
Does using kcalloc() violate the __aligned(256) constraint on struct
rsi_host_call?

If slab debugging (e.g., redzoning) or KASAN is enabled, the allocator
offsets the returned pointer, breaking natural power-of-two alignment.

When the unaligned IPA is passed to the RMM via SMC, it gets rejected,
causing the guest to trigger a BUG_ON() inside hv_set_vpreg() during early
boot.

Would it be safer to use alloc_percpu() here to guarantee the required
alignment natively?

> +		if (!hv_hostcall_array)
> +			return -ENOMEM;

[Severity: Low]
This isn't a bug, but since hyperv_init() runs early in the boot process, is
it necessary to handle this memory allocation failure gracefully?

At this stage, physical memory should be available, and an allocation failu=
re
typically means the system cannot boot anyway. It seems the explicit error
handling and cleanup logic add unnecessary complexity.

> +	}
> +
>  	/* Setup the guest ID */
>  	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
[ ... ]
> @@ -106,13 +125,13 @@ static int __init hyperv_init(void)
> =20
>  	ret =3D hv_common_init();
>  	if (ret)
> -		return ret;
> +		goto free_hostcall_mem;
> =20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:on=
line",
>  				hv_common_cpu_init, hv_common_cpu_die);
>  	if (ret < 0) {
>  		hv_common_free();
> -		return ret;
> +		goto free_hostcall_mem;
>  	}
> =20
>  	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> @@ -125,6 +144,11 @@ static int __init hyperv_init(void)
> =20
>  	hyperv_initialized =3D true;
>  	return 0;
> +
> +free_hostcall_mem:
> +	kfree(hv_hostcall_array);
> +	hv_hostcall_array =3D NULL;
> +	return ret;

[Severity: Low]
This isn't a bug, but following up on the previous question, could we avoid
adding this entire cleanup block since this is early boot code?

>  }
> =20
>  early_initcall(hyperv_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201148.1441=
143-1-kameroncarr@linux.microsoft.com?part=3D3
