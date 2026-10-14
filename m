Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118334041B;
	Wed, 14 Oct 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998834; cv=none; b=QJ2Q3io1mTBujvWgr9RUgdDX4R4dhnm9uxQfnRiSQK+0h4BUhOO26NMVuGxEqAZ4xWiyqJKb9YGxK8yenR9QiG/n4YlUlvBqMnJfMh7zKwvq8n2HLwnhbtTveCBqWsJELNTXwo5F7bOcmcrE38ZOmeKV3U0PpatGXu6jFGLxAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998834; c=relaxed/simple;
	bh=/DhCCdduSvGU+jRohyrE71CT7KCgRbZ7hxwTqS0qh7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WpOV5BWtEjTJB/hfiH9sMpw5k0RL6mmotQvQKuZmcJhsbM2DUzvbQd5m+isabPtE1QaRms2G8j9StdDVcMqizbwT38yo7vfTyPoNtjJHnJp9LdtHTMvKGV0suqgNNLqk9Gux+MGkOBjAtgGawNdYP8MfY6d6WumXhZUPAikbr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuZUaj/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuZUaj/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2EA1F000C4;
	Wed, 14 Oct 2026 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998832;
	bh=T1+E2k2Owgt5D89M0RIPqwAKDNzTjAgVytD2FAygs90=;
	h=From:Subject:Date:To:Cc;
	b=DuZUaj/V/FfaUCL5qLj1FkcP5Nu8k/DEmJrFKpGEtqvc/RihMfUV3rYvXChynwZl3
	 QGXRlVFN263fc9HP5EZJD80I+gHD8BXd+WAdU7Qt+XL2ceQOKxyAU75nhQJYUpDDDb
	 BiKj+ch6lUZ5UgdRTWexBWSGtadx9UqKABOI3KCKucbA2mGtm4g2EZbzfit/ffNwhf
	 11ND6IcHuGMowRW0fJ/o1aaedkVoQ3qUpvaSnqu2tI+CZ5ZNSNUB5GYK/u7oJahmTk
	 2CC98zzf/nB0B1sj3UYglRbldPiOMRuHggw4bYFu96MVotkkxR0f/9SP2Fn7UopQfJ
	 5deaPekM0KuoQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/75] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Date: Wed, 14 Oct 2026 19:26:23 +0200
Message-Id: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMBCE4Vche3YTaApYXsVwgDJoD211W4wJ4
 d2tcvzm8M9OCeKQaKh2ErxdcjEUNJeK7GMKd7BbiknVqqv72vAinkNkHwVsYwiwOQoLEjLrFmj
 00ttOWSqFp2B1n3/9Np4WvLZyks+R5in9Mt67PFSmWVsFY65KzzQexxeznFx5nQAAAA==
X-Change-ID: 20260709-drm-no-more-connector-reset-45ee14d7c62c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Aun-Ali Zaidi <admin@kodeit.net>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
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
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
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
 Alexey Brodkin <abrodkin@synopsys.com>, Hans de Goede <hansg@kernel.org>, 
 LiangCheng Wang <zaq14760@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Ruben Wauters <rubenru09@aol.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, Aditya Garg <aditya.garg@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13365; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/DhCCdduSvGU+jRohyrE71CT7KCgRbZ7hxwTqS0qh7s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd7vN6q5e3Reh/y9VQcHs49ar3P5OTUv6rHPkWKsPy
 xc5bGHpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOp72Rs2MhjsXneVibbsIJI
 vVJzxg9/fd5UGQsk6k8N7tBevcP76h6f09Y80lf/fvny99XjmVdfM9ZwZDbc6dwvpbX20N8jwaw
 TpgT4nAn2MHWbwivGZb/nrf6ZDWueCCRfjO/w6F0c32G1lAcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

This is a follow-up to the plane and CRTC reset removal series, and
part of a larger effort to remove the reset hook from all KMS objects.

The connector reset hook is overloaded: it is called both at probe
time to create the initial software state and during suspend/resume to
reset hardware and software state. These two roles have different
requirements, and the reset hook is not fallible, making error
handling difficult for the initial state allocation path.

While reset has the semantics to reset both the software and hardware
state, the vast majority of implementations and all the helpers only
reset the software state, making them equivalent to
atomic_create_state in practice. The atomic_create_state hook makes
this explicit: it only allocates and initializes a pristine state
without any side effect, and returns the state pointer or an ERR_PTR
on failure.

This series converts all connector drivers tree-wide from the reset hook
to atomic_create_state, then removes the reset hook from struct
drm_connector_funcs entirely. The conversions were done using a
combination of Coccinelle semantic patches, mechanical one-line
replacements and manual adjustments.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (75):
      drm/panel: Add atomic_create_state support
      drm/adp: Switch to drm_atomic_helper_connector_create_state
      drm/amdgpu: vkms: Switch to drm_atomic_helper_connector_create_state
      drm/amdgpu: dm: Switch to drm_atomic_helper_connector_create_state
      drm/arm: komeda: Switch to drm_atomic_helper_connector_create_state
      drm/aspeed: Switch to drm_atomic_helper_connector_create_state
      drm/ast: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx6345: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx78xx: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: chrontel-ch7033: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: lontium-lt8912b: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: megachips: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: nxp-ptn3460: Switch to drm_atomic_helper_connector_create_state
      drm/panel: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: sii902x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: simple-bridge: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tc358767: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tda998x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: ti-tfp410: Switch to drm_atomic_helper_connector_create_state
      drm/exynos: Switch to drm_atomic_helper_connector_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_connector_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_connector_create_state
      drm/hyperv: Switch to drm_atomic_helper_connector_create_state
      drm/imx: ipuv3: Switch to drm_atomic_helper_connector_create_state
      drm/logicvc: Switch to drm_atomic_helper_connector_create_state
      drm/loongson: Switch to drm_atomic_helper_connector_create_state
      drm/mgag200: Switch to drm_atomic_helper_connector_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_connector_create_state
      drm/msm: dpu1: Switch to drm_atomic_helper_connector_create_state
      drm/qxl: Switch to drm_atomic_helper_connector_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7920: Switch to drm_atomic_helper_connector_create_state
      drm/solomon: ssd130x: Switch to drm_atomic_helper_connector_create_state
      drm/sti: Switch to drm_atomic_helper_connector_create_state
      drm/stm: Switch to drm_atomic_helper_connector_create_state
      drm/sun4i: Switch to drm_atomic_helper_connector_create_state
      drm/sysfb: Switch to drm_atomic_helper_connector_create_state
      drm/tegra: Switch to drm_atomic_helper_connector_create_state
      drm/tests: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: arcpgu: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: gm12u320: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: repaper: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_connector_create_state
      drm/udl: Switch to drm_atomic_helper_connector_create_state
      drm/vboxvideo: Switch to drm_atomic_helper_connector_create_state
      drm/vc4: Switch to drm_atomic_helper_connector_create_state
      drm/virtio: Switch to drm_atomic_helper_connector_create_state
      drm/vkms: Switch to drm_atomic_helper_connector_create_state
      drm/xen: Switch to drm_atomic_helper_connector_create_state
      drm/atomic-state-helper: Rename connector_tv_margins_reset to state_init
      drm/atomic-state-helper: Rename connector_tv_reset to state_init
      drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/gud: Convert to atomic_create_state
      drm/sun4i: hdmi: Convert to atomic_create_state
      drm/sun4i: tv: Convert to atomic_create_state
      drm/tests: hdmi: Convert to atomic_create_state
      drm/vc4: hdmi: Convert to atomic_create_state
      drm/vc4: vec: Convert to atomic_create_state
      drm/connector: Remove drm_atomic_helper_connector_reset()
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state
      drm/i915: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/connector: Remove __drm_atomic_helper_connector_reset()
      drm/connector: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 32 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 14 +++-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 90 ++++++++++++++--------
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |  7 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |  2 +-
 .../drm/arm/display/komeda/komeda_wb_connector.c   |  2 +-
 drivers/gpu/drm/arm/malidp_mw.c                    | 18 ++---
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |  2 +-
 drivers/gpu/drm/ast/ast_dp.c                       | 19 ++---
 drivers/gpu/drm/ast/ast_dp501.c                    |  2 +-
 drivers/gpu/drm/ast/ast_sil164.c                   |  2 +-
 drivers/gpu/drm/ast/ast_vga.c                      |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |  2 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |  2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |  2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 12 ++-
 drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  3 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          | 68 ++++------------
 drivers/gpu/drm/drm_connector.c                    |  8 --
 drivers/gpu/drm/drm_mode_config.c                  |  4 +-
 drivers/gpu/drm/drm_panel.c                        | 14 +++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  2 +-
 drivers/gpu/drm/gud/gud_connector.c                | 20 +++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |  2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  2 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |  6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  6 +-
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                |  2 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |  2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |  2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |  4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         | 12 ++-
 drivers/gpu/drm/mgag200/mgag200_vga.c              |  2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  9 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 25 +++---
 drivers/gpu/drm/nouveau/nouveau_connector.h        |  3 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  2 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 15 ++--
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |  2 +-
 drivers/gpu/drm/sitronix/st7571.c                  |  2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |  2 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |  2 +-
 drivers/gpu/drm/stm/lvds.c                         |  2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 17 +++-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |  2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   | 16 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |  2 +-
 drivers/gpu/drm/tegra/dsi.c                        | 17 ++--
 drivers/gpu/drm/tegra/hdmi.c                       |  2 +-
 drivers/gpu/drm/tegra/sor.c                        | 13 ++--
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |  2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c            |  2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |  4 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 17 +++-
 drivers/gpu/drm/tests/drm_probe_helper_test.c      |  2 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |  2 +-
 drivers/gpu/drm/tiny/bochs.c                       |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |  2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |  2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |  2 +-
 drivers/gpu/drm/tiny/repaper.c                     |  2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |  2 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 32 ++++++--
 drivers/gpu/drm/vc4/vc4_txp.c                      |  2 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      | 16 +++-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  2 +-
 drivers/gpu/drm/vkms/vkms_connector.c              |  2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 23 ++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |  2 +-
 include/drm/drm_atomic_state_helper.h              |  9 +--
 include/drm/drm_connector.h                        | 12 ---
 include/drm/drm_mipi_dbi.h                         |  2 +-
 108 files changed, 392 insertions(+), 331 deletions(-)
---
base-commit: 91f52e99824b0beebb48cad51bbda81437af8664
change-id: 20260709-drm-no-more-connector-reset-45ee14d7c62c

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

