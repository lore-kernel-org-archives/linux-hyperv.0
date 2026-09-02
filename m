Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03238E13F;
	Wed,  2 Sep 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351756; cv=none; b=OrA/1OLGO/PdMyV3/jsKWi5aL5ah0ukojxjHmKeW7EIpaOhCYJs8xhSyRIyI2TGw6mXsjs7lRYL9/aUSKekw8TuKf/oRMNhFW16cpEuOfVg2uHlr9fJTcpmyvbdPcxZS7mGb6uvlXgZCYopMPltUOCM8Nsa7q5NgOmK3QQZLZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351756; c=relaxed/simple;
	bh=1bRFZZxDTgQ8rmLckOSI/5e5OrsyHy4fViWhDbHNB1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHUKySlV6TmZYzkUIU8c7IR99AecLTKep/Za0YOg2EsAu0V7acDXJlgQF/ee4sVJZfPUVFV2Cnss3n4t6o5tI8I2I/gZ1hgPbddGnSqgLWjZrZHac/b4sxT8lhcwF0QxO1CWDqzh8J6q602CDPKzd45Vg0IOkmdPXT9d5elx97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KQn/sSzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dEDeIlY7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=isXWmnvk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=27Y+s6c5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KQn/sSzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dEDeIlY7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="isXWmnvk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="27Y+s6c5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 656D11F7EA;
	Wed,  2 Sep 2026 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788351587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0wlDba8nVbwo/hXPNsTwJ6BQAEcN+OJcu82Sjb+nqc=;
	b=KQn/sSzu9spR8h0lkvRJhQJHJJap5xwSHMcvST88ZSb+qDyeCjNTWWxpd2lXSU5ue8KbAz
	fCGe4e1LnynafVYGWCmPNq5dps993I5knVQn9zMNvIoqLYwyCmqujwLoI4qAg4j2uE3IeZ
	F8xWU60uoBdBmqyekoNJK1QccHYf/DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788351587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0wlDba8nVbwo/hXPNsTwJ6BQAEcN+OJcu82Sjb+nqc=;
	b=dEDeIlY7+Tj6Pf7fYwJLa6dDUljZrcY1Q0MbajU1lh/vDmpzTnskBx9C99KHcuZMKWxF2Y
	XVqUoF4AZ7Aqd8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788351583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0wlDba8nVbwo/hXPNsTwJ6BQAEcN+OJcu82Sjb+nqc=;
	b=isXWmnvkfoTCRC0ZlzImJXpIodA8u3Hwb69LYvZpo33ytYVzm72nR7FNfZ0/rOYwAJt+24
	vnSN6c+wjRYgXA6dgL97VoKjldmb6zsUlC13A98CmRpDSkSmdzQYP1njvH+Kf6TsAJjWYh
	YGM1AdOpUbEP4vBUB7n+INzi0YMzf2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788351583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0wlDba8nVbwo/hXPNsTwJ6BQAEcN+OJcu82Sjb+nqc=;
	b=27Y+s6c5s08Dj1P0jDBW/sKJtru4haGMvoq7xpwSc+z9M4hRzIP+WTtne2HikLwAmFpuRF
	k3/RVJngz/GoOoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE4FC13874;
	Wed,  2 Sep 2026 12:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2D/SOFwUmGqxEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 12:19:40 +0000
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
Subject: [PATCH v3 11/14] drm/panic: Display panic screen via per-plane callback
Date: Wed,  2 Sep 2026 14:13:19 +0200
Message-ID: <20260902121930.597222-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902121930.597222-1-tzimmermann@suse.de>
References: <20260902121930.597222-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Add display_panic_screen to struct drm_plane_funcs. If set on a plane,
register a panic handler for the plane from the DRM core's panic
handling. Invoke this helper from the core to display a panic screen.

The new callback replaces get_scanout_buffer as signal for panic
support in a plane. Using get_scanout_buffer is now merely a detail
of the implementation. This will also free struct drm_scanout_buffer
for use cases besides panic handling.

With display_panic_screen in place, rename draw_panic_plane() to
drm_plane_helper_display_panic_screen() and make it available to DRM
drivers via drm_panic_helper.h. Do not change the implementation or
functionality of this code. drm_plane_helper_display_panic_screen()
still supports kernel messages, user messages and QR codes on various
color formats.

Then update all drivers that implement panic support. Provide the
initializer macro DRM_PANIC_PLANE_FUNCS that sets display_panic_screen
to drm_plane_helper_display_panic_screen(). If panic handling has
been disabled, it instead clears the callback. There's again no change
in functionality.

This logically splits panic handling into a set of entry points in the
DRM code and a set of helper functions provided by drivers. The core
invokes the driver's helper via callback, while the driver can tailor
the implementation to its needs. Panic handling now works like most
other interfaces in the DRM framework.

Locking and state-handling happens in the DRM core or helpers. Drivers
that receive a call to display_panic_screen can assume that no concurrent
modeset takes place on the plane or its CRTC.

Also update the documentation. Move information about locking and state
guarantees from drm_panic_trylock() to display_panic_screen, where
drivers authors can find it easily. Move information about the features
of the current implementation to drm_panic_helper_display_panic_screen().

v2:
- only consider planes with get_scanout_buffer (Sashiko)
- set callback for planes create with drm_crtc_init() (Sashiko)
- return errno code from display_panic_screen

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 MAINTAINERS                                   |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  2 +
 drivers/gpu/drm/ast/ast_mode.c                |  2 +
 drivers/gpu/drm/drm_modeset_helper.c          |  2 +
 drivers/gpu/drm/drm_panic.c                   | 91 ++++++++++---------
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  2 +
 drivers/gpu/drm/i915/display/i9xx_plane.c     |  3 +
 .../drm/i915/display/skl_universal_plane.c    |  4 +
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c       |  2 +
 drivers/gpu/drm/mgag200/mgag200_drv.h         |  4 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c       |  2 +
 .../gpu/drm/renesas/rcar-du/rcar_du_plane.c   |  2 +
 .../drm/renesas/shmobile/shmob_drm_plane.c    |  2 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      |  4 +-
 drivers/gpu/drm/sysfb/vesadrm.c               |  1 +
 drivers/gpu/drm/tidss/tidss_plane.c           |  2 +
 drivers/gpu/drm/tiny/bochs.c                  |  4 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  2 +
 include/drm/drm_mode_config.h                 |  4 +-
 include/drm/drm_modeset_helper_vtables.h      | 11 ++-
 include/drm/drm_panic.h                       | 49 ++--------
 include/drm/drm_panic_helper.h                | 27 ++++++
 include/drm/drm_plane.h                       | 57 ++++++++++++
 23 files changed, 192 insertions(+), 90 deletions(-)
 create mode 100644 include/drm/drm_panic_helper.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bedbb8557a1d..c66c3fe93f3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9113,7 +9113,8 @@ F:	drivers/gpu/drm/drm_draw.c
 F:	drivers/gpu/drm/drm_draw_internal.h
 F:	drivers/gpu/drm/drm_panic*.c
 F:	drivers/gpu/drm/tests/drm_panic_test.c
-F:	include/drm/drm_panic*
+F:	include/drm/drm_panic.h
+F:	include/drm/drm_panic_helper.h
 
 DRM PANIC QR CODE
 M:	Jocelyn Falempe <jfalempe@redhat.com>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 824ef3ce5de0..eadc22a255bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -28,6 +28,7 @@
 #include <drm/drm_blend.h>
 #include "drm/drm_framebuffer.h"
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
@@ -2177,6 +2178,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.atomic_set_property = dm_atomic_plane_set_property,
 	.atomic_get_property = dm_atomic_plane_get_property,
 #endif
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d5ed8c5c7925..ceebf9421100 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -43,6 +43,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -652,6 +653,7 @@ static const struct drm_plane_funcs ast_primary_plane_funcs = {
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
 	DRM_GEM_SHADOW_PLANE_FUNCS,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static int ast_primary_plane_init(struct ast_device *ast)
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index e54584da4c3d..cca623eb23e5 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -27,6 +27,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -113,6 +114,7 @@ static const uint32_t safe_modeset_formats[] = {
 
 static const struct drm_plane_funcs primary_plane_funcs = {
 	DRM_PLANE_NON_ATOMIC_FUNCS,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 /**
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 381f8aab3661..7b9864857577 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -28,6 +28,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_rect.h>
@@ -42,32 +43,18 @@ MODULE_LICENSE("GPL");
 /**
  * DOC: overview
  *
- * To enable DRM panic for a driver, the primary plane must implement a
- * &drm_plane_helper_funcs.get_scanout_buffer helper function. It is then
- * automatically registered to the drm panic handler.
- * When a panic occurs, the &drm_plane_helper_funcs.get_scanout_buffer will be
- * called, and the driver can provide a framebuffer so the panic handler can
- * draw the panic screen on it. Currently only linear buffer and a few color
- * formats are supported.
- * Optionally the driver can also provide a &drm_plane_helper_funcs.panic_flush
- * callback, that will be called after that, to send additional commands to the
- * hardware to make the scanout buffer visible.
- */
-
-/*
- * This module displays a user friendly message on screen when a kernel panic
- * occurs. This is conflicting with fbcon, so you can only enable it when fbcon
- * is disabled.
- * It's intended for end-user, so have minimal technical/debug information.
+ * This module displays a user friendly message on screen when a kernel
+ * panic occurs. This is conflicting with fbcon, so you can only enable
+ * it when fbcon is disabled. It's intended for end users and therefore
+ * have minimal technical/debug information.
  *
- * Implementation details:
+ * To enable DRM panic for a driver, the at least one primary plane must
+ * implement struct &drm_plane_funcs.display_panic_screen. The plane is
+ * then automatically registered to the drm panic handler.
  *
- * It is a panic handler, so it can't take lock, allocate memory, run tasks/irq,
- * or attempt to sleep. It's a best effort, and it may not be able to display
- * the message in all situations (like if the panic occurs in the middle of a
- * modesetting).
- * It will display only one static frame, so performance optimizations are low
- * priority as the machine is already in an unusable state.
+ * When a panic occurs, the DRM panic handler calls struct
+ * &drm_plane_funcs.display_panic_screen. See
+ * drm_plane_helper_display_panic_screen() for a generic implementation.
  */
 
 struct drm_panic_line {
@@ -817,12 +804,6 @@ static void drm_panic_qr_init(void) {};
 static void drm_panic_qr_exit(void) {};
 #endif
 
-enum drm_panic_type {
-	DRM_PANIC_TYPE_KMSG,
-	DRM_PANIC_TYPE_USER,
-	DRM_PANIC_TYPE_QR,
-};
-
 static enum drm_panic_type drm_panic_type = -1;
 
 static const char *drm_panic_type_map[] = {
@@ -936,21 +917,46 @@ static void drm_panic_clear_description(void)
 	desc_line->txt = NULL;
 }
 
-static void draw_panic_plane(struct drm_plane *plane, const char *description,
-			     enum drm_panic_type panic_type, u32 fg_color, u32 bg_color,
-			     unsigned int qr_version)
+/**
+ * drm_plane_helper_display_panic_screen - Displays a panic screen according to the given settings
+ * @plane: the DRM plane to display to
+ * @description: error message to display
+ * @panic_type: type of panic screen
+ * @fg_color: text foreground color
+ * @bg_color: text background color
+ * @qr_version: version of the QR code, if any
+ *
+ * This helper display a panic screen on common primary planes. The panic
+ * screen can either display a kernel message, a user message or a QR code.
+ *
+ * The helper uses struct drm_plane_helper_funcs.get_scanout_buffer, where
+ * the plane can provide a scanout buffer that the panic handler can draw to.
+ * Currently only linear buffer and a few color formats are supported.
+ *
+ * Optionally the plane can also provide a &drm_plane_helper_funcs.panic_flush
+ * callback, which the DRM panic handler calls after drawing to send additional
+ * commands to the hardware to make the scanout buffer visible.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise
+ */
+int drm_plane_helper_display_panic_screen(struct drm_plane *plane, const char *description,
+					  enum drm_panic_type panic_type,
+					  u32 fg_color, u32 bg_color, unsigned int qr_version)
 {
 	struct drm_scanout_buffer sb = { };
 	int ret;
 
 	ret = plane->helper_private->get_scanout_buffer(plane, &sb);
+	if (ret)
+		return ret;
 
-	if (ret || !drm_panic_is_format_supported(sb.format))
-		return;
+	if (!drm_panic_is_format_supported(sb.format))
+		return -EINVAL;
 
 	/* One of these should be set, or it can't draw pixels */
 	if (!sb.set_pixel && !sb.pages && iosys_map_is_null(&sb.map[0]))
-		return;
+		return -EINVAL;
 
 	drm_panic_set_description(description);
 
@@ -965,7 +971,10 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description,
 	}
 
 	drm_panic_clear_description();
+
+	return ret;
 }
+EXPORT_SYMBOL(drm_plane_helper_display_panic_screen);
 
 static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *description)
 {
@@ -988,8 +997,8 @@ static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *
 	unsigned long flags;
 
 	if (drm_panic_trylock(dev, flags)) {
-		draw_panic_plane(plane, description, drm_panic_type,
-				 fg_color, bg_color, qr_version);
+		plane->funcs->display_panic_screen(plane, description, drm_panic_type,
+						   fg_color, bg_color, qr_version);
 		drm_panic_unlock(dev, flags);
 	}
 }
@@ -1062,7 +1071,7 @@ bool drm_panic_is_enabled(struct drm_device *dev)
 	drm_for_each_plane(plane, dev) {
 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
 			continue;
-		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
+		if (!plane->funcs || !plane->funcs->display_panic_screen)
 			continue;
 		return true;
 	}
@@ -1085,7 +1094,7 @@ void drm_panic_register(struct drm_device *dev)
 	drm_for_each_plane(plane, dev) {
 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
 			continue;
-		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
+		if (!plane->funcs || !plane->funcs->display_panic_screen)
 			continue;
 		plane->kmsg_panic.dump = drm_panic;
 		plane->kmsg_panic.max_reason = KMSG_DUMP_PANIC;
@@ -1114,7 +1123,7 @@ void drm_panic_unregister(struct drm_device *dev)
 	drm_for_each_plane(plane, dev) {
 		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
 			continue;
-		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
+		if (!plane->funcs || !plane->funcs->display_panic_screen)
 			continue;
 		kmsg_dump_unregister(&plane->kmsg_panic);
 	}
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 1855749c1e41..3bf228ef97ff 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -18,6 +18,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
@@ -237,6 +238,7 @@ static const struct drm_plane_funcs hv_drm_plane_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
 	DRM_GEM_SHADOW_PLANE_FUNCS,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const struct drm_encoder_funcs hv_drm_simple_encoder_funcs_cleanup = {
diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index df6da1c6a359..0902b17d0269 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 
 #include "i9xx_plane.h"
@@ -887,6 +888,7 @@ static const struct drm_plane_funcs i965_plane_funcs = {
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = i965_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const struct drm_plane_funcs i8xx_plane_funcs = {
@@ -897,6 +899,7 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = i8xx_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static void i9xx_disable_tiling(struct intel_plane *plane)
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 5cda1ab90e40..8c0f414badf3 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -7,6 +7,7 @@
 #include <drm/drm_blend.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 #include <drm/intel/step.h>
 
@@ -2712,6 +2713,7 @@ static const struct drm_plane_funcs skl_plane_funcs = {
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = skl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const struct drm_plane_funcs icl_plane_funcs = {
@@ -2722,6 +2724,7 @@ static const struct drm_plane_funcs icl_plane_funcs = {
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = icl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const struct drm_plane_funcs tgl_plane_funcs = {
@@ -2732,6 +2735,7 @@ static const struct drm_plane_funcs tgl_plane_funcs = {
 	.atomic_destroy_state = intel_plane_destroy_state,
 	.format_mod_supported = tgl_plane_format_mod_supported,
 	.format_mod_supported_async = intel_plane_format_mod_supported_async,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static void
diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..377db7cea726 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -14,6 +14,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 
 #include <video/imx-ipu-v3.h>
@@ -362,6 +363,7 @@ static const struct drm_plane_funcs ipu_plane_funcs = {
 	.atomic_duplicate_state	= ipu_plane_duplicate_state,
 	.atomic_destroy_state	= ipu_plane_destroy_state,
 	.format_mod_supported = ipu_plane_format_mod_supported,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static int ipu_plane_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index 3732c62351bb..d3995ce876f4 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane.h>
 
 #include "mgag200_reg.h"
@@ -386,7 +387,8 @@ int mgag200_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
 	.update_plane = drm_atomic_helper_update_plane, \
 	.disable_plane = drm_atomic_helper_disable_plane, \
 	.destroy = drm_plane_cleanup, \
-	DRM_GEM_SHADOW_PLANE_FUNCS
+	DRM_GEM_SHADOW_PLANE_FUNCS, \
+	DRM_PANIC_PLANE_FUNCS
 
 void mgag200_crtc_fill_gamma(struct mga_device *mdev, const struct drm_format_info *format);
 void mgag200_crtc_load_gamma(struct mga_device *mdev,
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 15a322422f4e..fc29a291e96f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -39,6 +39,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/ttm/ttm_bo.h>
 
 #include "nouveau_bo.h"
@@ -841,6 +842,7 @@ nv50_wndw = {
 	.atomic_duplicate_state = nv50_wndw_atomic_duplicate_state,
 	.atomic_destroy_state = nv50_wndw_atomic_destroy_state,
 	.format_mod_supported = nv50_plane_format_mod_supported,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const u64 nv50_cursor_format_modifiers[] = {
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
index 8870766b9e54..f4b0e5b70c7d 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
@@ -16,6 +16,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_panic_helper.h>
 
 #include "rcar_du_drv.h"
 #include "rcar_du_group.h"
@@ -773,6 +774,7 @@ static const struct drm_plane_funcs rcar_du_plane_funcs = {
 	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
 	.atomic_set_property = rcar_du_plane_atomic_set_property,
 	.atomic_get_property = rcar_du_plane_atomic_get_property,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const uint32_t formats[] = {
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 148de34af785..907f85462fa0 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -14,6 +14,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_panic_helper.h>
 
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
@@ -286,6 +287,7 @@ static const struct drm_plane_funcs shmob_drm_plane_funcs = {
 	.reset = shmob_drm_plane_reset,
 	.atomic_duplicate_state = shmob_drm_plane_atomic_duplicate_state,
 	.atomic_destroy_state = shmob_drm_plane_atomic_destroy_state,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static const uint32_t formats[] = {
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 1c31267daa00..520f60daf6ef 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -12,6 +12,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_panic_helper.h>
 
 struct drm_format_info;
 struct drm_scanout_buffer;
@@ -144,7 +145,8 @@ void drm_sysfb_plane_atomic_destroy_state(struct drm_plane *plane,
 	.disable_plane = drm_atomic_helper_disable_plane, \
 	.atomic_create_state = drm_sysfb_plane_atomic_create_state, \
 	.atomic_duplicate_state = drm_sysfb_plane_atomic_duplicate_state, \
-	.atomic_destroy_state = drm_sysfb_plane_atomic_destroy_state
+	.atomic_destroy_state = drm_sysfb_plane_atomic_destroy_state, \
+	DRM_PANIC_PLANE_FUNCS
 
 /*
  * CRTC
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 6a67b2d2e451..14d2e6ab88aa 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -24,6 +24,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 6d82976c2db1..b0d5d6959b88 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -12,6 +12,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_dispc.h"
@@ -182,6 +183,7 @@ static const struct drm_plane_funcs tidss_plane_funcs = {
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index e2d957e51505..076d19b26511 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -20,6 +20,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_module.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -501,7 +502,8 @@ static const struct drm_plane_funcs bochs_primary_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
-	DRM_GEM_SHADOW_PLANE_FUNCS
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static void bochs_crtc_helper_mode_set_nofb(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a..108b5b93f130 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -30,6 +30,7 @@
 #include <linux/virtio_dma_buf.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
 #include <drm/drm_print.h>
 
 #include "virtgpu_drv.h"
@@ -94,6 +95,7 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	DRM_PANIC_PLANE_FUNCS,
 };
 
 static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index d8f5b7e9673e..084517beb924 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -495,8 +495,8 @@ struct drm_mode_config {
 	 *
 	 * Raw spinlock used to protect critical sections of code that access
 	 * the display hardware or modeset software state, which the panic
-	 * printing code must be protected against. See drm_panic_trylock(),
-	 * drm_panic_lock() and drm_panic_unlock().
+	 * printing code must be protected against. See the documentation on
+	 * DRM panic handling for more information.
 	 */
 	struct raw_spinlock panic_lock;
 
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index ca6268945c28..614bdee0c1ed 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1442,17 +1442,20 @@ struct drm_plane_helper_funcs {
 	/**
 	 * @get_scanout_buffer:
 	 *
-	 * Get the current scanout buffer, to display a message with drm_panic.
+	 * Get the current scanout buffer to display a message with drm_panic.
 	 * The driver should do the minimum changes to provide a buffer,
 	 * that can be used to display the panic screen. Currently only linear
 	 * buffers are supported. Non-linear buffer support is on the TODO list.
 	 * The device &dev.mode_config.panic_lock is taken before calling this
 	 * function, so you can safely access the &plane.state
 	 * It is called from a panic callback, and must follow its restrictions.
-	 * Please look the documentation at drm_panic_trylock() for an in-depth
+	 * Please look the documentation on DRM panic handling for an in-depth
 	 * discussions of what's safe and what is not allowed.
+	 *
 	 * It's a best effort mode, so it's expected that in some complex cases
-	 * the panic screen won't be displayed.
+	 * the panic screen won't be displayed. Drivers must not make any
+	 * assumptions about the actual state of the hardware.
+	 *
 	 * The returned &drm_scanout_buffer.map must be valid if no error code is
 	 * returned.
 	 *
@@ -1472,7 +1475,7 @@ struct drm_plane_helper_funcs {
 	 * It is only called if get_scanout_buffer() returned successfully, and
 	 * the &dev.mode_config.panic_lock is held during the entire sequence.
 	 * It is called from a panic callback, and must follow its restrictions.
-	 * Please look the documentation at drm_panic_trylock() for an in-depth
+	 * Please look the documentation on DRM panic handling for an in-depth
 	 * discussions of what's safe and what is not allowed.
 	 */
 	void (*panic_flush)(struct drm_plane *plane);
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index ac0e46b73436..430df536de14 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -15,6 +15,14 @@
 #include <drm/drm_device.h>
 #include <drm/drm_fourcc.h>
 
+struct page;
+
+enum drm_panic_type {
+	DRM_PANIC_TYPE_KMSG,
+	DRM_PANIC_TYPE_USER,
+	DRM_PANIC_TYPE_QR,
+};
+
 /**
  * struct drm_scanout_buffer - DRM scanout buffer
  *
@@ -87,45 +95,8 @@ struct drm_scanout_buffer {
  * @dev: struct drm_device
  * @flags: unsigned long irq flags you need to pass to the unlock() counterpart
  *
- * This function must be called by any panic printing code. The panic printing
- * attempt must be aborted if the trylock fails.
- *
- * Panic printing code can make the following assumptions while holding the
- * panic lock:
- *
- * - Anything protected by drm_panic_lock() and drm_panic_unlock() pairs is safe
- *   to access.
- *
- * - Furthermore the panic printing code only registers in drm_dev_unregister()
- *   and gets removed in drm_dev_unregister(). This allows the panic code to
- *   safely access any state which is invariant in between these two function
- *   calls, like the list of planes &drm_mode_config.plane_list or most of the
- *   struct drm_plane structure.
- *
- * Specifically thanks to the protection around plane updates in
- * drm_atomic_helper_swap_state() the following additional guarantees hold:
- *
- * - It is safe to deference the drm_plane.state pointer.
- *
- * - Anything in struct drm_plane_state or the driver's subclass thereof which
- *   stays invariant after the atomic check code has finished is safe to access.
- *   Specifically this includes the reference counted pointers to framebuffer
- *   and buffer objects.
- *
- * - Anything set up by &drm_plane_helper_funcs.fb_prepare and cleaned up
- *   &drm_plane_helper_funcs.fb_cleanup is safe to access, as long as it stays
- *   invariant between these two calls. This also means that for drivers using
- *   dynamic buffer management the framebuffer is pinned, and therefer all
- *   relevant datastructures can be accessed without taking any further locks
- *   (which would be impossible in panic context anyway).
- *
- * - Importantly, software and hardware state set up by
- *   &drm_plane_helper_funcs.begin_fb_access and
- *   &drm_plane_helper_funcs.end_fb_access is not safe to access.
- *
- * Drivers must not make any assumptions about the actual state of the hardware,
- * unless they explicitly protected these hardware access with drm_panic_lock()
- * and drm_panic_unlock().
+ * The panic-printing code calls this function. The panic printing attempt must
+ * be aborted if the trylock fails.
  *
  * Return:
  * %0 when failing to acquire the raw spinlock, nonzero on success.
diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helper.h
new file mode 100644
index 000000000000..0b6ad8f61821
--- /dev/null
+++ b/include/drm/drm_panic_helper.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+
+#ifndef __DRM_DRM_PANIC_HELPER_H_
+#define __DRM_DRM_PANIC_HELPER_H_
+
+#include <linux/types.h>
+
+enum drm_panic_type;
+
+struct drm_plane;
+
+/* drm_panic_helper.c */
+int drm_plane_helper_display_panic_screen(struct drm_plane *plane,
+					  const char *description,
+					  enum drm_panic_type panic_type,
+					  u32 fg_color, u32 bg_color,
+					  unsigned int qr_version);
+
+#if IS_ENABLED(CONFIG_DRM_PANIC)
+#define DRM_PANIC_PLANE_FUNCS \
+	.display_panic_screen = drm_plane_helper_display_panic_screen
+#else
+#define DRM_PANIC_PLANE_FUNCS \
+	.display_panic_screen = NULL
+#endif
+
+#endif
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 2c5a5a70a71b..7fee602d94e9 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -32,6 +32,8 @@
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_util.h>
 
+enum drm_panic_type;
+
 struct drm_crtc;
 struct drm_plane_size_hint;
 struct drm_printer;
@@ -590,6 +592,61 @@ struct drm_plane_funcs {
 	bool (*format_mod_supported_async)(struct drm_plane *plane,
 					   u32 format, u64 modifier);
 
+	/**
+	 * @display_panic_screen:
+	 *
+	 * DRM panic handling invokes this callback on panics.
+	 *
+	 * It is a panic handler, so it can't take locks, allocate memory, run tasks/irq,
+	 * or attempt to sleep. It's a best effort, and it may not be able to display
+	 * the message in all situations (like if the panic occurs in the middle of a
+	 * modesetting).
+	 *
+	 * Panic-printing code must acquire the panic lock before interacting with the
+	 * scanout buffer. Such helpers can make the following assumptions while holding
+	 * the panic lock:
+	 *
+	 * - Anything protected by drm_panic_lock() and drm_panic_unlock() pairs is safe
+	 *   to access.
+	 *
+	 * - Furthermore the panic printing code only registers in drm_dev_unregister()
+	 *   and gets removed in drm_dev_unregister(). This allows the panic code to
+	 *   safely access any state which is invariant in between these two function
+	 *   calls, like the list of planes &drm_mode_config.plane_list or most of the
+	 *   struct drm_plane structure.
+	 *
+	 * Specifically thanks to the protection around plane updates in
+	 * drm_atomic_helper_swap_state() the following additional guarantees hold:
+	 *
+	 * - It is safe to deference the drm_plane.state pointer.
+	 *
+	 * - Anything in struct drm_plane_state or the driver's subclass thereof which
+	 *   stays invariant after the atomic check code has finished is safe to access.
+	 *   Specifically this includes the reference counted pointers to framebuffer
+	 *   and buffer objects.
+	 *
+	 * - Anything set up by &drm_plane_helper_funcs.fb_prepare and cleaned up
+	 *   &drm_plane_helper_funcs.fb_cleanup is safe to access, as long as it stays
+	 *   invariant between these two calls. This also means that for drivers using
+	 *   dynamic buffer management the framebuffer is pinned, and therefer all
+	 *   relevant datastructures can be accessed without taking any further locks
+	 *   (which would be impossible in panic context anyway).
+	 *
+	 * - Importantly, software and hardware state set up by
+	 *   &drm_plane_helper_funcs.begin_fb_access and
+	 *   &drm_plane_helper_funcs.end_fb_access is not safe to access.
+	 *
+	 * It will display only one static frame, so performance optimizations are
+	 * low priority as the machine is already in an unusable state.
+	 *
+	 * This callback is optional. Planes without will not be considered
+	 * for panic output.
+	 */
+	int (*display_panic_screen)(struct drm_plane *plane,
+				    const char *description,
+				    enum drm_panic_type panic_type,
+				    u32 fg_color, u32 bg_color,
+				    unsigned int qr_version);
 };
 
 /**
-- 
2.55.0

