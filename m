Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239383D7D7E
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739771; cv=none; b=Xu+Yuk6jJ0l7TTOMMtixCR9twt2eAUnTs0z8MZ3/XiFNxdQ0kwS8xJ1XJT1PFefiZcEqj0RUgNVfdMs9TimyFXJh2EAtjUBMz9sCmtmpxIPMu/HFpuys7eUuolRB52OP3KHLVg7rpsEAD/zCd3LMWYEHSjalm+zjm4i6P3a+lKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739771; c=relaxed/simple;
	bh=ZXyeXbmf2Jx9G0bi0Ar+/cVikbnPgAcfIHVtGvDpBQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tjvnR908zxhbKetVTOcmTliAU2GlSpbFLb48iGTlRT9IUoEsgjFAxxlCch1/o/Bch5Bxb1eSvhOqgEL8MaTtbBNY3TKqWHUaGP34iT4jRQxKMaVtIBajNw+ksnvjzPevFpx4g6yZttq+RI43e8afCWg1sL+1/22ZXTJaieFQiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ02O2EE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ02O2EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XmXy8TGZMtUdUflzhbcwpO5PBzlQNsR1Xi5VVFI9N3E=;
	b=KJ02O2EE8JUjcWUlPfp4oADSPPWNt24rTuZNdaTbYBjbXv5a0KuV1H+OzyPJ0UEkKPv6es
	Vfy1zQ1K7ZUkAUTy/o9gypPvE2tz4j+Sibx7FKyTLhZgDoRgyqj4x0ZKFkK+i02KCUEbXs
	9sv0+gxBzObpHScitwMv+kWAXlCBW2Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-zePa_GbsMtmTsuH5SevbYw-1; Fri,
 14 Aug 2026 16:35:54 -0400
X-MC-Unique: zePa_GbsMtmTsuH5SevbYw-1
X-Mimecast-MFC-AGG-ID: zePa_GbsMtmTsuH5SevbYw_1786739751
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6B6219560AE;
	Fri, 14 Aug 2026 20:35:49 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02CAB197750F;
	Fri, 14 Aug 2026 20:35:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-samsung-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	intel-gfx@lists.freedesktop.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	spice-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev
Subject: [PATCH 0/5] drm/vblank: Enforce all-or-nothing vblank support
Date: Fri, 14 Aug 2026 16:35:28 -0400
Message-ID: <20260814203542.1405135-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

One of the oddities with DRM that is leftover from the old days is how
vblank support is implemented by drivers. This has caused some minor
issues for the rust bindings for KMS which could be worked around.
However, it seems like a much better idea to fix this on the C side.
Those oddities are mainly:

* There's nothing in the vblank core that actually ensures that all
  CRTCs implement vblank support if one of them do. On Rust's side, we
  can't have this and have to ensure either the whole device has vblank
  support or not - otherwise it would be quite painful ensuring we don't
  expose vblank methods to drivers that can't use them.
  This additionally means such a situation would lead to UB.
* There is a second variable for keeping track of the number of CRTCs
  and it's kind of broken and confusing. Even worse, we currently allow
  the vblank API to allow a driver to specify a different number of
  CRTCs then it actually has.

So, let's just go ahead and fix this across the whole tree, and enforce
that a driver must either implement hardware vblank support for all
CRTCs or no CRTCs.

Lyude Paul (5):
  drm/vblank: Add drm_device.has_hw_vblank
  drm/vblank: Remove drm->num_crtcs
  drm/vblank: Remove num_crtcs argument from drm_vblank_init()
  drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()
  drm/vblank: Require all CRTCs implement vblank support in
    drm_vblank_init()

 drivers/gpu/drm/adp/adp_drv.c                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/armada/armada_drv.c           |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/drm_vblank.c                  | 60 ++++++++++++-------
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 drivers/gpu/drm/gma500/psb_drv.c              |  2 +-
 drivers/gpu/drm/gma500/psb_irq.c              |  4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  2 +-
 .../drm/i915/display/intel_display_driver.c   |  3 +-
 drivers/gpu/drm/imx/dc/dc-kms.c               |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |  2 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c           |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
 drivers/gpu/drm/kmb/kmb_drv.c                 |  2 +-
 drivers/gpu/drm/logicvc/logicvc_mode.c        |  2 +-
 drivers/gpu/drm/loongson/lsdc_drv.c           |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/msm/msm_kms.c                 |  2 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c     |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c            |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c             |  2 +-
 drivers/gpu/drm/radeon/atombios_crtc.c        |  4 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c   |  4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  2 +-
 drivers/gpu/drm/sprd/sprd_drm.c               |  2 +-
 drivers/gpu/drm/sti/sti_compositor.c          |  2 +-
 drivers/gpu/drm/stm/ltdc.c                    |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tegra/drm.c                   |  2 +-
 drivers/gpu/drm/tidss/tidss_kms.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
 drivers/gpu/drm/tiny/bochs.c                  |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c            |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |  6 +-
 drivers/gpu/drm/verisilicon/vs_drm.c          |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c      |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c          |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c             |  2 +-
 include/drm/drm_device.h                      | 10 +++-
 include/drm/drm_vblank.h                      |  2 +-
 64 files changed, 114 insertions(+), 92 deletions(-)


base-commit: 568d4cb5dcc5ec4e22975699b6ea67a30806884c
-- 
2.55.0

