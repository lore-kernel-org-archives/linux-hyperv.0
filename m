Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490338;
	b=dBbTQVg9FKf32B9WLZbZzJkJgNMA/1JgsqOpcf/dAoPjELJ5Zde8PYUXj7cnN4CFkQHn
	 WIDutEH5+3/IDbxCu/8vprSm4kOl2X3F7IWXo/csz8q9fjxH/pK07bLm5hp50IYItjmIM
	 jeuC0vDZKeHwbi4FUa4lGpHeV2QYgQfAsqZepA6vmDbWas4X7n0gH8tdri/D3z1lhxwSN
	 J1r4PJDu0s82fuJYcs1HGe7y0m1ykckIPmq6VKwHhPW0UZ4tY0U1X1DEyfWG8QlLPF9CO
	 hCHjOVUbzInGXzuapCpnzNd8JGVg/LQjyfunkLqUCnBVxyBRO+X8f8QJEraI8oVo85w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r6ZiRY3FXltBOTurpbapfkXrVhZHo2axQtDyRtG/+Kg=;
	b=eDwvbQvHfU7MNUk/ZOEuXN9ow8WA+f6iaHSQRBFsDq0Ypw+GnSCN8PcBX9jvLYVvYLGX
	 NprXp1LdFV4ZgaVwyd3NIJyJYkwgL7qHpP0Bc4e8peh3i/XM94KMb9I5pSx2pUpxFcT57
	 RySAjV6QyOebRnmgM4mtrT/VEVLfeAwyynvY5HOs7iPXuGGvx16jC9uBMNodXB7O7Thb4
	 oaXKvfBUOuZ+wBzhMouGsWvK6MDAmKRlgwVXbrPx2K5OumlhQsPYG5BGeWQh5CJfi++1z
	 4a+C1bRrSE/Tcr8U3EgEkQsN9g3nCa6hQqldMXszP1p2R+hZIW5FHjg7g7qhZI8AVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wy8GlGPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5C606A334;
	Thu, 12 Nov 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wy8GlGPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227E61F00A06;
	Thu, 12 Nov 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490338;
	bh=r6ZiRY3FXltBOTurpbapfkXrVhZHo2axQtDyRtG/+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wy8GlGPynbdgDuFWN722xaQwNevNtmZMEu0BUn6KzojIS2khSDKExmF3/xNVEdtLl
	 eg+MrKwjSLQKSwX6KGIm3YdAvMrdpehkw2SEwXk5ITkqGQcbqHO3TpHS2uV2Am897/
	 10/dPietBwB77+JGc07RnvIwJDQCioeWxjJS5APKr5zv02KG/1GvxTvI2xPg8l2nj9
	 8rVb9kzBJiR4zpdkhL90XWtOFJlNgS29gDuGDeXDl5g8bz1BkEPEanNxu3FAmYKlIF
	 uvbMxLrCr7ffOATZvlIHAx+q1QfPvgRNTBbsvWHfJ7CKtkZD92nfbknljW1KTrGL27
	 2KvO5+WPab9Vw==
From: Maxime Ripard <mripard@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Janne Grunau <j@jannau.net>,
	Sasha Finkelstein <k@chaosmail.tech>,
	asahi@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Alison Wang <alison.wang@nxp.com>,
	Stefan Agner <stefan@agner.ch>,
	Ruben Wauters <rubenru09@aol.com>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	John Stultz <jstultz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	imx@lists.linux.dev,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-mips@vger.kernel.org,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Huacai Chen <chenhuacai@kernel.org>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Mingcong Bai <jeffbai@aosc.io>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Linus Walleij <linusw@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	nouveau@lists.freedesktop.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	spice-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	David Lechner <david@lechnology.com>,
	Iker Pedrosa <ikerpedrosam@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-tegra@vger.kernel.org,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	LiangCheng Wang <zaq14760@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
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
	Michal Simek <michal.simek@amd.com>,
	Aditya Garg <aditya.garg@linux.dev>,
	Andy Yan <andyshrk@163.com>
Subject: Re: (subset) [PATCH RESEND 00/83] drm: Switch drivers to drm_mode_config_create_initial_state
Date: Thu, 12 Nov 2026 14:32:12 +0100
Message-ID: <179449030440.677082.2648325087165275258.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 16:29:09 +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles. However, the two roles need different
> behaviors, notably for objects like drm_private_obj that must persist
> across suspend/resume and are excluded from drm_mode_config_reset()
> by design.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[03/83] drm/appletbdrm: Switch to drm_mode_config_create_initial_state
        commit: 24f5141d0266b391fda87dd3458aad31c26e28df
[04/83] drm/komeda: Switch to drm_mode_config_create_initial_state
        commit: 95b07f6f1f820601f9bc4f9dd8cb01e008c4441d
[06/83] drm/malidp: Switch to drm_mode_config_create_initial_state
        commit: b0507da85fdd7060decd29d35f5819259718f741
[08/83] drm/aspeed: Switch to drm_mode_config_create_initial_state
        commit: fe87bfb1dfa04dd73bb89e60820ced02967faee8
[10/83] drm/atmel-hlcdc: Switch to drm_mode_config_create_initial_state
        commit: b36f26eb85d8032b458fab7c6912650c0e5b5561
[13/83] drm/gud: Switch to drm_mode_config_create_initial_state
        commit: a53dc66784822a101541c54e1e7e471bbad3e8ee
[15/83] drm/hisilicon/kirin: Switch to drm_mode_config_create_initial_state
        commit: 1e8db0d2a2383ce3fb96ea1db26180350d972786
[17/83] drm/imx/dc: Switch to drm_mode_config_create_initial_state
        commit: 39283d6d8fbaca8d7bb7e98f7406dad5286bfc6e
[18/83] drm/imx/dcss: Switch to drm_mode_config_create_initial_state
        commit: dc54c1bc909873caf0f910677f3de899cdf3b62d
[24/83] drm/mcde: Switch to drm_mode_config_create_initial_state
        commit: 046b692dc7d3910b6a85d71e5e941c712bad30ee
[26/83] drm/meson: Switch to drm_mode_config_create_initial_state
        commit: a26760da1f8bebdcc7fe6fdcb5df5c6ca007e4cc
[29/83] drm/lcdif: Switch to drm_mode_config_create_initial_state
        commit: 0f3e257909538e9cce0213c2d1b9d3a7edf8f348
[30/83] drm/mxsfb: Switch to drm_mode_config_create_initial_state
        commit: 99da25e15ccbfb1d0717de28d3b6f45f72958127
[33/83] drm/pl111: Switch to drm_mode_config_create_initial_state
        commit: 4b9008133a7b14dbb1eeab84266926062d126ba7
[38/83] drm/rockchip: Switch to drm_mode_config_create_initial_state
        commit: c07d0dfba08808c90ab8ccc23a1f0ce9aafae536
[43/83] drm/ssd130x: Switch to drm_mode_config_create_initial_state
        commit: d7938a168f56608626d62a7015b448da1cee4dba
[48/83] drm/corebootdrm: Switch to drm_mode_config_create_initial_state
        commit: 207a0f90ce3953131806ead64bb512364de260c4
[49/83] drm/efidrm: Switch to drm_mode_config_create_initial_state
        commit: 8fa2e7e1b3642113677a6a77f81aa186f3b16293
[50/83] drm/ofdrm: Switch to drm_mode_config_create_initial_state
        commit: 1fd3ed4c330b8f56bbcd7d2684e1dae5961ee8ab
[51/83] drm/simpledrm: Switch to drm_mode_config_create_initial_state
        commit: cde728838797cdce3bc488acb1338c1dc20c24d2
[52/83] drm/vesadrm: Switch to drm_mode_config_create_initial_state
        commit: 705557cddfcbea6c6ee2e50057394c6c6fc2ab8b
[74/83] drm/tve200: Switch to drm_mode_config_create_initial_state
        commit: 4b40cfa3178f00188314a1da55dd899e635d2d73
[77/83] drm/vc4: Switch to drm_mode_config_create_initial_state
        commit: 6d8d9311bc9daac0e5acc3e5d34ca067abdd1fe4
[80/83] drm/vkms: Switch to drm_mode_config_create_initial_state
        commit: 63a80293361bc276fb07cd68511b5f887ff5fa41

Thanks!
Maxime
