Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DE313E2C;
	Tue, 18 Aug 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058277; cv=none; b=Xr7ZZ1XC6cA4Jm/nEWrihS/dCJqyTs0vbehen+lXP7atRb5GIpsNH3AMH1kRbd7y6xq2ss97vn9UCulfDO5r4ippwP283xRfO68OGCofOQ3Q+pG5tlR/1mq2xVqhFSLmyyWAOCIiQ3lP40RiztOpgCJjhYALUsH/DLGh+jO/f7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058277; c=relaxed/simple;
	bh=iVGKt//W8WTe6GsyD1fsWDCXkHdOHHIXCBr3gqcUFMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CPEBMSsV6ou9zCA0geq9ZFi9f/qSQ5ETDV0y9Kuk1eyJXNkpJHMyoTdFFGcJq/7BUy40yQhRejCDG7XR7xDaoT+I4qLvJnvQtH1BLll+SlbB6s+tkuZgi2abWii+A6u2kk4d2n1sKGKr2guQCebqN39MUvp9asIl+4VsNdt7768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iadpa/4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iadpa/4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1391F000E9;
	Tue, 18 Aug 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058276;
	bh=Fyr2rTcnJQyyFIFbxd0Nsnv3dEJzBm98+nePcwg0vk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iadpa/4sPruxnUmQWiaFza8mqTnrrz82L1CH/7dSADIIhsOZMQZBgt8nvOy1FZLNS
	 lqdaxpDCCTrP/t2ydy5r3hEg5p5cvzQlmIXOCwywnVknHqOtyF+rhh6YDCNIeJjxFY
	 CNAq0UID2JtftEcU5VRdBBoSJU8BqqDz4UsWbnRhi5EqP9tCVovnuuZzPFTR0bpyED
	 hBkFufkODMOge6y8vlDzTTZmZq34BTpxBV20dNhv/z2vZZzy021DFXisfn1AtRWUdi
	 sP7usoakeCtOyuvjTZnXEEzA448QO7FZHFEoSq5gemiBtvOMfmEtaQpEMVFnFHA583
	 B0vW5U3EAFHeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org, Frank.Li@kernel.org, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:04:35 +0000
Message-Id: <20260818130435.BC1391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for the result of `kmap_local_page_try_from_pan=
ic()` in `drm_panic_write_pixel24_xpage()` leads to a NULL pointer derefere=
nce.
--

--- Patch [3]: [PATCH 03/12] drm/panic: Return -EINVAL if font is not avail=
able ---
commit 5ad93562bf6ffaf36ef771a5c8eebc2aa43f5621
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return -EINVAL if font is not available

Font lookup does not allocate memory. Hence reporting ENOMEM on
failed lookups is misleading. Report EINVAL instead.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d839..96d238bfceee9 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_=
page,
> 					  unsigned int offset, u32 color)
> {
> 	u8 *vaddr2;
> 	u8 *p =3D vaddr + offset;
>=20
> 	vaddr2 =3D kmap_local_page_try_from_panic(next_page);
>=20
> 	*p++ =3D color & 0xff;
> 	color >>=3D 8;
>=20
> 	if (offset =3D=3D PAGE_SIZE - 1)
> 		p =3D vaddr2;
>=20
> 	*p++ =3D color & 0xff;

[Severity: High]
This isn't a bug introduced by this patch, but does=20
drm_panic_write_pixel24_xpage() lack a NULL check for vaddr2?

If the next page is located in HighMem, kmap_local_page_try_from_panic()
returns NULL since it is unsafe to map HighMem during a panic.

When vaddr2 is NULL and the offset crosses the page boundary
(PAGE_SIZE - 1 or PAGE_SIZE - 2), the write pointer p is set to vaddr2.
Would the subsequent write operation then dereference NULL, causing a
recursive panic that aborts the DRM panic handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D3
