Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C443B27F3;
	Tue, 18 Aug 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058232; cv=none; b=kQ413pGmnHHit9dNV3okQWxfMfWmzXRd+s9DAmemcTtQC1NxznJ0sYmmO6oLKhzRkB/98Bff9I8uRd/a/da15X9rCXw1IClVDHQw5vQpfUKl1Qp6jLVHe/HffCwGSqlPaDDHN1SEhL0LjaUqOlRrOxvZDcA4C/m6O5xHFrq0uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058232; c=relaxed/simple;
	bh=kMLdHgDGAQwEj3GbAmZFDXN0Oh0pyavM6PRkuicY/vM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AzkqTyG+hq2MrxN1BV12oghtEWAI58M9wUs1yT5XDCBsObhtbzXAtW3/Yl52YACpF3AmJQDwX4iZ+NwLMvSOFur2/xs27P4MfWOHDiHrthFNJy6XgWHEdbLa7ITZYashmK1ZdRY+R71Oqiqgoml4g+ykcJHeU6qWwCR/BibENwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+P5Ru/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+P5Ru/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CC51F000E9;
	Tue, 18 Aug 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058230;
	bh=BT6TUKSfzL9GnZa97feyroupicTpFudSzUIqpKfpnFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+P5Ru/tYOkCTyu07ibkl2psgdrxYVZXOja3N941iO+kauUOcS4wJq4HmKQovC/vr
	 MdZz9dreZHynCmHwtEbcyoczemQ3VzNThQOr4vPmOuC+158LQ4BdPuHNDy2vTAMydu
	 z6ekco8F1HUNV0cLdBjkSgOcHVc/aauSmS809ykdxG+pZnJVcel7Hcvl68niJAqoBA
	 zPF3w/+HIo7Q/w4vHaoPvZLbA5DL2FM2hnREvRVbO/hNOcty+cBFg0K5qCK8/jMDeQ
	 XaYr8yl6kKoV6z906qg04ZK1mhagLPLiGfHYsUVHXnBRPEkwdxiaQPKXn7mo8yWuqe
	 jb0kVEKrSlPkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] drm/panic: Return errno codes if panic output
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260818125012.468092-5-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:03:49 +0000
Message-Id: <20260818130349.B3CC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] draw_panic_screen_qr_code() ignores the return value of its fall=
back function draw_panic_screen_user() and unconditionally returns 0.
--

--- Patch [4]: [PATCH 04/12] drm/panic: Return errno codes if panic output =
fails ---
commit 8764682ca919f839ac40d09290f5a67bb03da8dc
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return errno codes if panic output fails

This commit updates the panic output helpers to return errno codes on
failure. This allows the driver to avoid flushing the display if an error
occurs, preserving the unflushed display output for debugging.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -814,10 +818,11 @@ static int _draw_panic_screen_qr_code(struct drm_sc=
anout_buffer *sb)
>  	return 0;
>  }
> =20
> -static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>  {
>  	if (_draw_panic_screen_qr_code(sb))
>  		draw_panic_screen_user(sb);
> +	return 0;

[Severity: Medium]
Should this return the error code from draw_panic_screen_user() if the
fallback also fails?

Because this unconditionally returns 0, draw_panic_dispatch() will report
success even if both _draw_panic_screen_qr_code() and the fallback fail.
This causes draw_panic_plane() to still flush the display buffer, which
might overwrite the unflushed output this patch aims to preserve.

>  }
>  #else
>  static void drm_panic_qr_init(void) {};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D4
