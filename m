Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CA3A48C5
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Sep 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379279; cv=none; b=PXVDNRf3Wnk7aXV70ZiOvVrGxjz54mp0sYX8/BLfPABnbZ3O6BoX0RmvFODIm/EY7CR9mECTX3tf4Cxm4YV5Labf/1FezdNzxB1f+CNkJXR+VZDEQqBphQDFyaHQBQgNzRcxcqa5fXrGnSlsA1LMVshgyzMVZwSsu1+bSKQMt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379279; c=relaxed/simple;
	bh=qitULFpdPWTR+4Zp7mP/FF0IyEWON0bfHPNcQLr9AhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZJXoZkfV3KVbFzHp2+KL9QkQv01xQBrYuYXrAe9BlBv+qLr98JcS/ZYnzhZTc6KTSK01bSblir3tGGQXZV2p3octlBC0FEEpWRN5S1fW1oqJ9g8ZnSD/Til6YGjzwsMKe2vnFKBG/ii9rJanr1vPaMovVh65fvr6BZHuzllces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK73YMMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK73YMMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71181F000E9;
	Wed,  2 Sep 2026 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379278;
	bh=nKCpaoOWlOZc2t2tUU6dqB0DhFE7vFvP1K18fBk9Jh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZK73YMMxvjYhq1teTXpCIlY04yG/Wqeg8tzVmX+9hQfQBMn+udC6fZe7EnvQNXCi0
	 4jomgf2yz1Riyq2+DMP/fLckkBnyhPhagysl/8ksRdH8nfP0YWcdCmqoPoUbXbX1FB
	 Nuk9OC8FE4L5MxEO9a5DBAB31kceN6N1ULF5eC0UVNaKk9o2KgYddor2QEYIzZ3im8
	 JKoeaq2miU0di2KPjmVnSVQ5R7nu3OJfahymRuOm6ctWBNAvYWMw5RwlMmhJa+tyuA
	 BDR4AEsJ8MjmLHSwJQyo0rqEcejMWaSxQezS2/dXzktEQgHNEOVsDSCr/zSl9p1LmP
	 b0fVfsfWJBtLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/4] net: mana: track when the HWC has been
 handed to the PF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901200018.3194525-2-longli@microsoft.com>
References: <20260901200018.3194525-1-longli@microsoft.com>
 <20260901200018.3194525-2-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:01:17 +0000
Message-Id: <20260902200117.C71181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `mana_smc_teardown_hwc()` fails, the driver proceeds to uncondi=
tionally destroy the hardware queues and free their backing DMA memory, whi=
ch can lead to a DMA use-after-free by the device.
--

commit 0af150088ed8994a134d0a328a359e4cea4bbce5
Author: Long Li <longli@microsoft.com>

net: mana: track when the HWC has been handed to the PF

This commit introduces a new setup_active flag to reliably track whether the
hardware queues have been handed to the physical function, addressing a gap
where the previous queue depth check was insufficient. This ensures accurate
state tracking during teardown to prepare for a future reinitialization pat=
h.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index 263e7c4e29341..75fdccdc8c482 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
[ ... ]
> @@ -815,13 +815,20 @@ void mana_hwc_destroy_channel(struct gdma_context *=
gc)
>  	if (!hwc)
>  		return;
> =20
> -	/* gc->max_num_cqs is set in mana_hwc_init_event_handler(). If it's
> -	 * non-zero, the HWC worked and we should tear down the HWC here.
> +	/* Tear down only if setup_hwc() handed the queues to the PF.  Until
> +	 * then the device never saw them, so there is nothing to undo.
>  	 */
> -	if (gc->max_num_cqs > 0) {
> -		mana_smc_teardown_hwc(&gc->shm_channel, false);
> -		gc->max_num_cqs =3D 0;
> +	if (hwc->setup_active) {
> +		/* Only a successful teardown invalidates the MST entries.  If
> +		 * it fails the device may still be using the queues, so leave
> +		 * the flag set rather than record a clean teardown.
> +		 */
> +		if (!mana_smc_teardown_hwc(&gc->shm_channel, false))
> +			hwc->setup_active =3D false;
> +		else
> +			dev_err(hwc->dev, "Failed to tear down HWC\n");
>  	}
> +	gc->max_num_cqs =3D 0;
> =20
>  	if (hwc->txq)
>  		mana_hwc_destroy_wq(hwc, hwc->txq);

[Severity: High]
This is a pre-existing issue, but if mana_smc_teardown_hwc() fails, does the
driver proceed to unconditionally destroy the hardware queues and free their
backing DMA memory?

As the newly added comment acknowledges that "the device may still be using
the queues", calling mana_hwc_destroy_wq() unconditionally unmaps and frees
the DMA memory. If the physical function hardware is still active, could th=
is
result in a DMA use-after-free leading to memory corruption or IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901200018.3194=
525-1-longli@microsoft.com?part=3D1
