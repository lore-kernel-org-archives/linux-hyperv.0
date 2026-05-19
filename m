Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831333E35B;
	Sat, 23 May 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544771; cv=none; b=VWe6vGhp0vhoI1ChifPQTbRzVOO9AYdKi8ALOnMmKJ9cu4mMd9W+lt/YkPStCf8geRc4VS9pqpqXoH2UgFj06qOtHv8ZdhRQeO/ExgitAtMASBYWOS6Sk65D8aktEADWTGjGjD49H1y6M5J+S+5txOGjkekgQSxsyv9SMBD3Vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544771; c=relaxed/simple;
	bh=ILuFrIOgTO8y5W1rv5THOEIkmcdLmOdqUeFLjCyS2Xs=;
	h=Message-ID:In-Reply-To:References:From:To:Cc:Date:Subject; b=Plt2bGGL8QD/vIytPmE++9w69uvlmFi7Up2TlzQloev/wtai/73c6SrQmCawrVDZPhhlcjyq8qSJEe8iRbSt5elys9hoHJb8LXBkLJx3Bq4Qg3Mnm9lT9M4T38ZQv0EndddK7ep+M6M5NvbNWxWNn8eSkl1WKdcHtx/V6Jt5WNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=Snk5RZ0l; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=FWqZW+86; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="Snk5RZ0l";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="FWqZW+86"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Date:Cc:To:From:References:In-Reply-To:Message-ID:Sender:
	Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=; b=Snk5RZ0lbfY2zD4XrnFehj7llD
	TsBfM9yHtksiAoNpZ+d4KMVhRyFUXvS2ULL7kQRxVzSz16wFJHpg2PfwoI9+nw3M2904Bjtd1Znu7
	cVg8lrJGneP13Me3T/OYCdkwy9n+Bmj/U9A1woM+WJ34xLQ7FjLE+9437L0vE+efPqTnNQbhvYpz5
	ix9SBx1JAFYAdFUdXo685b/REoz6fyv6Yb3ex27pvn4ZYniI/WzP8sD7PDn0aF8DVO8TvqJlRRfrR
	U4WPl9TdxIgcU++ZBmO6EilKy/Db1Uh64gVcKaAeCJU7aBseJecxuZdQ47hpFHFJEKONVvDSK45L2
	OKfz0oKw==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wQmsu-004mB3-1K;
	Sat, 23 May 2026 13:59:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779544752; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=;
 b=FWqZW+86/YJ+Hdt8DHHQ2s3zs0tbmTsspFIx94URgEeY8Zf6NqcXikXU22A+f4bUNgd94
 o++WP2q9kJ1k5Hyy6GAHDHJVBsog6N65KvGZdLgS7Y4eY0ZcyjOsbTvkZU8s6wnlvolP/KI
 r2bWLOZbVbM25+7Vs10P4qbpo9xtE491WDeFZKjLI/3nzEasPSiCBRRJr5d5nEpiFDyuRdP
 G1ZV3KGJDKUra4yGpousXkukgDWg8JhpIP16STMSaqZ6jZZGwfatgdIfcF0ZEy9do1FJ7sZ
 XemwDhBYDRWus5S7B1Yg6j3TRb7VkgbLD/XcUw5KGF9vbRBdkD7vb8tr+aqg==
Message-ID: <6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com>
In-Reply-To: <cover.1779542874.git.me@berkoc.com>
References: <cover.1779542874.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Tue, 19 May 2026 22:08:17 +0200
Subject: [PATCH v5 1/2] drm/hyperv: validate resolution_count and fix WIN8
 fallback
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
parse loop. Bound resolution_count against the array size, folded
into the existing zero-check.

When the WIN10 resolution probe fails, the caller in
hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
which sets mode_config.max_width / max_height to 0 and makes
drm_internal_framebuffer_create() reject every userspace framebuffer
with -EINVAL. The pre-WIN10 branch had the same gap for
preferred_width / preferred_height. Use a single post-probe fallback
guarded by screen_width_max == 0 so both paths converge on the WIN8
defaults.

Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526..c3d0ff229 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
@@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
+	}
+
+	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
-- 
2.47.3

