Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921782;
	b=f6RDzcZxsG2xydoMNyVP/STIRuhXpZsBKTRtUjKeSo3fvxi2zt42bt7CLkJiUnFBtIrV
	 HTQsTd+bGHeoiAIP8LcaU6aYnQJ9xRmq8naqixGDCj2+pLUGLvTDwG+oYcl6/BOQQvZnl
	 nTSB7YeSKX8a3f+8QCtteP230t5zBp+mnTDp4y2cj4hic6C5XbzUwcaVubGz1ld9OJ/rM
	 /qU7gP1h9y24EEFRi4KxwCxwpPKShsrtMLID7Ht+uPAmG0R0R/P06a4TTsxCnfizHC3or
	 hcfhppNUl2XRpdIL6YAzGnalpTLDhOSUT5O8a9KkwozF45LuKsG3+qY8S8gNy/gU25g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921782;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=rcC5LgWPdWSZHMv7xIAt2KV/AX/DvKKoKQ8foLqzlw4=;
	b=G3PJMHuuFbzuGghsMbiQBpq+PcqLRnAHnrQ/FZSKZTFBOjNuCXfVziPlhnlsWvXjkKl4
	 yQzqIb7Ry05+ewZfZve8V72V9xjSBJOF6j2zdIIWtRVQdvSFdxWfYPdpHvfu3GAc0gDMv
	 gvvUmFInBRDz/WXp/0cadB/gJId2nDmBUi0GjzIuVHKYARFMJtkCwiDeolvh5JvDPit23
	 byEmCMVeNUyZc5AQyEjPvr9tHiPxkMp+xlFBkear5KRATXxn7jbMvr+2y6vlpIpS1Jk4A
	 A8YyY62ekXvqkA4zjtjSW5UqtOcfx3ZZrwBIBpKU3bVxHHH/GyN/czofAGyV2LlVWhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lTDn19do;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="w/rpPAMl";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lTDn19do;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="w/rpPAMl";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FA606A32A;
	Tue, 17 Nov 2026 13:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 712FA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lTDn19do;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w/rpPAMl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lTDn19do;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w/rpPAMl
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1107222317;
	Tue, 17 Nov 2026 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794921779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcC5LgWPdWSZHMv7xIAt2KV/AX/DvKKoKQ8foLqzlw4=;
	b=lTDn19doBb9OLIgrH9s1ydM77pm0B1t2S37Nl82CLFgSaf3S4En1q9hthKer8wb9gkaT7Y
	/Kro6o+bEdwOXoy7w3MkaOyuuUXbNMeIFCaiwwPj2Cj8JhK19MtJ4nrfUdPmxw+1z+3HJM
	zQ+mW7XQ9Ufy2JUUHRhDf/9PG+BZ7BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794921779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcC5LgWPdWSZHMv7xIAt2KV/AX/DvKKoKQ8foLqzlw4=;
	b=w/rpPAMlvECO03bBuWSR5aJcmVie5v1W1Q6fU4W8MSpK9ZAUZCLJjaH840/cVShHHDiHCI
	2mHuazqbaSOhJ+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794921779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcC5LgWPdWSZHMv7xIAt2KV/AX/DvKKoKQ8foLqzlw4=;
	b=lTDn19doBb9OLIgrH9s1ydM77pm0B1t2S37Nl82CLFgSaf3S4En1q9hthKer8wb9gkaT7Y
	/Kro6o+bEdwOXoy7w3MkaOyuuUXbNMeIFCaiwwPj2Cj8JhK19MtJ4nrfUdPmxw+1z+3HJM
	zQ+mW7XQ9Ufy2JUUHRhDf/9PG+BZ7BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794921779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcC5LgWPdWSZHMv7xIAt2KV/AX/DvKKoKQ8foLqzlw4=;
	b=w/rpPAMlvECO03bBuWSR5aJcmVie5v1W1Q6fU4W8MSpK9ZAUZCLJjaH840/cVShHHDiHCI
	2mHuazqbaSOhJ+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1BF1334C;
	Tue, 17 Nov 2026 13:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jinhLy9V/GobdgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 13:22:55 +0000
Message-ID: <47f0b548-2ce5-4a71-864c-7c98c267c666@suse.de>
Date: Tue, 17 Nov 2026 14:22:55 +0100
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/64] drm: Switch drivers to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Janne Grunau <j@jannau.net>,
 Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sashiko-bot@kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yongbang Shi <shiyongbang@huawei.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer
 <s.hauer@pengutronix.de>, imx@lists.linux.dev,
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Dmitry Baryshkov
 <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
 nouveau@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, Geert Uytterhoeven
 <geert+renesas@glider.be>,
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
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Zack Rusin
 <zack.rusin@broadcom.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Michal Simek <michal.simek@amd.com>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
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
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,jannau.net,chaosmail.tech,lists.linux.dev,amd.com,kernel.org,arm.com,armlinux.org.uk,redhat.com,samsung.com,linaro.org,vger.kernel.org,nxp.com,agner.ch,hisilicon.com,huawei.com,microsoft.com,linux.microsoft.com,gmail.com,pengutronix.de,crapouillou.net,intel.com,sys-base.io,iscas.ac.cn,loongson.cn,aosc.io,xry111.site,collabora.com,linux.dev,somainline.org,oss.qualcomm.com,poorly.run,ideasonboard.com,glider.be,bp.renesas.com,lechnology.com,linux.alibaba.com,foss.st.com,sholland.org,nvidia.com,iki.fi,synopsys.com,chromium.org,broadcom.com,epam.com];
	R_RATELIMIT(0.00)[to_ip_from(RLy3j4wzmyjqg3bxpokuu7brne)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[104];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

Hi Maxime

Am 16.11.26 um 11:30 schrieb Maxime Ripard:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles. However, the two roles need different
> behaviors, notably for objects like drm_private_obj that must persist
> across suspend/resume and are excluded from drm_mode_config_reset()
> by design.
>
> Previous series introduced drm_mode_config_create_initial_state() to
> handle only the initial state creation at probe time, including
> drm_private_obj. Unlike drm_mode_config_reset(), it returns an error
> code, allowing drivers to properly handle allocation failures.
>
> This series switches all drivers calling drm_mode_config_reset() at
> probe time to drm_mode_config_create_initial_state(). The conversion
> was done using a Coccinelle semantic patch.
>
> This is part, and the final piece, of a larger transition to remove the
> overloaded reset semantics from the KMS subsystem, following similar
> series for planes, CRTCs, connectors, and bridges.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

For the entire series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>


> ---
> Changes in v2:
> - Fix some sashiko issues
> - Link to v1: https://lore.kernel.org/r/20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org
>
> ---
> Maxime Ripard (64):
>        drm/adp: Switch to drm_mode_config_create_initial_state
>        drm/amdgpu: Switch to drm_mode_config_create_initial_state
>        drm/hdlcd: Fix drm_atomic_helper_shutdown() on the probe error path
>        drm/hdlcd: Switch to drm_mode_config_create_initial_state
>        drm/armada: Switch to drm_mode_config_create_initial_state
>        drm/ast: Switch to drm_mode_config_create_initial_state
>        drm/exynos: Switch to drm_mode_config_create_initial_state
>        drm/fsl-dcu: Switch to drm_mode_config_create_initial_state
>        drm/hisilicon/hibmc: Remove hibmc_unload() from the load error path
>        drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state
>        drm/hyperv: Switch to drm_mode_config_create_initial_state
>        drm/imx/ipuv3: Switch to drm_mode_config_create_initial_state
>        drm/ingenic: Move the private object creation before the reset
>        drm/ingenic: Switch to drm_mode_config_create_initial_state
>        drm/kmb: Switch to drm_mode_config_create_initial_state
>        drm/logicvc: Switch to drm_mode_config_create_initial_state
>        drm/loongson: Switch to drm_mode_config_create_initial_state
>        drm/mediatek: Switch to drm_mode_config_create_initial_state
>        drm/mgag200: Switch to drm_mode_config_create_initial_state
>        drm/msm: Switch to drm_mode_config_create_initial_state
>        drm/nouveau: Switch to drm_mode_config_create_initial_state
>        drm/omap: Switch to drm_mode_config_create_initial_state
>        drm/qxl: Destroy the monitors object on the modeset init error path
>        drm/qxl: Switch to drm_mode_config_create_initial_state
>        drm/rcar-du: Switch to drm_mode_config_create_initial_state
>        drm/rz-du: Switch to drm_mode_config_create_initial_state
>        drm/shmobile: Switch to drm_mode_config_create_initial_state
>        drm/st7571: Switch to drm_mode_config_create_initial_state
>        drm/st7586: Switch to drm_mode_config_create_initial_state
>        drm/st7735r: Switch to drm_mode_config_create_initial_state
>        drm/st7920: Switch to drm_mode_config_create_initial_state
>        drm/sprd: Switch to drm_mode_config_create_initial_state
>        drm/sti: Fix drm_atomic_helper_shutdown() on the bind error paths
>        drm/sti: Move drm_mode_config_create_initial_state() before drm_dev_register()
>        drm/stm: Switch to drm_mode_config_create_initial_state
>        drm/sun4i: Switch to drm_mode_config_create_initial_state
>        drm/tegra: Switch to drm_mode_config_create_initial_state
>        drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_state
>        drm/tests: drm_atomic_test: Switch to drm_mode_config_create_initial_state
>        drm/tests: drm_bridge_test: Switch to drm_mode_config_create_initial_state
>        drm/tests: drm_hdmi_state_helper_test: Switch to drm_mode_config_create_initial_state
>        drm/tidss: Switch to drm_mode_config_create_initial_state
>        drm/tilcdc: Switch to drm_mode_config_create_initial_state
>        drm/arcpgu: Switch to drm_mode_config_create_initial_state
>        drm/bochs: Switch to drm_mode_config_create_initial_state
>        drm/cirrus-qemu: Switch to drm_mode_config_create_initial_state
>        drm/gm12u320: Switch to drm_mode_config_create_initial_state
>        drm/hx8357d: Switch to drm_mode_config_create_initial_state
>        drm/ili9163: Switch to drm_mode_config_create_initial_state
>        drm/ili9225: Switch to drm_mode_config_create_initial_state
>        drm/ili9341: Switch to drm_mode_config_create_initial_state
>        drm/ili9486: Switch to drm_mode_config_create_initial_state
>        drm/mi0283qt: Switch to drm_mode_config_create_initial_state
>        drm/panel-mipi-dbi: Switch to drm_mode_config_create_initial_state
>        drm/pixpaper: Switch to drm_mode_config_create_initial_state
>        drm/repaper: Switch to drm_mode_config_create_initial_state
>        drm/sharp-memory: Switch to drm_mode_config_create_initial_state
>        drm/udl: Switch to drm_mode_config_create_initial_state
>        drm/vboxvideo: Switch to drm_mode_config_create_initial_state
>        drm/verisilicon: Switch to drm_mode_config_create_initial_state
>        drm/virtio: Switch to drm_mode_config_create_initial_state
>        drm/vmwgfx: Switch to drm_mode_config_create_initial_state
>        drm/xen: Switch to drm_mode_config_create_initial_state
>        drm/xlnx: Switch to drm_mode_config_create_initial_state
>
>   drivers/gpu/drm/adp/adp_drv.c                      |  4 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  4 +++-
>   .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  3 ++-
>   .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |  4 +++-
>   drivers/gpu/drm/arm/hdlcd_drv.c                    |  9 +++++----
>   drivers/gpu/drm/armada/armada_drv.c                |  4 +++-
>   drivers/gpu/drm/ast/ast_mode.c                     |  4 +++-
>   drivers/gpu/drm/exynos/exynos_drm_drv.c            |  4 +++-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |  4 +++-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  7 ++++---
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  4 +---
>   drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |  4 +++-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c          | 22 +++++++++++++---------
>   drivers/gpu/drm/kmb/kmb_drv.c                      |  3 +--
>   drivers/gpu/drm/logicvc/logicvc_mode.c             |  4 +++-
>   drivers/gpu/drm/loongson/lsdc_drv.c                |  4 +++-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  8 +++++++-
>   drivers/gpu/drm/mgag200/mgag200_g200.c             |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200eh.c           |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200er.c           |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200ev.c           |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200se.c           |  4 +++-
>   drivers/gpu/drm/mgag200/mgag200_g200wb.c           |  4 +++-
>   drivers/gpu/drm/msm/msm_kms.c                      |  4 +++-
>   drivers/gpu/drm/nouveau/nouveau_display.c          |  4 +++-
>   drivers/gpu/drm/omapdrm/omap_drv.c                 |  4 +++-
>   drivers/gpu/drm/qxl/qxl_display.c                  | 11 +++++++++--
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |  4 +++-
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c       |  4 +++-
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c   |  4 +++-
>   drivers/gpu/drm/sitronix/st7571.c                  |  4 +++-
>   drivers/gpu/drm/sitronix/st7586.c                  |  4 +++-
>   drivers/gpu/drm/sitronix/st7735r.c                 |  4 +++-
>   drivers/gpu/drm/sitronix/st7920.c                  |  4 +---
>   drivers/gpu/drm/sprd/sprd_drm.c                    |  6 ++++--
>   drivers/gpu/drm/sti/sti_drv.c                      | 10 ++++------
>   drivers/gpu/drm/stm/drv.c                          |  6 +++++-
>   drivers/gpu/drm/sun4i/sun4i_drv.c                  |  4 +++-
>   drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  6 +++---
>   drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  2 +-
>   drivers/gpu/drm/tegra/drm.c                        |  4 +++-
>   drivers/gpu/drm/tests/drm_atomic_commit_test.c     |  3 ++-
>   drivers/gpu/drm/tests/drm_atomic_test.c            |  4 +++-
>   drivers/gpu/drm/tests/drm_bridge_test.c            | 12 +++++++++---
>   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  3 ++-
>   drivers/gpu/drm/tidss/tidss_drv.c                  |  6 +++++-
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  4 +++-
>   drivers/gpu/drm/tiny/arcpgu.c                      |  4 +++-
>   drivers/gpu/drm/tiny/bochs.c                       |  4 +---
>   drivers/gpu/drm/tiny/cirrus-qemu.c                 |  4 +++-
>   drivers/gpu/drm/tiny/gm12u320.c                    |  4 +++-
>   drivers/gpu/drm/tiny/hx8357d.c                     |  4 +++-
>   drivers/gpu/drm/tiny/ili9163.c                     |  4 +++-
>   drivers/gpu/drm/tiny/ili9225.c                     |  4 +++-
>   drivers/gpu/drm/tiny/ili9341.c                     |  4 +++-
>   drivers/gpu/drm/tiny/ili9486.c                     |  4 +++-
>   drivers/gpu/drm/tiny/mi0283qt.c                    |  4 +++-
>   drivers/gpu/drm/tiny/panel-mipi-dbi.c              |  4 +++-
>   drivers/gpu/drm/tiny/pixpaper.c                    |  4 +++-
>   drivers/gpu/drm/tiny/repaper.c                     |  4 +++-
>   drivers/gpu/drm/tiny/sharp-memory.c                |  4 +++-
>   drivers/gpu/drm/udl/udl_modeset.c                  |  4 +++-
>   drivers/gpu/drm/vboxvideo/vbox_mode.c              |  5 ++++-
>   drivers/gpu/drm/verisilicon/vs_drm.c               |  4 +++-
>   drivers/gpu/drm/virtio/virtgpu_display.c           |  3 +--
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 14 +++++++++++++-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  3 ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  3 ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  3 ---
>   drivers/gpu/drm/xen/xen_drm_front_kms.c            |  4 +++-
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  6 ++++--
>   74 files changed, 243 insertions(+), 115 deletions(-)
> ---
> base-commit: a8670a2ab1a81dc3fc30093e47c23b83244ca4d0
> change-id: 20260712-drm-no-more-config-reset-1ea89f56693d
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


