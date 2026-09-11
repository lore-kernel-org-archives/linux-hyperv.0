Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44B2F3632;
	Fri, 11 Sep 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131261; cv=none; b=eRztm7BxYVxjeV8E9WkbcYuUDiB3KRGbT06lbwezuFQlxH3aNGSxurvkGy5dd94uOK3/fdbjdOTNzeqpjhAtj+uyoNUew9+5YuneCg7cqj5I6CWqxXZT9LOYrPx7xCTOCFSVZCEPD0y+X9VTCPalSGmyilcaCJ414qGv5O5OUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131261; c=relaxed/simple;
	bh=8hLvPolZrAyN/rGoUtfPMpPK6CQmAiX4OmkzSPa0rh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwCLaQYH8oDAFN1ebj5DtYdAEZz0Lm+w+qPAeyMQRikG773s+fOaymFB//S+74IvuLj/aGLbQE+BciQuYOIx97W7IHywjnsl4pebuyB7WuWEQvMt8jXjxtJlH/SIHKQAedZJ5YqGd55yUhJl4fsBUFiPA+aOQoN8o28ORWrmBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC8PyTEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC8PyTEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0791F000FF;
	Fri, 11 Sep 2026 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131260;
	bh=8hLvPolZrAyN/rGoUtfPMpPK6CQmAiX4OmkzSPa0rh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aC8PyTEzip00grSpA+yc5tO7c3jmNteMdmDM0X5/VHKM2PiIZumdVT/KmF1mNdeo6
	 zqP191S/Gr9ThbJlxqUPTSsk0BpY4NYEJ018FyM2mCyhzy8GbgJP2xMWSzx07fccF6
	 nYesRYaQ15i3irzA7SaB42uN7vEvLlPagZcD0aF/esvBkLhJUyPjYFhtVb63/uBmnV
	 FDR/448pL+TgpGos274erhNm5/jpIrPj/CbYrYEI0C4byipOE1t0UI4GbRHzNqb1yG
	 hWL14aKE5ODKIFJxaOiR3MPqv/gvhnTwvcyq/UH1Hqw0aLYREkuQVFg6xBZzh+LPen
	 D4g9IZXxXowZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/14] drm/panic: Pass colors to
 draw_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, "Eugenio
 Perez" <eperezma@redhat.com>, ojeda@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-6-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:19 +0000
Message-Id: <20260911125419.6D0791F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D5

