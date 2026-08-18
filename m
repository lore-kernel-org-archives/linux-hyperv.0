Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D775471CEA;
	Tue, 18 Aug 2026 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057482; cv=none; b=sA/vzJH7FFaaFGYJ0jJJCS0Fqh0iWWYeoJBtpJaKNgnqYsGIrTzlmd66+ULyhRDgCsNPunN+BGb3tuwngGcu8L5fQ1jnREWt+sGFxYX9yo3ZYdjyVJuutV15zfmM/wxROowBKGSx0GnBHF51VABX8MknvoNmKFnHdENGA2KR9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057482; c=relaxed/simple;
	bh=WIpzugkwyTCbJq8D2j3q84rB9v4xNDeV0FBP7EfpAmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+S7ARzqLryK66UNGtMdxc99/97sgSBHEEjvZj7Vco+y89DiEN+ZH6OP5kcuxUbkAHx3ytHw+JpsV9vPJV3PMm4LhTjJus7IkuL4kxD/ZN0w/o95Fa/MiM9Z5vp6QqEJnn5xgqKrXGNqA2zSISjpBufvSNYl4yt9A3GQG9YTeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEDDC8459B;
	Tue, 18 Aug 2026 12:50:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59A74362E;
	Tue, 18 Aug 2026 12:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EAVeFA9VhGojIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 12:50:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
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
Subject: [PATCH 12/12] drm/panic: Compile KUnit tests as module
Date: Tue, 18 Aug 2026 14:28:10 +0200
Message-ID: <20260818125012.468092-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818125012.468092-1-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: CEDDC8459B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)]
X-Rspamd-Action: no action

Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=y
and make them build as a module. Export the necessary interfaces from the
panic helpers iff the KUnit framework has been enabled.

Select DRM_PANIC_HELPER from DRM_KUNIT_TEST to meet the dependencies of
the panic-helper tests.

It is now possible to run the tests by modprobing drm_panic_helper_test.ko
at runtime.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig.debug                 |  1 +
 drivers/gpu/drm/drm_panic_helper.c            | 26 ++++++++++---------
 drivers/gpu/drm/tests/Makefile                |  1 +
 drivers/gpu/drm/tests/drm_panic_helper_test.c | 15 ++++++++---
 include/drm/drm_panic_helper.h                |  8 ++++++
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1f4c98cbf090..b909cd0a619f 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -69,6 +69,7 @@ config DRM_KUNIT_TEST
 	select DRM_EXPORT_FOR_TESTS if m
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KUNIT_TEST_HELPERS
+	select DRM_PANIC_HELPER
 	select DRM_SYSFB_HELPER
 	select PRIME_NUMBERS
 	default KUNIT_ALL_TESTS
diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
index 3d612f9f3a37..1e114cdab3dd 100644
--- a/drivers/gpu/drm/drm_panic_helper.c
+++ b/drivers/gpu/drm/drm_panic_helper.c
@@ -8,6 +8,8 @@
 #include <linux/utsname.h>
 #include <linux/zlib.h>
 
+#include <kunit/visibility.h>
+
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -431,8 +433,8 @@ static void drm_panic_helper_logo_draw(struct drm_scanout_buffer *sb, struct drm
 				   fg_color);
 }
 
-static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
-					     u32 fg_color, u32 bg_color)
+VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
+						       u32 fg_color, u32 bg_color)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
@@ -464,6 +466,7 @@ static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_user);
 
 /*
  * Draw one line of kmsg, and handle wrapping if it won't fit in the screen width.
@@ -502,8 +505,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
  * and going up until reaching the top of the screen.
  */
-static int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
-					     u32 fg_color, u32 bg_color)
+VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
+						       u32 fg_color, u32 bg_color)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
@@ -547,6 +550,7 @@ static int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_kmsg);
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 /*
@@ -697,9 +701,9 @@ static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int qr_version)
 /*
  * Draw the panic message at the center of the screen, with a QR Code
  */
-static int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
-						u32 fg_color, u32 bg_color,
-						unsigned int qr_version)
+VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
+							  u32 fg_color, u32 bg_color,
+							  unsigned int qr_version)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
@@ -767,6 +771,7 @@ static int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
 	drm_panic_helper_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_qr_code);
 #else
 static void __init drm_panic_helper_qr_init(void) {};
 static void __exit drm_panic_helper_qr_exit(void) {};
@@ -819,7 +824,7 @@ static int draw_panic_helper_dispatch(struct drm_scanout_buffer *sb,
 	return ret;
 }
 
-static void drm_panic_helper_set_description(const char *description)
+VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *description)
 {
 	u32 len;
 
@@ -834,6 +839,7 @@ static void drm_panic_helper_set_description(const char *description)
 		desc_line->len = len;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);
 
 static void drm_panic_helper_clear_description(void)
 {
@@ -907,7 +913,3 @@ void __exit drm_panic_helper_exit(void)
 {
 	drm_panic_helper_qr_exit();
 }
-
-#ifdef CONFIG_DRM_KUNIT_TEST
-#include "tests/drm_panic_helper_test.c"
-#endif
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index e7193b49cf91..42207df1d1c8 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_managed_test.o \
 	drm_mm_test.o \
 	drm_modes_test.o \
+	drm_panic_helper_test.o \
 	drm_plane_helper_test.o \
 	drm_probe_helper_test.o \
 	drm_rect_test.o \
diff --git a/drivers/gpu/drm/tests/drm_panic_helper_test.c b/drivers/gpu/drm/tests/drm_panic_helper_test.c
index fcff8d2dccbe..75110da226dd 100644
--- a/drivers/gpu/drm/tests/drm_panic_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_panic_helper_test.c
@@ -6,13 +6,17 @@
  * KUNIT tests for DRM panic helpers
  */
 
-#include <drm/drm_fourcc.h>
-#include <drm/drm_panic.h>
+#include <linux/highmem.h>
+#include <linux/units.h>
+#include <linux/vmalloc.h>
 
 #include <kunit/test.h>
 
-#include <linux/units.h>
-#include <linux/vmalloc.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_panic.h>
+#include <drm/drm_panic_helper.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static void drm_panic_check_color_byte(struct kunit *test, u8 b)
 {
@@ -233,3 +237,6 @@ static struct kunit_suite drm_panic_helper_suite = {
 };
 
 kunit_test_suite(drm_panic_helper_suite);
+
+MODULE_DESCRIPTION("KUnit test suite for DRM panic handling");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helper.h
index 6dc63288bc2a..76ff3a83e07b 100644
--- a/include/drm/drm_panic_helper.h
+++ b/include/drm/drm_panic_helper.h
@@ -8,6 +8,7 @@
 enum drm_panic_type;
 
 struct drm_plane;
+struct drm_scanout_buffer;
 
 /* drm_panic_helper.c */
 void drm_plane_helper_display_panic_screen(struct drm_plane *plane,
@@ -15,6 +16,13 @@ void drm_plane_helper_display_panic_screen(struct drm_plane *plane,
 					   enum drm_panic_type panic_type,
 					   u32 fg_color, u32 bg_color,
 					   unsigned int qr_version);
+#if IS_ENABLED(CONFIG_KUNIT)
+int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
+int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
+int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb, unsigned int qr_version,
+					 u32 fg_color, u32 bg_color);
+void drm_panic_helper_set_description(const char *description);
+#endif
 
 /* drm_panic_helper_qr.rs */
 size_t drm_panic_helper_qr_max_data_size(u8 version, size_t url_len);
-- 
2.55.0

