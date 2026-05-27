Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CB3783B0
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895186; cv=none; b=dHX+KpfLwN3fWgcuhooHIGsc1OEqmBvib4RDmomxgzAisG9TsIQmD5OGQCewjuKPkBZ42F15gohGVjfVCmLEIHmR7R5EF5P4xgDeH8/DiA+45pkaMStvzOQUR6V9aAkd7Z/JlitoB8HO1ZEMJ2W7Wrh/d0BidyehHPzCkoAYg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895186; c=relaxed/simple;
	bh=ExP7urhBB5NpwWuh2hZ/r79w/L/gqvMVB7wr/jPydEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiepRsyO1k6F+MTepu3UaLrXyv5LIL9RK5o6TsrnUxU0SRZsHOpBTKICAmQFjbG74hQftEt9b4ThjC/Rojj5qM3roO89/qI5sO/KGOCyHZzE+BTJWNce8/hk9H4n04ihs8i/fpwAdMfdIW1Y+CP7XkIJTE09Ow+/Nc9NxDyffQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI6gRWhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI6gRWhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29571F000E9;
	Wed, 27 May 2026 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895185;
	bh=svcRO09znkxB0yqv96Pr7HpZMl1NwsQLzOIA6ztD7B0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JI6gRWhWqF6DO01t03VbTF3HsV/eX0/ldXcyn5n7IZO2+uzS6zJISOmyA0DSvxVyY
	 5ASVm6PM8jEJGIL5MwBQXC9P/CazTtPu44zbAdM9DH9NpXUO9sJf5UsYOjzpIqaB0v
	 F2V0rJaouOOJ3Sjxt8Hc94Wh90UGhkfGZYUAhR9QrCcKq87QndSA9mMCI6zQ0oF3jl
	 mXKOjMK8LKEyL+2kF6aPCxTXncXOvc1q+B5Uh1WFRWBY/U1Y6GM8/arTKFN3MXA/8Y
	 sqT8Nnw5a0xf0Xt8BstUHIG6O81Fwo89h465ascGzNEyTXpTctRybvHWmuLYZabaOZ
	 98rq/y0OlxrvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] drm/damage-helper: Do not alter damage clips
 on modeset, but ignore them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260527145113.241595-2-tzimmermann@suse.de>
References: <20260527145113.241595-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:19:44 +0000
Message-Id: <20260527151944.F29571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Retaining damage clips during modesets causes drivers that directl=
y access damage clips to incorrectly perform partial screen updates instead=
 of full screen updates.
--

commit 36f89d2b464094389bd2dab30c24b79223ef7bd1
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/damage-helper: Do not alter damage clips on modeset, but ignore them

This commit modifies the plane damage check to retain damage clips during
a full modeset. Instead of explicitly clearing the clips, it sets a new
ignore_damage_clips flag which is then checked by the damage iterator.

> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_da=
mage_helper.c
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_a=
tomic_commit *state,
>  		if (WARN_ON(!crtc_state))
>  			return;
> =20
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			drm_property_blob_put(plane_state->fb_damage_clips);
> -			plane_state->fb_damage_clips =3D NULL;
> -		}
> +		if (drm_atomic_crtc_needs_modeset(crtc_state))
> +			plane_state->ignore_damage_clips =3D true;
>  	}
>  }

[Severity: High]
By no longer setting plane_state->fb_damage_clips to NULL during a modeset,
will this break drivers that bypass the damage iterator?

Drivers like AMDGPU (in fill_dc_dirty_rects) and vmwgfx directly call
drm_plane_get_damage_clips_count() and drm_plane_get_damage_clips().
Because these accessor functions do not check the new ignore_damage_clips f=
lag,
won't they see a non-zero clip count if userspace provided one?

If they see a non-zero clip count during a modeset, will they incorrectly
skip their fallback paths and perform a partial update instead of the
required full framebuffer update?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527145113.2415=
95-1-tzimmermann@suse.de?part=3D1
