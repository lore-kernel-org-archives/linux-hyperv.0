Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E783A381C;
	Tue, 18 Aug 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057656; cv=none; b=JiQ+pPogsGrJnE9VG5v5x84kWFVCYfZg9ATUs827LWLeJuzudufpPdleWshcJ89XISmbtnuA4xE/G62BSADiSS/zv6ddWCzr7aX6oeJa57JJXV0mQF6x+snHq+Dwdi5CgrB3od4zfxDOZ35GKgTjlwZmPGfDXJ0/UBRfu0+EHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057656; c=relaxed/simple;
	bh=PSCAhho0h7/UlQXz05VDwtuQyRMoBKTXu1b62o2LBuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZAkjoSlWtPs0tS4/vc2Q+yUYyTl28Wj6WpUcpACBm2F6vIL13PBYJQCnUqporvan++KkhYAbd8phZ6P1SnvjvKttNLlWAoXrw3/GNgTsEyAnRWFj4fkoQ2Sil+M4MsyMrsjuV+Fvr3ouYulAfdOMi2Gj5y6wHwhR9eai/KYk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RO6ePgw2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GIR8Ul5b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UT0ZWdzR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tOCuz/wC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RO6ePgw2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GIR8Ul5b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UT0ZWdzR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOCuz/wC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF2C83EE5;
	Tue, 18 Aug 2026 12:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e2RIKiDQ2RkPE35X5Z/T0MyagJlj+RkSWp0wtJxJto=;
	b=RO6ePgw2wX80JaMoU8cT71NuwANBiJDv1ttb8fhYusFnclGMqpO+8tsnoaNusk/fjWViGY
	pwx1knQIp1ttJSEugcTm1+R3Zusr0GyWaUrN+bL4YBHykUl+eDNoSVGZ1LtMGZ3VEU5Ya2
	vRbIH4b3gOPLLjlyuYOAtQVmTAdC780=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e2RIKiDQ2RkPE35X5Z/T0MyagJlj+RkSWp0wtJxJto=;
	b=GIR8Ul5bnXNXEZFc9dEjDgGd5b+s3+Wsb1+OOJfkK9uPz2cPiRy9XnmxBULHzCdGicyyPg
	4oKW5y0l5uHcqRCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e2RIKiDQ2RkPE35X5Z/T0MyagJlj+RkSWp0wtJxJto=;
	b=UT0ZWdzRhkAVX2DcQmqon37sQuBFEj+Og+NHqzXj8Oz7kY7ZYRmAMQQzMB9WPQeMBEJ2ht
	R6BnTq9nUkJRSp5Lwr1tbO+YA6MIAJBGV/rou7QJ1LEbxmUdfuCntGUApPn/+1zVRS7I7r
	NHtkNpRaR6TzVSA8ABQr/CEb/JP+4EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4e2RIKiDQ2RkPE35X5Z/T0MyagJlj+RkSWp0wtJxJto=;
	b=tOCuz/wC9ooDHpIyoACKTQUn/5IMKnJbj9l/+/ODMiouwZYi2UedznY5wXZTKYX2R8hL6N
	wgIUXJ7m1MHtWeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45559367A;
	Tue, 18 Aug 2026 12:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FW8DwtVhGojIAAAD6G6ig
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
Subject: [PATCH 04/12] drm/panic: Return errno codes if panic output fails
Date: Tue, 18 Aug 2026 14:28:02 +0200
Message-ID: <20260818125012.468092-5-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Return errno codes from the panic output helpers to detect invalid
panic handling. Avoid flushing the display if an error ocured. The
unflushed display output might be helpful in debugging.

For now, test the result values in the panic test cases. A later patch
will add support for retrying failed panic output.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c            | 41 +++++++++++++++++---------
 drivers/gpu/drm/tests/drm_panic_test.c | 16 ++++++----
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 96d238bfceee..594235661710 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -478,7 +478,7 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 				   fg_color);
 }
 
-static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_user(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -489,7 +489,7 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 	unsigned int msg_width, msg_height;
 
 	if (!font)
-		return;
+		return -EINVAL;
 
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	drm_panic_logo_rect(&r_logo, font);
@@ -508,6 +508,8 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 		drm_panic_logo_draw(sb, &r_logo, font, fg_color);
 
 	draw_txt_rectangle(sb, font, panic_msg, panic_msg_lines, true, &r_msg, fg_color);
+
+	return 0;
 }
 
 /*
@@ -547,7 +549,7 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  * Draw the kmsg buffer to the screen, starting from the youngest message at the bottom,
  * and going up until reaching the top of the screen.
  */
-static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 {
 	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
 						    sb->format->format);
@@ -562,7 +564,7 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 	int yoffset;
 
 	if (!font || font->width > sb->width)
-		return;
+		return -EINVAL;
 
 	yoffset = sb->height - font->height - (sb->height % font->height) / 2;
 
@@ -589,6 +591,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
 			start--;
 		}
 	}
+
+	return 0;
 }
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
@@ -814,10 +818,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	return 0;
 }
 
-static void draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 {
 	if (_draw_panic_screen_qr_code(sb))
 		draw_panic_screen_user(sb);
+	return 0;
 }
 #else
 static void drm_panic_qr_init(void) {};
@@ -888,23 +893,25 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
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
@@ -951,9 +958,15 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
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

