Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5ED4D2EDF;
	Fri, 16 Oct 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163562; cv=none; b=QzWePHxITPuaQT2UqB5Az6EXWxzIf7bMHl3Ll22mBKUFgDQ3Z2TVUpUpUthG+D9hjXvXmxJ41KoJK6hiLhTSZdmJLbjZQZpAIXYmljjKQXZmMRcqQHoc7bHoMCRze3lTAZOdZ2TadiWdo1M2L3zcEyh6k9G/DXj6dYRBiGqDPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163562; c=relaxed/simple;
	bh=wArVxH9jZInnASIQLwCgvMc3lzkEDaLjNnutL2oFwVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWkofqE05R6o0DFiTVm5+qXn4e9jvSpvs/e79Jf3Gxu44nQhNbXZL1Ndg7LvkYj40qU0bL/EVDypcE/twaEwBbaJGSDVaJ46a5l6Up8ItTindUMg93h7qsHvdJshBJktGlhGEkUJUD5ec+OoZwagCYj603S8yHQhRg4mI7XlPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeXH2eNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeXH2eNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F291F000C4;
	Fri, 16 Oct 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163561;
	bh=zExOvzSfNAOGhWyHayoCJYIMW12XGItswYYl/21/DBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeXH2eNd0qTi1KJWMDpX2qurIIHfELGudDOFsBVj38SK5hgtwRmtRu++Y/B5kYqqd
	 A4blc5Fp2xS9ugu94PJEByj6vIlDtKLwiWnVuaMsxRz0Ir4yLDMdWRBi4NsEDJfgYI
	 dTCWHHQPHA4O4L72QOauM8WSJ4JjVCneqoIAwA1rVTR79Lh6W41DTt4LcokcrG/DS7
	 QghFRktl0qmqBt0Q2454sV5etB2cRZSEkJVEe4jVB1iPvoqhJu/FGnl3nmWT7TfuCi
	 kYiPGdYgWB0PP3fl0nc6yx6ZWW1MUxK7rfa2DXZnz9GRXCns4+n+2ph4Izy2R1nkwe
	 CPOLN30xIOzMQ==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Aun-Ali Zaidi <admin@kodeit.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	Paul Kocialkowski <paulk@sys-base.io>,
	Huacai Chen <chenhuacai@kernel.org>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Mingcong Bai <jeffbai@aosc.io>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	spice-devel@lists.freedesktop.org,
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
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-tegra@vger.kernel.org,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Hans de Goede <hansg@kernel.org>,
	LiangCheng Wang <zaq14760@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Ruben Wauters <rubenru09@aol.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	nouveau@lists.freedesktop.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: Re: (subset) [PATCH 00/75] drm/connector: Convert all drivers to atomic_create_state and remove reset
Date: Fri, 16 Oct 2026 17:12:34 +0200
Message-ID: <179216354629.2387589.2597043397406887835.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 19:26:23 +0200, Maxime Ripard wrote:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
> 
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[02/75] drm/adp: Switch to drm_atomic_helper_connector_create_state
        commit: db1de27aca30ebaad04aea74ac21e4c4fb531a37

Thanks!
Maxime
