Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29233E348
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105149; cv=none; b=K8RKiUwrk96ry3bP7o88LhhiMc3CWHEIrZZoDgHnDUpAp459La/nnrwT6Xn/V8Gc651OmTubEuI5heoqTKLRHcxvchHtKVaWXIFSPKB5YW8zF12YRcdoEULLVac21HHIp9+HPDySBdkSWjyn6wWpKUZHmFzNTJNWIUALUOcemxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105149; c=relaxed/simple;
	bh=lS4IrfZJo2FPhaUASdUPTsVSMx5VwLyjwMRNM8Gi000=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV+v8riW3BmYMcE4zz3aVLfeQtA7XroUfPNUuGbNjLhDQzHttJP4OqnekscKmGeH7ba5HI2Gf022kIex4cWjjSxsB+vvDRxWR1s3Go6sGtVuoJr8zb7PxobL41/jBnbMqNkJeGEBhPQm5UFUD8/7qk+62r3/27q1HilB8eq5a9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lmPGu+Ys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RIOnc1xz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lmPGu+Ys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RIOnc1xz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lmPGu+Ys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RIOnc1xz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lmPGu+Ys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RIOnc1xz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F19D46AEA6;
	Wed, 10 Jun 2026 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxql3716pXqWQmEE2LeoKEN1xwiz6N2JV4+1RCYfKw0=;
	b=lmPGu+YsH6vuslQO3NcxMiJCOgCfsBTiLtq7CIKTjIiUM86f++StXUdrsBJFtg0PwuRx7w
	k67FvJRDe5jVJna5FGo0mYqLXAb7XCMmlkFC0BHH2PdQ1+45F9p0o2FPAYH9GqQ9SxOZGz
	uY5mqP/uvtmkQo7WeDuCbxwQ4TF2vBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxql3716pXqWQmEE2LeoKEN1xwiz6N2JV4+1RCYfKw0=;
	b=RIOnc1xzz9T+R2qdG/VOw252ZL/cinH1eb7Ns1BAL0cfGO/r1DUlc+zqs6gMPdLv0yMmg3
	TFT7v7EtFZDaMpBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781105119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxql3716pXqWQmEE2LeoKEN1xwiz6N2JV4+1RCYfKw0=;
	b=lmPGu+YsH6vuslQO3NcxMiJCOgCfsBTiLtq7CIKTjIiUM86f++StXUdrsBJFtg0PwuRx7w
	k67FvJRDe5jVJna5FGo0mYqLXAb7XCMmlkFC0BHH2PdQ1+45F9p0o2FPAYH9GqQ9SxOZGz
	uY5mqP/uvtmkQo7WeDuCbxwQ4TF2vBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781105119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxql3716pXqWQmEE2LeoKEN1xwiz6N2JV4+1RCYfKw0=;
	b=RIOnc1xzz9T+R2qdG/VOw252ZL/cinH1eb7Ns1BAL0cfGO/r1DUlc+zqs6gMPdLv0yMmg3
	TFT7v7EtFZDaMpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 230CA779A7;
	Wed, 10 Jun 2026 15:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEgpB96BKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	jani.nikula@linux.intel.com,
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 08/15] drm/atomic-helpers: Evaluate plane damage after atomic_check
Date: Wed, 10 Jun 2026 17:18:24 +0200
Message-ID: <20260610152505.260172-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.79 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.936];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -6.79

Each plane's and CRTC's atomic_check might trigger a full modeset. As
this affects the plane's damage handling, evaluate damage clips after
running the atomic_check helpers.

Examples can be found in a number of drivers, such as ast, gud, ingenic,
mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
Ingenic even re-evaluates damage information in its plane's atomic_check.
Doing this after the atomic_check helpers ran benefits all drivers.

There's already a damage evaluation before the calls to atomic_check.
With a few fixes to drivers, this can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554df..8e080a42aec4 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1071,6 +1071,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 		}
 	}
 
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		drm_atomic_helper_check_plane_damage(state, new_plane_state);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_planes);
-- 
2.54.0

