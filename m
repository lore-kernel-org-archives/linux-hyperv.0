Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6E3D9693
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175594; cv=none; b=FT5wteXtdPmCPauC20lIv0rben7oMn7OlJHQUTrDOyDBMmhxZpX+kVtwDf3ikb8aYDC/ZSGma0hs5uMtX6nFa6uy3ehuM6XtyriAz5dUW090Ex0u16lCBEu7BmlKCCSfnsDoAAaiy0dPHyr3Uu3STb6JmwCFSg2K/b/KPZLTJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175594; c=relaxed/simple;
	bh=ifamMReb0BWhkfjGxF//h0cAx/mHBlMkmlRIFK0occw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIUbBbOGVEx5TAlQiQiEEO8G/+7/OQwg5ya0K27BybWAdItHcXkxdsCpLKapR/BufRICO5s8YoJHa9wgZZczQlagBizvmlI5CpNrPariRGMFRwKQ+yqrKB5b0VH3nP5oogSSpYCUf/IrZe2m0xE/G2XdV392Fh5l0s6UwG7/QdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtfRD6Ji; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9dSaYII; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtfRD6Ji";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9dSaYII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781175592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
	b=EtfRD6JiaxHvVmc6or9XWVkYyi+gCzzFWM6MFlebn+AluVG6o/CX5atL8lGWLs0vtea7lU
	hfparDuouw6ZIHd0svCS0JZgKN7iA50sNYqDKxqaraUUIIacyP2WNcmuslUdWOakvbzagj
	J/pfsdooPFMBnRpFhjEl9AnprNIovCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_Sgskty9ND2gd6eI1Z_Y9w-1; Thu, 11 Jun 2026 06:59:48 -0400
X-MC-Unique: _Sgskty9ND2gd6eI1Z_Y9w-1
X-Mimecast-MFC-AGG-ID: _Sgskty9ND2gd6eI1Z_Y9w_1781175587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6b407b4so3399741f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781175587; x=1781780387; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
        b=W9dSaYIIViGuSop919c8zZJHNXYQPBQUrbxXNpvTsE9g7Rlvbk6QnzEPAIq8ebuDMg
         mWWXpiP7y/sEzWgLErq2MWqBjplFi2vecc4yMgr1sNJPmWKI/UUEbKI2Etc3Uqs0+1Gw
         nj0trW25t7JtMkoy7lahqLX2X0g8QWLe0d+gllhYDYiB5vGsPvjN/AnQJnDlEFoGXdcb
         mqPuLMcBIAwNDzqyOrRUZdTRNcyq1Zzl+6kcy1iH97GFr6GxmDrSbie3RjUT1xocX1Kv
         5bw5ZWYs5NTml2Th7nNMghtGhpEnmR/kBtel69HQISubBILKk1IvcicsKMjTT3pppVFe
         DbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175587; x=1781780387;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
        b=hRT66foGs4CI1BhciLAWSH7BJOXnvXVviS9KpUoiefPvL8ak9ejWBx1IQhLZr8GKu/
         VU4eQ7+R88qQYX8Y6BBFYiNsrf3QEndaLLniK+fsTxSuEuqcbBi3DVYb2a0B+rkFOM5y
         G1r4bLDITzBZMh8wrFW2HX7im016T2GLVNh0HAYntb4skcLxkj/D9Pwg1uS6/qJlVQQd
         /U8FEWdd7Vv7BT+qX/XgqL3eaKBRfU8T0tOKG83EGc6CgW+WN30XWJyB5M7I4/iOdMhA
         MXjgQ6rNkFL+q2ddR9nmx26gI6GcN1drkI595ZJJtzNxXd7iRz83i5Ji5L1y07MY+Po9
         iZVg==
X-Forwarded-Encrypted: i=1; AFNElJ+3pHKciNo5x2qDRbmqv0gvdw1ZfjaJoJwlMlhDP5ts1Fz8xrlAC7PsAxO0Wgu1awRjHHL1+/i8CvyfdKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8YpsHabKAJf3L+GNOrM9Q7ra/WwD4Dxd3pjRmIDWlmZtU6ICV
	OTvffWHbShMy7KsNnQUuumHwEb2lS4LZBc8mXEkClwjKmBVHEehEG6UiLem3q7Ge0l9lZEFsnxT
	t7AVbZs15xpxQD+PizvXf8yzBMlAc+Fag9jlxq4oWbjCBgAkaG+TwbFFfmtEXGw0O3w==
X-Gm-Gg: Acq92OHDyPiAHlktNhMh+oAYWKDnyDCvTgGBAzXGMMMrOTJtQt2ipoJLn4pMG667teR
	6IDDv9qPXdHelPelhT+htt87F+a4ITZNMZOKTr0/39lVKCtgRsopfjYSa8MxDEL4HFBc0ZHijBP
	bcgI/VLBgBq5ImBwcs+YX91F87meOKh/zCJprqKZyYMJ1wQ3f76Gn/6TneS5CeshpI2fmMQ4z3b
	7t75N4dh41PWf7pTEWBSg9QykbqKO3KNLaTdLviwTf4MrzOkxnt9hy5KbjBW4AI2lKfQjhepVl5
	1akIpNAm5BMWuSPVThZZlMJIOuyGLGI+6MZIOGKPv7AjJFLK1mY8qGTpE86nxGYF5RmYrAgREkH
	NgRAZmw5ML/bfRQs1wRVu2A6J2isC1grr2Qi/dxItrxBJ5CAxXpgJYNtAh/3WyA3CeEyhWc/ZxB
	fdnSErj7yTzJOU5kM=
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240524f8f.20.1781175587107;
        Thu, 11 Jun 2026 03:59:47 -0700 (PDT)
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240484f8f.20.1781175586716;
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm81947989f8f.1.2026.06.11.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
 <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
 <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
Date: Thu, 11 Jun 2026 12:59:44 +0200
Message-ID: <87mrx15om7.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 11.06.26 um 12:10 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> The mode-setting pipeline can disabled damage clippings for a commit
>>> by setting ignore_damage_clips in struct drm_plane_state. The commit
>>> will then do a full display update.
>>>
>>> Test the flag in DCN code and do a full update in DCN code if it has
>>> been set.
>>>
>>> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
>>> to ignore damage clips") introduced ignore_damage_clips to selectively
>>> ignore damage clipping in certain framebuffer changes. This driver does
>>> not do that, but DRM's damage iterator will soon rely on the flag.
>>> Therefore supporting it here as well make sense for consistency.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
>> I don't think that a Fixes tag is correct here? Your patch series
>> is changing the 'struct drm_plane_state.ignore_damage_clips' and
>> the changes make sense, but definitely isn't a fix in my opinion.
>
> But shouldn't we have added this test in amdgpu and the other drivers as 
> part of commit 35ed38d58257 ? Sure, these drivers don't use
> ignore_damage_clips, but it's still an inconsistency wrt damage

I don't think so, since the original scope of ignore_damage_clips was for DRM
driver of virtual devices (namely virtio-gpu and vmwgfx). These do per-buffer
uploads instead of per-plane uploads, and so there was a need to force a full
plane update if the framebuffer attached to the plane was changed.

Your series are now extending the scope of ignore_damage_clips to be used by
core helpers and force a full plane update when doing a modeset. This makes
sense to me but it wasn't the original intention of the propery and that is
why I don't think that should be considered a fix.

The only patch that IMO is really a fix for commit 35ed38d58257 is patch #6.
Because is true that the plane state ignore_damage_clips was carried over
when the state was duplicated.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

