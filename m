Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424786;
	b=uPy/toPpoKOApHbp85MtIOhWy/Gor9wEa5xNA8g6PF426t+yFoBUUA+46h13NLmTMBRh
	 PJzqHlNy7RM+K6XzXz+HpMsdZZdbG83sx6SAZYh4q+BAArI16+p/wZlFPfWhfW+JzMEVd
	 SnnImTRAgn24DVQ28yXczWH+F96uD9wCZU9ksCjqckItArq3rAppEchGd0SEqZLpwc5H8
	 hi7/1NboVJYEWfCAE+MxNLlp9d9+u+lZuWkB/Ao4eLdqDkd43KtG6Lc96W7BzFl/I9v4w
	 vPnSs75jirBUvSfDQAhc5KUNNkEac/gNe3ClQHzeUKT/Es2KslRZZK9PvWKQdh3ghBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424786;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Rspamd-Pre-Result:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Spamd-Result:X-Rspamd-Server;
	bh=Q42+1LT+/kIysWR1pP52zLF3q3QDlSMlW5TUG8Jhqvg=;
	b=tZabFncvszLvB+XqlqCD3hryGGUXgY4xMyeJL8MU7mnboW4r7skM7y08Nmk0t66NFLS4
	 t6kzq03Bc3lNvoMAKDNBYNTFec7cweO4qfH2CKOuqpk6KiXZb6Vn074SGz/M2Ars6VFyd
	 K++ydrz6WVmealjDusMPE75VvLRNZ5vCCvpbmeubUUWb48IxzNxKKD9gbH4nF6+z5YLD4
	 sQCD7Yxbfl5q1qkyaB1aGKwzMGfI6QsjTSHo6IFMSULzPAjwr9cqaega9/4jM/hiqUewD
	 RZ4qieSWw78m9uf3A+snQPK+sSnXfX/1CgQdlKEmjyIn6qfenZSH+hbmCdrZX5BhTqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MsrOG3oY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dRTjBlue;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B2606DA60;
	Mon, 19 Oct 2026 15:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591B2606DA60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MsrOG3oY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dRTjBlue
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EC4621CA9;
	Mon, 19 Oct 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792424778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q42+1LT+/kIysWR1pP52zLF3q3QDlSMlW5TUG8Jhqvg=;
	b=MsrOG3oYS78SNJ7/ae2AH0ESftfF09tqFOLo3hMOAUt3slapAB7RrKO6+HesSxlqe6m/ue
	QEqoOB94tRzhOxv0a2MF0h3uFdFZhqo/bEk8CDVG0YF67dcqPz2qqkDbMdCoK9GGd82iS4
	Hb00NNR9DlS/BmHreEXJsRVzOrUheGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792424778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q42+1LT+/kIysWR1pP52zLF3q3QDlSMlW5TUG8Jhqvg=;
	b=dRTjBlueuN5bJ8GI4kyce071TiXAh7MkIvbio8l6r7/gH0P6dezWLAj20I7JwoEJfK3dni
	+4kEw2LgrA9qYSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA98A1376E;
	Mon, 19 Oct 2026 15:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYPgBkk71mrrPAAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 15:46:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	virtualization@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/4] drm: Add helper module for working with pixel data
Date: Mon, 19 Oct 2026 17:32:42 +0200
Message-ID: <20261019154612.777074-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019154612.777074-1-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Queue-Id: 2EC4621CA9
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Add drm_pixel_helper.ko. This module will contain helpers that copy
and process pixel data, such as framebuffers. Drivers that want to
use the helpers should select DRM_PIXEL_HELPER.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                   | 6 ++++++
 drivers/gpu/drm/Makefile                  | 4 ++++
 drivers/gpu/drm/drm_pixel_helper_common.c | 6 ++++++
 3 files changed, 16 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_pixel_helper_common.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c6..dce5e25671ee 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -49,6 +49,12 @@ config DRM_KMS_HELPER
 	help
 	  CRTC helpers for KMS drivers.
 
+config DRM_PIXEL_HELPER
+	tristate
+	depends on DRM
+	help
+	  Helpers for working with pixel data in DRM.
+
 config DRM_DRAW
 	bool
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923..5f555a2c1a4c 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -99,6 +99,10 @@ obj-$(CONFIG_DRM_PANEL) += drm_panel.o
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
+drm_pixel_helper-y := \
+	drm_pixel_helper_common.o
+obj-$(CONFIG_DRM_PIXEL_HELPER) += drm_pixel_helper.o
+
 #
 # Memory-management helpers
 #
diff --git a/drivers/gpu/drm/drm_pixel_helper_common.c b/drivers/gpu/drm/drm_pixel_helper_common.c
new file mode 100644
index 000000000000..743846e1e003
--- /dev/null
+++ b/drivers/gpu/drm/drm_pixel_helper_common.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("DRM pixel-data helpers");
+MODULE_LICENSE("GPL and additional rights");
-- 
2.56.0

