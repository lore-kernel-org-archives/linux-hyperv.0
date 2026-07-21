Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C05470440
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665341; cv=none; b=m7Ac7evPkDH73UshM2Gk9qzPFItrglSD9ZB+POTNg6TnUdIrKXcnhIwvGYHKKjiNEVj7jLwGxOrnPBb/eUQ2ejZ7T0QdJeYEuxrmeXrGoJqNjo4HmXwZG7Xjx4Q5E48v3L89K1ilUl+mnEnhfL2C43TyGHPbkFOcryfmSXEflqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665341; c=relaxed/simple;
	bh=UKSITUT/KNI8rQTUfXsHnM/XzehysOx+2+51uhDC1XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pZHcg0L4Agz2PcsltCTmvUuLVRG6llCXGT+QGa+cNHRnNxTLUvDp/QxBr/TlYC5tRn7t0SzUgYIkoerW9WNB91yIukXR6I0JCLcSpF4OVnvfTIEzrCiT2cTZgW+WhBUOwV8QjMRs00Ps+p4YGVzsgqyzv2xhfdlF61zCuqt3wFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGqVF+lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGqVF+lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFED51F00A3A;
	Tue, 21 Jul 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665339;
	bh=Olg8EUlbIu4cu8PoOBvkot+EipyWEipY4Tl8BJtfNxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MGqVF+lrf6h6B01JpIZVmj1Lhriprom6tygL6aOgw/XLBWud+jWnWEIKiByG79DjF
	 cjBvYigAy4zbDIE9jsm/6ogIBr/csq3w1x/EyuqQodlgzsbDq8eedlb0IQPlpa1yry
	 KpRzuRBPW1Sxb5eEYJ/CrJuxFgIs57VYDjjNpXm6RnK1UgcJoLkRLnFPZryr3F64GS
	 POvu1b7gZM1ioHWNsGsRA+YVs7/6MJceajhpNPpv12xgatqP1JepS4pNMBqzsw6F71
	 U9HU468+o8XYFuzgbRxs6hEZe6LSHTQHpuA4TYjjFE4uGWGyYgJvgOVEH6C/sMXH34
	 5oz2FA4SiS+tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721201148.1441143-2-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-2-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:22:19 +0000
Message-Id: <20260721202219.BFED51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `rsi_host_call` structure uses native integer types instead =
of explicit little-endian types, which can cause an ABI mismatch on big-end=
ian kernels.
--

--- Patch [1]: [PATCH v3 1/6] arm64: rsi: Add RSI host call structure and h=
elper function ---
commit 47a2fc3b0f72dc993f44827b221ab5eb02bbcb36
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

arm64: rsi: Add RSI host call structure and helper function

This commit introduces the rsi_host_call structure and a helper function to
invoke SMC_RSI_HOST_CALL. This allows Hyper-V guest code to route hypercalls
through the RSI interface when running inside an Arm CCA Realm.

[ ... ]

> diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rs=
i_smc.h
> index e19253f96c940..9cc57b5be0c02 100644
> --- a/arch/arm64/include/asm/rsi_smc.h
> +++ b/arch/arm64/include/asm/rsi_smc.h
> @@ -142,6 +142,13 @@ struct realm_config {
>  	 */
>  } __aligned(0x1000);
> =20
> +struct rsi_host_call {
> +	u16 immediate;
> +	u8 _padding[6];
> +	u64 gprs[31];
> +} __aligned(256);

[Severity: Medium]
Should this structure use explicit little-endian types (__le16, __le64)
instead of native integer types?

If a big-endian kernel constructs this structure in memory and issues the
SMC, won't the Realm Management Monitor read byte-swapped values? The CCA
RMM specification dictates that memory structures shared between the Realm
and the RMM must be little-endian, so using native types could cause an ABI
mismatch.

> +static_assert(sizeof(struct rsi_host_call) =3D=3D 256);
> +
>  #endif /* __ASSEMBLER__ */
> =20
>  /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201148.1441=
143-1-kameroncarr@linux.microsoft.com?part=3D1
