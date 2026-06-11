Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548E3CA4BB
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172638; cv=none; b=gk1yHDvhn++hfOKYkYi+Br2/2CgQo4v796+CAlRq6SPZFFyxg/thbp6xVWn8EWFrKDzR2xXmm2CIr2ZGWyj81FHC0nuqh7vBefH9anGc6sR67RpPaR1PYRnkpGjw5gpAxdUr+DaG3WMUdFYcaDLAdG0AdyLpgi0ecbVjTE3Sh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172638; c=relaxed/simple;
	bh=oPMscQPT7Ovr3uXegR35yeYCHSRNMFL4voLy9Xybado=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJ/fC7DvzgzHiZbqOInoknVnZ7RRxXao8X6fkaImjdp7fM7Mk+mcBGO87jRVaXrm+dx6TXxSn6OHpnv02RQWGtaL3py+kdq6mXjVfJLDQyfHDpeqRvB8U/i0xvjlPr4neBOlNR7QH9FDsjwjomlv/BHct6OmhYR1K/fXc41mkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWqqg/qE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON/ZQYvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWqqg/qE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON/ZQYvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
	b=fWqqg/qEEOeBhLTiXQh5WxsmVoRKTGr1GVdI4gJB/RA9tyWt61Ta7r5+D5i885hdF+V7hr
	b/+HE/ZO+JeZQG2lviWKUE/MbIKl66dSoE1DSNNFfYGYdYwL5xSyeSzlkRfNcD7R6XQ/NB
	RjtD+vlnBM15QU09C0/DzgBpVCzYt54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-F_RomDPmPhS8Z_hWmA1eDQ-1; Thu, 11 Jun 2026 06:10:35 -0400
X-MC-Unique: F_RomDPmPhS8Z_hWmA1eDQ-1
X-Mimecast-MFC-AGG-ID: F_RomDPmPhS8Z_hWmA1eDQ_1781172634
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso19152005e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172634; x=1781777434; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
        b=ON/ZQYvxQ3Bu78N5dWf8rw9SrbxVOJL50Ud7/+h/gucmV9pPWOMNLIpgWaxFtpbI/4
         dEThp43yNKrJ8t2VT2CNU/tK6AI7AxAHhgWw1ArSRP9X9Y9CqmQ0LjByF7cPjfB0kcF9
         CL3RW4nbbMAQx/3cRcEc/f92jYdrk2sA62aHk9Yjb874c1vz2biqHN78GtI2IdgHtva5
         CvM2Wo7c4CyJir0RfXDWtbbz6Az9Dv1R+R+Pq21FTSPlttOvhnlKNdghkzIF67GH2fb9
         64PbydklVv2Shro/AxyT2fXD7oZiE6awOmDmFE/gDiSMFs59jMMu4yx3YtqwkV8qwL1N
         fIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172634; x=1781777434;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
        b=R94fIdx3N6v41GOxGys5XO4coqzEsKGOfQdtVTRFHIrv1xVWqsZGpK0ni2VTlaX7cM
         yfI/rDMzp0dRDJNzkEwNtWm4nwxJ4hlnzfa903ZqdK01pkAkBXn0IpTwdTYWuW3erCvr
         oNJNm2Ac2ppLQnaCf68Kn8qtlsGxOKq95psMA59MwH7RmsYJ6E65d5E4/RBWmrBnD61Q
         02f292wCPGj5dZxBMK7xDtWizURnNMJ/Vw6Ka9b0mi2rfWiCWGLsffeSEgyFh41L+aTv
         XbhZNN4micyP63W3HFX/gdpsyskzJH9UnITvH3uSlpHrR5z++lMHrUc5eqVWglG81rCy
         PlJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RdB2XhdeaLU42KTQovjp8MwyJitDBMS6rg25mJBtb+hxcwkJEAi8pyN4aM65gLwR7JgiFUZIYSQFixTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsKQvPDw0yYm5QOYqEU/89Nu7hW1nVNDS7zupsGImjB5yEjLc
	5bVd0G6/ncSdYGY+h2Wq5Upzgflm+ZSEodug2Ni5xOMQxhIBJBP2ZtX5YKshJGLmTw61L7sqHyp
	89cP8BhKlABBXqBhfV09wRVDor3/e0cbiBOpiLvH+ubd0aR9KuVSZQn/HtNq+831/KQ==
X-Gm-Gg: Acq92OGzHwldzDMQOCsgp22UPkRG4r6uznYC9+mrdhBfOoxJ9bJY7OytUh54bPISm+k
	kuJ91BYx1Yi0Tn7sE2znjVrvHEuZMkYmWYMTs0eVkD6j60Xje6aOCwtpiIOoWa+LBlPvw1y/jtT
	6XOiOcwCnLmvgu2fiPG0U/k4oRAs6igcBXAvP7htH9qxU/zStoNXvK5677BL3qo97rRAwU27yvY
	5OB9zo8IWshcXLUOtqBjklDdpIzVmSujfgWReWUKTYj7Q+02/go+Xd6PA8XJHNZOiNlfKlBSgXL
	rSXt/H+DWaOn4Q9b64S+iZWfkhj6OV4lfD/yMewA4ZyModb/qh08VrMVdodPcSyRknypBpIxtDV
	zREQqsNYxBXEu9HFmyXbUCa4eOzE1mYj8DCHmNRuRbs9z7Hip3OP6PoYERxFuJfrH5m1Sd8Py97
	OOi+MgeGP9xZc0wls=
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id 5b1f17b1804b1-490e55dc1damr31237525e9.7.1781172633828;
        Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id 5b1f17b1804b1-490e55dc1damr31236645e9.7.1781172633469;
        Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52ac9aasm38076025e9.4.2026.06.11.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:10:32 -0700 (PDT)
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
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-2-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:10:31 +0200
Message-ID: <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in DCN code and do a full update in DCN code if it has
> been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. This driver does
> not do that, but DRM's damage iterator will soon rely on the flag.
> Therefore supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

I don't think that a Fixes tag is correct here? Your patch series
is changing the 'struct drm_plane_state.ignore_damage_clips' and
the changes make sense, but definitely isn't a fix in my opinion.

Having said that, the change look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

