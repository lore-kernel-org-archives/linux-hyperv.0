Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649236D517;
	Sat, 25 Apr 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141065; cv=none; b=UnEXD3yZMP+wzr9gQFBJkaXiyEajvjM/9mQjiZtnwZG8VVoHmckhByIDDtyjqOMUQ05u8GLTNd4KazqL1F7sk/fs47OnpQXAD2+c0RhDd48l8rGYHOWO515w4VLmGSwfiCI8n5syewwPkyM3r/v4k8kBjQfpaQaFWvSFH6CQh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141065; c=relaxed/simple;
	bh=SqEOPughdst5frDTxssFt1bEgiOZdsCrn3oqLR3vFBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQqfR2BMTEfbPb+UiDFsr0YgS7gUUB1Bp3Hc88wZTtG+MeQo0HnG5f/A4XjaMRTw1oXG72+Ggjy0JP2TBvETtpv1zd51SGcAJaBoNe/wsJ29Cw8RiCDaeCEFVPKmns3cjLT9+v0RE38fG48k8qD7YvXgrFZ4h3PrrOwYEsOLyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DmLKY5Py; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DmLKY5Py"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id BB44820B7167; Sat, 25 Apr 2026 11:17:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB44820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777141062;
	bh=sh39rjXCVsjh69pBUlReRVKxFnTSW80T1LCRSsVGCpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmLKY5PywiKZ56ifa/A3vP5fRErajPZezlwTuJfPij/+ws3BnFPT2CW1kRGiEHxfe
	 2Gb3yZDo/EljSMA2RhOBHeNPVvD+MLbQMsWCLHVamglpQGTHQngBGf1CuyhRz5PmJE
	 F6buL9MpiAXEl/u57gvRZN4SLya5TH6eS35PR9kU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Himadri Pandya <himadrispandya@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Deepak Rawat <drawat.floss@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@kernel.vger.org
Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Date: Sat, 25 Apr 2026 11:17:19 -0700
Message-ID: <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
ensure they are always aligned and large enough to hold all of the
relevant data.

Cc: stable@kernel.vger.org
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..753d97bff76f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -10,7 +10,7 @@
 
 #include "hyperv_drm.h"
 
-#define VMBUS_RING_BUFSIZE (256 * 1024)
+#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
 #define VMBUS_VSP_TIMEOUT (10 * HZ)
 
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
-- 
2.54.0

