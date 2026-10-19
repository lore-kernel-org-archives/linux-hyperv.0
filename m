Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424539;
	b=L6ZjYHCSCwrvq04PrJRF9xsNcVno7GUR0hsewFbejyM1APsB4KRfAUEdcF0ColCsieBJ
	 LOjhrYcvg+kpqJ+90NTTmmeXkWCDi+iL4gjUWaEb/Wq7+ijNcMiuDaELjMCodUg8QCEO0
	 wilo9eEpRnjzoODlrz8Jx/46Rr33YvVyuMFrLgGnnm4PRekqEze2Hvt/91XkQfxQdmw57
	 mXhgVoqhvhZGkAsf5GAHxSvLCS7MMLRFIeoYFSkOe7SsRGSOjiK0F9wMRfz52KrToVcqi
	 0vE2bx5yHeEXkfbNcrg0TjuQpC6JHpYQwMWdDWvTXq+skVmkMKABKAmRdgZH3cE6hjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
	b=qQek/FQK8JvA1x4cEL+c/z+9O8/MQMB3JfZUTFUa7qQqt9pUzJNR+OXbs61Lr1n9tfkN
	 IdUP5s86t0nJ7O5kLtNY5B22fLA3bXbOn79isXKiI8U2ZYAil2nkEYTW6X50QY3Er6AhQ
	 aqVFR3BaAlHsLtGelUg+H+I33Xiu+I0E1HH40/Yxf2Z2xqhYq6htfiGWh4CkRJZvCw6bd
	 ABssTEePl9B26ZvxG85QoeU72Meqg66F+dIckTMjUGMZrWxGxgJN2LZxVsz4G6TCNwVzd
	 1Jx/BMQBFI698pGj9BOyPWFKT++VneNCjxeXHW+8Me9SPEcFYpQVZ7x93b/70yiNRtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtrAjbZ7;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49567606EFEB
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 15:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49567606EFEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtrAjbZ7
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd623dfe420so1700709a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Oct 2026 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424539; x=1793029339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
        b=mtrAjbZ7SAOmcOlZpgZxkhF3asxHxfJiQO3A09sNBNjc7sZcnqZ8/tI8OPhNsV76aL
         icwHtvXRU8zBKnGPZBb8g8/atROCdBAspRO3AOnTaGDloW5UL1AOKpaCJgfFA0w61vUt
         Wb6OWovFSxtr/1+hN3+q3+/ImDqABvueQrSaunej4SdbfvoDodpzUp3Osj1Qw9PdvBY3
         Fd1GKV2p+YYThzzjPGaZ+cjSiaCCN9iUM+Yz95vkA71FreJNIZ1JM+VsZ1kT44ehlZy2
         hgfjd37pjAxY6+EaGK0TzqFpaiZIvSdFGjXfbDIrCMGIkDkngyQji0Dmd7OkpBImGojh
         pUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424539; x=1793029339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMgrhjGDM6hEQh8Aw9yzZbHzALMwxiGfaVEBL4NiDa0=;
        b=yO5kjpmGSLI92irXGNj9YLdKzekuXDPDKw/JvTMMBv7nRZmE63zm1+IvvNTCD38hi8
         L7sIpo6jBdS7adnEodG8KA6pTJIL3mhRZNzUcSasvO1NhdPTmTE/VPK5n318rcE18hfu
         i13CVnp17vD9ZS046zDA9/vVLC2XxG3PeusXK7r7WR578OnSEOr+VY+zDoFcZbm+78le
         /6auK3y9D+XWfI3SIF/ovKNVTQB2fgFfwOw69DBYz6GWFI86L3mbWMG12R5836iZesv1
         PYHaEDx9/6IBF6Wv2KCfAjFd5+YqL8lLTf6TV8+V+IZjYb0bNQTxLHcF0e+vY5fHI4xv
         WeIA==
X-Forwarded-Encrypted: i=1; AKwUvBwPPEFyy8RtOznRneUw09hdMJFLyWqSZ97Ki3AO4AjNaGlqGvzy1bG3kTkFxxBOBs0nBSY0kt+tEoO16Ug=@vger.kernel.org
X-Gm-Message-State: AFq9FYIilsLtEeQxmZ96dkaAbtZJxGmJlfjZHpH4t0wolWGNYrXKCLzb
	rgSmzU6NzU1zNnvdgm2KcR9LIvsL0LEfwyM5nWpgJMCpO95/BBRd+sA8
X-Gm-Gg: AYBFou2OT/VDDUh5uqslV3oGoROpiWu5lE3iiEvwG+X47iKULd2ZEtQc2atrjbvjyjy
	fOQk6Kae0jbz4Im37wa95k7ZS2/hUxf9aisaZvlZjGxUXTVz9kD9vHbfcnhbKvtgbdrtt5lpga7
	xfQJnjOHqW7tTCnxdd/ffuQMTXQiYV5hEaIXbB3cMvOVFiAG1Hk1rPbKQfn3Km1L61xA3qgKxkP
	prCACrEnHt/PAYt2436mo2nXSaFcBUBOIGqYzgbRg/cl0RMdIeSyRekULI5agQ/65n/rII6DDXU
	gx/nFl6LLtHJGTuPPCGzbTpZC03fb6GbF30a1eLGmuscZ9olblMXmw7cFc8NVBk3IJKBuB189A6
	HZQ31Az3fAAR8T9hckAgNL+mewhR5Fz73D7YeOG8XhuOceFvHX1XtCBRSUZMh1azoW8+pAz2XgJ
	2Rl7QLZ3lTga/hwAgiKHlfbflJKWRZxOCYksD/T05Cx9DOuUeUdnF/dYQcRpbNC4P18UCz
X-Received: by 2002:a17:90b:3d4e:b0:3ab:2c2b:1026 with SMTP id 98e67ed59e1d1-3acef0c8911mr6398917a91.34.1792424538542;
        Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
Received: from hachimi ([101.5.170.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm3926364a12.20.2026.10.19.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:42:18 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: tzimmermann@suse.de
Cc: airlied@gmail.com,
	decui@microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	regressions@lists.linux.dev,
	simona@ffwll.ch,
	ssengar@linux.microsoft.com,
	stable@vger.kernel.org,
	xlfylawarthur@gmail.com
Subject: Re: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Mon, 19 Oct 2026 23:40:43 +0800
Message-ID: <20261019154121.6257-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
References: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas, 

> Yeah, what's the cause of it? Switching off features does not fix any
> bugs or improve the status quo.

You are right that the module parameter is only a workaround for users
affected; it does not fix the underlying scheduling problem.

The cause is that the synthetic vblank timer is used to pace completion
of atomic updates triggered by dirtyfb, in addition to providing
synthetic vblank events. In Xorg's software-cursor path, pointer motion
damages the primary framebuffer and the damage is instantly submitted
via DRM_IOCTL_MODE_DIRTYFB. The Hyper-V dirtyfb path performs a
synchronous atomic commit, and with the vblank timer enabled that commit
can wait for the next simulated vblank. Under continuous pointer motion,
these commits dominate the update path and delay normal client updates,
resulting in sever frame-rate drops. 

This particular regression results from the combination of the blocking
dirtyfb path, synthetic vblank pacing, and the absence of a Linux DRM
cursor plane in Hyper-V. While the Hyper-V video protocol does have a
hardware-cursor command path, the upstream hyperv_drm driver currently
exposes only a primary plane. Cursor plane support was deferred during
the initial upstreaming [1]. Without a cursor plane, Xorg has to fall
back to software cursor-rendering path and it competes with periodic
graphical updates on the primary plane.

So the proper long-term fix could be adding cursor plane support in the
Hyper-V DRM driver, which may take some time. Providing that the stated
purpose of the offending commit is to rate-limit display updates, while
its current implementation regresses the existing software-cursor path,
I think adding a switch or reverting the commit until the requested
features in the driver is ready, is a reasonable short-term fix. 

> We had another fix for a problem with vblank timers:
>
> https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/
>
> Did you validate that this fix is unrelated?

Yes I tested that fix and confirmed that it is irrelevant. It solves
issues with excessively long frame durations, however this problem is
found in normal frame updates (in my case 60Hz / 16.7 ms per frame, way
below INT_MAX).

Best regards,

Lanfeng Wei

[1] https://lore.kernel.org/dri-devel/20200622110623.113546-1-drawat.floss@gmail.com/ 
