Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299C371897
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127606; cv=none; b=XfnKOpec1XkLAOTBryFHfDK88Mm/deu8sqGiMbBZvKQoK+kB2zH5DiCdXtNWGN5aBcfEV/9F1BYKMezjDTWH7BJ1B+/byz27/adtTrdSB+4AFFA19qqril6jqg4M1SVLwe6uj4thg3e23oXt9hYSOMVNNFizEnh8fvqriBfqCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127606; c=relaxed/simple;
	bh=IlgaD+BVzERZ3ss5zBYogc9mdd3/BtFWgL+DfqrqphY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKmmwqOG1nJ/7bEL/bENvZYl1KHGpg0PVzRo+HWvJNosue1afrMoRTXq7W5GEwpkhIJzsva0+XVCawXq4V/H0f1rfTq6FTwxtsCivrNfIwSH9Yq6Kfhki/r6mt4hBlVwPCh3amQwgEzJwH+qwTv5akOplWzQUnMlVPsAcvKD4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ovtBMPFe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OLCjMxRK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TTbq1g0N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5BKZ5yqq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ovtBMPFe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OLCjMxRK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TTbq1g0N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5BKZ5yqq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 804703EAC;
	Wed, 19 Aug 2026 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787127595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9GnN3rAoGpYO3vjH23hNjM1l2JRoLE1XiBBXLMKyqs=;
	b=ovtBMPFeqr8k1j/i0grRpHq6DPHJFiiTC8snRK0fCDyav4/FBVVuWo2QqtZs+hS/dq0nsu
	3/KAEP0FVpLw28IB9+WV1UCnc6zUofJ3WF/8xDW4sxwgaxKGGRR/szXja0DO4SFQPbXQI1
	tq7vteUceI3GDnxUN8FHOfxSiX4rX8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787127595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9GnN3rAoGpYO3vjH23hNjM1l2JRoLE1XiBBXLMKyqs=;
	b=OLCjMxRKl/OALMDCOPesk9Tez9TmPlVmjt/NNsv01xxV8W5JU8qbbuPe+wYqaVmTIl+wOW
	BylcTuIwHhAVGSDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TTbq1g0N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5BKZ5yqq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787127591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9GnN3rAoGpYO3vjH23hNjM1l2JRoLE1XiBBXLMKyqs=;
	b=TTbq1g0Nl1OwfJF+pdbIOnpH0eQf5d90Y38JQGsX3GsXVI83AK5xSZMHpajrZjmk2yW/J3
	zZfIDpH+uhtSrYJsxwbzT5GxDNcqXEzU0EXTyk6eWIiNXYzE9F5M8dZxQlmCEV5cvtbUH+
	dWEpdCSBd3/SQ/tZ3wdBLY6BsfxvAoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787127591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9GnN3rAoGpYO3vjH23hNjM1l2JRoLE1XiBBXLMKyqs=;
	b=5BKZ5yqqFVmo0J6a7W8dVqSOIXB999m7uAmRNNHrXNOLlingAOTwkScnqxBPCxphBHBLyS
	snH1HSVHt8GhveCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 416BD779BE;
	Wed, 19 Aug 2026 08:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tb24DidnhWrpawAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Aug 2026 08:19:51 +0000
Message-ID: <c4bbf710-2b9a-4922-91fe-70fb104808ad@suse.de>
Date: Wed, 19 Aug 2026 10:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
To: sashiko-reviews@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org,
 linux-hyperv@vger.kernel.org, Frank.Li@kernel.org,
 intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-7-tzimmermann@suse.de>
 <20260818130916.110771F000E9@smtp.kernel.org>
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
In-Reply-To: <20260818130916.110771F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 804703EAC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action



Am 18.08.26 um 15:09 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Concurrent debugfs writes or KUnit tests across multiple DRM devices race on global static buffers without adequate synchronization.

A fix would be nice, but is beyond this series. As it affects debugfs 
and kunit test there's no urgency.

> --
>
> --- Patch [6]: [PATCH 06/12] drm/panic: Pass global module parameters to drm_panic_dispatch() ---
> commit 9f2a1b5158feac614c09a17c83f387591642e034
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/panic: Pass global module parameters to drm_panic_dispatch()
>
> This patch sets the panic type and QR version in draw_panic_plane() as a single
> point of truth, passing these values into the individual drawing functions.
> In the test case, it always creates a QR code with version 40.
>
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index ede620b27515a..12c39217cbcb5 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
> [ ... ]
>> @@ -951,6 +955,11 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>>   #else
>>   	u32 bg_color = 0x00000000;
>>   #endif
>> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>> +	unsigned int qr_version = panic_qr_version;
>> +#else
>> +	unsigned int qr_version = 0;
>> +#endif
>>   
>>   	if (!drm_panic_trylock(plane->dev, flags))
>>   		return;
>> @@ -966,7 +975,7 @@ static void draw_panic_plane(struct drm_plane *plane, const char *description)
>>   
>>   	drm_panic_set_description(description);
>>   
>> -	ret = draw_panic_dispatch(&sb, fg_color, bg_color);
>> +	ret = draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr_version);
> [Severity: High]
> This is a pre-existing issue, but does the per-device locking in
> drm_panic_trylock() adequately protect the global buffers?
>
> Since the lock is per-device (plane->dev->mode_config.panic_lock), concurrent
> debugfs writes across multiple DRM devices can still race and mutate global
> static variables, such as the zlib stream workspace (struct z_stream_s stream)
> or qrbuf1 and qrbuf2.
>
> If a real kernel panic occurs while a debugfs write is concurrently using these
> buffers, the true panic handler could inherit a corrupted zlib workspace state,
> which might lead to a recursive fault and failure to display the panic screen.
>
> Could this be protected by a global lock for non-panic paths?
>
> [ ... ]
>> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tests/drm_panic_test.c
>> index 969a096ec840f..196496238d231 100644
>> --- a/drivers/gpu/drm/tests/drm_panic_test.c
>> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
>> @@ -58,7 +58,7 @@ static int draw_panic_screen_kmsg_default(struct drm_scanout_buffer *sb)
>>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>>   static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
>>   {
>> -	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
>> +	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
>>   }
>>   #endif
> [Severity: High]
> This isn't a bug introduced by this patch, but do the KUnit tests safely access
> the global drawing state?
>
> It appears the KUnit tests bypass draw_panic_plane() entirely and directly call
> drawing functions like draw_panic_screen_qr_code() without acquiring any locks.
> Could running the tests race on the global buffers and corrupt the zlib
> workspace?
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


