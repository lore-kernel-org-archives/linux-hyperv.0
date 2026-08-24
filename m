Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C035E93B;
	Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577232; cv=none; b=S5jnAR0/D5PDKYhfMRm9t/NoXS1INp5+3TCh9iqMxX5oylylUeG/w68aLnJemzBvpiN5KbMm/KyaiFDbWAqQETlg0TQqnkPv1vuttyQkHYJNZaRqBD3dNHC86fUyDC/k4AMB7To1yFRFfnbhUbkDpVekl1agdfTOa2SP0YZnmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577232; c=relaxed/simple;
	bh=EbToFAb6fri9SAHjQKuwtOM3zN2p5AA42q8BjBL2nJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PAYyxQbI04ylQ7SsQ9GqG66bCA9nrRzW9hHYlp8wbPtTCWreU+6UVO6/0HpP4JAHbjohzgfpvKGK1UBkS1xOoGnfEat8GTJJmBvgnCDExkVFL3IbXpQ1bGogIWss8q6SuCpdzEa8S/ils5g8pki/M2A94qDQQ4XzaIqVCZ2fRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5jsjHvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5jsjHvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B41F00A3A;
	Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577231;
	bh=tMcak/Mf+DuOibRI3q5Ttd/E3iSnBN8Ex3krV5Y5x2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5jsjHvl++N5+Cqf/fa/CRHm3AkmM+TJzjbQAIRNmIy5wXViUvyMJ+t+/HI+BZLRL
	 AQXy9/WzAth1nZayvtu+FkCWXbjeCXH+9OCH+h9/ZGvsdPXNfT2f5TuGfl///HmLB4
	 GFagqrMNy9ynD68mxBmeuV/Px5Pi4e+RvSM5Urb/ZMmyrF02+zFEUCv2PC8JYyUXVV
	 dGzADONQstvTSrahGM0+z9ZaZDH8dMAyzQI0tvUWxlWd2S+Z/UTQJy56dhNoH4KjmX
	 0BsZY2MkTaEh3MaMXgxy3yXY4+QidsctdkOpw82X6Rv4gjuzfaWrxc3BIX+8Ba91nb
	 tbVddvTQ+3CoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] drm/panic: Pass colors to
 draw_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, ojeda@kernel.org, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260824125201.218863-6-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:13:50 +0000
Message-Id: <20260824131350.8F1B41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using KUNIT_ASSERT_EQ with unmanaged resources causes kernel mem=
ory leaks on test failure.
--

--- Patch [5]: [PATCH v2 05/13] drm/panic: Pass colors to draw_panic_dispat=
ch() ---
commit dfb1a50d1181cba2ccd93fe314ac428958a579a7
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Pass colors to draw_panic_dispatch()

This commit sets the panic-screen colors in a central location and passes
them to the individual drawing functions. In the test cases, it hardcodes
these colors to remove test dependencies on the exact config values.

> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index fdd77b0cc54c9..969a096ec840f 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
[ ... ]
> @@ -48,10 +41,27 @@ struct drm_test_mode {
>  	.width =3D w, \
>  	.height =3D h, \
>  	.format =3D f, \
> -	.draw_screen =3D draw_panic_screen_##name, \
> +	.draw_screen =3D draw_panic_screen_ ## name ## _default, \

[Severity: Medium]
When params->draw_screen(sb) fails, does this cause the test to leak fb?

In drm_test_panic_screen_user_map(), the KUNIT_ASSERT_EQ() macro aborts the
test before vfree(fb) can execute:

drivers/gpu/drm/tests/drm_panic_test.c:drm_test_panic_screen_user_map() {
    ...
	fb =3D vmalloc(fb_size);
    ...
	ret =3D params->draw_screen(sb);
	KUNIT_ASSERT_EQ(test, ret, 0);
    ...
	vfree(fb);
}

Similarly, does drm_test_panic_screen_user_page() leak the allocated pages
when the test fails? An abort here skips the free_pages cleanup block:

drivers/gpu/drm/tests/drm_panic_test.c:drm_test_panic_screen_user_page() {
    ...
	ret =3D params->draw_screen(sb);
	KUNIT_ASSERT_EQ(test, ret, 0);
    ...
free_pages:
	for (p =3D 0; p < npages; p++)
		__free_page(pages[p]);
	kfree(pages);
}

>  	.fname =3D #name, \
>  	}, \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D5
