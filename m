Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D13859E6;
	Fri, 11 Sep 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131269; cv=none; b=d8dredWpFugm6FwvUpSa26XDoCGfRFW3haArDvrvZDpTczkkoa7jVGUqXS7gQejlO9oNWia181yHUSpOT7SkFkIKvu18SiCNrNeFPB6J5J4tse00QgmT9Pii2N4qNsND4pTOQusKhJPbOaQH4cY60M2hp1MXc/ldTHptKHu67UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131269; c=relaxed/simple;
	bh=XDQh51NcC8m5ick0utcnmIljTIdDpBigjrTxnTdj2E8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwH+FkPd+Ay/YaS+QjTT7lW5+p4BrZwerMKfvVfRDUXutfQmido52PDEXHIpHXdUJJg5odmsb7CdxtGyj3knywcI08jvptMzKaSxKnLUYQjrMPGK1b1WXosTVByerrZsyR0W7OEtVH17AznbP9xvCZf4ku32l0sAGP6KRi1apN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZeKQIG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZeKQIG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC8A1F000FF;
	Fri, 11 Sep 2026 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131268;
	bh=XDQh51NcC8m5ick0utcnmIljTIdDpBigjrTxnTdj2E8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZeKQIG2kbvCp89PeorFoW8sECJ2PQe9c6GdJlamOR4Tmq5pEh68bXvE7d7QmvhPw
	 98Yc1UjiMxsl7YsZWs5vbHI5NSAuUhqLTmN+p1v/sICfeLNo3QkVPzsaHOmaiDAjJV
	 UIGAh1y/gvKRFjF0IDVgnAW2V7wDLu32Byt6+uI3wvEqrxjUv/iZbwhTCOlA+5DzMX
	 I48QmGYwgXB2S+2NznO7ao2TWREKT2xJVeKGg5m4ZHFTTmM0GIsVDkphH6/FlAo+SA
	 8DOkn5iV0iO5Kb35Pipaz5nm0U8DngRIicw3PM3ZDyRdZ8wbfmssjmHlTEXyMyX1yH
	 bDKwlgZRR9rYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/14] drm/panic: Do not use un-escaped URL as format
 string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, intel-gfx@lists.freedesktop.org, ojeda@kernel.org, virtualization@lists.linux.dev, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, gary@garyguo.net, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org
In-Reply-To: <20260911124540.279841-2-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:25 +0000
Message-Id: <20260911125425.EFC8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
> with a %s conversion specifier. Avoids a possible vulnerabilty from
> a crafted URL string.
>=20
> As the attacker needs to control the kernel at the Kconfig level, the
> potential for an exploit is likely low.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D1

