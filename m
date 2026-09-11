Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F27369219;
	Fri, 11 Sep 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130863; cv=none; b=s7y3kgVlScBDqGw+ufL9CzrVpOz+6rmD3mhQGPTAZGKmoVYQz+r+JMDePA8kUlmJ32I3oxLQRcpBGOl9Pia0j7FeGL18ZGK9xgcnPtfuaJAtmpkHBPfCgkjv2D+OsL4Lb76B2HXDkM9pITsOj4IAxOaHIELziFNNkSxpKAvwfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130863; c=relaxed/simple;
	bh=9mDv8d4kOQXZqrqV+5WIRckqNEm1T20poSYM2QytedI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRYWk9zTp1zh8EdBiLchLciqFCno6PmizoMFuHDh1zmWwtAvc6dS5vPwwrcvqpxFLZebD3Mi31ntc8IQcpmr8gab1i6kdAUlSXhHgmL/4ha9gVwM+hp5ScRoABK0sTauxCGWCJlLRI3OB2Q+pDt7P5SZvzZsB0USRucxFkFPdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zTvPwQ0q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hNCVBgBo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FQKwaZZ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xQUchLEH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zTvPwQ0q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hNCVBgBo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FQKwaZZ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xQUchLEH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19E1121C13;
	Fri, 11 Sep 2026 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzg0pk9+7zA32pgHFdJrFnZp49of5cCIK8J846hIh9E=;
	b=zTvPwQ0qkivys+XDI17TLCI/qydPRMsOeyD+Mb27M30+l0lASAV7DLi1HAv48JLNSlIkgM
	vDjjvH79oP+EbgtU31mPMD1n/i+hStYKQI05whSADwIyjfHufe2f7zgxspkV7tAleZE0aP
	127Fh0J6++LsS28+rSVTnFF9/YL8Ch0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzg0pk9+7zA32pgHFdJrFnZp49of5cCIK8J846hIh9E=;
	b=hNCVBgBod98Il4/jOhp1XBOdborrxNRaOMi8WqoFGmogfk/8JJMaulhWGHfHoaB0EK/JJP
	gFCm5bmYOJPnilCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzg0pk9+7zA32pgHFdJrFnZp49of5cCIK8J846hIh9E=;
	b=FQKwaZZ+Zvw13jecxW98kaZDSS2ARV8N3fXSRoybaVfb+24UkLRyJ9evMIP5ukhnTZ3uwG
	XvKxSStbTfJez1IkEcpMEnnmpVyciZ10cwM8AtHI7ejmz0McpalW7A50+osa6Cg1D4ybbe
	4vcpYwYGtkFNMDLV4iY/8Nx0yD3UcHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzg0pk9+7zA32pgHFdJrFnZp49of5cCIK8J846hIh9E=;
	b=xQUchLEH2/BVsd9/kEwlRqlO5R91SeyFXt9RNQQeljJHNnfGXNlCWGKqDVitcvGEi5F0F1
	Jq5FWGFXUDz2vVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3318F137EC;
	Fri, 11 Sep 2026 12:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJocC/z3o2r8EQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 12:45:48 +0000
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
Subject: [PATCH v5 05/14] drm/panic: Pass colors to draw_panic_dispatch()
Date: Fri, 11 Sep 2026 14:43:58 +0200
Message-ID: <20260911124540.279841-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911124540.279841-1-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhthb38qh1ntkuzcrgoc19dwi)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO

Set the panic-screen colors in draw_panic_plane() as a single point
of truth. Pass the values into the individual drawing functions.

In the test cases, replace the Kconfig-defined colors with white and
black. Allows for removal of the tests' limitations and dependency on
the exact values. All tests now always verify the generated output.

Hardcoding the test colors will later also allow for building the
test case without having DRM panic handling enabled.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c            | 54 +++++++++++++++-----------
 drivers/gpu/drm/tests/drm_panic_test.c | 26 +++++++++----
 2 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index cc33a2b4bb52..834653d288a9 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -480,12 +480,8 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
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
@@ -493,6 +489,9 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
 	if (!font)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	drm_panic_logo_rect(&r_logo, font);
 
@@ -551,12 +550,8 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
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
@@ -568,6 +563,9 @@ static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	if (!font || font->width > sb->width)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
 
 	/* Fill with the background color, and draw text on top */
@@ -742,12 +740,9 @@ static int drm_panic_get_qr_code(u8 **qr_image)
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
@@ -760,6 +755,9 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	if (!font)
 		return -EINVAL;
 
+	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
+	bg_color = drm_draw_color_from_xrgb8888(bg_color, sb->format->format);
+
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 
 	drm_panic_logo_rect(&r_logo, font);
@@ -814,10 +812,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	return 0;
 }
 
-static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
 {
-	if (_draw_panic_screen_qr_code(sb))
-		return draw_panic_screen_user(sb);
+	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
+		return draw_panic_screen_user(sb, fg_color, bg_color);
 	return 0;
 }
 #else
@@ -889,22 +887,22 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
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
@@ -939,6 +937,16 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
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
@@ -954,7 +962,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
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

