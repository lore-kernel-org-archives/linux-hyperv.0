Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E713DD846
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739777; cv=none; b=M8oHBtbnPnOw6rLYO1OcRfAcHPw/xBTK6z0jJFfx/ZSKMM5G4S0YP4mtzQJFfmbMmGvL1MHI4i8CTy8T7pZP5qT5xLVO/Ic8I4kFdTLVTMFtGbPrpr6+KH0H8wnZsFjUAuZYLHzCvn9qI9EKI8mm8Pbjo+fcm7mr2ePQRlTDtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739777; c=relaxed/simple;
	bh=vmm1i0C9vXfD/IrBSW0vxZDHe7jpxrPQHihUJzNbwdo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQznFA93WmQh2XXL5ZWi8PlbrpnkwoNLNWx9JL6tDmVST403qUshua8xYlRPwXrMj+O5KQpcj1UuP3lnWVrkGX4sp7W/q0n5KWKLDycLIwobXUwzZWz1WIriqF5hDOVbY5or0h/GAQXDogVSVqYhbD7qsVWSs2D5cecj8NW0Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOIsULrz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOIsULrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786739774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WquuCq3TQCd+s4bFYX3uFmTk9vt6sijgW3Z8EuiR4qM=;
	b=EOIsULrzxfIXuC6sxkCm//sqeLHzQir3uTQwP4ofoOjK5KsCfQcKwO/vYLjmVoSyokkV1q
	p+wgpXHALpVWGhNbWJ+DVh8m4oloH335Ka1x02rXoBMp0Th2N7CX3PD8q9CPsVQAxqtd6v
	aN2v+nlUPvMFSlhT8UJuwJW+6kz5tdg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-3lqovXAqMhKKYoeTKCS2Bg-1; Fri,
 14 Aug 2026 16:36:10 -0400
X-MC-Unique: 3lqovXAqMhKKYoeTKCS2Bg-1
X-Mimecast-MFC-AGG-ID: 3lqovXAqMhKKYoeTKCS2Bg_1786739767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A467E1956069;
	Fri, 14 Aug 2026 20:36:07 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFE71197750F;
	Fri, 14 Aug 2026 20:36:04 +0000 (UTC)
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
Subject: [PATCH 5/5] drm/vblank: Require all CRTCs implement vblank support in drm_vblank_init()
Date: Fri, 14 Aug 2026 16:35:33 -0400
Message-ID: <20260814203542.1405135-6-lyude@redhat.com>
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

Due to us previously allowing users to specify the number of CRTCs for
drm_vblank_init() manually, a untested and almost certainly UB edge case
was technically possible for drivers: implementing vblank support for some
of their CRTCs, and not implementing it for others.

I don't think there's any actual situation in the real world where hardware
like this exists, nor do I think supporting such a possibility was ever
actually the original intent here. But in Rust, we need to be able to
prevent such a situation from occurring since we cannot guarantee no UB is
possible otherwise. I think it makes sense here for us to just handle this
safety check in the DRM core though, since it's quite likely such an edge
case would break C drivers in addition to Rust drivers.

So, let's start enforcing this in drm_vblank_init by checking that every
CRTC has an enable_vblank function registered. Throw a warning if we find
that some CRTCs have it and others don't.

In the event that we don't actually find any CRTCs with vblank support,
simply skip init and return -ENODEV. We intentionally don't WARN_ON() this
scenario, as it isn't a fatal error and drivers which do support KMS but
don't end up registering any CRTCs can simply ignore the error. This is
also useful for Rust, since it saves us from having to track whether or not
any CRTCs registered vblank support ourselves.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index d57405050554f..17affae23e7a6 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -542,12 +542,31 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
  * drmm_add_action_or_reset().
  *
  * Returns:
- * Zero on success or a negative error code on failure.
+ * Zero on success or a negative error code on failure. If no CRTCs with vblank
+ * support implemented were found, -ENODEV will be returned.
  */
 int drm_vblank_init(struct drm_device *dev)
 {
 	int ret;
 	struct drm_crtc *crtc;
+	bool found_vbl_crtc = false, found_non_vbl_crtc = false;
+
+	/* Vblank hooks are per-CRTC, not per-device - which is contrary to how
+	 * the vblank core was written. Since hardware that only has vblank
+	 * support on some CRTCs but not all is non-existent and would likely
+	 * lead to UB, ensure that vblank support is all or nothing.
+	 */
+	drm_for_each_crtc(crtc, dev) {
+		if (crtc->funcs->enable_vblank)
+			found_vbl_crtc = true;
+		else
+			found_non_vbl_crtc = true;
+
+		if (drm_WARN_ON(dev, found_vbl_crtc && found_non_vbl_crtc))
+			return -EINVAL;
+	}
+	if (!found_vbl_crtc)
+		return -ENODEV;
 
 	spin_lock_init(&dev->vbl_lock);
 	spin_lock_init(&dev->vblank_time_lock);
-- 
2.55.0

