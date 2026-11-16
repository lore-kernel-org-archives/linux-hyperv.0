Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825057;
	b=GpBgwfE7NWdQAUZ3z4omQ9OE+B1GV6CUf3nqWND9K+CaRBNf/QgVSnDXzr7UgZm3F/kP
	 uIfzUNYsO/LXM9qBN5QMCKPhQTHV/lYL0aY+1hZFSIkoGI+Kqm7xBW/gMsKe+wBE2mzmX
	 0oVVsRXscoqdrnV7RZZDRQ7TSAIlCRC18aAIgK3BVJmzl25r4b/oZI2h8FlFsTi2431qH
	 7ZdijuBqWE+ktE9Z4gww2Dzhhfp+5D4Bd1tuDcMfR07vw91j7uRoyMPUSUPdinGseemli
	 PP7+uUq5PKLAzo+0Ymk9OzNjKScMvktg0lGbgGmMZi1+xc6QhHEw7jsX7ioLTwsU7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825057;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hNoOLAkKTtSxiJZHPRFlIqEnER1Prl4GCQs18G25yPc=;
	b=I1KsrRqXY68dIRpIluIoX3ayZ6fPeNF8TBxkh6sdFpu3lmuqSe7cYjrIgC0ITGHZBDvm
	 hWrePxRFROMWJbEKx1mbW8k7m/Zrx3IyK9AUi+PI+pJIlokKV8sBai8LgHuvd9WAU0wOK
	 Q5VIB3JApTOYZQGQvkqco49mdWZHOSbeLVyzMyhWWAtiCqI2ohTTqbOTmcFblnJiwyuwq
	 Bp7Yw2U+wq9HtRbnuocJo8mchxAO0RuhVNXd6TXAALc2xv1UPmWfuFcv66+gtouui9L2f
	 g65rlJOd1cUkrLdYj2qWGY+/JI636TwufPS1nboQSizravmpykIziP6pvrt/b5/Qjhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZAQjQAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C691606A31C;
	Mon, 16 Nov 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZAQjQAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0581E1F000C4;
	Mon, 16 Nov 2026 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825057;
	bh=hNoOLAkKTtSxiJZHPRFlIqEnER1Prl4GCQs18G25yPc=;
	h=From:Subject:Date:To:Cc;
	b=eZAQjQAjpGYV7/Eiek+/CM3GGGJ7mjOU0aI2Pqqy/lVi1PtK6N21dH4ReeD0yKxqR
	 GA1WugARvXRRPA6PeNht/rYimME1ClZwx1fSDoFfrh5kea5FQkRCxCEQoFpyHLo3IF
	 zC++9JOkXFllW30ghcP3a7eJozKLkpENKLLCTfRnFEmvFEI25C5pZ3pc/azcAIQaLB
	 NMO/PzMqEmOjhtcDp6mEbUeo1FXq+UAR6AvqupyYKTcJOEDrEkmMMx2+fhfVZ/pO+S
	 6SfUpl6vvQdsNnk69fbG3tG3yCQR+I5DMRpaolHqjO7QkZf9xYrBswRl65X0R1nVLO
	 EsaYuU4/pW6xQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/64] drm: Switch drivers to
 drm_mode_config_create_initial_state
Date: Mon, 16 Nov 2026 11:30:16 +0100
Message-Id: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XNQQ6CMBBA0as0s2ZMW0IRVt7DsCBlChOlNVPSa
 Ah3N7J3+xfv75BJmDL0agehwplThF7ZSoFfxjgT8gS9Aqut062xOMmKMeGahNCnGHhGoUwbGhq
 vXWic6+oJKgUvocDvk74PlYKF85bkc56K+dUTNUY3/9FiUGPr6sZpb72vw+1BEul5STLDcBzHF
 w7mkJrBAAAA
X-Change-ID: 20260712-drm-no-more-config-reset-1ea89f56693d
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 sashiko-bot@kernel.org, Liviu Dudau <liviu.dudau@arm.com>, 
 Russell King <linux@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>, Dexuan Cui <decui@microsoft.com>, 
 Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 nouveau@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 David Lechner <david@lechnology.com>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
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
 Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Michal Simek <michal.simek@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10588; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UnO0MjpeeK9krxZGNzUbW4Y98HkRuMvk6bepjPVE67A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjtoSp5cbau8nO/fFo9nZ3JyVwYp7+OL+35/yiTLj
 8w57O6rO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBELOoYG97r7D+c8fKXCs+H
 V+zz97t4P63mf7xgZkOXUP6qJIaq9nfS1kVzNb7H6/ffELF9qLf2CGPD5+wrem7q7TGnXggsSF2
 lK1P0cGKITLburVPeF8KE889ce3pjvWDAm+I7u+YFRSqyTtoHAA==
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
Changes in v2:
- Fix some sashiko issues
- Link to v1: https://lore.kernel.org/r/20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org

---
Maxime Ripard (64):
      drm/adp: Switch to drm_mode_config_create_initial_state
      drm/amdgpu: Switch to drm_mode_config_create_initial_state
      drm/hdlcd: Fix drm_atomic_helper_shutdown() on the probe error path
      drm/hdlcd: Switch to drm_mode_config_create_initial_state
      drm/armada: Switch to drm_mode_config_create_initial_state
      drm/ast: Switch to drm_mode_config_create_initial_state
      drm/exynos: Switch to drm_mode_config_create_initial_state
      drm/fsl-dcu: Switch to drm_mode_config_create_initial_state
      drm/hisilicon/hibmc: Remove hibmc_unload() from the load error path
      drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state
      drm/hyperv: Switch to drm_mode_config_create_initial_state
      drm/imx/ipuv3: Switch to drm_mode_config_create_initial_state
      drm/ingenic: Move the private object creation before the reset
      drm/ingenic: Switch to drm_mode_config_create_initial_state
      drm/kmb: Switch to drm_mode_config_create_initial_state
      drm/logicvc: Switch to drm_mode_config_create_initial_state
      drm/loongson: Switch to drm_mode_config_create_initial_state
      drm/mediatek: Switch to drm_mode_config_create_initial_state
      drm/mgag200: Switch to drm_mode_config_create_initial_state
      drm/msm: Switch to drm_mode_config_create_initial_state
      drm/nouveau: Switch to drm_mode_config_create_initial_state
      drm/omap: Switch to drm_mode_config_create_initial_state
      drm/qxl: Destroy the monitors object on the modeset init error path
      drm/qxl: Switch to drm_mode_config_create_initial_state
      drm/rcar-du: Switch to drm_mode_config_create_initial_state
      drm/rz-du: Switch to drm_mode_config_create_initial_state
      drm/shmobile: Switch to drm_mode_config_create_initial_state
      drm/st7571: Switch to drm_mode_config_create_initial_state
      drm/st7586: Switch to drm_mode_config_create_initial_state
      drm/st7735r: Switch to drm_mode_config_create_initial_state
      drm/st7920: Switch to drm_mode_config_create_initial_state
      drm/sprd: Switch to drm_mode_config_create_initial_state
      drm/sti: Fix drm_atomic_helper_shutdown() on the bind error paths
      drm/sti: Move drm_mode_config_create_initial_state() before drm_dev_register()
      drm/stm: Switch to drm_mode_config_create_initial_state
      drm/sun4i: Switch to drm_mode_config_create_initial_state
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
      drm/udl: Switch to drm_mode_config_create_initial_state
      drm/vboxvideo: Switch to drm_mode_config_create_initial_state
      drm/verisilicon: Switch to drm_mode_config_create_initial_state
      drm/virtio: Switch to drm_mode_config_create_initial_state
      drm/vmwgfx: Switch to drm_mode_config_create_initial_state
      drm/xen: Switch to drm_mode_config_create_initial_state
      drm/xlnx: Switch to drm_mode_config_create_initial_state

 drivers/gpu/drm/adp/adp_drv.c                      |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  4 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  3 ++-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  4 +++-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |  9 +++++----
 drivers/gpu/drm/armada/armada_drv.c                |  4 +++-
 drivers/gpu/drm/ast/ast_mode.c                     |  4 +++-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 +++-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |  4 +++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  7 ++++---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  4 +---
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |  4 +++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          | 22 +++++++++++++---------
 drivers/gpu/drm/kmb/kmb_drv.c                      |  3 +--
 drivers/gpu/drm/logicvc/logicvc_mode.c             |  4 +++-
 drivers/gpu/drm/loongson/lsdc_drv.c                |  4 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200.c             |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c           |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |  4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c           |  4 +++-
 drivers/gpu/drm/msm/msm_kms.c                      |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_display.c          |  4 +++-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 +++-
 drivers/gpu/drm/qxl/qxl_display.c                  | 11 +++++++++--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |  4 +++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c       |  4 +++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c   |  4 +++-
 drivers/gpu/drm/sitronix/st7571.c                  |  4 +++-
 drivers/gpu/drm/sitronix/st7586.c                  |  4 +++-
 drivers/gpu/drm/sitronix/st7735r.c                 |  4 +++-
 drivers/gpu/drm/sitronix/st7920.c                  |  4 +---
 drivers/gpu/drm/sprd/sprd_drm.c                    |  6 ++++--
 drivers/gpu/drm/sti/sti_drv.c                      | 10 ++++------
 drivers/gpu/drm/stm/drv.c                          |  6 +++++-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 +++-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  6 +++---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  2 +-
 drivers/gpu/drm/tegra/drm.c                        |  4 +++-
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |  3 ++-
 drivers/gpu/drm/tests/drm_atomic_test.c            |  4 +++-
 drivers/gpu/drm/tests/drm_bridge_test.c            | 12 +++++++++---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  3 ++-
 drivers/gpu/drm/tidss/tidss_drv.c                  |  6 +++++-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  4 +++-
 drivers/gpu/drm/tiny/arcpgu.c                      |  4 +++-
 drivers/gpu/drm/tiny/bochs.c                       |  4 +---
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |  4 +++-
 drivers/gpu/drm/tiny/gm12u320.c                    |  4 +++-
 drivers/gpu/drm/tiny/hx8357d.c                     |  4 +++-
 drivers/gpu/drm/tiny/ili9163.c                     |  4 +++-
 drivers/gpu/drm/tiny/ili9225.c                     |  4 +++-
 drivers/gpu/drm/tiny/ili9341.c                     |  4 +++-
 drivers/gpu/drm/tiny/ili9486.c                     |  4 +++-
 drivers/gpu/drm/tiny/mi0283qt.c                    |  4 +++-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |  4 +++-
 drivers/gpu/drm/tiny/pixpaper.c                    |  4 +++-
 drivers/gpu/drm/tiny/repaper.c                     |  4 +++-
 drivers/gpu/drm/tiny/sharp-memory.c                |  4 +++-
 drivers/gpu/drm/udl/udl_modeset.c                  |  4 +++-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  5 ++++-
 drivers/gpu/drm/verisilicon/vs_drm.c               |  4 +++-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  3 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 14 +++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  3 ---
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |  4 +++-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  6 ++++--
 74 files changed, 243 insertions(+), 115 deletions(-)
---
base-commit: a8670a2ab1a81dc3fc30093e47c23b83244ca4d0
change-id: 20260712-drm-no-more-config-reset-1ea89f56693d

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

