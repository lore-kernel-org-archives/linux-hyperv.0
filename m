Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D73D0903;
	Wed, 19 Aug 2026 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120270; cv=none; b=QB3oK/4e+/h0Kn2XYqwidvkc9ZsUYMUaVZuy+QNlnVHLqOESUZI6m6PLpg+8Clmz4v5N1SOafOsi0Gb34D+frZD9596nNqTxZl9SxbIfzntgIVWVCOnit99BYY8xB2u9y5a8cIWkgpFanLS4+CgyOPec66B9C55WSJXWaS1qnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120270; c=relaxed/simple;
	bh=3EajQNbjuEt3B0aP/HWXhloydBrWAMv9GoLKHiDXcSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKYmTEkcrWQ09K3+Dwuw9+MdEIh8/NytxXgudE5c8R1l4hlcRRQ2VI9GffjLb3SdmDuLVN5lCyQkg0OLGU6k+wsTGJlp1YAUyxrX7QouVpNgC2r+B/np2tUSv/SAP1rQummjPO/OxQig8GUyt057CIgmZlYY9PW7jHZJzEiwOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dO720plT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Q9NN6B3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L8HnCUTS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eaPdP7nU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dO720plT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Q9NN6B3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L8HnCUTS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eaPdP7nU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 168B33E69;
	Wed, 19 Aug 2026 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787120204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c/AzOS9nYCn1gKcDW+iR9M86QEqFfEOWGqdTZE1/Q8A=;
	b=dO720plTJcEcHC+arFs6mB/9g8FDyt9rYEInkQG8s2VxFn+S+3tlBdg/z0/AE76kVegV/J
	po0cwcLIJ0eVH1dO9hOcYHWbGx/nXdmjU0jchzVB/Ap9d4oLj2BeJMXDhXaD1gW3tzAHoa
	VMq/ekbE9a8qAKfFTXWZ3jSUpCcnGBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787120204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c/AzOS9nYCn1gKcDW+iR9M86QEqFfEOWGqdTZE1/Q8A=;
	b=3Q9NN6B3P//DA/0r1qISw0CBzYxq34c3kFnAVy/gpQSWIUSsUBzu81MGBqHvUkojiRlIT4
	IvkPnljiLo7vL3CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L8HnCUTS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eaPdP7nU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787120200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c/AzOS9nYCn1gKcDW+iR9M86QEqFfEOWGqdTZE1/Q8A=;
	b=L8HnCUTSvXwz89JqoFEUVGXfyBa/oJZAT7BC7J3w1uwidMcKF4OuijNQdTHOe7KdU9uEgh
	5FjLcKdQXjz0iGVcE0TMronQ79HDZTovL3ne4XDVb7NDRzvZyTBD8D37rgnErtXW0X/CoY
	vMYe1wsMsZ1pQJYvLMtEzC1qL6dpgqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787120200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c/AzOS9nYCn1gKcDW+iR9M86QEqFfEOWGqdTZE1/Q8A=;
	b=eaPdP7nUjcgGMN2xiwEPnkNBTlV45RYeLfigA5z8I3ZRnJMisCHgbu0N+Luewac2zV75sO
	rnXH4UsE7FZEdMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 960AA2F81;
	Wed, 19 Aug 2026 06:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2BRI0dKhWpUcwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Aug 2026 06:16:39 +0000
Message-ID: <614bdf7b-031d-444b-a30c-132daa55ce3e@suse.de>
Date: Wed, 19 Aug 2026 08:16:39 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/panic: Move panic display code into helper
 library
To: Randy Dunlap <rdunlap@infradead.org>, jfalempe@redhat.com,
 javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-12-tzimmermann@suse.de>
 <916c4bd5-c73f-466e-8e9b-aee9d4d7d742@infradead.org>
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
In-Reply-To: <916c4bd5-c73f-466e-8e9b-aee9d4d7d742@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[infradead.org,redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 168B33E69
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hi

Am 18.08.26 um 17:55 schrieb Randy Dunlap:
> Hi,
>
> On 8/18/26 5:28 AM, Thomas Zimmermann wrote:
>>   M:	Hans de Goede <hansg@kernel.org>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 323422861e8f..cdfd72d9a9c5 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -45,6 +45,7 @@ config DRM_MIPI_DSI
>>   config DRM_KMS_HELPER
>>   	tristate
>>   	depends on DRM
>> +	select DRM_PANIC_HELPER if DRM_PANIC
> but DRM_PANIC_HELPER depends on DRM_TTM so
> DRM_KMS_HELPER should also depend on DRM_TTM. Otherwise:

Oops, how did that creep in?  There's no TTM dependency. This Kconfig 
change appears to be a copy-paste accident. Thanks for noting.

Best regards
Thomas

>
> WARNING: unmet direct dependencies detected for DRM_PANIC_HELPER
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_TTM [=n]
>    Selected by [y]:
>    - DRM_KMS_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_PANIC [=y]
>
>
>>   	select FB_CORE if DRM_FBDEV_EMULATION
>>   	help
>>   	  CRTC helpers for KMS drivers.
>> @@ -130,6 +131,10 @@ config DRM_PANIC_SCREEN_QR_VERSION
>>   	  Smaller QR code are easier to read, but will contain less debugging
>>   	  data. Default is 40.
>>   
>> +config DRM_PANIC_HELPER
>> +	bool
>> +	depends on DRM_TTM
>> +
>>   config DRM_RAS
>>   	bool "DRM RAS support"
>>   	depends on DRM

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


