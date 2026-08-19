Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614763D45FA
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130180; cv=none; b=C9hcm5VXC3vB1NBWAl4FeoJoyuRAvb1LPe78CJtFsuPKIn7Wt/y7jR0qaDSk05ZwHu1ph/8iWfjLqhCEIfSpkFmVt1IAZO7vIGGaoSLwO59zWAfiJnL41Wzt7aqkR9VwTWZR+ZWHqNL7Qz26ThcX2ENqkHmhI2IYwDfMO+uksbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130180; c=relaxed/simple;
	bh=LqwDv65ukW0pZ/l4HMlI0o35+RIxlNikoEbgozCev8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg8GtJTQusq9g92oWfvcNPFfKa5YbOKhhUAw3PDIiV2dBHEcsd1jl+a/SPWhWbnw3KVl96VtUfEN0eh1/JhLx9DtIS2AIb0EF7jcknYdrG5VuuEnYeJ1Fc8+IC1bqESiD2c028paU9K39yxBUsSfcmcr3vy8LVb6tUtSvs+sT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e/GaAJJl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBCXYqmL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y07gBOrv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TKspYuzE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/GaAJJl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBCXYqmL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y07gBOrv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TKspYuzE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4440884A46;
	Wed, 19 Aug 2026 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787130167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I2kdm9/KB4f0uakkMYi5OaEfL3aR00uc57x10GnpoMo=;
	b=e/GaAJJl9rKMTEZgRRdA72r2zB5/k6n0oVYabEgQgrLbC0A9zTL0NTI+iB3DMjviafq9UI
	W078KGzQ44wIVLRNhlrsvThPtYrtm9F5aCMBTCAqLbyum5jMNlVhvEMcFPTLF8VzwYt+lh
	sQdiCjfU5p1IpnoFVUbRIsI86OWUIXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787130167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I2kdm9/KB4f0uakkMYi5OaEfL3aR00uc57x10GnpoMo=;
	b=PBCXYqmL+PpD0kP9dfdrg0qOa3wodnJNbfowwlEVEVZWiEc9+LRgbnaXUN/ApgfdsWEtls
	VFHgXArZtMLMtICA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787130163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I2kdm9/KB4f0uakkMYi5OaEfL3aR00uc57x10GnpoMo=;
	b=y07gBOrvzogxVxJ4+dnEhH6yUnqrcM9IsfOEo9m7Q6xvIsE8I4/SG+72+Mh+zDwI8tB/bd
	xs86vrV1uXIkkdL5dIcbwzcETXEDEnsCLtwGpc9+vakX7BN8TbGVsuKuaVP77As885lYEK
	p9Kc1gqR1F4gBkG5xuVZcSBN7T/8CKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787130163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I2kdm9/KB4f0uakkMYi5OaEfL3aR00uc57x10GnpoMo=;
	b=TKspYuzEzY14ZdjPaUtFZPDk99lFK+oADgXA5poKvzKjhPNvScITARf6NU4E8NZBPfsxIx
	XfpHdYc8xAOU/LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09DE577A30;
	Wed, 19 Aug 2026 09:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TtX+ADNxhWr2FgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Aug 2026 09:02:43 +0000
Message-ID: <2011cebd-7e7e-4087-a445-fb2579861ef6@suse.de>
Date: Wed, 19 Aug 2026 11:02:42 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] drm/panic: Display panic screen via per-plane
 callback
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Frank.Li@kernel.org, linux-hyperv@vger.kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-10-tzimmermann@suse.de>
 <20260818131951.154171F000E9@smtp.kernel.org>
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
In-Reply-To: <20260818131951.154171F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 



Am 18.08.26 um 15:19 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The `drm_plane_helper_display_panic_screen` helper unconditionally dereferences `plane->helper_private` and `plane->helper_private->get_scanout_buffer`. However, by adding `DRM_PANIC_PLANE_FUNCS` to shared plane function tables (like `skl_plane_funcs` in i915 and `dm_plane_funcs` in amdgpu), the `display_panic_screen` callback is now applied to all planes (including cursors and overlays). These non-primary planes use different helper functions (e.g., `intel_plane_helper_funcs` or `dm_plane_helper_funcs`) that do not implement `get_scanout_buffer`. This causes `drm_panic_register` to mistakenly register panic dumpers for these planes, and upon a panic, the handler executes a NULL pointer dereference, triggering a nested panic.

Will be fixed by testing for get_scanout_buffer from 
drm_plane_helper_display_panic_screen().  I'll also add a check to only 
register panic screens for primary planes.

> - [Medium] The patch replaces `get_scanout_buffer` with `display_panic_screen` as the signal for panic support. However, it fails to add `DRM_PANIC_PLANE_FUNCS` to the legacy fallback `primary_plane_funcs` in `drm_modeset_helper.c`. Older AMDGPU DCE drivers (e.g., DCE 6.0, 8.0, 10.0) use `drm_crtc_init()` which implicitly relies on this legacy structure for their primary planes. Although these drivers implement `get_scanout_buffer` in their helper functions (`dce_v10_0_drm_primary_plane_helper_funcs`), their planes now lack the `display_panic_screen` callback. Consequently, `drm_panic_is_enabled()` returns false and their panic dumpers are never registered, silently breaking panic screen support on these hardware generations.

Will be added.


> - [Low] `drm_plane_helper_display_panic_screen` accepts a `panic_type` parameter (an `enum drm_panic_type`). However, when it calls `draw_panic_dispatch()`, it passes the global module parameter `drm_panic_type` instead of the passed-in `panic_type`. This logic bug prevents drivers from tailoring the panic screen implementation via the helper as intended.

Fixed in an earlier patch.


> --
>
> --- Patch [9]: [PATCH 09/12] drm/panic: Display panic screen via per-plane callback ---
> commit 69fa8c39afc844867e193df3659c6f6f1fb762f3
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/panic: Display panic screen via per-plane callback
>
> This commit adds display_panic_screen to struct drm_plane_funcs to replace
> get_scanout_buffer as the signal for panic support. It provides the helper
> drm_plane_helper_display_panic_screen() and the DRM_PANIC_PLANE_FUNCS macro
> to update drivers that implement panic support.
>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 824ef3ce5de0a..eadc22a255bb5 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> [ ... ]
>> @@ -2177,6 +2178,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
>>   	.atomic_set_property = dm_atomic_plane_set_property,
>>   	.atomic_get_property = dm_atomic_plane_get_property,
>>   #endif
>> +	DRM_PANIC_PLANE_FUNCS,
>>   };
> [Severity: High]
> Does adding this macro to shared plane function tables (like dm_plane_funcs
> or skl_plane_funcs) apply the panic screen callback to all planes, including
> cursors and overlays?
>
> Non-primary planes use different helper functions that do not implement
> get_scanout_buffer. Since drm_plane_helper_display_panic_screen()
> unconditionally dereferences plane->helper_private->get_scanout_buffer,
> could this cause a NULL pointer dereference in the panic handler for these
> planes and trigger a nested panic?
>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index 2263a11efdf63..2ecb4d1f6d470 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
> [ ... ]
>> +void drm_plane_helper_display_panic_screen(struct drm_plane *plane, const char *description,
>> +					   enum drm_panic_type panic_type,
>> +					   u32 fg_color, u32 bg_color, unsigned int qr_version)
>>   {
>>   	struct drm_scanout_buffer sb = { };
>>   	int ret;
> [Severity: Low]
> Is the panic_type parameter correctly passed to the dispatch function?
>
> The function accepts a panic_type argument, but the implementation appears
> to pass the global module parameter drm_panic_type to draw_panic_dispatch()
> instead of the passed-in argument. Does this discard the caller's requested
> panic type?
>
>> diff --git a/include/drm/drm_panic_helper.h b/include/drm/drm_panic_helper.h
>> new file mode 100644
>> index 0000000000000..e296620bbe34b
>> --- /dev/null
>> +++ b/include/drm/drm_panic_helper.h
> [ ... ]
>> +#if IS_ENABLED(CONFIG_DRM_PANIC)
>> +#define DRM_PANIC_PLANE_FUNCS \
>> +	.display_panic_screen = drm_plane_helper_display_panic_screen
>> +#else
>> +#define DRM_PANIC_PLANE_FUNCS \
>> +	.display_panic_screen = NULL
>> +#endif
> [Severity: Medium]
> Does the legacy fallback primary_plane_funcs in drm_modeset_helper.c also
> need to be updated with DRM_PANIC_PLANE_FUNCS?
>
> Older AMDGPU DCE drivers use drm_crtc_init(), which implicitly relies on
> this legacy structure for their primary planes. Although these drivers
> implement get_scanout_buffer() in their helper functions, lacking this
> macro in the fallback could cause drm_panic_is_enabled() to return false
> and silently drop panic screen support on these hardware generations.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


