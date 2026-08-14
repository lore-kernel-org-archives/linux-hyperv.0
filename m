Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9F3DA7F6
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739765; cv=none; b=fozI9L+gro3pMnKrCXpxtxijJGWRMrlqZ4n2OXGuqVWgLQ1Xo45XCzsn2LQ01Lk/yxBfEOp3C8KayX596YPdIRbC+3aAGHXG+J+dzbqUR17jEl320J43Vncr+kH+F32UuiopGu6zN8czqAmG1sZXc+vmkq62tnHDinkSRXoVh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739765; c=relaxed/simple;
	bh=L6cGAtA9z1lEA32tpQrcrf/dbswezRI4TiPZATe6Y6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGJBXIHKaQyla5PmtH44OGTLlyD7CMJhKTwt1MsRonn5wZfZQ9G6ZIekfRVXZNSU4nTCcjc1CVk6Azye0pVm8UiMA8oiJFCKvRZ5+RpQQrYsKoBRJM0tioAZgWdwRiX8hi/jOYeUcL//n4tZ+HIrTmXl9TOS00bE40a92QX89t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGiNZhwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGiNZhwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8HxtGS/+pDsEWZq9YYRCPV84sZrTTgU1WrgrxJbu3s=;
	b=DGiNZhwcCb1KbmOHbBKnCS6fB7eP05EMflaXau55R9uQeN5JSsKhwlKSlDOUJP1yqISIbT
	RSsHwniTosn7PaShK3kcLoMLdfVUSzfuc97OCslW5o7ji66evCfYRSGSZhvYHRYoHWQwUK
	nJYVaHuNVXugUMlG1+8xJ9CpVY8W5l4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-OoJM1A43PeiGF1bcosKBrg-1; Fri,
 14 Aug 2026 16:35:57 -0400
X-MC-Unique: OoJM1A43PeiGF1bcosKBrg-1
X-Mimecast-MFC-AGG-ID: OoJM1A43PeiGF1bcosKBrg_1786739754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC0B919560B5;
	Fri, 14 Aug 2026 20:35:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12FBC197751A;
	Fri, 14 Aug 2026 20:35:49 +0000 (UTC)
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
Subject: [PATCH 1/5] drm/vblank: Add drm_device.has_hw_vblank
Date: Fri, 14 Aug 2026 16:35:29 -0400
Message-ID: <20260814203542.1405135-2-lyude@redhat.com>
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

Currently the way we check if a driver supports hardware vblanks or not is
actually funny and cursed! Likely because it predates KMS.

As it turns out, we only check dev->num_crtcs to see if we have vblank
support. Why? Because it doesn't actually represent the number of CRTCs on
the device, unless drm_vblank_init() has been called - which sets
dev->num_crtcs. And as it turns out, this is the second place we keep track
of the number of CRTCs we have.

Let's clean this up by starting with adding a variable specifically for
tracking whether drm_vblank_init() has been called or not.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 3 ++-
 include/drm/drm_device.h     | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e423..d317148af8cb3 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -557,6 +557,7 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 	if (!dev->vblank)
 		return -ENOMEM;
 
+	dev->has_hw_vblank = true;
 	dev->num_crtcs = num_crtcs;
 
 	for (i = 0; i < num_crtcs; i++) {
@@ -600,7 +601,7 @@ EXPORT_SYMBOL(drm_vblank_init);
  */
 bool drm_dev_has_vblank(const struct drm_device *dev)
 {
-	return dev->num_crtcs != 0;
+	return dev->has_hw_vblank;
 }
 EXPORT_SYMBOL(drm_dev_has_vblank);
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 768a8dae83c52..2df08c756afd3 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -287,6 +287,13 @@ struct drm_device {
 	 */
 	struct drm_vblank_crtc *vblank;
 
+	/**
+	 * @has_hw_vblank:
+	 *
+	 * Has the driver called drm_vblank_init() to setup hardware vblank support?
+	 */
+	bool has_hw_vblank;
+
 	/**
 	 * @vblank_time_lock:
 	 *
-- 
2.55.0

