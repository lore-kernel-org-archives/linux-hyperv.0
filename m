Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB5473C93
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Oct 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932439; cv=none; b=gJWqwhjJjmi81GfrzR+6j3ZkPwy/7f2MZ7tMxJ7llqRTnk0WhG1vMJvIefW/+HzVT/18agpqr3pX7aHvlGGBc4rDjNlKMsHoQZFYww/ip6UUtkc4BgQfGBtGkmfySj0msNthqCC6Wb6i0kmaMzYQleSZEVcWfiFNaaM5AmLF1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932439; c=relaxed/simple;
	bh=XDY+2oG0klwwFro/m/FdhuqqFLLr9/5hxbXft/+mr3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JSB5LUeMoGOzRHeftzqOrkUwhp4cD1ObnbeAGSgr4z5GEi152MicjBaMsCGj/nvTowX1z3U4K1XDqQqNRgLt43R9Hz+NkCLJiKASkVv1UhQ9nxSASCWoAGeQMPMBd0MXoEXOhqyhE3QQxTb9fZHPEIEVweLRbpzCDOYHwXeFc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St4PdawW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St4PdawW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BAF1F00893;
	Fri,  2 Oct 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932438;
	bh=SRtQtCCsuCNa3gIenL493ISphrSHtnhbqUjMCMu2IHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=St4PdawWwDVZzTzpBt9G8UsfnYOCurtAupudCrCmhuzK8RLJ1yWfWMZFMfK0DorNs
	 2DiTb2oEaOI/0OOSPwL3p+8XEF1PAVNURhHI61wPvdUPVsAa8sKiRFmIhvJwVTfaCY
	 HB8kCwvWEe2efyvMMyHVSAx4Kqdfz40YID9yCSq7DOjs7f2WL4GJPnyjOy1yShnqAd
	 nXd5HQ/q/8c2tSZ0RO+qUOkgzT5eXza2tLo6ojxwd6b1yZcI+xPnsS0O/iopBb8+z9
	 lCmFPgwhbQJ13PS1aKtqTc9zlwXaNXAxbFisOa/TtZUAAsGVWAdrZ9R6Elua3LoaPl
	 OjoK+wXlqP4RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261001220552.1793471-6-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
 <20261001220552.1793471-6-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:57 +0000
Message-Id: <20261002091357.D2BAF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] arm64: hyperv: Missing NULL check on hv_hostcall_array causes NULL=
 dereference
- [High] arm64: hyperv: Shared per-CPU RSI hostcall buffer breaks NMI re-en=
trancy
- [High] arm64: hyperv: kcalloc allocation fails to guarantee 256-byte RSI =
alignment requirement
- [Medium] arm64: hyperv: Missing PROT_NS_SHARED bit on IPA passed to host =
in CCA Realms
--

commit f459f1780582f30fc15313756e77abd8a5994839
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Route hypercalls through RSI host call in CCA Realms

Modify the five hypercall wrapper functions to check is_realm_world()
and use the per-CPU rsi_host_call structure when inside a Realm.

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..0b5c89eb9df19 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c

[ ... ]

> @@ -12,11 +12,44 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/arm-rsi-cmds.h>
>  #include <linux/module.h>
> +#include <linux/smp.h>
>  #include <asm-generic/bug.h>
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
> =20
> +
> +/*
> + * hv_do_rsi_hypercall - Helper function to invoke a hypercall from a
> + * Realm world using the RSI interface.
> + */
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

[Severity: High]
Does local_irq_save() provide sufficient protection here?

Since it disables normal IRQs but does not mask NMIs (or ARM64 pseudo-NMIs),
could an NMI handler (such as a watchdog or kernel panic tracing) that makes
a hypercall overwrite the active hostcall buffer and corrupt the outer
hypercall's state?

> +	hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +	memset(hostcall, 0, sizeof(*hostcall));
> +	hostcall->gprs[0] =3D HV_FUNC_ID;
> +	hostcall->gprs[1] =3D control;
> +	hostcall->gprs[2] =3D input1;
> +	hostcall->gprs[3] =3D input2;
> +
> +	if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)

[Severity: High]
Could the physical address passed to rsi_host_call() be unaligned here?

The ARM CCA RSI ABI mandates that the SMC_RSI_HOST_CALL structure be
256-byte aligned. Since hv_hostcall_array is dynamically allocated via
kcalloc() (which guarantees only standard architecture minimum alignment
like 8 or 16 bytes), could this pass an unaligned block and cause the RMM
to reject the host call?

> +		ret =3D hostcall->gprs[0];
> +	else
> +		ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
>  /*
>   * hv_do_hypercall- Invoke the specified hypercall
>   */
> @@ -29,8 +62,11 @@ u64 hv_do_hypercall(u64 control, void *input, void *ou=
tput)
>  	input_address =3D input ? virt_to_phys(input) : 0;
>  	output_address =3D output ? virt_to_phys(output) : 0;
> =20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
> -			  input_address, output_address, &res);
> +	if (is_realm_world())
> +		return hv_do_rsi_hypercall(control, input_address, output_address);

[Severity: Medium]
Does this pass a Protected IPA to the host without setting the
PROT_NS_SHARED bit?

The virt_to_phys() macro extracts the base physical address but does not
include the shared memory bit. If the host relies on this address to access
the payload buffer, will it fail to access the guest's Protected memory
unless the Hyper-V host implicitly ORs the shared bit for all Realm
hypercalls?

[ ... ]

> @@ -76,24 +118,44 @@ EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
>  void hv_set_vpreg(u32 msr, u64 value)
>  {
>  	struct arm_smccc_res res;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 status;
> =20
> -	arm_smccc_1_1_hvc(HV_FUNC_ID,
> -		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> -			HV_HYPERCALL_REP_COMP_1,
> -		HV_PARTITION_ID_SELF,
> -		HV_VP_INDEX_SELF,
> -		msr,
> -		0,
> -		value,
> -		0,
> -		&res);
> +	if (is_realm_world()) {
> +		local_irq_save(flags);

[Severity: High]
As in hv_do_rsi_hypercall(), could an NMI interrupting this critical section
corrupt the shared per-CPU rsi_host_call buffer?

> +		hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: High]
Could this result in a NULL pointer dereference if hyperv_init() has not
been called or failed?

The hv_do_rsi_hypercall() function explicitly checks for !hv_hostcall_array,
but that protection appears to be missing here before calculating the offset
and calling memset().

> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_SET_VP_REGISTERS |
> +				    HV_HYPERCALL_FAST_BIT |
> +				    HV_HYPERCALL_REP_COMP_1;
> +		hostcall->gprs[2] =3D HV_PARTITION_ID_SELF;

[ ... ]

> @@ -108,29 +170,55 @@ void hv_get_vpreg_128(u32 msr, struct hv_get_vp_reg=
isters_output *result)
>  {
>  	struct arm_smccc_1_2_regs args;
>  	struct arm_smccc_1_2_regs res;
> +	struct rsi_host_call *hostcall;
> +	unsigned long flags;
> +	u64 status;
> =20
> -	args.a0 =3D HV_FUNC_ID;
> -	args.a1 =3D HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> -			HV_HYPERCALL_REP_COMP_1;
> -	args.a2 =3D HV_PARTITION_ID_SELF;
> -	args.a3 =3D HV_VP_INDEX_SELF;
> -	args.a4 =3D msr;
> +	if (is_realm_world()) {
> +		local_irq_save(flags);
> +		hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: High]
Similar to hv_set_vpreg() above, is a check for !hv_hostcall_array needed
here to prevent a potential NULL pointer dereference on initialization error
paths?

> =20
> -	/*
> -	 * Use the SMCCC 1.2 interface because the results are in registers
> -	 * beyond X0-X3.
> -	 */
> -	arm_smccc_1_2_hvc(&args, &res);
> +		hostcall->gprs[0] =3D HV_FUNC_ID;
> +		hostcall->gprs[1] =3D HVCALL_GET_VP_REGISTERS |
> +				    HV_HYPERCALL_FAST_BIT |
> +				    HV_HYPERCALL_REP_COMP_1;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001220552.1793=
471-1-kameroncarr@linux.microsoft.com?part=3D5
