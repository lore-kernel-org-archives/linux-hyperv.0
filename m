Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0F481FD0;
	Wed,  9 Sep 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944459; cv=none; b=rYAtJqA8y4f4GUXYettMm9apP6ah8yp16wlL+y/LdLSm1GbwjF2V/P0FWxX99QO7B9W31/Y4U1BpKdMOm8kvjolSgITekzJHbJ9HULwIEhberBN9bomzXs4/UKxbVQfReB9tWeR+b2IokNLlMi9mwro+7NcmH3LOk7YTODhSbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944459; c=relaxed/simple;
	bh=kjqtIyBgKPrKCJECguzuWPZ1Z8EoO5PgIOlCf0Pfb9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egiRf8qSkoKZVm6UytqhUvDz9eRkW7Vk9zdmVhpI5WkOtuM84bSVw3px31PFZkR0hO6RUX3P6XJfgwznpwWyPxetwVy/rvCQ8D7zeTsSQWEJjW9E+Il++ogSlvhDy/GFO8LEOVHlBOxcqNXxK440QeKIxdxSPr/Vtc4Lugq6cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gs8fGZBl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zdww29BZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OZdO2mbC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rw+vt1s4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gs8fGZBl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zdww29BZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OZdO2mbC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rw+vt1s4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6316021AB7;
	Wed,  9 Sep 2026 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf0GWqv54/4OUi5PyX2eXJB496zjYw0Dj5U/uvfM6bc=;
	b=gs8fGZBlUS7FWdj+aM9NT/EwZZJlbmd1TbRk/Ziashq/36pkf1kuqKGZb9s8L7va8j22u3
	QZlQUfCFQ3qYfZ9xVCEZBAqjun8GN2zQaAJ9ro+rSFb7FQ5AnnHVc59N+m2Tvio5MF1+vA
	NVAvAfdo+hnVOiVglLA8XpELRTorkdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf0GWqv54/4OUi5PyX2eXJB496zjYw0Dj5U/uvfM6bc=;
	b=zdww29BZqO9kejvDFGknyESBoBF84m1kqEDYk2UdTEFqL9VEwB8Vwk/tQW4vGQKKp+aJJG
	e0gxhrQdnny0x7Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OZdO2mbC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Rw+vt1s4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf0GWqv54/4OUi5PyX2eXJB496zjYw0Dj5U/uvfM6bc=;
	b=OZdO2mbCOWjBNZ7oaOhkt0Yn5JwTlyzFCqD977nQJEwsiFR2isfhs7yAbuZv8uJfAoqF1w
	vrFJ50oChjtpTBXGc5UVo7S+DkS1TKwJD5mG0h9lySHlziCkXxqPOgtJviKgD55LaeWZpU
	fw3UjYCP7LrfGuInat9VRXqOU8ID8Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf0GWqv54/4OUi5PyX2eXJB496zjYw0Dj5U/uvfM6bc=;
	b=Rw+vt1s4UpdKzuDTpXBbnucvYFRbKRsF+gce9Ymj0IMf1+foWS/m2xgbgBBue4EeG297mI
	iuscFAeFMmbHtBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B74F2139CB;
	Wed,  9 Sep 2026 08:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKZWK78foWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
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
Subject: [PATCH v4 14/14] drm/panic: Compile KUnit tests as module
Date: Wed,  9 Sep 2026 10:55:29 +0200
Message-ID: <20260909085826.64529-15-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909085826.64529-1-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 6316021AB7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,drm_panic_helper_qr.rs:url,suse.de:dkim,suse.de:email,suse.de:mid];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,drm_panic_helper_qr.rs:url,suse.de:dkim,suse.de:email,suse.de:mid];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=y
and make them build as a module. Export the necessary interfaces from the
panic helpers iff the KUnit framework has been enabled.

Select DRM_PANIC_HELPER from DRM_KUNIT_TEST to meet the dependencies of
the panic-helper tests.

It is now possible to run the tests by modprobe-ing drm_panic_helper_test
at runtime.

v3:
- clean up after each test case (Sashiko)
v2:
- fix parameter order in decl of drm_panic_helper_draw_screen_qr()
  (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/Kconfig.debug                 |  1 +
 drivers/gpu/drm/drm_panic_helper.c            | 26 ++++++++++---------
 drivers/gpu/drm/tests/Makefile                |  1 +
 drivers/gpu/drm/tests/drm_panic_helper_test.c | 21 ++++++++++++---
 include/drm/drm_panic_helper.h                |  8 ++++++
 5 files changed, 41 insertions(+), 16 deletions(-)

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
index 3206e0cf1e51..19b9407ccdc5 100644
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
@@ -433,8 +435,8 @@ static void drm_panic_helper_logo_draw(struct drm_scanout_buffer *sb, struct drm
 				   fg_color);
 }
 
-static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
-					     u32 fg_color, u32 bg_color)
+VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
+						       u32 fg_color, u32 bg_color)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
@@ -466,6 +468,7 @@ static int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_user);
 
 /*
  * Draw one line of kmsg, and handle wrapping if it won't fit in the screen width.
@@ -504,8 +507,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
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
@@ -549,6 +552,7 @@ static int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_kmsg);
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 /*
@@ -691,9 +695,9 @@ static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int qr_version)
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
@@ -763,6 +767,7 @@ static int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
 	drm_panic_helper_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_draw_screen_qr_code);
 #else
 static void __init drm_panic_helper_qr_init(void) { };
 static void __exit drm_panic_helper_qr_exit(void) { };
@@ -815,7 +820,7 @@ static int draw_panic_helper_dispatch(struct drm_scanout_buffer *sb,
 	return ret;
 }
 
-static void drm_panic_helper_set_description(const char *description)
+VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *description)
 {
 	u32 len;
 
@@ -830,6 +835,7 @@ static void drm_panic_helper_set_description(const char *description)
 		desc_line->len = len;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);
 
 static void drm_panic_helper_clear_description(void)
 {
@@ -910,7 +916,3 @@ void __exit drm_panic_helper_exit(void)
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
index e6befe0f1c83..6184a6fc7eb8 100644
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
@@ -86,6 +90,11 @@ static int drm_test_panic_init(struct kunit *test)
 	return 0;
 }
 
+static void drm_test_panic_exit(struct kunit *test)
+{
+	drm_panic_helper_set_description(NULL);
+}
+
 /*
  * Test drawing the panic screen, using a memory mapped framebuffer
  * Set the whole buffer to 0xa5, and then check that all pixels have been
@@ -229,7 +238,11 @@ static struct kunit_case drm_panic_screen_user_test[] = {
 static struct kunit_suite drm_panic_helper_suite = {
 	.name = "drm_panic_helper",
 	.init = drm_test_panic_init,
+	.exit = drm_test_panic_exit,
 	.test_cases = drm_panic_screen_user_test,
 };
 
 kunit_test_suite(drm_panic_helper_suite);
+
+MODULE_DESCRIPTION("KUnit test suite for DRM panic handling");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helper.h
index 6cc9a0eba077..6b19607e0784 100644
--- a/include/drm/drm_panic_helper.h
+++ b/include/drm/drm_panic_helper.h
@@ -8,6 +8,7 @@
 enum drm_panic_type;
 
 struct drm_plane;
+struct drm_scanout_buffer;
 
 /* drm_panic_helper.c */
 int drm_plane_helper_display_panic_screen(struct drm_plane *plane,
@@ -15,6 +16,13 @@ int drm_plane_helper_display_panic_screen(struct drm_plane *plane,
 					  enum drm_panic_type panic_type,
 					  u32 fg_color, u32 bg_color,
 					  unsigned int qr_version);
+#if IS_ENABLED(CONFIG_KUNIT)
+int drm_panic_helper_draw_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
+int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color);
+int drm_panic_helper_draw_screen_qr_code(struct drm_scanout_buffer *sb,
+					 u32 fg_color, u32 bg_color, unsigned int qr_version);
+void drm_panic_helper_set_description(const char *description);
+#endif
 
 /* drm_panic_helper_qr.rs */
 size_t drm_panic_helper_qr_max_data_size(u8 version, size_t url_len);
-- 
2.55.0

