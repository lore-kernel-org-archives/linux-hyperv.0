Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556441;
	b=xIlLcenlg8rNWhV+i1+xLlZrt3BNQrTk19AW+5tbj2/uU5t14A623PSfBW16nfnfnInL
	 pH9uR6nPvFh2u+Iu+1Ub0bvDeIro2Xq+QeYLxIm0Q8WvjnsXjMr50Yt1+kXpod9hHP43A
	 FRCnKDh74K91uvc/0W5g7zjTpZhHgtdrb2b1FmoFDk/dNk2tmeVWw5hP77g5BK0PmDqit
	 AHfYEuI+cGAHAdFc3pQa0PybzHVjS2wMNzUB8dg+tS51S2aohEkex9O7H3F5EDL68VBpf
	 COfU/ZX8jSy+qz0In4usJSJT/7hJGvI9FKFadvl9A49jcTuXQqexty7mqLBZEMCmmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8vTHmqosNip4PzWeUJYtggJ3iETjixMqdrHE7e2DIQU=;
	b=jzFSFjfD6PRNBF1/FrbYlEUoCCdg1p0mWEFakkatbp3vnJUdwQUXyDg47hsHJ0uczvg6
	 fLDWF49PxHNKptEKXpaR119klc38UmnrcGg8VNZi5Fd0905OFPoVCkMLwPfEguLBzSyLv
	 B0gOJ+t1NHBjkhXDLDzbwLxovF1YDtMM3CLWvOOci/djHZ/TcxkxCFRr3cIlt6fitbB8l
	 UVGYBW0eoJMu1IB0IP42L0sKh8kRfST31csY5Dti5OJ+tDKGN1lIRz5rK0XUrTXIuCdrB
	 6EQIShTRLlBwFzYSr3wos0otsfj8oF315HVEYgiw2iO/e/Vn8sDAlsMuGuHP7y48VUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dm8TZPn;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B21606A334
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 21:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B21606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dm8TZPn
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99e0b348a05so1376652241.1
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2026 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556440; x=1796161240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vTHmqosNip4PzWeUJYtggJ3iETjixMqdrHE7e2DIQU=;
        b=0dm8TZPnqEQFkRwrXxHnx5HZPGepIu1i6nigAX8fz59SVnfIllA8zMxlg3Qi9rP5Cg
         7ClvnriYq4VPEpzMNIS3/f8hggdOpXqQdl3PPfA2Oj8Hjl2Sa5Hbfhfp334XFOefTygp
         sObv+L1JJcptSBZf0n86Jfe7pgshaMgdFHPa9w3f6WSQSS2lDo1kvreb5PZYZGOfASXS
         2Uvxd/y/Aar6NS3QS/KoCASWJJLTnEj63HO7XKyBhwG8JvCGCZeyNduZeNG7776oJVTb
         5sqlxeuIzjpa5Jj0XO9Mrd4a0Wm2x+0wKX43lKE5COetTQqfkPwO//WKpKovDnUblHZo
         uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556440; x=1796161240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vTHmqosNip4PzWeUJYtggJ3iETjixMqdrHE7e2DIQU=;
        b=pSByMRX25RHODGKH5ex+AFcVXXigk3BBG1psHjqBouJGgrd9tTftqmSMQfeTAkHE1q
         L+D8rI+ZSuXzoWnJ9nIREr7ZGIfOfAx8E1I6js3j+q98xIWucpaPu5q2wVDH5ziKFSpS
         GHF58xqpgOZi7JRFdiAzq3wBq6gnlwUp9HvVCbhoAJo4zwWntaSQ7AhzV2v4MyK1ir4+
         qqXdhUBwMOOYkQOJXSLtXzi0GA9UkY4NZ1Sm2mMng4hKYc/33/52Ie5BJ59WFOPNkOhL
         swKy0vuhPtINGKLGM13ptwSUR2inP4oMepc/tJYW/v1f+ZXxnYEn5XMbYL/rq/1dzPw1
         xktA==
X-Forwarded-Encrypted: i=1; AL+hErHD5I12sKjNVcAo1ghl6CoaFR25Vpydlf095f/yP1x0tGdA8HfowP2BLDI1BqpirlKFcixgl30/FwDTvso=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uux+VibPT5aI0pN1E0O0nvKpYk0BT2qHYSuoMkJA+pWKnpyUI
	VNexp9vjGUB8Dkyu3XpbgwZJWNX17KWhrJpOQGRQe7G4I/DMaLQYM1U0
X-Gm-Gg: AZFdTZc0z9Vrh/7TW5mWFttg0A6qpRmkI9XCIEgHPyvUFuoF65akFz9KbmFrC/zm50J
	/KXG2uwhrzVbtCgfHO/u/SEosBBqY02dlPrPvofHn4atvihS/j0zsskMF1/R7y7EaXIMZ9CKPIp
	mhNLq9KdoqmQMqWnwQ3mo9i1crjbSgQtozR8QZSaQEA34xvHyQ99onoQb9+FLaivJTSLlNOlfy8
	L+Qge4raxVFF5OlpZxjnEkwp/oSs1Gv44n2ym4XAvYlm6zEEGt9l+k7A0WfJ+zj/fnlbN3cAnAo
	rZoT0wAHZcFcA+EupDeaspBO9I4x9JKgIv/bTukQ6ICehfLervuwWWS/F6nEtJTZ5pv+wVLRXq/
	yN5lxIN8km4p5plIMP2H1LtG9rA6LPq/TuSzovUscSIFPfWk2H+QF8jeunlALfOC5wn5UMGLN9n
	++YgDLd5Car1Y4hPQj28f4j99YU+scp1dnFd0dyWAeJ2Hbd7LwterHM5IBksv5pnXHAm6W1O99v
	htlLZf9hQtaBVrZnx/0zaNwalMoKRsfD1e327DbGK7o7xC2qR/ob/UPT1InxytqXH2fgnytY6+0
	4IIiMaXr6ScOAqDxCM3mb72CoDyXj4CCMY/ZwF2Pn5nB7gx7Jyxr
X-Received: by 2002:a05:6102:292a:b0:7a6:d11b:16ea with SMTP id ada2fe7eead31-7d73935fb84mr8027697137.6.1795556439674;
        Tue, 24 Nov 2026 13:40:39 -0800 (PST)
Received: from emedev.tailf75c28.ts.net ([179.238.117.100])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm15952879241.1.2026.11.24.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:40:39 -0800 (PST)
From: Emerson Busson <emersonbusson@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Kameron Carr <kameroncarr@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] hv: vmbus: make rings and host-visible buffers survive buddy fragmentation
Date: Tue, 24 Nov 2026 18:40:26 -0300
Message-ID: <20261124214030.174246-1-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Opening new VMBus channels or subchannels can fail with -ENOMEM under
memory fragmentation even when plenty of order-0 pages are free, because
vmbus_alloc_ring() asks for a single high-order contiguous block (order-7
for a 512 KiB ring) and vmbus_alloc_requestor() uses contiguous
allocations for its request array and bitmap.

Based on Michael Kelley's review of v1 and the v2 feedback from Wei Liu
and Michael Kelley, v3 goes back to the core VMBus allocation path. It
groups buffer and GPADL state into struct vmbus_buffer, allocates ring
buffers through vmbus_alloc_buffer(), drops struct vmbus_gpadl along
with the duplicate decrypt/re-encrypt paths, and switches requestor
metadata to kvcalloc().

Changes since v2:
- Dropped the reclaim workqueue, UIO page-pinning layer, and KUnit tests
  to keep this series focused on VMBus buffer and ring allocation.
- Split the hv_netvsc fixes and allocations out for separate net /
  net-next submissions.
- Preserved hv_netvsc's revoke-failure leak guard before GPADL teardown.
- Rebased onto hyperv-next.

v1: https://lore.kernel.org/linux-hyperv/20260918014017.2536753-1-emersonbusson@gmail.com/
v2: https://lore.kernel.org/linux-hyperv/20261007190752.336426-1-emersonbusson@gmail.com/

Tested with x86_64 (W=1 C=2) and i386 builds, a local QEMU/KVM boot with
lockdep enabled, and a backport onto 6.18.64.1 running live on Hyper-V
x86_64 (85 VMBus channels, 12 netvsc queues, uio_hv_generic loaded).
Confidential VM paths (SEV-SNP, TDX, Arm64 CCA) were compile-tested and
reviewed by inspection only.

Emerson Busson (3):
  hv: vmbus: encapsulate buffer and GPADL state in struct vmbus_buffer
  hv: vmbus: allocate ring buffers via vmbus_alloc_buffer()
  hv: vmbus: allocate requestor metadata with kvcalloc()

 drivers/hv/channel.c            | 363 +++++++++++++++-----------------
 drivers/hv/hyperv_vmbus.h       |   4 +-
 drivers/hv/ring_buffer.c        |  17 +-
 drivers/net/hyperv/hyperv_net.h |  10 +-
 drivers/net/hyperv/netvsc.c     |  64 +++---
 drivers/uio/uio_hv_generic.c    |  97 ++++-----
 include/linux/hyperv.h          |  43 ++--
 7 files changed, 271 insertions(+), 327 deletions(-)


base-commit: eab80895d447ec164a1d91a1ab377bd3a9dc9044
-- 
2.43.0

