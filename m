Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173C472F79
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665498; cv=none; b=NeGEvsRKcXwbvTiXWFxq2l8/YgAOEiHvP6huounzd51wMe+5GcY5gXuNaUT1ccpcFtGeSlLsBCZEhOMXt454OQOd3hk3abs6HdDjCQ7o7D6W3HSgphg/SXC4XrAh8L5QYZdN3HyNBBrfsej/EnT9mrU0qtRvyXlII4F+il5ffnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665498; c=relaxed/simple;
	bh=NIeq7geSak9H5TEgUpb1EMyzcPV5Y57ota2JRza3srQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KkMhVEQme3HBdjN/9Q+VZ5J9yfpl+R7QJpDgIHVmY/mxHu8w3WEU2miFiZZDUtTOCUKvQtH3KHJh3k7m/kVNxV/E7vIxa5YqJAo2d0/ua87nT3sAB4IGIuHSP6okQ4yR3M4dcuJKGT+w+87N4mlKm8omMrJAbp+4GsdeA4blgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSMGC5Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSMGC5Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05F91F000E9;
	Tue, 21 Jul 2026 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665497;
	bh=L+mDiI0TF1facxpNWsX0UGv7ACQgAgwC0YOlYdOmVZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSMGC5CzSlnbjjYpKm0q019BeuubcezY4uJe3/DJfYn7DQ79digO5Oq46EouTkl3m
	 CKhO0G7QcKY9HNEMSAKO/DwfGgjjenMfZVYErxv2zwg87U8QzWUDulESCwnyzQAXhs
	 z6nl6h0448uMPusJ6eo6Hj7I7E9Knj8i0FeJZbFeTecqnRGKLYGYFoR0vxL6OY4OPg
	 Mg6/pmq4YcaF7/I7MBf2pB1WEsehi+dgtRkpig65zTv0LiWcwOjU3wWJBG+VelTwH9
	 VbWVavc+Ywdjfzi7yAKlLOCi6LnRtpxRZEmpP6/qZaBHztisrwgpmFLnbR7/R+Et0M
	 OgZ/ZSv50vbPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721201148.1441143-3-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:24:56 +0000
Message-Id: <20260721202456.E05F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler memory barrier causes dead-store elimination and =
constant-folding of the RSI host call buffer.
--

--- Patch [2]: [PATCH v3 2/6] firmware: smccc: Detect hypervisor via RSI ho=
st call in CCA Realms ---
commit 5f8398cb1bc3327a58d70463ef37d994ffacca02
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

This commit modifies arm_smccc_hypervisor_has_uuid() to use rsi_host_call()
when operating in a Realm. It introduces arm_smccc_realm_get_hypervisor_uui=
d()
which uses a spinlock-protected file-static buffer to make the call.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index bdee057db2fd3..a876b7aa2dc99 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
[ ... ]
> @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> =20
> +#ifdef CONFIG_ARM64
> +static struct rsi_host_call uuid_hc;
> +static DEFINE_SPINLOCK(uuid_hc_lock);
> +
> +/*
> + * Helper function to get the hypervisor UUID via an RsiHostCall.
> + */
> +static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *re=
s)
> +{
> +	guard(spinlock_irqsave)(&uuid_hc_lock);
> +
> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> +	uuid_hc.gprs[0] =3D ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> +
> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) !=3D RSI_SUCCESS) {
> +		res->a0 =3D SMCCC_RET_NOT_SUPPORTED;
> +		return;
> +	}
> +
> +	res->a0 =3D uuid_hc.gprs[0];

[Severity: High]
Does this code need a compiler memory barrier before reading back the resul=
ts?

Because __pa_symbol() uses RELOC_HIDE() to explicitly hide the pointer's
provenance from the compiler's alias analysis, the compiler may not realize
that rsi_host_call() modifies uuid_hc.

Without a barrier(), could the compiler constant-fold the reads to their
statically-known previous values? If so, this could result in res->a0 being
optimized to ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID instead of the value
returned by the hypervisor, and potentially allow the stores during
initialization to be dead-store eliminated.

> +	res->a1 =3D uuid_hc.gprs[1];
> +	res->a2 =3D uuid_hc.gprs[2];
> +	res->a3 =3D uuid_hc.gprs[3];
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201148.1441=
143-1-kameroncarr@linux.microsoft.com?part=3D2
