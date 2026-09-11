Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4A47F3D9;
	Fri, 11 Sep 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131699; cv=none; b=ISujdY/afk0dtJ/L+NtWW0WN9jFtWRXxT+vvDPEfW7zWajyL9KFaJ9XJvjDuaSSrIkBsThPafPaHgzt1I4yT7j4AJ1jESiRxXS/cO3FUMtZF//JrWQCSyvJcYzCnAV3TXn+dFW3maW5Az1yM4ltOEIvgInN7X28GcYlSZUFFR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131699; c=relaxed/simple;
	bh=ITWwrU1+lRmLuva48oLsKTlgUumBuY7FaZNMvnW/XTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/lyRsETsHw/iA/1l3cYW2a675f6Mb1YSi+E6J8vhRpKpVZUocoFKnlFiDs9SUiQ0QQFycP3Gi3RAtzbWledi63mF6rBtRsOy+SkyHRetJhCpvk8mKquwBvfWXKRbrqN8Sb9t3V9sufNSETLa5G+FLSjZDlI+H+82PNNqT8yQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIHTr6sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIHTr6sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EEA1F000FF;
	Fri, 11 Sep 2026 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131682;
	bh=njJNqx2xN32J4SV/wSn1hvanaa80mVzmvuVh8G0EjAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIHTr6sSpk5e//l7q7kerPPajxMrnRUkF2npfHv6BrMyq2xheK/KRFkXkiwLsQap2
	 r2S7ppJiminXJFI58jHPB6HHOXQLRU/NmNjfEA89U5p5qfNqAYjByd6qJ1lRGeJAfy
	 mrIZsCBIJMygeXjpXaqmTATjbdPd9bmI2ueM5hDn92YMb0luJQR+4qdUKqqnarVQbm
	 w6fGUr0/5SnvtcHikUWUaFFjAIrsgUB82TXZ+1D2fAI5Yvlpmk3YBRGVxzBCybLJRH
	 gzMEZbfycDDCSWxyXZEwUufA5JjuNx6Z/hoL6IO8w9oK91UUVYeBWJ6P1ntwpijDY4
	 F8dllB0p0thSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] drm/panic: Compile KUnit tests as module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, Frank.Li@kernel.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, imx@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org, "Eugenio Perez" <eperezma@redhat.com>, gary@garyguo.net, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260911124540.279841-15-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:01:21 +0000
Message-Id: <20260911130121.78EEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=
=3Dy
> and make them build as a module. Export the necessary interfaces from the
> panic helpers iff the KUnit framework has been enabled.
>=20
> Select DRM_PANIC_HELPER from DRM_KUNIT_TEST to meet the dependencies of
> the panic-helper tests.
>=20
> It is now possible to run the tests by modprobe-ing drm_panic_helper_test
> at runtime.
>=20
> v5:
> - clear test description with drm_panic_helper_clear_description() (Sashi=
ko)
> v3:
> - clean up after each test case (Sashiko)
> v2:
> - fix parameter order in decl of drm_panic_helper_draw_screen_qr()
>   (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D14

