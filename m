Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332332BF41
	for <linux-hyperv@vger.kernel.org>; Mon, 11 May 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502299; cv=none; b=loLA53TPs4CA8vXrJXvIJHJnOzvSQq777h9WwkMKqbsxXT4Isk9yBRxJT2RQcjhK1SPDP/+zSVvSRf1aIxFNmBHZAoJ2J4sPZiKajRAd7oQc4HVjRCCtkqeNjrGurX8+XUZG4nhOTBkV10LeR61kzhOpgCPutNdHGmVYsQ8bNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502299; c=relaxed/simple;
	bh=1ho0abA+qbkW7yZ2V+bmXLPvCSAOSuoAatXJwcUT1W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me5sh1crKrl/g6yYOhnrzkV5Ac+R8xRpVSn+RVfCvto0PlrheBWkrcisJhnTqH+NIdNtY0XcqeFtPOgYxt7LgMGGFzjhq6zfSQoqObP79Xa8PtHn5u3BJ11s4JJTVKk8uPRRBtMFI/IAyvBf2XYRlK2M3RxOfXnpE29KiLJNV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R4IThUWW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DAn28gAj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R4IThUWW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DAn28gAj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R4IThUWW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DAn28gAj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R4IThUWW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DAn28gAj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6811D67E8E;
	Mon, 11 May 2026 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9QiHG4vOe4f2QDeIQHXRl8pRRE7jHmOLJK1ltAjPkI=;
	b=R4IThUWWKSVOQ5UdyMntj9S8zGXe6IHSANPixSsX3puZFYNvHjcMVpH7Mh0eNvUM2Dh8Nd
	zqZ9YYX9gqlfI/ZxM+knwZ25c7YIzd9J0wtRqbUPC4d83Xraok0Z7B+T7Vsgh0iJY/xWGI
	smPsBj/acoMrF/1ICIlfUXj1llxr7Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9QiHG4vOe4f2QDeIQHXRl8pRRE7jHmOLJK1ltAjPkI=;
	b=DAn28gAj1+DrEZ37E/1Ea8iqhP5n/54op8a0vFD6cpx5EKjHWGgpfAuhT4GvQwARuN4mbl
	NjeCW5QNg6E9NKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778502268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9QiHG4vOe4f2QDeIQHXRl8pRRE7jHmOLJK1ltAjPkI=;
	b=R4IThUWWKSVOQ5UdyMntj9S8zGXe6IHSANPixSsX3puZFYNvHjcMVpH7Mh0eNvUM2Dh8Nd
	zqZ9YYX9gqlfI/ZxM+knwZ25c7YIzd9J0wtRqbUPC4d83Xraok0Z7B+T7Vsgh0iJY/xWGI
	smPsBj/acoMrF/1ICIlfUXj1llxr7Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778502268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9QiHG4vOe4f2QDeIQHXRl8pRRE7jHmOLJK1ltAjPkI=;
	b=DAn28gAj1+DrEZ37E/1Ea8iqhP5n/54op8a0vFD6cpx5EKjHWGgpfAuhT4GvQwARuN4mbl
	NjeCW5QNg6E9NKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F298A593A3;
	Mon, 11 May 2026 12:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KOP7OXvKAWolYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 12:24:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 08/10] drm/atomic_helper: Do not evaluate plane damage before atomic_check
Date: Mon, 11 May 2026 14:22:32 +0200
Message-ID: <20260511122421.114014-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511122421.114014-1-tzimmermann@suse.de>
References: <20260511122421.114014-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,broadcom.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqqu4k9zio1uathxs7idfp4sa)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

Remove the call to drm_atomic_helper_check_plane_damage() from before
calling the atomic_check helpers. The call has no longer any purpose,
as the actual evaluation happens after running atomic_check.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 823ce60d45b4..57ffa8c8d641 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1034,8 +1034,6 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 
 		drm_atomic_helper_plane_changed(state, old_plane_state, new_plane_state, plane);
 
-		drm_atomic_helper_check_plane_damage(state, old_plane_state, new_plane_state);
-
 		if (!funcs || !funcs->atomic_check)
 			continue;
 
-- 
2.54.0

