Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EF44F540;
	Fri, 11 Sep 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130896; cv=none; b=W7L/TXfLIcWhQeQ2QIEkXYwWPSG5xOkfqdNxpNUjt/Cg3LgbG02XGFaaFITrs1nTQyS1gbCDlwXCEB1ipRMJ0V5rvNoUFzgH8CcbTj5UuVReNuUHUureynqFl5gLz+bIYzupp1YWy9fWsSJ7buk4lQ3mDsUzL43XPhRk1eCSx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130896; c=relaxed/simple;
	bh=LJHZ6KCxwsKKNuf/zX87PHgsvBnitasvTfoElzqx/lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUgVZx/8FdX8UW/yz6a6+B2Qzln82ltidOMyjycnvL5C3u52NZk52cKHmDt+CKeUadOXuoIeq//2hYf9OLBqNrdIVlhAv4/3inHWuAW5szFc4olzBMSPxs7X7ZzaIQEydg32HWXGxQYXKApz1QHPmmj58RXuo2h3gD0/exdQnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e29Oa1xF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ALyD02LC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uf7/pL2F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vCrEhHV5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e29Oa1xF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ALyD02LC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uf7/pL2F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vCrEhHV5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 512DF21D67;
	Fri, 11 Sep 2026 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=e29Oa1xFS7EvCT/Twis4W+zabXg4WlAFO5wNmeaEblSD97h5J82BBRaTmWH8htfnkcOx+B
	8G5Ar1ko3aEQTvb1G/y04Ehm8hD+EizcbzfkmPdCPUthx3YrTz0e74pPjr1qfQgmwqV5Ds
	vYyN34/VEukJSXaxTzMh6R4Z1h9T9Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=ALyD02LCN9j0MyFx1q6nKPo5caPjsAKLraWALUyuwhFfsVkxLiHzn6ZWbZfhU02cfELx0E
	C5LfCklP1QrizJAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789130752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=Uf7/pL2F3BXitbtkLejjeB65jZGFp/fNd8lJ3ixj4tJs/6FAqegHYinUcJlJ4zfLorPHrl
	bzyoFAeVHb4DA2cS2LTNJmRPN9Zor9dqlx22A1BCJRFACH2YiTVPyfMrfSR37PhXaiwtt8
	hD9Mshv9meFxhmjAgUPF7oN+pYZFHEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789130752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yw/+e2gzQxo9H+pdwIa/AXa45ESt2VPejHwf9N8gL4=;
	b=vCrEhHV5x+2HNHCTInx512gGwfmjw56Tv7GH3g02rDS/V+yl7KIpzz2sYlk13P317reNuB
	PGPaNXrfDAjz5jBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFDDF136ED;
	Fri, 11 Sep 2026 12:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGEjOf73o2r8EQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 12:45:50 +0000
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
Subject: [PATCH v5 10/14] drm/panic: Restrict to primary planes
Date: Fri, 11 Sep 2026 14:44:03 +0200
Message-ID: <20260911124540.279841-11-tzimmermann@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhthb38qh1ntkuzcrgoc19dwi)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

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

