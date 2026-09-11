Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396247F77C;
	Fri, 11 Sep 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131615; cv=none; b=rudpgw9TukynyLQpdaalHjkyiw1uwqYldX1YcGU1EBMou7r3BGUHRR5H71v6PrBRZFvaIAY7VdVd6pr+m+MCI2Z+0zjgA8g//h4utssf7lM6Q2UOhSbaj9tL4DqDG6F8Qa7ejzXydO2xVAytRgPlidFC2fz1WWbyO3uRbvP+P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131615; c=relaxed/simple;
	bh=yX+3ilPb20xiw8ZmOebnP4VcjHhRYW77anjC2PSUMOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pK44NgKcnAcmVYjgEXy7cUFDNkTg8UXeOA8TTSCag/u/54SvrlUgheO18izjVmZgVf+Ev0dHYqkVUN518kNN9pKO2ys/nVGA5NIh4ZFKSSPWNFRK/pEgwRVgs6Hyk26cjS/XfOa/S+JHP1MjVxvCGorz0B9+5dU0S/tisGLgJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1/IRq2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1/IRq2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6441F00899;
	Fri, 11 Sep 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131590;
	bh=yX+3ilPb20xiw8ZmOebnP4VcjHhRYW77anjC2PSUMOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1/IRq2uo/UurTvnX1op4KNq5KATENSdkp0JYc2lVsGM9E5jNnZCMjILGfVXMV5wU
	 JLYrDeORq5/Csgv2ukR5a4dOik0cTfmGpIDqBAQ3qHi8TuC+Rt6MNnqbEvp4zC1lUU
	 /cdL3PWW5Ekeg/maVEU7NulsQB77bVWYoqx/s6J4Ibsob+Pmn8rlXAVr3dZf59J8vl
	 XndM5q++BzLOVQbeaSpA/NGcC1BNRxrer8Q4fkOP0ZA1GegGjoX6iX7OhuerRIo0Vi
	 dH4W9Q9EehI36N9x4Z2+wQxe5dgBOINSJttdUgzCfjIXUjx3VCRiD9RP6Zb1sN5tqV
	 6aPTad0ybnfbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/14] drm/panic: Move panic display code into helper
 library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: ojeda@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911124540.279841-14-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:49 +0000
Message-Id: <20260911125950.4B6441F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Move drm_plane_helper_display_panic_screen() and the existing panic-
> display code into drm_panic_helper.c. Rename symbols accordingly.
> Also update the QR-related code and the bindings accordingly.
>=20
> Link the rsp. object file into drm_kms_helper.ko. Eventually the code
> will become a DRM drawing library, together with DRM's format and draw
> helpers. This requires more preparation. until then, KMS helpers serve
> as a module. All DRM drivers link it anyway.
>=20
> Add a new section about drawing helpers to the documentation of the KMS
> helpers. List format and panic helpers there.
>=20
> v2:
> - fix dependencies on other DRM modules (Randy, Sashiko)
> - provide placeholders for drm_panic_helper_{init,exit}() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D13

