Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C193D7D6A
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962285; cv=none; b=t5unlNFy4vxvkDRDBxMjoD/MVTZN+c38RhAaAO3w+ResU66Qb6jfOTliTFDTigIChW8WpDV5fnhw5MMouRKvV72CeofpvavHTCTbdIHW4Vthsyyx3XTa/tzrxa0Fl6YsIDRfliFpOj8s0cHf+V4gUyKDnhDK4O6x/lnNnJuhX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962285; c=relaxed/simple;
	bh=GtZBxsNY2EVbCMppOi5bGS4/lroKa+sClEkbYM3t26w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gnhg8WzGjljlNPX6fOBBjwJF2yTI1+z37/tiVjReMJC/Hgo/GC4BVTVp/6OzIo3ypfhgrXt8GL2P9O4fCtYQUi/SgKQAVEREgyqxAS3ZMbbntLr9dTFx6sdrpc8hU657lOxv6KxP+f+QAirv9GI9gcmrIW3UIzva2LYgjF7I7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9d72vjq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9d72vjq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d032846c95so19924715ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962283; x=1786567083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmVh4KRe3hgz9m4MpvFISw7w1ZAAFF37oKFJENEaSMU=;
        b=c9d72vjqdIH5bRETUjyvJf5/3w1n/Wj5J6lQm3tTUIBueeoZWLy2wrU7YMH/Wopaiy
         ENJYhmCNUBjpk7CHfliuOGZ6TpN6mScv/BoUEN2WnTV25iaEHlc1BJFmArgPnGx18+Hr
         X0K+KRnE8LIO+aOfi2UBvA+GR6EElU1C6PpwoEXSksOmNx+bC4gEIbVGO2nu9oF8V/Sw
         gyD1LB2APYxO29wKY7Hb0Jk+eZGvz/kljfbJo1yluqLv9p5TPoivS/FHKdX1cgNoK1B5
         EB79Hg6Erng5S/RdZASYithZmLN+pCDLwwCXPR+pcXWa4hrGuH0MLTNHtknE/xuUzp/S
         c4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962283; x=1786567083;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BmVh4KRe3hgz9m4MpvFISw7w1ZAAFF37oKFJENEaSMU=;
        b=FReNmpqe7ygQtNuQiJSRjBoSoSbtGm7r6fIyC0E2L6IsN2Vjuh1Kk3X605zn7/M395
         uW6dWJKS5P1thRd6/04RzwQuo6c9ODdad3M7XND633IHiYx1RAKzc9LVLGi/+VDEelqj
         0SNnl6PJQ6Xa0avvpHEGJLIv/SsgVA3+WqjlTanvqXcCsMagGP1g0uqETZ14e/LDH4/0
         8tSBzo097njQxQVrs2qAdS9mfE0UdFWnsgLn31swe1G48UYFRPNp6yLZwcep/1P2pugw
         CRsLPApSckCygLUfm7oJ78nArplV7L3Yadi2M64czr5Mra8+CwviwWruG1ZsvNQ4K+Iq
         DMkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1JTMcO0HJL8lgRftC9jtW7q2NYT9MXbBSq72aVt6/NMOA+xwcced4KeYfnt/nIhmjmKhLFwud68+eJZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKIT//nLXgjOspnulBTFX+xqeID81Y6iVSL15mpV38985pk+N
	aSeruIwJGHBiYLXipj4hqe0/0JKZ4f5B0JPcr7SHWrYlKwxIZL1TowzD
X-Gm-Gg: AR+sD11GWu6rvJmzN1iJpkbYWVaeW5icuNfhUWTiTNpajmUgQeNL2DEI5DvcnVUrgO2
	KREeMCCD5fTvHHXeGstvYcJxFI3qVp/AxmRVpVIaIpNeJP+3ZGoeNnVZbzqIE+N/KMB5zH3vN++
	t1HlGHBVZ6p5iWsn24dK/QlDVdtjXmjRqszvREKZZqvLGUhH4hOMiZtxQIcC4VTvas+IYvVWU1b
	hgSNy7K5IzUma66sfBo4B6crOT9LcoDrIfBJlMvsgxSmysGMYuXjZZjDN5UThJIMzpkZF6/24Ke
	muLz849TLT0FSgVU93gZh4XOViBVrOVRHX07rUOzGLkzpAnnsdEGBo2yOyPlfngL/5gv5CGguml
	a64ofciCXxTHDRTEi4KRedi6K2/CBwK1TlARHxXKcpBB+6C4InGO6odiRwm5ReC5VQL2LFJAQxl
	l0K9bFeN/X0P8NIh32LET6u/bbH1/4zVeNpUcOYQmlH0s+8O9oa3R4A6msi5pOGDwqGX4nLuIH6
	oLTAqhHuRPxEfXSv3o9kEvNe8/V7P6TXlgEmJuGbmo=
X-Received: by 2002:a17:903:4588:b0:2cf:477f:57c5 with SMTP id d9443c01a7336-2d0ca71b42bmr109216615ad.1.1785962283175;
        Wed, 05 Aug 2026 13:38:03 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:02 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Remove support for Windows Server 2012/2012R2 & Win8/Win8.1 versions of Hyper-V
Date: Wed,  5 Aug 2026 13:37:45 -0700
Message-Id: <20260805203751.2678-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux code for running as a Hyper-V guest includes special cases for
running on Hyper-V in WS2012/2012R2 and Windows 8/8.1. These versions
were initially released 14 years ago, and official support ended in 2023
(unless a customer has contracted for extended security updates). Given
the release of subsequent versions with improved functionality, there's
no need to continue to support the latest Linux kernels on these versions
of Hyper-V. If someone is running Linux on one of these older Hyper-V
versions and doesn't want to upgrade, they can continue to do so as
presumably they don't want upgrade the Linux version either.

Simplify Linux code by removing special cases for running on these
old versions of Hyper-V. This includes removing the negotiation of the
VMBus protocol versions for WS2012/Win8, and the special case code based
on those VMBus protocol versions. Changes are in the core VMBus code and
several drivers for synthetic VMBus devices.

Some VMBus drivers have device-specific protocols with the Hyper-V host.
Further simplify the code by removing the use of protocol versions that
are specific to WS2012/Win8 and earlier.

Finally, the WS2012/Win8 versions of Hyper-V were the last to use
messages to deliver synthetic timer interrupts. Starting in WS2016/Win10,
stimer interrupts are delivered to their own assigned interrupt vector
(called "Direct Mode"). So remove the code for handling timer interrupts
delivered as messages. This removal has a broader benefit in removing
a key blocker to disentangling VMBus code (which handles the messages)
and stimer code, as they should be independent of each other. The
final disentangling will come as a follow-on patch set.

Testing:
* VM on local Hyper-V on up-to-date Windows 11
* Added temp debug code to suppress Direct Mode enumeration. Fallback
  to LAPIC timer worked as expected (x86/x64 only)
* Used hv_vmbus.max_version=0x30000 on the kernel boot line to simulate
  running on WS2012/Win8 Hyper-V and see the new error message output
  when VMBus can't connect
* Azure VM DC16eds v6: TDX CoCo VM with HvLite paravisor
* Azure VM DC16ads v6: SEV-SNP VM with an older paravisor
* Azure VM D16alds_v7: normal AMD x86 VM with HvLite paravisor
* Azure VM D16plds v6: normal ARM64 VM with MSFT Cobalt processor
* Not tested running in VTL2

There's no specific urgency to removing the special case code for
WS2012/Win8, so if the broader Linux kernel community surfaces
a reason why this clean-up should not be done now, we can wait.
But I think we want to eventually stop carrying around this extra
baggage, and based on discussions with the Hyper-V team within
Microsoft, we're past the point that it has any value.

Michael Kelley (6):
  Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of
    Hyper-V
  hv_sock: Remove check for old Hyper-V hosts
  hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
  drm_hyperv: Remove support for synth video protocol of old Hyper-V
    hosts
  scsi: storvsc: Remove support for storvsc protocol of old Hyper-V
    hosts
  clocksource: hyper-v: Remove support for stimer interrupts in message
    mode

 arch/x86/hyperv/hv_init.c                 |  17 +--
 arch/x86/kernel/cpu/mshyperv.c            |   4 +-
 drivers/clocksource/hyperv_timer.c        | 150 +++-------------------
 drivers/gpu/drm/hyperv/hyperv_drm.h       |   1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  44 ++-----
 drivers/hv/channel_mgmt.c                 |   8 +-
 drivers/hv/connection.c                   |  11 +-
 drivers/hv/hv.c                           |   4 -
 drivers/hv/hv_balloon.c                   |  36 +++---
 drivers/hv/hv_snapshot.c                  |   5 -
 drivers/hv/vmbus_drv.c                    |  10 +-
 drivers/net/hyperv/netvsc.c               |  20 +--
 drivers/scsi/storvsc_drv.c                |  53 ++------
 include/clocksource/hyperv_timer.h        |   6 -
 include/linux/hyperv.h                    |   5 +-
 net/vmw_vsock/hyperv_transport.c          |   3 -
 16 files changed, 82 insertions(+), 295 deletions(-)

-- 
2.25.1

