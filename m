Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EA369990;
	Wed,  9 Sep 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945197; cv=none; b=W3U/K2JhPDFL7SWjtRY/n1RqrtXbxbby8mb9mAsNZgrVJT0OSeigZt9LPvMtd+5WZlsMmUmtzEqXDU6kez7PQP6A4YWFEqHa4xxFpdazR2PolPWlMSHX+V7QGx0DL0RNFTQWyzw5y85SsDqSLxCp83b7VXK9EYHU6UvStymcdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945197; c=relaxed/simple;
	bh=hli6ez5KjFclPn4AlwREO1zYzgchjZ11BhJABfXphx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LhliTJWNvFye4Krn4E3IV5wdX6dunJu39ROSzq1Uya/p2qhq5y3wmTtJ96wDXLilSrhuVCp0T+MGDZiSbD358JUN96fzuux1Te+BeiTIxtkFwwIrmAolnGSwDxjblT1RdITseP8Y1/yNm0UbSL2T2dyrrDFZlgyhCz28hRkPZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk1G4sHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk1G4sHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34441F00A3A;
	Wed,  9 Sep 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945196;
	bh=hli6ez5KjFclPn4AlwREO1zYzgchjZ11BhJABfXphx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pk1G4sHWsG5uNAiwHqW4cbtZ6YQzGiYxFMWWrbXaKXHPIn0+3cPc8O8Mlzzofhb4I
	 RFAvh6B5ODHkRdrPV5ErVwxltF686pM02/X8tOi1vkuQTyfAEv8Z/3MmA4tTRkJ0vy
	 S+dOCt+k7RBh4bRHLydLxAREX7YZAwRoTChpOTEIAMJyD7c0SHfe71e2HXz0x0jfvX
	 0rfVrcRn33euDpiB0VcCo0eYGtUCMU1bjCgvgvqZveKZLX8k0uJka1syQefmdlxBzB
	 mKzwu/OrkVkNSBaZye5F9w9DtUGZ+f6zB0ZECzHs3cPAFi+KAMVkqt/yWtlFI4Ibe1
	 yw4se8pM/9uKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/14] drm/panic: Pass colors to
 draw_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org, gary@garyguo.net, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, Frank.Li@kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260909085826.64529-6-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:15 +0000
Message-Id: <20260909091315.C34441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Set the panic-screen colors in draw_panic_plane() as a single point
> of truth. Pass the values into the individual drawing functions.
>=20
> In the test cases, replace the Kconfig-defined colors with white and
> black. Allows for removal of the tests' limitations and dependency on
> the exact values. All tests now always verify the generated output.
>=20
> Hardcoding the test colors will later also allow for building the
> test case without having DRM panic handling enabled.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D5

