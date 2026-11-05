Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887743;
	b=19t5OhxRSFvSYIzH/Mqr5HmOYhUuhOYkXtJqPJZVmAe10HHKJnGwQ4wyZX6LgEGBIkrd
	 cFG6863Zim9lBls1w2NFobNcg7+9q3WnK6zbmuPDRCkbF3TwWn9pS+VoKfoWJR4LY2sdA
	 PTaaRC/eJHOZhFt0943gZqXd/fI9IFhOs4q86hWZzfT2dfKbzb+Ikm2CdlcEHlaKkHUtR
	 8btDIfyDak+DdHFN2LHdOivQIlsjUcKsWTCYgz4ouUhSb8RN69z7CB5oZA1VxwkbrBrh2
	 4ZUnuRGB1tMmzInMRjQ6N0EPmDZy0oVUD5LSwT0IT/byfEUP9nB8j/3KF+WzMzSX5Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887743;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VpzTf44uanY82JK5gvkIQ8PHjT9V0UkQpItWXOxArwQ=;
	b=i3nOZv2fqijCk0+c10Om71wBXZG5a5EmxHCdwuSlqYBkGmxdSXuWws9gU6PhAxcN7dED
	 b0OLuQHHMA2RTzZQfsFa+FcYYcmRrZ7H+Acm43rTgr4JQESGj5pwv59HO6m9l3056d0ec
	 pwSo2Or7PT+N/ZIoT46NCXBAIWdKvMxhnq0Z5vGG6ajpVPIaRRbQ7MW9f8cLkdpAtkEP5
	 fUVCS9qcZXW3rj08Mm4uF+98plRGr/URrKeBq0Cr05u7nEvaoHUYiEPGNv3zQq48J0aSE
	 I8+8hyMr9AgBkS/byW/e3p1WPBEs3FjukXfVTTbotNBrTgZs2u19y1lVewINZ+NmSNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXlLAYQd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFF606A31B
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXlLAYQd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD691F0093A;
	Thu,  5 Nov 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887742;
	bh=VpzTf44uanY82JK5gvkIQ8PHjT9V0UkQpItWXOxArwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PXlLAYQdXm941mPHwFjOwUYpL+ifFBIPfZNiverqecu1rl83dibUe2AEMDfRj+POx
	 HzV6I7dde990c74YYwujXYoYx5o5mG+ac68bYBE6EXK4qxQlE7Ymwxcuwr54FlNVUc
	 noBwxTkkA7KYUsxuJJo/TbW7U+jjKrgk1IKFjMANRTcbMonTYzM+W+X7mT0ziNdvZE
	 YEFw6ZrSQvTnBgUSsyuO+6QjBYULyJLQEgIsxocNGjIIkgpv4VB6zuCwnAA9ijDBGT
	 AMSAsTOcyMbGqZ8vEp1Wx23SqSEOEixuho1Ex3TNU+cSM5ALrTCm+6JrK6JVhNwhVX
	 eOOBpLHfGDpIw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:07:33 +0100
Subject: [PATCH 16/83] drm/hyperv: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-16-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NEEQ2MFcdUzJbtJIPNNe+JcYh9p147t0lW/gPI3Zxuw=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrsjaKheXzA/GGdXVzkLxbr1wGHpXwh4LZLYUCXAoId46mt/
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrsjaIACgkQJ1/OGaI9vnZEyAGAvNbA
 DdHIcrxYvqkoUHP6yiGJ+9BvS3QVPNSnjR3tk2dqjysCHd3NF4iQS1is8AZwAXoDlZsEXyI6cVx
 NvNNAldVlMPl6MiHZqvIowR6gBHBnE3ZAbQ3crhB7zTlMNbmRmCA=
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

