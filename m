Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4675453A5E;
	Wed,  9 Sep 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946657; cv=none; b=gDsLFEJq0yCuKE+a+1SAaoAfKhniCoe5UG4KGtGUKfvcdRKSSpjVpdLTMjhWX+o3bpmwDx19l9f9xcQyUQ/+euS0mRMXaXwwPJ+ue+noRWnEVS/P0xFK4N3rG88X5iBinKrE0gX+Amo+PKaU/xV6i/2rGVbSfo5SrSiK9jiVFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946657; c=relaxed/simple;
	bh=Rrs44k5UNfx/JWjfozHkOXos/jrv6slH8wNYDXf2jvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pUA1jg2lkd6ZGplbfQtG4Egi0IKeRotdocPs5i79VY3SUmX4ZiAab9KvkqC2kkbi6S7WM6kwgEncB7NSu0TlE+Mr/zpFA7/+SKO/moEKCeZkqMR0Kq0/iiNWk/zSIPCTYdoCyjAlvrfGqqpyUpATp1tiPq/0+L1J8+oMLC2W3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFcips2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFcips2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1931F00A3A;
	Wed,  9 Sep 2026 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946649;
	bh=HjXCv/IRivEd/0jUidSfuc1KTFFdu2s/p3PtFBwX+Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFcips2dNZb6YLBKKYInKBk99Ih0a0yB6P8InbZqxryG8B5GvaJoaJZNssN8/bMFK
	 g46Mr8oYPQOaUNKjhuB7oS4ptmd8cItVTuWI5Evee03G3Jw2JjwlOH2ZaJDdccHUL0
	 UNdggCSq53AH7f+1aoSC9aOEx1+bjxPm+lsDK4FhM8uP6SJPOODnoWIAA+bGbIIy3F
	 ofPHZg/XY4vUSH0o4N/4di6RhllmgQBII7peekz7KG6LTTcRCzZC+DtjyQDnVaWcwJ
	 D/Wmqk6CTJ/GWioDnYaHXvx+hViUDUeAc9ef6fbY4nYRTh72rDyAMmoJOyg/P8OG3Q
	 KXRD4uNgbwQqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] drm/panic: Compile KUnit tests as module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev, intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org, virtualization@lists.linux.dev, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com, ojeda@kernel.org
In-Reply-To: <20260909085826.64529-15-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:37:27 +0000
Message-Id: <20260909093728.4E1931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The KUnit test exit function `drm_test_panic_exit()` fails to clea=
r the global panic description, leaving a dangling pointer that can crash t=
he panic handler.
--

commit 7eb0aee35aa7e3c110129d29f0c30be49ac71dab
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Compile KUnit tests as module

This commit fixes the panic-helper KUnit tests dependency and enables them =
to
be built as a module. It exports necessary interfaces if KUnit is enabled a=
nd
adds cleanup logic for the tests.

> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_pan=
ic_helper.c
[ ... ]
> @@ -815,7 +820,7 @@ static int draw_panic_helper_dispatch(struct drm_scan=
out_buffer *sb,
>  	return ret;
>  }
> =20
> -static void drm_panic_helper_set_description(const char *description)
> +VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *descr=
iption)
>  {
>  	u32 len;
> =20
> @@ -830,6 +835,7 @@ static void drm_panic_helper_set_description(const ch=
ar *description)
>  		desc_line->len =3D len;
>  	}
>  }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);
[ ... ]
> diff --git a/drivers/gpu/drm/tests/drm_panic_helper_test.c b/drivers/gpu/=
drm/tests/drm_panic_helper_test.c
[ ... ]
> @@ -86,6 +90,11 @@ static int drm_test_panic_init(struct kunit *test)
>  	return 0;
>  }
> =20
> +static void drm_test_panic_exit(struct kunit *test)
> +{
> +	drm_panic_helper_set_description(NULL);
> +}

[Severity: High]
Does this leave a dangling pointer in the global panic_msg array when the t=
est
module is unloaded?

Looking at drm_panic_helper_set_description() in drm_panic_helper.c, it
checks if the argument is valid before modifying the state:

    if (description) {
        struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1=
];
        desc_line->txt =3D description;
        ...
    }

When drm_test_panic_exit() calls drm_panic_helper_set_description(NULL) to
clear the state, the NULL argument is silently ignored.=20

Since drm_test_panic_init() originally sets the description to a string
located in the test module's read-only data, the global panic_msg array will
retain a pointer to this memory even after the module is freed.

If a system panic occurs later, could the panic handler fault when trying to
dereference this stale pointer and fail to render the panic screen?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D14
