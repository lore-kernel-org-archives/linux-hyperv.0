Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFB476CF7;
	Tue, 18 Aug 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059193; cv=none; b=D9wP2HVm1wHuzPoHH0F0nx2k7xNTRY7OdJe0CoSFg3B8pNStIOLFEssnYL/UB4JO240wZ527WvfdvqtDh/BNovTvT0z4OpZ++t0Sh0d/dCEzxzIHqUvh1F7hETTBbEiu6EZDK5DvtC9zfasHN/SHjZgRn5O9bXOJ7Wz7M4BaasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059193; c=relaxed/simple;
	bh=LardJLtvgMMd88PaBykTDx4ZDBlHi3Mu9DimlXZKKzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GH6eIx1ZC83EV+o2/pIEEE1F3RF6Dgnhy+CHKHLD1U95tQU/yMDdFZfomYUcVtVB3W6FO8b7yVxOgSDycmMjoW5HGH7jxcK/l+o90/NSErNafG66+jFLHfQZoJxzCO9ROuWDDqaD9nmwPNckqsDSR1CN263el62hGn1DV632Se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYEG/X31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYEG/X31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154171F000E9;
	Tue, 18 Aug 2026 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059191;
	bh=3OECFuID8OxfFZMZwe/XajbxGBf8JR2K20Q4oEs4U2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYEG/X31bZkTUQFI/ZpxOc2kan1QWVtxrh8pRMcEKKxEG32Ud3uvggwqHRfvjYipm
	 vyJDRpeEQSrB3LihrjglGHNt778bsqo0PP9vPAUdM7c7ut8HDxnau/mJUCRFPsNUS3
	 NSbO/U9cjvPYhk6x4N2/isU4wprCXu504BHpXvWhRZXrzQqZXeo7wq++3ZxfWpMs3W
	 7LQjyOhhNlptBUsB/BMWl6Fz5MbqEvboVxmJ9Z3fmm2ZkO5cnRVyF7h7WC5Zvl99/Y
	 l1KWJrRllm7SLJ7hksJQ9DS3InFWwMaS5y12PvO4REt0EXDkN4+wN+KCELfaO0OCcm
	 jrD80Qb/eKJ4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] drm/panic: Display panic screen via per-plane
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org
In-Reply-To: <20260818125012.468092-10-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:19:50 +0000
Message-Id: <20260818131951.154171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `drm_plane_helper_display_panic_screen` helper unconditionally=
 dereferences `plane->helper_private` and `plane->helper_private->get_scano=
ut_buffer`. However, by adding `DRM_PANIC_PLANE_FUNCS` to shared plane func=
tion tables (like `skl_plane_funcs` in i915 and `dm_plane_funcs` in amdgpu)=
, the `display_panic_screen` callback is now applied to all planes (includi=
ng cursors and overlays). These non-primary planes use different helper fun=
ctions (e.g., `intel_plane_helper_funcs` or `dm_plane_helper_funcs`) that d=
o not implement `get_scanout_buffer`. This causes `drm_panic_register` to m=
istakenly register panic dumpers for these planes, and upon a panic, the ha=
ndler executes a NULL pointer dereference, triggering a nested panic.
- [Medium] The patch replaces `get_scanout_buffer` with `display_panic_scre=
en` as the signal for panic support. However, it fails to add `DRM_PANIC_PL=
ANE_FUNCS` to the legacy fallback `primary_plane_funcs` in `drm_modeset_hel=
per.c`. Older AMDGPU DCE drivers (e.g., DCE 6.0, 8.0, 10.0) use `drm_crtc_i=
nit()` which implicitly relies on this legacy structure for their primary p=
lanes. Although these drivers implement `get_scanout_buffer` in their helpe=
r functions (`dce_v10_0_drm_primary_plane_helper_funcs`), their planes now =
lack the `display_panic_screen` callback. Consequently, `drm_panic_is_enabl=
ed()` returns false and their panic dumpers are never registered, silently =
breaking panic screen support on these hardware generations.
- [Low] `drm_plane_helper_display_panic_screen` accepts a `panic_type` para=
meter (an `enum drm_panic_type`). However, when it calls `draw_panic_dispat=
ch()`, it passes the global module parameter `drm_panic_type` instead of th=
e passed-in `panic_type`. This logic bug prevents drivers from tailoring th=
e panic screen implementation via the helper as intended.
--

--- Patch [9]: [PATCH 09/12] drm/panic: Display panic screen via per-plane =
callback ---
commit 69fa8c39afc844867e193df3659c6f6f1fb762f3
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Display panic screen via per-plane callback

This commit adds display_panic_screen to struct drm_plane_funcs to replace
get_scanout_buffer as the signal for panic support. It provides the helper
drm_plane_helper_display_panic_screen() and the DRM_PANIC_PLANE_FUNCS macro
to update drivers that implement panic support.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 824ef3ce5de0a..eadc22a255bb5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
[ ... ]
> @@ -2177,6 +2178,7 @@ static const struct drm_plane_funcs dm_plane_funcs =
=3D {
>  	.atomic_set_property =3D dm_atomic_plane_set_property,
>  	.atomic_get_property =3D dm_atomic_plane_get_property,
>  #endif
> +	DRM_PANIC_PLANE_FUNCS,
>  };

[Severity: High]
Does adding this macro to shared plane function tables (like dm_plane_funcs
or skl_plane_funcs) apply the panic screen callback to all planes, including
cursors and overlays?

Non-primary planes use different helper functions that do not implement
get_scanout_buffer. Since drm_plane_helper_display_panic_screen()
unconditionally dereferences plane->helper_private->get_scanout_buffer,
could this cause a NULL pointer dereference in the panic handler for these
planes and trigger a nested panic?

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 2263a11efdf63..2ecb4d1f6d470 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> +void drm_plane_helper_display_panic_screen(struct drm_plane *plane, cons=
t char *description,
> +					   enum drm_panic_type panic_type,
> +					   u32 fg_color, u32 bg_color, unsigned int qr_version)
>  {
>  	struct drm_scanout_buffer sb =3D { };
>  	int ret;

[Severity: Low]
Is the panic_type parameter correctly passed to the dispatch function?

The function accepts a panic_type argument, but the implementation appears
to pass the global module parameter drm_panic_type to draw_panic_dispatch()
instead of the passed-in argument. Does this discard the caller's requested
panic type?

> diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helpe=
r.h
> new file mode 100644
> index 0000000000000..e296620bbe34b
> --- /dev/null
> +++ b/include/drm/drm_panic_helper.h
[ ... ]
> +#if IS_ENABLED(CONFIG_DRM_PANIC)
> +#define DRM_PANIC_PLANE_FUNCS \
> +	.display_panic_screen =3D drm_plane_helper_display_panic_screen
> +#else
> +#define DRM_PANIC_PLANE_FUNCS \
> +	.display_panic_screen =3D NULL
> +#endif

[Severity: Medium]
Does the legacy fallback primary_plane_funcs in drm_modeset_helper.c also
need to be updated with DRM_PANIC_PLANE_FUNCS?

Older AMDGPU DCE drivers use drm_crtc_init(), which implicitly relies on
this legacy structure for their primary planes. Although these drivers
implement get_scanout_buffer() in their helper functions, lacking this
macro in the fallback could cause drm_panic_is_enabled() to return false
and silently drop panic screen support on these hardware generations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D9
