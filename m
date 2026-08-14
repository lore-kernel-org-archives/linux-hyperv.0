Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A442E7390;
	Fri, 14 Aug 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740965; cv=none; b=kPLDowQaoamv7J1jdGt+HzMvwGRKjHJSN84XkCq2UHQtUAZNWbK+EMJ/ROkrfCzrcqiHYWcY4nYfqkUTik7juV+gRD1JB+ShkMzO7Khu7BJXBsJ8+lwTXP7cpDwCYba2IGMWPSUZm41FATuedeJ6i0fRWuDKHc6iFID7kzVWttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740965; c=relaxed/simple;
	bh=OZOxNC1RpuxYhD0EzavS3619bf2lcmmOSimmgIlTmTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvWOUWNvN9IVxTXMPaEzh5GBHTTd1uAMFkhLtCln2g3/JNGp3qxM2cwEWe1YKhP2wlplGokojOjMm8KJ3b585f6VNVf6k0BjJqVSPjwRp0pH3eYnuCE8RkZNKtNdmGjhU0oIISFANt8bicQ/v/PP59hL+ns+isSXVHUg+o16Hq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faVlqrLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faVlqrLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497061F00A3A;
	Fri, 14 Aug 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740963;
	bh=fTfUDQrgJ3Y+t0RXMYFXkxKPnYej7d4+iN1qSmhzYRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faVlqrLBEhwneawuv22KUSZLYCX7unkodfOtf3Hcy0hRJXpLl3IrOplgOC9ywccXK
	 /vk5qU0qILftzpV2Z7wUjZLsodfwUxICqs6/i8/CUNzSkAv9eMhVbmhJYDgyIO1sFz
	 /vw2D90gMNhpA5V7nvcO2ezHZLgrc+4Pexmc4Rx48OQcgcqOgowpqtXddb6/IaOYEq
	 8PhWN/CHhCzvr6WLO+6UFekETFGShIvJYIG1le4FZ+XixW3npDsdzUeZOMRgLiMApa
	 QmNJghPBd6iqva7/1NKcD+XRgPOmQteFxxCjrDZO0mxUkdbG6sX+inC02wD0bucfHX
	 T9S1jtidwcOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in
 drm_vblank_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lyude Paul" <lyude@redhat.com>
Cc: imx@lists.linux.dev, intel-xe@lists.freedesktop.org, neil.armstrong@linaro.org, intel-gfx@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org
In-Reply-To: <20260814203542.1405135-5-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
 <20260814203542.1405135-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:56:02 +0000
Message-Id: <20260814205603.497061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling `drm_vblank_init` before creating CRTCs results in a z=
ero-size allocation, leading to a kernel crash when vblank features are lat=
er used.
--

--- Patch [4]: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in drm_vblan=
k_init() ---
commit 4aec980231f556c8a36b5294d67b3d582d49d623
Author: Lyude Paul <lyude@redhat.com>

drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()

This patch updates drm_vblank_init() to use the drm_for_each_crtc() iterator
instead of manually counting the number of CRTCs.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 17283e8920378..d57405050554f 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -547,19 +547,20 @@ static void drm_vblank_init_release(struct drm_devi=
ce *dev, void *ptr)
>  int drm_vblank_init(struct drm_device *dev)
>  {
>  	int ret;
> -	unsigned int num_crtcs =3D dev->mode_config.num_crtc;
> -	unsigned int i;
> +	struct drm_crtc *crtc;
> =20
>  	spin_lock_init(&dev->vbl_lock);
>  	spin_lock_init(&dev->vblank_time_lock);
> =20
> -	dev->vblank =3D drmm_kcalloc(dev, num_crtcs, sizeof(*dev->vblank), GFP_=
KERNEL);
> +	dev->vblank =3D drmm_kcalloc(dev, dev->mode_config.num_crtc,
> +				   sizeof(*dev->vblank), GFP_KERNEL);
>  	if (!dev->vblank)
>  		return -ENOMEM;
> =20
>  	dev->has_hw_vblank =3D true;
> =20
> -	for (i =3D 0; i < num_crtcs; i++) {
> +	drm_for_each_crtc(crtc, dev) {

[Severity: Critical]
Could this change lead to an uninitialized vblank array and subsequent page
fault for drivers that initialize vblank before creating CRTCs?

For example, in vkms_drv.c:vkms_create(), drm_vblank_init() is called before
vkms_modeset_init() creates the CRTCs:

	ret =3D drm_vblank_init(&vkms_device->drm);
	if (ret) {
		DRM_ERROR("Failed to vblank\n");
		goto out_devres;
	}

	ret =3D vkms_modeset_init(vkms_device);

Because the CRTCs are not yet created at this point, dev->mode_config.num_c=
rtc
is 0. The allocation for the vblank array becomes a 0-byte allocation,
returning ZERO_SIZE_PTR (0x10). The drm_for_each_crtc() loop then executes 0
times, and drm_vblank_init() successfully returns 0.

When userspace later calls DRM_IOCTL_WAIT_VBLANK, the kernel looks up the
CRTC using drm_vblank_crtc(dev, pipe). This returns a pointer into the arra=
y,
which evaluates to ZERO_SIZE_PTR + pipe * sizeof(...).

Will dereferencing this pointer cause an immediate kernel OOPS?

> +		unsigned int i =3D crtc->index;
>  		struct drm_vblank_crtc *vblank =3D drm_vblank_crtc(dev, i);
> =20
>  		vblank->dev =3D dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814203542.1405=
135-1-lyude@redhat.com?part=3D4
