Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503932;
	b=KBJpLw5oIruvqZ0olHHtfov1d2foWv8jkBLrA64qctD3jnkQm/rEmCfFebcAv7vzZXEp
	 aT6S2t+O9UbO5qp1SYJIG099fwI+fcs3F16RbIUb7vNK2ds2RovrTdHIWaoOAsUHxx6JC
	 hJcukwo3JJMqn0iIvRRqtisfrD6VEvc6HSclvaY5GE9kHj4V0T/YoxIH0JhaQAr0VxtBR
	 1dMCB5QnLRrupY71syInN9ggri+Gx30nysh3U1NC+TGpK1+e1Bp5fYMkgujGrwn0+3hZT
	 mfaPrcExzODp2682qD/dg53+TAVtcmLiegeCHa5tT5SUUGrZhRar1jrKFuaJiNn4zUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503932;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=q+k+l+KwIvo8WwGh1xBJrAI8OIfqohYpVA1bVMl9nBU=;
	b=rBKEG6/lye0mbJq1fjSVtlzXwmTd+VwxpP8v9afwySUe3Pt1L/veIkhtpPNJd/w62ikj
	 rA7kH2yZQ8mQ3K+pTbMU/BUWYdjPIHHuU+MbYmpHuZO3TsUDaNV8kM1EXuiaKCtm8xiXt
	 Gt5SavvUHM7BwjWZsg+ob2d9cwy5QhXsRTuIiICRzibzvgP+f/aZ/J8RttSW7pNm1F0pv
	 Ou18+KR330Kxhkx5iQqoMeahZLWFr7K4+JdJLZZvvOImuFGcm4oZozdKU2YeshPxzbNsn
	 0gCHo8jPYUgntA7vDrtR/HtxCfv4hXrbPdh0b+5aWuVSZWh1Pfn3Ti2jAi0zbyKnAAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHpWiiNK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HbccXt6u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHpWiiNK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HbccXt6u;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B017606F442
	for <linux-hyperv@vger.kernel.org>; Tue, 20 Oct 2026 13:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B017606F442
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHpWiiNK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HbccXt6u;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FHpWiiNK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HbccXt6u
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EF8D21D9B;
	Tue, 20 Oct 2026 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792503930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+k+l+KwIvo8WwGh1xBJrAI8OIfqohYpVA1bVMl9nBU=;
	b=FHpWiiNK77MC+qDOPPqHez1vXeUAOUrPnCg3Ia8Uj0mCH/8fTZKgJro8EZb1Vwfno8FvrW
	mQj9MFg2m/QOQghpLADt3zq/eR9axwDILC3Vil2gXZYb6DIUZm3MtxhOiF99WZj4KHtwX+
	1pdsiW8SV0yWCeqJjd927HEz3oDaRC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792503930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+k+l+KwIvo8WwGh1xBJrAI8OIfqohYpVA1bVMl9nBU=;
	b=HbccXt6uIHta5y9dv6sWAZ75G1mgdv7S7KfdQbPFwCVbPjoNwYRyDOIX10ioTbzCRhU/zv
	eP42enqrXM0bpfCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792503930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+k+l+KwIvo8WwGh1xBJrAI8OIfqohYpVA1bVMl9nBU=;
	b=FHpWiiNK77MC+qDOPPqHez1vXeUAOUrPnCg3Ia8Uj0mCH/8fTZKgJro8EZb1Vwfno8FvrW
	mQj9MFg2m/QOQghpLADt3zq/eR9axwDILC3Vil2gXZYb6DIUZm3MtxhOiF99WZj4KHtwX+
	1pdsiW8SV0yWCeqJjd927HEz3oDaRC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792503930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+k+l+KwIvo8WwGh1xBJrAI8OIfqohYpVA1bVMl9nBU=;
	b=HbccXt6uIHta5y9dv6sWAZ75G1mgdv7S7KfdQbPFwCVbPjoNwYRyDOIX10ioTbzCRhU/zv
	eP42enqrXM0bpfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE7F136C6;
	Tue, 20 Oct 2026 13:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vTngGHlw12rlEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 20 Oct 2026 13:45:29 +0000
Message-ID: <977e3d5c-0c54-49a2-8797-6053d341be1a@suse.de>
Date: Tue, 20 Oct 2026 15:45:29 +0200
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
Subject: Re: [PATCH 24/75] drm/hyperv: Switch to
 drm_atomic_helper_connector_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
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
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:email]
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO



Am 14.10.26 um 19:26 schrieb Maxime Ripard:
> The hyperv connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 523d1c7ea072..da399cb951a5 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
>   };
>   
>   static const struct drm_connector_funcs hv_drm_connector_funcs = {
>   	.fill_modes = drm_helper_probe_single_connector_modes,
>   	.destroy = drm_connector_cleanup,
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
>   static inline int hv_drm_conn_init(struct hv_drm_device *hv)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


