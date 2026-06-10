Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F13DBD7A
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105139; cv=none; b=VjN/cQBBU8hGO8R9fqHbqPXhb/WHh+X69srNGeAf+Nx2MBCn3L9pfSggjkwR3GI6agy8LD8r7ZVTHtxFsvsqPhpIviqVwgVdaWPFt5nHqQ16LkiLo/aHqbwFUk+yozZpkbGXLLiyvGhyTG2otvLNiEsjkDZYyetPPXklNHhJpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105139; c=relaxed/simple;
	bh=T7eudhctxMk7auPW88fSPbwN4qtuclsaD1D6JHcxO+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcTYUrs6qOmmtitzqAmEKEm5O2bu7QgFxY7XRGk7+c7H8vdXtl5vmQa0ae9cnTUtQ9uheqq5RL8/Xc4878xPGE+A64xZi/SzlbCePCnG2vKPlsJtg7AZL0psq9XV+MK1DWvxqhrBCEfAfVKvAUVtrV3Jc8sUaYoJ+w1AZwcXEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ggxih/Pl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKPXQaNj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ggxih/Pl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKPXQaNj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ggxih/Pl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKPXQaNj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ggxih/Pl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKPXQaNj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABAE6AEA5;
	Wed, 10 Jun 2026 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBzLPMAqxqn9R4waBS++H7+XppSH4AsBxWAq/Efav5w=;
	b=ggxih/PlMKDLJO/OZcW0i8EgVIm2n7wZDmIFaFQQ40R6EqboIT6eQAYyfbiuyOevRrlqqi
	8TbsFV7/QYtn3GdHLsrxCFjFYUdJilQR9WP5CxI8ldoFhQv8xcbygPrwz1QPxjV5wv0AiI
	7rDJJH/S7usdFyJ2Bo5lnl/qpGihIPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBzLPMAqxqn9R4waBS++H7+XppSH4AsBxWAq/Efav5w=;
	b=HKPXQaNjPfhvR3sI48w/CHwQTFtWHjOldSfDBEwV7tG5YRkvf2owNd0GGAbJLKYffm6fs7
	/7hQD/hhdr3xcIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBzLPMAqxqn9R4waBS++H7+XppSH4AsBxWAq/Efav5w=;
	b=ggxih/PlMKDLJO/OZcW0i8EgVIm2n7wZDmIFaFQQ40R6EqboIT6eQAYyfbiuyOevRrlqqi
	8TbsFV7/QYtn3GdHLsrxCFjFYUdJilQR9WP5CxI8ldoFhQv8xcbygPrwz1QPxjV5wv0AiI
	7rDJJH/S7usdFyJ2Bo5lnl/qpGihIPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBzLPMAqxqn9R4waBS++H7+XppSH4AsBxWAq/Efav5w=;
	b=HKPXQaNjPfhvR3sI48w/CHwQTFtWHjOldSfDBEwV7tG5YRkvf2owNd0GGAbJLKYffm6fs7
	/7hQD/hhdr3xcIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42648779A9;
	Wed, 10 Jun 2026 15:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAvGDt2BKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	jani.nikula@linux.intel.com,
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 07/15] drm/damage-helper: Do not alter damage clips on modeset, but ignore them
Date: Wed, 10 Jun 2026 17:18:23 +0200
Message-ID: <20260610152505.260172-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.936];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -6.79

User space supplies rectangles for damage clipping in a plane property.
For full mode sets, drivers still require a full plane update. In this
case, leave the information as-is and set the ignore_damage_clips flag
instead. The damage iterator will later ignore any damage information.

Leaving the damage information as-is might be helpful to drivers that
benefit from this information even on full modesets (e.g., for cache
management). It will also help with consolidating the damage-handling
logic.

Also add a new unit test that evaluates the ignore_damage_clips flag. It
sets two damage clips plus the flag and tests if the reported damage
covers the entire framebuffer.

v5:
- clear ignore_damage_clips in a separate patch (Javier)
v4:
- slightly reword the commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
 .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index 74a7f4252ecf..945fac8dc27b 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
 		if (WARN_ON(!crtc_state))
 			return;
 
-		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
-			drm_property_blob_put(plane_state->fb_damage_clips);
-			plane_state->fb_damage_clips = NULL;
-		}
+		if (drm_atomic_crtc_needs_modeset(crtc_state))
+			plane_state->ignore_damage_clips = true;
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_plane_damage);
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 0df2e1a54b0d..64f038a62ffe 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -603,6 +603,33 @@ static void drm_test_damage_iter_damage_not_visible(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
 }
 
+static void drm_test_damage_iter_damage_ignore(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	u32 num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* 2 damage clips, but ignore them. */
+	set_damage_clip(&damage[0], 20, 30, 200, 180);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	mock->state.ignore_damage_clips = true;
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip) {
+		if (num_hits == 0)
+			check_damage_clip(test, &clip, 0, 0, 1024, 768);
+		num_hits++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return full-framebuffer damage.");
+}
+
 static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_no_damage),
 	KUNIT_CASE(drm_test_damage_iter_no_damage_fractional_src),
@@ -625,6 +652,7 @@ static struct kunit_case drm_damage_helper_tests[] = {
 	KUNIT_CASE(drm_test_damage_iter_damage_one_outside),
 	KUNIT_CASE(drm_test_damage_iter_damage_src_moved),
 	KUNIT_CASE(drm_test_damage_iter_damage_not_visible),
+	KUNIT_CASE(drm_test_damage_iter_damage_ignore),
 	{ }
 };
 
-- 
2.54.0

