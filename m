Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426752;
	b=QOAf9JMhxCQm+AHCdolSb+VyX6hhAYcrdxnoHlICEAdQGHR/rEncXUYD7scP9bgESIrP
	 l9Ra89WjofzfWaiQVefbaXtVlQMwmwB21JCOh1g9zGTWDH6xlrcJhGt7NXvktwadiC+M/
	 Ct8Nqss7cbes+shUoTd+CFx0uL1Wow+9kv22Ty20UwygXr0EhCQqlhf34r6i7GcZJ6x/W
	 8pnvdWzi2yzMyy2L3KOxdisu0HYt8lN62k4VFuEzEvncQJC3U3Q70PtnczAqExIbwSJRJ
	 lMKDLEn0wyBJ3FYTwIjeLB5wUwY7oFC3BhPqkj8aPHvok52h4BPgLu6+O/5QP+bY5gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426752;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=shs0Qmr6z6AGWxamqP5HMy0NMX1ySVsqh6zsSxOLyLY=;
	b=HnY2NMbVwFi7iERBWtnE/MwIWox1j1OVlzevDf2l7HiwEdYxW6JD7YCI6yPbtQD6eUqm
	 svqIXC6TQBJ8v7hgf9DUe72t1vo078HRtb6HIyRdQSYQ4zw/48T6uy5AiYO0miUXY1dkg
	 1Doef41oeJ9ofpS5J5K/j1tyPqpdxvcctiRQxlnI1zrmb/TpOyEftKCNRCYfBN14Kxg29
	 Di6GnJLfpo6SusAw+zeFcM+k3FrM77MPVDqWu/IFOs3Vkjn5fz5wv1QD/xOEr84o3sWmw
	 rJqeG+9iS24i2GISSkOLKW9r+uTArraqrvMLE/++vBsFMzFaMUg0t2kxNqlzzLqImXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWt0QnFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8D606A31D;
	Mon, 19 Oct 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWt0QnFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDBD1F000C4;
	Mon, 19 Oct 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426751;
	bh=shs0Qmr6z6AGWxamqP5HMy0NMX1ySVsqh6zsSxOLyLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWt0QnFZNI3EIMza9ej8C2XFXq0Bh+XrlgnxAk+iTSlyQDk4Ecog4QtlmCZQ7PZlW
	 e/NOAlfmbJNhykwDYH3NKSwAbws9HhRirr+ByZFXLD1sWvtRaSNlDGlxCOl8RFnyzY
	 4Rszg8nxJzHRmhZrq72h3ISetFpZZtkKkdK1W484tIRh9nQ02Eg6LG6qEQqkBgiVB0
	 N5Pri0Jsx37ybixtg3R3V4BFgCMmIgAx80ifX7ZXfpeXaWSMr8qQq+z0VhWoMxJhXl
	 HOANibuXJNJQPjgZgwQXvcndbTYsC0hPVR+LMxEuuB4onPQlr1QmfVZn/Dnmnhpz++
	 fgumzsZN9NMgw==
Message-ID: <sashiko-outbox-177862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/pixel: Link panic helpers into
 drm_pixel_helper.ko
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev, virtualization@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019154612.777074-4-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:19:10 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] drm: missing DRM_PIXEL_HELPER select in DRM_KMS_HELPER for drm_crtc=
_init()
- [Low] drm/tests: link failure in drm_panic_helper_test when CONFIG_DRM_PA=
NIC=3Dn
- [Low] drm/xe: missing DRM_PIXEL_HELPER dependency when DRM_PANIC=3Dy
--

commit d010f0f67d242682650aa0651dfd5a1e57612943
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/pixel: Link panic helpers into drm_pixel_helper.ko

This commit moves the DRM panic helpers from drm_kms_helper into
drm_pixel_helper.ko, drops the DRM_PANIC_HELPER Kconfig option, and
selects DRM_PIXEL_HELPER in drivers using the panic helpers.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 8e4a588e9111d..bf7c599443403 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -46,13 +46,14 @@ config DRM_MIPI_DSI
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> -	select DRM_PANIC_HELPER if DRM_PANIC
>  	help
>  	  CRTC helpers for KMS drivers.

[Severity: Low]
Does DRM_KMS_HELPER also need to select DRM_PIXEL_HELPER if DRM_PANIC?

drivers/gpu/drm/drm_modeset_helper.c is unconditionally compiled into
drm_kms_helper, and its primary_plane_funcs structure (used by
drm_crtc_init()) includes DRM_PANIC_PLANE_FUNCS:

drivers/gpu/drm/drm_modeset_helper.c:
    static const struct drm_plane_funcs primary_plane_funcs =3D {
            DRM_PLANE_NON_ATOMIC_FUNCS,
            DRM_PANIC_PLANE_FUNCS,
    };

When CONFIG_DRM_PANIC is enabled, DRM_PANIC_PLANE_FUNCS expands in
include/drm/drm_panic_helper.h to reference
drm_plane_helper_display_panic_screen, which is now built into
drm_pixel_helper. If CONFIG_DRM_PANIC=3Dy and DRM_KMS_HELPER is enabled
without a matching built-in or modular DRM_PIXEL_HELPER, linking fails
with an undefined reference to drm_plane_helper_display_panic_screen.

[ ... ]

> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1afb9cad850f6..4573cad368a28 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -69,7 +69,6 @@ config DRM_KUNIT_TEST
>  	select DRM_EXPORT_FOR_TESTS if m
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_KUNIT_TEST_HELPERS
> -	select DRM_PANIC_HELPER
>  	select DRM_PIXEL_HELPER
>  	select DRM_SYSFB_HELPER
>  	select PRIME_NUMBERS

[Severity: Low]
Can removing select DRM_PANIC_HELPER from DRM_KUNIT_TEST cause a link
failure when CONFIG_DRM_PANIC is disabled?

With this change, drm_panic_helper.o is only built into drm_pixel_helper
when CONFIG_DRM_PANIC is enabled:

drivers/gpu/drm/Makefile:
    drm_pixel_helper-$(CONFIG_DRM_PANIC) +=3D drm_panic_helper.o

However, drivers/gpu/drm/tests/Makefile still builds
drm_panic_helper_test.o unconditionally under obj-$(CONFIG_DRM_KUNIT_TEST),
and functions such as drm_panic_helper_draw_screen_user_default() in
drivers/gpu/drm/tests/drm_panic_helper_test.c call
drm_panic_helper_draw_screen_user(), drm_panic_helper_draw_screen_kmsg(),
drm_panic_helper_set_description(), and
drm_panic_helper_clear_description(). When CONFIG_DRM_KUNIT_TEST is enabled
and CONFIG_DRM_PANIC=3Dn, linking fails with undefined references to those
symbols.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 71426b9c91f00..f698d3c8daa9e 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -19,6 +19,7 @@ config DRM_I915
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL
>  	select DRM_MIPI_DSI
> +	select DRM_PIXEL_HELPER if DRM_PANIC
>  	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
>  	select RELAY
>  	select I2C

[Severity: Low]
Should DRM_XE or DRM_XE_DISPLAY in drivers/gpu/drm/xe/Kconfig also select
DRM_PIXEL_HELPER if DRM_PANIC?

When CONFIG_DRM_XE_DISPLAY=3Dy, drivers/gpu/drm/xe/Makefile compiles
drivers/gpu/drm/i915/display/skl_universal_plane.c into xe.ko, where
skl_plane_funcs, icl_plane_funcs, and tgl_plane_funcs use
DRM_PANIC_PLANE_FUNCS:

drivers/gpu/drm/i915/display/skl_universal_plane.c:
    static const struct drm_plane_funcs skl_plane_funcs =3D {
            ...
            DRM_PANIC_PLANE_FUNCS,
    };

If CONFIG_DRM_XE=3Dm, CONFIG_DRM_XE_DISPLAY=3Dy, and CONFIG_DRM_PANIC=3Dy a=
re
enabled while CONFIG_DRM_PIXEL_HELPER=3Dn, modpost fails with an undefined
reference to drm_plane_helper_display_panic_screen in xe.ko.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154612.7770=
74-1-tzimmermann@suse.de?part=3D3
