Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942833C182;
	Mon, 24 Aug 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580688; cv=none; b=mDIfOHr/zQkBimPJrsE0ZS6d639XlsC4L3LkoS5h6UPzuT2jkb5SWdV62E2J52UFjmyWBo0SZGNyNZzZegEQAcmkcFIVDw5a+Qu18yCcYwAetHh1tR69ckrWF3b5yMISGAijsItxVdS9YSJR9clcP4kjGIGPKEr4YDZGsNdN+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580688; c=relaxed/simple;
	bh=FXwAVx3UqbOjAt7lM9Asm08c1pgGI3sWPbfWT5OsL40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RN6PW2sFucHnjBqN/V6z4yiphdw9GcYrnItm1KxMprZeP+UuITIwuOsU8hGOJw4w1p79wFr0LNC0IvMxqg3CmhoOSB0Dgqb9T5B84Y8x2k4jUAuofBS67QCuN9YPVup/sAboQXZ9gConbgTRYXVtxwQ2kWVwoD95tURGZq2Dvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9wr6Sjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9wr6Sjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C91F00A3A;
	Mon, 24 Aug 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580686;
	bh=NNSqrxhKdKa9IsISn7TuGdTFnKoxHXdqNnZmSpXrJlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9wr6SjtyDdFI565fEg5Y7ka2qiBRlRSYHSDE4oTcj68lvrC37ievysH8flpSFsGQ
	 V6k0ysaCuZcI0BdQbAeTG2KTgEfCTJeYgYM6VihjJ30FqRkMQIpvXzMlm0jzbbQTKr
	 sHma8LyvG8V/1vxLLRmMyH/dsN5gB7UU9vfJX/EZnPfbQV+xjks16B5nx75lndLsLh
	 iM7XJCTIll7JU50iUrJ/uihq7UDE12/hUfaCAvWQkut8ja7irSLPeuCpA3VDJ7b/Nx
	 j5i2EgWhpiU+dbZVc4xJx3Rq8Dtgg3oNJaje9YQ3Kzsaz1eQhSMUPzMTgu8VW+GmY7
	 irzAfulRKrnSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] drm/panic: Compile KUnit tests as module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org
In-Reply-To: <20260824125201.218863-14-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:11:25 +0000
Message-Id: <20260824141126.817C91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer in panic_msg array causes use-after-free during k=
ernel panic after the test module is unloaded.
--

--- Patch [13]: [PATCH v2 13/13] drm/panic: Compile KUnit tests as module -=
--
commit 9a00d4c3f17fad5dbc6e3335649c2316482a4fad
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/panic: Compile KUnit tests as module
   =20
Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=3Dy
and make them build as a module. Export the necessary interfaces from the
panic helpers iff the KUnit framework has been enabled.

> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_pan=
ic_helper.c
> index 669f09225f8ed..253262b7e0d4c 100644
> --- a/drivers/gpu/drm/drm_panic_helper.c
> +++ b/drivers/gpu/drm/drm_panic_helper.c

[ ... ]

> -static void drm_panic_helper_set_description(const char *description)
> +VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *descr=
iption)
>  {
>  	u32 len;
> =20
>  	if (description) {
>  		struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1];
> =20
>  		desc_line->txt =3D description;
>  		len =3D strlen(description);
>  		/* ignore the last newline character */
>  		if (len && description[len - 1] =3D=3D '\n')
>  			len -=3D 1;
>  		desc_line->len =3D len;
>  	}
>  }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);

[Severity: High]
This is a pre-existing issue, but since the test can now be built as a modu=
le,
does unloading it leave a dangling pointer in the global panic_msg array?

In drivers/gpu/drm/tests/drm_panic_helper_test.c, drm_test_panic_init()
calls drm_panic_helper_set_description("Kunit testing"), which stores a
pointer to the test module's .rodata.

When the drm_panic_helper_test module is unloaded, this memory is freed. Si=
nce
the test suite lacks an .exit callback to call
drm_panic_helper_clear_description(), the dangling pointer remains in the
global array.

If a real kernel panic occurs later where detail->description is NULL (such=
 as
via kmsg_dump(KMSG_DUMP_PANIC) on some architectures), this function silent=
ly
ignores the NULL input and leaves the dangling pointer intact.

Will this cause a use-after-free read when the panic screen rendering
dereferences desc_line->txt, potentially preventing the panic screen from
displaying during an actual crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D13
