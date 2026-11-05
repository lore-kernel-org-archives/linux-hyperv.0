Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892615;
	b=4Mc9tdS1YrcDl2vC53qXHBMdMZZcvFszk4gQrMK+NnZccewfCHTyFPSahgVIFPV1bj8A
	 NkCEZ6ANnTIXUjI7l11Ae2u9bOgJJFd8Hpyu/GBCrppTshvoVjO7aoPZity9GvZzm1o31
	 Pbw57kmnfPyzMfoK2kun2qnt1hGD1zMecz36pcSQSl6eLud7wm98a3sqaT8h7Uy0I7Ueu
	 g+UYNKj2FEnpqcL31x3R0Ma3TTR7wkyjOBJey+4G3ec93536LEBFkppUh/5q1/EgVMRko
	 bDEKfTvik9EHz6WwPFefcWCJsUHakBQGWNH8c0yPEd0E3AMOX3D65XsJn0NJGGnZrmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892615;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=p6o5IOQrCtTZjQsAqZ9AgWrfdOJt0BRDOEbu1VBkyyA=;
	b=sfRwUOqt2nR7N2/BRb7j/pql6o4exCZziiKbmv0ert4gYQLBvreUnDP9iNTXcxJlvJfX
	 djLEcR0SVu18XQtVvlWYMlVpcfS7RQ/it8EHksqoPaSSpIkKn5F74uBV4nyVI1V8y15w1
	 2oX03X7ej2jf2SJWnIZRDzHc5oEA/8zziZwjUztRUgZ4qvUlcRWoc6t1Rd9uXFD1wvhnr
	 HPQLGsnh97o62/3PN/gU04CnOCQZWs8laWm+y/RfGdX+sUjiHmY8wTshVehZqxl5UXSrj
	 DR3+dsllYX72cgdgRrGlKHLKWcmP/jzCM6SJklIAMiXuOuIYATFt4ZMmFmpuCshFK9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7yn3kWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720C606EE8D;
	Thu,  5 Nov 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7yn3kWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6B01F000C1;
	Thu,  5 Nov 2026 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892614;
	bh=p6o5IOQrCtTZjQsAqZ9AgWrfdOJt0BRDOEbu1VBkyyA=;
	h=From:Subject:Date:To:Cc;
	b=M7yn3kWG1Qc488J1DGqNkHdE+t2ksGsS4IFAcx7p845ZbuJDUND9uzqIDSyC+Zaap
	 DTXtpzRN0rcZU5xBc+djN5anrHsgozqM3eAbGlCKw6PP9G/ZWS8hY1h1iRzBrEUQj8
	 YBHYkR+rap81/1mzfvc3YJLI9spIOn2ublHxCD7Xi2W+YmTB2wZI9pgRe3uni1kfq+
	 s8OfYr2lugjdxpPJ+kUfo+c5r5F0b0EARbn/KFcURgCsPlYzGJbH42r08ksn/MDqjW
	 jDgXUYboJgZQtyfDcA27Ir5Wd4sFX35kEkIQNtp6+j4EBAa6Ay5Zu8B1jEj5rGrPEs
	 VmO9Pb+Dpo6iw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH RESEND 00/83] drm: Switch drivers to
 drm_mode_config_create_initial_state
Date: Thu, 05 Nov 2026 16:29:09 +0100
Message-Id: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Aun-Ali Zaidi <admin@kodeit.net>, Liviu Dudau <liviu.dudau@arm.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
 Lucas Stach <l.stach@pengutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, Linus Walleij <linusw@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 Marek Vasut <marex@denx.de>, Danilo Krummrich <dakr@kernel.org>, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 David Lechner <david@lechnology.com>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
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
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 Jyri Sarha <jyri.sarha@iki.fi>, Alexey Brodkin <abrodkin@synopsys.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Alex Lanzano <lanzano.alex@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Michal Simek <michal.simek@amd.com>, Aditya Garg <aditya.garg@linux.dev>, 
 Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14157; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hiyckXiJ1VawveVxqMKwp9AP/VPzPnmsprkBFkY6wdY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFty1eNjzapGodOed082zqh9cnCY2K/Rxvuitqy9zs
 /OO/3dj6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATSf3B2LD2sryDw1e19fL1
 9YuPW/G4H82emR37kedNzpT5B+0XnDnW4/5+c29LYqnASxPlw+IlUoz16U6r9817c0R2hcvm9Ec
 KRzI+TdkXEK6umN/Zv8LUZf1DoaafHXGfWi1lFvflHeeIy1IEAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles. However, the two roles need different
behaviors, notably for objects like drm_private_obj that must persist
across suspend/resume and are excluded from drm_mode_config_reset()
by design.

Previous series introduced drm_mode_config_create_initial_state() to
handle only the initial state creation at probe time, including
drm_private_obj. Unlike drm_mode_config_reset(), it returns an error
code, allowing drivers to properly handle allocation failures.

This series switches all drivers calling drm_mode_config_reset() at
probe time to drm_mode_config_create_initial_state(). The conversion
was done using a Coccinelle semantic patch.

This is part, and the final piece, of a larger transition to remove the
overloaded reset semantics from the KMS subsystem, following similar
series for planes, CRTCs, connectors, and bridges.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (83):
      drm/adp: Switch to drm_mode_config_create_initial_state
      drm/amdgpu: Switch to drm_mode_config_create_initial_state
      drm/appletbdrm: Switch to drm_mode_config_create_initial_state
      drm/komeda: Switch to drm_mode_config_create_initial_state
      drm/hdlcd: Switch to drm_mode_config_create_initial_state
      drm/malidp: Switch to drm_mode_config_create_initial_state
      drm/armada: Switch to drm_mode_config_create_initial_state
      drm/aspeed: Switch to drm_mode_config_create_initial_state
      drm/ast: Switch to drm_mode_config_create_initial_state
      drm/atmel-hlcdc: Switch to drm_mode_config_create_initial_state
      drm/exynos: Switch to drm_mode_config_create_initial_state
      drm/fsl-dcu: Switch to drm_mode_config_create_initial_state
      drm/gud: Switch to drm_mode_config_create_initial_state
      drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state
      drm/hisilicon/kirin: Switch to drm_mode_config_create_initial_state
      drm/hyperv: Switch to drm_mode_config_create_initial_state
      drm/imx/dc: Switch to drm_mode_config_create_initial_state
      drm/imx/dcss: Switch to drm_mode_config_create_initial_state
      drm/imx/ipuv3: Switch to drm_mode_config_create_initial_state
      drm/ingenic: Switch to drm_mode_config_create_initial_state
      drm/kmb: Switch to drm_mode_config_create_initial_state
      drm/logicvc: Switch to drm_mode_config_create_initial_state
      drm/loongson: Switch to drm_mode_config_create_initial_state
      drm/mcde: Switch to drm_mode_config_create_initial_state
      drm/mediatek: Switch to drm_mode_config_create_initial_state
      drm/meson: Switch to drm_mode_config_create_initial_state
      drm/mgag200: Switch to drm_mode_config_create_initial_state
      drm/msm: Switch to drm_mode_config_create_initial_state
      drm/lcdif: Switch to drm_mode_config_create_initial_state
      drm/mxsfb: Switch to drm_mode_config_create_initial_state
      drm/nouveau: Switch to drm_mode_config_create_initial_state
      drm/omap: Switch to drm_mode_config_create_initial_state
      drm/pl111: Switch to drm_mode_config_create_initial_state
      drm/qxl: Switch to drm_mode_config_create_initial_state
      drm/rcar-du: Switch to drm_mode_config_create_initial_state
      drm/rz-du: Switch to drm_mode_config_create_initial_state
      drm/shmobile: Switch to drm_mode_config_create_initial_state
      drm/rockchip: Switch to drm_mode_config_create_initial_state
      drm/st7571: Switch to drm_mode_config_create_initial_state
      drm/st7586: Switch to drm_mode_config_create_initial_state
      drm/st7735r: Switch to drm_mode_config_create_initial_state
      drm/st7920: Switch to drm_mode_config_create_initial_state
      drm/ssd130x: Switch to drm_mode_config_create_initial_state
      drm/sprd: Switch to drm_mode_config_create_initial_state
      drm/sti: Switch to drm_mode_config_create_initial_state
      drm/stm: Switch to drm_mode_config_create_initial_state
      drm/sun4i: Switch to drm_mode_config_create_initial_state
      drm/corebootdrm: Switch to drm_mode_config_create_initial_state
      drm/efidrm: Switch to drm_mode_config_create_initial_state
      drm/ofdrm: Switch to drm_mode_config_create_initial_state
      drm/simpledrm: Switch to drm_mode_config_create_initial_state
      drm/vesadrm: Switch to drm_mode_config_create_initial_state
      drm/tegra: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_atomic_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_bridge_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_hdmi_state_helper_test: Switch to drm_mode_config_create_initial_state
      drm/tidss: Switch to drm_mode_config_create_initial_state
      drm/tilcdc: Switch to drm_mode_config_create_initial_state
      drm/arcpgu: Switch to drm_mode_config_create_initial_state
      drm/bochs: Switch to drm_mode_config_create_initial_state
      drm/cirrus-qemu: Switch to drm_mode_config_create_initial_state
      drm/gm12u320: Switch to drm_mode_config_create_initial_state
      drm/hx8357d: Switch to drm_mode_config_create_initial_state
      drm/ili9163: Switch to drm_mode_config_create_initial_state
      drm/ili9225: Switch to drm_mode_config_create_initial_state
      drm/ili9341: Switch to drm_mode_config_create_initial_state
      drm/ili9486: Switch to drm_mode_config_create_initial_state
      drm/mi0283qt: Switch to drm_mode_config_create_initial_state
      drm/panel-mipi-dbi: Switch to drm_mode_config_create_initial_state
      drm/pixpaper: Switch to drm_mode_config_create_initial_state
      drm/repaper: Switch to drm_mode_config_create_initial_state
      drm/sharp-memory: Switch to drm_mode_config_create_initial_state
      drm/tve200: Switch to drm_mode_config_create_initial_state
      drm/udl: Switch to drm_mode_config_create_initial_state
      drm/vboxvideo: Switch to drm_mode_config_create_initial_state
      drm/vc4: Switch to drm_mode_config_create_initial_state
      drm/verisilicon: Switch to drm_mode_config_create_initial_state
      drm/virtio: Switch to drm_mode_config_create_initial_state
      drm/vkms: Switch to drm_mode_config_create_initial_state
      drm/vmwgfx: Switch to drm_mode_config_create_initial_state
      drm/xen: Switch to drm_mode_config_create_initial_state
      drm/xlnx: Switch to drm_mode_config_create_initial_state

 drivers/gpu/drm/adp/adp_drv.c                                |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                     |  4 +++-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c   |  3 ++-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c   |  4 +++-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c              |  4 +++-
 drivers/gpu/drm/arm/hdlcd_drv.c                              |  4 +++-
 drivers/gpu/drm/arm/malidp_drv.c                             |  4 +++-
 drivers/gpu/drm/armada/armada_drv.c                          |  4 +++-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                      |  4 +---
 drivers/gpu/drm/ast/ast_mode.c                               |  4 +++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c                 |  4 +++-
 drivers/gpu/drm/exynos/exynos_drm_drv.c                      |  4 +++-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c                    |  4 +++-
 drivers/gpu/drm/gud/gud_drv.c                                |  4 +++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c              |  6 ++++--
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c              |  6 ++++--
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c                  |  4 +---
 drivers/gpu/drm/imx/dc/dc-kms.c                              |  4 +++-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                          |  4 +++-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c                     |  4 +++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c                    |  4 +++-
 drivers/gpu/drm/kmb/kmb_drv.c                                |  3 +--
 drivers/gpu/drm/logicvc/logicvc_mode.c                       |  4 +++-
 drivers/gpu/drm/loongson/lsdc_drv.c                          |  4 +++-
 drivers/gpu/drm/mcde/mcde_drv.c                              |  4 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                       |  8 +++++++-
 drivers/gpu/drm/meson/meson_drv.c                            |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200.c                       |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c                     |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c                    |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c                    |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200er.c                     |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c                     |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c                    |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200se.c                     |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c                     |  4 +++-
 drivers/gpu/drm/msm/msm_kms.c                                |  4 +++-
 drivers/gpu/drm/mxsfb/lcdif_drv.c                            |  4 +++-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                            |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_display.c                    |  4 +++-
 drivers/gpu/drm/omapdrm/omap_drv.c                           |  4 +++-
 drivers/gpu/drm/pl111/pl111_drv.c                            |  4 +++-
 drivers/gpu/drm/qxl/qxl_display.c                            |  3 +--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c                |  4 +++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c                 |  4 +++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c             |  4 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c                  |  4 +++-
 drivers/gpu/drm/sitronix/st7571.c                            |  4 +++-
 drivers/gpu/drm/sitronix/st7586.c                            |  4 +++-
 drivers/gpu/drm/sitronix/st7735r.c                           |  4 +++-
 drivers/gpu/drm/sitronix/st7920.c                            |  4 +---
 drivers/gpu/drm/solomon/ssd130x.c                            |  4 +---
 drivers/gpu/drm/sprd/sprd_drm.c                              |  6 ++++--
 drivers/gpu/drm/sti/sti_drv.c                                |  6 +++++-
 drivers/gpu/drm/stm/drv.c                                    |  4 +++-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c                    |  4 +++-
 drivers/gpu/drm/sysfb/corebootdrm.c                          |  4 +++-
 drivers/gpu/drm/sysfb/efidrm.c                               |  4 +++-
 drivers/gpu/drm/sysfb/ofdrm.c                                |  4 +++-
 drivers/gpu/drm/sysfb/simpledrm.c                            |  4 +++-
 drivers/gpu/drm/sysfb/vesadrm.c                              |  4 +++-
 drivers/gpu/drm/tegra/drm.c                                  |  4 +++-
 drivers/gpu/drm/tests/drm_atomic_commit_test.c               |  4 +++-
 drivers/gpu/drm/tests/drm_atomic_test.c                      |  4 +++-
 drivers/gpu/drm/tests/drm_bridge_test.c                      | 12 +++++++++---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c           |  4 +++-
 drivers/gpu/drm/tidss/tidss_drv.c                            |  6 +++++-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                          |  4 +++-
 drivers/gpu/drm/tiny/appletbdrm.c                            |  4 +---
 drivers/gpu/drm/tiny/arcpgu.c                                |  4 +++-
 drivers/gpu/drm/tiny/bochs.c                                 |  4 +---
 drivers/gpu/drm/tiny/cirrus-qemu.c                           |  4 +++-
 drivers/gpu/drm/tiny/gm12u320.c                              |  4 +++-
 drivers/gpu/drm/tiny/hx8357d.c                               |  4 +++-
 drivers/gpu/drm/tiny/ili9163.c                               |  4 +++-
 drivers/gpu/drm/tiny/ili9225.c                               |  4 +++-
 drivers/gpu/drm/tiny/ili9341.c                               |  4 +++-
 drivers/gpu/drm/tiny/ili9486.c                               |  4 +++-
 drivers/gpu/drm/tiny/mi0283qt.c                              |  4 +++-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c                        |  4 +++-
 drivers/gpu/drm/tiny/pixpaper.c                              |  4 +++-
 drivers/gpu/drm/tiny/repaper.c                               |  4 +++-
 drivers/gpu/drm/tiny/sharp-memory.c                          |  4 +++-
 drivers/gpu/drm/tve200/tve200_drv.c                          |  4 +++-
 drivers/gpu/drm/udl/udl_modeset.c                            |  4 +++-
 drivers/gpu/drm/vboxvideo/vbox_mode.c                        |  5 ++++-
 drivers/gpu/drm/vc4/vc4_kms.c                                |  4 +++-
 drivers/gpu/drm/verisilicon/vs_drm.c                         |  4 +++-
 drivers/gpu/drm/virtio/virtgpu_display.c                     |  3 +--
 drivers/gpu/drm/vkms/vkms_output.c                           |  4 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                          |  4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                         |  4 +---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                         |  4 +---
 drivers/gpu/drm/xen/xen_drm_front_kms.c                      |  4 +++-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                            |  6 ++++--
 95 files changed, 277 insertions(+), 124 deletions(-)
---
base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
change-id: 20260712-drm-no-more-config-reset-1ea89f56693d

Best regards,
-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauyPHAAKCRAnX84Zoj2+
dkwsAX9NFbbJHCN9xg2CeHNoUE2b74hoQ5+vO2GWUoHj4SnPtC+G3wjjcqEZiRKZ
xMEy+OMBgLIpXnrk4sqLj7r+OWFunhZwYsLromcY/UpASSNAT98Hro2QnIUo8S4f
xStpohEISg==
=9Kfg
-----END PGP SIGNATURE-----
-- 
Maxime Ripard <mripard@kernel.org>

