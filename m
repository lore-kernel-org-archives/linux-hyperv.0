Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB63C9EE9
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739785; cv=none; b=JBlLz2OLQqCgS6VbRaJygoKPXoV6OxSdC4G8OxeRo67rFpXBSGcdViTNCiNF9QhYhhxkW0YQRF6krsdTv56rbNRI5cCmtzCKgPAv2EXzhMMpdDiniPqESPUODHxvSMyZgIkgLL2robojYVgi8ijwsbs+Wdiw1hIlddBdNg0yDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739785; c=relaxed/simple;
	bh=eedkQEXrorNp37ksZK/2amUEphp9uBOtzRKZqiLu8RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjLTU7OOEwst/xI0TQdI57IivhhZMLYX3uuieDHk4eF03tE/Yw8wkViN6lipyGlwqFem6l8dh0rgQPuU8BzMl6JfenKSClRl49tCUkk786kbmEGIloTOcqk0BpZzXBqk723E23Haphs1JwTas6S8jqv3ozOHLBA32m2TNE61vas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwdIYDtp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwdIYDtp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEzS7cgh0s3kpDJoSKFSaeUbfz26XKFwvX4uV6Y0kQg=;
	b=fwdIYDtpSWHoxjufb+eNfSzISFOciE40K2DO+Ldg+N43vjYWIzVcRrQZo++SeNmMcKE+/Z
	cuktg1ioy5pyy0ujxsO3ug27vCdYkAt18D1FBNK4VzaBiTiA3RtwanFjNowHnx32n2MSfB
	eKDXo0NoWIxdujcJUoEWeZEuX2cx438=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-oqOvZT7bMEW5oR1aBhdpHw-1; Fri,
 14 Aug 2026 16:36:07 -0400
X-MC-Unique: oqOvZT7bMEW5oR1aBhdpHw-1
X-Mimecast-MFC-AGG-ID: oqOvZT7bMEW5oR1aBhdpHw_1786739765
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF7D195608A;
	Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94B5E197751A;
	Fri, 14 Aug 2026 20:36:00 +0000 (UTC)
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
Subject: [PATCH 4/5] drm/vblank: Use drm_for_each_crtc() in drm_vblank_init()
Date: Fri, 14 Aug 2026 16:35:32 -0400
Message-ID: <20260814203542.1405135-5-lyude@redhat.com>
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

No functional changes yet, we just should be using this iterator here
instead of manually counting the number of CRTCs anyhow.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 17283e8920378..d57405050554f 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -547,19 +547,20 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 int drm_vblank_init(struct drm_device *dev)
 {
 	int ret;
-	unsigned int num_crtcs = dev->mode_config.num_crtc;
-	unsigned int i;
+	struct drm_crtc *crtc;
 
 	spin_lock_init(&dev->vbl_lock);
 	spin_lock_init(&dev->vblank_time_lock);
 
-	dev->vblank = drmm_kcalloc(dev, num_crtcs, sizeof(*dev->vblank), GFP_KERNEL);
+	dev->vblank = drmm_kcalloc(dev, dev->mode_config.num_crtc,
+				   sizeof(*dev->vblank), GFP_KERNEL);
 	if (!dev->vblank)
 		return -ENOMEM;
 
 	dev->has_hw_vblank = true;
 
-	for (i = 0; i < num_crtcs; i++) {
+	drm_for_each_crtc(crtc, dev) {
+		unsigned int i = crtc->index;
 		struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, i);
 
 		vblank->dev = dev;
-- 
2.55.0

