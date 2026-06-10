Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675C2E7F2C
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105130; cv=none; b=KH/TMeMkcAytenDOZS4EUDq+SC1IT9qLFF2NW65aeY8ihnBLIVvsi53M+p0+3GYcL4+nnDn2eJ0K5/m8HAxG6/Hb1MSOKXIc3ke4DJghIpC3l72Rrq6PaJbCec3ffuRohol7j5P5EhKK0ZLM8cXJlboU1CbTn1FWnDwRgbt/1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105130; c=relaxed/simple;
	bh=9ohuB0PNP3qgnrdT+AAZx2L2VDHZfnhjk+wL010zUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjgrxG8rgFIDF6KdBeMgGlxIRzocEfJllLymL3ZeRlyDsh8pdlEepa1LJzqlgr6Te7y3TLeLCXvYTPc8IUHlqYl+9bLEm92X4e/NOmTk6LA3AzWJ/1/1kHUQfe+/oFrPb6hn5wonUXfmMkTKEQ4m4FpRhx6qfMCw9QmB/xGk7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4F175AB3;
	Wed, 10 Jun 2026 15:25:15 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A361779A7;
	Wed, 10 Jun 2026 15:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GdzJNqBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:14 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Zack Rusin <zackr@vmware.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 04/15] drm/vmwgfx: Handle struct drm_plane_state.ignore_damage_clips
Date: Wed, 10 Jun 2026 17:18:20 +0200
Message-ID: <20260610152505.260172-5-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7B4F175AB3
X-Rspamd-Action: no action

The mode-setting pipeline can disabled damage clippings for a commit
by setting ignore_damage_clips in struct drm_plane_state. The commit
will then do a full display update.

Test the flag in the primary ldu plane's atomic_update and do a full
update if it has been set.

Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
to ignore damage clips") introduced ignore_damage_clips to selectively
ignore damage clipping in certain framebuffer changes. Vmwgfx does not
do that, but DRM's damage iterator will soon rely on the flag. Therefore
supporting it here as well make sense for consistency.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index af3e32174563..40618759c940 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -342,10 +342,15 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 			.x2 = vfb->base.width,
 			.y2 = vfb->base.height
 		};
-		struct drm_mode_rect *damage_rects = drm_plane_get_damage_clips(new_state);
-		u32 rect_count = drm_plane_get_damage_clips_count(new_state);
+		struct drm_mode_rect *damage_rects = NULL;
+		u32 rect_count = 0;
 		int ret;
 
+		if (!new_state->ignore_damage_clips) {
+			damage_rects = drm_plane_get_damage_clips(new_state);
+			rect_count = drm_plane_get_damage_clips_count(new_state);
+		}
+
 		if (!damage_rects) {
 			damage_rects = &fb_rect;
 			rect_count = 1;
-- 
2.54.0

