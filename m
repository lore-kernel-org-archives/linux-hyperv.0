Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00247798C;
	Fri, 11 Sep 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130880; cv=none; b=YujLoOYDR4lJSUU5xe8VngssOHx+S2dmjut2hxa3t39XBEIfJgnZ6rfwDw9FWZp46pTDZ2kpVppFH34pYhq08+xTn6VlBhrcdgqMRtBLZVQ7IlRIkEFKOCJ4gH5s06fKFRhBi48fqeKHj7ImQHj+9Ne0G4ZVPyl/k7y8879jg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130880; c=relaxed/simple;
	bh=FDTiyA0OkO6gPzRwEx1f3yKoyo4NIFSiLW36A8/Cip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpWjxUHiDH8wReTE0j2G/O974EjbjyT3uQ9TTCw/rxJQiR8WDNyWDZ3UQ3HGNNoHGJ7Y0Mrc8B5Kh//qpk6qV+zO39JFLTP5lBNd50lkwoRQ13xAZGBLRInlaqtrynknAUBsqU9jDB+LqigF0TUgrLjVyvOa6GTybxjxOAmaggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rLLT+MHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HCXUvaoi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r0Se8txc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tpo9UnOa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rLLT+MHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HCXUvaoi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r0Se8txc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tpo9UnOa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4845721D47;
	Fri, 11 Sep 2026 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=rLLT+MHDTOOLzGNZKKkC04iB2JjCF+hb85N1F+6vQLTLiS7wytyenutZ1yb/yoq6hx/oFy
	1wqkjR5RX9CGxw+gc/nawySRoggV3cUtHhqierNvn0KfT6r9ZOVHMGh9j2ZQQJyRWjm/Ff
	mZ2xggmMbvEbseJmtnh4yXfeJlzOHJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=HCXUvaoitZXsStgV2D0dDtdr96rIzeeeWWH/9oTOiEUIoZXkoaCj8SZGLSbJAweuqYpsx3
	y7nDML4RlZbWrJDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=r0Se8txcomoz1NFdbI/gUovNBxMyRh9gc258G+lFQRHT1VV40xbmmu9L6wO/ToRoyIXNgR
	FNJfYOeEOsKyVpv3F7o0+9u7nGkaHrZUxyWuTzyIJe0SLoCgj+HPjs8s0UEDn0zjzYKafD
	LbmiQskibbabQFDLthMWOXzoWHLsg6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gROToXlK8SjdMBn2SBlcMsgteVlZQArVpFSxxwGrkhg=;
	b=Tpo9UnOabfghU9gXBmXTIuR1NOzDd++YS7BWyAmko+9vgbSMcVDZZv7XZaXoH5+4VvHUrj
	Q+aDCg5gwy6+bCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BBFE13865;
	Fri, 11 Sep 2026 12:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CIZEf33o2r8EQAAD6G6ig
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
Subject: [PATCH v5 07/14] drm/panic: Return from screen_user if display is too small
Date: Fri, 11 Sep 2026 14:44:00 +0200
Message-ID: <20260911124540.279841-8-tzimmermann@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhthb38qh1ntkuzcrgoc19dwi)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO

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

