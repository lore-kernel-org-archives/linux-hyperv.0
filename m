Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD43D6472;
	Wed,  9 Sep 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946382; cv=none; b=IxHlBhnjuTc8W6qrQya8CwQIlsrayDFDl0x/meGetV0URncdj8zt0hFg692o7R9VGu+EsZGmffT3UXhiApvi9OXqKkii4rVtuEl7uLjIRRjgqVYmrVeW8b8b4GEcblOMibodK7/nos8uPLdMQdvU9u0UTXs9rS+s+b693fvhCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946382; c=relaxed/simple;
	bh=LgpRNDk0Oc7zvB/z2SKBRCMq8bP4rRuvCbi/f2DOcX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afo+xbet8SNjH3A48gs5Qsw6EbHLJyyUKGPb5ED7gTumaO8ZLEw86XJuGpSGkXASgH7+AjuOcTlh/4g6RFbvTL/bSqNuvsFjQPIxvKJsxcegsXAiWauOWAcEhjHXrKeP7g7hF5RQUcLHeCj161LAzlg9S9Yqbf6At08hqG24+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iegvzD2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iegvzD2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02581F00A3D;
	Wed,  9 Sep 2026 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946365;
	bh=pjZHiFRHuvig4QcBz8WoADhabzi1k9JT3b4nNK9B9To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iegvzD2E1kx7hSizRGHiMOswmqoAprg+Br1Aw423R9194IJZ+etFpV/rPjahaMqKE
	 81LR+RC1HvJMLV/Efvbt9Qm6ApupMF/dtPtCQvo2BiMAwWhq+hj+ORHY8DtvmS+gXb
	 qLiJLUeLqZ5uhmbELUM46bgKOeGqLYrXMTocjOMxZnsCXAKzo+p3cvO6uG2EPIN4mn
	 m11sf3tUbzccfkDQ3uX0wZJ65FBmtD7yjqAD2V0ZOArfu+n2e5RuOF6QxxBiU3iuVX
	 YHCwMih+14WXhr0Z4EJ8MatUL6TdVaS6rw8S3UJsqs/4Hurzd0+nEnQOvJh9eNf8gR
	 0bp6eJSD6iY8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] drm/panic: Move panic display code into helper
 library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, imx@lists.linux.dev, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, wsa+renesas@sang-engineering.com, intel-gfx@lists.freedesktop.org, ojeda@kernel.org, Frank.Li@kernel.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-14-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:32:44 +0000
Message-Id: <20260909093244.E02581F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] CONFIG_DRM_PANIC_SCREEN_QR_CODE can be enabled without its source c=
ode being compiled.
--

commit cfc7923d9a3badf08604fdffe1b2f5534bf2b0b6
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Move panic display code into helper library

This commit moves the panic display code and drm_plane_helper_display_panic=
_screen()
into a new drm_panic_helper.c library. It renames symbols and updates the Q=
R-related
code accordingly, linking the object files into the drm_kms_helper module.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e635fcffd3790..f0c340aa2ec60 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
[ ... ]
> @@ -157,6 +156,8 @@ drm_kms_helper-y :=3D \
>  	drm_simple_kms_helper.o \
>  	drm_vblank_helper.o
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) +=3D bridge/panel.o
> +drm_kms_helper-$(CONFIG_DRM_PANIC_HELPER) +=3D drm_panic_helper.o
> +drm_kms_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) +=3D drm_panic_helper_=
qr.o

[Severity: Low]
Does this allow CONFIG_DRM_PANIC_SCREEN_QR_CODE to be enabled without its
source code being compiled?

Since drm_panic_helper_qr.o is now built into drm_kms_helper, if a kernel is
configured with CONFIG_DRM_KMS_HELPER=3Dn and CONFIG_DRM_PANIC_SCREEN_QR_CO=
DE=3Dy,
the QR code source (drm_panic_helper_qr.rs) will be silently omitted from t=
he
build. The definition for CONFIG_DRM_PANIC_SCREEN_QR_CODE in
drivers/gpu/drm/Kconfig currently does not depend on or select DRM_KMS_HELP=
ER.

Should the Kconfig dependencies be updated to prevent this configuration
mismatch?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D13
