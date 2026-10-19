Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427533;
	b=Y/xLsWw4NLcQsiomS1ygiVxFUmjoPeOb6pZg1seXdPoRwnene5OLg14y9tIYKY8y13TF
	 1awLlsZW21RpFzqfDhJFMvz5aPQJw/h7ZSsavgCBD4YkIo7aOQ59Zis+bJLylgrTjuZOQ
	 K8KejIb1EsqgHmceqjHINzQzQg1SXEYEMWVHT22RPQStR7SsdthaDZ31mkCaoa2cBknxR
	 uWdtlMiZY4M8Wk27VXIYiwRHPEoTZifR0FEu+qx4bebG4zkwa7PzX23WqmZ1mh6ZvH2zA
	 I5Mg5XSffm+Z8oYOkGdE9W2j4qdYguTmkZCGsY8T1VsfxLVreL5iE1Uc8FjyH99Flpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427533;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i255b40ZMmpIZGqcrOmg8txUse8R1k/KW0oaKIiX3bQ=;
	b=HD7iI5xxIsx9RP0Uj/BSAmCk6Y8E8YRqVxU/wcCxSNUVGI/DdTs9TY1p2hLBylqWDDkh
	 CuMeV0T49KMbbpt2tfTDlGPsNoxjzK3WP+oEFC0ZVMnfhh/qVNNYzOYloJJMSZpgsPL2H
	 u+EqMPv0Pa07ZS0b9ScRa6D1OAtM6/y3JbJu9i42zgRQNGcXzMXmruZYS06kYYVM7PJOx
	 1YyMHU3/qXhyeJ7Nt83wnwaQKrFOfJJfxfCccost5c/mkBHZeJLXzuHjNqXqObjy4/5Hs
	 Gke9fu4YJApZ8wbObR9y0YrUYdGque0O7dXZuPu6amAnlyhQPYuyf5LYL2SajE8Pkvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlvH+V41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C54606A31F;
	Mon, 19 Oct 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlvH+V41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0661F000C4;
	Mon, 19 Oct 2026 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427532;
	bh=i255b40ZMmpIZGqcrOmg8txUse8R1k/KW0oaKIiX3bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BlvH+V41S1/czwU7kzrqftcx3A5lvedV/70KmCHcuhRwytx9YxviG+nWM8sr8iVG5
	 LFUP947xQb4BGOkSBqn/GK6zoXJV1RMAHMCLF2lwopCDit09Dz20zmGjAjUKt65jR9
	 gZSCOnzHyou1MVk5ns3z21M0IKW6bkffc+7NnaO5CrTw2WZo3DhLNqoWGg2N9mpcaV
	 D9mXb+9C2DUuwBKKVXsOFrzyHIdSTuyu+JjUifepvU+c0i8m5nH1xCRkj2+nku4CqS
	 V8d89SyFNmRK3w3hejSmS9rIUGn0rs0RybaixqyR1GMqSnDyNw3O1hHYmUl3c/4v/J
	 lU1sBTmo5zVdQ==
Message-ID: <sashiko-outbox-177908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/pixel: Link draw helpers into
 drm_pixel_helper.ko
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev, virtualization@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019154612.777074-5-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:32:11 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm: missing DRM_PIXEL_HELPER dependency in DRM_KMS_HELPER
- [Medium] drm/pixel: missing DRM_PIXEL_HELPER select in DRM_ST7920, DRM_XE=
, and DRM_KMS_HELPER
- [Low] drm/pixel: stale drm_draw.c reference in MAINTAINERS after rename
- [Low] drm: drm_panic_helper.o omitted when DRM_KUNIT_TEST=3Dy and DRM_PAN=
IC=3Dn
--

commit 8f1149ac31f00f33aec39cba3d1477d5b9456a23
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/pixel: Link draw helpers into drm_pixel_helper.ko

This commit moves drm_draw.c (renamed to drm_draw_helper.c) from the DRM
core into drm_pixel_helper.ko, removes the DRM_DRAW Kconfig symbol, and
updates DRM_CLIENT_LIB to select DRM_PIXEL_HELPER when DRM_CLIENT_LOG is
enabled.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index bf7c599443403..1b16e6101a53a 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -52,15 +52,10 @@ config DRM_KMS_HELPER
>  config DRM_PIXEL_HELPER
>  	tristate
>  	depends on DRM
> -	select DRM_DRAW if DRM_PANIC
>  	select FONT_SUPPORT if DRM_PANIC
>  	help
>  	  Helpers for working with pixel data in DRM.
> =20
> -config DRM_DRAW
> -	bool
> -	depends on DRM
> -
>  config DRM_PANIC
>  	bool "Display a user-friendly message when a kernel panic occurs"
>  	depends on DRM && PRINTK

[Severity: High]
With drm_format_helper.o and drm_panic_helper.o moved from drm_kms_helper.ko
into drm_pixel_helper.ko in this series, does DRM_KMS_HELPER in
drivers/gpu/drm/Kconfig also need to select DRM_PIXEL_HELPER?

In drivers/gpu/drm/Makefile, drm_kms_helper.o unconditionally links in
drm_gem_atomic_helper.o and drm_modeset_helper.o.

In drivers/gpu/drm/drm_gem_atomic_helper.c, the shadow plane helpers call
format conversion functions that are now in drm_pixel_helper.ko:

drivers/gpu/drm/drm_gem_atomic_helper.c:__drm_gem_shadow_plane_state_init()=
 {
	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
}

Along with drm_format_conv_state_copy() in
__drm_gem_duplicate_shadow_plane_state() and
drm_format_conv_state_release() in __drm_gem_destroy_shadow_plane_state().

Similarly, in drivers/gpu/drm/drm_modeset_helper.c, primary_plane_funcs uses
DRM_PANIC_PLANE_FUNCS:

static const struct drm_plane_funcs primary_plane_funcs =3D {
	DRM_PLANE_NON_ATOMIC_FUNCS,
	DRM_PANIC_PLANE_FUNCS,
};

When CONFIG_DRM_PANIC=3Dy, DRM_PANIC_PLANE_FUNCS references
drm_plane_helper_display_panic_screen(), which is now defined in
drm_panic_helper.c inside drm_pixel_helper.ko.

Without DRM_KMS_HELPER selecting DRM_PIXEL_HELPER, won't configurations with
CONFIG_DRM_KMS_HELPER enabled and CONFIG_DRM_PIXEL_HELPER=3Dn (or
CONFIG_DRM_KMS_HELPER=3Dy and CONFIG_DRM_PIXEL_HELPER=3Dm) fail to link with
undefined references to drm_format_conv_state_init(),
drm_format_conv_state_copy(), drm_format_conv_state_release(), and
drm_plane_helper_display_panic_screen()?

[Severity: Medium]
Are there also a couple of drivers missing a select of DRM_PIXEL_HELPER
after moving the format and panic helpers into drm_pixel_helper.ko?

1. In drivers/gpu/drm/sitronix/Kconfig, DRM_ST7571 and DRM_ST7586 were
updated to select DRM_PIXEL_HELPER, but DRM_ST7920 was not:

config DRM_ST7920
	tristate "DRM support for Sitronix ST7920 LCD displays"
	depends on DRM && SPI && MMU
	select DRM_GEM_SHMEM_HELPER
	select DRM_KMS_HELPER
	select REGMAP_SPI

However, drivers/gpu/drm/sitronix/st7920.c calls drm_fb_xrgb8888_to_mono()
in st7920_fb_blit_rect() and drm_format_conv_state_reserve() in
st7920_primary_plane_atomic_check(), both of which are in
drm_format_helper.c.

2. In drivers/gpu/drm/xe/Kconfig, neither DRM_XE nor DRM_XE_DISPLAY selects
DRM_PIXEL_HELPER if DRM_PANIC (unlike DRM_I915), even though
drivers/gpu/drm/xe/Makefile compiles i915-display/skl_universal_plane.o
into xe.ko when CONFIG_DRM_XE_DISPLAY=3Dy, which uses DRM_PANIC_PLANE_FUNCS
and references drm_plane_helper_display_panic_screen().

Could these cause link failures when building DRM_ST7920 or DRM_XE without
DRM_PIXEL_HELPER enabled?

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 18a5a5baf0293..ab9eb4c212648 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -91,7 +91,6 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) +=3D \
>  	drm_privacy_screen_x86.o
>  drm-$(CONFIG_DRM_ACCEL) +=3D ../../accel/drm_accel.o
>  drm-$(CONFIG_DRM_PANIC) +=3D drm_panic.o
> -drm-$(CONFIG_DRM_DRAW) +=3D drm_draw.o
>  drm-$(CONFIG_DRM_RAS) +=3D drm_ras.o drm_ras_nl.o drm_ras_genl_family.o
>  obj-$(CONFIG_DRM)	+=3D drm.o
> =20
> @@ -100,6 +99,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) +=3D drm_pa=
nel_orientation_quirks.o
>  obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) +=3D drm_panel_backlight_quirks=
.o
> =20
>  drm_pixel_helper-y :=3D \
> +	drm_draw_helper.o \
>  	drm_format_helper.o \
>  	drm_pixel_helper_common.o
>  drm_pixel_helper-$(CONFIG_DRM_PANIC) +=3D drm_panic_helper.o

[Severity: Low]
What happens when CONFIG_DRM_KUNIT_TEST is enabled while CONFIG_DRM_PANIC=
=3Dn
(such as with the default drivers/gpu/drm/tests/.kunitconfig)?

In drivers/gpu/drm/tests/Makefile, drm_panic_helper_test.o is built
unconditionally under CONFIG_DRM_KUNIT_TEST, and
drivers/gpu/drm/tests/drm_panic_helper_test.c calls
drm_panic_helper_draw_screen_user(), drm_panic_helper_draw_screen_kmsg(),
drm_panic_helper_set_description(), and
drm_panic_helper_clear_description():

static int drm_panic_helper_draw_screen_user_default(struct drm_scanout_buf=
fer *sb)
{
	return drm_panic_helper_draw_screen_user(sb, 0x00ffffff, 0x00000000);
}

Previously, DRM_KUNIT_TEST selected DRM_PANIC_HELPER, which built
drm_panic_helper.o and selected FONT_SUPPORT even when CONFIG_DRM_PANIC=3Dn.

Now that DRM_KUNIT_TEST in drivers/gpu/drm/Kconfig.debug selects
DRM_PIXEL_HELPER instead of DRM_PANIC_HELPER, and drm_panic_helper.o is only
compiled into drm_pixel_helper when CONFIG_DRM_PANIC is enabled (and
DRM_PIXEL_HELPER only selects FONT_SUPPORT if DRM_PANIC), won't building
DRM_KUNIT_TEST with CONFIG_DRM_PANIC=3Dn fail at link time with undefined
references to the drm_panic_helper_* functions?

[ ... ]

> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw_helper=
.c
> similarity index 100%
> rename from drivers/gpu/drm/drm_draw.c
> rename to drivers/gpu/drm/drm_draw_helper.c

[Severity: Low]
Should theDRM PANIC entry in MAINTAINERS also be updated to reflect the
rename from drivers/gpu/drm/drm_draw.c to drivers/gpu/drm/drm_draw_helper.c?

DRM PANIC
M:	Jocelyn Falempe <jfalempe@redhat.com>
M:	Javier Martinez Canillas <javierm@redhat.com>
L:	dri-devel@lists.freedesktop.org
S:	Supported
T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
F:	drivers/gpu/drm/drm_draw.c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154612.7770=
74-1-tzimmermann@suse.de?part=3D4
