Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E534746B2;
	Tue, 18 Aug 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059125; cv=none; b=Nq3IQPUUUBMn2Yoe6LQKsZNKHxjo09gNmKiBKOeWfL3aQEKNZCF2+4XTYLmYSCxdp9Z/3756CM4M5RrGtZK71djbiPdERXL2CrLGQ2wbvinN7a5NfP7KvBo5D2rAmnfp3XfedDyi8AU0ydg2b70PJJ64pGLcBivUs5UyFNZRgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059125; c=relaxed/simple;
	bh=V0KvKAaALzAzdlZOKWHnb/PeXq0/QTUnWiijtxWIaPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LsId1BmBBHO900vrTnKeU1TDUv5NEU6cHJQHWqoYSfewkL8qwfXYu1lB/lc9gDGJ3BbP+kuavTdYPkhDb7C17SZ9zsfSD2UmZP8ODRkfDs8yytz850sG557YWJjLWGu7Hck8PunFZ1K5Fh7IjUlA9HgNH58dyctcXqzIsGkpr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZYhNISJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZYhNISJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7D31F000E9;
	Tue, 18 Aug 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059120;
	bh=1YsFc/jON1QKIBiB/iplM0X292IHdaWnlNvP20uJoRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZYhNISJCW858ASXypFFbMTvVgQcbMbFi2jTyBXgRJsU+XfeQakwoCDIDvtw8GvPQ
	 mTlXBeRurTmQp12S6Qh+qITDAd6iXftLdJuL9EdLd1C8TkLMMvEpS/WAWyJFSwpWKY
	 jfWNTSfjcBRsv7vuYO078fVkl1H3w2jztm0G9KeQ99sarHN+J9lNkHt3XohMsZP2XE
	 ymMMQlqhGFkb46BZ6vVSVgI42mhMIZNAK5PmtnNc8nbkwFJlXbBhlXBasm6ZuGo/6g
	 i99IGcT8RUuc0cVi3n2wGAI/dKO/IosMzJlVKtCORc7c3koP+S6/tdCFMEjaxONBD+
	 +kRVijnWteO6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] drm/panic: Compile KUnit tests as module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260818125012.468092-13-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:18:39 +0000
Message-Id: <20260818131840.0E7D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Mismatched parameter order between declaration and definition fo=
r `drm_panic_helper_draw_screen_qr_code`.
- [Low] Unmet direct dependency warning when DRM_PANIC_HELPER is selected w=
ithout DRM_TTM.
- [Low] Missing indirect dependencies on DRM_DRAW and FONT_SUPPORT leading =
to linker errors.
--

--- Patch [12]: [PATCH 12/12] drm/panic: Compile KUnit tests as module ---
commit a56a5f0ffd0c185768aecc54426d672e40b1b0ae
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Compile KUnit tests as module

Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=3Dy
and make them build as a module. Export the necessary interfaces from the
panic helpers iff the KUnit framework has been enabled.

> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1f4c98cbf0906..b909cd0a619fe 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -69,6 +69,7 @@ config DRM_KUNIT_TEST
>  	select DRM_EXPORT_FOR_TESTS if m
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_KUNIT_TEST_HELPERS
> +	select DRM_PANIC_HELPER

[Severity: Low]
When DRM_KUNIT_TEST is enabled on a configuration where DRM_TTM is disabled,
does this cause an unmet direct dependency warning? DRM_PANIC_HELPER has a
depends on DRM_TTM requirement in drivers/gpu/drm/Kconfig.

Also, does selecting DRM_PANIC_HELPER without ensuring DRM_DRAW and
FONT_SUPPORT are available cause linker errors?=20

The drm_panic_helper.c file unconditionally calls functions from the DRM
draw library (drm_draw_color_from_xrgb8888) and the font library
(get_default_font). Normally, DRM_PANIC selects DRM_DRAW and FONT_SUPPORT,
ensuring these symbols are available, but selecting DRM_PANIC_HELPER
directly bypasses these.

[ ... ]

> diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helpe=
r.h
> index 6dc63288bc2ab..76ff3a83e07b7 100644
> --- a/include/drm/drm_panic_helper.h
> +++ b/include/drm/drm_panic_helper.h
[ ... ]
> @@ -15,6 +16,13 @@ void drm_plane_helper_display_panic_screen(struct drm_=
plane *plane,
>  					   enum drm_panic_type panic_type,
>  					   u32 fg_color, u32 bg_color,
>  					   unsigned int qr_version);
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb, u32=
 fg_color, u32 bg_color);
> +int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb, u32=
 fg_color, u32 bg_color);
> +int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb, =
unsigned int qr_version,
> +					 u32 fg_color, u32 bg_color);

[Severity: Medium]
Does this prototype match the definition in
drivers/gpu/drm/drm_panic_helper.c?

Here it is declared as:
int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
                                         unsigned int qr_version,
                                         u32 fg_color,
                                         u32 bg_color);

But the implementation is defined as:
VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_qr_code(
                                         struct drm_scanout_buffer *sb,
                                         u32 fg_color,
                                         u32 bg_color,
                                         unsigned int qr_version)

Because u32 and unsigned int are functionally equivalent types, the compiler
silently accepts this mismatch without any warnings. Will any caller
relying on the header's parameter order inadvertently swap the qr_version
and fg_color arguments, causing the function to fail with -ENOSPC or render
with corrupted colors?

> +void drm_panic_helper_set_description(const char *description);
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D12
