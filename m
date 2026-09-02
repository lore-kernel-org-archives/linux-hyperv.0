Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682F2472B6;
	Wed,  2 Sep 2026 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351641; cv=none; b=MgsSvdSDPNZ8jKNfEmsswlAfdRFNVLiJpKogBdod2HY0i2EOZRl9DTfLSgzOHfqoNrpaOw9tSWpyZKxDJzfWzkuGIEQDQrvKDdDhhCf5YWw3bXIczotOJD4oAfnw6Pk04dAqZ3N8y/VfYuczoM+hDBBsLd7f5ASrgk1tZGdpMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351641; c=relaxed/simple;
	bh=e455uAZQU9TfmxbIWl6qwdLfnVL/EJz4yGoNtU+jQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdlEAFMQBuW4cB+NfSrt224F9PMQTrpAlUbLSEILigKIkUpVUcseWZsdR22Bm4OV2QtddKiWxMVlSeaLVlkeuFnUqrP/d8j2uXGXpp2m+NNRVA7r3B29I4iIqHxYHNUx8nAdW7RWI+DhiQDl1u6cmcmlhMSNrPQG55Tl8A+z6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 671581F81C;
	Wed,  2 Sep 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93710136E6;
	Wed,  2 Sep 2026 12:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBiWIl0UmGqxEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 12:19:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	geert@linux-m68k.org,
	rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	virtualization@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 12/14] drm/panic: Internalize panic locking in DRM core and helpers
Date: Wed,  2 Sep 2026 14:13:20 +0200
Message-ID: <20260902121930.597222-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902121930.597222-1-tzimmermann@suse.de>
References: <20260902121930.597222-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 671581F81C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

None of the DRM drivers handles panic locking. Declare the interfaces
in an internal header file. Move the trylock required during the panic
into the DRM core's sources.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/gpu/drm-kms.rst        |  3 ++
 MAINTAINERS                          |  3 +-
 drivers/gpu/drm/drm_atomic_helper.c  |  2 +-
 drivers/gpu/drm/drm_drv.c            |  2 +-
 drivers/gpu/drm/drm_panic.c          |  4 ++
 drivers/gpu/drm/drm_panic_internal.h | 55 +++++++++++++++++++++++
 include/drm/drm_panic.h              | 65 ----------------------------
 7 files changed, 66 insertions(+), 68 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_internal.h

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 0dd440a14946..8988fd64369b 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -421,6 +421,9 @@ Plane Panic Functions Reference
 .. kernel-doc:: include/drm/drm_panic.h
    :internal:
 
+.. kernel-doc:: drivers/gpu/drm/drm_panic_internal.h
+   :internal:
+
 .. kernel-doc:: drivers/gpu/drm/drm_panic.c
    :export:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c66c3fe93f3d..ccc5dc0a01ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9111,7 +9111,8 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/drm_draw.c
 F:	drivers/gpu/drm/drm_draw_internal.h
-F:	drivers/gpu/drm/drm_panic*.c
+F:	drivers/gpu/drm/drm_panic.c
+F:	drivers/gpu/drm/drm_panic_internal.h
 F:	drivers/gpu/drm/tests/drm_panic_test.c
 F:	include/drm/drm_panic.h
 F:	include/drm/drm_panic_helper.h
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554df..af3934df3313 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -41,7 +41,6 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
-#include <drm/drm_panic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
@@ -49,6 +48,7 @@
 
 #include "drm_crtc_helper_internal.h"
 #include "drm_crtc_internal.h"
+#include "drm_panic_internal.h"
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8c0879c336e5..64055514acbf 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -51,13 +51,13 @@
 #include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_object.h>
-#include <drm/drm_panic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_privacy_screen_machine.h>
 #include <drm/drm_ras_genl_family.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
+#include "drm_panic_internal.h"
 
 MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
 MODULE_DESCRIPTION("DRM shared core routines");
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 7b9864857577..41ba0c4b050e 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -35,6 +35,7 @@
 
 #include "drm_crtc_internal.h"
 #include "drm_draw_internal.h"
+#include "drm_panic_internal.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM panic handler");
@@ -976,6 +977,9 @@ int drm_plane_helper_display_panic_screen(struct drm_plane *plane, const char *d
 }
 EXPORT_SYMBOL(drm_plane_helper_display_panic_screen);
 
+#define drm_panic_trylock(dev, flags) \
+	raw_spin_trylock_irqsave(&(dev)->mode_config.panic_lock, flags)
+
 static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *description)
 {
 #if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm_panic_internal.h
new file mode 100644
index 000000000000..c68d64c56e15
--- /dev/null
+++ b/drivers/gpu/drm/drm_panic_internal.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+
+/*
+ * Copyright (c) 2024 Intel
+ * Copyright (c) 2024 Red Hat
+ */
+
+#ifndef __DRM_PANIC_INTERNAL_H__
+#define __DRM_PANIC_INTERNAL_H__
+
+#include <linux/spinlock.h>
+
+struct drm_device;
+
+#ifdef CONFIG_DRM_PANIC
+
+/**
+ * drm_panic_lock - protect panic printing relevant state
+ * @dev: struct drm_device
+ * @flags: unsigned long irq flags you need to pass to the unlock() counterpart
+ *
+ * This function must be called to protect software and hardware state that the
+ * panic printing code must be able to rely on. The protected sections must be
+ * as small as possible. It uses the irqsave/irqrestore variant, and can be
+ * called from irq handler. Examples include:
+ *
+ * - Access to peek/poke or other similar registers, if that is the way the
+ *   driver prints the pixels into the scanout buffer at panic time.
+ *
+ * - Updates to pointers like &drm_plane.state, allowing the panic handler to
+ *   safely deference these. This is done in drm_atomic_helper_swap_state().
+ *
+ * - An state that isn't invariant and that the driver must be able to access
+ *   during panic printing.
+ */
+#define drm_panic_lock(dev, flags) \
+	raw_spin_lock_irqsave(&(dev)->mode_config.panic_lock, flags)
+
+/**
+ * drm_panic_unlock - end of the panic printing critical section
+ * @dev: struct drm_device
+ * @flags: irq flags that were returned when acquiring the lock
+ *
+ * Unlocks the raw spinlock acquired by either drm_panic_lock() or
+ * drm_panic_trylock().
+ */
+#define drm_panic_unlock(dev, flags) \
+	raw_spin_unlock_irqrestore(&(dev)->mode_config.panic_lock, flags)
+
+#else
+static inline void drm_panic_lock(struct drm_device *dev, unsigned long flags) {}
+static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags) {}
+#endif
+
+#endif /* __DRM_PANIC_INTERNAL_H__ */
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index 430df536de14..99572b7eeab9 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -8,11 +8,9 @@
 #ifndef __DRM_PANIC_H__
 #define __DRM_PANIC_H__
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/iosys-map.h>
 
-#include <drm/drm_device.h>
 #include <drm/drm_fourcc.h>
 
 struct page;
@@ -85,71 +83,8 @@ struct drm_scanout_buffer {
 	 * set_pixel()
 	 */
 	void *private;
-
 };
 
-#ifdef CONFIG_DRM_PANIC
-
-/**
- * drm_panic_trylock - try to enter the panic printing critical section
- * @dev: struct drm_device
- * @flags: unsigned long irq flags you need to pass to the unlock() counterpart
- *
- * The panic-printing code calls this function. The panic printing attempt must
- * be aborted if the trylock fails.
- *
- * Return:
- * %0 when failing to acquire the raw spinlock, nonzero on success.
- */
-#define drm_panic_trylock(dev, flags) \
-	raw_spin_trylock_irqsave(&(dev)->mode_config.panic_lock, flags)
-
-/**
- * drm_panic_lock - protect panic printing relevant state
- * @dev: struct drm_device
- * @flags: unsigned long irq flags you need to pass to the unlock() counterpart
- *
- * This function must be called to protect software and hardware state that the
- * panic printing code must be able to rely on. The protected sections must be
- * as small as possible. It uses the irqsave/irqrestore variant, and can be
- * called from irq handler. Examples include:
- *
- * - Access to peek/poke or other similar registers, if that is the way the
- *   driver prints the pixels into the scanout buffer at panic time.
- *
- * - Updates to pointers like &drm_plane.state, allowing the panic handler to
- *   safely deference these. This is done in drm_atomic_helper_swap_state().
- *
- * - An state that isn't invariant and that the driver must be able to access
- *   during panic printing.
- */
-
-#define drm_panic_lock(dev, flags) \
-	raw_spin_lock_irqsave(&(dev)->mode_config.panic_lock, flags)
-
-/**
- * drm_panic_unlock - end of the panic printing critical section
- * @dev: struct drm_device
- * @flags: irq flags that were returned when acquiring the lock
- *
- * Unlocks the raw spinlock acquired by either drm_panic_lock() or
- * drm_panic_trylock().
- */
-#define drm_panic_unlock(dev, flags) \
-	raw_spin_unlock_irqrestore(&(dev)->mode_config.panic_lock, flags)
-
-#else
-
-static inline bool drm_panic_trylock(struct drm_device *dev, unsigned long flags)
-{
-	return true;
-}
-
-static inline void drm_panic_lock(struct drm_device *dev, unsigned long flags) {}
-static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags) {}
-
-#endif
-
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
 
-- 
2.55.0

