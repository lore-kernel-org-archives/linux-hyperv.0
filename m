Return-Path: <linux-hyperv-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B2AC433EF
	for <linux-hyperv@archiver.kernel.org>; Mon, 11 Apr 2022 04:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiDKEQS (ORCPT <rfc822;linux-hyperv@archiver.kernel.org>);
        Mon, 11 Apr 2022 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiDKEQQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Apr 2022 00:16:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636DB60D4;
        Sun, 10 Apr 2022 21:14:02 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A5CE205845F;
        Sun, 10 Apr 2022 21:14:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A5CE205845F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649650441;
        bh=1CE5tL3nbw04pRTjcKkm6W9BNuI9HtgHCs/cFUU4uBI=;
        h=From:To:Subject:Date:From;
        b=YWCrewhiRD5KF/KMC4BcuneHC+qudT89GPBAmwOF/eeEXmZk9ofuQgwX7rp5sL1dB
         4eSIOcDUHWj/6oYPiD73JshaYvKt35Zhh6w/Mffci5QoCbtvGuHJSfo2mr8FwY0TRQ
         xlA8EYCP/YOI5EFugNpLn5REml2QqhQoJhIEWuLk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, decui@microsoft.com
Subject: [PATCH v3] drm/hyperv: Added error message for fb size greater than allocated
Date:   Sun, 10 Apr 2022 21:13:57 -0700
Message-Id: <1649650437-17977-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Added error message when the size of requested framebuffer is more than
the allocated size by vmbus mmio region for framebuffer

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
v2 -> v3 : then -> than (typo fix)

 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index e82b815..6634818 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -123,8 +123,11 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
 	if (fb->format->format != DRM_FORMAT_XRGB8888)
 		return -EINVAL;
 
-	if (fb->pitches[0] * fb->height > hv->fb_size)
+	if (fb->pitches[0] * fb->height > hv->fb_size) {
+		drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater than allocated size %ld\n",
+		current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
 		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
1.8.3.1

