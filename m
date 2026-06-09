Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FE3F1AA6
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029490; cv=none; b=ljtvSL67xsfB0509AdD0DlNcUSq99Xa1kCCQI7nBB+mPXKzyi4SBj0RmYJmfgPhbHV19DJzsFztma2srbX0EDccY5MOarJ0XqlhmLeOQhpXLi8a0CtRqMMIsz1LOl7xDZ5h2cFGcNWMybZkXL+EswKLMYdrBdo+2Wuu+4qRhiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029490; c=relaxed/simple;
	bh=x75UjGDXg/u3vxO7MyY5ngFpp/GmDGG9L+xpT8u0cfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AbiKoMYfjsw31VEMcLjGLIkEYZJnm428Suxa/mkXz4+uj7xydYrCI/UzAtbWXsQ4wSqHCC58Avnp/iHBzKjm554oyhUxNyP+o/F2xyprg8tJwD2xIoARKroFYPjprAQohozDYXMwef8Hz94HVQlSoMaCS+KBAmyZY8I/MzDuxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhkvw/xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhkvw/xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B761F00893;
	Tue,  9 Jun 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029489;
	bh=aYQMdHanTylwRRT4Z03HTEtBWbzcGmZ+n/kRjMoZPds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bhkvw/xaIChP/JnnAdKYNS++3st782GtGVKEWx6E3E6QPIDS5TqAVb1i+CNFG0v64
	 cV6XlPWyUCzH+iBbX6VaUT3p+H7OFGZkAWci4Uxc7GOw09MECZc+yAfN9zCI0/mdoX
	 /KHVpNzprHHiGSw31JgkJNpJn71vxQYCgmXxAUaG6+Mj2wuu8aDLvjQnp5/hMkp8wQ
	 aGF6ifrZOx7C6TmK7fWiqUogOAaboFxCO1C/iOy5K6CoEohwe7zZc6bpcO0Gag9eXC
	 JHvWQBaWSKJ6fZQj510UlGxi0GqTo0Gj+P0aIQMZ3Iq0YROmtsYprV+Czwk86lezfN
	 sOIc3GAayupjg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host
 call in CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-3-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:24:48 +0000
Message-Id: <20260609182448.D3B761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Host call structure `uuid_hc` is allocated in protected memory, wh=
ich will cause the RMM to reject the RSI_HOST_CALL.
--

commit ec503a8b7982b956b2d7e06ff213250087e22275
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

firmware: smccc: Detect hypervisor via RSI host call in CCA Realms

Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and use
rsi_host_call() to query the hypervisor vendor UUID when inside a Realm.
This introduces a file-static rsi_host_call buffer serialized by a spinlock
to handle the request.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index bdee057db2fd3..6b465e65472b0 100644
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
> +static bool arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *re=
s)
> +{
> +	guard(spinlock_irqsave)(&uuid_hc_lock);
> +
> +	memset(&uuid_hc, 0, sizeof(uuid_hc));
> +	uuid_hc.gprs[0] =3D ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
> +
> +	if (rsi_host_call(__pa_symbol(&uuid_hc)) !=3D RSI_SUCCESS)

[Severity: High]
Will the RMM reject this host call because uuid_hc is located in protected
memory?

In ARM CCA (Realms), the memory passed to the RMM for an RSI_HOST_CALL
needs to be in the unprotected (shared) state, as the untrusted host
hypervisor must be able to read and write to it.=20

Since uuid_hc is statically allocated, it resides in the kernel's protected
BSS section. Calling rsi_host_call() with this physical address will likely
result in RSI_ERROR_INPUT and break hypervisor UUID discovery.

Additionally, because memory decryption operates at page granularity, apply=
ing
set_memory_decrypted() to a static variable would decrypt adjacent, unrelat=
ed
kernel data and expose it to the untrusted host.

Should this instead use a dedicated, dynamically allocated page that is saf=
ely
marked as decrypted?

> +		return false;
> +
> +	res->a0 =3D uuid_hc.gprs[0];
> +	res->a1 =3D uuid_hc.gprs[1];
> +	res->a2 =3D uuid_hc.gprs[2];
> +	res->a3 =3D uuid_hc.gprs[3];
> +	return true;
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609181030.2378=
391-1-kameroncarr@linux.microsoft.com?part=3D2
