Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EB38C2D0
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486795; cv=none; b=SV12Ujwv8BTdCdmwYgSK9pQINR/fPqob1u6jz8ZVns6+ccNZ5PR5V9zaSyipXuYOOL3S1uVtnbCK74Om3K54ikPl6hTia8uRf2kRhI7lokryUWhZCEAGxaFmVfkFo2O9fjE0UmDUzbrwkKSxq2SuAnJqD8LSIvhfPmDG1JoL6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486795; c=relaxed/simple;
	bh=AxXokR9yTnXIXLj9Db4ukgIhemDv2YeEJlYdS2h6TgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY8H2Lo7gCn+Mk9iOeJ3xXdjlvlgRirfJTg+DHgpTxO+Jrip1dIIUnDO5O6wT2wO1YakX6jf544rBESXOYU9xLUeY2xsHE7RpnT0snZbvn3LMB4ZU0e6l/3LGXob9u+EketdBc2SL2D6WrDOzGsQB/1oq6u5RaN3S2u50HQIir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YsJviukk; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YsJviukk"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3141690eec.0
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486793; x=1792091593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=YsJviukkd+L2i+QOPAEmQWGEy+Qi3sqFfYHjM8kZPNHyxDviGTrrADrgnmRizjkq79
         tKK+sGWtRKhBa9a8nojTQxpHNdvm/yO4ytkNFdWgK/JAtBpj4EN8nKG5A8ZALDzmDdcK
         F6S15GWxjACHApcV91REtCeWtZnOyLoUxypA1E+ENwPcFmyLIWrxdIIHxP7YCfoAT44m
         GREBdiqOYkSd23WbYfI0KPHbUlJeoLmFWZb0jt5KM/RM0gMW612+34Y6jH8Gn6kSVWNB
         LJ4emMEKObjd0wF91sJN8Q2R/ifIjOS6Bg2YRvLlrVZT+VDm9Q2ZjSVxxLtE8NkhkM84
         nT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486793; x=1792091593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=M3HOGOt353AtkK/wrnBC6fyIRDyq/HTB6c4nAeKIfjWCrBY1i78rxblYNq21Ofq92u
         lMQkXeYdhAbe45+V51p4EvjJj0SI+MCqjnAv/GPf4dWF+aNrfGAmH6UKNJ8btgHOtd3o
         nHjW1lgaXg30Lnbd+ZkeiTwyygnKu9XwRq3B1iW0Ex0Vx092GZQu2KiW46+YMeHmtlaq
         VYRoABt/FZcM/qsNcK/cSAXa6lmal+aG0GnMNgkdNYXPny4XVzGEjbHfrTVbryVQqQqH
         cFVjj+Og9qqAPZTELbolB4FiL29u/NRUle/jIxaXJF0fy86gTL/b3mcBoizL4oz0fCbr
         4j9g==
X-Forwarded-Encrypted: i=1; AKwUvBwPpZ9umF8Ay8wWSoIPPtH2W0w7MqjQAqdy5snRTXtdezPXmkRyk9zXOpnjlWAodSZTOJBhiksKImtdmIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0JGaN2BHHwuKWZdLWv5jN3KEymvPPALd1h+Gxqg0kSGtGDdst
	6B5U2qggcHNscvV1dq/ezsuOzcvFTi6USd8xo04wnSkWM8JevjUq5dJ8HK0tlso0VRQ=
X-Gm-Gg: AYBFou0/SwUot35H+3PLxTD2l1JcReQeUNgzWzfEQ/+oImK1giGgHbawsG1U9/SQ/Ch
	HJv0aCScP0Pddtdb0J5YmOrh+1zwqwq4T+1aOJ/yCjaica/48+OqL38nDNeduLT9CGBalRi0kXG
	G9J4N7wzPUa8UhpoiPM1ln4kdnz+i4wzQhYcKHs9nQCyZuxIrg+DdAcgroDq4q7/7C0lcBpXjsh
	w9qK/J6OCZZx/mLwB4AtRK4+XXHlke06H/az++sSom5iuC7VpGGjBMIcwQ56ZNWPmEmQMeWpA2V
	GKwHHVjJq4h2DiBQ3YIG0o3PYW76YltAgVOwE9CKIsJSl3hKm10TQ2IkRqgkqqTsphqcmf9nS04
	DfhNWYJnH69UcDei0sGKd0zplS8rAeN5RtO7+WnenioHoMXsxIC00LDjGfd4ZYNYVuPRaN7f5nW
	7f9IstZ0U+aCPBkKT+NhTS7Y3kiJhYIxFg6jbMKoRMuyh2y7Y3N834FDEq6rk1nTBMYNH0SuUzZ
	4Edh3w1eQufuDesRrluZAO9M17FoE3MoMyVjbBf9ZKKPMzlA4R6mTVvY7BLq6SXA6i1Hxza2JFP
	U0uuZQ==
X-Received: by 2002:a05:7301:c8a:b0:351:7ec0:cd4e with SMTP id 5a478bee46e88-3517ec0ce24mr3629562eec.41.1791486792986;
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Thu,  8 Oct 2026 15:13:03 -0400
Message-ID: <20261008191309.98263-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21976. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. fbdev: hyperv_fb: Simplify hvfb_putmem
  2. fbdev: hyperv_fb: Allow graceful removal of framebuffer

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
