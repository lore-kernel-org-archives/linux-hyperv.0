Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426295;
	b=NDHa2Rf3rlFMSVmGxVUPphXYAG2/mQZq0tIlOldCA5BFnrziSqRU4cc0/Q+xVW87l/5z
	 coifjhz263GGOcHijRf+SBNm3ipz0JMLdNL/uwXtR/lGAB0dbZFrsFkyfQPH6EvrReq2R
	 VD02oM2VoxieEI6bPI2v9Kct4B8u+2DWPXe+wXfL+h5T3xokAIsqUSo3CFU64AFelRT5r
	 ScATu6E0CvJ4/Thf26kUQzqmmaSjIgJ/IaeJ+BX4HW87P2tLGI7cCziIaGMeJww7R9Fkl
	 CHJQn3chA4GmBf5pL7cTPFqmpvHs9+zKp9RyMGagvg4AU9rKU05RXweB9Ns21VP7k2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oQNjJoZ0jTS+KSHbGjg9eb95h9U/EVZVTbkZwJqmV3I=;
	b=uVCRh2Cnh1it6AYY48+2dru9ctboM43nKGSQOVc5JVrzQzIJi+k6eB//HxUYUywNHkMI
	 /6ne2uw2LkfEvfOls8MqTnISGS2YynXymTlKZWi3CxGpoEPuy5lvS59VPfhnVdV87xS89
	 FK9Ss0HMcjetaLmzysCTQx2JBx3/+21nmOrEiqrtZ1DDcef0Z7DG2EfHqBGXnnDCVpliA
	 3R+AVesH/RXjyMSuVv33DKpHDgTAxYzqj/HQ7djGHjZzxs80lqcGlVL0Ex8sq5kdHrUbr
	 KC83g2bpqXK+Vji3kjTbn1RMX48R5eNCHFrDTkI8m+xXmAnjfrFJTg4mC5AWVZ09wzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD1XkAp1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D50606DA79;
	Mon, 19 Oct 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD1XkAp1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC0A1F000C4;
	Mon, 19 Oct 2026 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426294;
	bh=oQNjJoZ0jTS+KSHbGjg9eb95h9U/EVZVTbkZwJqmV3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dD1XkAp183qoxCocuNxU3u77A0yLqiGa9SPUkIInHh3QyVuOs1gUY7A8f6hItDiRf
	 q/oK/2MiL6W5FWztrFM3iQV3ziy9643wTzRs82cx82Mu0sFZTF7lfe+A6ybcTtQWU0
	 ubVv1y6fPmyC5tjmZ1y9TOCg7gio7yteNrxKWnQUdwpZ2WXcskRYuru+kdIXmpZ8j7
	 0CS1+J+gZdJgyzw72X4f0IZOlPJOFHVIYXyA0uR/eG/xXfHK1WvQHe4o6ZfcLMNzoC
	 0+NUeIcGy3pZUXsVcFxX1YPtRzjJVjjqp13M3/ui/3QN4IdEnO+5GRzuR097x8JdZY
	 JPN1n+/CmL2Mw==
Message-ID: <sashiko-outbox-177831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/pixel: Link format helpers into
 drm_pixel_helper.ko
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev, virtualization@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019154612.777074-3-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:11:33 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm: undefined drm_format_conv_state_*() references in drm_kms_help=
er
- [Low] drm/sitronix: missing DRM_PIXEL_HELPER select in config DRM_ST7920
--

commit 5297070737eb21b200d62be5b5e13861b6e29b57
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/pixel: Link format helpers into drm_pixel_helper.ko

This commit moves drm_format_helper.o from drm_kms_helper.ko into
drm_pixel_helper.ko and updates drivers using format helpers to select
DRM_PIXEL_HELPER and include <drm/drm_format_helper.h>.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 5f555a2c1a4c8..fbc643747110f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) +=3D drm_p=
anel_orientation_quirks.o
>  obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) +=3D drm_panel_backlight_quirks=
.o
> =20
>  drm_pixel_helper-y :=3D \
> +	drm_format_helper.o \
>  	drm_pixel_helper_common.o
>  obj-$(CONFIG_DRM_PIXEL_HELPER) +=3D drm_pixel_helper.o
> =20
> @@ -150,7 +151,6 @@ drm_kms_helper-y :=3D \
>  	drm_crtc_helper.o \
>  	drm_damage_helper.o \
>  	drm_flip_work.o \
> -	drm_format_helper.o \
>  	drm_gem_atomic_helper.o \
>  	drm_gem_framebuffer_helper.o \
>  	drm_kms_helper_common.o \

[Severity: Low]
Will moving drm_format_helper.o to drm_pixel_helper-y while leaving
drm_gem_atomic_helper.o in drm_kms_helper-y cause undefined symbol referenc=
es
when CONFIG_DRM_KMS_HELPER is enabled without CONFIG_DRM_PIXEL_HELPER (or w=
hen
CONFIG_DRM_KMS_HELPER=3Dy and CONFIG_DRM_PIXEL_HELPER=3Dm)?

In drivers/gpu/drm/drm_gem_atomic_helper.c, the shadow plane helpers call
functions defined in drivers/gpu/drm/drm_format_helper.c:

drivers/gpu/drm/drm_gem_atomic_helper.c:
__drm_gem_shadow_plane_state_init()
	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);

__drm_gem_duplicate_shadow_plane_state()
	drm_format_conv_state_copy(&new_shadow_plane_state->fmtcnv_state,
				   &shadow_plane_state->fmtcnv_state);

__drm_gem_destroy_shadow_plane_state()
	drm_format_conv_state_release(&shadow_plane_state->fmtcnv_state);
	__drm_atomic_helper_plane_destroy_state(&shadow_plane_state->base);

Because config DRM_KMS_HELPER in drivers/gpu/drm/Kconfig does not select
DRM_PIXEL_HELPER, linking drm_kms_helper fails with undefined references to
drm_format_conv_state_init(), drm_format_conv_state_copy(), and
drm_format_conv_state_release().

[ ... ]

> diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/=
Kconfig
> index 41a428ef8295e..c4b54f4f4f69a 100644
> --- a/drivers/gpu/drm/sitronix/Kconfig
> +++ b/drivers/gpu/drm/sitronix/Kconfig
> @@ -4,6 +4,7 @@ config DRM_ST7571
>  	select DRM_CLIENT_SELECTION
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_KMS_HELPER
> +	select DRM_PIXEL_HELPER
>  	select VIDEOMODE_HELPERS
>  	help
>  	  Sitronix ST7571 is a driver and controller for 4-level gray
> @@ -46,6 +47,7 @@ config DRM_ST7586
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_MIPI_DBI
> +	select DRM_PIXEL_HELPER
>  	help
>  	  DRM driver for the following Sitronix ST7586 panels:
>  	  * LEGO MINDSTORMS EV3

[Severity: Low]
Should config DRM_ST7920 in drivers/gpu/drm/sitronix/Kconfig also select
DRM_PIXEL_HELPER (and include <drm/drm_format_helper.h> in
drivers/gpu/drm/sitronix/st7920.c)?

In drivers/gpu/drm/sitronix/st7920.c, the driver calls format helpers
directly:

st7920_fb_blit_rect()
	iosys_map_set_vaddr(&dst, buf);
	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);

st7920_primary_plane_atomic_check()
	/* format conversion necessary; reserve buffer */
	buf =3D drm_format_conv_state_reserve(&shadow_plane_state->fmtcnv_state,
					    pitch, GFP_KERNEL);

Without selecting DRM_PIXEL_HELPER in DRM_ST7920, building st7920 when
CONFIG_DRM_PIXEL_HELPER is disabled (or when CONFIG_DRM_ST7920=3Dy and
CONFIG_DRM_PIXEL_HELPER=3Dm) fails with undefined references to
drm_fb_xrgb8888_to_mono() and drm_format_conv_state_reserve().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154612.7770=
74-1-tzimmermann@suse.de?part=3D2
