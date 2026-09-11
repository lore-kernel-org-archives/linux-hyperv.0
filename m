Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CF44F540;
	Fri, 11 Sep 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131296; cv=none; b=LZGQ5YA4r8lw7Y2cgHFae/WRjmRGnRAPQQ5RRuENQ8DB5zINJbnt8B698Nb3Q9olPrN4jyZ6jnlfnvYiMFfZTU+MbRFlzSkx5HeE349LX/Gt7hh/LgGNBfiulwAnbyQIsq2RAXbSCPVcOAwIz/HOi/tbmmaGLspJqdX0Geb2vpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131296; c=relaxed/simple;
	bh=jWbxLHEaLpiGf2wWhzOi2PAKcNMBoXCPv2UhyZjIbrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IscG3U2u4bxFyBDGKAkqaa0LcZkFLWn324q9g/KV/EG3VJLnXP0CXOikzWQxqwh0eTZFcHuUWYEUuaoFOUGmQreSGbmOyt611IKqGqg2HgQ3dL6vg2YaPsCSnIUGmdqNaW6D0kxhy1Iv8nWa5qutsnp8ZwRJMq3RVQpKMj0AIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVJa/NO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVJa/NO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE541F000FF;
	Fri, 11 Sep 2026 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131294;
	bh=jWbxLHEaLpiGf2wWhzOi2PAKcNMBoXCPv2UhyZjIbrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVJa/NO04B0FF8fW1pjOaZiTDk/HG7CKpaAyhVW8pobq4XwTIya40MJw9nDRS+Ags
	 OOOGIuCWN9TmYOmrrWqXIhMsRfsQl8G2z7rOhuoi3yQIb2snOQ6vJ4z812Wlkal3Su
	 8SWULZVJ5KTGjnpCJTRwMgrjhJw5lO54SHtwuHSKW2wBbc3yO0yHUrd0pMkWjJN7oC
	 lpZSzTBwMobvX4dkU8QseOm7soR8RN2WiqFGOPmSdZY1WgCQ5NblfkDVhM3f0M1T8Z
	 jl9j0MqpL0bjfL71+JX4HVZIpWfbeDqHFHnCtHMEi0yDCZm//cjKqL60Cg5ZePc5+D
	 U/Ezs6sBr+RKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/14] drm/panic: Return from screen_user if display
 is too small
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, gary@garyguo.net, linux-hyperv@vger.kernel.org, ojeda@kernel.org, virtualization@lists.linux.dev, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260911124540.279841-8-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:53 +0000
Message-Id: <20260911125453.EEE541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Return an error if the display is too small to display at least a
> single character. If the panic handler cannot display any message
> it does at least not destroy the current output, which might help
> with identifying the problem.
>=20
> v4:
> - also check font height against scanout buffer (Jocelyn)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D7

