Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422957;
	b=jHW0zORP5iA4+UEc5f6YJIS7ZLD8DK2yMd0+6CQ1q7slJGd8eXIGczdaIpXP5dBkzZK4
	 suzgLKjTgGTvbe9jS2XqWCcFHBtaEAoivcF2NviJE2EOTorgQdCYvESa76RtFymgP6mn8
	 VZhb3BHCc6vcRw0QM5oJXNEpGZemsduNfXUxKlqF73EUeniL92ZvNqJ1mFlDgs3ayKmjk
	 k88+zg4LjGM6dwjqFjZ1BdOtTwzAbh0QJCf/zu8wvhoeU7d2tyDYkKq7w7PFAXT2RyW4Z
	 qm43Qo4yMio2n8/yM7y6cXWkLBKnV10mhqBwaRukAbe3He9zZQKp3sWFvwDAFu83OOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rY7NXz2qfQQtnIEL3eObvxvEOIQ+EeZp99ff3bsp5sk=;
	b=LfprZZ+hHgUJwDXm+0KS8UOXDah5T4D73bKccUFteS+a45T7K/Lg5yg0xNa86gz/XbXT
	 Q40udK7liYfEKHxUKKCYfH4t3qwYWMYl76A6tMaR6U5cjVbcPyNM/jsb4HWrCWGtRAI5A
	 SGt1DSDV1zrAKgB4b/mrGOxD4FgTjgbAITi0XLCYS8CyTad+yzHu321V202WI9EpgJn/9
	 dRcPfqggG1yc7uu5EhoYcT8vZH1TFeCyFAcfipK0Zr/3q6n0Z5icIcGycvgbJL8RNZIFF
	 mKY2cSp88gOUY9uwmpl2sArQ7trKK9nNJIfPy/jmGFKRz8K4ffG/G8rBWhT6cPIEU/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnpQzRLX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA27609DCFA;
	Mon, 19 Oct 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnpQzRLX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E71F000C4;
	Mon, 19 Oct 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422956;
	bh=rY7NXz2qfQQtnIEL3eObvxvEOIQ+EeZp99ff3bsp5sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnpQzRLX3TYf8k0qu6IYpaMq62MrzgVnzWtCBEbdnX0IUPXFCp6FFVhb6e/W37EY7
	 oQdkTxuZitFSXzUqh8YM+LI6hW4HWoVv72MiRtWfb/iuVaWOGKHt2j8Piy3XsHY4bv
	 HfJH5x277Hg+W3vBh+BKJcUHigFzcPtKnByrkz6Qw0vZi1heWwAKuKjDH8y9RjWbAw
	 ZWzbQHvwqs0XljbKJDetYNNwEqmAYS1SizYC8c9PQJ/+yV3C9kQ+UX6IhimWK6Szh4
	 MliM2s0jWJxjgBc2N8LAVJSnUAeqxo/k14Kw0U606JcTDsTXyg4NEZpgxA/P9PGn8a
	 a/NOnXhhwsAXA==
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
Date: Mon, 19 Oct 2026 17:15:50 +0200
Message-ID: <179242294379.2822300.2839114266297465713.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
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

[73/75] drm/vmwgfx: Convert to atomic_create_state
        commit: e6bb593b800813788dc16179d1305747ff974d00

Thanks!
Maxime
