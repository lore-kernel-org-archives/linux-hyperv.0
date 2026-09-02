Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CF47DD4B;
	Wed,  2 Sep 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351722; cv=none; b=TVgcihcc/e5Fp9qaqt9qWmmHelwW8y2tMQmOk6uPx9KOCPJfgq4FLJARpBnVmlwOJQW7qILEPatCItXgFig8vwMtzaS1OrZ3rhWBan6MNyxBj+oDMeqnkILGzK4dgAVrwYQwFf9s2vXmU5aDMc0dMsQMlF5J7XrTBc253WaQ4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351722; c=relaxed/simple;
	bh=O0NObaiGSigSj+3+w9x3ENvJqI/hG4Ehs8onM+j5M4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBOQMlwC+LmtiOouLphPuXs/GS9yJ2ObVtzp0FSOYtQDYr2YYp9hqU+U51bLbSPTIPo9kU1mCFvUQTrpcO8tmZ+o00dvGvqkSWGIJC7tcVLCn+Kb+cUSgD+gqFMipgvfQA+0VIcH3l3MdjhG6r4WzQAM/thKTaooEuu3tKtZy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fABEGolP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OIOc54dT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J7PVk+xz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOXEliYU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fABEGolP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OIOc54dT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J7PVk+xz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOXEliYU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17EE31F7E5;
	Wed,  2 Sep 2026 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788351585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqU7LNDaUhamqIrDBuv/DRsU+Sh6qgbYihMr+nbt4z4=;
	b=fABEGolPQiUX7Y5iMQQRCAaGAdl3UgK0fYLZXSUBGuKzMPOIdiOeVxCAEKTbgv9TtLRGOu
	xBS9KbbnC/WoKRSQIz0pZuEkPSUeO+ZqKF3HQcycn4gQm+Or3N+Tg4A+PnbS1W2ngvpVp5
	wFPRr2Q1VbCHjKe1xwnzMnKgiAnB5o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788351585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqU7LNDaUhamqIrDBuv/DRsU+Sh6qgbYihMr+nbt4z4=;
	b=OIOc54dTlvUVaZPITACUrfGJANbPMVKDRPdyaB4FTwfQsoEKH+EcuwPZ3mzXfIbr6gABqC
	9Is4fJ61jWdT+aBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788351581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqU7LNDaUhamqIrDBuv/DRsU+Sh6qgbYihMr+nbt4z4=;
	b=J7PVk+xz7/hzHxEtxCDAW2H6sG0Uzd/E1+U0blsnB8h2CpDIUDr6CTY9vhsqmeVfejePfo
	VRHJPoGVZgBxv0ncL/yKHMGE3S+RitSO+GKLDejMpprXmr4VtwV0WrCvHd8wcAila16vwJ
	LZCRbk+O1Rx2WUOd13I9z0j9vEmHq1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788351581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqU7LNDaUhamqIrDBuv/DRsU+Sh6qgbYihMr+nbt4z4=;
	b=xOXEliYUjh+QaAOfFBZxoHLYHrG/HLy0V024NTviQimFr7dajcUjjKInZvg8mXx6wpd3f8
	XFw3biwloT7q9fCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 752701393C;
	Wed,  2 Sep 2026 12:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAAtG1oUmGqxEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 12:19:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
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
Subject: [PATCH v3 07/14] drm/panic: Return from screen_user if display is too small
Date: Wed,  2 Sep 2026 14:13:15 +0200
Message-ID: <20260902121930.597222-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902121930.597222-1-tzimmermann@suse.de>
References: <20260902121930.597222-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
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
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Return an error if the display is too small to display at least a
single character. If the panic handler cannot display any message
it does at least not destroy the current output, which might help
with identifying the problem.

This change duplicates the logic from screen_kmsg output.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index f597ef04c5bc..c317afc76669 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -486,7 +486,7 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u
 	struct drm_rect r_screen, r_logo, r_msg;
 	unsigned int msg_width, msg_height;
 
-	if (!font)
+	if (!font || font->width > sb->width)
 		return -EINVAL;
 
 	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);
-- 
2.55.0

