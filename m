Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5D4749E3;
	Tue, 18 Aug 2026 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058819; cv=none; b=QtDP2xha4Th64S4AB+/U0UxxYLPY0XaUikgcwfuXBmlXvHvLrcgJd9p9hzD/Ikhecl6WOUfcrBsAv8/MGXWmGKCIbpzAZXX2FTKQ0odnRj8IuVE7KrhU4c/26ceRra8JWKAAh5fIyK6E6zL5F/MjMNtlUGuP5avWQew0ZiTrW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058819; c=relaxed/simple;
	bh=5yH5hQ6Q08W8n6QC35PMmpXDcPj+WFKx4bcibvoMmlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRRej2oaffhCpVc7laIRkjS0/F4IVqBq5FHOMJLB27+gs+aYeXSVebU0NF5G2Lb26zJLTuO8Flu0ADvWIPXZAt/K/ZhNDkaoPvQ2GQhSElaqA0fAdJSRVNH3ghu9XlrOllWryZyFX67JgBWYM6B5P/XSbzLoDFcsMNgvtD+K5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FofqkNJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FofqkNJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702441F00A3D;
	Tue, 18 Aug 2026 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058817;
	bh=8Pz74CHQ647IIVFmbLpghV+tSTi8VywV4inhV1WQvTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FofqkNJWQcN36rC7dCAbZX7G5hQOs+UYJNfRcF/pEXI521d7pRrSwq8Z+r4KOem0n
	 FpOSMVSz0K5dfYxpegYfLjwEi7TTcZ25btXsgQQFCDEiPY0Lq8wAQ5l7CvEHbi/EiP
	 x6Tn+jVkWpba4/xbUq84rKNyw9nK/1/+ROqDgHKkcS6bFhW+h8bbjqfc7Px9jlyTSB
	 Tp8jFoD5TM1uEdi73kA5diCHpzSHxRUt1tzJks7TLvhHFrq8vOeyvofxoJC8TCyz9/
	 VkpkFWhwfX+ufDs3d1JSwmky5flDcG9tFNQZok4tJQrU0Rjh8vfUo1BMpsGZoRzILz
	 jB7yrmx2c/jQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] drm/panic: Move panic display code into helper
 library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: wsa+renesas@sang-engineering.com, imx@lists.linux.dev, ojeda@kernel.org, Frank.Li@kernel.org, intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260818125012.468092-12-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:13:36 +0000
Message-Id: <20260818131337.702441F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing fallback stubs for `drm_panic_helper_init` and `drm_panic_h=
elper_exit` cause link failure when `CONFIG_DRM_PANIC_HELPER` is disabled.
- [Low] `DRM_KMS_HELPER` selects `DRM_PANIC_HELPER` without satisfying its =
`DRM_TTM` dependency.
--

--- Patch [11]: [PATCH 11/12] drm/panic: Move panic display code into helpe=
r library ---
commit 3d718c4f09d4c3ad0b378e7ca17f9b9b1d4d1627
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Move panic display code into helper library
   =20
This commit extracts panic display functionality from drm_panic.c into a
new drm_panic_helper.c file. The KMS helper module is updated to link
this new helper object, and relevant Kconfig and Makefile entries are
added.

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f6..cdfd72d9a9c5e 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -45,6 +45,7 @@ config DRM_MIPI_DSI
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_PANIC_HELPER if DRM_PANIC
>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	help

[ ... ]

> @@ -130,6 +131,10 @@ config DRM_PANIC_SCREEN_QR_VERSION
>  	  Smaller QR code are easier to read, but will contain less debugging
>  	  data. Default is 40.
> =20
> +config DRM_PANIC_HELPER
> +	bool
> +	depends on DRM_TTM

[Severity: Low]
Will this cause an unmet direct dependency warning in Kconfig?

DRM_KMS_HELPER selects DRM_PANIC_HELPER, but it doesn't inherit or ensure=20
the DRM_TTM dependency is met. If a kernel is configured with DRM_KMS_HELPER
and DRM_PANIC enabled, but without DRM_TTM, it might lead to Kconfig warnin=
gs
or a build failure.

> diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/dr=
m_kms_helper_common.c
> index 0c7550c0462b5..b5d5b469b4443 100644
> --- a/drivers/gpu/drm/drm_kms_helper_common.c
> +++ b/drivers/gpu/drm/drm_kms_helper_common.c
> @@ -27,6 +27,20 @@
> =20
>  #include <linux/module.h>
> =20
> +#include "drm_panic_internal.h"
> +
> +static int __init drm_kms_helper_init(void)
> +{
> +	return drm_panic_helper_init();
> +}
> +module_init(drm_kms_helper_init);

[ ... ]

> diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm_p=
anic_internal.h
> index c68d64c56e156..8aa91e80eb4dc 100644
> --- a/drivers/gpu/drm/drm_panic_internal.h
> +++ b/drivers/gpu/drm/drm_panic_internal.h
> @@ -52,4 +52,8 @@ static inline void drm_panic_lock(struct drm_device *de=
v, unsigned long flags) {
>  static inline void drm_panic_unlock(struct drm_device *dev, unsigned lon=
g flags) {}
>  #endif
> =20
> +/* drm_panic_helper.c */
> +int drm_panic_helper_init(void);
> +void drm_panic_helper_exit(void);
> +

[Severity: Low]
Does this cause a link failure when CONFIG_DRM_PANIC_HELPER is disabled?

The calls to drm_panic_helper_init() and drm_panic_helper_exit() in
drm_kms_helper_common.c are unconditional. Without fallback static inline
stubs in drm_panic_internal.h when the feature is disabled, it seems this
will lead to unresolved external references during the linking phase.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D11
