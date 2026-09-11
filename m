Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4E47CA71;
	Fri, 11 Sep 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131406; cv=none; b=Y1H7BsS3Hf88ltNzwp9INx8P+BI6jbu37XO8LBgycqlbvzDX7RyGhr87P8TO4tXK3GzXmelkOcds1OhG0APcrsH5f6NHMs+v9yw/umqf9S8o11rbO+kAUjHzSAaL9z137iE4pXOdVVO0kh8CUGgTTOL48aSwfVq9AwDKgwxYRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131406; c=relaxed/simple;
	bh=FAY5lyJ7IDLBX0N86QizjsEGHvzbqF2RXoIapFP/Rts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kfh/eGQoJwfuoyNdde23JIXZPyKe0vTSk0fkglAmcFvMaNMeQXxfn0LPEBvJnn8BZnHV7c9jDYRgErRTL1tAtocEhi5KoShUZwPIR2H7l6BsVXjjAxIxHGkPZDgBw+9bfwefnAE2DXVihXuIRRIoUJXbZQp0U4//c7fRDDXLaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj+W32BT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj+W32BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D861F00893;
	Fri, 11 Sep 2026 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131390;
	bh=FAY5lyJ7IDLBX0N86QizjsEGHvzbqF2RXoIapFP/Rts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aj+W32BTkOVtHhWDXjjWNDCMVmF4gX4IJQclEHwOWPN2gSByAhxi4QlntgEOjprxU
	 M/r4Dbz8YQtgC6yBxObRSYqMJ85Fe0H4Ki2/CpUMZy4TtkqxJ6XHu0ZnYSfaZOtMpF
	 gihQ57u6LpVMq2oRF+wJN7IXEPcDiPeFixc+hsh8U28nxkjOW0dWHALZ/iUJ3P0PNB
	 YijPyVGmHksc1dCecaUYj0UfJDR7tYSkVXBUgd3L0wDLk0pdQlhdbdyJ4lm4JsR3y4
	 aBZN+YDUzmYoEY+IjdTnkXsdxWWPye2P17N7X1bp7IATaYvTeRMmSaQq1NoZBN/PvY
	 jdiftp8hpic5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/14] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com, ojeda@kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, gary@garyguo.net, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-7-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:56:29 +0000
Message-Id: <20260911125629.A9D861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Set the panic type and QR version in draw_panic_plane() as a single
> point of truth. Pass the values into the individual drawing functions.
>=20
> In the test case, always create a QR code with version 40 (i.e., the
> highest supported version).
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D6

