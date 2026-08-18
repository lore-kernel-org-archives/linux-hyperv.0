Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764A381E95;
	Tue, 18 Aug 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058875; cv=none; b=DwPijbPopjAFhekPo87dRVS0+uTNsCe0rJkgNYiIu3UlWn2edwA34AI2MTVoImpz8q5H9jtPHMza2CEyg7UXRKg739RIrCtVIsE9HavfuzWGyjWpOEUb3r+4fxdgNAKG1vHTGh5ZZshLLUX7blYeqYVEjyJh3XrZewOrixwSnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058875; c=relaxed/simple;
	bh=5eIoxm3oMAnGqIyXr0NQt68QEn5deuCrgpEAHFDr2Mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hpEj5/o2o42030f70SDGTyruxgLe7FAZJ2FvWrc+nYRmKjLvaEa7KFMKYRqWRd7TXuTO3LQEPOYnj28cERGjqQJ2p/mjmJw8ID68/L2kIssHPu4PifUuJsTVdoEpbkswlRPSva5xZZzHd9DUeQHyxhoFJXJa4h+IZVkefpvp5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiYITZN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiYITZN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D81F000E9;
	Tue, 18 Aug 2026 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058874;
	bh=68omMfCG5mbL7V/GOyvx1RxscX9zZ42gvdnnCjUNDQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiYITZN/XFwPH29BJZ+COnDOeYhStA68yulDACFO5baeL+e8P513puHzN0cORR++U
	 d2i9+DVD+7JIpHJyuaxkchS+ZPX3aeEcJisdhQvE5X9hh1SkpQjU1ZyOj1TCFO0b3B
	 aUWTl7lK9rHdFtrxQjlMmT34PkJnxoxntxao4p8ITP+lOXUPAcIKl1FumXQmkwTlMn
	 jigJ1qyuYLYYbAkQYvYaGQxkngkFxThn1Cpkf44zCJmNEN63Kuthe/kQxhrusyibZS
	 qBQWNpRX99wlTYhNBNy+aGi8IJ3anw3f9IyTS8oOpd8VO19hHXXbMYq5R/STkfU+T2
	 Hl55KeW74B5eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] drm/panic: Split draw_panic_plane()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, ojeda@kernel.org, imx@lists.linux.dev, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260818125012.468092-9-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:14:33 +0000
Message-Id: <20260818131433.8A3D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `panic_type` parameter in `draw_panic_plane()` is ignored an=
d shadowed by the global `drm_panic_type` variable.

Pre-existing issues:
- [High] Data race on global variables (`panic_msg`, `qrbuf1`, `qrbuf2`, `s=
tream`) when triggering panic debugfs interface concurrently across multipl=
e DRM devices.
--

--- Patch [8]: [PATCH 08/12] drm/panic: Split draw_panic_plane() ---
commit 87af97baf7c5108af8275ef63007ab9f483466ca
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Split draw_panic_plane()
   =20
Move locking and parameters from draw_panic_plane() into the new
helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
there. The new helper is now the DRM core's interface for displaying a
panic screen.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 0960750bfce25..2263a11efdf63 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -940,38 +940,21 @@ static void drm_panic_clear_description(void)
>  	desc_line->txt =3D NULL;
>  }
> =20
> -static void draw_panic_plane(struct drm_plane *plane, const char *descri=
ption)
> +static void draw_panic_plane(struct drm_plane *plane, const char *descri=
ption,
> +			     enum drm_panic_type panic_type, u32 fg_color, u32 bg_color,
> +			     unsigned int qr_version)
>  {

[Severity: Medium]
Does this function ignore the new panic_type parameter?

The parameter is passed to draw_panic_plane(), but if the code still uses t=
he
global drm_panic_type variable internally when calling draw_panic_dispatch(=
):

	ret =3D draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_ve=
rsion);

Any caller passing a specific panic_type will have its request overridden by
the global module parameter, which seems to break the intent of making this=
 a
generic helper.

[ ... ]

> @@ -1021,7 +1027,7 @@ static ssize_t debugfs_trigger_write(struct file *f=
ile, const char __user *user_
>  	if (kstrtobool_from_user(user_buf, count, &run) =3D=3D 0 && run) {
>  		struct drm_plane *plane =3D file->private_data;
> =20
> -		draw_panic_plane(plane, "Test from debugfs");
> +		drm_panic_display_panic_screen(plane, "Test from debugfs");

[Severity: High]
This is a pre-existing issue, but does this debugfs entry point allow a data
race on global variables across different DRM devices?

When a user writes concurrently to the debugfs files of two or more distinct
DRM devices, the debugfs_trigger_write() handler acquires a per-device lock
via drm_panic_trylock().

However, these concurrent writes can proceed to mutate the unprotected glob=
al
panic_msg array in drm_panic_set_description():

	struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1];
	desc_line->txt =3D description;

This could also affect other globals like qrbuf1, qrbuf2, and the zlib
stream workspace.

Could this concurrent execution across different DRM devices corrupt memory
and lead to an inconsistent state?

>  	}
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D8
