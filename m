Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825092;
	b=FDpeB4X8U9O3BXugEWSBLD8MduW7J9ofc0A0dMBWPFsdKdSQy6cDF5syDNA2m3RVeiQm
	 0GxluWe1sjzsy8+z/pMtl3+Oy7Bd3Q+PLULy6zyTU+24ICn54utIWll/4OJvPSn13BwUv
	 8p+Pi+b+6FJTosfIGcM13+OfG/UmN1c/EusweymzcGeZXCVBUBlyfHZDSY5rAOELIdA6a
	 TMVZgfgjI+B0oH2HbcsN5YxQ0K3OlKIcjF4zGfki4uNMIOIE0psByUeeRCUuMOOrj5BK1
	 Irr00wdsam38GJ3qLjcT9AGCow5i6EW34irsuPrAlvIIrZLs6uwKucLDiqgEDhaYtog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825092;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8UTx7hfn9ScqGKLwZ+mlESG3z0L0rpzo7VEppQIjtdI=;
	b=fUZ6oge41a9WRsLrYXdbsKqMnZulc8KHTYhwRsL6VHbNuhQNNCTsDw+yV66GKN8dtTsp
	 /Err0VNKY0SCFJLwbuzpefenF9WLcuJMkrBcQtJ807ltPFz7nHpO1htr2QqRxbqfVYP6P
	 qf0qSvOMKwwQ4IAXH0QHHNN1WvaTEBEJ/0ofnrE/MURHtWY+5AQxUOaEM57KzMoeZ+L0H
	 tWH/JkguZ4FJAATQ48uplcyxQSt12FUfVOpiRWCn16mEVbbdkz8U+5usWal1w4+PVsXEA
	 QAiqCWidwjV7InMr7jCLHi7UxPCB/EjXfalEOA5/TPZ6ZPaZ15HS6JSjii4rFa/VBIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crjyqnfg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF363606A89E
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Nov 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crjyqnfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB83D1F000D0;
	Mon, 16 Nov 2026 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825092;
	bh=8UTx7hfn9ScqGKLwZ+mlESG3z0L0rpzo7VEppQIjtdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CrjyqnfgqDAwBCGrhzRMcCstb84E5uKwsqN23pwagrScobSV3YvnEdK0GpDlNkcEY
	 ddCCvjlIqDML23q1dGVDxMn5UJIfgzXZJ4nGHl55OaLkyQ/ZBm2DE1h4VfG95MyMiA
	 a12Sn4N1UeEvu2Slr4P1IO5giMcPfr4anYH+OczkkzVu4g+gFtWV2PKmOCi8KE2q/K
	 qM59QyP3hebM67Q6+b3SDO7wXs0GOC/0uGLicL6JVgR83a+OFB9cFJYmi/9JoBCaVe
	 oS4WwZv/6Vn/OSxnKTgLXxA7rIUsaFpvyaqrOVKpHDeozj2CCh9Kwaji+f1B2xytBz
	 gEvwQXU3/QZkA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:27 +0100
Subject: [PATCH v2 11/64] drm/hyperv: Switch to
 drm_mode_config_create_initial_state
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-11-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zciRmC5jF1oTFHKhECPibOoiM4CO6x8cndCWlHWuVSQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brsc3SN5/ImYvYvhDLUrevPKOIIsuYturp58qv7gN
 /MqI6MdHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAixWKMDQcPPe3O2hDRKHfT
 gf/MgsMHLnlIBJ4SW6Kw92D7JrbGdD85n7/Ss2doBP0tnv3WIZ47lrGabdo0VRW1+Y0T1MKf78z
 rvrT8iEGEfmrNh7x//muEw3o8fvA+EDzSJTP39bmoFr3YTkEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 759952f4ff19..73938303e663 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -500,9 +500,7 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
 
 	ret = drm_vblank_init(dev, 1);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }

-- 
2.56.1

