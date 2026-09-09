Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BD34CFDE;
	Wed,  9 Sep 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944385; cv=none; b=Dp/vhzMZGWc5q8cR4twUwM/AXliUeD+9BL038hWhVlSggdMp0+NSjrxPCHlNNimXEuE/kUlKhiQgvqRVU4KSLhpgjSTF/btCDHiQjV5XAez5zVZMdJTgt10khhgiBlD86uUItv/nJvN6qfSFEq3sKr+zGK8V3BIuhY5khl+BoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944385; c=relaxed/simple;
	bh=NAlEuAjAAvqC1pgj124dsNfJ2Vahdu9c7oKTi27QScA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze1KE5yMHoqEAdehpa7lRAJRc02EEj6io0Vf2p67iF8MiTpmlqsOvccUUDtd5tFGspUEO6HC6kl0gfiBOg/Qzr87cN9tVjgoBgZT24Uv9PZ0zhLxfvjtjZFmvaJf0Bw6gHWPtwpBxxLkHCmYTEJIanpr27eDrsEm78GgC35J5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yo1MILwz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cih09gPH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hdovw7gs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HkwA2IPC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yo1MILwz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cih09gPH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hdovw7gs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HkwA2IPC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2CC91F8A4;
	Wed,  9 Sep 2026 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHcnWQis0a9YdEbj0QwnLdNo84Wg9sGXZxx3L0bx0Ig=;
	b=Yo1MILwzsTCOXOeiTPcJ7Blw+vOIB1Ob8oMvy269o1CeWV5NXymsJqo74qj+2yXnFhQibm
	6JF7R+tHq9Zn2OzxMFMa5V6R1NNHjRJJtCHwzqxHKQSU6A5c3WM1g6QASeGSUNtLIscuD1
	tooSn7FjLzBGesgiwF+WRKTmnUmcmmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHcnWQis0a9YdEbj0QwnLdNo84Wg9sGXZxx3L0bx0Ig=;
	b=cih09gPHO+NwkPAekH5aAMDYTbn7Q+dOyJmOFRRVR4dsldMl2zS/nTY+W7SP7Cy2jGwvJe
	Kp9Pt45tYFmifYAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHcnWQis0a9YdEbj0QwnLdNo84Wg9sGXZxx3L0bx0Ig=;
	b=Hdovw7gs2jc4ym09YynajVkoBajgHXgVoIU5MP326C4vrNqziXac9/At/JQYefhaIx3tLK
	uagJuCDQMWToSTm2Vv/k8KR/GTIlhHEDJRpfY09gGK+yP2mUJOVZkuV/WwPeABc4WqgtuM
	L8Ctj54NRtjtimwLYpTLGgRfYwPYCy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHcnWQis0a9YdEbj0QwnLdNo84Wg9sGXZxx3L0bx0Ig=;
	b=HkwA2IPCXwe00bgqJ1vXYB+KEzREolE3iPkca17ym5jrjFsjmlilhIvjcO1nEbQQqA514K
	ec7Q4xefHegDiTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECB471388B;
	Wed,  9 Sep 2026 08:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uKCgOLkfoWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:33 +0000
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
Subject: [PATCH v4 04/14] drm/panic: Return errno codes if panic output fails
Date: Wed,  9 Sep 2026 10:55:19 +0200
Message-ID: <20260909085826.64529-5-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhthb38qh1ntkuzcrgoc19dwi)];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Return errno codes from the panic output helpers to detect invalid
panic handling. Avoid flushing the display if an error ocured. The
unflushed display output might be helpful in debugging.

For now, test the result values in the panic test cases. A later patch
will add support for retrying failed panic output.

v2:
- forward return value of draw_panic_screen_user() (Sashiko)
- forward errno code from drm_panic_get_qr_code

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c            | 47 +++++++++++++++++---------
 drivers/gpu/drm/tests/drm_panic_test.c | 16 +++++----
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 62490d32019c..cc33a2b4bb52 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -480,7 +480,7 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 				   fg_color);
 }
 
-static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -491,7 +491,7 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 	unsigned int msg_width, msg_height;
 
 	if (!font)
-		return;
+		return -EINVAL;
 
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	drm_panic_logo_rect(&r_logo, font);
@@ -510,6 +510,8 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
 
 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
+
+	return 0;
 }
 
 /*
@@ -549,7 +551,7 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
  * and going up until reaching the top of the screen.
  */
-static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -564,7 +566,7 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	int yoffset;
 
 	if (!font || font->width > sb->width)
-		return;
+		return -EINVAL;
 
 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
 
@@ -591,6 +593,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 			start--;
 		}
 	}
+
+	return 0;
 }
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
@@ -767,7 +771,9 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	max_qr_size = min(3 * sb->width / 4, 3 * sb->height / 4);
 
 	qr_width = drm_panic_get_qr_code(&qr_image);
-	if (qr_width <= 0)
+	if (qr_width < 0)
+		return qr_width;
+	else if (!qr_width)
 		return -ENOSPC;
 
 	qr_canvas_width = qr_width + QR_MARGIN * 2;
@@ -808,10 +814,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	return 0;
 }
 
-static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 {
 	if (_draw_panic_screen_qr_code(sb))
-		draw_panic_screen_user(sb);
+		return draw_panic_screen_user(sb);
+	return 0;
 }
 #else
 static void drm_panic_qr_init(void) {};
@@ -882,23 +889,25 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 	return drm_draw_can_convert_from_xrgb8888(format->format);
 }
 
-static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
+static int draw_panic_dispatch(struct drm_scanout_buffer *sb)
 {
+	int ret;
+
 	switch (drm_panic_type) {
 	case DRM_PANIC_TYPE_KMSG:
-		draw_panic_screen_kmsg(sb);
+		ret = draw_panic_screen_kmsg(sb);
 		break;
-
 #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 	case DRM_PANIC_TYPE_QR:
-		draw_panic_screen_qr_code(sb);
+		ret = draw_panic_screen_qr_code(sb);
 		break;
 #endif
-
 	case DRM_PANIC_TYPE_USER:
 	default:
-		draw_panic_screen_user(sb);
+		ret = draw_panic_screen_user(sb);
 	}
+
+	return ret;
 }
 
 static void drm_panic_set_description(const char *description)
@@ -945,9 +954,15 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
 	drm_panic_set_description(description);
 
-	draw_panic_dispatch(&sb);
-	if (plane->helper_private->panic_flush)
-		plane->helper_private->panic_flush(plane);
+	ret = draw_panic_dispatch(&sb);
+	if (!ret) {
+		/*
+		 * Only flush if we have a panic screen to display. Otherwise
+		 * it's probably better to leave the display output as-is.
+		 */
+		if (plane->helper_private->panic_flush)
+			plane->helper_private->panic_flush(plane);
+	}
 
 	drm_panic_clear_description();
 
diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
index ad2f3a2f93b6..fdd77b0cc54c 100644
--- a/drivers/gpu/drm/tests/drm_panic_test.c
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -30,7 +30,7 @@ struct drm_test_mode {
 	const int width;
 	const int height;
 	const u32 format;
-	void (*draw_screen)(struct drm_scanout_buffer *sb);
+	int (*draw_screen)(struct drm_scanout_buffer *sb);
 	const char *fname;
 };
 
@@ -87,7 +87,7 @@ static void drm_test_panic_screen_user_map(struct kunit *test)
 	const struct drm_test_mode *params = test->param_value;
 	char *fb;
 	int fb_size;
-	int i;
+	int i, ret;
 
 	sb->format = drm_format_info(params->format);
 	fb_size = params->width * params->height * sb->format->cpp[0];
@@ -102,7 +102,8 @@ static void drm_test_panic_screen_user_map(struct kunit *test)
 	sb->height = params->height;
 	sb->pitch[0] = params->width * sb->format->cpp[0];
 
-	params->draw_screen(sb);
+	ret = params->draw_screen(sb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	for (i = 0; i < fb_size; i++)
 		drm_panic_check_color_byte(test, fb[i]);
@@ -119,7 +120,7 @@ static void drm_test_panic_screen_user_page(struct kunit *test)
 {
 	struct drm_scanout_buffer *sb = test->priv;
 	const struct drm_test_mode *params = test->param_value;
-	int fb_size, p, i, npages;
+	int fb_size, p, i, npages, ret;
 	struct page **pages;
 	u8 *vaddr;
 
@@ -146,7 +147,8 @@ static void drm_test_panic_screen_user_page(struct kunit *test)
 	sb->height = params->height;
 	sb->pitch[0] = params->width * sb->format->cpp[0];
 
-	params->draw_screen(sb);
+	ret = params->draw_screen(sb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	for (p = 0; p < npages; p++) {
 		int bytes_in_page = (p == npages - 1) ? fb_size - p * PAGE_SIZE : PAGE_SIZE;
@@ -182,6 +184,7 @@ static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
 {
 	struct drm_scanout_buffer *sb = test->priv;
 	const struct drm_test_mode *params = test->param_value;
+	int ret;
 
 	sb->format = drm_format_info(params->format);
 	sb->set_pixel = drm_test_panic_set_pixel;
@@ -189,7 +192,8 @@ static void drm_test_panic_screen_user_set_pixel(struct kunit *test)
 	sb->height = params->height;
 	sb->private = test;
 
-	params->draw_screen(sb);
+	ret = params->draw_screen(sb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 }
 
 static void drm_test_panic_desc(const struct drm_test_mode *t, char *desc)
-- 
2.55.0

