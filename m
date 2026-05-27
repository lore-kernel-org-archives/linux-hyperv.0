Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC332EAE
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889182; cv=none; b=daJj2zqW+WtP9DtVkTcEkrAavurMIbE4qBY6HsGjG5vck9hSeC87Pn+aVZl0FaP5VZspXJp+CqDFgdAT+BQJrJEvVlUmK7MjHVsxtF5Y8MTtn+GI/a4KloOrwhE3uL6wfVeZg2VneoS002ea2A59tijh/rVriTqoCRPkhEGe92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889182; c=relaxed/simple;
	bh=uJsGW54sY/kYHimF9+lX79RJmTpQR+L9nooBsYIf7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmDo06MOBwNc6Iw0NonLhBCN+C97cNpuA7wHTfnBdxTKuz2MBn/hka0vQ4ltKY78vjpQ3KIQG5g8Ar7kqhTo1AhBF95J2lWJghmge2hrnGzQFhNfYEBBc6h6qayRkI8dSu5IyFb2Ww7yDvRsf/6QARjX3etARwuItgzXEMdHjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86ED56BA6A;
	Wed, 27 May 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257FE5A861;
	Wed, 27 May 2026 13:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2H3KBw30FmrpMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:39:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	mdaenzer@redhat.com,
	pekka.paalanen@collabora.com,
	jadahl@gmail.com,
	contact@emersion.fr,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	mhklinux@outlook.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	wayland-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/9] drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
Date: Wed, 27 May 2026 15:32:45 +0200
Message-ID: <20260527133917.207150-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
References: <20260527133917.207150-1-tzimmermann@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 86ED56BA6A
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action

Mark the vblank event on bochs as simulated, so that the WAIT_VBLANK
ioctl fails with an error. The ioctl should not be supported because
the output is not synchronized to a display refresh.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index e2d957e51505..b5955ef39e31 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -677,7 +677,7 @@ static int bochs_kms_init(struct bochs_device *bochs)
 	drm_connector_attach_edid_property(connector);
 	drm_connector_attach_encoder(connector, encoder);
 
-	ret = drm_vblank_init(dev, 1);
+	ret = drmm_vblank_init(dev, 1, DRM_VBLANK_FLAG_SIMULATED);
 	if (ret)
 		return ret;
 
-- 
2.54.0

