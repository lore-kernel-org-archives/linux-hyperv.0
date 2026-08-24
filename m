Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038741DE03;
	Mon, 24 Aug 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576225; cv=none; b=blvkr2ydW9qXHlsRJR0gPN9qGzvUseNQHjWQ5tCDFKZkD40+Arq3hrlwtekELfapU/gEGngtm25yw4EZVWuuPAjh3ygu+3YZFu+LoLykvG5kQWB88l3ZmyfZ/NOulQZxVlR/xhpLCM18gDhSFuiLoBY1I4w6r7hWzfmR4AKdvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576225; c=relaxed/simple;
	bh=Hgzu/aTqGgpWftoDfichdxt+TjW0mzlTI6alWxrxj5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTDOgyT7MPnHF8xD/lEfdIrTrgq34HN2nPgWzOT274VJeHk12GIMlRdAQF0LE3NiyibkCyKoe0BWS5+rE0CqYca1B4MYyO+WCl3TLT5VJNzNA4gWz9faHbqztu6pCJVKeGPznkraOJpnxQfE7ucjzgZHmSgGlwCi5rXFBM1oC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RgOzaE9S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=919aQov6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kvb2GBXy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gis60qH+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RgOzaE9S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="919aQov6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kvb2GBXy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gis60qH+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 355D41F78D;
	Mon, 24 Aug 2026 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787575930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y4Rt8us7KI8CytgLhmA5lh8x+Gadd2RdxeTeBmbBBCM=;
	b=RgOzaE9S+HYlAglV9BpmsudO5/gKS03qrN19AX7VA84YNBypoV1s7TYrBfSh73gqj/O0do
	qyIixOajyJ2RS6TJcR9vOHJYHp0IVYgaC6hgtolU22PbS97SWpG5sBEO+O89VV+BZKojjZ
	Aq6Pj9RCWSBBofyuO203nFy0+tYee8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787575930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y4Rt8us7KI8CytgLhmA5lh8x+Gadd2RdxeTeBmbBBCM=;
	b=919aQov6dWtPIV6Oxs6qVgMKm0rO2Hbdr8b8b5+j/KYdI/9Ou4NRCMuNBMNt2GQK25JJ9I
	fLGh4EergfVJS6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787575926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y4Rt8us7KI8CytgLhmA5lh8x+Gadd2RdxeTeBmbBBCM=;
	b=kvb2GBXypsijxw7CuZUwEcBSkoH/Ynz3bQYZVWPEK17qYH9iyVcPQeNJgr5mo76BPqh0se
	4tvWz2Aq5/pWNBN95pfVNrjWwAwnr0B6yKhz5GVs9nfI3pBC0ygHGUBf13NNKP9j8g4Khe
	HXBEVIsayxD8H6aVQvuX5UsWn5VzREk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787575926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y4Rt8us7KI8CytgLhmA5lh8x+Gadd2RdxeTeBmbBBCM=;
	b=Gis60qH+QDuqJW6hGG3iTTPhGQQ2NG/9IWW7bHVGqMPmgj9fJUSlUvg+hNqOtzGT1PwOfk
	FYOVY8rYMGX+cTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCAB13335;
	Mon, 24 Aug 2026 12:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xYHvKHU+jGpyNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Aug 2026 12:52:05 +0000
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
Subject: [PATCH v2 00/13] drm/panic: Split into core and helpers
Date: Mon, 24 Aug 2026 14:43:31 +0200
Message-ID: <20260824125201.218863-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[drm_panic_qr.rs:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,drm_panic_helper_qr.rs:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,linux-m68k.org,infradead.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Split DRM's current panic handling into a core and a helper module.
The core is still part of DRM's core library. The panic helpers are
part of DRM's KMS helper module (for now).

The motivation behind this series is to get panic handling's drawing
code out of the DRM core. At some point it should share a single
module with DRM's other drawing and format conversion.

With the series applied, panic handling follows DRM's established
design pattern of having a DRM core interface with a dedicated
implementation in each driver. Drivers share common code in helper
modules. For panic handling, the DRM core still contains the panic
entry points, the parameters and the debugfs interface. All drawing
is now located in the panic helpers.

Patches 1 to 4 improve several issues in the current panic code. It
makes sense to fix them before moving the core around.

Patches 5 to 8 put handling of all panic state and locking into a
single place, drm_panic_display_panic_screen(). It is maintained by
panic handling's DRM core code. This also enables the test cases to
work more independently from the kernel's configuration.

Patches 9 to 12 split the panic-handling code into the core and panic
helpers. The former maintain all state, locking and public interfaces.
The latter handles drawing and details of the involved framebuffers.

DRM devices that offer panic handling provide a single callback, struct
drm_plane_funcs.display_panic_screen. A new initializer macro makes it
point to the existing panic-drawing implementation. Hence there's no
change in features or functionality. If panic handling is configured
off, it all clears out to NULL.

Patch 13 reworks the test cases slighly, so that they can be build as
a separate module. Do 'modprobe drm_panic_helper_test' to run them.

Tested under bochs, i915, amdgpu with debugfs and test cases.

Future directions:

- Panic handling shares drawing code with format conversion and
clients. There's even more drawing code in vkms. Later series' can
attempt to unify and harmonize all these implementations in a single
draw module.

- The drawing helper drm_plane_helper_display_panic_screen() still
implements various access schemes (map, set_pixel, memcpy) in a single
function. It could be split up into specialized helpers.

- If we ever need a driver-specific helper, it is now possible to
implement a custom version of display_panic_screen.

v2:
- resolve the various Kconfig issues (Randy)
- remove changes to qrbuf allocation (Jocelyn, Geert)
- fix possible URL format-string attack
- make test cases work again uder certain edge cases
- add better error reporting from failed draw_screen
- filter out non-primary planes from panic handling

Thomas Zimmermann (13):
  drm/panic: Do not use un-escaped URL as format string
  drm/panic: Test address from kmap op for NULL
  drm/panic: Return -EINVAL if font is not available
  drm/panic: Return errno codes if panic output fails
  drm/panic: Pass colors to draw_panic_dispatch()
  drm/panic: Pass global module parameters to drm_panic_dispatch()
  drm/panic: Retry in dispatch function if panic output fails
  drm/panic: Split draw_panic_plane()
  drm/panic: Restrict to primary planes; unconditionally unregister
  drm/panic: Display panic screen via per-plane callback
  drm/panic: Internalize panic locking in DRM core and helpers
  drm/panic: Move panic display code into helper library
  drm/panic: Compile KUnit tests as module

 Documentation/gpu/drm-kms-helpers.rst         |  11 +-
 Documentation/gpu/drm-kms.rst                 |   3 +
 MAINTAINERS                                   |  11 +-
 drivers/gpu/drm/Kconfig                       |   9 +-
 drivers/gpu/drm/Kconfig.debug                 |   1 +
 drivers/gpu/drm/Makefile                      |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   2 +
 drivers/gpu/drm/ast/ast_mode.c                |   2 +
 drivers/gpu/drm/drm_atomic_helper.c           |   2 +-
 drivers/gpu/drm/drm_crtc_internal.h           |   2 -
 drivers/gpu/drm/drm_drv.c                     |   3 +-
 drivers/gpu/drm/drm_kms_helper_common.c       |  14 +
 drivers/gpu/drm/drm_modeset_helper.c          |   2 +
 drivers/gpu/drm/drm_panic.c                   | 919 +-----------------
 drivers/gpu/drm/drm_panic_helper.c            | 918 +++++++++++++++++
 ...drm_panic_qr.rs => drm_panic_helper_qr.rs} |   4 +-
 drivers/gpu/drm/drm_panic_internal.h          |  69 ++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |   2 +
 drivers/gpu/drm/i915/display/i9xx_plane.c     |   3 +
 .../drm/i915/display/skl_universal_plane.c    |   4 +
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c       |   2 +
 drivers/gpu/drm/mgag200/mgag200_drv.h         |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c       |   2 +
 .../gpu/drm/renesas/rcar-du/rcar_du_plane.c   |   2 +
 .../drm/renesas/shmobile/shmob_drm_plane.c    |   2 +
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      |   4 +-
 drivers/gpu/drm/sysfb/vesadrm.c               |   1 +
 drivers/gpu/drm/tests/Makefile                |   1 +
 ...m_panic_test.c => drm_panic_helper_test.c} |  67 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |   2 +
 drivers/gpu/drm/tiny/bochs.c                  |   4 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |   2 +
 include/drm/drm_mode_config.h                 |   4 +-
 include/drm/drm_modeset_helper_vtables.h      |  11 +-
 include/drm/drm_panic.h                       | 117 +--
 include/drm/drm_panic_helper.h                |  40 +
 include/drm/drm_plane.h                       |  57 ++
 rust/bindings/bindings_helper.h               |   4 +-
 38 files changed, 1273 insertions(+), 1037 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panic_helper.c
 rename drivers/gpu/drm/{drm_panic_qr.rs => drm_panic_helper_qr.rs} (99%)
 create mode 100644 drivers/gpu/drm/drm_panic_internal.h
 rename drivers/gpu/drm/tests/{drm_panic_test.c => drm_panic_helper_test.c} (79%)
 create mode 100644 include/drm/drm_panic_helper.h


base-commit: dc462ab791b686c48545c160ecc81be64f77a846
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
-- 
2.55.0

