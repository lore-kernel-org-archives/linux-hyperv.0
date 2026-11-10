Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334628;
	b=0zPDFC7EseTAKRy4jGVokzB2zQHzm99eg3owgL+DsNbaWxni+zTDi73I8l/EqYzMySKc
	 H1cHyR6asrBT62P5eDrLbETVotmeWALkHCmJldGvCfUcjyTjujp0cKJTIZIKQI1a2lrxi
	 x7vfbhzmjmEd/rraaZL8gu9LkTLcpKRO5RhN5uPtg/e2Mds9COCENhAfMqSolnvYMveSD
	 kLPBAtkfTSudkcWJQgjWfi9d9IpVz8joqi+sj7utl0QQ8HF5h8oSMrk2V9XWf2uWiskma
	 rhvi8mCXhHkPf8fYM0b+0FVgz3pWitY0B6jXr5JcNaOIk15+aLKWMNpUrllPOemdeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334628;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7NhWvPXzIPgpGjsa+QpWCs+b6cZNYdNhrWU6Qv8VSSs=;
	b=uV6kXm32RaKU1ioK5e2GrOWxnTqOZjvSTp5m1jrjovk8smMefPVQHv4aRHPqsEpfXmaw
	 5/wVXQIogf5x+DZ9exFz3DO1SFzNHNmCC9NVYvDnFCAFfCR1bAKA/ABG85VSKxxe4Yna5
	 70ALJub8ZvljYQ/Rs68xzItP1CehOdSQVRoeT0oUnuh/VXHUhrfy91lKj779JpYPCBeyX
	 96xRpU3FldEQkC7i/cJNnteZCC/cjjOqV/rWqpXeqIDEAbDFgvA1ozqE+xa5H0NrDZ/iM
	 vF0ibp3J9Kvxg79aeAwitUYAyMJ0Qw/xrHWXA7FEX3GUOEFXL+aKrMGWlLniMGWT7Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bZLXEPf7;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C679606A325
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Nov 2026 18:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C679606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bZLXEPf7
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 5E34720B7169; Tue, 10 Nov 2026 10:17:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E34720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794334624;
	bh=7NhWvPXzIPgpGjsa+QpWCs+b6cZNYdNhrWU6Qv8VSSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZLXEPf7VWwzVJ3mfXBumNpLX6MsqN9axK0gLyos8AbGkxUj3XLYlqisgpQX+jflQ
	 PK+wPsbOf3+myv8gQHXuRUI/d2Hd66zXaAITTDai1nzYQ4evV07q21v83RynuLBcxa
	 7fdUbHeWB1HNvEMfZG18DdOMTYLeKYbU9m6b7TII=
Date: Tue, 10 Nov 2026 13:17:04 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-hyperv@vger.kernel.org, Lanfeng Wei <xlfylawarthur@gmail.com>
Subject: Re: [PATCH] drm/hyperv: add cursor plane support
Message-ID: <avNfoFMMmdVECYUv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261020231451.1813472-1-hamzamahfooz@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020231451.1813472-1-hamzamahfooz@linux.microsoft.com>

Hi Lanfeng,

On Tue, Oct 20, 2026 at 07:14:51PM -0400, Hamza Mahfooz wrote:
> The Hyper-V synthetic video device lets the guest set the image and the
> position of the mouse pointer, which RDP clients like the VM Connection
> window then draw on their own, wherever their local mouse is. The driver
> only used this to hide the pointer so far, leaving the cursor to be
> drawn into the framebuffer, where it lags behind the mouse.
> 
> Add a cursor plane that hands its image to the host instead. As the
> clients draw the pointer at their mouse position, the hotspot needs to
> be known, so set DRIVER_CURSOR_HOTSPOT.
> 
> The host takes ARGB8888 images of up to 96x96 pixels, stored bottom-up
> and sent in parts of at most 8 KiB. Fully transparent columns and rows
> at the right and bottom, like the padding of a cursor buffer of the
> maximum size, are left out to keep the messages small. RDP clients use
> straight alpha for pointer images, so only advertise the "Coverage"
> pixel blend mode.
> 
> The host shows a small dot for a pointer marked invisible, so a hidden
> cursor is sent as a single, almost transparent pixel instead, like
> hv_drm_hide_hw_ptr() did, which this replaces. An image without any
> visible pixel is sent likewise, as clients may draw it as an opaque box
> otherwise.
> 
> Clients connecting to the VM show a default pointer until they are sent
> one, so keep a copy of the cursor and send it again when the host
> reports a feature change as a client connects, and when the CRTC gets
> enabled.
> 
> NOTE: The predominant client (i.e. VMConnect) draws translucent pixels
> as opaque ones blended onto black, this is a limitation of the client.
> 

Have you had a chance to test this out on your end?

Hamza

> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm.h         |  37 +++-
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  13 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 170 +++++++++++++++-
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 211 ++++++++++++++++----
>  4 files changed, 381 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
> index f4262a37af36..df03185a2e19 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> @@ -13,10 +13,38 @@
>  
>  #define VMBUS_MAX_PACKET_SIZE 0x4000
>  
> +#define SYNTHVID_CURSOR_MAX_X 96
> +#define SYNTHVID_CURSOR_MAX_Y 96
> +#define SYNTHVID_CURSOR_ARGB_PIXEL_SIZE 4
> +#define SYNTHVID_CURSOR_MAX_SIZE (SYNTHVID_CURSOR_MAX_X * \
> +	SYNTHVID_CURSOR_MAX_Y * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE)
> +
> +/*
> + * Copy of the cursor last handed to the host, so that it can be sent again
> + * when needed, e.g. after a VM Connection window was opened.
> + */
> +struct hv_drm_cursor {
> +	/* Serializes pointer messages and protects the fields below */
> +	struct mutex lock;
> +	/* The host may not have the cached shape, e.g. after a failed send */
> +	bool shape_stale;
> +	u32 width;
> +	u32 height;
> +	u32 hot_x;
> +	u32 hot_y;
> +	s32 x;
> +	s32 y;
> +	/* ARGB8888, rows of width pixels, stored bottom-up as the host wants */
> +	u8 image[SYNTHVID_CURSOR_MAX_SIZE];
> +	/* Scratch space for building pointer shape messages */
> +	u8 msg_buf[VMBUS_MAX_PACKET_SIZE];
> +};
> +
>  struct hv_drm_device {
>  	/* drm */
>  	struct drm_device dev;
>  	struct drm_plane plane;
> +	struct drm_plane cursor_plane;
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
>  	struct drm_connector connector;
> @@ -40,6 +68,9 @@ struct hv_drm_device {
>  	u8 init_buf[VMBUS_MAX_PACKET_SIZE];
>  	u8 recv_buf[VMBUS_MAX_PACKET_SIZE];
>  
> +	struct hv_drm_cursor *cursor;
> +	struct work_struct cursor_work;
> +
>  	struct hv_device *hdev;
>  };
>  
> @@ -52,8 +83,12 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv);
>  int hv_drm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
>  int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>  			    u32 w, u32 h, u32 pitch);
> -int hv_drm_hide_hw_ptr(struct hv_device *hdev);
> +int hv_drm_cursor_init(struct hv_drm_device *hv);
> +void hv_drm_cursor_set_hidden(struct hv_drm_cursor *cursor);
> +void hv_drm_update_cursor(struct hv_drm_device *hv, bool shape);
> +void hv_drm_restore_cursor(struct hv_drm_device *hv);
>  int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
>  int hv_drm_connect_vsp(struct hv_device *hdev);
> +void hv_drm_disconnect_vsp(struct hv_device *hdev);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 031206a5b3d7..21e5fcc3eb68 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -26,7 +26,8 @@
>  DEFINE_DRM_GEM_FOPS(hv_drm_fops);
>  
>  static struct drm_driver hv_drm_driver = {
> -	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
> +	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC |
> +			   DRIVER_CURSOR_HOTSPOT,
>  
>  	.name		 = DRIVER_NAME,
>  	.desc		 = DRIVER_DESC,
> @@ -119,6 +120,10 @@ static int hv_drm_vmbus_probe(struct hv_device *hdev,
>  	hv_set_drvdata(hdev, hv);
>  	hv->hdev = hdev;
>  
> +	ret = hv_drm_cursor_init(hv);
> +	if (ret)
> +		goto err_hv_set_drv_data;
> +
>  	ret = hv_drm_connect_vsp(hdev);
>  	if (ret) {
>  		drm_err(dev, "Failed to connect to vmbus.\n");
> @@ -162,7 +167,7 @@ static int hv_drm_vmbus_probe(struct hv_device *hdev,
>  	iounmap(hv->vram);
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>  err_vmbus_close:
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>  err_hv_set_drv_data:
>  	hv_set_drvdata(hdev, NULL);
>  	return ret;
> @@ -176,7 +181,7 @@ static void hv_drm_vmbus_remove(struct hv_device *hdev)
>  	vmbus_set_skip_unload(false);
>  	drm_dev_unplug(dev);
>  	drm_atomic_helper_shutdown(dev);
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>  	hv_set_drvdata(hdev, NULL);
>  
>  	iounmap(hv->vram);
> @@ -197,7 +202,7 @@ static int hv_drm_vmbus_suspend(struct hv_device *hdev)
>  	if (ret)
>  		return ret;
>  
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index da399cb951a5..c9d02311afb5 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -6,6 +6,7 @@
>  #include <linux/hyperv.h>
>  
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_blend.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
> @@ -110,7 +111,7 @@ static void hv_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  	struct drm_plane_state *plane_state = plane->state;
>  	struct drm_crtc_state *crtc_state = crtc->state;
>  
> -	hv_drm_hide_hw_ptr(hv->hdev);
> +	hv_drm_restore_cursor(hv);
>  	hv_drm_update_situation(hv->hdev, 1,  hv->screen_depth,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
> @@ -241,6 +242,152 @@ static const struct drm_plane_funcs hv_drm_plane_funcs = {
>  	DRM_PANIC_PLANE_FUNCS,
>  };
>  
> +static const u32 hv_drm_cursor_formats[] = {
> +	DRM_FORMAT_ARGB8888,
> +};
> +
> +static int hv_drm_cursor_atomic_check(struct drm_plane *plane,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
> +
> +	if (crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  true, true);
> +	if (ret)
> +		return ret;
> +
> +	if (!plane_state->fb)
> +		return 0;
> +
> +	if (!plane_state->crtc_w || plane_state->crtc_w > SYNTHVID_CURSOR_MAX_X ||
> +	    !plane_state->crtc_h || plane_state->crtc_h > SYNTHVID_CURSOR_MAX_Y) {
> +		drm_dbg_atomic(plane->dev, "Invalid cursor size %ux%u\n",
> +			       plane_state->crtc_w, plane_state->crtc_h);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy the cursor image to the cache, bottom-up as the host wants it. Fully
> + * transparent columns and rows at the right and bottom, like the padding of
> + * a cursor buffer of the maximum size, are left out.
> + */
> +static void hv_drm_cursor_load(struct hv_drm_cursor *cursor,
> +			       const struct drm_plane_state *state,
> +			       const struct iosys_map *map)
> +{
> +	size_t pitch = state->fb->pitches[0];
> +	size_t offset = (state->src_y >> 16) * pitch + (state->src_x >> 16) *
> +		SYNTHVID_CURSOR_ARGB_PIXEL_SIZE;
> +	u32 hot_x = clamp_t(s32, state->hotspot_x, 0, state->crtc_w - 1);
> +	u32 hot_y = clamp_t(s32, state->hotspot_y, 0, state->crtc_h - 1);
> +	u32 width = 0, height = 0;
> +	u32 x, y;
> +
> +	for (y = 0; y < state->crtc_h; y++) {
> +		for (x = state->crtc_w; x; x--) {
> +			if (iosys_map_rd(map,
> +					 (offset + y * pitch + x *
> +					  SYNTHVID_CURSOR_ARGB_PIXEL_SIZE - 1),
> +					 u8))
> +				break;
> +		}
> +
> +		if (x) {
> +			width = max(width, x);
> +			height = y + 1;
> +		}
> +	}
> +
> +	if (!width) {
> +		hv_drm_cursor_set_hidden(cursor);
> +		return;
> +	}
> +
> +	/* Keep the hotspot within the image */
> +	width = max(width, hot_x + 1);
> +	height = max(height, hot_y + 1);
> +
> +	for (y = 0; y < height; y++)
> +		iosys_map_memcpy_from((cursor->image + (height - 1 - y) *
> +				       width * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE),
> +				      map, offset + y * pitch,
> +				      width * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE);
> +
> +	cursor->width = width;
> +	cursor->height = height;
> +	cursor->hot_x = hot_x;
> +	cursor->hot_y = hot_y;
> +}
> +
> +static void hv_drm_cursor_hide(struct hv_drm_device *hv)
> +{
> +	struct hv_drm_cursor *cursor = hv->cursor;
> +
> +	scoped_guard(mutex, &cursor->lock) {
> +		hv_drm_cursor_set_hidden(cursor);
> +		hv_drm_update_cursor(hv, true);
> +	}
> +}
> +
> +static void hv_drm_cursor_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
> +{
> +	struct hv_drm_device *hv = to_hv_drm(plane->dev);
> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
> +	struct hv_drm_cursor *cursor = hv->cursor;
> +	bool shape;
> +
> +	if (!new_state->visible) {
> +		if (old_state->visible)
> +			hv_drm_cursor_hide(hv);
> +		return;
> +	}
> +
> +	shape = !old_state->visible || old_state->fb != new_state->fb ||
> +		old_state->src_x != new_state->src_x ||
> +		old_state->src_y != new_state->src_y ||
> +		old_state->src_w != new_state->src_w ||
> +		old_state->src_h != new_state->src_h ||
> +		old_state->hotspot_x != new_state->hotspot_x ||
> +		old_state->hotspot_y != new_state->hotspot_y;
> +
> +	scoped_guard(mutex, &cursor->lock) {
> +		if (shape)
> +			hv_drm_cursor_load(cursor, new_state,
> +					   &shadow_plane_state->data[0]);
> +
> +		cursor->x = new_state->crtc_x;
> +		cursor->y = new_state->crtc_y;
> +		hv_drm_update_cursor(hv, shape);
> +	}
> +}
> +
> +static void hv_drm_cursor_atomic_disable(struct drm_plane *plane,
> +					 struct drm_atomic_commit *state)
> +{
> +	hv_drm_cursor_hide(to_hv_drm(plane->dev));
> +}
> +
> +static const struct drm_plane_helper_funcs hv_drm_cursor_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_check = hv_drm_cursor_atomic_check,
> +	.atomic_update = hv_drm_cursor_atomic_update,
> +	.atomic_disable = hv_drm_cursor_atomic_disable,
> +};
> +
>  static const struct drm_encoder_funcs hv_drm_simple_encoder_funcs_cleanup = {
>  	.destroy = drm_encoder_cleanup,
>  };
> @@ -250,6 +397,7 @@ static inline int hv_drm_pipe_init(struct hv_drm_device *hv)
>  	struct drm_device *dev = &hv->dev;
>  	struct drm_encoder *encoder = &hv->encoder;
>  	struct drm_plane *plane = &hv->plane;
> +	struct drm_plane *cursor = &hv->cursor_plane;
>  	struct drm_crtc *crtc = &hv->crtc;
>  	struct drm_connector *connector = &hv->connector;
>  	int ret;
> @@ -264,7 +412,23 @@ static inline int hv_drm_pipe_init(struct hv_drm_device *hv)
>  	drm_plane_helper_add(plane, &hv_drm_plane_helper_funcs);
>  	drm_plane_enable_fb_damage_clips(plane);
>  
> -	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> +	ret = drm_universal_plane_init(dev, cursor, 0,
> +				       &hv_drm_plane_funcs,
> +				       hv_drm_cursor_formats,
> +				       ARRAY_SIZE(hv_drm_cursor_formats),
> +				       hv_drm_modifiers,
> +				       DRM_PLANE_TYPE_CURSOR, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(cursor, &hv_drm_cursor_helper_funcs);
> +
> +	/* The cursor image reaches the host's clients with straight alpha */
> +	ret = drm_plane_create_blend_mode_property(cursor,
> +						   BIT(DRM_MODE_BLEND_COVERAGE));
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_crtc_init_with_planes(dev, crtc, plane, cursor,
>  					&hv_drm_crtc_funcs, NULL);
>  	if (ret)
>  		return ret;
> @@ -320,6 +484,8 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
>  	dev->mode_config.min_height = 0;
>  	dev->mode_config.max_width = hv->screen_width_max;
>  	dev->mode_config.max_height = hv->screen_height_max;
> +	dev->mode_config.cursor_width = SYNTHVID_CURSOR_MAX_X;
> +	dev->mode_config.cursor_height = SYNTHVID_CURSOR_MAX_Y;
>  
>  	dev->mode_config.preferred_depth = hv->screen_depth;
>  	dev->mode_config.prefer_shadow = 0;
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 8ddd34833941..0f3e64fc73ac 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/hyperv.h>
>  
> +#include <drm/drm_managed.h>
>  #include <drm/drm_print.h>
>  
>  #include "hyperv_drm.h"
> @@ -111,12 +112,9 @@ struct synthvid_pointer_position {
>  	s32 image_y;
>  } __packed;
>  
> -#define SYNTHVID_CURSOR_MAX_X 96
> -#define SYNTHVID_CURSOR_MAX_Y 96
> -#define SYNTHVID_CURSOR_ARGB_PIXEL_SIZE 4
> -#define SYNTHVID_CURSOR_MAX_SIZE (SYNTHVID_CURSOR_MAX_X * \
> -	SYNTHVID_CURSOR_MAX_Y * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE)
>  #define SYNTHVID_CURSOR_COMPLETE (-1)
> +/* Most pixel data the host accepts in one pointer shape message */
> +#define SYNTHVID_CURSOR_MAX_PAYLOAD 8192
>  
>  struct synthvid_pointer_shape {
>  	u8 part_idx;
> @@ -286,47 +284,163 @@ int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>  }
>  
>  /*
> - * Hyper-V supports a hardware cursor feature. It's not used by Linux VM,
> - * but the Hyper-V host still draws a point as an extra mouse pointer,
> - * which is unwanted, especially when Xorg is running.
> - *
> - * Hide the unwanted pointer, by setting msg.ptr_pos.is_visible = 1 and setting
> - * the msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
> - * work in tests.
> - *
> - * The hv_drm_hide_hw_ptr() is also called in the handler of the
> - * SYNTHVID_FEATURE_CHANGE event, otherwise the host still draws an extra
> - * unwanted mouse pointer after the VM Connection window is closed and reopened.
> + * The host always shows a mouse pointer: the one set with the pointer shape
> + * and position messages, or else a small dot, which is also what it shows
> + * for a pointer marked invisible. A hidden cursor is therefore a single,
> + * almost transparent pixel.
>   */
> -int hv_drm_hide_hw_ptr(struct hv_device *hdev)
> +static const u8 hv_drm_cursor_hidden_pixel[SYNTHVID_CURSOR_ARGB_PIXEL_SIZE] = {
> +	0x00, 0x01, 0x01, 0x01
> +};
> +
> +void hv_drm_cursor_set_hidden(struct hv_drm_cursor *cursor)
>  {
> -	struct synthvid_msg msg;
> +	memcpy(cursor->image, hv_drm_cursor_hidden_pixel,
> +	       sizeof(hv_drm_cursor_hidden_pixel));
> +	cursor->width = 1;
> +	cursor->height = 1;
> +	cursor->hot_x = 0;
> +	cursor->hot_y = 0;
> +	cursor->x = 0;
> +	cursor->y = 0;
> +}
>  
> -	memset(&msg, 0, sizeof(struct synthvid_msg));
> -	msg.vid_hdr.type = SYNTHVID_POINTER_POSITION;
> -	msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> +/*
> + * Pointer shapes too large for one message are sent in parts numbered from
> + * 0, with SYNTHVID_CURSOR_COMPLETE marking the last part. A shape that fits
> + * in one message is sent as a lone SYNTHVID_CURSOR_COMPLETE part.
> + */
> +static int hv_drm_send_ptr_shape(struct hv_drm_device *hv, u32 width,
> +				 u32 height, u32 hot_x, u32 hot_y,
> +				 const u8 *image)
> +{
> +	const size_t data_offset = offsetof(struct synthvid_msg,
> +					    ptr_shape.data);
> +	size_t size = width * height * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE;
> +	u8 *buf = hv->cursor->msg_buf;
> +	struct synthvid_msg *msg;
> +	size_t offset = 0;
> +	u8 part = 0;
> +	size_t len;
> +	int ret;
> +
> +	BUILD_BUG_ON((offsetof(struct synthvid_msg, ptr_shape.data) +
> +		     SYNTHVID_CURSOR_MAX_PAYLOAD) >
> +		     sizeof_field(struct hv_drm_cursor, msg_buf));
> +
> +	msg = (struct synthvid_msg *)buf;
> +
> +	do {
> +		len = min(size - offset, SYNTHVID_CURSOR_MAX_PAYLOAD);
> +
> +		memset(buf, 0, data_offset);
> +		msg->vid_hdr.type = SYNTHVID_POINTER_SHAPE;
> +		msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> +			offsetof(struct synthvid_pointer_shape, data) + len;
> +		if (offset + len < size)
> +			msg->ptr_shape.part_idx = part++;
> +		else
> +			msg->ptr_shape.part_idx = SYNTHVID_CURSOR_COMPLETE;
> +		msg->ptr_shape.is_argb = 1;
> +		msg->ptr_shape.width = width;
> +		msg->ptr_shape.height = height;
> +		msg->ptr_shape.hot_x = hot_x;
> +		msg->ptr_shape.hot_y = hot_y;
> +		memcpy(buf + data_offset, image + offset, len);
> +
> +		ret = hv_drm_sendpacket(hv->hdev, msg);
> +		if (ret)
> +			return ret;
> +
> +		offset += len;
> +	} while (offset < size);
> +
> +	return 0;
> +}
> +
> +static int hv_drm_send_ptr_position(struct hv_drm_device *hv, s32 x, s32 y)
> +{
> +	struct synthvid_msg *msg = (struct synthvid_msg *)hv->cursor->msg_buf;
> +
> +	memset(msg, 0, sizeof(struct synthvid_msg));
> +	msg->vid_hdr.type = SYNTHVID_POINTER_POSITION;
> +	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_pointer_position);
> -	msg.ptr_pos.is_visible = 1;
> -	msg.ptr_pos.video_output = 0;
> -	msg.ptr_pos.image_x = 0;
> -	msg.ptr_pos.image_y = 0;
> -	hv_drm_sendpacket(hdev, &msg);
> +	msg->ptr_pos.is_visible = 1;
> +	msg->ptr_pos.video_output = 0;
> +	msg->ptr_pos.image_x = x;
> +	msg->ptr_pos.image_y = y;
>  
> -	memset(&msg, 0, sizeof(struct synthvid_msg));
> -	msg.vid_hdr.type = SYNTHVID_POINTER_SHAPE;
> -	msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> -		sizeof(struct synthvid_pointer_shape);
> -	msg.ptr_shape.part_idx = SYNTHVID_CURSOR_COMPLETE;
> -	msg.ptr_shape.is_argb = 1;
> -	msg.ptr_shape.width = 1;
> -	msg.ptr_shape.height = 1;
> -	msg.ptr_shape.hot_x = 0;
> -	msg.ptr_shape.hot_y = 0;
> -	msg.ptr_shape.data[0] = 0;
> -	msg.ptr_shape.data[1] = 1;
> -	msg.ptr_shape.data[2] = 1;
> -	msg.ptr_shape.data[3] = 1;
> -	hv_drm_sendpacket(hdev, &msg);
> +	return hv_drm_sendpacket(hv->hdev, msg);
> +}
> +
> +/*
> + * Send the cached cursor to the host: the shape if @shape is set or the host
> + * may lack it, then the position. The position goes last as the host applies
> + * the hotspot of its current shape to it.
> + */
> +void hv_drm_update_cursor(struct hv_drm_device *hv, bool shape)
> +{
> +	struct hv_drm_cursor *cursor = hv->cursor;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&cursor->lock);
> +
> +	if (shape || cursor->shape_stale) {
> +		/*
> +		 * The host may still be waiting for the rest of a multi-part
> +		 * shape, and rejects new shapes until it gets a final part.
> +		 * A one pixel shape completes any such shape, and is a valid
> +		 * shape of its own otherwise.
> +		 */
> +		if (cursor->shape_stale)
> +			ret = hv_drm_send_ptr_shape(hv, 1, 1, 0, 0,
> +						    hv_drm_cursor_hidden_pixel);
> +		if (!ret)
> +			ret = hv_drm_send_ptr_shape(hv, cursor->width,
> +						    cursor->height,
> +						    cursor->hot_x,
> +						    cursor->hot_y,
> +						    cursor->image);
> +		cursor->shape_stale = ret;
> +	}
> +
> +	hv_drm_send_ptr_position(hv, cursor->x, cursor->y);
> +}
> +
> +void hv_drm_restore_cursor(struct hv_drm_device *hv)
> +{
> +	scoped_guard(mutex, &hv->cursor->lock)
> +		hv_drm_update_cursor(hv, true);
> +}
> +
> +static void hv_drm_restore_cursor_work(struct work_struct *work)
> +{
> +	struct hv_drm_device *hv = container_of(work, struct hv_drm_device,
> +						cursor_work);
> +
> +	hv_drm_restore_cursor(hv);
> +}
> +
> +int hv_drm_cursor_init(struct hv_drm_device *hv)
> +{
> +	struct hv_drm_cursor *cursor;
> +	int ret;
> +
> +	cursor = drmm_kzalloc(&hv->dev, sizeof(*cursor), GFP_KERNEL);
> +	if (!cursor)
> +		return -ENOMEM;
> +
> +	ret = drmm_mutex_init(&hv->dev, &cursor->lock);
> +	if (ret)
> +		return ret;
> +
> +	hv_drm_cursor_set_hidden(cursor);
> +	cursor->shape_stale = true;
> +	hv->cursor = cursor;
> +
> +	INIT_WORK(&hv->cursor_work, hv_drm_restore_cursor_work);
> +	disable_work(&hv->cursor_work);
>  
>  	return 0;
>  }
> @@ -474,7 +588,7 @@ static void hv_drm_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  		}
>  		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
>  		if (hv->dirt_needed)
> -			hv_drm_hide_hw_ptr(hv->hdev);
> +			schedule_work(&hv->cursor_work);
>  		return;
>  	default:
>  		return;
> @@ -538,9 +652,11 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
>  	struct drm_device *dev = &hv->dev;
>  	int ret;
>  
> +	enable_work(&hv->cursor_work);
>  	ret = vmbus_open(hdev->channel, VMBUS_RING_BUFSIZE, VMBUS_RING_BUFSIZE,
>  			 NULL, 0, hv_drm_receive, hdev);
>  	if (ret) {
> +		disable_work_sync(&hv->cursor_work);
>  		drm_err(dev, "Unable to open vmbus channel\n");
>  		return ret;
>  	}
> @@ -574,6 +690,15 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
>  	return 0;
>  
>  error:
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>  	return ret;
>  }
> +
> +void hv_drm_disconnect_vsp(struct hv_device *hdev)
> +{
> +	struct hv_drm_device *hv = hv_get_drvdata(hdev);
> +
> +	/* Stop the work before vmbus_close() frees the ring buffers */
> +	disable_work_sync(&hv->cursor_work);
> +	vmbus_close(hdev->channel);
> +}
> -- 
> 2.56.0
