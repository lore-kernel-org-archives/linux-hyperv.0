Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427577;
	b=0cd523z7eawCZrdM8V3xvuXQ414+kE+kCOym7j/z9TC0G2XqPTAZI+1FjsgYkIXo5Wbx
	 x0HVfxDkXtWduDjnSaZxWvl9OU8YT5QfLHQWQEs/chAwwQAWZ41dedW3RvfCJQuflpDVx
	 bVWIR6aMwMHQYrB2qr9RuzpJVTYdHHGBP8k8pxY9b18BL90zcVlNCZr+f7OexXJJ2A4IS
	 +C8H7fPettRTYINFVgHEZJ4fGEuXOi33MswoZRd5wtlIwYaBnXPy4DvFq2CISMoFCgDwz
	 EubQv6gaiNjU6wDp95hrPZgOwG2ywDEyyK2NFtcCxAeysrLgIt4YTIxgsRQ4fh4I4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427577;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Rspamd-Action:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Flag:X-Spam-Score;
	bh=oxmu7stfRu9F1nID7OH4tHkwJ+6MmriNypobbE12Aic=;
	b=JcpuNj/x/81WBfNzKqDvvSpYhymSO2QyLXsLCID/D+YH43OmaqGilGeReki9ed8bW8bv
	 kkVBUgrsJuSub5lBRk+LLbGG/G67WXbHdC37LJhpnOLzQMu+1GIFwDojGTefMVSm0MEyl
	 tCkdTR4OCkZEI6UeprSH0dPbm2nU2FC0+6WjZ6vz4dNMhST115gXBLAOjJdapYcw1i4Cc
	 Ruq8BctCLNWE96dIaO+TkJW6s7f7n6gTeH4sgi0/BCxuPE0iOS64mL2V39CA+81JvAdR1
	 yvCS5HdPVV+R2cdwvYq/bstIyQSEide4vrwHJPQ+xvSN+ROsJOc0CDXgA427/9ORO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IEv18a17;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NU20AtNF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IEv18a17;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NU20AtNF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467C606A31D
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 16:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1467C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IEv18a17;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NU20AtNF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IEv18a17;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NU20AtNF
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D74621C20;
	Mon, 19 Oct 2026 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792427575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxmu7stfRu9F1nID7OH4tHkwJ+6MmriNypobbE12Aic=;
	b=IEv18a17/3KJqDEtJ4FSngYTj3bf77WTh8T024FZIz0miCpeCU+wv57ptKwXXXzv+Xa2Qn
	TtUOhpJlroYh8l0L7EsEKcIZ0F3ELqDVtiXZC645yTmY+15wxeN7pHgzXKsXAg+TPoKTHQ
	qUs/dAnYDNCqL7W7OCMOtqd0gN2y6EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792427575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxmu7stfRu9F1nID7OH4tHkwJ+6MmriNypobbE12Aic=;
	b=NU20AtNFudFpqxSUTQa8t9OuCNcdTvtxiTDvY4aTGYQpH1p6G2pz7ZZfnnL/Q4FECZyCE/
	FOoB0oqNSxbQHlBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IEv18a17;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NU20AtNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792427575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxmu7stfRu9F1nID7OH4tHkwJ+6MmriNypobbE12Aic=;
	b=IEv18a17/3KJqDEtJ4FSngYTj3bf77WTh8T024FZIz0miCpeCU+wv57ptKwXXXzv+Xa2Qn
	TtUOhpJlroYh8l0L7EsEKcIZ0F3ELqDVtiXZC645yTmY+15wxeN7pHgzXKsXAg+TPoKTHQ
	qUs/dAnYDNCqL7W7OCMOtqd0gN2y6EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792427575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oxmu7stfRu9F1nID7OH4tHkwJ+6MmriNypobbE12Aic=;
	b=NU20AtNFudFpqxSUTQa8t9OuCNcdTvtxiTDvY4aTGYQpH1p6G2pz7ZZfnnL/Q4FECZyCE/
	FOoB0oqNSxbQHlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0194E136CC;
	Mon, 19 Oct 2026 16:32:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VkahMjZG1morbQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 16:32:54 +0000
Message-ID: <4deb710d-ef64-4592-833d-ad1b84d715be@suse.de>
Date: Mon, 19 Oct 2026 18:32:54 +0200
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
Subject: Re: [PATCH 3/4] drm/pixel: Link panic helpers into
 drm_pixel_helper.ko
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, imx@lists.linux.dev,
 virtualization@lists.linux.dev, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez <eperezma@redhat.com>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-4-tzimmermann@suse.de>
 <sashiko-outbox-177862@kernel.org>
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
In-Reply-To: <sashiko-outbox-177862@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D74621C20
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -3.00



Am 19.10.26 um 18:19 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Low] drm: missing DRM_PIXEL_HELPER select in DRM_KMS_HELPER for drm_crtc_init()

I see this is still an issue. The fix here is to move drm_crtc_init() 
into drivers. The only remaining callers of drm_crtc_init() are in 
radeon and amdgpu. There was recently a patch to move the helper there, 
[1] but the effort appears to have stalled.

[1] 
https://lore.kernel.org/dri-devel/20260903071409.427010-1-oushixiong1025@163.com/

I'll do this before continuing with the pixel helpers.


> - [Low] drm/tests: link failure in drm_panic_helper_test when CONFIG_DRM_PANIC=n
> - [Low] drm/xe: missing DRM_PIXEL_HELPER dependency when DRM_PANIC=y
> --
>
> commit d010f0f67d242682650aa0651dfd5a1e57612943
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/pixel: Link panic helpers into drm_pixel_helper.ko
>
> This commit moves the DRM panic helpers from drm_kms_helper into
> drm_pixel_helper.ko, drops the DRM_PANIC_HELPER Kconfig option, and
> selects DRM_PIXEL_HELPER in drivers using the panic helpers.
>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 8e4a588e9111d..bf7c599443403 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -46,13 +46,14 @@ config DRM_MIPI_DSI
>>   config DRM_KMS_HELPER
>>   	tristate
>>   	depends on DRM
>> -	select DRM_PANIC_HELPER if DRM_PANIC
>>   	help
>>   	  CRTC helpers for KMS drivers.
> [Severity: Low]
> Does DRM_KMS_HELPER also need to select DRM_PIXEL_HELPER if DRM_PANIC?
>
> drivers/gpu/drm/drm_modeset_helper.c is unconditionally compiled into
> drm_kms_helper, and its primary_plane_funcs structure (used by
> drm_crtc_init()) includes DRM_PANIC_PLANE_FUNCS:
>
> drivers/gpu/drm/drm_modeset_helper.c:
>      static const struct drm_plane_funcs primary_plane_funcs = {
>              DRM_PLANE_NON_ATOMIC_FUNCS,
>              DRM_PANIC_PLANE_FUNCS,
>      };
>
> When CONFIG_DRM_PANIC is enabled, DRM_PANIC_PLANE_FUNCS expands in
> include/drm/drm_panic_helper.h to reference
> drm_plane_helper_display_panic_screen, which is now built into
> drm_pixel_helper. If CONFIG_DRM_PANIC=y and DRM_KMS_HELPER is enabled
> without a matching built-in or modular DRM_PIXEL_HELPER, linking fails
> with an undefined reference to drm_plane_helper_display_panic_screen.
>
> [ ... ]
>
>> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
>> index 1afb9cad850f6..4573cad368a28 100644
>> --- a/drivers/gpu/drm/Kconfig.debug
>> +++ b/drivers/gpu/drm/Kconfig.debug
>> @@ -69,7 +69,6 @@ config DRM_KUNIT_TEST
>>   	select DRM_EXPORT_FOR_TESTS if m
>>   	select DRM_GEM_SHMEM_HELPER
>>   	select DRM_KUNIT_TEST_HELPERS
>> -	select DRM_PANIC_HELPER
>>   	select DRM_PIXEL_HELPER
>>   	select DRM_SYSFB_HELPER
>>   	select PRIME_NUMBERS
> [Severity: Low]
> Can removing select DRM_PANIC_HELPER from DRM_KUNIT_TEST cause a link
> failure when CONFIG_DRM_PANIC is disabled?
>
> With this change, drm_panic_helper.o is only built into drm_pixel_helper
> when CONFIG_DRM_PANIC is enabled:
>
> drivers/gpu/drm/Makefile:
>      drm_pixel_helper-$(CONFIG_DRM_PANIC) += drm_panic_helper.o
>
> However, drivers/gpu/drm/tests/Makefile still builds
> drm_panic_helper_test.o unconditionally under obj-$(CONFIG_DRM_KUNIT_TEST),
> and functions such as drm_panic_helper_draw_screen_user_default() in
> drivers/gpu/drm/tests/drm_panic_helper_test.c call
> drm_panic_helper_draw_screen_user(), drm_panic_helper_draw_screen_kmsg(),
> drm_panic_helper_set_description(), and
> drm_panic_helper_clear_description(). When CONFIG_DRM_KUNIT_TEST is enabled
> and CONFIG_DRM_PANIC=n, linking fails with undefined references to those
> symbols.
>
> [ ... ]
>
>> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
>> index 71426b9c91f00..f698d3c8daa9e 100644
>> --- a/drivers/gpu/drm/i915/Kconfig
>> +++ b/drivers/gpu/drm/i915/Kconfig
>> @@ -19,6 +19,7 @@ config DRM_I915
>>   	select DRM_KMS_HELPER
>>   	select DRM_PANEL
>>   	select DRM_MIPI_DSI
>> +	select DRM_PIXEL_HELPER if DRM_PANIC
>>   	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
>>   	select RELAY
>>   	select I2C
> [Severity: Low]
> Should DRM_XE or DRM_XE_DISPLAY in drivers/gpu/drm/xe/Kconfig also select
> DRM_PIXEL_HELPER if DRM_PANIC?
>
> When CONFIG_DRM_XE_DISPLAY=y, drivers/gpu/drm/xe/Makefile compiles
> drivers/gpu/drm/i915/display/skl_universal_plane.c into xe.ko, where
> skl_plane_funcs, icl_plane_funcs, and tgl_plane_funcs use
> DRM_PANIC_PLANE_FUNCS:
>
> drivers/gpu/drm/i915/display/skl_universal_plane.c:
>      static const struct drm_plane_funcs skl_plane_funcs = {
>              ...
>              DRM_PANIC_PLANE_FUNCS,
>      };
>
> If CONFIG_DRM_XE=m, CONFIG_DRM_XE_DISPLAY=y, and CONFIG_DRM_PANIC=y are
> enabled while CONFIG_DRM_PIXEL_HELPER=n, modpost fails with an undefined
> reference to drm_plane_helper_display_panic_screen in xe.ko.
>
> [ ... ]
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


