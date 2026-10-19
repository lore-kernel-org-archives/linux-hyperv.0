Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424802;
	b=nXc5nQKZh9r2GBNofxhXMNe+hsz815ksrO2VAuCEbpMLikQghlkB3il6qlb8ApGHLv2C
	 GKfTQMXLNASIFkAUVEjoBV5KorMZUjOowzaFOrMm04DM0pGnmZMq9yfjhuXCNFexzyeu2
	 jwtTYhh0lKeNsm4Od/NnqbO7m0vNBC0VCgJIMSO7k7tk+1SK9kC5ygmggjjhn0bRAtobo
	 d5Xop9vSHIHgo5bTUSTylm7+ZBCfZwdAEMnBrkabMZ4LteZYYEQZ81cu9ldZPv84YIW9V
	 0DECQU4nyMp6e153QHyv4kmOO92N4/HW4rdVUg4TvFN1484MO56c4chq4kHY6nCSLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424802;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Rspamd-Pre-Result:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Spamd-Result:X-Rspamd-Server;
	bh=AT+mLGGAR9lMsVQ4EgFREBQMYpMc/ICAky5vzL2w4MU=;
	b=M6yZ8tCANDeyWNqDErocmTauWhqqH1UmrYeykhEgU45xwpKMiY0wthCLRgMmMndkHcRk
	 i+A/IYVEbASCm3YADj+fygEukWfvGSI5K181tqiUmfBTbSHe9vBwtVaBO4+uguMTjZz1t
	 ZVaNyCqf20e7GtvOhPs7486QWmyokDLtxNwf09C9xxuca6DZvfOFEcxNq9ydUrFWt5mhx
	 kSVMwoErW4qjSEGrWqPmJ2hOjCYggKG7F9V0fv2HtC2HZVUy7zrzQ2iB4oz8lj6ejKZAb
	 IRUiOVPbOSCJ3oZsL5/85efm3bFN/+EpxU1VRphR/ErOBCGPnyZN21PO8eLknUkSVHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815A60740BC;
	Mon, 19 Oct 2026 15:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9815A60740BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E30D21BB5;
	Mon, 19 Oct 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D22137D2;
	Mon, 19 Oct 2026 15:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYPgBkk71mrrPAAAD6G6ig:T4
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
Subject: [PATCH 3/4] drm/pixel: Link panic helpers into drm_pixel_helper.ko
Date: Mon, 19 Oct 2026 17:32:44 +0200
Message-ID: <20261019154612.777074-4-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Queue-Id: 3E30D21BB5
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Move panic helpers from drm_kms_helper to drm_pixel_helper.ko. Select
DRM_PIXEL_HELPER in the drivers that use the panic helpers.

Drop the Kconfig option DRM_PANIC_HELPER. With the user selecting
panic support via DRM_PANIC, panic helpers will become available to
drivers.

Related module init and exit functions are now declared in the new
header file drm_pixel_helper_internal.h. Other internal functions for
pixel helpers can later go there as well.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                     |  9 ++-------
 drivers/gpu/drm/Kconfig.debug               |  1 -
 drivers/gpu/drm/Makefile                    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/Kconfig          |  1 +
 drivers/gpu/drm/drm_kms_helper_common.c     | 13 -------------
 drivers/gpu/drm/drm_panic_helper.c          |  1 +
 drivers/gpu/drm/drm_panic_internal.h        | 14 --------------
 drivers/gpu/drm/drm_pixel_helper_common.c   | 14 ++++++++++++++
 drivers/gpu/drm/drm_pixel_helper_internal.h | 20 ++++++++++++++++++++
 drivers/gpu/drm/i915/Kconfig                |  1 +
 drivers/gpu/drm/imx/ipuv3/Kconfig           |  1 +
 drivers/gpu/drm/nouveau/Kconfig             |  1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig     |  1 +
 drivers/gpu/drm/renesas/shmobile/Kconfig    |  1 +
 drivers/gpu/drm/tidss/Kconfig               |  1 +
 drivers/gpu/drm/virtio/Kconfig              |  1 +
 16 files changed, 47 insertions(+), 37 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_pixel_helper_internal.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8e4a588e9111..bf7c59944340 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -46,13 +46,14 @@ config DRM_MIPI_DSI
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
-	select DRM_PANIC_HELPER if DRM_PANIC
 	help
 	  CRTC helpers for KMS drivers.
 
 config DRM_PIXEL_HELPER
 	tristate
 	depends on DRM
+	select DRM_DRAW if DRM_PANIC
+	select FONT_SUPPORT if DRM_PANIC
 	help
 	  Helpers for working with pixel data in DRM.
 
@@ -135,12 +136,6 @@ config DRM_PANIC_SCREEN_QR_VERSION
 	  Smaller QR code are easier to read, but will contain less debugging
 	  data. Default is 40.
 
-config DRM_PANIC_HELPER
-	bool
-	depends on DRM
-	select DRM_DRAW
-	select FONT_SUPPORT
-
 config DRM_RAS
 	bool "DRM RAS support"
 	depends on DRM
diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1afb9cad850f..4573cad368a2 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -69,7 +69,6 @@ config DRM_KUNIT_TEST
 	select DRM_EXPORT_FOR_TESTS if m
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KUNIT_TEST_HELPERS
-	select DRM_PANIC_HELPER
 	select DRM_PIXEL_HELPER
 	select DRM_SYSFB_HELPER
 	select PRIME_NUMBERS
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index fbc643747110..18a5a5baf029 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -102,6 +102,8 @@ obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 drm_pixel_helper-y := \
 	drm_format_helper.o \
 	drm_pixel_helper_common.o
+drm_pixel_helper-$(CONFIG_DRM_PANIC) += drm_panic_helper.o
+drm_pixel_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_helper_qr.o
 obj-$(CONFIG_DRM_PIXEL_HELPER) += drm_pixel_helper.o
 
 #
@@ -160,8 +162,6 @@ drm_kms_helper-y := \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o \
 	drm_vblank_helper.o
-drm_kms_helper-$(CONFIG_DRM_PANIC_HELPER) += drm_panic_helper.o
-drm_kms_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_helper_qr.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
 #
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 12e4a41bf1f0..78584d8aeb52 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -12,6 +12,7 @@ config DRM_AMDGPU
 	select DRM_DISPLAY_HDCP_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select DRM_SCHED
 	select DRM_TTM
 	select DRM_TTM_HELPER
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 1e55ecac4698..76c7297b24e9 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -30,7 +30,6 @@
 #include <linux/moduleparam.h>
 
 #include "drm_crtc_helper_internal.h"
-#include "drm_panic_internal.h"
 
 #if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
 bool drm_fbdev_emulation = true;
@@ -68,18 +67,6 @@ MODULE_PARM_DESC(drm_leak_fbdev_smem,
 
 #endif
 
-static int __init drm_kms_helper_init(void)
-{
-	return drm_panic_helper_init();
-}
-module_init(drm_kms_helper_init);
-
-static void __exit drm_kms_helper_exit(void)
-{
-	drm_panic_helper_exit();
-}
-module_exit(drm_kms_helper_exit);
-
 MODULE_AUTHOR("David Airlie, Jesse Barnes");
 MODULE_DESCRIPTION("DRM KMS helper");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
index 8913c3d22e8d..6f0d3a2df6b3 100644
--- a/drivers/gpu/drm/drm_panic_helper.c
+++ b/drivers/gpu/drm/drm_panic_helper.c
@@ -20,6 +20,7 @@
 
 #include "drm_draw_internal.h"
 #include "drm_panic_internal.h"
+#include "drm_pixel_helper_internal.h"
 
 struct drm_panic_line {
 	u32 len;
diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm_panic_internal.h
index fe6d514a0833..c68d64c56e15 100644
--- a/drivers/gpu/drm/drm_panic_internal.h
+++ b/drivers/gpu/drm/drm_panic_internal.h
@@ -52,18 +52,4 @@ static inline void drm_panic_lock(struct drm_device *dev, unsigned long flags) {
 static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags) {}
 #endif
 
-#if IS_ENABLED(CONFIG_DRM_PANIC_HELPER)
-/* drm_panic_helper.c */
-int __init drm_panic_helper_init(void);
-void __exit drm_panic_helper_exit(void);
-#else
-static inline int __init drm_panic_helper_init(void)
-{
-	return 0;
-}
-
-static inline void __exit drm_panic_helper_exit(void)
-{ }
-#endif
-
 #endif /* __DRM_PANIC_INTERNAL_H__ */
diff --git a/drivers/gpu/drm/drm_pixel_helper_common.c b/drivers/gpu/drm/drm_pixel_helper_common.c
index 743846e1e003..0213c59b82f0 100644
--- a/drivers/gpu/drm/drm_pixel_helper_common.c
+++ b/drivers/gpu/drm/drm_pixel_helper_common.c
@@ -2,5 +2,19 @@
 
 #include <linux/module.h>
 
+#include "drm_pixel_helper_internal.h"
+
+static int __init drm_pixel_helper_init(void)
+{
+	return drm_panic_helper_init();
+}
+module_init(drm_pixel_helper_init);
+
+static void __exit drm_pixel_helper_exit(void)
+{
+	drm_panic_helper_exit();
+}
+module_exit(drm_pixel_helper_exit);
+
 MODULE_DESCRIPTION("DRM pixel-data helpers");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/gpu/drm/drm_pixel_helper_internal.h b/drivers/gpu/drm/drm_pixel_helper_internal.h
new file mode 100644
index 000000000000..1606cbb0a460
--- /dev/null
+++ b/drivers/gpu/drm/drm_pixel_helper_internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+
+#ifndef DRM_PIXEL_HELPER_INTERNAL_H
+#define DRM_PIXEL_HELPER_INTERNAL_H
+
+#if IS_ENABLED(CONFIG_DRM_PANIC)
+/* drm_panic_helper.c */
+int __init drm_panic_helper_init(void);
+void __exit drm_panic_helper_exit(void);
+#else
+static inline int __init drm_panic_helper_init(void)
+{
+	return 0;
+}
+
+static inline void __exit drm_panic_helper_exit(void)
+{ }
+#endif
+
+#endif
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5e939004b646..1c65b14bf0f4 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -19,6 +19,7 @@ config DRM_I915
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select DRM_MIPI_DSI
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select RELAY
 	select I2C
diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index 3ca237515e46..19b51835cdd3 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -3,6 +3,7 @@ config DRM_IMX
 	tristate "DRM Support for Freescale i.MX"
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select VIDEOMODE_HELPERS
 	select DRM_GEM_DMA_HELPER
 	depends on DRM && (ARCH_MXC || COMPILE_TEST)
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3b5757aed9c8..3850b27861fa 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -10,6 +10,7 @@ config DRM_NOUVEAU
 	select DRM_DISPLAY_HDMI_HELPER
 	select DRM_DISPLAY_HELPER
 	select DRM_KMS_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select DRM_EXEC
diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
index 80bd770ae0f6..33337ff84c2e 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
@@ -9,6 +9,7 @@ config DRM_RCAR_DU
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have an R-Car chipset.
diff --git a/drivers/gpu/drm/renesas/shmobile/Kconfig b/drivers/gpu/drm/renesas/shmobile/Kconfig
index 52e160464001..dbb86f068499 100644
--- a/drivers/gpu/drm/renesas/shmobile/Kconfig
+++ b/drivers/gpu/drm/renesas/shmobile/Kconfig
@@ -9,6 +9,7 @@ config DRM_SHMOBILE
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have an SH Mobile chipset.
diff --git a/drivers/gpu/drm/tidss/Kconfig b/drivers/gpu/drm/tidss/Kconfig
index 52a64fa1ad5d..be60ec720544 100644
--- a/drivers/gpu/drm/tidss/Kconfig
+++ b/drivers/gpu/drm/tidss/Kconfig
@@ -8,6 +8,7 @@ config DRM_TIDSS
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	help
 	  The TI Keystone family SoCs introduced a new generation of
 	  Display SubSystem. There is currently three Keystone family
diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index fc884fb57b7e..6440a8f39e04 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -6,6 +6,7 @@ config DRM_VIRTIO_GPU
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_PIXEL_HELPER if DRM_PANIC
 	select VIRTIO_DMA_SHARED_BUFFER
 	help
 	   This is the virtual GPU driver for virtio.  It can be used with
-- 
2.56.0

