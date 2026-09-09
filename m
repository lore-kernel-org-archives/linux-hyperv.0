Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E93F5BEF;
	Wed,  9 Sep 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946160; cv=none; b=H/CBURoPftNcV9XcQXHGMLF8w6GkIn+h0bH5QXXkj2LPZvfnA+ykM8ijC1uYwZztlqsNT+A9EXfWnbA/LoAZi2YHJsbwICq6rqXVfw/4iwBI9CZSjFsPkCMCTQPmnrTE20IXWqYPxAmsSpv0NY5+uBLXKGS34oMCwG9FxulSF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946160; c=relaxed/simple;
	bh=tXl2UpBmj4NE2SOI6/ACR693kuQ7Q5jjNZtO/VSraRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9JFnrdmw0wMMjz5igKj/DEIQJRtBOsysNGRdxAjvxx7S5TKrk66n/Hh79VT+XyaUQzskzKJVpRg3HCT1J4IvCxcNq9eaZC8VFXRryvMrZ+xdjVTRlIIigtBNoyFkfeucBt90YUf49jeuDHasEKBwT+o+kkSYQG0oGMlaLAsZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdnQp7UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdnQp7UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3160A1F00A3A;
	Wed,  9 Sep 2026 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946147;
	bh=tXl2UpBmj4NE2SOI6/ACR693kuQ7Q5jjNZtO/VSraRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdnQp7UFVW1IKReMMuPnXAFIA8SOrQC+TCReTSQQuqrUXLiRKZpXLagvaIcXvk9L0
	 y0Oe1TNwFC/cGWusKFg/GyykFBu8svW/sO6JBcpffQ+Wt/UoU0GqLgU2fLsARNNSAK
	 LrCZVLFo3wq0yrii5AzeEv2yqvBnWSq6rribYnwU4D+1wB4tx6+0OKUUZz6tCUgM5M
	 JHXnt4zD+C7asx4tLd/ZHGj7WkXKd3N/XmqxRc4qSiKsHaURSTWc3NpYuPU85QpoKj
	 pL4vJ+5eJnPEZdbSqWiwCgSf+svzukI8KMsavdq3jZCA829ATZhbega64p8dG9rUnz
	 d4CXI9YtvsYQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] drm/panic: Display panic screen via per-plane
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Frank.Li@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, imx@lists.linux.dev, virtualization@lists.linux.dev, gary@garyguo.net, wsa+renesas@sang-engineering.com, intel-xe@lists.freedesktop.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909085826.64529-12-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:29:06 +0000
Message-Id: <20260909092907.3160A1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D11

