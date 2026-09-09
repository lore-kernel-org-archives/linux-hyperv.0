Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213A489868;
	Wed,  9 Sep 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944929; cv=none; b=g8ayMcN+/c9N/hY+btyMaK4YO4Cv+8Ji5yP6pa/TBsrFJVLVFTaXkv/JqoGtHv1clLScnRM8IbLAPBkLK1a0XRYkKYwZVF68MM2gnLUf9uHren7g34XfXi+Cg9HN5r8IoTLsxhKfx8EQ6AIoOdbgCmeWs6PUIehI10lIGvM27sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944929; c=relaxed/simple;
	bh=aGy2CgXcDQ+imoqZ54TQ20ORwgTZS//UONFDVx4wO38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DwBxhvx+TF1xmrjBi1wQbeaeb8BEa0EuqZtxQj82PNzQvWEjWbRol/f74/UuGeKp66bp167cR04FRhXZEvf6seb2zyytP5T6e27TQ1Bu88wy3zxRorobZ3ahsvO6jNNjoDOAPIoNGtYYAyTbgdmk2tg+45kihTDimAryLb09moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnBsI5IY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnBsI5IY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF031F00A3A;
	Wed,  9 Sep 2026 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944927;
	bh=aGy2CgXcDQ+imoqZ54TQ20ORwgTZS//UONFDVx4wO38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnBsI5IYLcvodTY3L4QakZStEfXVkXUh40PEmUWn2q/7weiPCHjjC9aU0A1ZFA3Nb
	 dQJ7ae9zuyBeSVtlPLhR0bquvmOVpEjaRKw7YNEujmIlo6am3iUMD/7qw4tNL+IiOr
	 JNh9QQKANjGx7x4FAyyh2/bH+QdxbJmj/LOYqrS2IQlI/OX+O2WEzqJd3JnZwy7Hzh
	 HZmvTaeGylVIDzEI44+zOdvqPxBoVU5MdsEwNeWBP6se+abqAHncGy4w9nearuE+U3
	 E7yxTq2XE9HZWJSf4RjexKltwSB/ElGUxIkc6vu+Nco0G+ahjpJD8d+U34xZpNYkOZ
	 p4o/h7hvh9ghg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/14] drm/panic: Return -EINVAL if font is not
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, Frank.Li@kernel.org, ojeda@kernel.org, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260909085826.64529-4-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:08:46 +0000
Message-Id: <20260909090847.0FF031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D3

