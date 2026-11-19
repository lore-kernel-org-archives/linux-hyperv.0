Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095788;
	b=l3pSqhDijIEDgJhwCG1z/MiHCm7YtX3HSEzTEvOGwsURRz1Ic0++QVUTn8Adp6ue1Hxt
	 xOEQCdy90YjS+T6TxDpx4E4nK3CCLSmLDt1k5/xy1X8RY6MqhRAlGWH1jd7MBkOy8r5CB
	 DC56VOR0Wmne4+cwdXSxwJAdxKYoS8qOVH930HD8CKmCL5GiPdJP30XELeuYnw9PGD9+R
	 PWZBgrVCY4nFLAjOikN8wW7ePicfeEr5rXolVmM+uir0GFjzdD05KZZ6poZyOLGx3TQWp
	 k06M+GrNakLXjVERFkr09mFPJiXZY9tGCTsODX1e0WVsKUKv+JesfGUSVO06+pMOffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CbEg7XvfeDnBQ/K77/dlrEkK7yv8e4LifTJxVZmhLAs=;
	b=h47X2qhB7967iQIcTXCPFXjjrMphxrf+dHgVXSCeldRNhrilKeT4pDhtrqMwuApgEWZk
	 M+S6ebuPk+ICNiWSwfdi60DFl51iCJnywhvmmsaTa4wdDsYrD3iSaG/YfFYMfR0eLMXdr
	 zPMOmGPnvujUvEV2oj3EFOiktpc8mxZKH0XLJyvKG6iGmXjK5xQiAkeqQta3Y3jagpW8s
	 M0SLTugq7frbZQaOT6I6KEGZOxACiSVAGWhWJlON0RAfbIaIc+DIzcpTEBdfbmyH+R6kR
	 EOAk4gimdNVv2V/9r8mwv9tazTEiaz0KwcPXRn2O9x7aEj4v3aoVyng9rblgSvaCx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/jm8GB4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82C606A33E;
	Thu, 19 Nov 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/jm8GB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C561F000C4;
	Thu, 19 Nov 2026 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095788;
	bh=CbEg7XvfeDnBQ/K77/dlrEkK7yv8e4LifTJxVZmhLAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/jm8GB4oI1ZqtVH3mcxqQUwu9zuKiDu90pq6oKhkRGMpkul9cUzIWyL0OMn9lNiE
	 yBKBsV8prLTEFyx0qEMoD8RpojqItT9dAXuguu1fIPVRXKdIrWHbwCsl9jO+ySa7g7
	 k00W4Ui1/3OvE8DlqLfbOZX3jHIMUSZi3jgQBAE/Cw/9/Zykh9QHw5PS1qgR2i71IR
	 zfO8LeXoviNETRPF0eKG6jI5XGyHA/nbymcYM0a9zYLwrYLw9o5tAXmABdR6mFolMb
	 LOw2bTAgup7y5wAExPZUZs/Z37euTnmiFeLJ23GCI0jxPdlBzRNv8iqF2TPyMS/YJP
	 fqCrH5mGo+kGQ==
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
Date: Thu, 19 Nov 2026 14:43:02 +0100
Message-ID: <179509577844.523497.5498880532220697042.b4-ty@kernel.org>
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

[03/64] drm/hdlcd: Fix drm_atomic_helper_shutdown() on the probe error path
        commit: e388eae138aa9364caada0a372b5712642188c16
[11/64] drm/hyperv: Switch to drm_mode_config_create_initial_state
        commit: 50b11ceaaef03d4062971db173bbddc8ac0df28b
[25/64] drm/rcar-du: Switch to drm_mode_config_create_initial_state
        commit: d8b8de5c35983567a7ef78fcd9f75db46d6c26af
[29/64] drm/st7586: Switch to drm_mode_config_create_initial_state
        commit: 52eb5b7764084bddd68e77c1c3e62e70ad11828f
[30/64] drm/st7735r: Switch to drm_mode_config_create_initial_state
        commit: 28d10bb2421152b650329710183c1f6df1bd056e
[31/64] drm/st7920: Switch to drm_mode_config_create_initial_state
        commit: b17f5f1abd5c30875d203d7690c92129d2d814d6
[35/64] drm/stm: Switch to drm_mode_config_create_initial_state
        commit: d78ccdcc94eba858fd8386f0da6de4ec4cd44666
[37/64] drm/tegra: Switch to drm_mode_config_create_initial_state
        commit: 0c187722c35db771276ee7390454f7de70508833
[50/64] drm/ili9225: Switch to drm_mode_config_create_initial_state
        commit: 0fc18dd1409138d88089ecdda5544ea2f8785520

Thanks!
Maxime
