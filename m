Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC09399036
	for <linux-hyperv@vger.kernel.org>; Wed, 19 Aug 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127741; cv=none; b=dO+fJ86um8US5KmnRjiogHarkbevfwY5DKRF531xYduxfVB0PP+ogqn2VZgDjsj1tKgPKZ4N+yT3y7ZVSkuqgQXzl4U2czot9IK5L2OUzHgt9dNwl4cJMC2R4OhxSDKHpmiOz5yNJrVy+ZM5MJAaZHBSZLvK4zhVmzjyxQ0fB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127741; c=relaxed/simple;
	bh=42pckIP6OuUwrvrAy04Cy4ixyQLZrVTJFUzY9g24TKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIbpB7h0k2er7xtqechmcHxFMC4cXv5izGTE5Z48q8KZ8WLWZ1bLyi0q2rC9Nrab3cOaJWQAJeEwZa3msN/Hh6k5Uiktc6Mqxg1wst/c2Y24t7HKFS2o+7+OAooBNMwdFhqf86KbrTFmTt2QV7TjUjiPudqJJSVDt+4Gj5EDJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uspJcNY7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QYyCurve; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxMhb+EN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ammhfTDM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uspJcNY7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QYyCurve";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxMhb+EN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ammhfTDM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9476F3EAC;
	Wed, 19 Aug 2026 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787127733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLXsUmxS6VoLACyx0soPwmhAAfleZCRYNeF80jfiiCA=;
	b=uspJcNY7c9ScFhsddZ44oWHV+xMi/zjwP4R2mQnGTWcxilDz5jEZfWBmeOxBOILGFAa9wW
	/5+7WVg2IXDn6l+h1TwEGLaN3hWbmwauv4qRuq7EOVpU8n95/izctCBRGBQl4t3QDLyAOD
	7w69eey4f0igmVL5fwdPo00yYBg5F8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787127733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLXsUmxS6VoLACyx0soPwmhAAfleZCRYNeF80jfiiCA=;
	b=QYyCurvefr/vDZ3jHFmn3udlyUHIvxnPvbZYDczOgu2oxAcAlOgejtt+XnJfOTc1yaBQLX
	TUNEwxcdPm/07fCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787127729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLXsUmxS6VoLACyx0soPwmhAAfleZCRYNeF80jfiiCA=;
	b=cxMhb+ENMJi1yKIIbwgBwGJGqeBoKUANYOqtHjgtcqhyFwt7FXVeFmQTaKS6agsm9WNUvO
	n/F7jyaXnLSebFap4432uhXTqP0Nn42zmmr89K7FoGaaxZU74ctC4MIzi6Zj7aZeET0IsK
	gFP9/lCCX0kTlF6Pic0RGHDHfZzUvg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787127729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLXsUmxS6VoLACyx0soPwmhAAfleZCRYNeF80jfiiCA=;
	b=ammhfTDMuV55xX/s1kxJXE1cm4jogUxu1ZCRSeOh5tCVUxrqHUf7FqHPRI4qKZZ1BerIse
	av8G2pPFXvRfFeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E804779BE;
	Wed, 19 Aug 2026 08:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5/jFbFnhWobbgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Aug 2026 08:22:09 +0000
Message-ID: <b5f0a822-a343-45b2-94de-aeefd870427e@suse.de>
Date: Wed, 19 Aug 2026 10:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Frank.Li@kernel.org, imx@lists.linux.dev, intel-xe@lists.freedesktop.org,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-8-tzimmermann@suse.de>
 <20260818130547.4FEDF1F00A3A@smtp.kernel.org>
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
In-Reply-To: <20260818130547.4FEDF1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo]



Am 18.08.26 um 15:05 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the internal fallback from `draw_panic_screen_qr_code` breaks the `drm_panic` KUnit tests.

I think that's exactly the right thing to do. When we unit-test 
draw_panic_screen_qr_code() , we better not fallback silently to 
something that works; thus masking the error.
> --
>
> --- Patch [7]: [PATCH 07/12] drm/panic: Retry in dispatch function if panic output fails ---
> commit 23392eb57457ad383d9c4741f6fc2f3c107aabb3
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/panic: Retry in dispatch function if panic output fails
>
> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
>
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
> [ ... ]
>> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>>   	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>>   	return 0;
>>   }
>> -
>> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>> -				     u32 fg_color, u32 bg_color,
>> -				     unsigned int qr_version)
>> -{
>> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
>> -		draw_panic_screen_user(sb, fg_color, bg_color);
>> -	return 0;
>> -}
> [Severity: Medium]
> Does removing this fallback cause the drm_panic KUnit tests to fail?
>
> Looking at the test suite in drivers/gpu/drm/tests/drm_panic_test.c, it
> calls this function directly without going through the new dispatch logic:
>
> static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *sb)
> {
> 	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
> }
>
> When tested with a small resolution like 300x200, the scale evaluates to 0
> and returns -ENOSPC. Previously, this wrapper caught the error, fell back
> to draw_panic_screen_user, and safely returned 0, satisfying the KUnit
> check.
>
> Since the fallback was moved to draw_panic_dispatch and the test calls
> the lower-level function directly, will this now propagate the -ENOSPC
> error and spuriously fail the test?
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


