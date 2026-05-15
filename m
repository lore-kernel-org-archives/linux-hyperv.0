Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2A44D68A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846975; cv=none; b=qxyf+qfYOruNSDPGuqfx/9hVEH2s1pWTq309AIanv09n1vEbDCwAggg73NOoIFyHmz7eeo/TITCdNL3XwP/0h5KafgYnIRGYweFHpTxSA3/Xt7RRuCeSil2iV1tjCNY2AXImAdXnWoLo1c94jzauXidYluXm9V60LpZpJ2hXSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846975; c=relaxed/simple;
	bh=uJsGW54sY/kYHimF9+lX79RJmTpQR+L9nooBsYIf7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2dYuFRPFMsnH5Bkq50uiUt6nh3n0yNAqqULU7ZzCX+M1pLyX+tWVDgAaRaOemUXl3b70MLTchJpBjgRMwa4p9FRV+BqNuGIKYAGy5BS4i9J4T242xM5mLBeNKl9P0EuqTOTFoAYm+46SdDb6NQ0DhtTE6oyvzYNLcGKfrOtVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZrrxfK3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=59nq6O2c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZrrxfK3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=59nq6O2c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZrrxfK3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="59nq6O2c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZrrxfK3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="59nq6O2c"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3DB65ED11;
	Fri, 15 May 2026 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuh6TyilX4VWG6Zmg1V90Jch9YZvkfz6xDh17+YehGA=;
	b=ZrrxfK3Q1F76T2qQp+4ymFzW9yjTurZZ1eWeMb0ZSJCdW1hlB+y66wOFzdUys31PMGVgdA
	b4WHGmfc0HLK/KSVObWwHcjZG6PTT0pFdMi729f/hk6wdpmo68okaFiIzPOycXVZW2lHO5
	560SduVsmWyE9dXGKKbQEkV1JD8smXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuh6TyilX4VWG6Zmg1V90Jch9YZvkfz6xDh17+YehGA=;
	b=59nq6O2cE8xjt2PT6Xxdj9W5m+yGWBz8gIFuPLWlIrCe1BtWVaZ0/uWGZyfMLnxzSEfg7X
	LYcYLmlvsOzVU6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778846962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuh6TyilX4VWG6Zmg1V90Jch9YZvkfz6xDh17+YehGA=;
	b=ZrrxfK3Q1F76T2qQp+4ymFzW9yjTurZZ1eWeMb0ZSJCdW1hlB+y66wOFzdUys31PMGVgdA
	b4WHGmfc0HLK/KSVObWwHcjZG6PTT0pFdMi729f/hk6wdpmo68okaFiIzPOycXVZW2lHO5
	560SduVsmWyE9dXGKKbQEkV1JD8smXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778846962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuh6TyilX4VWG6Zmg1V90Jch9YZvkfz6xDh17+YehGA=;
	b=59nq6O2cE8xjt2PT6Xxdj9W5m+yGWBz8gIFuPLWlIrCe1BtWVaZ0/uWGZyfMLnxzSEfg7X
	LYcYLmlvsOzVU6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9955C593A9;
	Fri, 15 May 2026 12:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WAI7JPEMB2rQFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 12:09:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	mdaenzer@redhat.com,
	pekka.paalanen@collabora.com,
	jadahl@gmail.com,
	contact@emersion.fr,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/9] drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
Date: Fri, 15 May 2026 13:55:09 +0200
Message-ID: <20260515120916.333614-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515120916.333614-1-tzimmermann@suse.de>
References: <20260515120916.333614-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL9d8yydhbkx9sasttcqzahbbr)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80

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

