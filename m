Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B86468C3D;
	Wed,  9 Sep 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944418; cv=none; b=Rn0tmSVC55u5+zMoqiaG4FKOiCN2bpIQ0f12nIgMPev78BniPhX1+B+ShAbZC1BYwxZ/6pTEx8yxSGvFHVGYBjD5dnZebh1wSd3LxbJgBio+zZRnt1A3cBqU5rI0qPoZVs3ajXH6rytdUvEOZ+1UEYhlLhP3yJrrGuWZq0jo/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944418; c=relaxed/simple;
	bh=LJHZ6KCxwsKKNuf/zX87PHgsvBnitasvTfoElzqx/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyTsf6aY+qGDz6uQ784oRp6iLf/s2CHSLEiTk+XRIohCogxlR1aq/NTY4Y1ErLoXDhY7St4//is6fmgr/+QKMo/UFoB5Q/DdalPE5/OxPR+/qAzEOaFng4UlrjTMCpAxCEdJsejE6qHYqq6InPlIcm3F5Bd8V3YhVpmbPVXowds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1dm1xO1x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AyB9DOLf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U4OeGi32; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AorCwKKY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1dm1xO1x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AyB9DOLf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U4OeGi32";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AorCwKKY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F45721A7E;
	Wed,  9 Sep 2026 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=1dm1xO1x3hLqRrsmVizHSExZ08U5t0vJ59xO7zwq3xHt3LAATOhHEKpTiL3uxciWMvCbPs
	8w8e73ZsrNlOZYbGexGKNE0XJ6vF2JSxro+4Mv7aIYB6kKF4dXPO9haQJ+7MYSBpnUd6fg
	RtLDXwUfhBCScXS5cO3Wj+3HTtn8gDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=AyB9DOLf/MsVeP4truED/BqsipN0gXwRUM8uKJpuTrrmkz5mQZmznl1nmIH1JzbnP0Nso1
	14PP0j3oCMA5z3DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U4OeGi32;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AorCwKKY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=U4OeGi32J/zKC0WnRfvdYuh7OGEVPH8zZWZh1n+7OguBQEayIbkmI4H4kQpxze9qi5rHl9
	iZm2xO0v47xQyvBGKKryLTD6hR7MwdEXAe5WSvPmM9PfnnpOkw4tP8HdChhqpRl9cdBTYw
	KXCtnJQA3+rTp4o+rMZCr12GwMqQzic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=AorCwKKY3gSBU8990Mrshvx+tOznGvCi8rGQl7B4okGlFGOFBgRPOaKyYhMk9K0qi2ufkH
	ZFdu/y6iH8gQ/TAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 670BB1396B;
	Wed,  9 Sep 2026 08:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wE3GF70foWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:37 +0000
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
Subject: [PATCH v4 10/14] drm/panic: Restrict to primary planes
Date: Wed,  9 Sep 2026 10:55:25 +0200
Message-ID: <20260909085826.64529-11-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 2F45721A7E
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Restrict panic handling to primary displays. Overlays and cursors
should not display panic output. If there are exceptions, they can
be registered by the driver itself.

v3:
- also update drm_panic_is_enabled() (Sashiko)
- still do some testing when unregistering (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 809d51ad78a8..522ea990a2e9 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -1059,9 +1059,13 @@ bool drm_panic_is_enabled(struct drm_device *dev)
 	if (!dev->mode_config.num_total_plane)
 		return false;
 
-	drm_for_each_plane(plane, dev)
-		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
-			return true;
+	drm_for_each_plane(plane, dev) {
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
+		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
+			continue;
+		return true;
+	}
 	return false;
 }
 EXPORT_SYMBOL(drm_panic_is_enabled);
@@ -1079,6 +1083,8 @@ void drm_panic_register(struct drm_device *dev)
 		return;
 
 	drm_for_each_plane(plane, dev) {
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
 			continue;
 		plane->kmsg_panic.dump = drm_panic;
@@ -1106,6 +1112,8 @@ void drm_panic_unregister(struct drm_device *dev)
 		return;
 
 	drm_for_each_plane(plane, dev) {
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
 			continue;
 		kmsg_dump_unregister(&plane->kmsg_panic);
-- 
2.55.0

