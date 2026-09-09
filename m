Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF248E0D4;
	Wed,  9 Sep 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945209; cv=none; b=Eiy2rToDCoEkm+R4/+2FYiGnsVn4QpI4uCpv7sd16an5ozwZy/Tc5KBZugUNLcYjFU8I8yO+IE5/30kVSTej5+d18FcRmcF1Pv6XvDLB/C33zC7/yaR1yRQMxa8wY1pL3/WWlYdxSHM75ozdWVKsU0VcAxPMQCGLVyR0huj4iQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945209; c=relaxed/simple;
	bh=3z+9LEWFCS9gciYWfo5+uTWPOIF8QN3SH8vrdCXy91w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdKLVg3/4rmC8U1hfS509RcAuh2pkJg/0e12L6PEZLxoDHAnXO8AajxwxFYmgvy9aNuaTuy8fSgT8+Xzp/J2eHxAn/Jp2+aj5C5UV8MrEnUuDmyb+2qZ9Q5PzQxxjjgYJ6qBb+Bp8JJ1Gss5QPgGI/jbtcbFUsk8k7Z1Pbl7ZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlYlpdO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlYlpdO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2501F00A3A;
	Wed,  9 Sep 2026 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945208;
	bh=AAwOGRQaoDxWa8W7YOl+0hmbLzFBwRTEXNQVM25Bff0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlYlpdO7bvC67o1WGv48JCynadP305FzSV9BC0UybWtpH/5USq7wEyD8cHUKrO3RV
	 JX9POh+lypSjH6LXWpafFZmXOXGR+HXsqW4Z0VPZAG1N0bro7lr3pbCZEcs13RLIWI
	 lMnScwf/QySwfpo5cdpDXgazphMJMwgpFY3/HTPzfu8aae4/hTSNgBnxaTTub3kp0o
	 jld9b3mAROMsBX4pM1SyH3obGkn6fyl/FKUegxWvQS21cEEzXFM+Q+K097T4sLjcpd
	 Qedntbf3g5hEAB5DjLxXI/PpLmoChEJSVejFCm4yVLnrGPVfb+JtsYNRWo3nLnBhIg
	 EG3xzSDNnINcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/14] drm/panic: Return errno codes if panic output
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: gary@garyguo.net, wsa+renesas@sang-engineering.com, imx@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org, virtualization@lists.linux.dev, ojeda@kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909085826.64529-5-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:26 +0000
Message-Id: <20260909091326.EB2501F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Memory leak on test failure due to KUNIT_ASSERT_EQ aborting the tes=
t without cleanup.
--

commit 9d8cd66dd2ff7109b373380125b5d333a64fb982
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return errno codes if panic output fails

This commit modifies the panic output helpers to return errno codes, allowi=
ng
detection of invalid panic handling and avoiding display flushes on error.
The KUnit tests are also updated to assert that these new return values
indicate success.

> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index ad2f3a2f93b6a..fdd77b0cc54c9 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c

[ ... ]

> @@ -102,7 +102,8 @@ static void drm_test_panic_screen_user_map(struct kun=
it *test)
>  	sb->height =3D params->height;
>  	sb->pitch[0] =3D params->width * sb->format->cpp[0];
> =20
> -	params->draw_screen(sb);
> +	ret =3D params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Low]
If KUNIT_ASSERT_EQ() fails here, does this abort the test and bypass the
subsequent vfree(fb) cleanup step?

If draw_screen() returns a non-zero error code (for instance, due to an
unsupported size or missing font), it looks like this will leak the vmalloc=
'd
framebuffer since the test aborts before the free can execute.

>  	for (i =3D 0; i < fb_size; i++)
>  		drm_panic_check_color_byte(test, fb[i]);

[ ... ]

> @@ -146,7 +147,8 @@ static void drm_test_panic_screen_user_page(struct ku=
nit *test)
>  	sb->height =3D params->height;
>  	sb->pitch[0] =3D params->width * sb->format->cpp[0];
> =20
> -	params->draw_screen(sb);
> +	ret =3D params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Low]
Similarly, if KUNIT_ASSERT_EQ() fails here, does it abort the test and
bypass the free_pages cleanup block?=20

It appears this would cause a leak of both the allocated pages and the pages
pointer array on test failure.

>  	for (p =3D 0; p < npages; p++) {
>  		int bytes_in_page =3D (p =3D=3D npages - 1) ? fb_size - p * PAGE_SIZE =
: PAGE_SIZE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D4
