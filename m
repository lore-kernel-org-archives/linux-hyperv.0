Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1143559CA;
	Tue, 18 Aug 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057686; cv=none; b=txJw+N4XcOzdX5H6QgbFlimQxWtYZnS2SfvsWQeB4P9Y6PQ/MCHwsmyEsj+i2enJTFGufGs1WKFz1vzEw+u7eK+zoeHNIJlrHjR91qu1tLvhk4NRnfP3bd8JkWvDOTmbDC5T5U5SI3u2C/OfkUgNKAj3ftXS1pvXSnJcwUPhYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057686; c=relaxed/simple;
	bh=Xfpc2Th2VobFEG5KWyOT6DeMip+suYoKcOIc0nsVeTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4uabenvjOfNFYUamg+vaojQ4hTs1H36Pe0qiT2R2wjM5otaA+pwDp0tZyeZhB3GwN9nJ81/ZwzpATNzfJwNUdao0njblsnYe5RuLQWMZAcNHfyRLgZO+y5ypgXu78KMliOsZJEFjOuWE24xUvFsGSZFg3zJpnLADjJ0+Z4izjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C+rx56II; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1VO4mOlp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a1fZCUFs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HUiYY53l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C+rx56II";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1VO4mOlp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a1fZCUFs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUiYY53l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 037A53EF5;
	Tue, 18 Aug 2026 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWxLxUqLwgHR941Mn2p+v/5kZ4Bng/gZMelFCmC4oxI=;
	b=C+rx56IITF+26I9BdoOeDF9wsNWSbfBK8aYKDwnHbwJQcoRXlR3f4A7qCSKWBYhMLrZs4X
	8THFxqRKBCVpy1S1Ax7U2h+OM+D51ePiP9ZL5vvym2MugiwHWZ9gqX2m+pUfRTCr3N1p7Z
	r0db0cYE94SNH/cXEoUwFdagmOWQZ5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWxLxUqLwgHR941Mn2p+v/5kZ4Bng/gZMelFCmC4oxI=;
	b=1VO4mOlpyoWqA0JCxx0CE7VXI0pDLopV2EY3s2VxXYkiZu6z9ofP7hlz6TGVgKn3MQ+h15
	3jrUbZy+TUVEdIAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWxLxUqLwgHR941Mn2p+v/5kZ4Bng/gZMelFCmC4oxI=;
	b=a1fZCUFsbz5+kPS5SHVx743v+ssdYqmWqNzx/Tu+YKPmXqRG59HJYEIrz+zTcSvTZdokA9
	vjByW7CkkuCJ1ic0Vk2J4G/mmXN3uzldKYCCXQWVHudndVDWGzDI4AiYj6F/K5JafqcU9i
	4knuy2cumXRfFIMsUgnF/l3vl643JhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWxLxUqLwgHR941Mn2p+v/5kZ4Bng/gZMelFCmC4oxI=;
	b=HUiYY53llf6C89tRQ3hLu+mSOge3YT2zJZ1KXCujWA4kPpBdkOip4fTJfSKUh+p6muen8s
	IM6jaI6XraSgbZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44767367C;
	Tue, 18 Aug 2026 12:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eHaJDwxVhGojIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 12:50:20 +0000
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
Subject: [PATCH 06/12] drm/panic: Pass global module parameters to drm_panic_dispatch()
Date: Tue, 18 Aug 2026 14:28:04 +0200
Message-ID: <20260818125012.468092-7-tzimmermann@suse.de>
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

Set the panic type and QR version in draw_panic_plane() as a single
point of truth. Pass the values into the individual drawing functions.

In the test case, always create a QR code with version 40 (i.e., the
highest supported version).

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c            | 39 ++++++++++++++++----------
 drivers/gpu/drm/tests/drm_panic_test.c |  2 +-
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index ede620b27515..12c39217cbcb 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -657,7 +657,7 @@ static void drm_panic_qr_exit(void)
 	stream.workspace = NULL;
 }
 
-static int drm_panic_get_qr_code_url(u8 **qr_image)
+static int drm_panic_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
 {
 	struct kmsg_dump_iter iter;
 	char url[256];
@@ -672,7 +672,7 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 		return -EINVAL;
 	url_len = ret;
 
-	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
+	max_qr_data_size = drm_panic_qr_max_data_size(qr_version, url_len);
 	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, sizeof(qrbuf1));
 
 	/* get kmsg to buffer 1 */
@@ -718,11 +718,11 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 				     qrbuf1, sizeof(qrbuf1));
 }
 
-static int drm_panic_get_qr_code_raw(u8 **qr_image)
+static int drm_panic_get_qr_code_raw(u8 **qr_image, unsigned int qr_version)
 {
 	struct kmsg_dump_iter iter;
 	size_t kmsg_len;
-	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(panic_qr_version, 0),
+	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(qr_version, 0),
 				   sizeof(qrbuf1));
 
 	kmsg_dump_rewind(&iter);
@@ -735,19 +735,20 @@ static int drm_panic_get_qr_code_raw(u8 **qr_image)
 				     qrbuf2, sizeof(qrbuf2));
 }
 
-static int drm_panic_get_qr_code(u8 **qr_image)
+static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
 {
 	if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
-		return drm_panic_get_qr_code_url(qr_image);
+		return drm_panic_get_qr_code_url(qr_image, qr_version);
 	else
-		return drm_panic_get_qr_code_raw(qr_image);
+		return drm_panic_get_qr_code_raw(qr_image, qr_version);
 }
 
 /*
  * Draw the panic message at the center of the screen, with a QR Code
  */
 static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
-				      u32 fg_color, u32 bg_color)
+				      u32 fg_color, u32 bg_color,
+				      unsigned int qr_version)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
@@ -774,7 +775,7 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
 
 	max_qr_size = min(3 * sb->width / 4, 3 * sb->height / 4);
 
-	qr_width = drm_panic_get_qr_code(&qr_image);
+	qr_width = drm_panic_get_qr_code(&qr_image, qr_version);
 	if (qr_width <= 0)
 		return -ENOSPC;
 
@@ -816,9 +817,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
 	return 0;
 }
 
-static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
+				     u32 fg_color, u32 bg_color,
+				     unsigned int qr_version)
 {
-	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
+	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
 		draw_panic_screen_user(sb, fg_color, bg_color);
 	return 0;
 }
@@ -891,17 +894,18 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 	return drm_draw_can_convert_from_xrgb8888(format->format);
 }
 
-static int draw_panic_dispatch(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
+static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_type panic_type,
+			       u32 fg_color, u32 bg_color, unsigned int qr_version)
 {
 	int ret;
 
-	switch (drm_panic_type) {
+	switch (panic_type) {
 	case DRM_PANIC_TYPE_KMSG:
 		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
 		break;
 #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 	case DRM_PANIC_TYPE_QR:
-		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color);
+		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
 		break;
 #endif
 	case DRM_PANIC_TYPE_USER:
@@ -951,6 +955,11 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 #else
 	u32 bg_color = 0x00000000;
 #endif
+#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+	unsigned int qr_version = panic_qr_version;
+#else
+	unsigned int qr_version = 0;
+#endif
 
 	if (!drm_panic_trylock(plane->dev, flags))
 		return;
@@ -966,7 +975,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
 	drm_panic_set_description(description);
 
-	ret = draw_panic_dispatch(&sb, fg_color, bg_color);
+	ret = draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_version);
 	if (!ret) {
 		/*
 		 * Only flush if we have a panic screen to display. Otherwise
diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
index 969a096ec840..196496238d23 100644
--- a/drivers/gpu/drm/tests/drm_panic_test.c
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -58,7 +58,7 @@ static int draw_panic_screen_kmsg_default(struct drm_scanout_buffer *sb)
 #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
 {
-	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
+	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
 }
 #endif
 
-- 
2.55.0

