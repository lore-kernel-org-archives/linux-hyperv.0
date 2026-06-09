Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21F4C8FFC
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031016; cv=none; b=OgZhUG/lcB5/yD6EBLrEn4zgaPGXas9Ifpp4f4mLrI2rapzQJUMoqD+iRE6sPvY5OWv9cgbIeYEcTt4nBCepSFwvJMCloYQDXUY/VTz/pG3m4hbMJ0Oh6bEur1q/ZEzNZ86Ys4EzKQf9GIl9luWlc2mGz/A90McPl2GIEeHflSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031016; c=relaxed/simple;
	bh=A1gwCnzvSzH2K0FssACWnWov1hX+CM/jtTIyi9aHV3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uL2yz6quVQuDzlt+2z+PtUPLmvdGQ1a5cXyGAuBMYtnr+7bdcxu/HtO/upxKPcROey13VZsn4lvYOZnwgPQXBQdcSeUW/0c85uQYz8pm6L6UFKacaxwfB9JsQ49YVD3N6lfcDgMcab+C2yL/YKQV59RrJRHOFq+3KdCrzaaBStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Oe657l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Oe657l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EC41F00898;
	Tue,  9 Jun 2026 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031012;
	bh=wvk0Wa7PQ2OU6K3bgnhQJdOwWV2oVSeTaJQivA7md6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+Oe657lPnZjMPAXuicMcjZIqSE2Vf0CYz3RVCUa0rj5sLtOetPrHLgeQ0hYDzkj5
	 hnu6WglQMAp9U7miitZc2ELp8z8YihSZqj2k7PPcGgVoXHwnESoeRmEQTuyo15o74m
	 E7ehX02wzZmGEMK1N/cWGiKu2DU2sMELO7SMofscEgWG9M9tr3O3+WhH2ek9pQEvhB
	 K6QvkRtrIc83rfL8gxRSZp6/w/Y5U5akE1wutGq8xfMx/OyyFW4Xa+T8AXi52c0dUN
	 1/J9Rb+iOfaGUgNAS2XW0IGrkeQrM1jQUL80zklp2XB8VJSl9iLJ2LLA1FYO6zHFPR
	 DSHynHAtJF5JA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] arm64: hyperv: Route hypercalls through RSI
 host call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-6-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-6-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:50:12 +0000
Message-Id: <20260609185012.94EC41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] NMI/FIQ Reentrancy Data Corruption in Realm Hypercalls
- [High] Uninitialized Access / Missing NULL Check on Per-CPU Hostcall Poin=
ter
- [High] Hardware ABI Violation / Unsafe Memory Allocation for rsi_host_call
--

commit 17e33243e24b87deba9b6417fd0671d6c8f9140b
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Route hypercalls through RSI host call in CCA Realms

Modify the five hypercall wrapper functions to check is_realm_world()
and use the per-CPU rsi_host_call structure when inside a Realm.

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..1759998ef2667 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
[ ... ]
> @@ -25,12 +26,32 @@ u64 hv_do_hypercall(u64 control, void *input, void *o=
utput)
>  	struct arm_smccc_res	res;
>  	u64			input_address;
>  	u64			output_address;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 ret;
> =20
>  	input_address =3D input ? virt_to_phys(input) : 0;
>  	output_address =3D output ? virt_to_phys(output) : 0;
> =20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
> -			  input_address, output_address, &res);
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D *this_cpu_ptr(hyperv_pcpu_hostcall_struct);
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: High]
Could hostcall be NULL here?

If a hypercall is issued before the per-CPU structure is allocated for the
local CPU (such as during early boot, early AP bring-up, or broadcast TLB
flushes), won't passing this to memset() cause a NULL pointer dereference?

[Severity: High]
Since hypercall arguments are now passed using a shared per-CPU memory
structure instead of registers, is there a risk of reentrancy corruption?

local_irq_save() disables IRQs, but it does not mask NMIs or synchronous
exceptions. If an NMI or exception interrupts this code after the memset()
and issues another hypercall (like a crash IPI via hv_do_fast_hypercall8()),
won't the nested hypercall overwrite this shared hostcall buffer?

When the exception returns, the interrupted hypercall would then execute
using the corrupted arguments or read the wrong return status.

> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D control;
> +		hostcall->gprs[2] =3D input_address;
> +		hostcall->gprs[3] =3D output_address;
> +
> +		if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)

[Severity: High]
Is the 256-byte alignment required by the RMM guaranteed for this physical
address?

While the struct declaration might include an alignment attribute, dynamic
allocations don't always guarantee 256-byte physical alignment. For
instance, standard allocations only guarantee alignment up to
ARCH_KMALLOC_MINALIGN, and debugging features like CONFIG_SLUB_DEBUG can
shift object payloads, breaking natural power-of-two alignment.

Would passing an unaligned physical address here cause the RMM to reject
the call or inject a synchronous alignment fault into the Realm guest?

> +			ret =3D hostcall->gprs[0];
> +		else
> +			ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +		local_irq_restore(flags);
> +		return ret;
> +	}
> +
>  	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input_address,
>  			  output_address, &res);
>  	return res.a0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D5
