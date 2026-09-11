Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCF47798C;
	Fri, 11 Sep 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130797; cv=none; b=h30kk5XTdnyoqnuGEJHSkUmmtKnvCztF7tTIq6FrnLPfYjpNK2h48QBtGBkZHTBxZyCxDQQCukYvGviDGysvMo4oi53rlYQkajHuWSA3keGPnAvHWqf8NTSIsh+Sp1FtTOs2P8EBVk+zkAEDJujmuCndTrrsTnOUlDUda2BKqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130797; c=relaxed/simple;
	bh=65gGAd0DGX78A1Z+eR7KkAMXqcGOFZFCKrTRm3tNYtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2t9p3RSKUJ5grcQGkfm6BogXvLB0l14T7W6giJ0jGvdoaqhRnkl+QaxdhVufdzWrP/hheqrQhyqcWV9ZzpMs+XTipIh+uKNevCVPRuCr2un8sUnEwFTc7rUL0qedFY7aSLD1YRo9P/5V75DS7vNIzYfjVoKPGv+SDathEXF8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47F2021AC2;
	Fri, 11 Sep 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C691386E;
	Fri, 11 Sep 2026 12:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJmaGP73o2r8EQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 12:45:50 +0000
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
Subject: [PATCH v5 09/14] drm/panic: Split draw_panic_plane()
Date: Fri, 11 Sep 2026 14:44:02 +0200
Message-ID: <20260911124540.279841-10-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 47F2021AC2
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

Move locking and parameters from draw_panic_plane() into the new
helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
there.

The new helper drm_panic_display_panic_screen() is now the DRM core's
interface for displaying a panic screen. The code remaining in
draw_panic_plane() still does all the heavy lifting. It will become a
plane helper for DRM drivers.

v2:
- use panic_type argument in draw_panic_plane() (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index ce4606cac7e2..809d51ad78a8 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -936,42 +936,25 @@ static void drm_panic_clear_description(void)
 	desc_line->txt = NULL;
 }
 
-static void draw_panic_plane(struct drm_plane *plane, const char *description)
+static void draw_panic_plane(struct drm_plane *plane, const char *description,
+			     enum drm_panic_type panic_type, u32 fg_color, u32 bg_color,
+			     unsigned int qr_version)
 {
 	struct drm_scanout_buffer sb = { };
 	int ret;
-	unsigned long flags;
-#if defined(CONFIG_DRM_PANIC_FOREGROUND_COLOR)
-	u32 fg_color = CONFIG_DRM_PANIC_FOREGROUND_COLOR;
-#else
-	u32 fg_color = 0x00ffffff;
-#endif
-#if defined(CONFIG_DRM_PANIC_BACKGROUND_COLOR)
-	u32 bg_color = CONFIG_DRM_PANIC_BACKGROUND_COLOR;
-#else
-	u32 bg_color = 0x00000000;
-#endif
-#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
-	unsigned int qr_version = panic_qr_version;
-#else
-	unsigned int qr_version = 0;
-#endif
-
-	if (!drm_panic_trylock(plane->dev, flags))
-		return;
 
 	ret = plane->helper_private->get_scanout_buffer(plane, &sb);
 
 	if (ret || !drm_panic_is_format_supported(sb.format))
-		goto unlock;
+		return;
 
 	/* One of these should be set, or it can't draw pixels */
 	if (!sb.set_pixel && !sb.pages && iosys_map_is_null(&sb.map[0]))
-		goto unlock;
+		return;
 
 	drm_panic_set_description(description);
 
-	ret = draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_version);
+	ret = draw_panic_dispatch(&sb, panic_type, fg_color, bg_color, qr_version);
 	if (!ret) {
 		/*
 		 * Only flush if we have a panic screen to display. Otherwise
@@ -982,9 +965,33 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
 	}
 
 	drm_panic_clear_description();
+}
 
-unlock:
-	drm_panic_unlock(plane->dev, flags);
+static void drm_panic_display_panic_screen(struct drm_plane *plane, const char *description)
+{
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
+#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+	unsigned int qr_version = panic_qr_version;
+#else
+	unsigned int qr_version = 0;
+#endif
+	struct drm_device *dev = plane->dev;
+	unsigned long flags;
+
+	if (drm_panic_trylock(dev, flags)) {
+		draw_panic_plane(plane, description, drm_panic_type,
+				 fg_color, bg_color, qr_version);
+		drm_panic_unlock(dev, flags);
+	}
 }
 
 static struct drm_plane *to_drm_plane(struct kmsg_dumper *kd)
@@ -997,10 +1004,9 @@ static void drm_panic(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detai
 	struct drm_plane *plane = to_drm_plane(dumper);
 
 	if (detail->reason == KMSG_DUMP_PANIC)
-		draw_panic_plane(plane, detail->description);
+		drm_panic_display_panic_screen(plane, detail->description);
 }
 
-
 /*
  * DEBUG FS, This is currently unsafe.
  * Create one file per plane, so it's possible to debug one plane at a time.
@@ -1017,7 +1023,7 @@ static ssize_t debugfs_trigger_write(struct file *file, const char __user *user_
 	if (kstrtobool_from_user(user_buf, count, &run) == 0 && run) {
 		struct drm_plane *plane = file->private_data;
 
-		draw_panic_plane(plane, "Test from debugfs");
+		drm_panic_display_panic_screen(plane, "Test from debugfs");
 	}
 	return count;
 }
-- 
2.55.0

