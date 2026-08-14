Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587A33AD9C;
	Fri, 14 Aug 2026 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740708; cv=none; b=TYZOiDFOcVsCi1NhRzqbeO5vbn+DYtLnhM1j+7QPuyCsXkvPzIt1NY+NymOssDGAZZEvm051jm1WNFr5KZHG/4ZInLJRihg43SK2dRxHjMlMuN8fo5NUc3BAyujdqdHHxbD7jLIs2qUWh1uDlNtnmFGHQL9Q8uTEAJbSUo2lHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740708; c=relaxed/simple;
	bh=sKmwZzj1qR9pXfms5hAGhL3d8vFO3rdxpfs+J8G31hE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TK6BoiYMXgKS2Gn15NPqkXkMO1Pwez0to/S047A9NxOKlEBzeUU13Of+/TY8F7WjFexHlzuNH9zE8qrQYKiz/YJhgMNMox/XXW00OkBcH0ibRiIzqEuKgATVWpRpfC7cXmr4hb6Y4P+DwY3fsY6jMcHmves/3KGNexQoD85qE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kutsmjbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kutsmjbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560FA1F000E9;
	Fri, 14 Aug 2026 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740706;
	bh=0IYOYwNbA/BZ+ifKph8wX7c9viUdBpinxV81JfV7DrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kutsmjbdJj//waNJ/u3uWkelQcLhVYJqTjCMBkH/ia5KfE6A0TogkSU5frpfOAaFJ
	 n0YEsTDwkj/GqZ5xeVuH4gwDFA2SE6/t9KZBUhQxDsr1uAnCSjLCFml8X3A4i87iR5
	 cegpEf+BcQYBuIxfzNj0Yvr3AGoDN1tcdNQNzo2KozfvRJUKqRlmMOC6GYvilCJIBw
	 uSs8o2df0YNNh/tViXOY06lHy1VzxJU6Ih9ngO9OyYzOeg5mTlMKo1gle2oIsKXkAH
	 mPbHu1FXJQd5LCGwZoat4Kkf/9oY7psZyF1nhOTuGWdNNhTxgSoMxC/86yz5Kx7qn0
	 f7XsIIT4TRQCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/vblank: Remove num_crtcs argument from
 drm_vblank_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, imx@lists.linux.dev, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260814203542.1405135-4-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:51:45 +0000
Message-Id: <20260814205146.560FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm_vblank_init() returns -ENODEV causing probe failures in mu=
ltiple drivers
--

--- Patch [3]: [PATCH 3/5] drm/vblank: Remove num_crtcs argument from drm_v=
blank_init() ---
commit 049e1e142facf2bbdd92cd8a8847a53f6b18b3aa
Author: Lyude Paul <lyude@redhat.com>

drm/vblank: Remove num_crtcs argument from drm_vblank_init()

This commit removes the num_crtcs argument from drm_vblank_init() and
updates callers across the tree to rely on the internal DRM count of CRTCs
instead. The change was applied mechanically using a Coccinelle patch.

> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/as=
peed/aspeed_gfx_drv.c
> index d4577663a1f0e..ba78695d1015c 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -205,7 +205,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  	if (ret < 0)
>  		return ret;
> =20
> -	ret =3D drm_vblank_init(drm, 1);
> +	ret =3D drm_vblank_init(drm);

[Severity: Critical]
Will this cause a probe regression for this driver?

By removing the explicit CRTC count, drm_vblank_init() now relies on the
DRM device's internal CRTC list being populated. However, aspeed_gfx_load()
calls drm_vblank_init() before calling aspeed_gfx_create_pipe(), which is
where the CRTC is actually created.

Because the CRTC list is empty at this point, drm_vblank_init() will
return -ENODEV and fail the probe.

>  	if (ret < 0) {
>  		dev_err(drm->dev, "Failed to initialise vblank\n");
>  		return ret;

> [ ... ]

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/=
drm/renesas/rcar-du/rcar_du_kms.c
> index 9228a7ad0dfa4..c9e29da53d056 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -888,7 +888,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
>  	 * Initialize vertical blanking interrupts handling. Start with vblank
>  	 * disabled for all CRTCs.
>  	 */
> -	ret =3D drm_vblank_init(dev, rcdu->num_crtcs);
> +	ret =3D drm_vblank_init(dev);

[Severity: Critical]
Does this introduce a similar regression for rcar-du?

The driver calls drm_vblank_init() here, but the CRTCs are not created
until the rcar_du_crtc_create() loop further down. This means
drm_vblank_init() will see an empty CRTC list and fail with -ENODEV.

>  	if (ret < 0)
>  		return ret;

> [ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 5a640b531d88f..5a830cee7fe9b 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -192,8 +192,7 @@ int vkms_create(struct vkms_config *config)
>  		goto out_devres;
>  	}
> =20
> -	ret =3D drm_vblank_init(&vkms_device->drm,
> -			      vkms_config_get_num_crtcs(config));
> +	ret =3D drm_vblank_init(&vkms_device->drm);

[Severity: Critical]
Can this lead to a complete initialization failure for vkms?

The call to drm_vblank_init() occurs before vkms_modeset_init(), meaning
the pipeline components have not been created yet and the internal CRTC
count is zero.

>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
>  		goto out_devres;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814203542.1405=
135-1-lyude@redhat.com?part=3D3
