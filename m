Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFB2C9D;
	Mon, 24 Aug 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577681; cv=none; b=Bfxwvn4TPmy2a9fRZpKAsclJ0APQ3Df+Y3kb8zVUM9iWH3qWAFRsF1KY8rLas1z/eKtaSy2sEk9weIz3SYPo/TmT+Ba+HD7VgS5wifgH3tu2cLfot222nrWkailigl1NHRDtnCB5Xj+p17xfR5cgNf2f3edggpQU1o0SNFPSgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577681; c=relaxed/simple;
	bh=PNtSKVSUXLlUo7MPNhnGWaeTqFeekLZ+xnHo0kdhbXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4zqgtCxenGpOjYbpczBkQDGzJfeh+9VpNS+fhNXyP0eM0TEzMain2Reh/gPwHa4Fp9oMtuHpL7/QlfLcvlcc94gYPq7IJrbOxRVHv0ZAlftXXy4qbzubyzQcJ/A3f1T9kf8vwTkC5hGEB3O5G5dKPLAGWi0y2hso5fmtEJZUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7eZ+srk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7eZ+srk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0027B1F000E9;
	Mon, 24 Aug 2026 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577679;
	bh=tqQWdU7qIu7z80Vg+ML+5cNSrgns2KDCFHdeeAvGBcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7eZ+srkEa6Mjjhy159+Dlxi9kUsa8zInzcYaa9ZfJ4kJ6C6bmwFKCqwfFKwBCLkI
	 hqdiYLhjcWzRuyGQRwVUa1+6K/t31eXHV84x1HeVy2HVW7VxOPIjAdJTpEzN2HMzTv
	 R2XzFKijKlzLAWUIjp3909DA46jPjHP8gSQZWEBJgyBpdtwg56c8/bCdvRk6plNfYz
	 QIQsn/oo6kO76R+JRXmBB0XZgxD5mszoYvhKAImi3NFRvmlBdP5TH8ygRF3NZtiDFa
	 7LaCJTzLecy+s1SY87VGHwqkpkx4NEUvOui9SsgoYbkwJUp7NtSLjOcGxihe6HObLR
	 sJrmlVyhrl+Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] drm/panic: Retry in dispatch function if panic
 output fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260824125201.218863-8-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:21:18 +0000
Message-Id: <20260824132119.0027B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message claims a change that is not present in the co=
de diff.
- [Medium] Fallback to user mode silently flushes a blank screen if the scr=
een is narrower than a single character, defeating failure preservation.
--

--- Patch [7]: [PATCH v2 07/13] drm/panic: Retry in dispatch function if pa=
nic output fails ---
commit 43648cf544bdeed6f6c85be5e74f3e855c778814
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Retry in dispatch function if panic output fails

This patch introduces explicit fallback to DRM_PANIC_TYPE_USER in
drm_panic_dispatch() when QR code or kmsg outputs fail. It also increases t=
he
minimum QR code test size to 494x494.

> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

[Severity: Medium]
This isn't a bug, but the commit message mentions passing drm_panic_type as=
 a
parameter to drm_panic_dispatch(), which isn't present in this patch's code
changes. Was this already implemented in a preceding commit?

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index f597ef04c5bcb..bc7c096c42363 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> @@ -895,13 +886,22 @@ static int draw_panic_dispatch(struct drm_scanout_b=
uffer *sb, enum drm_panic_typ
>  {
>  	int ret;
> =20
> +retry:
>  	switch (panic_type) {
>  	case DRM_PANIC_TYPE_KMSG:
>  		ret =3D draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type =3D DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}

[Severity: Medium]
Does this fallback logic inadvertently cause the screen to be overwritten w=
ith
a blank screen if the screen is narrower than a single character?

If drm_panic_type is set to KMSG and sb->width < font->width,
draw_panic_screen_kmsg() returns -EINVAL. The retry logic here catches this
and falls back to DRM_PANIC_TYPE_USER.

However, looking at draw_panic_screen_user(), it lacks a similar width chec=
k.
It clears the screen with the background color:

drivers/gpu/drm/drm_panic.c:draw_panic_screen_user() {
    ...
    /* Fill with the background color, and draw text on top */
    drm_panic_fill(sb, &r_screen, bg_color);
    ...
}

It then returns 0 (success) without drawing any text. This success code cau=
ses
draw_panic_plane() to flush the blank screen, destroying the existing visual
evidence instead of preserving it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D7
