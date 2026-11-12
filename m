Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477127;
	b=YWoZHc+hMVmwzkmygNu1z1EBoH7R0rotEWdAMu8qKEg3J1Mq7/6SMeGrBTv3x16/RoHz
	 b7JlNj2YLVB+PNQDq9IhU7ccp0NKYH94IaC8fj6pbJbxQqXbQLlXI7sNFjj4IPBfAb9Lb
	 mz4kiwEUkLnRRXmGxYtAnAbh1E2btCw4n6KstqzGejr8bVM6PvJXhUdjBNnn8ApCqrLFY
	 bQ8+SIFl45S+b5QZr8F3h7+upWeI7dn094Si6XwEOQDzikw0WgTACobEiNu+s+oy2VL0u
	 FbKT3Es30IQgNbwtsyF3r4lBGGDjbNIbknkTMKWEHS4WS2gjbS13mHRfhWvO5RQdQmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477127;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=HiYeYVFg1R1B3XVllf4oujoWxuk5zb+H9zujL0c4y2k=;
	b=yJ96oLRcQkY1NtuD1dr8xGBl65LeW1x/+HesJKYBR0TSmqI/JSFrgwgutmgPfd/758VJ
	 08NKmpdwEJYvgvEeBA0mZT1BS0M5tGWEcGBTQ0u/APKayJbHmkkzJfO1YOnrmI17m1vMe
	 sNPqQxr1nBmB58sGq9YfSvDYFS4eefsEpC0RzgQTaJbIx9rF2LHZwF1zFkCIwkIU6SdNr
	 cqKI2FPrYdDwf0gjVek+4KD+wVfgsXHcxt/bNDXZuoCr/qIJB0BXqqBv6r+PQP0Vkhq8z
	 XavoVpd7ueG0dqGhvRmZZHSfzNlMniZl8hww6dtmw/OWMkd7RNU79Q04tQk56aJ277A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="JU/fqGKx";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJi+rE8t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pPINMZC4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="qVYx/xVp";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E465606A321
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2026 09:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E465606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JU/fqGKx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XJi+rE8t;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pPINMZC4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qVYx/xVp
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDA71F766;
	Thu, 12 Nov 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794477124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HiYeYVFg1R1B3XVllf4oujoWxuk5zb+H9zujL0c4y2k=;
	b=JU/fqGKxwp2m+leS71la591N6U2cJ+U6PiHjBijbGm1lpM6+bwdbTwUxnbUAOxJ/TBtKLz
	bhzUCPm+1nF9zyDXEaf9CoSSCxawiVoUxu3HVP6yXEQdRG5JNCsNiMlmuERrh8YzL+frZ8
	GPiUgFxXQe4JeU5zHa7aEYpoLGefGg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794477124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HiYeYVFg1R1B3XVllf4oujoWxuk5zb+H9zujL0c4y2k=;
	b=XJi+rE8t9rMkiYsWYUqwi8Va2liRYJ4IzTDpK9X8XLn7dDrhHDXsZi408goPlJgDp3yxiE
	4ZhcO+pOppFIGqDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pPINMZC4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qVYx/xVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794477123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HiYeYVFg1R1B3XVllf4oujoWxuk5zb+H9zujL0c4y2k=;
	b=pPINMZC4KZpMVU9+/gWEDq+dKejzDJj8BJ1Z7jaJXlLf7am+XR6zm6i/Dc3alH0ndNo3zg
	8waB8Eo/GEpQO8W2f+8awjbptuxIjxiCIQYEHJqvoJuw6fen+AWpLT9Ro2rBstwKtNiVpD
	aeL1u9YsD757xSmDGogzLHOtSZ42N4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794477123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HiYeYVFg1R1B3XVllf4oujoWxuk5zb+H9zujL0c4y2k=;
	b=qVYx/xVpspr1bIZRTLsVHPnbZS9bFacsyoGbAPsDBODCbtHFr8L4m7OkLGXYMfABgg3zKN
	ksTrU6aC5OMzoODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 582C6134A0;
	Thu, 12 Nov 2026 09:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M+uhC0KM9WovHwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 12 Nov 2026 09:52:02 +0000
Message-ID: <9a952b79-4f77-4ec1-9bcd-6482b392e0f6@suse.de>
Date: Thu, 12 Nov 2026 10:52:01 +0100
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/hyperv: add cursor plane support
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org
References: <20261111154950.1304813-1-hamzamahfooz@linux.microsoft.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20261111154950.1304813-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ptr_shape.data:url,suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 0BDA71F766



Am 11.11.26 um 16:49 schrieb Hamza Mahfooz:
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
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Looks good now.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2:
> - Test for !plane_state->visible in the cursor's atomic_check().
>    (Thomas)
> - Use drm_dbg() instead of drm_dbg_atomic(). (Thomas)
> - Add a note as to why the hidden cursor pixel's alpha is 1 rather than
>    0. (Thomas)
> - Add a comment to explain why the cursor is sent again from a work
>    item.
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm.h         |  37 +++-
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  13 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 170 ++++++++++++++-
>   drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 217 ++++++++++++++++----
>   4 files changed, 388 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
> index f4262a37a..df03185a2 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> @@ -13,10 +13,38 @@
>   
>   #define VMBUS_MAX_PACKET_SIZE 0x4000
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
>   struct hv_drm_device {
>   	/* drm */
>   	struct drm_device dev;
>   	struct drm_plane plane;
> +	struct drm_plane cursor_plane;
>   	struct drm_crtc crtc;
>   	struct drm_encoder encoder;
>   	struct drm_connector connector;
> @@ -40,6 +68,9 @@ struct hv_drm_device {
>   	u8 init_buf[VMBUS_MAX_PACKET_SIZE];
>   	u8 recv_buf[VMBUS_MAX_PACKET_SIZE];
>   
> +	struct hv_drm_cursor *cursor;
> +	struct work_struct cursor_work;
> +
>   	struct hv_device *hdev;
>   };
>   
> @@ -52,8 +83,12 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv);
>   int hv_drm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
>   int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>   			    u32 w, u32 h, u32 pitch);
> -int hv_drm_hide_hw_ptr(struct hv_device *hdev);
> +int hv_drm_cursor_init(struct hv_drm_device *hv);
> +void hv_drm_cursor_set_hidden(struct hv_drm_cursor *cursor);
> +void hv_drm_update_cursor(struct hv_drm_device *hv, bool shape);
> +void hv_drm_restore_cursor(struct hv_drm_device *hv);
>   int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
>   int hv_drm_connect_vsp(struct hv_device *hdev);
> +void hv_drm_disconnect_vsp(struct hv_device *hdev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 031206a5b..21e5fcc3e 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -26,7 +26,8 @@
>   DEFINE_DRM_GEM_FOPS(hv_drm_fops);
>   
>   static struct drm_driver hv_drm_driver = {
> -	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
> +	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC |
> +			   DRIVER_CURSOR_HOTSPOT,
>   
>   	.name		 = DRIVER_NAME,
>   	.desc		 = DRIVER_DESC,
> @@ -119,6 +120,10 @@ static int hv_drm_vmbus_probe(struct hv_device *hdev,
>   	hv_set_drvdata(hdev, hv);
>   	hv->hdev = hdev;
>   
> +	ret = hv_drm_cursor_init(hv);
> +	if (ret)
> +		goto err_hv_set_drv_data;
> +
>   	ret = hv_drm_connect_vsp(hdev);
>   	if (ret) {
>   		drm_err(dev, "Failed to connect to vmbus.\n");
> @@ -162,7 +167,7 @@ static int hv_drm_vmbus_probe(struct hv_device *hdev,
>   	iounmap(hv->vram);
>   	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>   err_vmbus_close:
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>   err_hv_set_drv_data:
>   	hv_set_drvdata(hdev, NULL);
>   	return ret;
> @@ -176,7 +181,7 @@ static void hv_drm_vmbus_remove(struct hv_device *hdev)
>   	vmbus_set_skip_unload(false);
>   	drm_dev_unplug(dev);
>   	drm_atomic_helper_shutdown(dev);
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>   	hv_set_drvdata(hdev, NULL);
>   
>   	iounmap(hv->vram);
> @@ -197,7 +202,7 @@ static int hv_drm_vmbus_suspend(struct hv_device *hdev)
>   	if (ret)
>   		return ret;
>   
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index da399cb95..759952f4f 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -6,6 +6,7 @@
>   #include <linux/hyperv.h>
>   
>   #include <drm/drm_atomic.h>
> +#include <drm/drm_blend.h>
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_drv.h>
> @@ -110,7 +111,7 @@ static void hv_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   
> -	hv_drm_hide_hw_ptr(hv->hdev);
> +	hv_drm_restore_cursor(hv);
>   	hv_drm_update_situation(hv->hdev, 1,  hv->screen_depth,
>   				crtc_state->mode.hdisplay,
>   				crtc_state->mode.vdisplay,
> @@ -241,6 +242,152 @@ static const struct drm_plane_funcs hv_drm_plane_funcs = {
>   	DRM_PANIC_PLANE_FUNCS,
>   };
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
> +	if (!plane_state->visible)
> +		return 0;
> +
> +	if (plane_state->crtc_w > SYNTHVID_CURSOR_MAX_X ||
> +	    plane_state->crtc_h > SYNTHVID_CURSOR_MAX_Y) {
> +		drm_dbg(plane->dev, "Invalid cursor size %ux%u\n",
> +			plane_state->crtc_w, plane_state->crtc_h);
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
>   static const struct drm_encoder_funcs hv_drm_simple_encoder_funcs_cleanup = {
>   	.destroy = drm_encoder_cleanup,
>   };
> @@ -250,6 +397,7 @@ static inline int hv_drm_pipe_init(struct hv_drm_device *hv)
>   	struct drm_device *dev = &hv->dev;
>   	struct drm_encoder *encoder = &hv->encoder;
>   	struct drm_plane *plane = &hv->plane;
> +	struct drm_plane *cursor = &hv->cursor_plane;
>   	struct drm_crtc *crtc = &hv->crtc;
>   	struct drm_connector *connector = &hv->connector;
>   	int ret;
> @@ -264,7 +412,23 @@ static inline int hv_drm_pipe_init(struct hv_drm_device *hv)
>   	drm_plane_helper_add(plane, &hv_drm_plane_helper_funcs);
>   	drm_plane_enable_fb_damage_clips(plane);
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
>   					&hv_drm_crtc_funcs, NULL);
>   	if (ret)
>   		return ret;
> @@ -320,6 +484,8 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
>   	dev->mode_config.min_height = 0;
>   	dev->mode_config.max_width = hv->screen_width_max;
>   	dev->mode_config.max_height = hv->screen_height_max;
> +	dev->mode_config.cursor_width = SYNTHVID_CURSOR_MAX_X;
> +	dev->mode_config.cursor_height = SYNTHVID_CURSOR_MAX_Y;
>   
>   	dev->mode_config.preferred_depth = hv->screen_depth;
>   	dev->mode_config.prefer_shadow = 0;
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 8ddd34833..99e036576 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/hyperv.h>
>   
> +#include <drm/drm_managed.h>
>   #include <drm/drm_print.h>
>   
>   #include "hyperv_drm.h"
> @@ -111,12 +112,9 @@ struct synthvid_pointer_position {
>   	s32 image_y;
>   } __packed;
>   
> -#define SYNTHVID_CURSOR_MAX_X 96
> -#define SYNTHVID_CURSOR_MAX_Y 96
> -#define SYNTHVID_CURSOR_ARGB_PIXEL_SIZE 4
> -#define SYNTHVID_CURSOR_MAX_SIZE (SYNTHVID_CURSOR_MAX_X * \
> -	SYNTHVID_CURSOR_MAX_Y * SYNTHVID_CURSOR_ARGB_PIXEL_SIZE)
>   #define SYNTHVID_CURSOR_COMPLETE (-1)
> +/* Most pixel data the host accepts in one pointer shape message */
> +#define SYNTHVID_CURSOR_MAX_PAYLOAD 8192
>   
>   struct synthvid_pointer_shape {
>   	u8 part_idx;
> @@ -286,47 +284,166 @@ int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>   }
>   
>   /*
> - * Hyper-V supports a hardware cursor feature. It's not used by Linux VM,
> - * but the Hyper-V host still draws a point as an extra mouse pointer,
> - * which is unwanted, especially when Xorg is running.
> + * The host always shows a mouse pointer: the one set with the pointer shape
> + * and position messages, or else a small dot, which is also what it shows
> + * for a pointer marked invisible. A hidden cursor is therefore a single,
> + * almost transparent pixel.
>    *
> - * Hide the unwanted pointer, by setting msg.ptr_pos.is_visible = 1 and setting
> - * the msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
> - * work in tests.
> - *
> - * The hv_drm_hide_hw_ptr() is also called in the handler of the
> - * SYNTHVID_FEATURE_CHANGE event, otherwise the host still draws an extra
> - * unwanted mouse pointer after the VM Connection window is closed and reopened.
> + * NOTE: Its alpha, the last byte, is 1 rather than 0, as clients may draw an
> + *       image whose alpha values are all 0 as an opaque one.
>    */
> -int hv_drm_hide_hw_ptr(struct hv_device *hdev)
> +static const u8 hv_drm_cursor_hidden_pixel[SYNTHVID_CURSOR_ARGB_PIXEL_SIZE] = {
> +	0x00, 0x01, 0x01, 0x01
> +};
> +
> +void hv_drm_cursor_set_hidden(struct hv_drm_cursor *cursor)
>   {
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
>   		sizeof(struct synthvid_pointer_position);
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
>   	return 0;
>   }
> @@ -473,8 +590,13 @@ static void hv_drm_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>   			return;
>   		}
>   		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
> +		/*
> +		 * Send the cursor to clients that may have just connected, from
> +		 * a work item, as that takes the cursor's mutex and the channel
> +		 * callback runs in atomic context.
> +		 */
>   		if (hv->dirt_needed)
> -			hv_drm_hide_hw_ptr(hv->hdev);
> +			schedule_work(&hv->cursor_work);
>   		return;
>   	default:
>   		return;
> @@ -538,9 +660,11 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
>   	struct drm_device *dev = &hv->dev;
>   	int ret;
>   
> +	enable_work(&hv->cursor_work);
>   	ret = vmbus_open(hdev->channel, VMBUS_RING_BUFSIZE, VMBUS_RING_BUFSIZE,
>   			 NULL, 0, hv_drm_receive, hdev);
>   	if (ret) {
> +		disable_work_sync(&hv->cursor_work);
>   		drm_err(dev, "Unable to open vmbus channel\n");
>   		return ret;
>   	}
> @@ -574,6 +698,15 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
>   	return 0;
>   
>   error:
> -	vmbus_close(hdev->channel);
> +	hv_drm_disconnect_vsp(hdev);
>   	return ret;
>   }
> +
> +void hv_drm_disconnect_vsp(struct hv_device *hdev)
> +{
> +	struct hv_drm_device *hv = hv_get_drvdata(hdev);
> +
> +	/* Stop the work before vmbus_close() frees the ring buffers */
> +	disable_work_sync(&hv->cursor_work);
> +	vmbus_close(hdev->channel);
> +}

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


