Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892672;
	b=T1HeRL3LKJjgH9OWWK2zICG5wBXuvyGrJYEzOP3iUv9Hsrnbs/XXgQsAHoB4xorZhGpE
	 H3gg3MtfDxZuXI8fIjcMHXfBJxVxmjl3flVHpveDzuTgUObvglIsyA9E5PYixnLt/Rhew
	 mx7DQST8RjKwH/YLg9xa4q4/65rAOWMhsDomQiwf0EataUyOIpynZfnsJE3QKUkkhKVvv
	 2/xPK6LcBrMpvglEQVKPjqsC/JVPzQPV69z+BEAa16FbDE58pLViuzW4tDUlQFvmraTra
	 KzGY1xNzRHsE9HEOVtSfmpXjUWgU4mLFzxQPeOkWMNOtZeTdoaxsSmA2Ne5Q1YHLQiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VpzTf44uanY82JK5gvkIQ8PHjT9V0UkQpItWXOxArwQ=;
	b=JRx+gGbcq9nNMlIqr7BOKJJdb2wP02PoypJt/Hmna54BvarQ7C7+BJJ9biZeU3SKIx//
	 +GYMQVc5uGE3nqP8qfyFdVEgYwwPySb0itnGsi2dXhWtcEw6ek2RNX90wnB/Ehji6MPwG
	 XI5P6+54NQ+A2c9PuNMf/cS/zhms0H+EwGtNsChUPoPYumvEm0WpybjeNRRT2nH8uI3sV
	 /AbBXGEWKv2Vzqw9CV8IhPfgwNfEMh3htleeSLgbVM1lc+whRlQIGO2GmmuXal7xK7KTF
	 Eg4lKYHBDV4soz6BOG93GzWOiaq8l1V+VL1i04bpq98rEjNjcz4xy+Q4kVNV3G9VZ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9xgt9wx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D2606EE82
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9xgt9wx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA5E1F00A17;
	Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892671;
	bh=VpzTf44uanY82JK5gvkIQ8PHjT9V0UkQpItWXOxArwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U9xgt9wxphPkAOQgwdIc5hEcxo981ESwIJtUr8qCybOHBu/MSOcREOzhMTNEWoop1
	 wGoM405Vql0vxNnKCrDEQXS9Fs7EQFZ4TxOLX5XzI2AA4lVIfB8aZPn69FF4lluWe1
	 /0R8Ctan3Up0OqIhIxWxq3+ZpVe56HauiRiwcbxfGtXr0jH3AGYPtlvlDVD8167g9R
	 48f/esr+g9R9NcFmBeRkBDcbFi4E3dFPvfLmOnXuOBOUqj40AeKS3Pv1BjZ9J5qdM1
	 NSTsx3cg9NDPglsgEPghsQ0YWCPn1qfHuSX2QeYyFORk655JvqG/KVlOZ1RKi2J3Cg
	 KtWdIqaUk9vcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:25 +0100
Subject: [PATCH RESEND 16/83] drm/hyperv: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-16-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NEEQ2MFcdUzJbtJIPNNe+JcYh9p147t0lW/gPI3Zxuw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzJyuedIVFiFB+/szb2n5jXlJmPuP84OWakvKqXN
 H65KHNtx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI/03Ghl8dk2xYFzTNYau/
 Lb909fW0zIeFW/Oq7/7Q8Uo7IcnB++JG8LzjdioChiIFQku3CnVsYqxTyPN90WmRXMtq6XjGoPz
 9Lhn1uRIFsfe/sxhOVai+9rZcYN+GrWs/WuqtEonKFl/x6woA
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
index da399cb951a5..64715cc8bdee 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -337,6 +337,4 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
 		return ret;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }

-- 
2.55.0

