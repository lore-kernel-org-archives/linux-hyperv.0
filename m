Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA463CB576;
	Wed, 19 Aug 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136352; cv=none; b=bvt3QydMlIT+TGxtc4eALOv8jXi/o3j1coSCoC4dUPa1pL3CH69oXLD5CgOixVrm3Zb27pIVZp8Uq2qwGs75O5IzJosunr4EhQXg8UfoIAY5O86veJwtDDQpflgAf8mMQHyiuXeWuuXB2ebTaSY+zTWladwClNI5hH0T9NcJgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136352; c=relaxed/simple;
	bh=ZuHkUEAywijyKy0CYl/u0oX2kPdWveoBXxulvd/HS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID5WmsXZXm5kj1mVGr94wuUAE/7+DWV+j44FQhUiUFse6AwI3SEZIEiyXQZfxYhUGKeCkcpHYxs5SlkSm8l56QCKr9oIFsK8yRR3rzmLj2qPwjBJDlwaI4UxTL1PES34v82/Cuq2BwIMsGt2jW3SRdzfnpGKt4gzWo+25KfS7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LdNWfzPK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NtPGda8x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HtiVdQ6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nQiVOu0G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LdNWfzPK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NtPGda8x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HtiVdQ6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQiVOu0G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CA123ECE;
	Wed, 19 Aug 2026 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787136342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hg/ZPXFle3feAVe1hiMHSTS/1Mz1wkpga/z0zY78R5Q=;
	b=LdNWfzPKrb9NDTksCcvaHrsvxugOfINA1v+h3Kxy67vH2zhc75r2JKsfmAAhoII4pijNSl
	DamY7typxy92U9RMhZP6Sk+eDBWphjO7TfrMGA6m0nv+DQmV6o0cPOsy5bl7f8mbDMhkuM
	fEkDpG5lCEQUoiHXix5NG6Zduj7fH0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787136342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hg/ZPXFle3feAVe1hiMHSTS/1Mz1wkpga/z0zY78R5Q=;
	b=NtPGda8xTU4/ykIvNTrk/MXoH9S0MdxTKEoPi+bSi+fNK8qvsVvOrNREMwnZWfeM++KHAq
	bAb3yg0PLR0wlCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787136338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hg/ZPXFle3feAVe1hiMHSTS/1Mz1wkpga/z0zY78R5Q=;
	b=HtiVdQ6P+QJOYv7bdivbBbzsLhrDtGsKdck5z+Rrnv5Or6Yb44FhFp1YxLUk3gDWrB9qYV
	cn2gnBsxFaQ4xwdio3kwwY4iDLHaGThOj7ebSl9TL/PcG3Ua+Yaq9p1sn/dvBl9zZR/kEE
	h4zGF9BReqs7jdJ4u7HD2AXm8xs8UR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787136338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hg/ZPXFle3feAVe1hiMHSTS/1Mz1wkpga/z0zY78R5Q=;
	b=nQiVOu0G3/p+k3HKPnabYNUqcD5L4WSj9Qhtsmg5DXJti+Tl/1EJONrUHo9Krh/jZRLA7e
	BT6JqTT+EATfroAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC5BB2F81;
	Wed, 19 Aug 2026 10:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PoR9KFGJhWo/KAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 19 Aug 2026 10:45:37 +0000
Message-ID: <427a13f5-c820-4aa1-b19f-1fb0493d264d@suse.de>
Date: Wed, 19 Aug 2026 12:45:37 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: jfalempe@redhat.com, javierm@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-2-tzimmermann@suse.de>
 <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

Am 19.08.26 um 11:38 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Tue, 18 Aug 2026 at 15:00, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
>> allocates them for us. Avoids the kmalloc later on. Also allows for
>> using sizeof() to get the number of bytes in each array. Access the
>> arrays once with memset, so that the physical pages are available on
>> a panic.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Thanks for your patch!
>
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -628,24 +628,23 @@ MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>>   #define WINDOW_BITS 12
>>   #define MEM_LEVEL 4
>>
>> -static char *qrbuf1;
>> -static char *qrbuf2;
>> +static u8 qrbuf1[QR_BUFFER1_SIZE];
>> +static u8 qrbuf2[QR_BUFFER2_SIZE];
> I am not a big fan of increasing kernel size like this.
> You may run (faster) into boot loader limitations.

Which limitation would this be?

>
>>   static struct z_stream_s stream;
>>
>>   static void __init drm_panic_qr_init(void)
>>   {
>> -       qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
>> -       qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
>> +       /* best-effort allocation; can be NULL */
>>          stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>>                                     GFP_KERNEL);
> <ironic>Why not use a static array for this, too?</ironic>

I tried, by the size is calculated at runtime.


>
>> +
>> +       /* touch memory so that pages are there in the case of a panic */
>> +       memset(qrbuf1, 0, sizeof(qrbuf1));
>> +       memset(qrbuf2, 0, sizeof(qrbuf2));
> Please clarify "there"?
> In cache? Not all systems have sufficient data cache, so it may be
> evicted at any time.
> In RAM? AFAIK kernel and module memory is not demand-paged.
> In TLB? Like cache, it may be evicted at any time.

I'd like to avoid looking for a page after a panic has already occurred. 
But I guess it might not make a difference, given all the DRM that is 
involved.

The motivation here was that I did not like that panic handling depends 
on a number of dynamic kmallocs, with which we don't even detect alloc 
failures until a panic has occurred.

>
> So IMHO this is futile.

Noted.

Best regards
Thomas

>
>>   }
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


