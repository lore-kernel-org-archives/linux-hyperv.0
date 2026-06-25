Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7D3EA961
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410044; cv=none; b=HE7KXw/qb/+TZbeRCpfO4ZUHQA0vFncOIVlpUAo1tBP6aCPHqbY6+aFYMKvM5ZoiDEW5cWNsoF28QBgcruZE7KFdSZM9lVyrfVnPLA2PH26iIhOb2emnP5mpuI6pM9SHccXlARWaDqXhO6Jg0uxwijy+0rcMuUneFuaCXAyHFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410044; c=relaxed/simple;
	bh=qG0bn8kxZQeXC+1GlekZJ3kTnfb1eop9+y2PB3tftk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RR0d1K+/KSp1UU8J/nd+JMqHW49l2WO4F0fylHZX/eID+E/vs+RkptJ8WYnzXQyYc+BABDaD3AJjQbBWMiIA/JAFr9tKEQaNCczoGxNmdQzyEoPJhR6DwVGGPopNCqt6ZUpMDgXFSWSqDsZt2LyTJr65Y3GX52f47bejRd4GnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJX5/K1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJX5/K1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B51F000E9;
	Thu, 25 Jun 2026 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410042;
	bh=KBqLGNFCwil1X1ocztkmUvL0PUsyEzxpBiVKIzfYqOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJX5/K1V8WRSHbuKxm3BpQJX+3xmGg8x1aH2EkOH+5xA1hVjdWU7mvZfTLci47kgG
	 UPytES6EPWMwKcYGuA8jfwPBldi62O5gTDvcFMaMRbSLh/D+DmkvyXEl5DmSiNSoSF
	 jzFXjXw3dGCKqHOBd7Hys4itYSkJF1V5gpLkP+DJXfHmXVsLfA2Dyezugwr/jycYPi
	 u75XUrsekHxO3CwQsKlOfNzgOr+p7IgP7zQVfE3NTk93yAljL53O3E6nMTiNnlBhYi
	 thD/hE5Uqu5NyvZN276th/i5Ho22EDSMhFz1lB8PMiwDWcmYb5YX3mzE4DCABggn79
	 KGQlPKc3ZlEeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260625173500.1995481-3-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:54:01 +0000
Message-Id: <20260625175402.378B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Initialization order bug causes `arm_smccc_hypervisor_has_uuid()=
` to incorrectly fall back to standard SMC during early boot in a CCA Realm.
--

commit 8e27a5d40fac36e0edcb6814624362e892694ac4
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

This commit modifies arm_smccc_hypervisor_has_uuid() to check is_realm_worl=
d()
and use an RSI host call to query the hypervisor UUID inside a Realm. It ad=
ds
a file-static RSI host call buffer serialized by a spinlock for ARM64.

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
[ ... ]
>  bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
>  {
>  	struct arm_smccc_res res =3D {};
>  	uuid_t uuid;
> =20
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +#ifdef CONFIG_ARM64
> +	if (is_realm_world())
> +		arm_smccc_realm_get_hypervisor_uuid(&res);
> +	else
> +#endif

[Severity: Medium]
Will this check evaluate to false during early boot, causing the detection =
to
incorrectly fall back to the standard SMC conduit?

Looking at setup_arch(), psci_dt_init() executes before arm64_rsi_init() is
called to set up the rsi_present static key used by is_realm_world():

setup_arch() {
    ...
    if (acpi_disabled)
        psci_dt_init();
    else
        psci_acpi_init();

    arm64_rsi_init();
    ...
}

Because psci_dt_init() calls psci_probe(), which calls kvm_init_hyp_service=
s(),
this eventually reaches arm_smccc_hypervisor_has_uuid() before the static k=
ey
is initialized.=20

Does this sequence cause a silent failure to detect the KVM hypervisor insi=
de
an Arm CCA Realm?

> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
> +				     &res);
> +
>  	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625173500.1995=
481-1-kameroncarr@linux.microsoft.com?part=3D2
