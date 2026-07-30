Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64C331EA5
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374757; cv=none; b=b5NG7wZoWWjxUr/4fh21iPCdoFAQf0Iw7jM+qtlfBUlraJ2F3Bwor+0rsRqTw/UIs+trDBSWGbRWcdiEkBeipgA2+Zqz4ZSPiNCCJIFq9S1tyPPE+YSFCzLE0/ie291I+KKw5MmvUC2Qez6uOui+BVgxHJd0whP0l8zHG/DPjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374757; c=relaxed/simple;
	bh=+HbaaUIMUahJwXlQkCzH8RuEd5vg0Rw+WrfY9eNHfGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jKaf7Au7U2Mmc2aTm7WuJuhCXs2nDwrTwK/fCo0raZy/3QdhbWMC2HKTsl+t1E3ALv/+yjSiUzfFgYuq5zyt9x8Qy7+6js5tGUjIfvptNDURUO/X/GmI4/OaTyLpJaGx6EaPaxuooY4imkzVS+7VBkJEs1hy7SdaTYHuJC22VZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+dHMWAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+dHMWAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1D1F000E9;
	Thu, 30 Jul 2026 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374756;
	bh=Sb3W0rcCMyorjJctvYemuATtFDoTz6Foi3UDfM2uEfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+dHMWAeTTLChO8djwUdD+w1bCER/MmuDzFvJN0cMMk6ct3vyCit+N1gHuIJ89r/v
	 PRROjj6eqaXtbBsKmBLnzjyX1vSw/WpztDKWIAVXBVUloxqqZXYKpCeaqMpv687hLf
	 QH1eX472SdH+FnDmEBBzEIiG7YgTt6cY9DMkE4+Bbu3guGu7Ba7JmimHn2rAmFrBfT
	 2U/bn7ZSWeMXMTgYEaOIbkkQE6vrH+LjsZ8Dn03P66fHTYvEs2jsp5cAlTdEIOzEBW
	 zaug5qntt9nZ+PLaAXlmAk8J27/tAzoi5anwEYZkPiOgQZfTJV2oltv/fy51bufpgc
	 llKX6UYGh7Nkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/hyperv: reserve more vectors
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260730005020.2181875-1-wei.liu@kernel.org>
References: <20260730005020.2181875-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:25:55 +0000
Message-Id: <20260730012556.03E1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to resolve the interrupt mapping failure on system=
s with X86_FEATURE_FRED enabled because an early return bypasses the newly =
added vector reservations.
--

--- Patch [1]: [PATCH] x86/hyperv: reserve more vectors ---
commit b0d2bc1fc2c7327b5574f796990f799e59f429b9
Author: Wei Liu <wei.liu@kernel.org>

x86/hyperv: reserve more vectors

This commit reserves three additional vectors used by the Microsoft
Hypervisor to prevent the kernel vector allocator from mapping device
interrupts to them when interrupt remapping is unavailable.

> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -502,17 +502,32 @@ static void hv_reserve_irq_vectors(void)
[ ... ]
>  	if (cpu_feature_enabled(X86_FEATURE_FRED))
>  		return;
> =20
>  	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>  	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> -	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_APC_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_DPC_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HAL_NT_CLOCK_IPI_VECTOR, system_vectors))
>  		BUG();

[Severity: High]
This is a pre-existing issue, but does placing these new vector reservations
after the FRED early return cause them to be bypassed on FRED-enabled
hardware?

Since the early return skips updating the system_vectors bitmap, vectors
0x2F and 0xD2 won't be reserved when X86_FEATURE_FRED is enabled.

Because the kernel's dynamic vector allocator still relies on the
system_vectors bitmap to avoid assigning device interrupts, won't the
allocator still hand these vectors out to drivers on FRED-enabled systems
and reproduce the mapping failure?

> -	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x\n",
> +	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
>  		HYPERV_DBG_ASSERT_VECTOR, HYPERV_DBG_SERVICE_VECTOR,
> -		HYPERV_DBG_FASTFAIL_VECTOR);
> +		HYPERV_DBG_FASTFAIL_VECTOR, HAL_NT_APC_VECTOR,
> +		HAL_NT_DPC_VECTOR, HAL_NT_CLOCK_IPI_VECTOR);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730005020.2181=
875-1-wei.liu@kernel.org?part=3D1
