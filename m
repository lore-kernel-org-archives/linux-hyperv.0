Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91F2DF719;
	Fri, 21 Aug 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294369; cv=none; b=oZUiDqWuJiaOb+F/rau66bMGd4OhS67Uu5c4UJUsR5iM/wJLp/jmTC+OzI54j5Vvh+mAQug96aZ4sENE4NKc0IWHA+AlXfq6ExEX05b9ulbo+MhZAhYQ6AVoByUurWUGHgAqWxc4Vjqfd/5LUfQzeVqpppIGJrdr0HnWxK6yUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294369; c=relaxed/simple;
	bh=Q+P3w2dr2jKrwoP0NuqdHvJM0nrzfqOzaVZKW3DU1vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hevwS/2GaCc9iXufJ4h6MP05Cs8653xXrKfWRFGVTbkuQeiK+pRUIViSjdpdVQ+SY4j/RojoY6/PGMi4QFcKaDhWHaZ/2/IiEFScxgthi4NHQWzALMdbYB3EuhFZmlT8JtPlHJ5WpIZMXWcCGpCvL6IDy5Mi9waGyKDcL8HXh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bwcBwS0+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Z4vcbQC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mL9/9Iir; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xbk2DB96; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bwcBwS0+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Z4vcbQC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mL9/9Iir";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbk2DB96"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3284B3EAF;
	Fri, 21 Aug 2026 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787294328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IMECoYsWSShMDNVZ8JDbQREho5iWl1tF8HaXKW+o8bY=;
	b=bwcBwS0+RC4EqtR9XE60Dr7YThswkD9m/wJHGl0tYz+b+jnsCbHokMe2hGq/Uqk4uzT50A
	eo3102wp6SGIjVNcjni9XRheTPpNywHtnve3o/8JTxEV7f0KyAXhdofQzz/9ZLDSC0zYU4
	Y6GN1+Rph/uZtJg+IxXU5IT21JaHaQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787294328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IMECoYsWSShMDNVZ8JDbQREho5iWl1tF8HaXKW+o8bY=;
	b=6Z4vcbQCxluqvDsyVW5JOdb+VetFkKQe/E/aiunFRyGnD0F+w7Vd66aAq33oo/wFBvKlfS
	DD681hcQkd6gUCBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mL9/9Iir";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xbk2DB96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787294324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IMECoYsWSShMDNVZ8JDbQREho5iWl1tF8HaXKW+o8bY=;
	b=mL9/9IirJ/hFuHoEJ9tqN6Gyj/BzCxbBnS8Vhpd9olYi8cAzb5Q7wleR0jkMWFnb6EQXj4
	MbELBsuGxlTEhOXwdoUh5C2t3dHRphQ2taTyOQWKik5ErjYPYnJRZqA4MOEXeGdv8z+pmE
	DnM6e+TO6hELLfr5XGJHojqd0ilrLZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787294324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IMECoYsWSShMDNVZ8JDbQREho5iWl1tF8HaXKW+o8bY=;
	b=xbk2DB96M/yt8An1/BaVXFIB/WVgjEWwzS3BFmfjzbloxDMaBSaA5lj+zU3stDKov/MLO3
	gePOA+Nf5lkyeWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBCDE3329;
	Fri, 21 Aug 2026 06:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id us1oLHPyh2pUAgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Aug 2026 06:38:43 +0000
Message-ID: <3d0d14e6-05d2-4fc4-befe-e1d0cafc91db@suse.de>
Date: Fri, 21 Aug 2026 08:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] drm/panic: Split into core and helpers
To: Jocelyn Falempe <jfalempe@redhat.com>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <e4da5ba4-9a02-4080-9a83-19d401017910@redhat.com>
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
In-Reply-To: <e4da5ba4-9a02-4080-9a83-19d401017910@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3284B3EAF
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Jocelyn

Am 20.08.26 um 19:49 schrieb Jocelyn Falempe:
> On 18/08/2026 14:27, Thomas Zimmermann wrote:
>> Split DRM's current panic handling into a core and a helper module.
>> The core is still part of DRM's core library. The panic helpers are
>> part of DRM's KMS helper module (for now).
>>
>> The motivation behind this series is to get panic handling's drawing
>> code out of the DRM core. At some point it should share a single
>> module with DRM's other drawing and format conversion.
>>
>> With the series applied, panic hanlding follows DRM's established
>> design pattern of having a DRM core interface with an dedicated
>> implementation in each driver. Drivers share common code in helper
>> modules. For panic handling, the DRM core still contains the panic
>> entry points, the parameters and the debugfs interface. All drawing
>> is now located in the panic helpers.
>>
>> Patches 1 to 4 improve several issues in the current panic code. It
>> makes sense to fix them before moving the core around.
>>
>> Patches 5 to 8 put handling of all panic state and locking into a
>> single place, drm_panic_display_panic_screen(). It is maintained by
>> panic handling's DRM core code. This also enables the test cases to
>> work more independently from the kernel's configuration.
>>
>> Patches 9 to 11 split the panic-handling code into the core and panic
>> helpers. The former maintain all state, locking and public interfaces.
>> The latter handles drawing and details of the involved framebuffers.
>>
>> DRM devices that offer panic handling provide a single callback, struct
>> drm_plane_funcs.display_panic_screen. A new initializer macro makes it
>> point to the existing panic-drawing implementation. Hence there's no
>> change in features or functionality. If panic handling is configured
>> off, it all clears out to NULL.
>>
>> Patch 12 reworks the test cases slighly, so that they can be build as
>> a separate module. Do 'modprobe drm_panic_helper_test' to run them.
>>
>> Tested under bochs with debugfs and test cases.
>
> Overall the series looks good to me, and I like the split between the 
> helper and the core.
> I would just drop the first two patches, as I don't see much 
> difference between static allocation or kmalloc() at init, and I think 
> that memset() the buffers to 0 is not useful in this case.

Ok. Geert also expressed a dislike for these changes.

I have a number of changes done from the Sashiko review and will post an 
update to the series early next week.

Thanks for reviewing.

Best regards
Thomas


>
> Best regards,
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


