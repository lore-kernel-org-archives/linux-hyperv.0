Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6844F540;
	Fri, 11 Sep 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131313; cv=none; b=oqi1XzWqf1EOdO6gYoOMDW0QKuKxwdFT+77UCJ5ZYVvqBzlaC2De5Kd78ubDQMjrIE7INPNyATEIRTny5Hf+3zSRt/AlLQADnL0otGBt1ZBRmOho+CX4JzlLWnq5DRcwQwfsvVAvjOogRMJk6ZmLgpInyOc0ggcNFzIou395Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131313; c=relaxed/simple;
	bh=an0BVH+ZbY2/m5yLlE1s2KfrTVlB5o9WmKtC+kS3FTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IO0s6K9vgX4iGPCnQLnY/NNmejXQCeBF3r/mYturF+rkELP61SzFPlQ3VqnVtaqGCTDee3nKiqiGt3nU6QsgO589+Chdkh8lcto8RLwA9MT+aLPA5G7ibY/oISoa0oDj1wQ7wKaJo8wS16tN1u9cpHCMfMHqBTCtICM35VT6hIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYQIhxm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYQIhxm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512D21F000FF;
	Fri, 11 Sep 2026 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131312;
	bh=an0BVH+ZbY2/m5yLlE1s2KfrTVlB5o9WmKtC+kS3FTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYQIhxm8bz+zg3lMoJknpy4qOCj0QpHQhMVBHgxVD1MAsux/FRPCzEXSZtIbKVzgO
	 fL16HDUJ6KBvYQvJxw21Y9OjRrhKsug0pl3MRzoDy/KApNrICjxLUFJvd4vE1Rmwgh
	 U9/DnVU4R1tnIgllFmMgBAhjKXm5NJxbUI8IgsL9q6q/zFMkKNmAWEAgA4JEws7L0g
	 qeHPs5hnc12mj5HhbG/3Cbj4s/39M4tom1QpfochVtBD8jL0uE1K7GcCli4qRW2l25
	 Ee9exB/eCUIJYgVDOaSj3/uK8Hz9/afWAceSjOf1zveiiXRLNu78HqvQpCUa6Poljh
	 FaIXcRBORaaEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/14] drm/panic: Restrict to primary planes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org, "Eugenio Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com, gary@garyguo.net, imx@lists.linux.dev, intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260911124540.279841-11-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:55:10 +0000
Message-Id: <20260911125511.512D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Restrict panic handling to primary displays. Overlays and cursors
> should not display panic output. If there are exceptions, they can
> be registered by the driver itself.
>=20
> v3:
> - also update drm_panic_is_enabled() (Sashiko)
> - still do some testing when unregistering (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D10

