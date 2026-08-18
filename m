Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF612DF13F;
	Tue, 18 Aug 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058558; cv=none; b=L3CtMAiL/qEV79WutROqC3hnP8HCCKI4AegSddcJXzyJCglRY5/9/h4o7NUmCRmzX6T2cYSEx/e8mowj6Z7vSYlQdE19jPRs+dyHOw2ApmjzQSaNZg0pl4y+hpX+zHBMzXKJ11+TgHvxAXV7BwiFs49oHtgleMOClgMY/l+x0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058558; c=relaxed/simple;
	bh=j5ZpcttcCWXMpRGzwTX6YgO04Pbl8YHiDHgPoDRY4Z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzBf/IzJYLOlKsq/UL+hF84vEowr6lnHMXyVSoCx59XrpC6OHqwzCIYYigUQmKRvkyVtT9bPhULmvdA3FQuF9QYILZgHVrsZgTgkDXT0/3T8CWMN3c4ZmbOkDp9R+1PWSBaLBz0xyr6OJ8dc3bfC+CqumwE1TqT3LSibDD5KZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP1kGnuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP1kGnuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110771F000E9;
	Tue, 18 Aug 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058556;
	bh=L5WWSul3RAEl4/t2hhe1a784y/wIeSmloPtBdMqkhuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OP1kGnuz6HJmfYAqQO1vUfRp8kcRYMm9SlHlPPadXtfuvXGSoFCxoT5Chughq2ZSO
	 ymFWhX7Rnr/MVtnaoYsTZYt8zn8ULhGv0WBIDFEB4Kysz3LSJXD8qFAj2ay6IIQeME
	 RxDiTLQVrZ96syZDo6mYF08edvsChPw4qAEAbCuEuhPxAMn4Li2vRptJoR+9TRTTeR
	 Q4CaZqh680IHhAmQYDyX5uXlj0Zv0/RRoJLUgtgRmNR/en69VpSHKI08pzUPW1Ogzd
	 NWPcaT2vkr6jrK2Rr4+4GGPTRQtGbyORrPxiXRLggStGEOfvHY/Ezb9E2Y3D3MvKDi
	 Xpu+VfWoiDJWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org, linux-hyperv@vger.kernel.org, Frank.Li@kernel.org, intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260818125012.468092-7-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:09:15 +0000
Message-Id: <20260818130916.110771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent debugfs writes or KUnit tests across multiple DRM devic=
es race on global static buffers without adequate synchronization.
--

--- Patch [6]: [PATCH 06/12] drm/panic: Pass global module parameters to dr=
m_panic_dispatch() ---
commit 9f2a1b5158feac614c09a17c83f387591642e034
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Pass global module parameters to drm_panic_dispatch()

This patch sets the panic type and QR version in draw_panic_plane() as a si=
ngle
point of truth, passing these values into the individual drawing functions.
In the test case, it always creates a QR code with version 40.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ede620b27515a..12c39217cbcb5 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -951,6 +955,11 @@ static void draw_panic_plane(struct drm_plane *plane=
, const char *description)
>  #else
>  	u32 bg_color =3D 0x00000000;
>  #endif
> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +	unsigned int qr_version =3D panic_qr_version;
> +#else
> +	unsigned int qr_version =3D 0;
> +#endif
> =20
>  	if (!drm_panic_trylock(plane->dev, flags))
>  		return;
> @@ -966,7 +975,7 @@ static void draw_panic_plane(struct drm_plane *plane,=
 const char *description)
> =20
>  	drm_panic_set_description(description);
> =20
> -	ret =3D draw_panic_dispatch(&sb, fg_color, bg_color);
> +	ret =3D draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr=
_version);

[Severity: High]
This is a pre-existing issue, but does the per-device locking in
drm_panic_trylock() adequately protect the global buffers?

Since the lock is per-device (plane->dev->mode_config.panic_lock), concurre=
nt
debugfs writes across multiple DRM devices can still race and mutate global
static variables, such as the zlib stream workspace (struct z_stream_s stre=
am)
or qrbuf1 and qrbuf2.

If a real kernel panic occurs while a debugfs write is concurrently using t=
hese
buffers, the true panic handler could inherit a corrupted zlib workspace st=
ate,
which might lead to a recursive fault and failure to display the panic scre=
en.

Could this be protected by a global lock for non-panic paths?

[ ... ]
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index 969a096ec840f..196496238d231 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -58,7 +58,7 @@ static int draw_panic_screen_kmsg_default(struct drm_sc=
anout_buffer *sb)
>  #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>  static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *=
sb)
>  {
> -	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
> +	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
>  }
>  #endif

[Severity: High]
This isn't a bug introduced by this patch, but do the KUnit tests safely ac=
cess
the global drawing state?

It appears the KUnit tests bypass draw_panic_plane() entirely and directly =
call
drawing functions like draw_panic_screen_qr_code() without acquiring any lo=
cks.
Could running the tests race on the global buffers and corrupt the zlib
workspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D6
