Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA4384250;
	Wed,  9 Sep 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944403; cv=none; b=s5fC5s9P5D/kxXzbj7/glJ7I8BkAa0zSiMnqpJslN4WhiKWjqicXkYqMdkDz2gZ8nxv4my8Ca2ohjzrZLMoseDqocMdfVMSmODsitvxFBJ4oOl1hf75GV8P3oqyt10eMNziJeWBS0qWcjsi1m117LZUPXp8jePdDDFF1HzO4TzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944403; c=relaxed/simple;
	bh=eciJ9jsr7AB7/58KShnubYuqD7EkujTJGBnTFwC9GoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS4kbBZFuLOLaoOT4KWWyykfOROgSwn5vZrwqlVcptQcoHSBCHnKY652tzbFzJp7uGct7XOv+bOl4jk+EK5lyeX81H0Tkse1Dz4YAmbOFWCoov0x1K0WT9KwuIfoxuvr9eahPHtsYFxspuyIhTRTWjPwkd5dkI6wc6F4WvLmcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W9oDqvLR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lMP3GEWW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wyHpAJeh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SF0iZZum; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W9oDqvLR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lMP3GEWW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wyHpAJeh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SF0iZZum"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E553E1F83F;
	Wed,  9 Sep 2026 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC0+KLKbJpYLNfJ5VRFGCqadwDqoWaUxvHFHXz5HZnc=;
	b=W9oDqvLR94YZVdt+BS7omr3yZFARPrM0F/4BfMmTbwtAOw9EUx7q9gqF9E3LfK4xCEMs+/
	h4SG6ChZ43p/vgp6Sh3P6pKxKaIPUZ4yf8wixBjRdiQ18f3pVXDw+2FrRfU+94JoWVU+dE
	He93ViGttc0mJF44wQBKYG5lKdwhlBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC0+KLKbJpYLNfJ5VRFGCqadwDqoWaUxvHFHXz5HZnc=;
	b=lMP3GEWWgdpO3BhN2PR4cMMVzCwwhyrssFpbrhJXzsDkK3ExXm7jipkH1bNxa2dtrRKPbw
	vTvYX2RisGELfcBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wyHpAJeh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SF0iZZum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC0+KLKbJpYLNfJ5VRFGCqadwDqoWaUxvHFHXz5HZnc=;
	b=wyHpAJehst7/fj38EwLjbLwqvboxksxoqvF31Z7mpUPD6zvhbpoEvLm8ThKnBFXtIL4avy
	IDMLG/GesSE7G7XiPANZHW0isfMce+1kNO+8F2N50eMJTr1/P93MIn2A4k0lQL2Fz4Km9M
	CFMREthR8OqCfVJA7fVMLyTxFLczfUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC0+KLKbJpYLNfJ5VRFGCqadwDqoWaUxvHFHXz5HZnc=;
	b=SF0iZZumOC4RWUCn+pDWPmRyV76F7+RbpRiZnSr4abbEGI3Z6s5gKH7yJqmkVxUYa21rAS
	C7FLBPJdwzpfV+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB7213929;
	Wed,  9 Sep 2026 08:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GI4XBrsfoWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:35 +0000
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
Subject: [PATCH v4 06/14] drm/panic: Pass global module parameters to drm_panic_dispatch()
Date: Wed,  9 Sep 2026 10:55:21 +0200
Message-ID: <20260909085826.64529-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: E553E1F83F
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
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Set the panic type and QR version in draw_panic_plane() as a single
point of truth. Pass the values into the individual drawing functions.

In the test case, always create a QR code with version 40 (i.e., the
highest supported version).

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c            | 39 ++++++++++++++++----------
 drivers/gpu/drm/tests/drm_panic_test.c |  2 +-
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 834653d288a9..f597ef04c5bc 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -654,7 +654,7 @@ static void drm_panic_qr_exit(void)
 	stream.workspace = NULL;
 }
 
-static int drm_panic_get_qr_code_url(u8 **qr_image)
+static int drm_panic_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
 {
 	struct kmsg_dump_iter iter;
 	char url[256];
@@ -666,7 +666,7 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
 			   utsname()->machine, utsname()->release);
 
-	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
+	max_qr_data_size = drm_panic_qr_max_data_size(qr_version, url_len);
 	max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE);
 
 	/* get kmsg to buffer 1 */
@@ -712,11 +712,11 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 				     qrbuf1, QR_BUFFER1_SIZE);
 }
 
-static int drm_panic_get_qr_code_raw(u8 **qr_image)
+static int drm_panic_get_qr_code_raw(u8 **qr_image, unsigned int qr_version)
 {
 	struct kmsg_dump_iter iter;
 	size_t kmsg_len;
-	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(panic_qr_version, 0),
+	size_t max_kmsg_size = min(drm_panic_qr_max_data_size(qr_version, 0),
 				   QR_BUFFER1_SIZE);
 
 	kmsg_dump_rewind(&iter);
@@ -729,19 +729,20 @@ static int drm_panic_get_qr_code_raw(u8 **qr_image)
 				     qrbuf2, QR_BUFFER2_SIZE);
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
@@ -768,7 +769,7 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
 
 	max_qr_size = min(3 * sb->width / 4, 3 * sb->height / 4);
 
-	qr_width = drm_panic_get_qr_code(&qr_image);
+	qr_width = drm_panic_get_qr_code(&qr_image, qr_version);
 	if (qr_width < 0)
 		return qr_width;
 	else if (!qr_width)
@@ -812,9 +813,11 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
 	return 0;
 }
 
-static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb, u32 fg_color, u32 bg_color)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
+				     u32 fg_color, u32 bg_color,
+				     unsigned int qr_version)
 {
-	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color))
+	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
 		return draw_panic_screen_user(sb, fg_color, bg_color);
 	return 0;
 }
@@ -887,17 +890,18 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
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
@@ -947,6 +951,11 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
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
@@ -962,7 +971,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 
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

