Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626324;
	b=AXrzBlsTUyhb/AoJemOlc1WQ557GxBhPI05brf2TPhXxG9RJ1f9uQ7LOiLWazgctsTAc
	 WBHuEZRe3I0NDB5SpanNRt9al4bX1iitnyIgw3ZdlUOBWBpxGpm2WvwsA7vEQ6ABaGxOK
	 YCIxaEaeLEiCJvuZ048RHj3w0RuSMbz8dYq5MIZVO9XuZMMDXbOoHxEwXfD8qRwbomU8H
	 phry/akR13LRz5veRphKk8v1KokRohvv6owakN0glH7+oxPHsb0fUFoQ6x1xBfn2/KygU
	 FDeQllMwHJOvibCRoQTrnwsy7uVBeLNW2tLG6Rdb9RiuE61vF+OsqHRSvxuhtFzVmvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626324;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rlCKbUjY30uTRvIldpk1e7nHz1dXQjBHQ6XEE9/3ipk=;
	b=AFeyBiHpCPVAV9VzY8Ti3mz5c9HPxZE7EN0BN+iOBbz1b2OYBWLz9UvXgbaq5tq2ei3t
	 DWHwSu42yY6Qjpj2ZETrZ5HFLyVbTEbsuAJacAKfpAzAEfwO3h/X0Duz/HV19MlUFejvq
	 Th1d6mVP4+RIub1sDrwzocaaF/293v1ITlcD37+zdp7lzf83zCaaJIGlTRtRNouCf1Fot
	 UktLwkEYAq06dHBRjwANzctD//6GN3AC5msqe5vDUmaU29nZ7UCMEdBcC6wfVKLVuB3M1
	 XRBvY2GBZ8uE2s7lrTv6eLoljAO9JejYIVrc/Qo0ukzH0xzCUJmniRbOvHWN10DKXxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1L+7Zx5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E6606A323
	for <linux-hyperv@vger.kernel.org>; Sat, 14 Nov 2026 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1L+7Zx5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6581F000C4;
	Sat, 14 Nov 2026 03:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626323;
	bh=rlCKbUjY30uTRvIldpk1e7nHz1dXQjBHQ6XEE9/3ipk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I1L+7Zx5VcNOlFFADRIHYifJiEkEdDa3qCns5e+7S1QMwwegX8G6NNi7ynzA6R3st
	 mEngyJL8Ftws57jBT3BQQXZZcVOavCVo4BNonPf7T3tyOQG8JuaHPKuJ90wMxDOa6W
	 LwkkUxnJNi+5/l20Nqi03WWvT3I88xqH9heu1S9tlIGRJ8dmQ2pQwKRlm/6FXruFi8
	 SUDGsPtmUooOsrG1pLjdBueGDxFXg1D/3mdkofhVGBJN8P3HFtqBrYcr05MKvN9EHk
	 zJKiWYUqNeYw1C76XNojNK31vBWiGCFr3U8Yew2O7Inr5hgYP2MNLXKcOT8bUy0Ang
	 FIbFa6Kfi8BRg==
Message-ID: <sashiko-outbox-214095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat
 hypercall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261114025313.1257042-3-mrathor@linux.microsoft.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
 <20261114025313.1257042-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:18:43 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] Drivers: hv: unused HV_REP_COUNT_MAX macro and dead return in
  mshyperv.h
--

commit 9765fd900ad842b6359a24f592cd624ffdc92be5
Author: Mukesh R <mrathor@linux.microsoft.com>

Drivers: hv: Fix bugs and issues around repeat hypercall

This commit updates repeat hypercall handling to account for partial
completions on failure, splits repeat hypercall helpers between hardware
confidential VMs and regular VMs, and renames HV_STATUS_TIME_OUT to
HV_STATUS_TIMEOUT.

> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 396bcb3db0bcc..87c784b9daa69 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,9 @@
> =20
>  #define VTPM_BASE_ADDRESS 0xfed40000
> =20
> +#define HV_REP_COUNT_MAX	\
> +	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
> +
>  enum hv_partition_type {

[ ... ]

> @@ -135,45 +143,63 @@ static inline unsigned int hv_repcomp(u64 status)
>  	/* Bits [43:32] of status have 'Reps completed' data. */
>  	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
>  			 HV_HYPERCALL_REP_COMP_OFFSET;
>  }
> =20
> -/*
> - * Rep hypercalls. Callers of this functions are supposed to ensure that
> - * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
> - * definition.
> - */
> -static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
> -					 u16 varhead_size, u16 rep_start,
> -					 void *input, void *output)
> +static inline u64 hv_do_rep_hypercall_reg(u16 code, u16 rep_count,
> +					  u16 varhead_size, u16 rep_start,
> +					  void *input, void *output)
>  {
>  	u64 control =3D code;
> -	u64 status;
> -	u16 rep_comp;
> =20
>  	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>  	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
>  	control |=3D (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
> =20
> -	do {
> +	return hv_do_hypercall(control, input, output);
> +}
> +
> +static inline u64 hv_do_rep_hypercall_cvm(u16 code, u16 rep_count,
> +					  u16 varhead_size, u16 rep_start,
> +					  void *input, void *output)
> +{
> +	u64 status, control =3D code;
> +	u16 rep_comp =3D 0;
> +
> +	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
> +	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> +	control |=3D (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
> +
> +	for (;;) {
>  		status =3D hv_do_hypercall(control, input, output);
> -		if (!hv_result_success(status))
> +
> +		if (!hv_result_timeout(status))
>  			return status;
> =20
>  		rep_comp =3D hv_repcomp(status);
> -
>  		control &=3D ~HV_HYPERCALL_REP_START_MASK;
>  		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> =20
>  		touch_nmi_watchdog();
> -	} while (rep_comp < rep_count);
> +	}
> =20
>  	return status;
>  }

[Severity: Low]
Is the trailing return status; in hv_do_rep_hypercall_cvm() needed now
that the loop is for (;;) with no break statement?  Also, HV_REP_COUNT_MAX
added earlier in this file has no users in the tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114025313.1257=
042-1-mrathor@linux.microsoft.com?part=3D2
