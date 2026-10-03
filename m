Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF02383C8F
	for <linux-hyperv@vger.kernel.org>; Sat,  3 Oct 2026 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991246; cv=none; b=MPRT1Vm0S+IpeU2R9ldL6iL06exvaAS2V4Mhsxb/cs1n6RdaeeVlQXhuVLsc9vUo/O4A0thWjxiBYHjxAdWDrd/g6+1c9vFoyjrB6fRY3NZcPwnVGpeuoX1IDcCAMo/oeWMWZZZiJBK+FiPLeCkUsI8+EpvLI+xWUY9pu8jcZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991246; c=relaxed/simple;
	bh=W/xEA4Ldekk3KRE4715yi8lvwA3bHNthLAbKNF5EyV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJggirU6Hn1FieSUyv1XBQOKZe0feE+xGUfnd0N0Adi/CuKtusuLugOyzruW2EwzdvE1iX8w4nCv136ocnYGtJXDmsabUS7/uRgb6S0oI8mupVZ/GTrW72Smy+/gYMMmuAvHiHnCencQbOarGn0AB9REtklQX7rHb0h09GebeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muRXSkfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muRXSkfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F390F1F000FF;
	Sat,  3 Oct 2026 01:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991245;
	bh=88lPpI9Xij/EHb6/S57Q+I0eYfjO6h+Bug+kGuVH4rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muRXSkfM1w1nzsFaYOVIBxNU2ysRYbrVibwtWonLNNFCpWZcBXVcPkT+gyucFBPsR
	 xKLknCkVfW6TQHgo7OLhbSvZoEAR2o+wmdOwwNhLsQCfYcfr/2ibMxBjEeh9wbJRDR
	 /NaFfp6S4St2vwOwUSBmp3GJuCsC/XmsopOZY0Szat3fmMFwslsDb9VLbaoDuqGtkk
	 RzjEdQ9q2ZlYEKJ6gppw0JzqL5LMUh3k9fJ/z4rWpQKn0DkADWafJtLlE7P/AMmcr6
	 6T5KQzIvcbhQF7xjl/es3lHpXVLwUpvKEF4NBSBt/nnd06r9JRI8P+dK2VkdGLWbMx
	 zdb29gqVd8WLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] arm64: hyperv: Route hypercalls through RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261002215725.2015959-6-kameroncarr@linux.microsoft.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-6-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:04 +0000
Message-Id: <20261003013404.F390F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: hyperv: kcalloc fails to guarantee 256-byte alignment for r=
si_host_call
- [Medium] arm64: hyperv: missing NULL pointer guard on hv_hostcall_array c=
auses recursive panic
--

commit 2c893995afa956ce0fb20a1d090c6e04fba71575
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: hyperv: Route hypercalls through RSI host call in CCA Realms

This commit updates the Hyper-V hypercall wrappers to check if the kernel
is running in a CCA Realm. If so, it routes the hypercalls through the RSI
host call interface using the per-CPU hv_hostcall_array.

> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index e33a9e3c366a1..2f6fc1469c54f 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -12,11 +12,43 @@

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
> +	memset(hostcall, 0, sizeof(*hostcall));
> +	hostcall->gprs[0] =3D HV_FUNC_ID;
> +	hostcall->gprs[1] =3D control;
> +	hostcall->gprs[2] =3D input1;
> +	hostcall->gprs[3] =3D input2;
> +
> +	if (rsi_host_call(virt_to_phys(hostcall)) =3D=3D RSI_SUCCESS)

[Severity: High]
Does this physical address satisfy the RMM's 256-byte alignment requirement?

If hv_hostcall_array was allocated with kcalloc() (e.g., in hyperv_init()),
the allocation might not guarantee strict 256-byte alignment when SLUB
debugging or KASAN is enabled due to redzone shifts. If the resulting
address is misaligned, could the RMM reject the SMC host call and return an
error that eventually triggers a BUG_ON() and kernel panic?

[ ... ]

> @@ -76,24 +117,44 @@ EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
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
> +		hostcall =3D &hv_hostcall_array[smp_processor_id()];
> +		memset(hostcall, 0, sizeof(*hostcall));

[Severity: Medium]
Is it safe to access hv_hostcall_array here without a NULL check?

In hv_do_rsi_hypercall() above, there is a check for !hv_hostcall_array. If
Hyper-V initialization fails and sets hv_hostcall_array to NULL, but the
panic notifier remains registered, a later kernel panic could invoke
hyperv_report_panic() which calls hv_set_vpreg(). Without a guard,
this memset() could cause a recursive fault and break the crash handler.

[ ... ]

> @@ -108,29 +169,55 @@ void hv_get_vpreg_128(u32 msr, struct hv_get_vp_reg=
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

[Severity: Medium]
Could this also cause a NULL pointer dereference if hv_hostcall_array
was freed and set to NULL during an early boot failure?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002215725.2015=
959-1-kameroncarr@linux.microsoft.com?part=3D5
