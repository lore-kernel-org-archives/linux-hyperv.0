Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424781;
	b=xvrY0EhUF7U3q7ED4Gr2MfCWEnIk8T7G0FLx4S3BkN4FhJEd7GnOm88r3zh8v5L+pJ6f
	 tH980J4xgrhJfPYjhUWRR49kWhm7pu+OyyLv0d8KTwkBt/AKv5dqk/X8jUv8wNCtqui5N
	 8HZRPNxptEHDa6W/xzyFe954FA2Zxq6RH+8vLIxakJtOs7WK3plsT5n8GUj2Hx+rs0nzI
	 Q2dlfRnrElLB4VPCe0q2NvGWv3yeK3ZK0XTZqd0xrmaMN5XK0+Q6d8iVWrELhS1namE8N
	 1/2MP7P3mRQ8m0DbrYZLlK1Gbw2hJNMLwSDPH8Lqiw9VebeI4k2VQyN8ZcshIJQwX3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424781;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spamd-Result;
	bh=Q5jfLHdOgauf4TJGcojCjJicBompzHEBNJH4FQng/Qg=;
	b=nIx/wjl8ZLDuWHd59PjxejN7xNR+rkEEkqPJvIkP1XJf+vDvyrAAq09pY7X76JQjSG3D
	 SWGjS4RNW7etgfwPmx8v3pABM7pvfZShzMIE7l01wShMLuep1Y5SeCzCyGAXR6juWQ1jM
	 3pOwFLZXcGRHwLIkJOG1a5N8XglaN4VrOy/EgOO+qvfagvuIOlc1ppG0AKHmefCXcbmKV
	 AQQu7FfvMcy0HvC2tN4Xx0xU/JZxHpuNxgAMMxP3dbnoTcqsfegXIy9SbBscEmrfPK+S0
	 1PnBdhqW86xDN7ZNTR8SWCwWQO+gJ1Lc1Kh2eFR0yMB800DxGKzAGyynRImqN0bAg4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="eLHhPEX/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5khW4cqd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zNQS71yM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ewW0O3Sh;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8377606EFE7;
	Mon, 19 Oct 2026 15:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8377606EFE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eLHhPEX/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5khW4cqd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zNQS71yM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ewW0O3Sh
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C40E41F444;
	Mon, 19 Oct 2026 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792424779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q5jfLHdOgauf4TJGcojCjJicBompzHEBNJH4FQng/Qg=;
	b=eLHhPEX/3TCqJ/XmoqatvuqCQSdY3Pr+P5FtOt4Sv3QxwUJXgA10ALsxbhVld0eAe93ZZ4
	d6Cek9M0r++AsQeKzSIm52qOdgSQlIZCuDesVxFP3/Ea5d45QzrOgqzaA4QW8MGCsovmQ+
	jA4wv975YO/0ShG6BVHsrbXD7T6+42c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792424779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q5jfLHdOgauf4TJGcojCjJicBompzHEBNJH4FQng/Qg=;
	b=5khW4cqdC699nJ5v1ujyRTIiRqIwFIwiF6OPf+6TvSoUAYYU9p+lDn2ZB/iMfgzOctVZKY
	cA1AHNoEvehaFOCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792424777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q5jfLHdOgauf4TJGcojCjJicBompzHEBNJH4FQng/Qg=;
	b=zNQS71yM/kc2I8PjYNn19JU+kwk8G5rNHxyb/Q+1ufzMrLSOXAXbNkTdsQ1Vu6xRVVrGgs
	sMbOalMqkrOYeuWe1LON6FlwdaEAZTwI7txzBCIhoUA2gnX0jxqU2Ui87s0ABFD89IXPwR
	noquh1e0zE3+bnmhWYYumfZhud8nw2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792424777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q5jfLHdOgauf4TJGcojCjJicBompzHEBNJH4FQng/Qg=;
	b=ewW0O3ShwsL4XRU7kOgc1bRZz9WfEvSleKV+S+vmfs7Y8PT00P899HadfuKSo+f/7uoR7s
	GvmYEw2bikL52cCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43642134B3;
	Mon, 19 Oct 2026 15:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYPgBkk71mrrPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 15:46:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	virtualization@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] drm: Move drawing to pixel-helper module
Date: Mon, 19 Oct 2026 17:32:41 +0200
Message-ID: <20261019154612.777074-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Add the new module drm_pixel_helper.ko and link existing shared code
for drawing to it. This includes format helpers, panic helpers and
drawing helpers. Update drivers. No functional changes.

The existing helpers are currently part of KMS helpers or the DRM core.
Neither is suitable for this. Adding drm_pixel_helper.ko resolves this.
The new module only depends on the DRM core and common kernel functions.

Future directions: putting pixel-related helpers into the same module
opens up the possibility of sharing more code among them. There is even
more drawing code in vkms and a few other drivers. Hopefully this could
be integrated into pixel helpers at some point.

Smoke-tested on qemu with vesadrm and bochs.

Thomas Zimmermann (4):
  drm: Add helper module for working with pixel data
  drm/pixel: Link format helpers into drm_pixel_helper.ko
  drm/pixel: Link panic helpers into drm_pixel_helper.ko
  drm/pixel: Link draw helpers into drm_pixel_helper.ko

 drivers/gpu/drm/Kconfig                       | 15 ++++++--------
 drivers/gpu/drm/Kconfig.debug                 |  2 +-
 drivers/gpu/drm/Makefile                      | 12 +++++++----
 drivers/gpu/drm/amd/amdgpu/Kconfig            |  1 +
 drivers/gpu/drm/ast/Kconfig                   |  1 +
 drivers/gpu/drm/clients/Kconfig               |  2 +-
 .../gpu/drm/{drm_draw.c => drm_draw_helper.c} |  0
 drivers/gpu/drm/drm_kms_helper_common.c       | 13 ------------
 drivers/gpu/drm/drm_panic_helper.c            |  1 +
 drivers/gpu/drm/drm_panic_internal.h          | 14 -------------
 drivers/gpu/drm/drm_pixel_helper_common.c     | 20 +++++++++++++++++++
 drivers/gpu/drm/drm_pixel_helper_internal.h   | 20 +++++++++++++++++++
 drivers/gpu/drm/gud/Kconfig                   |  1 +
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |  1 +
 drivers/gpu/drm/hyperv/Kconfig                |  1 +
 drivers/gpu/drm/i915/Kconfig                  |  1 +
 drivers/gpu/drm/imx/ipuv3/Kconfig             |  1 +
 drivers/gpu/drm/mgag200/Kconfig               |  1 +
 drivers/gpu/drm/nouveau/Kconfig               |  1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig       |  1 +
 drivers/gpu/drm/renesas/shmobile/Kconfig      |  1 +
 drivers/gpu/drm/sitronix/Kconfig              |  2 ++
 drivers/gpu/drm/solomon/Kconfig               |  1 +
 drivers/gpu/drm/sysfb/Kconfig                 |  1 +
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c     |  1 +
 drivers/gpu/drm/tidss/Kconfig                 |  1 +
 drivers/gpu/drm/tiny/Kconfig                  |  6 ++++++
 drivers/gpu/drm/tiny/bochs.c                  |  1 +
 drivers/gpu/drm/virtio/Kconfig                |  1 +
 30 files changed, 83 insertions(+), 42 deletions(-)
 rename drivers/gpu/drm/{drm_draw.c => drm_draw_helper.c} (100%)
 create mode 100644 drivers/gpu/drm/drm_pixel_helper_common.c
 create mode 100644 drivers/gpu/drm/drm_pixel_helper_internal.h


base-commit: 5b9ee97c47574138633a1cb70a32d118b6860a43
-- 
2.56.0

