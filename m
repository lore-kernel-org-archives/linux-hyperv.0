Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DEB4749C0;
	Tue, 18 Aug 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057719; cv=none; b=gNOVfwi54VMzhHAQQif+LGDnpuzRoa696/+PmpoSy9t9E4YmtwPIePXP8U0UdQTJWxi8Uj4LZRb3ZAIMhGX39CBcgxP2Ep+b3hqz/E7kg0LkBy3efpi6MR3uSaKVHxYcvZUOwR9+YErhzsByxgQgcXUnfoQiywbYCDjJYCuvYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057719; c=relaxed/simple;
	bh=QL0X6pTTavKTFei5lSC5sB2J1NhdSdOGYGzTaL3tIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaVPYhpqQAmMaiz8REtuhAcJmNknC8s4bLhcTkhDLIqKDGCmzQ7JgIYz0s+FVKAkDpdobh5nJ7GgwQ13Bm47gIfUd+K26pvDnhQ+tDS10HXZqigrwfBTDpaS9ndu3tzDw8ZlTTSxIj+rCauUMlT0BodVDvhn8mc9KreRoGl9WAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z88GztwC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0A1c5aPM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bnvWNKN3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UEgg4hEl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z88GztwC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0A1c5aPM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bnvWNKN3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UEgg4hEl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82F8C3EBD;
	Tue, 18 Aug 2026 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+bcWc4T/rU3VJYnflqTO5mpTU63URyw7VznDPWHcA0=;
	b=Z88GztwCCatW/H/uskajNcA46j7QOQcPqEU8P20avJdJy2CXcGyyRYDwE5CAYFDKfLc86B
	FyQFPjmqhjtyXuwo8l3P6gK225jif20wFcvlJtyrWL3x3imHQAfFoXrwZRitDlGSN0jkvc
	UqWjML9tMqvfq6jkYsy7nmE772IVCFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+bcWc4T/rU3VJYnflqTO5mpTU63URyw7VznDPWHcA0=;
	b=0A1c5aPMTnHHEJ6rIXyy/+peCcZQ4ykHjlRriaEYQJ0Dc4YZ/NQ0K7GF/GrO0xsc7KPpwh
	g2c6xZkRgOJi57CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+bcWc4T/rU3VJYnflqTO5mpTU63URyw7VznDPWHcA0=;
	b=bnvWNKN3izrmYsYYhi2y/HstSlabK46I1lmloa4ucnshsOeH1Jv+ZIbBJwvbnG+YQXR2+3
	mZuRKWk9Wm0TmR5GPR6Br8wJ0g2VgTe+6hNVyHTCA/hAQXGTMMhDYCxY0gvy4u2Oh1nzCY
	MX/BgqaTSjQdtWjD283xUc87+W6LoaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+bcWc4T/rU3VJYnflqTO5mpTU63URyw7VznDPWHcA0=;
	b=UEgg4hEljsD5umpamNvvTFD9Rohmv/TNMp3RHFalLPZNYh0eWj0BY8P0N6FZwh5cF7RVOB
	ehRyK6Vsen6pjKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 475D6367E;
	Tue, 18 Aug 2026 12:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sG9SEA1VhGojIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 12:50:21 +0000
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
Subject: [PATCH 08/12] drm/panic: Split draw_panic_plane()
Date: Tue, 18 Aug 2026 14:28:06 +0200
Message-ID: <20260818125012.468092-9-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Move locking and parameters from draw_panic_plane() into the new
helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
there.

The new helper drm_panic_display_panic_screen() is now the DRM core's
interface for displaying a panic screen. The code remaining in
draw_panic_plane() still does all the heavy lifting. It will become a
plane helper for DRM drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 0960750bfce2..2263a11efdf6 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -940,38 +940,21 @@ static void drm_panic_clear_description(void)
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
 
@@ -986,9 +969,33 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
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
@@ -1001,10 +1008,9 @@ static void drm_panic(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detai
 	struct drm_plane *plane = to_drm_plane(dumper);
 
 	if (detail->reason == KMSG_DUMP_PANIC)
-		draw_panic_plane(plane, detail->description);
+		drm_panic_display_panic_screen(plane, detail->description);
 }
 
-
 /*
  * DEBUG FS, This is currently unsafe.
  * Create one file per plane, so it's possible to debug one plane at a time.
@@ -1021,7 +1027,7 @@ static ssize_t debugfs_trigger_write(struct file *file, const char __user *user_
 	if (kstrtobool_from_user(user_buf, count, &run) == 0 && run) {
 		struct drm_plane *plane = file->private_data;
 
-		draw_panic_plane(plane, "Test from debugfs");
+		drm_panic_display_panic_screen(plane, "Test from debugfs");
 	}
 	return count;
 }
-- 
2.55.0

