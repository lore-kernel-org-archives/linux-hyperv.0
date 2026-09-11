Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BE47798C;
	Fri, 11 Sep 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130779; cv=none; b=EGnYCKRA430nR1m/8Pl9N4WpgSjhMllcB5wG2eCuou8EuTC1hpjCVhM0IbcKifhI/qwy8ikqn7nXa59ukp/mXaxK/I7VXUEHOr85TYrVkPTrZOn/0Yu0vVgRuW4UP+Zmrk6+46ENbsLBZtTYZap8YTYzXxhGJkbFTz7LXLqEso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130779; c=relaxed/simple;
	bh=wuSS9FLG3O8Y+QmvNmTpVj+LaFQgJwmH2nKVkLd4Vw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiVk0xs7gel+TwtjwIAbZe+p/YK5ibtUPwS77u+MCdhKZBAEX6LRenTL8boUFstMco42D095wuruNnnxigEPxq8G7NzNHfy0wV72EIHRhD/cI/d1V8m6RLWxtPA8FCfHLV92zy6im+MkVDhG4bE+Q2SEb5WAGEQ+bdhy8IEcsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2206F21D63;
	Fri, 11 Sep 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D481813867;
	Fri, 11 Sep 2026 12:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDCtMv33o2r8EQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 12:45:49 +0000
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
Subject: [PATCH v5 08/14] drm/panic: Retry in dispatch function if panic output fails
Date: Fri, 11 Sep 2026 14:44:01 +0200
Message-ID: <20260911124540.279841-9-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 2206F21D63
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)]

On failed output of QR codes and kmsg buffers, fall back to a user
message. QR-code output already did this internally, but now formally
support it in drm_panic_dispatch(). Streamlines the existing logic.

With the implicit fallback removed from QR-code support, the tests
cases fail for thr smallest output size (300x200). This is because the
QR code requires a minimal output size. Increase the size to 494x494,
which is the minimum supported size for QR output.

v3:
- update outdated commit description (Sashiko)
v2:
- fix minimum test size (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c            | 24 ++++++++++++------------
 drivers/gpu/drm/tests/drm_panic_test.c |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index b1cd5e5865a0..ce4606cac7e2 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -740,9 +740,9 @@ static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
 /*
  * Draw the panic message at the center of the screen, with a QR Code
  */
-static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
-				      u32 fg_color, u32 bg_color,
-				      unsigned int qr_version)
+static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
+				     u32 fg_color, u32 bg_color,
+				     unsigned int qr_version)
 {
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
@@ -812,15 +812,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
 	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
 	return 0;
 }
-
-static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
-				     u32 fg_color, u32 bg_color,
-				     unsigned int qr_version)
-{
-	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
-		return draw_panic_screen_user(sb, fg_color, bg_color);
-	return 0;
-}
 #else
 static void drm_panic_qr_init(void) {};
 static void drm_panic_qr_exit(void) {};
@@ -895,13 +886,22 @@ static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_typ
 {
 	int ret;
 
+retry:
 	switch (panic_type) {
 	case DRM_PANIC_TYPE_KMSG:
 		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
+		if (ret) {
+			panic_type = DRM_PANIC_TYPE_USER;
+			goto retry;
+		}
 		break;
 #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 	case DRM_PANIC_TYPE_QR:
 		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
+		if (ret) {
+			panic_type = DRM_PANIC_TYPE_USER;
+			goto retry;
+		}
 		break;
 #endif
 	case DRM_PANIC_TYPE_USER:
diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
index 196496238d23..55d77bc203df 100644
--- a/drivers/gpu/drm/tests/drm_panic_test.c
+++ b/drivers/gpu/drm/tests/drm_panic_test.c
@@ -32,7 +32,7 @@ struct drm_test_mode {
  */
 #define DRM_TEST_MODE_LIST(func) \
 	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_XRGB8888, func) \
-	DRM_PANIC_TEST_MODE(300, 200, DRM_FORMAT_XRGB8888, func) \
+	DRM_PANIC_TEST_MODE(494, 494, DRM_FORMAT_XRGB8888, func) \
 	DRM_PANIC_TEST_MODE(1920, 1080, DRM_FORMAT_XRGB8888, func) \
 	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB565, func) \
 	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB888, func) \
-- 
2.55.0

