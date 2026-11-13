Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607159;
	b=ftzZRrS7kyLzHxkgmos49aIGPuhpOvxax18/+/rgeRI3VuLP5p9dDklkdvBjmBinOC79
	 3NHCtxWxzLTOZ0bwcp80WzzwBf93LiNNbCRs4AzoX/ybPlMUrCpb0ynNJnPLUnEfOKioR
	 Z1ZO8bsjPY017Uu7PyNxk09nRyokozGaGkw3L29WIkQHucPn2MEWwZTodfuSJfuGq4wuK
	 1TZgYNtRvRQnMKrjLML7F2sKqbiooFtQgRfhn8VEquqOnhI0FVtqeMSi2/2GGZbnYzcKG
	 1NxsnYpWxQVSDU6LL/pKCcRIEem7zkJMrir5o6Rsalg9Z+OvG8tSp7DPeyhhumFxCTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607159;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yo5/Ludd3iLfDJ3kwnz1BM7dzhexiWbvw29sP6ti3hQ=;
	b=j4BbzSvD3r2DE534oGXbYv+TmZ74M5B0u9oClSK3nXloDhcCxpY4mMAyH53COmfx1t+K
	 4NdAzAMofvQ56Fx9nh0GzJPwArcIitz/bw+5VbZDGDi/YezdGq5uuvNz5M3pIsPn9wcfx
	 thIg8JXbhJjYpWl1m9rWm70RgHFpebDgDunO/3+6rj6o0UFwOpZYnLaHHnhAHuU82xsb9
	 REmYrq8bsdI3CM0SvpxxdDibKYesc8QKu3vJrDkjlaHNahqx7Rx2v7soXbHsLCrbMqYNM
	 9mR8UaaHFekAqrW9U5+ZCiCAKuf+4dJpwdJxWY3B4wP5UXYIqJ9noEt+W7Wmyx1q50g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rUVCn+6l;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239BA606A334;
	Fri, 13 Nov 2026 21:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239BA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rUVCn+6l
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6DB7020B7167; Fri, 13 Nov 2026 13:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DB7020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794607154;
	bh=yo5/Ludd3iLfDJ3kwnz1BM7dzhexiWbvw29sP6ti3hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUVCn+6lNK3oVHmaku2a7i3GYzbTlCoBbDU3fmTyF6u+LcB5lhBhWuUDWSOlHSPz0
	 8nioCI4VjwTE5mqBv+JSYFA4wCl535D9Jn5ldOyCO2DfpH+/YVQ5Dx7rFqNXw5/K5f
	 OlgjIMMqkgt/vtVGEr3XXkD8nOT+Nyaqff5lASjk=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 1/2] drm/hyperv: add modes for all resolutions offered by the host
Date: Fri, 13 Nov 2026 16:58:42 -0500
Message-ID: <20261113215843.1939889-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
References: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The host reports the resolutions it supports, which depend on the VM's
configuration: a list of standard resolutions by default, those up to a
maximum plus the maximum itself, or a single resolution. The driver
only takes the largest and the default resolution from the list, and
offers the DMT modes of up to 60 Hz that fit. Resolutions without such
a mode are thus missing (e.g. 1152x864, for which DMT only has a 75 Hz
mode). A VM set to 2560x1440 even ends up without a preferred mode, as
DMT has no 2560x1440 mode at all.

So, keep the list and add a 60 Hz CVT mode for every resolution in it
that lacks a mode of its size, so that all of them can be used. CVT
rounds the width down to a multiple of 8 while the host only requires an
even width (e.g. 1366x768), so restore the width afterwards.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h         |  9 +++++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 29 +++++++++++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 10 +++----
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index df03185a2e19..6006d665343b 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -19,6 +19,13 @@
 #define SYNTHVID_CURSOR_MAX_SIZE (SYNTHVID_CURSOR_MAX_X * \
 	SYNTHVID_CURSOR_MAX_Y * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE)
 
+#define SYNTHVID_MAX_RESOLUTION_COUNT 64
+
+struct hvd_screen_info {
+	u16 width;
+	u16 height;
+} __packed;
+
 /*
  * Copy of the cursor last handed to the host, so that it can be sent again
  * when needed, e.g. after a VM Connection window was opened.
@@ -55,6 +62,8 @@ struct hv_drm_device {
 	u32 preferred_width;
 	u32 preferred_height;
 	u32 screen_depth;
+	struct hvd_screen_info resolutions[SYNTHVID_MAX_RESOLUTION_COUNT];
+	unsigned int resolution_count;
 
 	/* hw */
 	struct resource *mem;
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 48d7751c0bdd..177f804dca0c 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -46,14 +46,43 @@ static int hv_drm_blit_to_vram_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
+static int hv_drm_connector_add_mode(struct drm_connector *connector,
+				     u16 width, u16 height)
+{
+	struct drm_display_mode *mode;
+
+	list_for_each_entry(mode, &connector->probed_modes, head) {
+		if (mode->hdisplay == width && mode->vdisplay == height)
+			return 0;
+	}
+
+	mode = drm_cvt_mode(connector->dev, width, height, 60, false, false,
+			    false);
+	if (!mode)
+		return 0;
+
+	/* CVT rounds the width down to a multiple of 8, the host does not */
+	mode->hdisplay = width;
+	mode->type |= DRM_MODE_TYPE_DRIVER;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
 static int hv_drm_connector_get_modes(struct drm_connector *connector)
 {
 	struct hv_drm_device *hv = to_hv_drm(connector->dev);
+	unsigned int i;
 	int count;
 
 	count = drm_add_modes_noedid(connector,
 				     connector->dev->mode_config.max_width,
 				     connector->dev->mode_config.max_height);
+	for (i = 0; i < hv->resolution_count; i++)
+		count += hv_drm_connector_add_mode(connector,
+						   hv->resolutions[i].width,
+						   hv->resolutions[i].height);
 	drm_set_preferred_mode(connector, hv->preferred_width,
 			       hv->preferred_height);
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 99e036576929..81ffb88ba6a1 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -56,11 +56,6 @@ struct pipe_msg_hdr {
 	u32 size; /* size of message after this field */
 } __packed;
 
-struct hvd_screen_info {
-	u16 width;
-	u16 height;
-} __packed;
-
 struct synthvid_msg_hdr {
 	u32 type;
 	u32 size;  /* size of this header + payload after this field */
@@ -145,7 +140,6 @@ struct synthvid_dirt {
 } __packed;
 
 #define SYNTHVID_EDID_BLOCK_SIZE	128
-#define	SYNTHVID_MAX_RESOLUTION_COUNT	64
 
 struct synthvid_supported_resolution_req {
 	u8 maximum_resolution_count;
@@ -522,6 +516,10 @@ static int hv_drm_get_supported_resolution(struct hv_device *hdev)
 	hv->preferred_height =
 		msg->resolution_resp.supported_resolution[index].height;
 
+	hv->resolution_count = msg->resolution_resp.resolution_count;
+	memcpy(hv->resolutions, msg->resolution_resp.supported_resolution,
+	       hv->resolution_count * sizeof(hv->resolutions[0]));
+
 	return 0;
 }
 
-- 
2.56.0

