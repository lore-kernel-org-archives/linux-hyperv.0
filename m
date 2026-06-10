Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BF3BA23A
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105166; cv=none; b=m9JspZh5CDa8n3aNf5/4pEc4gXTBMc/QPDdxXmFwUv/6DhabObDCX3+CkZzF5zFE9ovyo1NJt1/Yhtx5A9yfSFW0q6utXgTethr7nKMAnMmMEMntAy2VaM7zpzW2CZkZ5OgzjKI3C6aMjxuKY8JBsjHpIRpQj6FVbClRLyCIHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105166; c=relaxed/simple;
	bh=evlWPmtJQtVllJ6bis+HzSuiyvsMulYNENN/xnWMkic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gewtfM9fgbXZ1+mcovPBNqiAnSBV2YCwD9OMZLJOqwp7XXNN0t2d5ZtkncrYzyE5z67k2VjyWqJh9oZHtSUeiLL1dgWOTbJeECJsJGUK4NrXKCe11q31rLnhcTpyQmILnAH1k2/trSiT/m5B0MCHcsg1CubO896mMmtgpBzojfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYp6+WJy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GP1oyov; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYp6+WJy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4GP1oyov; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYp6+WJy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GP1oyov";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYp6+WJy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4GP1oyov"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C007E6AEAA;
	Wed, 10 Jun 2026 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wqbu4ZgPs4aAlFGqJpV9YYxgBXMoLFrRD+YYCZyPUw=;
	b=nYp6+WJykibBlVTA5ZEoEYA4ZGAXIvDpc659KK8Kxq7CIvxnQ5Y1gR+Il2H0hbyz331CtI
	wzfsE9i/G1XeSwEqj+7/T8aGfqQKVtow7cu1LcPT5Lmgt1u2DUnx+PVCDyUFuyUG4zWT1p
	qQgwTCedmjj01uxO09X6FCORQyBLQT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wqbu4ZgPs4aAlFGqJpV9YYxgBXMoLFrRD+YYCZyPUw=;
	b=4GP1oyovPaE9ZmLzVFvbVA52U9AApzetJ2t4oy7xDA7JCEMTYJBqx+x2J3UNuFCtZDHWMG
	5n3lDHkR+05GDpCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wqbu4ZgPs4aAlFGqJpV9YYxgBXMoLFrRD+YYCZyPUw=;
	b=nYp6+WJykibBlVTA5ZEoEYA4ZGAXIvDpc659KK8Kxq7CIvxnQ5Y1gR+Il2H0hbyz331CtI
	wzfsE9i/G1XeSwEqj+7/T8aGfqQKVtow7cu1LcPT5Lmgt1u2DUnx+PVCDyUFuyUG4zWT1p
	qQgwTCedmjj01uxO09X6FCORQyBLQT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wqbu4ZgPs4aAlFGqJpV9YYxgBXMoLFrRD+YYCZyPUw=;
	b=4GP1oyovPaE9ZmLzVFvbVA52U9AApzetJ2t4oy7xDA7JCEMTYJBqx+x2J3UNuFCtZDHWMG
	5n3lDHkR+05GDpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5ED779A7;
	Wed, 10 Jun 2026 15:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MM/ON+BKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:19 +0000
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
Subject: [PATCH v5 10/15] drm/atomic_helper: Do not evaluate plane damage before atomic_check
Date: Wed, 10 Jun 2026 17:18:26 +0200
Message-ID: <20260610152505.260172-11-tzimmermann@suse.de>
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
X-Spam-Score: -6.79
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.932];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
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

Remove the call to drm_atomic_helper_check_plane_damage() from before
calling the atomic_check helpers. The call has no longer any purpose,
as the actual evaluation happens after running atomic_check.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 8e080a42aec4..d9cb9b3f8490 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1040,8 +1040,6 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 
 		drm_atomic_helper_plane_changed(state, old_plane_state, new_plane_state, plane);
 
-		drm_atomic_helper_check_plane_damage(state, new_plane_state);
-
 		if (!funcs || !funcs->atomic_check)
 			continue;
 
-- 
2.54.0

