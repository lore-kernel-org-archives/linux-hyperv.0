Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84E3CC314
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739766; cv=none; b=C4mF4wdsiwA3jFyDXeb3iR5W/ixjEleHIkhEBimCFP6lSrF9QwE4aZwpBYn+k/1ihVxFv5D9k5EVJZgcJYCUVrSU8pd+Fn1Q03dElceTvfPicY8HTlykrhlYKmyj5yfUUGR5j5EsW9CUvVh1bh99nZF2CBukHX1LHC370LfwuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739766; c=relaxed/simple;
	bh=WGmmHU56JK8t4H0Wmrqd7q2YhIComv2MZmxZyBvM1gM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nciydOtle/DW5S73Nc+urF23De3QAHxPmYnDE/fes+vqSCj9qDRwxF1mlQYr1AFMJgJC+5ZREyQRuSMWQZSpRH+W/WOAfHdWXuepz9mZfl59FzlbL3c3rbrrkMSUWCGHnfj+WIyGx6eE9bgtC3UVEMGAW2SXxJb37ZpyVimG3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR+mnIJn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR+mnIJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkwKjhSBsyXHCMEk0wHtGPYai7M4BNZChhD9iC4BYz8=;
	b=BR+mnIJntNWAw1niHsv30nbRgytunKN4XuR9P20uWriuqfNkADpP8+DJUFlt1kNygGB/dZ
	iRiEkRcbNf+wgLqL5zyDRJOfHHWc4eDD3FgbrNK3Ox5xU0i7ooQdOsOcJXw095pHla2sLu
	8RwnM2JDR0w5BGOQWm4FDwbeKTuI8Qg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-ryFPgAHQPDmJvJtUq0HEYQ-1; Fri,
 14 Aug 2026 16:35:59 -0400
X-MC-Unique: ryFPgAHQPDmJvJtUq0HEYQ-1
X-Mimecast-MFC-AGG-ID: ryFPgAHQPDmJvJtUq0HEYQ_1786739756
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C000E18004BB;
	Fri, 14 Aug 2026 20:35:56 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBB83197751E;
	Fri, 14 Aug 2026 20:35:53 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-samsung-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	intel-gfx@lists.freedesktop.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	spice-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev
Subject: [PATCH 2/5] drm/vblank: Remove drm->num_crtcs
Date: Fri, 14 Aug 2026 16:35:30 -0400
Message-ID: <20260814203542.1405135-3-lyude@redhat.com>
In-Reply-To: <20260814203542.1405135-1-lyude@redhat.com>
References: <20260814203542.1405135-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

While working on the Rust bindings for KMS, I asked myself "why does
drm_vblank_init() need the number of CRTCs with vblank support passed to
it?".

After some digging, I noticed the reason and it's silly and likely a
holdover from the pre-KMS days. We actually have ended up with two
different variables that claim to track the number of CRTCs a KMS device
has:

- dev->num_crtcs: Setup -from- drm_vblank_init(), meaning it's 0 if the
  driver has no vblank support.
- dev->mode_config.num_crtc: The correct one

There's no real need for this and it's probably confusing, and it's quite
easy to just drop this variable and convert everything over to
mode_config.num_crtc. So, let's do that with the following coccinelle
patch:

  virtual patch

  @depends on patch@
  struct drm_device *dev;
  @@

  - dev->num_crtcs
  + dev->mode_config.num_crtc

Signed-off-by: Lyude Paul <lyude@redhat.com>
Assisted-by: Coccinelle
---
 drivers/gpu/drm/drm_vblank.c                | 23 ++++++++++-----------
 drivers/gpu/drm/gma500/psb_irq.c            |  4 ++--
 drivers/gpu/drm/radeon/atombios_crtc.c      |  4 ++--
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |  4 ++--
 drivers/gpu/drm/vc4/vc4_kms.c               |  4 ++--
 include/drm/drm_device.h                    |  3 ---
 6 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index d317148af8cb3..c6f61a39b5d16 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -398,7 +398,7 @@ u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe)
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	u64 count;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return 0;
 
 	count = atomic64_read(&vblank->count);
@@ -558,7 +558,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 		return -ENOMEM;
 
 	dev->has_hw_vblank = true;
-	dev->num_crtcs = num_crtcs;
 
 	for (i = 0; i < num_crtcs; i++) {
 		struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, i);
@@ -645,7 +644,7 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
 	if (!drm_dev_has_vblank(dev))
 		return;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return;
 
 	/* Valid dotclock? */
@@ -729,7 +728,7 @@ drm_crtc_vblank_helper_get_vblank_timestamp_internal(
 	int vpos, hpos, i;
 	int delta_ns, duration_ns;
 
-	if (pipe >= dev->num_crtcs) {
+	if (pipe >= dev->mode_config.num_crtc) {
 		drm_err(dev, "Invalid crtc %u\n", pipe);
 		return false;
 	}
@@ -970,7 +969,7 @@ static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
 	u64 vblank_count;
 	unsigned int seq;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs)) {
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc)) {
 		*vblanktime = 0;
 		return 0;
 	}
@@ -1227,7 +1226,7 @@ int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
 	if (!drm_dev_has_vblank(dev))
 		return -EINVAL;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return -EINVAL;
 
 	spin_lock_irqsave(&dev->vbl_lock, irqflags);
@@ -1266,7 +1265,7 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	int vblank_offdelay = vblank->config.offdelay_ms;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return;
 
 	if (drm_WARN_ON(dev, atomic_read(&vblank->refcount) == 0))
@@ -1355,7 +1354,7 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	ktime_t now;
 	u64 seq;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return;
 
 	/*
@@ -1496,7 +1495,7 @@ void drm_crtc_vblank_on_config(struct drm_crtc *crtc,
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return;
 
 	spin_lock_irq(&dev->vbl_lock);
@@ -1555,7 +1554,7 @@ static void drm_vblank_restore(struct drm_device *dev, unsigned int pipe)
 	u32 cur_vblank, diff = 1;
 	u32 max_vblank_count = drm_max_vblank_count(dev, pipe);
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return;
 
 	assert_spin_locked(&dev->vbl_lock);
@@ -1788,7 +1787,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 		pipe = pipe_index;
 	}
 
-	if (pipe >= dev->num_crtcs)
+	if (pipe >= dev->mode_config.num_crtc)
 		return -EINVAL;
 
 	vblank = drm_vblank_crtc(dev, pipe);
@@ -1931,7 +1930,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 	if (drm_WARN_ON_ONCE(dev, !drm_dev_has_vblank(dev)))
 		return false;
 
-	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
+	if (drm_WARN_ON(dev, pipe >= dev->mode_config.num_crtc))
 		return false;
 
 	spin_lock_irqsave(&dev->event_lock, irqflags);
diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index c224c7ff353ce..f0b234a84bd55 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -292,7 +292,7 @@ void gma_irq_postinstall(struct drm_device *dev)
 	PSB_WVDC32(dev_priv->vdc_irq_mask, PSB_INT_ENABLE_R);
 	PSB_WVDC32(0xFFFFFFFF, PSB_HWSTAM);
 
-	for (i = 0; i < dev->num_crtcs; ++i) {
+	for (i = 0; i < dev->mode_config.num_crtc; ++i) {
 		if (dev->vblank[i].enabled)
 			gma_enable_pipestat(dev_priv, i, PIPE_VBLANK_INTERRUPT_ENABLE);
 		else
@@ -350,7 +350,7 @@ void gma_irq_uninstall(struct drm_device *dev)
 
 	PSB_WVDC32(0xFFFFFFFF, PSB_HWSTAM);
 
-	for (i = 0; i < dev->num_crtcs; ++i) {
+	for (i = 0; i < dev->mode_config.num_crtc; ++i) {
 		if (dev->vblank[i].enabled)
 			gma_disable_pipestat(dev_priv, i, PIPE_VBLANK_INTERRUPT_ENABLE);
 	}
diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0d6c5..054a24376aee0 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -277,14 +277,14 @@ void atombios_crtc_dpms(struct drm_crtc *crtc, int mode)
 		if (ASIC_IS_DCE3(rdev) && !ASIC_IS_DCE6(rdev))
 			atombios_enable_crtc_memreq(crtc, ATOM_ENABLE);
 		atombios_blank_crtc(crtc, ATOM_DISABLE);
-		if (dev->num_crtcs > radeon_crtc->crtc_id)
+		if (dev->mode_config.num_crtc > radeon_crtc->crtc_id)
 			drm_crtc_vblank_on(crtc);
 		radeon_crtc_load_lut(crtc);
 		break;
 	case DRM_MODE_DPMS_STANDBY:
 	case DRM_MODE_DPMS_SUSPEND:
 	case DRM_MODE_DPMS_OFF:
-		if (dev->num_crtcs > radeon_crtc->crtc_id)
+		if (dev->mode_config.num_crtc > radeon_crtc->crtc_id)
 			drm_crtc_vblank_off(crtc);
 		if (radeon_crtc->enabled)
 			atombios_blank_crtc(crtc, ATOM_ENABLE);
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
index a1054c8094d46..954a877b1fad2 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -334,14 +334,14 @@ static void radeon_crtc_dpms(struct drm_crtc *crtc, int mode)
 									 RADEON_CRTC_DISP_REQ_EN_B));
 			WREG32_P(RADEON_CRTC_EXT_CNTL, crtc_ext_cntl, ~(mask | crtc_ext_cntl));
 		}
-		if (dev->num_crtcs > radeon_crtc->crtc_id)
+		if (dev->mode_config.num_crtc > radeon_crtc->crtc_id)
 			drm_crtc_vblank_on(crtc);
 		radeon_crtc_load_lut(crtc);
 		break;
 	case DRM_MODE_DPMS_STANDBY:
 	case DRM_MODE_DPMS_SUSPEND:
 	case DRM_MODE_DPMS_OFF:
-		if (dev->num_crtcs > radeon_crtc->crtc_id)
+		if (dev->mode_config.num_crtc > radeon_crtc->crtc_id)
 			drm_crtc_vblank_off(crtc);
 		if (radeon_crtc->crtc_id)
 			WREG32_P(RADEON_CRTC2_GEN_CNTL, mask, ~(RADEON_CRTC2_EN | mask));
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index b17e73bce3841..8f08567d28fc6 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -936,7 +936,7 @@ static int vc4_pv_muxing_atomic_check(struct drm_device *dev,
 	 * If the layout changes and doesn't give us that in the future,
 	 * we will need to have something smarter, but it works so far.
 	 */
-	sorted_crtcs = kmalloc_objs(*sorted_crtcs, dev->num_crtcs);
+	sorted_crtcs = kmalloc_objs(*sorted_crtcs, dev->mode_config.num_crtc);
 	if (!sorted_crtcs)
 		return -ENOMEM;
 
@@ -946,7 +946,7 @@ static int vc4_pv_muxing_atomic_check(struct drm_device *dev,
 
 	sort(sorted_crtcs, i, sizeof(*sorted_crtcs), cmp_vc4_crtc_hvs_output, NULL);
 
-	for (i = 0; i < dev->num_crtcs; i++) {
+	for (i = 0; i < dev->mode_config.num_crtc; i++) {
 		struct vc4_crtc_state *old_vc4_crtc_state, *new_vc4_crtc_state;
 		struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 		struct vc4_crtc *vc4_crtc;
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 2df08c756afd3..2a9115da90ae7 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -340,9 +340,6 @@ struct drm_device {
 	 */
 	spinlock_t event_lock;
 
-	/** @num_crtcs: Number of CRTCs on this device */
-	unsigned int num_crtcs;
-
 	/** @mode_config: Current mode config */
 	struct drm_mode_config mode_config;
 
-- 
2.55.0

