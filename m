Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042C38B147
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284115; cv=none; b=rPTKgUv65IankywyR869N0I1sLHLtA34JlpBc+ztVglrICPMP2og5rYe3q1HD2GLyQWYkNeO75/I9XCCrjHOm85/Ns6IK04aUTsKis8wwtA9ik1LWB+Qk9MvNRWWjLX2G8pYMPWxgLM+edVOyMYCo0ycNDDEionOq6Ts+RhLKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284115; c=relaxed/simple;
	bh=hyGh81g0LpxC/gwcsryNXNDftWeBZBaOe6CWX47ym7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nPzfzgrA3fg4Pt0lfYACQ5/rQ7QRitn3+BIztt2yimIHnEuFRYe0KGuUH4zSxx0PKNlmB38cRQBdCMeOFUK8KgMpzdsC/lU78hqb/dFVKWEfCz6OT7THUrHSb17N1nNwGqgW1nfahim/6F9IX38Y92pQQnMBVxUstEReEIh0zyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCJS26IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCJS26IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF51F000E9;
	Tue,  1 Sep 2026 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284113;
	bh=kjEssPBEFQInTP+QvWVnDn7ZtjnTVLT13y4Dy5qrRWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCJS26IBKnJdo5r2u4hg/tXkS/olMTAtjXnCZAQSGBlsoD8vGTWWZxnz+2m/6KUAP
	 MFDEO4xlRjtxI9IBghAaOzQTG7AS7CY/rn/Lqf27Y4sP+O4K6TxynHLHVbt5kiLDWv
	 8PLeTxJ07urus6v40213YkzC4DcNOdvSsth4SQPZ/Gry9VCg2NPgZ4ORyMixrn/71c
	 hJ6ug6ytNkwE4Ba98Uj3zeSbgB0xbdSlJBq/IZJ1ixrs7JkVHKeXusYLpvO6/SJ1uG
	 HUXM6GSaWfzHTRU8bqpvP0f/I7oUV7A2AYLDWA72T/OkfMgFAxUw+usgDNAvUHPQyp
	 FavDA/aDp5TSg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/12] drivers: hv: hv_vsm_boot: Boot primary
 processor in VTL1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-12-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-12-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:35:13 +0000
Message-Id: <20260901173513.ABCF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignored error status from VTL1 boot handshake allows the system to=
 continue in an insecure state, bypassing a security-critical kernel panic.
--

commit 91cb8ed727ae4b19c3d3be7dbd03c34def48f245
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: hv_vsm_boot: Boot primary processor in VTL1

This commit introduces the final step of the primary-CPU bring-up to
transition into VTL1 and start executing the secure kernel. It issues
the first vtlcall on the primary CPU to pass initialization arguments.
It also adds a check to see if Mode-Based Execution Control (MBEC) is
enabled after booting into VTL1.

> diff --git a/drivers/hv/hv_vsm_boot.c b/drivers/hv/hv_vsm_boot.c
> index abe82e03e1897..c4f15c42df1f6 100644
> --- a/drivers/hv/hv_vsm_boot.c
> +++ b/drivers/hv/hv_vsm_boot.c
[ ... ]
> +static int __init hv_vsm_boot_vtl1(void)
> +{
> +	struct hv_vtlcall_param args =3D {0};
> +	u16 vp_enabled_vtl_set =3D 0;
> +	u8 active_mbec_enabled =3D 0;
> +	int ret;
> +	s64 sk_status;
> +
> +	args.a0 =3D num_possible_cpus();
> +	args.a1 =3D sk_res.start;
> +	args.a2 =3D resource_size(&sk_res);
> +
> +	/* Kick start vtl1 boot on the primary cpu. */
> +	sk_status =3D hv_vsm_vtlcall(&args);
> +	if (sk_status)
> +		pr_warn("VTL1 boot returned status %lld\n", sk_status);
> +
> +	ret =3D hv_vsm_get_vp_status(&vp_enabled_vtl_set, &active_mbec_enabled);
> +	if (ret)
> +		return ret;
> +
> +	if (!active_mbec_enabled) {
> +		pr_err("Failed to enable MBEC for VP0\n");
> +		hv_vsm_mbec_enabled =3D false;
> +	}
> +	return 0;
> +}
        ^^^^

[Severity: High]
Does this code silently ignore a VTL1 boot failure?

If hv_vsm_vtlcall() returns a non-zero error in sk_status, this function
merely logs a warning and proceeds to call hv_vsm_get_vp_status().

If hv_vsm_get_vp_status() succeeds despite the VTL1 boot failure,
hv_vsm_boot_vtl1() will return 0, because vp_enabled_vtl_set is never
validated to confirm VTL1 actually booted.

This could allow the system to continue by bypassing failure handling in the
caller. If VTL1 setup fails, could the partition be left in an exposed state
where an attacker might race to configure VTL1 themselves and gain a
higher-privilege foothold than VTL0?

Should this return an error code when hv_vsm_vtlcall() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D11
