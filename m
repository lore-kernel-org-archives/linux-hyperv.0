Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0C2F3632;
	Fri, 11 Sep 2026 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131250; cv=none; b=bP0nqkbNu870rmdoGFpE0OfuW0M6jFhmstwWD3nDdBR6ZC25eqCmVAwZHFN4q1TDIVGHbSyp5Zx2Fl8xmig22wremdqAjYZ1uwW0vlpsqLmuUB4xNslFYhnUWDeiuqb/yUrxq3AbCaHTgpXodiE1Gems7Ufiy3xExywR5IqREXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131250; c=relaxed/simple;
	bh=DH2MgrmSNXSwGj0bQL9pRyfq+FBusWHHv39MC6losiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QXgT+k5JZGEfLH5cqJC44b4wUmnsQSTQlLZKx1RWKrsQ9jhxn0dQvjeW9w7qEuFk/v1OUNqh2fi1hLXYGJJt9Xb+yBYp9mpgYlEsJDXMBla8n+2t5ZSEivlgWT8vIxPzgMRutoO3EowCG9iMoZCjp2032ASQg9jXcYusxCmgwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELDlWdVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELDlWdVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488361F000FF;
	Fri, 11 Sep 2026 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131248;
	bh=DH2MgrmSNXSwGj0bQL9pRyfq+FBusWHHv39MC6losiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELDlWdVUj6rgI+ydpmIjWkjnEdvZLRbKOl9eMPpsBv8gkVjX5IdGm8WCvrKeiyoAY
	 HVNHKsG0q4NkwWM0I5rXrAbZGpDFh2nPIy0cgvoFYcPOjsy2QKBET4VUTVjrNhFbT3
	 +8Ecf90MtkFqFMPL1Dns+txKCWPD/3QdjWI0lBYFxXnw9spprxsAMQ52r83yapwiUS
	 iSd0VPLtIc/UFUf6Y7UnHfr1A/2pVFrpYO+KYSIsnOQF3A5YBLOjamUSB8Uxt0LVWX
	 kF4duXEesQ4E4C5IbzIscCTE01FF79eb8FktH/UkyDkpMFDP1ouiUn5HasSmGl+JI0
	 7nI/r/lNhpYRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/14] drm/panic: Retry in dispatch function if panic
 output fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, gary@garyguo.net, intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260911124540.279841-9-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:07 +0000
Message-Id: <20260911125408.488361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
>=20
> With the implicit fallback removed from QR-code support, the tests
> cases fail for thr smallest output size (300x200). This is because the
> QR code requires a minimal output size. Increase the size to 494x494,
> which is the minimum supported size for QR output.
>=20
> v3:
> - update outdated commit description (Sashiko)
> v2:
> - fix minimum test size (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D8

