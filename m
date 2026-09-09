Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59F44DB6D;
	Wed,  9 Sep 2026 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944367; cv=none; b=gjH+njOZ71KYAy7FWNesa/JXiWmJtM9Cc1L8EbT+JfBQ3k/3drWxljgAmoxN4prCfmCmNqiPY3rd+T5uZ6SpPR2eI92YnivP31sGU4s9t9FTHZVJ6IHzwZOumxn7xpkT3c/YuuZ91tM1vqEXJguV32w+E8gf7iRnY+AN/nafbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944367; c=relaxed/simple;
	bh=odxnxmaAf2RV3ti0/nNL9HKMt/VzDj+O4M2J6w+83Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhP9uLCW06tR37gr1VwW3BXOf+kmUaMwQOE/EjO/ctr1LqPM8Hw4uSvKQVXphf9XB7btp9J79TrLZUPgPTf3+oER09HEOEH0tJOKkz48tGyhBckXp+HBBZ/piNXkid9+ynodb6XxP5BijhoDYjFXppbKModkq+yqy6AOQlqlsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R2RhpcHa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qZcKf8Jq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uElrFHMD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2WRZzS+a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R2RhpcHa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qZcKf8Jq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uElrFHMD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2WRZzS+a"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C2BE21A80;
	Wed,  9 Sep 2026 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnvK6SDSqRaczPeuHNPtlErQ77C4BU5i8ISwXQWL8II=;
	b=R2RhpcHa7cKwqCeJ7/9pJ8jN8xRBT74m5btiqPNfNbAKZl1qorAJgRRb1NdTvBHNH0qZs5
	ZcBSJp1SJqLoZlBFR26fgEecAMtqCJy3MgVC3c94/edtsdSh3JqmQ5gUHUJqTFvOBVOhJl
	HmdHRXjCPL/glMIQdKc0GKWnUxxeO3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnvK6SDSqRaczPeuHNPtlErQ77C4BU5i8ISwXQWL8II=;
	b=qZcKf8JqJVsokpuBU9V1rXktlkZDVQMUwvjh+B2isTBZMkkEvDvskkdzvGj5aeIMxeCRCm
	nFQnm+GZ2Ct27HBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uElrFHMD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2WRZzS+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788944314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnvK6SDSqRaczPeuHNPtlErQ77C4BU5i8ISwXQWL8II=;
	b=uElrFHMDHNsWvfWYdZKcyHq0nKSpi9oDCzQoKMGWdxYxDnzOlQvuiPzI4SvqIziUftXgqg
	Npi2YrUGwcQXuQ1li8pBuDZ+XUG9Cs85jgvYyD0PA3bzwYCVmUP0fZxiqynyEQ9/RJ777y
	5+hCgMq8ggsNeAxfX2Mql8zCSGhjK0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788944314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnvK6SDSqRaczPeuHNPtlErQ77C4BU5i8ISwXQWL8II=;
	b=2WRZzS+aI4UBmJc33euTTP+VVVhI2gdCLufV6De3M5QI1q0SB1363MU2KRUuNUK2xOLINY
	oVszKjCPVOZ0oaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663291366F;
	Wed,  9 Sep 2026 08:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CNOZF7kfoWoVUQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:58:33 +0000
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
Subject: [PATCH v4 03/14] drm/panic: Return -EINVAL if font is not available
Date: Wed,  9 Sep 2026 10:55:18 +0200
Message-ID: <20260909085826.64529-4-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 2C2BE21A80
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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

Font lookup does not allocate memory. Hence reporting ENOMEM on
failed lookups is misleading. Report EINVAL instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index d28ce8878e05..62490d32019c 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -751,8 +751,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
 	int qr_width, qr_canvas_width, qr_pitch, v_margin;
 	u8 *qr_image;
 
-	if (!font || !qrbuf1 || !qrbuf2 || !stream.workspace)
+	if (!qrbuf1 || !qrbuf2 || !stream.workspace)
 		return -ENOMEM;
+	if (!font)
+		return -EINVAL;
 
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 
-- 
2.55.0

