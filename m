Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601B46F49E
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665677; cv=none; b=qeHC9ONpfir7Vcyu64XpKdqAD5ksU3z6RUKGdmm36HZix3CqhPLrQrBtNVacFvb39Er/6G1eEcrJjLiM1d6xlzwiA7CCePB6hiWxErIQto2oWJl+FT+5WLbbAj0RLkX/iiWTAdXy6QkSWA5wDvOeWBEW3yXCh8smEdmhVYgYCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665677; c=relaxed/simple;
	bh=MFKMGNQJhrFP8QWAF/TTK4bj5iM3gd1Jz+eCn57ht4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rwBdU4ne4BWNs11JyZqxzOl/hZsd0Zf3vkIiDVdSv4yuQEFlpc93FhU3LHFlhwPGqoaXiW/KJDldbKcJS5zfo3VJjomwkrQyPMOL8SsoTUP507W7byhBNUmcZgZQfZXCP/PVHsd4AoZShnh8UHTige/70s9WdT5Dz+DSa/Nih9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSzpdEF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSzpdEF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B21F00A3D;
	Tue, 21 Jul 2026 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665673;
	bh=mVc0tES490016s3ylbEeMRKurw+G8ihUY//67PDBD/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSzpdEF3hahuGKPI2XZ0TwbpRoYRhuEhMTgypyLSH0oBzbBzwPQJFTAX5RCv5eTIF
	 UE4bN2SSX8aIpSbvh70BZr4ctHQlCAJS580rat/TtzEETi9jj8VN3GjvDxyA7YojZa
	 aUGXgvvNf9/nDXXW+uwAvp16unoffMTM4WNUSB7ZZJXJjE53TMUl/3jRvfjLVZuHQo
	 dtTzsanGBDolLpgERLINiW/NmWe3R81MOjCIS6CL/uf0iV2Yd+OHWVYt7rQqlIBHZx
	 KQ7YNPMhdqAUbxT4061E2hY1nMiZp+YZ7XgTyDvmFaYJ7uaxcC8wwWW4BOG4YBUcsV
	 25xDtPXFzsYsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721201148.1441143-6-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-6-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:27:53 +0000
Message-Id: <20260721202753.853B21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The globally allocated `hv_hostcall_array` is used for RSI host ca=
lls, but it is not guaranteed to be 256-byte aligned, which is strictly req=
uired by the RMM.
- [High] Using a single shared per-CPU buffer for hypercalls without maskin=
g NMIs/FIQs destroys re-entrancy, risking data corruption.
- [High] Hypercalls passing memory buffers will fail because the guest pass=
es Protected IPAs to the host instead of Shared IPAs.
--

--- Patch [5]: [PATCH v3 5/6] arm64: hyperv: Route hypercalls through RSI h=
ost call in CCA Realms ---
commit a89ea311002c08edfbe0b6f9d1e3ca3c6d94b198
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Route hypercalls through RSI host call in CCA Realms

This patch modifies the hypercall wrapper functions to check for
is_realm_world(). When running inside a Realm, it routes the hypercalls
through the RSI interface using a per-CPU rsi_host_call structure.

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..77cba08fca132 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c

[ ... ]

> +static u64 hv_do_rsi_hypercall(u64 control, u64 input1, u64 input2)
> +{
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	if (!hv_hostcall_array)
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	local_irq_save(flags);
> +	hostcall =3D &hv_hostcall_array[smp_processor_id()];

[Severity: High]
Since local_irq_save() doesn't mask FIQs or pseudo-NMIs on ARM64, is this=20
shared per-CPU buffer safe from re-entrancy?

If a pseudo-NMI like a perf interrupt or hardware watchdog interrupts an=20
ongoing hypercall and issues a hypercall itself (e.g., hyperv_report_panic=
=20
calling hv_set_vpreg), wouldn't it overwrite this same hostcall buffer and=
=20
corrupt the state?

> +	memset(hostcall, 0, sizeof(*hostcall));
> +	hostcall->gprs[0] =3D HV_FUNC_ID;
> +	hostcall->gprs[1] =3D control;
> +	hostcall->gprs[2] =3D input1;
> +	hostcall->gprs[3] =3D input2;
> +
> +	if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)

[Severity: High]
Does the allocation of hv_hostcall_array guarantee the 256-byte alignment=20
required by the RMM ABI?

If it is allocated using kcalloc() during init, that only guarantees=20
alignment up to ARCH_KMALLOC_MINALIGN. When slab debugging like SLUB_DEBUG=
=20
redzoning is enabled, the objects can be shifted by redzone padding,=20
completely breaking the 256-byte alignment and causing the RMM to reject th=
e=20
call.

> +		ret =3D hostcall->gprs[0];
> +	else
> +		ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}

[ ... ]

> @@ -29,8 +61,11 @@ u64 hv_do_hypercall(u64 control, void *input, void *ou=
tput)
>  	input_address =3D input ? virt_to_phys(input) : 0;
>  	output_address =3D output ? virt_to_phys(output) : 0;
> =20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
> -			  input_address, output_address, &res);
> +	if (is_realm_world())
> +		return hv_do_rsi_hypercall(control, input_address, output_address);

[Severity: High]
Will the Hyper-V host be able to access these input and output buffers?

In a CCA Realm, the physical address space is divided by the prot_ns_shared=
=20
bit, and virt_to_phys() returns a Protected IPA without this bit set.

If the host requires access to these buffers, does this need to pass a=20
Shared IPA instead of the base Protected IPA?

> +
> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input_address,
> +			  output_address, &res);
>  	return res.a0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201148.1441=
143-1-kameroncarr@linux.microsoft.com?part=3D5
