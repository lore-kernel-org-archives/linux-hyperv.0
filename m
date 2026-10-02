Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA605473C84
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Oct 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932438; cv=none; b=BZ9pRi6B4n5t5feMsYGmk7C6tCAn2IsJzKNFAUNm27GpJjdVQFKkfonRo+RyAc6/YTu4hPRCGFKSELO7hBS5zyWvdd2rNTZfnfZo2paPGS3Lcaljm7aFMrw2Cd3sDOoptjaEUAvvL9HX23p2m9rcXZewlzo0gVOSBO3at2PS8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932438; c=relaxed/simple;
	bh=1vk3KPZGFw4aGvTJXl2tamrFCwp8VzbQooQkMEzZXYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rsp2j8a4tR1mRfT1zzxBFQXQuiTjJpFR0vUXYflbTkpIjIpjlZX/q/oLGUb1fCNp16NMzYtcgWlGTzs9nVajzkd6BX6evf3HltB18NktAMddBCjnSKJmb7/E1FI1PcfMPD6+fgdnvjYRp6z87HKclxEgraeCdu9RVI+KRlDU1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OndOilwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OndOilwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C41D1F000FF;
	Fri,  2 Oct 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932437;
	bh=u1hs7uw/oVFwfQB5o6wdbNRYSuP9QtcJwjsxxWXjNZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OndOilwBSJ0Tl5+ZlxUWy+UJPnP29HHuxx/Z0VgBhTXrCqe+XEKn+5Bq+jVQesEip
	 qV+pABy2plblKO+RfTgEbgbDsUniY/W7oUfy7d7OtQf+KDM/2zG89tdauF6g1B2FgC
	 9K2LwE3hmwiAOwkpMeaia9bkUcpmFftaOzTt9V+hQH0b+7DlpI9vt08RmWLsozuyih
	 0rihaArJ6cl/PICclgcN0694rdNSwQKH426mQ+JAWKJfLsChBIruDChYFaMjzurXAH
	 UzMFzx2v6NCG4J7VnwlAoEWoqJQ6yKp+G9i25W9zQG5r/AAA67bUVBXe3kgUvDAVc3
	 ZOlLVplWnvMsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261001220552.1793471-3-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
 <20261001220552.1793471-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:56 +0000
Message-Id: <20261002091357.2C41D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] init: KVM hypervisor detection fails in Realms due to late rsi_p=
resent init
--

commit 26246cc162e7aa368ba4bffb04d1af1a21a168c0
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

This commit modifies arm_smccc_hypervisor_has_uuid() to check if the system
is running in a Realm environment. If so, it uses an RSI host call to query
the hypervisor vendor UUID instead of a direct SMC or HVC call.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index afc2e4d602ba6..7e7717076eeb0 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c

[ ... ]

> @@ -69,12 +75,45 @@ s32 arm_smccc_get_soc_id_revision(void)
>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  {
>  	struct arm_smccc_res res =3D {};
>  	uuid_t uuid;
> =20
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +#ifdef CONFIG_ARM64
> +	if (is_realm_world())

[Severity: Medium]
Does this Realm detection fail for early callers like KVM initialization?

The is_realm_world() check relies on the rsi_present static key being set.
However, during early boot in setup_arch(), arm64_rsi_init() is called
after the PSCI initialization:

arch/arm64/kernel/setup.c:setup_arch() {
	...
	if (acpi_disabled)
		psci_dt_init();
	else
		psci_acpi_init();

	arm64_rsi_init();
	...
}

The PSCI initialization path eventually calls kvm_init_hyp_services(), which
uses arm_smccc_hypervisor_has_uuid() to detect the hypervisor. Since the
rsi_present key has not been set yet, is_realm_world() will return false.

This causes a fallback to the direct SMC invocation, which is intercepted a=
nd
fails in Realm environments, preventing the initialization of KVM
paravirtualization features for Realm guests.

> +		arm_smccc_realm_get_hypervisor_uuid(&res);
> +	else
> +#endif
> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> +				     &res);
> +
>  	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
>  		return false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001220552.1793=
471-1-kameroncarr@linux.microsoft.com?part=3D2
