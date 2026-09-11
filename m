Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA747F3C8;
	Fri, 11 Sep 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131607; cv=none; b=WPK3T+Rj01Sqhv12xJLV08r+4IG/NpMfRkD3UOLtO5vlSWol7QOYnqvxrMabvARwudUFhd4EWwH4BTXIileqJPT9nt8DBXmgXG+bGrK5uaW5SgwDKZnbmuYooLBRc3ngLP2iZ4g474qOKyzDpIFKjg9pOtuUgkzyMzySr5iTw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131607; c=relaxed/simple;
	bh=4GSlZVdim4UHhZgzdztPlxiMIor4//3/w7uuyumnHns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ja9ZpY9kj9Y/4mbJhk5somGrK+2WrmeTI5caB56Jaly5erYc2TEI+kl+GrPAVhHB/z+F2MuMp7oAX1HKFNthu8iLXWDOGlAF3t9t6d3eEGhPRv84EOUlqburlyYTzDbPby4xjLGYmv1vCjgFlKRB/Fbioy4Be8baycMpjBdDSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRqxgu/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRqxgu/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE5C1F00898;
	Fri, 11 Sep 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131584;
	bh=4GSlZVdim4UHhZgzdztPlxiMIor4//3/w7uuyumnHns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRqxgu/2JkLI3PeOol6tJ9dW7mpOXvyeEjCoKTGxIJfu2xLeTH8J/4j4FdL3OBcRA
	 ncOrlOVhWVZgGORHiCqp6KNhNEGk28PfIqWjbDTg93snCFvm/GoviUlIG1AQlmnWG4
	 FXpRgoOIApiLBke+RIWY1FWRsODT6ZQ3ai8A46xYMBaXtUk93qSyd9nDVENCZqB0ZB
	 ym9h6YCRADgJ6ZW+jhC4/V2osHOSBozpIdjQYZKe05g+Y2Utb6eL+zxMFBlxH9XaDz
	 3pEDFaQQw/DrywGtQ5Sjbj+hGAPGsLF/x8JmVH4pFJQoaUSqDVqBQhc2X9XsCWKIpz
	 WxqtvI/UhWqxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] drm/panic: Display panic screen via per-plane
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, gary@garyguo.net, "Michael S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, ojeda@kernel.org, intel-xe@lists.freedesktop.org, virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260911124540.279841-12-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:43 +0000
Message-Id: <20260911125944.1BE5C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Add display_panic_screen to struct drm_plane_funcs. If set on a plane,
> register a panic handler for the plane from the DRM core's panic
> handling. Invoke this helper from the core to display a panic screen.
>=20
> The new callback replaces get_scanout_buffer as signal for panic
> support in a plane. Using get_scanout_buffer is now merely a detail
> of the implementation. This will also free struct drm_scanout_buffer
> for use cases besides panic handling.
>=20
> With display_panic_screen in place, rename draw_panic_plane() to
> drm_plane_helper_display_panic_screen() and make it available to DRM
> drivers via drm_panic_helper.h. Do not change the implementation or
> functionality of this code. drm_plane_helper_display_panic_screen()
> still supports kernel messages, user messages and QR codes on various
> color formats.
> [ ... ]
> - only consider planes with get_scanout_buffer (Sashiko)
> - set callback for planes create with drm_crtc_init() (Sashiko)
> - return errno code from display_panic_screen
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D11

