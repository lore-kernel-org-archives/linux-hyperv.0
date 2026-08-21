Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B821423A83
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Aug 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323192; cv=none; b=PerGyl0AAS6f/cxPE3bcdp6/3Lxp4jeUWMktpMtMX0CcWgZwUgLx28ELNLRmUpSr2EatTPGeHZ2odqnCxsyG3Q+SDv0cq+Ukve2UD5y2ShZzIt/lZs8ACxapn0aKJBBE4RbOxzFhuX6NpI/lrE8dHRYh0l16jmEoHWDzh/KCu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323192; c=relaxed/simple;
	bh=ruXycmb3plf+6PWeu1i/vP/qvX3ZaYbws8zFBzAuWY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipgV/pAmaOuapP6TE90o0a51kHvswRd+QjWVYh4sBWTVn73ORBjUYwqjSjFCQtxuDdSnpdPxEyKij5y4pZUfphfUFiHoLGaxbVMVAkY/mwjAoCntHy6RmjtLJYXLeunQWTPZZnFC6HvjMSTO9TB1OQbOGC/jHJR/mWKXl6vz6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzAwTeuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzAwTeuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4247F1F000E9;
	Fri, 21 Aug 2026 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323186;
	bh=re1eb35ZdS1svUjOnqsfFM5fIy5wYJs2GS7KkwlgjzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EzAwTeuzdJPbkSjPGP26/swSCzlkVRWxSRD0+/TKaqH7rfrtsPgYVCWtgiOJaNNvD
	 92k5wdY9zwZZKKvBhAS38YgrJ7B1o5rOoJQk6lgx4Tc6MbB4g3P38H5sQGpNh/dEnm
	 wMsGRfHsDw//TuoBStTap96OaBo08qC1hJdw4Qj8pcCwchSkXYYztHK6Sij5kj/ubV
	 JDvJDxpyPbVrhIYpinbKG+5kg8XFy2QxV0PzfWdWarTQr7rEPgFmRqw3Ht5UL8P7OH
	 Ugeuk3xmbrwIPNpFb8wdVqkmhEABIH8JYwubfgLYk9wdC1DpYjnk56ZpoXCRJzHxtm
	 XrtfvqFceaT1g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:46 +0200
Subject: [PATCH 10/70] drm/hyperv: Switch to
 drm_atomic_helper_crtc_create_state
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-10-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ruXycmb3plf+6PWeu1i/vP/qvX3ZaYbws8zFBzAuWY8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSX+CvY+dS93+izW6+VbR0435+p+TZb6c9Xzbo+pv5
 XKurNmlYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEcR1jnUH5pahHN2ekTZ+8
 ziO8bMeLn+vSUir+/18SvVeY7WGxpmdN5S4W56uLTOeEMh5ey8E3hbHh3VypKs39qxUkLkzcKBL
 9zTf7qE7z3ois2EORE4V9Frvp+V6SuCZnU7nGYqbDnDlC58UB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The hyperv crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 1855749c1e41..3261e730c69d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -124,11 +124,11 @@ static const struct drm_crtc_helper_funcs hv_drm_crtc_helper_funcs = {
 	.atomic_enable = hv_drm_crtc_helper_atomic_enable,
 	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
 static const struct drm_crtc_funcs hv_drm_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

