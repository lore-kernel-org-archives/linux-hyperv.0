Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC9563FBF
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Oct 2026 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998924; cv=none; b=IHKJOwgMGq+SLUnwua3e6sip+S6a0DIZ14OjqHB6vgvHkI8MYR0apzyHTA+52RovbZ6bCamamDqRe1eaxQGxbmcbDwWlb2nFsvHRMNs6dwwamKHyrE0xyHrdNnBLIJdrHfc/2/1MHJlohffAhx/5EVbDfB2NWnAo0C1otvPRn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998924; c=relaxed/simple;
	bh=ugtlh+MIfLszXFGE6m0yvcym1HwdCOM9fcPrb9p7Ius=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8KqGlbdcGwkgPZgKj7IUkIqInQEL2D8PgYvJAMijMsnO50S0Xl5aoAoN+ia6EmN40KavoSuonsEE0IuYwsKExw5bu0Qv3HSE/VFF9z6uM0q/A9Bbw2ea9DWtQzfbX6uoADdBkMzpXr2g0gCIS7bVwLBinVHwGvfdL/Tlcs/oDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m58xpQk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m58xpQk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C81F000C4;
	Wed, 14 Oct 2026 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998919;
	bh=cCixLrEpVO0ikUgNOqkoErMEMOZi2q4QJtVdxN1QvaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m58xpQk0cyYYcmvLGrLraD3mabCeZq8aOn885LAk+DXhfCr25tkS9Juej2ym5dkt1
	 pnt4qw0HIDbZOHfhiPHZAAsC8EO8R94JXQWzmi5FwHeoy32MizYQbHIkCv6m0hsqac
	 ECNQQgFcdh6e3bG8d/4nlIPIP3BkT12qNZ3M3EJS8Ex2VrQ9j4lzpumhhMiI4LfS3A
	 h4sMSvBd5jxs4278402IeJPEktbGlW19aELxKUTwIPFrTysCWd20vZoQ0XAawTpOXl
	 YDhqniVqLPyGs71f5Y9qOYBP+chW2ibFedDK/19IWHlaKqD89XZhoizkVlr7uVC3Yv
	 o/rS30avSib/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:47 +0200
Subject: [PATCH 24/75] drm/hyperv: Switch to
 drm_atomic_helper_connector_create_state
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ugtlh+MIfLszXFGE6m0yvcym1HwdCOM9fcPrb9p7Ius=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4fKp29hipyqpXNFP6XCJCrolarPGmtl3yYeW+UpS
 s++us/tmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOJOMLY8CBm0b3t5WxOBWdP
 /+mMNjxr4SDl9C1CnZlpTuFNVc3gGJvioK1n3twufblj1XO54KeujPWB9W9uf7py1sYjpG3156X
 ZmUYfJybua4n30U/blZa+Qdfh99nu7EMz2Fwc6+YrrjrndBUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The hyperv connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

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
index 523d1c7ea072..da399cb951a5 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs hv_drm_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static inline int hv_drm_conn_init(struct hv_drm_device *hv)

-- 
2.55.0

