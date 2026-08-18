Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10684756DE;
	Tue, 18 Aug 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057526; cv=none; b=ntb+dlXR7so03I6fmVp3b91FTWPTQ992jXrkDUnQ6BkeRDkn4zfF9eX69Cp4clO374OtHTAfOdkywh+Td+YrdNiWitem4VxZcAJJNoSwgw2CMjgT9zuL8eJcDw5F+D4NGgb9fHQNRxG4cpom46oYpljIjwjaOaB902byHfszDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057526; c=relaxed/simple;
	bh=kBsFA3Zv0N/Go0FzR3xjKPQKTwpo4Xi2HsUXiEhI69k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrOldme66aaXkXxnpo8PKB2o+CoGLH0HgvqqgVXbtPcZRn9S+RaZJ1NjscFmZQ1GmXa7U1pcfkOajY4hsqnkZQ+KnkbhFakP4HkaA1zUem2GiP8fkiZQCRp54wrzJ2pp7xwIzjoI1Dity4Oj1S1hGpPMhDfq0oUIzHvpGRxsrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SB8IqDt9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cGJZVIK3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=enSAMH7j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=frjoziAg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SB8IqDt9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cGJZVIK3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="enSAMH7j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="frjoziAg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 012C98458B;
	Tue, 18 Aug 2026 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEUnJVKyRqaw2oJE0p+7XPzDoUMdTd1XhCSyTm76Sls=;
	b=SB8IqDt930lx8gbu6TDdQTbWBQOd/m0orN5xNz8FCnU9Va+6xvZYDhY6z4csnEas0nNZDR
	OjH4eC05RWLWFG+gqj9fo3/p4ERYB1qusj34DsU5Z6ojaBLAHtxu1uwcj0TyKtL+sxBEZc
	MS1FOshTKl4kIUDW2V/NXv59kQBp0PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEUnJVKyRqaw2oJE0p+7XPzDoUMdTd1XhCSyTm76Sls=;
	b=cGJZVIK3mLo5oUSlaPuth8y+rlk7EvLl5mowmfdy3xZKK82uG7gtC/l8AHJ7fN+A0tG4Bd
	JRtVA0QRZhpxv6BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEUnJVKyRqaw2oJE0p+7XPzDoUMdTd1XhCSyTm76Sls=;
	b=enSAMH7jcNTe+Q2jqJSROkKDRaCTWjGQB3SwTlh+qv8WPG7gfnSEh85HTpI9B6JpWAwu9l
	mSDk0+ajXFfjrLJ70bd1pCXRrcPZGr+BA9ntgoIxHcnM/qlD1zPsHtl/nb1Tlk7QTHDWFI
	WJRbDBeHhvB54mv+nQcUba9Qyjj5Iig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEUnJVKyRqaw2oJE0p+7XPzDoUMdTd1XhCSyTm76Sls=;
	b=frjoziAgcX9tx1QDqoAV9prLlG8E/W+IdI5WShAjZlEomWGjGWEFHXi3u4e30s1wL4rzmp
	nVHW0yqY25j+GSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C063F367B;
	Tue, 18 Aug 2026 12:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DjJLQtVhGojIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 12:50:19 +0000
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
Subject: [PATCH 05/12] drm/panic: Pass colors to draw_panic_dispatch()
Date: Tue, 18 Aug 2026 14:28:03 +0200
Message-ID: <20260818125012.468092-6-tzimmermann@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Set the panic-screen colors in draw_panic_plane() as a single point
of truth. Pass the values into the individual drawing functions.

In the test cases, replace the Kconfig-defined colors with white and
black. Allows for removal of the tests' limitations and dependency on
the exact values. All tests now always verify the generated output.

Hardcoding the test colors will later also allow for building the
test case without having DRM panic handling enabled.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c            | 54 +++++++++++++++-----------
 drivers/gpu/drm/tests/drm_panic_test.c | 26 +++++++++----
 2 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 594235661710..ede620b27515 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -478,12 +478,8 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 				   fg_color);
 }
 
-static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
 {
-	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
-						    sb->format->format);
-	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
-						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
 	unsigned int msg_width, msg_height;
@@ -491,6 +487,9 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
 	if (!font)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	drm_panic_logo_rect(&r_logo, font);
 
@@ -549,12 +548,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
  * and going up until reaching the top of the screen.
  */
-static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
 {
-	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
-						    sb->format->format);
-	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
-						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
@@ -566,6 +561,9 @@ static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	if (!font || font->width > sb->width)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
 
 	/* Fill with the background color, and draw text on top */
@@ -748,12 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image)
 /*
  * Draw the panic message at the center of the screen, with a QR Code
  */
-static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
+static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
+				      u32 fg_color, u32 bg_color)
 {
-	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
-						    sb->format->format);
-	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
-						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
 	unsigned int max_qr_size, scale;
@@ -766,6 +761,9 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	if (!font)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 
 	drm_panic_logo_rect(&r_logo, font);
@@ -818,10 +816,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	return 0;
 }
 
-static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
 {
-	if (_draw_panic_screen_qr_code(sb))
-		draw_panic_screen_user(sb);
+	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
+		draw_panic_screen_user(sb, fg_color, bg_color);
 	return 0;
 }
 #else
@@ -893,22 +891,22 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 	return drm_draw_can_convert_from_xrgb8888(format->format);
 }
 
-static int draw_panic_dispatch(struct drm_scanout_buffer *sb)
+static int draw_panic_dispatch(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
 {
 	int ret;
 
 	switch (drm_panic_type) {
 	case DRM_PANIC_TYPE_KMSG:
-		ret = draw_panic_screen_kmsg(sb);
+		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
 		break;
 #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 	case DRM_PANIC_TYPE_QR:
-		ret = draw_panic_screen_qr_code(sb);
+		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color);
 		break;
 #endif
 	case DRM_PANIC_TYPE_USER:
 	default:
-		ret = draw_panic_screen_user(sb);
+		ret = draw_panic_screen_user(sb, fg_color, bg_color);
 	}
 
 	return ret;
@@ -943,6 +941,16 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 	struct drm_scanout_buffer sb = { };
 	int ret;
 	unsigned long flags;
+#if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
+	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
+#else
+	u32 fg_color = 0x00ffffff;
+#endif
+#if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
+	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
+#else
+	u32 bg_color = 0x00000000;
+#endif
 
 	if (!drm_panic_trylock(plane->dev, flags))
 		return;
@@ -958,7 +966,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
 	drm_panic_set_description(description);
 
-	ret = draw_panic_dispatch(&sb);
+	ret = draw_panic_dispatch(&sb, fg_color, bg_color);
 	if (!ret) {
 		/*
 		 * Only flush if we have a panic screen to display. Otherwise
diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
index fdd77b0cc54c..969a096ec840 100644
--- a/drivers/gpu/drm/tests/drm_panic_test.c
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -14,17 +14,10 @@
 #include <linux/units.h>
 #include <linux/vmalloc.h>
 
-/* Check the framebuffer color only if the panic colors are the default */
-#if (CONFIG_DRM_PANIC_BACKGROUND_COLOR == 0 && \
-	CONFIG_DRM_PANIC_FOREGROUND_COLOR == 0xffffff)
-
 static void drm_panic_check_color_byte(struct kunit *test, u8 b)
 {
 	KUNIT_EXPECT_TRUE(test, (b == 0 || b == 0xff));
 }
-#else
-static void drm_panic_check_color_byte(struct kunit *test, u8 b) {}
-#endif
 
 struct drm_test_mode {
 	const int width;
@@ -48,10 +41,27 @@ struct drm_test_mode {
 	.width = w, \
 	.height = h, \
 	.format = f, \
-	.draw_screen = draw_panic_screen_##name, \
+	.draw_screen = draw_panic_screen_ ## name ## _default, \
 	.fname = #name, \
 	}, \
 
+static int draw_panic_screen_user_default(struct drm_scanout_buffer *sb)
+{
+	return draw_panic_screen_user(sb, 0x00ffffff, 0x00000000);
+}
+
+static int draw_panic_screen_kmsg_default(struct drm_scanout_buffer *sb)
+{
+	return draw_panic_screen_kmsg(sb, 0x00ffffff, 0x00000000);
+}
+
+#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
+{
+	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
+}
+#endif
+
 static const struct drm_test_mode drm_test_modes_cases[] = {
 	DRM_TEST_MODE_LIST(user)
 	DRM_TEST_MODE_LIST(kmsg)
-- 
2.55.0

