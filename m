Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDC3B2D14;
	Wed,  9 Sep 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945775; cv=none; b=HydRcJvFNKMe90hOdqK6LTydXLk6LZaMzGGXJsAHkGpdF8R9MrdyiIVbZbtdfpZ6d3Iz8cnEjBCtdf8MKhtwwQJMwlN3Ebjpuk1oNEdoBnNjXgQR0QirXzxDEaQdMFpxUwjZcs96V+M/eJZqleEHZsz3eMh2N6E2XxnAQXe3zSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945775; c=relaxed/simple;
	bh=ge/1IGXJ4zYvxqcd4Aw09mlZOq8fPEmfY+YddOC4X/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXZRodtI1CgzaYSlehdUDY7FfOXxaUccedxTRgHyjVP/wRpWIL1/fgUcxzaiJMpfLVuZsneVFXDGLmHe5U1XiM6zDv8Joulz23RnQb9Z/8XLcsQC/TZTLn7y71SNmmMltbG52tvXLHAnOcVuvphtPYJS0h41r+EyEx1nkvvbOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVxWZoFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVxWZoFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F331F00A3A;
	Wed,  9 Sep 2026 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945773;
	bh=ge/1IGXJ4zYvxqcd4Aw09mlZOq8fPEmfY+YddOC4X/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVxWZoFYvMMY9fkqVEG5Xr0jZ+fkWw5/kC4NUYisO29JiI489kt42kKCHIYSRFQJV
	 W3C17ZC1Zd85U+uMltTNG4WqqsJSaEmWbVcFbF3vLD+0Byke5boxSc4lktGkDRhpHF
	 hWDaN13d0NGfmaLqLcbec1DuDW5pbvwq5FvHxUzRsO7yje1rcRU2KRnhYU9BhKyJTK
	 NPrz5d13SQ7rrJ7zB4nXHQiQRDmr3E8g1lblESvFRuhJNQb/8a7JT7God9KfjJgXDz
	 ++++lNmQ1J3ch4y9F7WY13aw9DmgNJhjVDFUi7JsrgnikGXK6vp1PXYYTnP4kAH8Td
	 fkJchNC093GHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/14] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, gary@garyguo.net, virtualization@lists.linux.dev, ojeda@kernel.org, linux-hyperv@vger.kernel.org, wsa+renesas@sang-engineering.com, imx@lists.linux.dev, Frank.Li@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-7-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:22:52 +0000
Message-Id: <20260909092253.29F331F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D6

