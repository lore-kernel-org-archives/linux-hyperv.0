Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610146C4A9;
	Wed,  9 Sep 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945314; cv=none; b=elUybvLDJTRq6EIfepsf0FA00GGU6yRRbBeeZH+/hrXaO3QriDcOFliYMdojfGJ8mCD65K4Klo4m6TsRg4ZyCRevMqmgRUCGUL2/R839W392XsWu4wJYeb5LbfPEKOhNvud9dt2zbyMAVJ/IEtWDYqLo+QlBh4snhVT4C1ngYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945314; c=relaxed/simple;
	bh=AyRxX+uCOQI0YJyFaQe7zJb+NRs+oaMHlGWeLnEzcXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sw+1Ei86vDyvvFP0LO8h2k+8QPjDQDVHYoVP3AAge5YqhlYNxW+TjSG/nTAP5MziF3gc02lHaAAFptapRmh/3iveODR4+TtV+j+AKbcz1n8H0fl1sMWVyUe4OHQQ9UW1swhopYcs9HPYN2Pt/2D80SKwHKni6/loBfTQpVLVJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg8DO+TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg8DO+TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DA1F00A3A;
	Wed,  9 Sep 2026 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945311;
	bh=gLDyNFD1/RvPm1J7pM+BXHTtKoCe4+PeIOeIYj4a48k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fg8DO+TXq2FAIjw+/tsm+bwwrTgwpGh+mNzuJ7O4UdoHaHD6yiw8eJRH2u0ESjl/J
	 zlZzP35cb+q2QJa3haIsH/MC9ErlOJZcoZMLNtn3corFf5U/l7vkjjaVhdGDDIX85c
	 LO0i7xLtkiUMOIyoBEL+Dp0H6ruZamGwo+49KI5pLJ7MraWSD4Oty3ebEUEW+lxV0l
	 vc77Mx+CiKKK2Ogdrr8jlVjPpSKrxK/5cAlcCPm5bJ4dg83+Xl9bLCVmNlGYVUFbYF
	 R2mCqCrL9WPpm2TR09Rpy47aOFgU7xk5ahn94OwRb4sVku91UUgDOqlCBOqQO11LnG
	 cdrT6ZGzIuWJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/14] drm/panic: Test address from kmap op for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, Frank.Li@kernel.org, intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260909085826.64529-3-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:15:10 +0000
Message-Id: <20260909091511.011DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference in `kmap_local_page_try_from_pa=
nic()` due to missing NULL checks for page pointers in `drm_panic_fill_page=
()` and `drm_panic_blit_page()`.
--

commit ddaf01e3dc4138e21af0a9818e11a3a8b5244eae
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Test address from kmap op for NULL

This patch adds a NULL check for the return value of
kmap_local_page_try_from_panic() to avoid dereferencing a failed mapping
during kernel panic screen rendering.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be3380..d28ce8878e055 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>  	u8 *p =3D vaddr + offset;
> =20
>  	vaddr2 =3D kmap_local_page_try_from_panic(next_page);

[Severity: High]
This isn't a bug introduced by this patch, but could next_page itself=20
be NULL here?

If a 24-bit pixel crosses a page boundary and the next page in the pages=20
array is NULL, passing it into kmap_local_page_try_from_panic() can cause=20
a NULL pointer dereference via PageHighMem(). If CONFIG_HIGHMEM is disabled=
,=20
page_to_virt(NULL) yields a garbage pointer which also crashes upon=20
dereference. This would cause a double fault during a kernel panic,=20
preventing the panic screen from rendering.

It looks like similar unchecked page pointers are passed elsewhere in=20
drivers/gpu/drm/drm_panic.c, such as in drm_panic_fill_page():

drm_panic_fill_page() {
    ...
    vaddr =3D kmap_local_page_try_from_panic(pages[page]);
    ...
}

And in drm_panic_blit_page(), pages[page + 1] is passed without a NULL chec=
k=20
even though pages[new_page] is explicitly checked earlier in the function:

drm_panic_blit_page() {
    ...
    drm_panic_write_pixel24_xpage(vaddr, pages[page + 1], offset, fg32);
    ...
}

Would it be safer to verify that next_page and pages[page] are not NULL=20
before attempting to map them, in order to safely handle unmapped or sparse=
=20
pages in the display buffer?

> +	if (!vaddr2)
> +		return;
> =20
>  	*p++ =3D color & 0xff;
>  	color >>=3D 8;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D2
