Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB94749C6;
	Tue, 18 Aug 2026 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057496; cv=none; b=flErQmRsAGSRcL0dQOJMuJwYhGtwD0ZjqxVEvcG/HR0oXOt66zMJ7gzjAk9cL5hG2tzPv7+ghcuqn9YtHbc1o3egLZ8aTqJomqz3lN4iqX2zlO6wD8z/NT7Pq/XnyOkDuvFH2bpdHaPKaLZrJA+HToX/Gl+auMzr/1iZ7ukOoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057496; c=relaxed/simple;
	bh=8rc4N+wpZT4JJxTJWL3C7Ne2SfxMiAcjfI3xkHxA378=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hStz7kNm4RIFesId3SooHaZuHKDjpNbA2PyfMEhLt+LAKBZ40TfuW2qXmeRYLya1ppsVTIca7VabVPS3PVnfzUWNauaN77jyjQ3ruZVIBMFWB9LpsjvQnbakt+vxx2FV0HVezgbEaqZZcISkD/LQTwtvnQcGpkzhu8KuXpoXjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XYup1uGb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7fEnJZy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XYup1uGb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7fEnJZy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDB8E3E75;
	Tue, 18 Aug 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787057418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lurynGJFfEOjpSoiEvFLb2rSec2t0K5pgw8WURsM3ZM=;
	b=XYup1uGbrJML4Mzy59EIa1+NKb8rhGkIloNjVQIk8cLr8NCC+flnp+SXRdO8x+0AEsBZdM
	A3wq8ctRSLTUprnpI1f9Ay56yZdS0DArlBCoYiG2ciKAIO82tvPyMeCV+//1UMbywlYmsX
	Udzky4X/z9GbC3QOXOoStuJ0Mq5D7fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787057418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lurynGJFfEOjpSoiEvFLb2rSec2t0K5pgw8WURsM3ZM=;
	b=w7fEnJZyzqyNLqZ3HvZ8TEICA8+rVdi3XmaL7yk8FQOqe2nvGJ3D+rf/DlXIfppQAiuADg
	21+vbzKmmXos/4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45649362E;
	Tue, 18 Aug 2026 12:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yB+4DwpVhGojIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 12:50:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
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
Subject: [PATCH 02/12] drm/panic: Make allocation of zlib workspace more robust
Date: Tue, 18 Aug 2026 14:28:00 +0200
Message-ID: <20260818125012.468092-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818125012.468092-1-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)]
X-Rspamd-Queue-Id: BDB8E3E75
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Test the zlib workspace size to not have a negative value. This
would be a driver bug. Also touch allocated memory so that the
pages are available upon a panic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_panic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 0685f7d8dba2..705b72bf0d83 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -634,13 +634,19 @@ static struct z_stream_s stream;
 
 static void __init drm_panic_qr_init(void)
 {
+	int wssize;
+
+	wssize = zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL);
+	if (WARN_ON_ONCE(wssize < 0))
+		return;
 	/* best-effort allocation; can be NULL */
-	stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
-				   GFP_KERNEL);
+	stream.workspace = kmalloc(wssize, GFP_KERNEL);
 
 	/* touch memory so that pages are there in the case of a panic */
 	memset(qrbuf1, 0, sizeof(qrbuf1));
 	memset(qrbuf2, 0, sizeof(qrbuf2));
+	if (stream.workspace)
+		memset(stream.workspace, 0, wssize);
 }
 
 static void drm_panic_qr_exit(void)
-- 
2.55.0

