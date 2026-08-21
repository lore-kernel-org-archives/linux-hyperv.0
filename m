Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F152490BFA;
	Fri, 21 Aug 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323164; cv=none; b=bn7ivDAhJDUto/3NieNgwovXpcK/XeUOPVoQcWtYOCLDoOb+UoaW3BzjCLkQkHtE8fXwFNa+OD4Ysz1BsLk00bNmtICezJMKFOmld6JiHwGpMFj419ECziFhvpH9HmzOL5zlMlJoG9mASAwoBPM/MJo8JFz4fcOA97/2DX98HpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323164; c=relaxed/simple;
	bh=XrpjqpxeU7ALF5OLpK2WpdbG15zlPyFx5PlM9LAlHdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IY5Zn+nNslg2BV3OmdtRu9dgfx1uVjP+uAEuRJVXXmH1nJC9E/RN+5Tibte8xkEZKKnCQFIgWFOGe/r9huEAbRPwlRuOqzYgIpeoppvqrFpsw4uKR3LucWm/gjVcapSlueSEJzb17qWbjYkil3xKvbr0cblouju235EEkHz0ncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN1u/yS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN1u/yS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B61F000E9;
	Fri, 21 Aug 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323162;
	bh=1is4vlPBYIemAGJNcyTfyeB4LcQTBxiGBN1U0sCNEMs=;
	h=From:Subject:Date:To:Cc;
	b=FN1u/yS7xdcJbsStZ+nKUxoMvs+kEhII7QUNCGLCDiEhPuJw8j37Gjf3ioEGHsays
	 B4R6H/mGhya901xaI8+TExbsArw8P2XBnjAaCN0Z/T6tQ3ZOnXhBqOG9Y/MCuxFQ6C
	 HN/AQR2D5n3xrnHkUZefY218B3odTqpVVkxm7+dJ5uNAgi1zBZ7kt0gno/MpL1h+Xb
	 MKG/JonL4EzBXyXM3CGkhUnJDh8c16VtEqLvL0r3/Mmy54DYjR08fTieu12GmNe5E0
	 pdEgW/sYqNxYCl6bEerjcj1H24XdynDHugbHesM92juDFZ/tIH8ZmNuSGm3l1YgeXa
	 Bk7E97B55Zwjw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/70] drm/crtc: Convert all drivers to atomic_create_state
 and remove reset
Date: Fri, 21 Aug 2026 16:38:36 +0200
Message-Id: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ7CIAzG8VchPdsEFnRur2J2YFC1B0ALmiXL3
 l3mjv8v6a8rFBKmAqNaQejLhXNqYU4K/NOlByGH1tDp7qJ7PWCQiCljzELopXoUKlTRWGfDefb
 XYA2045fQnZc/fJuOFnp/ml+PEWZXmpBj5DqqXY1cPCZaKu7PUPeoB5i27QeOVHDlpAAAAA==
X-Change-ID: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Liviu Dudau <liviu.dudau@arm.com>, Russell King <linux@armlinux.org.uk>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>, 
 Ruben Wauters <rubenru09@aol.com>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>, John Stultz <jstultz@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, Dexuan Cui <decui@microsoft.com>, 
 Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>, 
 linux-mips@vger.kernel.org, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Jerome Brunet <jbrunet@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 Marek Vasut <marex@denx.de>, Dave Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aditya Garg <gargaditya08@proton.me>, Aun-Ali Zaidi <admin@kodeit.net>, 
 LiangCheng Wang <zaq14760@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Huacai Chen <chenhuacai@kernel.org>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, 
 Qianhai Wu <wuqianhai@loongson.cn>, Xi Ruoyao <xry111@xry111.site>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 nouveau@lists.freedesktop.org, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>, 
 linux-rockchip@lists.infradead.org, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10779; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XrpjqpxeU7ALF5OLpK2WpdbG15zlPyFx5PlM9LAlHdY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSd+XbtrDvPLAypKrqwIuJBVtKGP58e3vNoGDLkZFC
 yNyzqqYdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJRGgxVrO/2eF1MjFl/cHs
 Jxsn5npdOsF9VzR9SUlnHHvK7MgDb5U7ja6LGKsfk5sjoxNiGpPyibE+bdafRRv8i237pSPUjJy
 TN8z19j5uyFy45IQqZ1NX/r7E2TskJUSfuzM9XtUaqtnAHgQA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

This is a follow-up to the plane reset removal series, and part of a
larger effort to remove the reset hook from all KMS objects.

The CRTC reset hook is overloaded: it is called both at probe time to
create the initial software state and during suspend/resume to reset
hardware and software state. These two roles have different
requirements, and the reset hook is not fallible, making error
handling difficult for the initial state allocation path.

While reset has the semantics to reset both the software and hardware
state, the vast majority of implementations and all the helpers only
reset the software state, making them equivalent to
atomic_create_state in practice. The atomic_create_state hook makes
this explicit: it only allocates and initializes a pristine state
without any side effect, and returns the state pointer or an ERR_PTR
on failure.

This series converts all CRTC drivers tree-wide from the reset hook to
atomic_create_state, then removes the reset hook from struct
drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
hardware reset logic mixed into their reset hook; those are moved to
CRTC creation instead. The conversions were done using a combination of
Coccinelle semantic patches and manual adjustments.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (70):
      drm/adp: Switch to drm_atomic_helper_crtc_create_state
      drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
      drm/arm: hdlcd: Switch to drm_atomic_helper_crtc_create_state
      drm/armada: Switch to drm_atomic_helper_crtc_create_state
      drm/exynos: Switch to drm_atomic_helper_crtc_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_crtc_create_state
      drm/gud: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_crtc_create_state
      drm/hisilicon: kirin: Switch to drm_atomic_helper_crtc_create_state
      drm/hyperv: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dc: Switch to drm_atomic_helper_crtc_create_state
      drm/imx: dcss: Switch to drm_atomic_helper_crtc_create_state
      drm/ingenic: Switch to drm_atomic_helper_crtc_create_state
      drm/kmb: Switch to drm_atomic_helper_crtc_create_state
      drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
      drm/meson: Switch to drm_atomic_helper_crtc_create_state
      drm/msm: mdp4: Switch to drm_atomic_helper_crtc_create_state
      drm/mxs: mxsfb: Switch to drm_atomic_helper_crtc_create_state
      drm/qxl: Switch to drm_atomic_helper_crtc_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_crtc_create_state
      drm/simple-kms: Remove unused reset_crtc hook
      drm/simple-kms: Switch to drm_atomic_helper_crtc_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_crtc_create_state
      drm/sprd: Switch to drm_atomic_helper_crtc_create_state
      drm/sti: Switch to drm_atomic_helper_crtc_create_state
      drm/stm: Switch to drm_atomic_helper_crtc_create_state
      drm/sun4i: Switch to drm_atomic_helper_crtc_create_state
      drm/tests: Switch to drm_atomic_helper_crtc_create_state
      drm/tilcdc: Move hardware reset to CRTC creation
      drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: appletbdrm: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_crtc_create_state
      drm/udl: Switch to drm_atomic_helper_crtc_create_state
      drm/vbox: Switch to drm_atomic_helper_crtc_create_state
      drm/verisilicon: Switch to drm_atomic_helper_crtc_create_state
      drm/virtio: Switch to drm_atomic_helper_crtc_create_state
      drm/xlnx: Switch to drm_atomic_helper_crtc_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      sysfb: Convert to create_state
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/imx: ipuv3: Convert to atomic_create_state
      drm/loongsoon: Move hardware reset to CRTC creation
      drm/loongson: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/mgag200: Convert to atomic_create_state
      drm/msm: dpu1: Convert to atomic_create_state
      drm/msm: mdp5: Convert to atomic_create_state
      drm/mxsfb: lcdif: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omapdrm: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rzg2l-du: Convert to atomic_create_state
      drm/rockchip: vop: Convert to atomic_create_state
      drm/rockchip: vop2: Convert to atomic_create_state
      drm/sitronix: st7920: Convert to atomic_create_state
      drm/solomon: ssd130x: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/vkms: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset

 drivers/gpu/drm/adp/adp_drv.c                      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 17 ++++----
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 18 ++++----
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |  2 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  | 18 ++++----
 drivers/gpu/drm/armada/armada_crtc.c               |  2 +-
 drivers/gpu/drm/ast/ast_mode.c                     | 18 ++++----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 19 ++++-----
 drivers/gpu/drm/drm_atomic_state_helper.c          | 45 --------------------
 drivers/gpu/drm/drm_mode_config.c                  |  4 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            | 13 +-----
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |  2 +-
 drivers/gpu/drm/gud/gud_drv.c                      |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |  2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  2 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |  2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             | 18 ++++----
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  2 +-
 drivers/gpu/drm/kmb/kmb_crtc.c                     |  2 +-
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |  2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               | 26 ++++++------
 drivers/gpu/drm/mediatek/mtk_crtc.c                | 18 ++++----
 drivers/gpu/drm/meson/meson_crtc.c                 |  2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |  4 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             | 15 ++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           | 18 ++++----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          | 20 ++++-----
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  | 17 ++++----
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  4 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            | 14 +++----
 drivers/gpu/drm/omapdrm/omap_crtc.c                | 17 ++++----
 drivers/gpu/drm/qxl/qxl_display.c                  |  2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     | 17 ++++----
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      | 15 +++----
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 18 ++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 18 ++++----
 drivers/gpu/drm/sitronix/st7571.c                  |  2 +-
 drivers/gpu/drm/sitronix/st7920.c                  | 10 +++--
 drivers/gpu/drm/solomon/ssd130x.c                  | 10 +++--
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  2 +-
 drivers/gpu/drm/sti/sti_crtc.c                     |  2 +-
 drivers/gpu/drm/stm/ltdc.c                         |  4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |  4 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          | 20 ++++-----
 drivers/gpu/drm/tegra/dc.c                         | 18 ++++----
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               | 49 +++++++++-------------
 drivers/gpu/drm/tiny/appletbdrm.c                  |  2 +-
 drivers/gpu/drm/tiny/bochs.c                       |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |  2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |  2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |  2 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     | 14 +++----
 drivers/gpu/drm/vc4/vc4_drv.h                      |  2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |  2 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c              |  2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  2 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   | 18 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 22 ++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  2 +-
 include/drm/drm_atomic_state_helper.h              |  3 --
 include/drm/drm_crtc.h                             | 12 ------
 include/drm/drm_mipi_dbi.h                         |  2 +-
 include/drm/drm_simple_kms_helper.h                |  1 -
 78 files changed, 275 insertions(+), 385 deletions(-)
---
base-commit: 7ea58b9ddb52264a4ed36bccb975062ada32c62d
change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

