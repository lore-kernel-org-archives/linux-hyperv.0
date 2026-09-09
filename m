Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1847208E;
	Wed,  9 Sep 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944420; cv=none; b=p/n7mkjrOl6ErxPOh7vUhovj9sF/nTvG9OxR/rNK63Hm2kqFgEQC7Zg9n3VbfUyLKcCikL8K6kq6RNWE2sutmRKog4K3Fel+yKVYKw7FjCksDPO+R3Z1MPJzxfk4/XQf9FQMM3xTm2/5hCUOmYYN5BlqXJAsri9eyTvmYVahHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944420; c=relaxed/simple;
	bh=FDTiyA0OkO6gPzRwEx1f3yKoyo4NIFSiLW36A8/Cip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDPksUpYX898tjCcNH/cHzcnrTQVhtbeOYqNWAGj/ULnxk3058mU6Jhg5YfTJ0js8N5HufMwNEcW6vRSg5qJwQD7FLEiJ0W1xM4GPhkoeoA6w2uLxAyULrCmElNGmw+im7oVglkmmv2c8LKFui7jsyC2EY1fRjVr4+1XTmY10oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z7xTRyL1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qSI2sFng; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sPZpMIfe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqWSlJ2b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z7xTRyL1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qSI2sFng";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPZpMIfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqWSlJ2b"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 632751F7D7;
	Wed,  9 Sep 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=z7xTRyL1wXVV1rvAQKLCLLva9+HnO24fblx+4pk0rQfgSM978D6npVe59sBGaRfo8iWEnN
	w8NFSVEozAb3Bj5j5sDkc9EjxSJY6J9NpJLmm9+t+qk0GO8LO6mfPjBldDIV1NOYwDS1AN
	fVjxRxxYc7lPaQthOIM0KirzHNGODoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=qSI2sFngMhRav8YrlXi90/Lyzl0ZJ1ByrFsOUcb9GlvgTv0TSL5pg97Dh9fnl1VU1HAjrw
	2KAfBdo/R2pRwwCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sPZpMIfe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WqWSlJ2b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=sPZpMIfeFaZUQQtiQZ/sEFg6HOXP6u0DKoRb4DawgCdWAmCo6EiKPW0wJ0R6iwUkx0gJC2
	7ebkQZYOq+x2gASrv490hnd4vK1KhNSp4oWTyG/SAlC95nEVUibeOwrNw6E8U4Oqdl3dcT
	aBr2VvUW78lte/WYY0PXyvVj8WpOC1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=WqWSlJ2bdTuzoV9l+0zIrR3vIXcQhiSNiN6NmPT9WHl6pS1NCHHMt6wcoaLjdjYtLNUFhz
	HB4gY6Wnldd3saCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9BD1392A;
	Wed,  9 Sep 2026 08:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMK4KLsfoWoVUQAAD6G6ig
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
Subject: [PATCH v4 07/14] drm/panic: Return from screen_user if display is too small
Date: Wed,  9 Sep 2026 10:55:22 +0200
Message-ID: <20260909085826.64529-8-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 632751F7D7
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLo585esf9b7txaosbn5shab9z)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Return an error if the display is too small to display at least a
single character. If the panic handler cannot display any message
it does at least not destroy the current output, which might help
with identifying the problem.

v4:
- also check font height against scanout buffer (Jocelyn)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index f597ef04c5bc..b1cd5e5865a0 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -486,7 +486,7 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u
 	struct drm_rect r_screen, r_logo, r_msg;
 	unsigned int msg_width, msg_height;
 
-	if (!font)
+	if (!font || font->width > sb->width || font->height > sb->height)
 		return -EINVAL;
 
 	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
@@ -560,7 +560,7 @@ static int draw_panic_screen_kmsg(struct drm_scanout_buffer *sb, u32 fg_color, u
 	struct drm_panic_line line;
 	int yoffset;
 
-	if (!font || font->width > sb->width)
+	if (!font || font->width > sb->width || font->height > sb->height)
 		return -EINVAL;
 
 	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
-- 
2.55.0

