Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3438D69D;
	Mon, 24 Aug 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570902; cv=none; b=PkfWn5YZj1AY3+CMdnJFnSVGgy7brpJ29zuBoo9x9eonJurKjys+rVvOYU5Fb0CdOtnssfhj7XqFp/ZfjoFm3tO4Ht0RCh99UfbPh7CU4wQ153t6APie2jYvHgYidWDwC+jTtoqXBVMNdkcXZTbA/DAIhRVbTBaS/oSmua1gt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570902; c=relaxed/simple;
	bh=sdV8IKSzvBM2QqVDwBaCbcaPhegAg+U0Rp2ZABkRGd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8Rmp/cykpM9PYniHV6DrJKKDM4pGhR7zEv4M/o+TA9NS3oqgUw24C1opnvYycPS2RvAA2g4e1n4rY4NxRn8PkMioihjrcYZxtrn/kJVif9mId69kWka4WuA5I4TudzkiPeCob+gbJbDS6/BGLx6ndNyWL463aJQ8t8YSxj4NAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jPAk+QU8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5lDYM8Sp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bsPlg+u0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OLusts3S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jPAk+QU8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5lDYM8Sp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bsPlg+u0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OLusts3S"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33A70868AD;
	Mon, 24 Aug 2026 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787570893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oRfeKqw0N0kQLKC+424hjjzXjyHez3BAAze+hVfK2Rg=;
	b=jPAk+QU8Oz9JiYGtn+V5jZxMEyjAvNiz7x+giw+idIe7iWHZ3M9kfknb1WdCY6dzXCmQD3
	RUzjbubEF3hnieEB81hcTriJJ/TZwn9WrJvXmwfrSSxcQQ1ZlbjhLeh4wlav9BK5HaMwO3
	6684oDDWCwOgqkGGromNNiB5crtoKp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787570893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oRfeKqw0N0kQLKC+424hjjzXjyHez3BAAze+hVfK2Rg=;
	b=5lDYM8Sp+2Zs/UK8WEQsqpqKl/p+3waU+CqzB8+6scnvBPnqiDamSiTmKrctumFJCWBEYi
	aX34sUfDAX5NblCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787570889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oRfeKqw0N0kQLKC+424hjjzXjyHez3BAAze+hVfK2Rg=;
	b=bsPlg+u0OwdeHNbNGrLeK44/R8qCs4CSg2PYS8tAMdo+SiYAgso2oR9h7L/qr4Kf3DuMkG
	JKgB4VRdqQ8XdeAhqD8b8vI76Bx+jM9yHqOPuKlYDaI0OV9UYbWCi5Q1nsdyTPB6peYLQF
	TjI7tAEaxq6cznVveiRZRfRGOnX5P94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787570889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oRfeKqw0N0kQLKC+424hjjzXjyHez3BAAze+hVfK2Rg=;
	b=OLusts3Smqe2AFyYsDutCyN37J42MZz2JAj9qpn2mbZkclBOoroaTNZlb/XsAZWC4PdLh8
	KxcB0oUEd1WRgsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DC4E1333B;
	Mon, 24 Aug 2026 11:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l1sQCsYqjGpBYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Aug 2026 11:28:06 +0000
Message-ID: <c56a1ec4-b70d-4ff6-a2ca-4ff625845b4e@suse.de>
Date: Mon, 24 Aug 2026 13:28:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/70] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Janne Grunau <j@jannau.net>,
 Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 Xinliang Liu <xinliang.liu@linaro.org>, Yongqin Liu
 <yongqin.liu@linaro.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Liu Ying <victor.liu@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>,
 linux-mips@vger.kernel.org, Anitha Chrisanthus
 <anitha.chrisanthus@intel.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org,
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
 Rodrigo Siqueira <siqueira@igalia.com>, Jocelyn Falempe
 <jfalempe@redhat.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Huacai Chen <chenhuacai@kernel.org>,
 Jianmin Lv <lvjianmin@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Qianhai Wu <wuqianhai@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
 nouveau@lists.freedesktop.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Iker Pedrosa <ikerpedrosam@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Zack Rusin <zack.rusin@broadcom.com>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	FORGED_RECIPIENTS(2.00)[m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:j@jannau.net,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:amd-gfx@lists.freedesktop.org,m:liviu.dudau@arm.com,m:linux@armlinux.org.uk,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:stefan@agner.ch,m:rubenru09@aol.com,m:tiantao6@hisilicon.com,m:kong.kongxinwei@hisilicon.com,m:shiyongbang@huawei.com,m:jstultz@google.com,m:sumit.semwal@linaro.org,m:xinliang.liu@linaro.org,m:yongqin.liu@linaro.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:festevam@gmail.com,m:imx@lists.linux.dev,m:paul@crapouillou.net,m:anitha.chrisanthus@intel.com,m:jbrunet@baylibre.com,m:khilman@baylibre.com,m:martin.blumenstingl@googlemail.com,m:linux-amlogic@lists.infradead.org,m:abhinav.kumar@linux.dev,m:lumag@kernel.org,m:jesszhan0024@gmail.com,m:freedreno@lists.freedesktop
 .org,m:marex@denx.de,m:spice-devel@lists.freedesktop.org,m:virtualization@lists.linux.dev,m:geert+renesas@glider.be,m:marcus.folkesson@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:orsonzhai@gmail.com,m:alain.volmat@foss.st.com,m:rgallaispou@gmail.com,m:alexandre.torgue@foss.st.com,m:mcoquelin.stm32@gmail.com,m:philippe.cornu@foss.st.com,m:raphael.gallais-pou@foss.st.com,m:yannick.fertre@foss.st.com,m:wens@kernel.org,m:linux-sunxi@lists.linux.dev,m:jyri.sarha@iki.fi,m:tomi.valkeinen@ideasonboard.com,m:admin@kodeit.net,m:zaq14760@gmail.com,m:lanzano.alex@gmail.com,m:hansg@kernel.org,m:zhengxingda@iscas.ac.cn,m:olvaffe@gmail.com,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:michal.simek@amd.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexandre.belloni@bootlin.com,m:dharma.b@microchip.com,s:p.zabel@pengutronix.de,s:dave.stevenson@raspberrypi.com,s:kernel-list@raspberrypi.com,s:lyude@redhat.com,s:andy.yan@rock-chips.co
 m,s:hjc@rock-chips.com,s:heiko@sntech.de,s:linux-tegra@vger.kernel.org,s:xry111@xry111.site];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,jannau.net,chaosmail.tech,lists.linux.dev,amd.com,arm.com,armlinux.org.uk,samsung.com,kernel.org,linaro.org,vger.kernel.org,nxp.com,agner.ch,aol.com,hisilicon.com,huawei.com,google.com,microsoft.com,linux.microsoft.com,gmail.com,pengutronix.de,oss.nxp.com,crapouillou.net,intel.com,sys-base.io,baylibre.com,googlemail.com,lists.infradead.org,linux.dev,somainline.org,oss.qualcomm.com,poorly.run,denx.de,redhat.com,glider.be,linux.alibaba.com,foss.st.com,sholland.org,iki.fi,ideasonboard.com,proton.me,kodeit.net,iscas.ac.cn,collabora.com,chromium.org,igalia.com,bootlin.com,tuxon.dev,microchip.com,loongson.cn,aosc.io,xry111.site,bp.renesas.com,sntech.de,rock-chips.com,nvidia.com,raspberrypi.com,broadcom.com];
	R_RATELIMIT(0.00)[to_ip_from(RLh4b8m38yy5xh1jtyurbarrz6)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[135];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

Hi Maxime

Am 21.08.26 um 16:38 schrieb Maxime Ripard:
> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>
> This series converts all CRTC drivers tree-wide from the reset hook to
> atomic_create_state, then removes the reset hook from struct
> drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> hardware reset logic mixed into their reset hook; those are moved to
> CRTC creation instead. The conversions were done using a combination of
> Coccinelle semantic patches and manual adjustments.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

I've gone through the series and it looks good to me; except for patch 50.

Feel free to add

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

to the series with the exception of patch 50.

Best regards
Thomas


> ---
> Maxime Ripard (70):
>        drm/adp: Switch to drm_atomic_helper_crtc_create_state
>        drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
>        drm/arm: hdlcd: Switch to drm_atomic_helper_crtc_create_state
>        drm/armada: Switch to drm_atomic_helper_crtc_create_state
>        drm/exynos: Switch to drm_atomic_helper_crtc_create_state
>        drm/fsl-dcu: Switch to drm_atomic_helper_crtc_create_state
>        drm/gud: Switch to drm_atomic_helper_crtc_create_state
>        drm/hisilicon: hibmc: Switch to drm_atomic_helper_crtc_create_state
>        drm/hisilicon: kirin: Switch to drm_atomic_helper_crtc_create_state
>        drm/hyperv: Switch to drm_atomic_helper_crtc_create_state
>        drm/imx: dc: Switch to drm_atomic_helper_crtc_create_state
>        drm/imx: dcss: Switch to drm_atomic_helper_crtc_create_state
>        drm/ingenic: Switch to drm_atomic_helper_crtc_create_state
>        drm/kmb: Switch to drm_atomic_helper_crtc_create_state
>        drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
>        drm/meson: Switch to drm_atomic_helper_crtc_create_state
>        drm/msm: mdp4: Switch to drm_atomic_helper_crtc_create_state
>        drm/mxs: mxsfb: Switch to drm_atomic_helper_crtc_create_state
>        drm/qxl: Switch to drm_atomic_helper_crtc_create_state
>        drm/renesas: shmobile: Switch to drm_atomic_helper_crtc_create_state
>        drm/simple-kms: Remove unused reset_crtc hook
>        drm/simple-kms: Switch to drm_atomic_helper_crtc_create_state
>        drm/sitronix: st7571: Switch to drm_atomic_helper_crtc_create_state
>        drm/sprd: Switch to drm_atomic_helper_crtc_create_state
>        drm/sti: Switch to drm_atomic_helper_crtc_create_state
>        drm/stm: Switch to drm_atomic_helper_crtc_create_state
>        drm/sun4i: Switch to drm_atomic_helper_crtc_create_state
>        drm/tests: Switch to drm_atomic_helper_crtc_create_state
>        drm/tilcdc: Move hardware reset to CRTC creation
>        drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
>        drm/tiny: appletbdrm: Switch to drm_atomic_helper_crtc_create_state
>        drm/tiny: bochs: Switch to drm_atomic_helper_crtc_create_state
>        drm/tiny: cirrus: Switch to drm_atomic_helper_crtc_create_state
>        drm/tiny: pixpaper: Switch to drm_atomic_helper_crtc_create_state
>        drm/tiny: sharp: Switch to drm_atomic_helper_crtc_create_state
>        drm/udl: Switch to drm_atomic_helper_crtc_create_state
>        drm/vbox: Switch to drm_atomic_helper_crtc_create_state
>        drm/verisilicon: Switch to drm_atomic_helper_crtc_create_state
>        drm/virtio: Switch to drm_atomic_helper_crtc_create_state
>        drm/xlnx: Switch to drm_atomic_helper_crtc_create_state
>        drm/mipi-dbi: Switch to drm_atomic_helper_crtc_create_state
>        drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
>        sysfb: Convert to create_state
>        drm/amdgpu: dm: Convert to atomic_create_state
>        drm/komeda: Convert to atomic_create_state
>        drm/malidp: Convert to atomic_create_state
>        drm/ast: Convert to atomic_create_state
>        drm/atmel-hlcdc: Convert to atomic_create_state
>        drm/imx: ipuv3: Convert to atomic_create_state
>        drm/loongsoon: Move hardware reset to CRTC creation
>        drm/loongson: Convert to atomic_create_state
>        drm/mediatek: Convert to atomic_create_state
>        drm/mgag200: Convert to atomic_create_state
>        drm/msm: dpu1: Convert to atomic_create_state
>        drm/msm: mdp5: Convert to atomic_create_state
>        drm/mxsfb: lcdif: Convert to atomic_create_state
>        drm/nouveau: Convert to atomic_create_state
>        drm/omapdrm: Convert to atomic_create_state
>        drm/rcar-du: Convert to atomic_create_state
>        drm/rzg2l-du: Convert to atomic_create_state
>        drm/rockchip: vop: Convert to atomic_create_state
>        drm/rockchip: vop2: Convert to atomic_create_state
>        drm/sitronix: st7920: Convert to atomic_create_state
>        drm/solomon: ssd130x: Convert to atomic_create_state
>        drm/tegra: Convert to atomic_create_state
>        drm/vc4: Convert to atomic_create_state
>        drm/vkms: Convert to atomic_create_state
>        drm/vmwgfx: Convert to atomic_create_state
>        drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
>        drm/crtc: Remove reset
>
>   drivers/gpu/drm/adp/adp_drv.c                      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 17 ++++----
>   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 18 ++++----
>   drivers/gpu/drm/arm/hdlcd_crtc.c                   |  2 +-
>   drivers/gpu/drm/arm/malidp_crtc.c                  | 18 ++++----
>   drivers/gpu/drm/armada/armada_crtc.c               |  2 +-
>   drivers/gpu/drm/ast/ast_mode.c                     | 18 ++++----
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 19 ++++-----
>   drivers/gpu/drm/drm_atomic_state_helper.c          | 45 --------------------
>   drivers/gpu/drm/drm_mode_config.c                  |  4 +-
>   drivers/gpu/drm/drm_simple_kms_helper.c            | 13 +-----
>   drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  2 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |  2 +-
>   drivers/gpu/drm/gud/gud_drv.c                      |  2 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |  2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  2 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  2 +-
>   drivers/gpu/drm/imx/dc/dc-crtc.c                   |  2 +-
>   drivers/gpu/drm/imx/dcss/dcss-crtc.c               |  2 +-
>   drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             | 18 ++++----
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  2 +-
>   drivers/gpu/drm/kmb/kmb_crtc.c                     |  2 +-
>   drivers/gpu/drm/logicvc/logicvc_crtc.c             |  2 +-
>   drivers/gpu/drm/loongson/lsdc_crtc.c               | 26 ++++++------
>   drivers/gpu/drm/mediatek/mtk_crtc.c                | 18 ++++----
>   drivers/gpu/drm/meson/meson_crtc.c                 |  2 +-
>   drivers/gpu/drm/mgag200/mgag200_drv.h              |  4 +-
>   drivers/gpu/drm/mgag200/mgag200_mode.c             | 15 ++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           | 18 ++++----
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  2 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          | 20 ++++-----
>   drivers/gpu/drm/mxsfb/lcdif_kms.c                  | 17 ++++----
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  4 +-
>   drivers/gpu/drm/nouveau/dispnv50/head.c            | 14 +++----
>   drivers/gpu/drm/omapdrm/omap_crtc.c                | 17 ++++----
>   drivers/gpu/drm/qxl/qxl_display.c                  |  2 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     | 17 ++++----
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      | 15 +++----
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |  2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 18 ++++----
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 18 ++++----
>   drivers/gpu/drm/sitronix/st7571.c                  |  2 +-
>   drivers/gpu/drm/sitronix/st7920.c                  | 10 +++--
>   drivers/gpu/drm/solomon/ssd130x.c                  | 10 +++--
>   drivers/gpu/drm/sprd/sprd_dpu.c                    |  2 +-
>   drivers/gpu/drm/sti/sti_crtc.c                     |  2 +-
>   drivers/gpu/drm/stm/ltdc.c                         |  4 +-
>   drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  2 +-
>   drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |  4 +-
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          | 20 ++++-----
>   drivers/gpu/drm/tegra/dc.c                         | 18 ++++----
>   drivers/gpu/drm/tests/drm_kunit_helpers.c          |  2 +-
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c               | 49 +++++++++-------------
>   drivers/gpu/drm/tiny/appletbdrm.c                  |  2 +-
>   drivers/gpu/drm/tiny/bochs.c                       |  2 +-
>   drivers/gpu/drm/tiny/cirrus-qemu.c                 |  2 +-
>   drivers/gpu/drm/tiny/pixpaper.c                    |  2 +-
>   drivers/gpu/drm/tiny/sharp-memory.c                |  2 +-
>   drivers/gpu/drm/udl/udl_modeset.c                  |  2 +-
>   drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
>   drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c          |  2 +-
>   drivers/gpu/drm/vc4/vc4_crtc.c                     | 14 +++----
>   drivers/gpu/drm/vc4/vc4_drv.h                      |  2 +-
>   drivers/gpu/drm/vc4/vc4_txp.c                      |  2 +-
>   drivers/gpu/drm/verisilicon/vs_crtc.c              |  2 +-
>   drivers/gpu/drm/virtio/virtgpu_display.c           |  2 +-
>   drivers/gpu/drm/vkms/vkms_crtc.c                   | 18 ++++----
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 22 ++++------
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  2 +-
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  2 +-
>   include/drm/drm_atomic_state_helper.h              |  3 --
>   include/drm/drm_crtc.h                             | 12 ------
>   include/drm/drm_mipi_dbi.h                         |  2 +-
>   include/drm/drm_simple_kms_helper.h                |  1 -
>   78 files changed, 275 insertions(+), 385 deletions(-)
> ---
> base-commit: 7ea58b9ddb52264a4ed36bccb975062ada32c62d
> change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


