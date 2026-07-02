Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CE390981
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983725; cv=none; b=QRxDfr/d2T1BcUOKEAvtzMiifw+tOavyOvQ4mlSyxpBviCxuH9eLzobfgna48ILpTTlpRl1UD/ZdTVoAkU7xv+rVGpeSmhdoHyoRg+dRYlJ3Rx2oXyv8uHQVMM+BIC7Qo1YWoTHiLRqDb3azvNpXW2UAGZBUw1+c7NbEI9XQUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983725; c=relaxed/simple;
	bh=MT9sPatuzKsWGEzTl8mSu7rJvYd56fwj8BB2rQbcNDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ep0TbbM6gCq8r5uii3A7TBqj4KvhLAcRGBHm1rwUmFsnnxTEJTvzGnGVZfFagsfkEpQEkXGGDvpBAmhagAdEe62RK48jlGHrymt57X/OceMZJi3M5bQ54S/xED0IRN9sYdy/cdiqwyVYVnTvw+IbnHhB/YlwPAzSLnbYQK2yJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nppHb3Bt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kqtcr/iD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nppHb3Bt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kqtcr/iD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nppHb3Bt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kqtcr/iD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nppHb3Bt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kqtcr/iD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E5D8740C9;
	Thu,  2 Jul 2026 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782983715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gcIRMuJdnWxglX282uJMGMsZpqjvVtk2oVuBKv4zAdg=;
	b=nppHb3Btq527MN16+7kiZ8Vogss2BzKVTjeiOzlIqC/WfmsUSHdbdzWKBtpymHwHRQOxGi
	Qi7CJppS37VMKptdrygSmj3jHUbakQAdmIy0Nd19SornnIldWCSskLFv6J3P5lwP7pP2C0
	T9tftyw9nXUUEgPEJ73A44HsKp+NbMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782983715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gcIRMuJdnWxglX282uJMGMsZpqjvVtk2oVuBKv4zAdg=;
	b=kqtcr/iDCyLq64uvcEBrzOqq264UoE/k5WQBfjx8/m6a0r8ZGkjQbCoBlb5q8H55x+aZ7G
	rRqn4JceZkU9bnDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nppHb3Bt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="kqtcr/iD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782983715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gcIRMuJdnWxglX282uJMGMsZpqjvVtk2oVuBKv4zAdg=;
	b=nppHb3Btq527MN16+7kiZ8Vogss2BzKVTjeiOzlIqC/WfmsUSHdbdzWKBtpymHwHRQOxGi
	Qi7CJppS37VMKptdrygSmj3jHUbakQAdmIy0Nd19SornnIldWCSskLFv6J3P5lwP7pP2C0
	T9tftyw9nXUUEgPEJ73A44HsKp+NbMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782983715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gcIRMuJdnWxglX282uJMGMsZpqjvVtk2oVuBKv4zAdg=;
	b=kqtcr/iDCyLq64uvcEBrzOqq264UoE/k5WQBfjx8/m6a0r8ZGkjQbCoBlb5q8H55x+aZ7G
	rRqn4JceZkU9bnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01D16779AA;
	Thu,  2 Jul 2026 09:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hz3QOiIsRmq4awAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Jul 2026 09:15:14 +0000
Message-ID: <4e421c5a-1ecc-4155-8262-69c163af9624@suse.de>
Date: Thu, 2 Jul 2026 11:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and subdevice
 for pci match array
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
 <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de> <akYkWQzXIo-y3n4J@monoceros>
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
In-Reply-To: <akYkWQzXIo-y3n4J@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,baylibre.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E5D8740C9
X-Spam-Score: -5.51

Hi

Am 02.07.26 um 10:52 schrieb Uwe Kleine-König (The Capable Hub):
> Hallo Thomas,
>
> On Thu, Jul 02, 2026 at 08:43:32AM +0200, Thomas Zimmermann wrote:
>> Am 01.07.26 um 19:05 schrieb Uwe Kleine-König (The Capable Hub):
>>> .subvendor and .subdevice were set to 0 implicitly, so only devices with
>>> these two values set to 0 in hardware can probe automatically. Make this
>>> requirement explicit.
>>>
>>> While touching this array item, also make use of the pci macro designed
>>> for that case.
>>>
>>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
>>> ---
>>>    drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> index 2e75fb793495..e766d87b7a9d 100644
>>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> @@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
>>>    static const struct pci_device_id hv_drm_pci_tbl[] = {
>>>    	{
>>> -		.vendor = PCI_VENDOR_ID_MICROSOFT,
>>> -		.device = PCI_DEVICE_ID_HYPERV_VIDEO,
>>> +		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
>>> +				0, 0),
>> IDK, but it looks like an oversight to me.  Setting the sub-fields to ANY
>> seems like the better fix.
> That was my initial reflex, too. However while writing the commit log
> for that change I noticed that since commit d750785f305e ("Staging: hv:
> fix hv_utils module to properly autoload") from 2010 (applied to
> v2.6.35-rc4) the driver never worked for hardware with .subvendor != 0
> or .subdevice != 0. I cannot believe that something like that is
> discovered 16 years later by chance during a rework by someone who
> didn't try to run that hardware. And if I understand correctly, this is
> emulated hardware and so I guess used quite a lot.

I wouldn't be surprised. To my knowledge, there's just one 
implementation of this device, which is Windows. If they clear their 
host-side structures to 0 and pass them to the guest, no one would ever 
notice the issue. But let's see what the driver maintainers can comment 
on the issue.

Best regards
Thomas

>
> Best regards
> Uwe

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


