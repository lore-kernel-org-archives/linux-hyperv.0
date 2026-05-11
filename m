Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF233815D2
	for <linux-hyperv@vger.kernel.org>; Mon, 11 May 2026 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502274; cv=none; b=kkovr15fonzQUzpP8lExt2zRaHVxetQ5sqZvbliWPmSPIrpS9eurdKhPZ/vgLJ5TH/qfDFkWh8k2tHjCiy/cZ/aipZHKGLXtGIGTfP39Z5TMTNmcaT/e37L4RfeTC2zqxE3pPSbACCJJDIg3NJCqar32m2TuYTJZdtOrVmsVLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502274; c=relaxed/simple;
	bh=J1wgyImkUCbYTBUeRD6/TbMQgT7G/nWQJnGr5i5B8fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJwti+CZ4s3NRNecTaBN8IS8RpwzRdBnyA9xV7Q13OEiChck7lz9PPOapDdw8knZIblwHED0c0+aWsIh3QYz9s5JViHxBzqkzs0Emwo8QNWwXd6LVuEoy+uOqMTlfIZBdbi8Q8Jdm9Qc57D43WevI2GBFPFBg5fK+/9HpXgSSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lw5l2Al/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rDPERZcs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lw5l2Al/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rDPERZcs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lw5l2Al/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rDPERZcs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lw5l2Al/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rDPERZcs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14ED9674DF;
	Mon, 11 May 2026 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZQFRfJuIUA5DXSJJMhmYNGtobw+HMI9pkdavuyyOmA=;
	b=Lw5l2Al/R13dLrNENXhTMT/72s9BDjTWvCRP7Ka0UzSrWSeEwYh/Aq3qH8sLiN5DOIcK2c
	93qU0L5R0OSRet3Hn/d9sLfxv1gMYSS+PfKJcanQGQ29by1cwcNbcs+1+X+ob+UvqVzyEf
	tt/PTiZHEhU+RmZzfORCK6rhwqS6TYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZQFRfJuIUA5DXSJJMhmYNGtobw+HMI9pkdavuyyOmA=;
	b=rDPERZcsNDQfdFL8CAkV0LivoSigyMYsTtyj/30+tMr+R39gDNEFd8g7K5ZTjccY3nVEd6
	f0d5twoAuj7/JEDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZQFRfJuIUA5DXSJJMhmYNGtobw+HMI9pkdavuyyOmA=;
	b=Lw5l2Al/R13dLrNENXhTMT/72s9BDjTWvCRP7Ka0UzSrWSeEwYh/Aq3qH8sLiN5DOIcK2c
	93qU0L5R0OSRet3Hn/d9sLfxv1gMYSS+PfKJcanQGQ29by1cwcNbcs+1+X+ob+UvqVzyEf
	tt/PTiZHEhU+RmZzfORCK6rhwqS6TYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZQFRfJuIUA5DXSJJMhmYNGtobw+HMI9pkdavuyyOmA=;
	b=rDPERZcsNDQfdFL8CAkV0LivoSigyMYsTtyj/30+tMr+R39gDNEFd8g7K5ZTjccY3nVEd6
	f0d5twoAuj7/JEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D6A1593A9;
	Mon, 11 May 2026 12:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qI8+JXnKAWolYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 12:24:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 03/10] drm/ingenic: Remove calls to drm_atomic_helper_check_plane_damage()
Date: Mon, 11 May 2026 14:22:27 +0200
Message-ID: <20260511122421.114014-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511122421.114014-1-tzimmermann@suse.de>
References: <20260511122421.114014-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqqu4k9zio1uathxs7idfp4sa)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

Atomic helpers call drm_atomic_helper_check_plane_damage() after the
atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
from the planes' atomic_check.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 3 ---
 drivers/gpu/drm/ingenic/ingenic-ipu.c     | 8 ++------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66..e99b44e3ac92 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -519,9 +519,6 @@ static int ingenic_drm_plane_atomic_check(struct drm_plane *plane,
 	     old_plane_state->fb->format->format != new_plane_state->fb->format->format))
 		crtc_state->mode_changed = true;
 
-	if (priv->soc_info->map_noncoherent)
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 56143a191f36..fd17c642c7ac 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -594,7 +594,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 
 	if (!new_plane_state->crtc ||
 	    !crtc_state->mode.hdisplay || !crtc_state->mode.vdisplay)
-		goto out_check_damage;
+		return 0;
 
 	/* Plane must be fully visible */
 	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0 ||
@@ -611,7 +611,7 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 
 	if (!osd_changed(new_plane_state, old_plane_state))
-		goto out_check_damage;
+		return 0;
 
 	crtc_state->mode_changed = true;
 
@@ -645,10 +645,6 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
 	ipu_state->denom_w = denom_w;
 	ipu_state->denom_h = denom_h;
 
-out_check_damage:
-	if (ingenic_drm_map_noncoherent(ipu->master))
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 	return 0;
 }
 
-- 
2.54.0

