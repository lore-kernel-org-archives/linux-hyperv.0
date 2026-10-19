Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424794;
	b=WkXVzu9UHvKWc2vdROQ5RBAJCe59SmhVJNzYhCnE/0efn1HK7LOJeFwusOoOyu0yhJJ9
	 LVW/KXWR0MPR3OvvE9Oohys+mpdwbGzZvi2aQigiJxTYfJptnYFIseeenpc9VpKw29sGo
	 7rC30MJ6gdispemWcE14F5lGZ5rqR3x0i7/FAwbXnCAg06w7Glw3+STSIwIZ5r0ZQyhvo
	 YrwJieUT4eWMYJso5fNRwtiIjJSAzHDSD1tHPsk/Li3lj9mE1lO8TpPyjHOhoA5htI2Sy
	 AAYgAxKIO6jplNI+XlME3GWiV/2dfUJdo0mjgqaMLwJNndiUgaKhmPqGQyl+SScIXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424794;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spamd-Result;
	bh=h7muRxXAykkt35sFl8LMwP3eh6YlcPhVpucg+ybyypg=;
	b=tOnsJG2UCpWnb4u2eAusfNNIhAbEMGybHAEVuKv6bAxnEZxJjY1TjYvv3R+I5OeZdw6J
	 0yYPHjjVRbIoUNWVuKlO2vRJ9SQqQq1qctYu2/q7wmjSn08PPgc/dyxgt+IscFg3LAubX
	 c5XrBxBcol38HG8wpOhnkUUzqnPAWho4/iUmxhRG2SCd9J8JphABF+y0cxVqaA9d0biA/
	 OK5taO6EYwyN3EmSx9YmCxQySMlqPjERWwRM4tQ4YlCzZt7Of80sq9YQcyQld6VkLvU9Q
	 MOfzMqiZizkYfzJL9bS3q5qcCJTYKRlxVAkEYq2er8wG7gRofwAxzxNeLSnqqfFJAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jxUOnrfC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dvoDA8c6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vr717cFZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kOr8HApD;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF61606EFC0;
	Mon, 19 Oct 2026 15:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF61606EFC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jxUOnrfC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dvoDA8c6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vr717cFZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kOr8HApD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9379921CAB;
	Mon, 19 Oct 2026 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792424779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7muRxXAykkt35sFl8LMwP3eh6YlcPhVpucg+ybyypg=;
	b=jxUOnrfCBUF5JTzlQzoegQhfqYUPP/ynAT8m+6+Jio65O+iUTEh8EFHHHwwHslQoMtV/Nv
	n3C6IwlKs9WTIedKY9kP9WEhWpA1HtxYG33YG/tc9VpKPSDPriaRlcJnGZNXRsSds93+Bn
	X/AtZ2l5DuhGmXjKeMBd16ZFP51NzOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792424779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7muRxXAykkt35sFl8LMwP3eh6YlcPhVpucg+ybyypg=;
	b=dvoDA8c69seYeJWKAnQF7W+q3L5eOJP4MC0uaqYG3Slfbx2VYF91+PtL1vN1NmLOCN2LkY
	FHo8XK8sRkAhrwAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792424778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7muRxXAykkt35sFl8LMwP3eh6YlcPhVpucg+ybyypg=;
	b=vr717cFZCXtUGxipHn0i1TJVI0JtcjwvCY0UZxHXNXVyY6ftP6wjSAXco9TtpkiNiVoZqO
	/pvq0f1a3R3YWPpd+NZNvRZKZ6LcQIM/rPfDyV7WTkuNXV9j5UNHYvBRph0iYL6uYZvJ8a
	utd1x+//p+H0Y3fAG687VgoVETO/NHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792424778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7muRxXAykkt35sFl8LMwP3eh6YlcPhVpucg+ybyypg=;
	b=kOr8HApDnYmbSi59JnVx97HRN7e4VuCObGQwGOEF8m86/BQX5uwjFgCwoZRMvDM5LUebzy
	QSAb/50GvjjVgXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15390137CA;
	Mon, 19 Oct 2026 15:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYPgBkk71mrrPAAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 15:46:18 +0000
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
Subject: [PATCH 2/4] drm/pixel: Link format helpers into drm_pixel_helper.ko
Date: Mon, 19 Oct 2026 17:32:43 +0200
Message-ID: <20261019154612.777074-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019154612.777074-1-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Move drm_format_helper.o from drm_kms_helper.ko to drm_pixel_helper.ko.
Select DRM_PIXEL_HELPER from the drivers that use the format helpers.
While at it, include <drm/drm_format_helper.h> in a few places where it
is missing.

Format helpers copy pixel data from a DRM framebuffer to a hardware
scanout buffer or some other destination. They can transform the color
format as part of the copying operation. A number of drivers require
this functionality as part of their display update.

The format helpers are currently part of drm_kms_helper.ko, which is
for mode-setting helpers (i.e, helpers that modify the display pipeline).

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                        | 1 +
 drivers/gpu/drm/Kconfig.debug                  | 1 +
 drivers/gpu/drm/Makefile                       | 2 +-
 drivers/gpu/drm/ast/Kconfig                    | 1 +
 drivers/gpu/drm/gud/Kconfig                    | 1 +
 drivers/gpu/drm/hisilicon/hibmc/Kconfig        | 1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 1 +
 drivers/gpu/drm/hyperv/Kconfig                 | 1 +
 drivers/gpu/drm/mgag200/Kconfig                | 1 +
 drivers/gpu/drm/sitronix/Kconfig               | 2 ++
 drivers/gpu/drm/solomon/Kconfig                | 1 +
 drivers/gpu/drm/sysfb/Kconfig                  | 1 +
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c      | 1 +
 drivers/gpu/drm/tiny/Kconfig                   | 6 ++++++
 drivers/gpu/drm/tiny/bochs.c                   | 1 +
 15 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index dce5e25671ee..8e4a588e9111 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -37,6 +37,7 @@ config DRM_MIPI_DBI
 	tristate
 	depends on DRM
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 
 config DRM_MIPI_DSI
 	bool
diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index b909cd0a619f..1afb9cad850f 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -70,6 +70,7 @@ config DRM_KUNIT_TEST
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KUNIT_TEST_HELPERS
 	select DRM_PANIC_HELPER
+	select DRM_PIXEL_HELPER
 	select DRM_SYSFB_HELPER
 	select PRIME_NUMBERS
 	default KUNIT_ALL_TESTS
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5f555a2c1a4c..fbc643747110 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
 drm_pixel_helper-y := \
+	drm_format_helper.o \
 	drm_pixel_helper_common.o
 obj-$(CONFIG_DRM_PIXEL_HELPER) += drm_pixel_helper.o
 
@@ -150,7 +151,6 @@ drm_kms_helper-y := \
 	drm_crtc_helper.o \
 	drm_damage_helper.o \
 	drm_flip_work.o \
-	drm_format_helper.o \
 	drm_gem_atomic_helper.o \
 	drm_gem_framebuffer_helper.o \
 	drm_kms_helper_common.o \
diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
index 242fbccdf844..1758debb8317 100644
--- a/drivers/gpu/drm/ast/Kconfig
+++ b/drivers/gpu/drm/ast/Kconfig
@@ -5,6 +5,7 @@ config DRM_AST
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	select I2C
 	select I2C_ALGOBIT
 	help
diff --git a/drivers/gpu/drm/gud/Kconfig b/drivers/gpu/drm/gud/Kconfig
index b4d2136942f0..385702103633 100644
--- a/drivers/gpu/drm/gud/Kconfig
+++ b/drivers/gpu/drm/gud/Kconfig
@@ -7,6 +7,7 @@ config DRM_GUD
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_PIXEL_HELPER
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  This is a DRM display driver for GUD USB Displays or display
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index adf4516bf8f6..f896f8cb8689 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -7,6 +7,7 @@ config DRM_HISI_HIBMC
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	select I2C
 	select I2C_ALGOBIT
 	help
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 7849abd0488e..aaef70153f7e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_format_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
diff --git a/drivers/gpu/drm/hyperv/Kconfig b/drivers/gpu/drm/hyperv/Kconfig
index 86234f6a73f2..21146ed294e3 100644
--- a/drivers/gpu/drm/hyperv/Kconfig
+++ b/drivers/gpu/drm/hyperv/Kconfig
@@ -5,6 +5,7 @@ config DRM_HYPERV
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	 This is a KMS driver for Hyper-V synthetic video device. Choose this
 	 option if you would like to enable drm driver for Hyper-V virtual
diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index a962ae564a75..06bb23a888f9 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -5,6 +5,7 @@ config DRM_MGAG200
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	select I2C
 	select I2C_ALGOBIT
 	help
diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/Kconfig
index 41a428ef8295..c4b54f4f4f69 100644
--- a/drivers/gpu/drm/sitronix/Kconfig
+++ b/drivers/gpu/drm/sitronix/Kconfig
@@ -4,6 +4,7 @@ config DRM_ST7571
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	select VIDEOMODE_HELPERS
 	help
 	  Sitronix ST7571 is a driver and controller for 4-level gray
@@ -46,6 +47,7 @@ config DRM_ST7586
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
+	select DRM_PIXEL_HELPER
 	help
 	  DRM driver for the following Sitronix ST7586 panels:
 	  * LEGO MINDSTORMS EV3
diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 400a6cab3a67..b65daabb2e96 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -5,6 +5,7 @@ config DRM_SSD130X
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	  DRM driver for the SSD13xx Solomon and SINO WEALTH SH110x OLED
 	  controllers. This is only for the core driver, a driver for the
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index f7e48178885e..eaf6b8d1cd51 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -5,6 +5,7 @@ menu "Drivers for system framebuffers"
 
 config DRM_SYSFB_HELPER
 	tristate
+	select DRM_PIXEL_HELPER
 	depends on DRM
 
 config DRM_COREBOOTDRM
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 13df0925163a..c403c168c4c3 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -10,6 +10,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_panic.h>
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a47..176d75ce17ea 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -6,6 +6,7 @@ config DRM_APPLETBDRM
 	depends on X86 || COMPILE_TEST
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	  Say Y here if you want support for the display of Touch Bars on x86
 	  MacBook Pros.
@@ -30,6 +31,7 @@ config DRM_BOCHS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	  This is a KMS driver for qemu's stdvga output. Choose this option
 	  for qemu.
@@ -42,6 +44,7 @@ config DRM_CIRRUS_QEMU
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	 This is a KMS driver for emulated cirrus device in qemu.
 	 It is *NOT* intended for real cirrus devices. This requires
@@ -62,6 +65,7 @@ config DRM_GM12U320
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	 This is a KMS driver for projectors which use the GM12U320 chipset
 	 for video transfer over USB2/3, such as the Acer C120 mini projector.
@@ -186,6 +190,7 @@ config TINYDRM_REPAPER
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	  DRM driver for the following Pervasive Displays panels:
 	  1.44" TFT EPD Panel (E1144CS021)
@@ -201,6 +206,7 @@ config TINYDRM_SHARP_MEMORY
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER
 	help
 	  DRM Driver for the following Sharp Memory Panels:
 	  * 1.00" Sharp Memory LCD (LS010B7DH04)
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1..2744fe26dbeb 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -13,6 +13,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
-- 
2.56.0

