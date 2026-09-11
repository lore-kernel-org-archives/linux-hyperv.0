Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6C459AE6;
	Fri, 11 Sep 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131204; cv=none; b=Cpu8D8sTEgcmBWQatID4ev1DCSCJ8TCzK4SsKbSR8pyGftYvS28l8EfZ7JnZHupyq/QdlryONVQEOaGX2tPAQJHHUk/qsDsViH2jhTV9xMRGfcay/rHnBbUM47q2x36ltgO8DC2sTk33hKi5qrIe+5duENdmb7b84EHVmoRGzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131204; c=relaxed/simple;
	bh=Th0XY13Yvx3ysarn7ce65X3mSKTtBrILLJ8hVYlvSF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A438bZbbyWomszmQEmDs0dAWJhvNtUvYzr/kbEZklzrdnJGBk8T1Bdd95r0MVpgitYA9XstI3KKHUSWYxP/Mmf7ygoPJ2frhF0wrZ3jvV7DIdHXDnaikaFTqsm4HxFBuTtTp4Tf1/O1R61NdDYIYF/7Xxzkhu/z5UL4WiyTUiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3ccw/Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3ccw/Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED71F000FF;
	Fri, 11 Sep 2026 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131202;
	bh=Th0XY13Yvx3ysarn7ce65X3mSKTtBrILLJ8hVYlvSF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3ccw/YqXYLhuVlXgUsBP8Nj52LE5FLRtSXPblQgAC/GjkKy5Z85BI5V39rVreLfc
	 DSqlDmKelqol3h+KhuFxTmysDNWoOMUF4tlH5KnbUWatrBoJsO9F3eoYEA9U4tqZsx
	 OnKT4+gukweWqnLHk3vuQb8iUx1okYtgVjfjnuPZFNV/voabEetRs9AQ0Ajm0fdLAW
	 R5Qvtwd0FM2CJ8FTJkDlWkJAWubxfsRf0bYgSFmREq72uVurx/VGpbceroEwJ8/bzq
	 oWzMXFF4PupV0A6xQGmmxjsM3XHnY9mABqrsCxLEGw3PUx+Wl1UGrHHXisHXXnkFF3
	 5c7cZ89khTs3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/14] drm/panic: Split draw_panic_plane()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, ojeda@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, gary@garyguo.net, virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911124540.279841-10-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:53:21 +0000
Message-Id: <20260911125322.17ED71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Move locking and parameters from draw_panic_plane() into the new
> helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
> there.
>=20
> The new helper drm_panic_display_panic_screen() is now the DRM core's
> interface for displaying a panic screen. The code remaining in
> draw_panic_plane() still does all the heavy lifting. It will become a
> plane helper for DRM drivers.
>=20
> v2:
> - use panic_type argument in draw_panic_plane() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D9

