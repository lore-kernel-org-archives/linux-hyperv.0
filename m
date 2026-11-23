Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428688;
	b=YY+cZR/mlj+j5WrprgRpVDF/rfwuJjmd4NvICT3uLzx6Jr8+1L9HCMLMxplyck/WJfhH
	 idV2f2c6cPbtetgwrNMpQoboPbtSHkx8D3nxe/tgPrLCyPMBjtvLq+Rc4n/3qlkp0moZV
	 +xiuWgz1U7FCuGsdsHudqv4Tq43vbKWtha+Zgbz06Ai54BEJw566N2SChUkS4uAmale8F
	 1nbJgC24Y4mQuGStirJwscZ0aQ2cVigvDE5m/YzYadBKMPP5RktADKzpUVfGaGzXw0vPc
	 i0PrQahie7c22UmW+qbfHFOw9YTWugjMFNBrsgueP7eiV8WCKQ+tJiX89jF36atOZDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rDFRLPy40I79JiGWrVFkLz2U4fAoPpBfu86dL+TJWTw=;
	b=wF09ddiZSJOCZSpZuYWULsNgnWNyEA13/d0WOXLKPQ3G6GYKr9fKP0AN9ukVPozF8vxg
	 H2UdjocQLh/GcI6ypJGSmCH+bJ5nJmwDQJOQJJRGfL5IB1dP/JOmpiCJ+Izx/jpE1KA05
	 0rE56Lxi1Eccw6v5L8Ym9VBo8KvvTS96nyBq7Z+4kcsbB26GqJ2ls9AlXkJ46zzmxVVb2
	 ZAZyD1YpPeqiUcS4u20aWDe6OfwGO1JmwYXAt9M7hvK3T6AMU7F8JQZ/3dggB3LQTOQnb
	 CJeSP25XmrH1cajEcVEGlOPZSSLS4VZltqBVzSGe3WdKZqCSNVe6tWXI0rW6NJ/RmkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQv8DoiR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836D606A331;
	Mon, 23 Nov 2026 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQv8DoiR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1141F000EF;
	Mon, 23 Nov 2026 10:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428688;
	bh=rDFRLPy40I79JiGWrVFkLz2U4fAoPpBfu86dL+TJWTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQv8DoiRck3gy8xgpS3BEeZCIVXlC+5twIrYuAJPvxyh+T6hLul9ehLPpI0/H8Ena
	 EoHPb6kv2Z1NRHkQj923ovInemiLOUPSnbRP19n0hmOl3DYyi/0U2zQnqNlsdAYgQX
	 yfIeKn1+n9OIoTJRvbp7rjlMj4wIsTr/xKlt8/kIiAVX5xbKrEtXbYSnqm7V+dLOrM
	 VyoI9JSIUfP6xwxXeJf8XGivEo78xSGLAZFRbS/S+K2EDg0EQWkh2mc7W/lQNIsXSv
	 CCH9QPsnErU7JRjGcCJBhGjJ2f+Q+uo3Lw7ckrw1kCFyKD4FZnZKjrPIy1KnGsdlwY
	 rf74RydNSb3kw==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Janne Grunau <j@jannau.net>,
	Sasha Finkelstein <k@chaosmail.tech>,
	asahi@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	sashiko-bot@kernel.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Alison Wang <alison.wang@nxp.com>,
	Stefan Agner <stefan@agner.ch>,
	Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	imx@lists.linux.dev,
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
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
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	David Lechner <david@lechnology.com>,
	Iker Pedrosa <ikerpedrosam@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
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
	Chia-I Wu <olvaffe@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: (subset) [PATCH v2 00/64] drm: Switch drivers to drm_mode_config_create_initial_state
Date: Mon, 23 Nov 2026 11:11:22 +0100
Message-ID: <179542861006.1136573.1196433498269800463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
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

On Mon, 16 Nov 2026 11:30:16 +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles. However, the two roles need different
> behaviors, notably for objects like drm_private_obj that must persist
> across suspend/resume and are excluded from drm_mode_config_reset()
> by design.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[01/64] drm/adp: Switch to drm_mode_config_create_initial_state
        commit: d636d17d3b8ecda8a3db6a77874e652aabac4eb2
[02/64] drm/amdgpu: Switch to drm_mode_config_create_initial_state
        commit: 064bc83ffc6eb72ec8af2973517f130d81bcd9bb
[04/64] drm/hdlcd: Switch to drm_mode_config_create_initial_state
        commit: 18becfe9b42cb828fc7fcf9703319d34675cd9f1
[05/64] drm/armada: Switch to drm_mode_config_create_initial_state
        commit: 69cecb2d921b7ae098c2800cbfa67590c436c3c4
[06/64] drm/ast: Switch to drm_mode_config_create_initial_state
        commit: 76dacf729a8dd4a954a5a8457ca49b221055d346
[07/64] drm/exynos: Switch to drm_mode_config_create_initial_state
        commit: cbe6da900d937f0de4c73eb574c409c9e2f4a7e8
[08/64] drm/fsl-dcu: Switch to drm_mode_config_create_initial_state
        commit: 6a294a6bf06ed0d71a505998bd0fd3abe1e9ea87
[09/64] drm/hisilicon/hibmc: Remove hibmc_unload() from the load error path
        commit: f830550f85cd0f5bd955d5b9abdb795f95a25ff8
[10/64] drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state
        commit: f935c8d2f8c6de0c4b95c5f63874ced18efe1de6
[12/64] drm/imx/ipuv3: Switch to drm_mode_config_create_initial_state
        commit: 8799786a618d2a56b8e3dc998b64fb28cb648ca6
[13/64] drm/ingenic: Move the private object creation before the reset
        commit: 5cc203c0dcd3352196d8ede54531afc2175193b0
[14/64] drm/ingenic: Switch to drm_mode_config_create_initial_state
        commit: 8636f44eb77f5f738708423a104ee2f225f84b97
[15/64] drm/kmb: Switch to drm_mode_config_create_initial_state
        commit: f4f4fd2ae13175ef7aa851cdeaa08bf29a0f38b1
[16/64] drm/logicvc: Switch to drm_mode_config_create_initial_state
        commit: 7f84f99fa2d9b068e4a51514df0e1f32ad3247aa
[18/64] drm/mediatek: Switch to drm_mode_config_create_initial_state
        commit: 333cf2d79ee32c5590787eeb6df1c3c1a9ad6a48
[19/64] drm/mgag200: Switch to drm_mode_config_create_initial_state
        commit: 2fb1383d1aed812e4830aec34b890547fe8d496e
[20/64] drm/msm: Switch to drm_mode_config_create_initial_state
        commit: 53556096b6e5e07a8c58fe19cfdf5f3d4e1197ab
[21/64] drm/nouveau: Switch to drm_mode_config_create_initial_state
        commit: 960f6b7c64cb9536c37e7995262fd465f2fc623b
[22/64] drm/omap: Switch to drm_mode_config_create_initial_state
        commit: cf34a54e91f99b80623fee78ad334871a7f39858
[23/64] drm/qxl: Destroy the monitors object on the modeset init error path
        commit: bf50dc68880788f9ad85f4411f2d3fa575139ceb
[24/64] drm/qxl: Switch to drm_mode_config_create_initial_state
        commit: f364abef006d3867174f9defa5f79c4c6585cead
[26/64] drm/rz-du: Switch to drm_mode_config_create_initial_state
        commit: 938dfe76a15263c5fac77ea1f99c265848c219f8
[27/64] drm/shmobile: Switch to drm_mode_config_create_initial_state
        commit: 588132787e6df07f0267983881f437990d56c5e8
[28/64] drm/st7571: Switch to drm_mode_config_create_initial_state
        commit: e03927d29003912052c64aad83df169243d43484
[32/64] drm/sprd: Switch to drm_mode_config_create_initial_state
        commit: 1af982780216d568a4e8ff6790b87de29e52ab90
[33/64] drm/sti: Fix drm_atomic_helper_shutdown() on the bind error paths
        commit: d3047688f4bc35ca827ee2994a014c81898d73cc
[34/64] drm/sti: Move drm_mode_config_create_initial_state() before drm_dev_register()
        commit: 2798c8d86bf4e4853cbc1b3e2a248d55e714a649
[36/64] drm/sun4i: Switch to drm_mode_config_create_initial_state
        commit: ad5e714a08a6d5f6fa39b589a438b40aaac9e2bf
[38/64] drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_state
        commit: 019bfdeb119dc616303a173323fd69853fe99858
[39/64] drm/tests: drm_atomic_test: Switch to drm_mode_config_create_initial_state
        commit: 53f0931d45c029f97c611837b8f853c9fad7a82c
[40/64] drm/tests: drm_bridge_test: Switch to drm_mode_config_create_initial_state
        commit: 45472c059ac76f982e31f67ef87f9db3caef1f88
[41/64] drm/tests: drm_hdmi_state_helper_test: Switch to drm_mode_config_create_initial_state
        commit: 3db9197bbe3fc859fd5b7521d1f4cedd9d62cb8c
[42/64] drm/tidss: Switch to drm_mode_config_create_initial_state
        commit: d771b7c8577c0b847d401a22f49a6abc18680ed3
[44/64] drm/arcpgu: Switch to drm_mode_config_create_initial_state
        commit: 620165b05363bea94b72970884f6f27ccf7cee3f
[45/64] drm/bochs: Switch to drm_mode_config_create_initial_state
        commit: c67548948d8c5ebb422fa03fb5dd89e44e458f20
[46/64] drm/cirrus-qemu: Switch to drm_mode_config_create_initial_state
        commit: 10e37ab94f0f10a7fd729a063c26bf1a94e7f2b0
[47/64] drm/gm12u320: Switch to drm_mode_config_create_initial_state
        commit: ce7e27979d41b94bb9a1ed66b6957a300a5a8c0a
[48/64] drm/hx8357d: Switch to drm_mode_config_create_initial_state
        commit: d9abdda3a6bd4903af87a1ed6d02c1897035cf4e
[49/64] drm/ili9163: Switch to drm_mode_config_create_initial_state
        commit: 6fc964d0567e8303cf72adc45dad29e9415fe76c
[51/64] drm/ili9341: Switch to drm_mode_config_create_initial_state
        commit: 75269393962354820792fddfe3da359b3be85ca3
[52/64] drm/ili9486: Switch to drm_mode_config_create_initial_state
        commit: c4f2890c815c5ac8d68668a072806edf4f466a7e
[53/64] drm/mi0283qt: Switch to drm_mode_config_create_initial_state
        commit: dfa078305c262eae2b0449814392e429b6bd58ee
[54/64] drm/panel-mipi-dbi: Switch to drm_mode_config_create_initial_state
        commit: 38b37ce4bc5fc406f1e93a90ce9b2b8531c6f5cb
[55/64] drm/pixpaper: Switch to drm_mode_config_create_initial_state
        commit: d3cb39a976745195d2d388b5b9194d47bfd2eb41
[56/64] drm/repaper: Switch to drm_mode_config_create_initial_state
        commit: ce380404a74260b6bb178b24dfd4125a591e1069
[57/64] drm/sharp-memory: Switch to drm_mode_config_create_initial_state
        commit: d4b8b6e920779d568a085eb611c75dc4bb5805a8
[58/64] drm/udl: Switch to drm_mode_config_create_initial_state
        commit: 6358c0da712b0170a3f1470c5eb75ec95340875c
[59/64] drm/vboxvideo: Switch to drm_mode_config_create_initial_state
        commit: a932fa029dad6b23b4ff5b7fdb44e5819c098b6e
[60/64] drm/verisilicon: Switch to drm_mode_config_create_initial_state
        commit: f3b23268607094ff4461119d623a235a2bdc8608
[61/64] drm/virtio: Switch to drm_mode_config_create_initial_state
        commit: eb2c77198187b0283f12be28bdb770703da59dca
[63/64] drm/xen: Switch to drm_mode_config_create_initial_state
        commit: 51b3e01a42db6100976907b95d224636e6551c98
[64/64] drm/xlnx: Switch to drm_mode_config_create_initial_state
        commit: bb8391a1a8d00b11661ab692313a991456d391dd

Thanks!
Maxime
