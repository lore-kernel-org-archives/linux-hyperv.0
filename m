Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5C396B8C
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442304; cv=none; b=ifVpZTpiIBA2E4Vsa9Ymk0wPdZLEq7jSv1vUm1zx0kD5ZJTuvmUZjWghP/SuL9molviTZLzKtdJ9Bbimlrd+X6J0+m8DGD7OX/nTPBbBT7kDLCgkDm4bEwYRg36yFNhlE/5QzDsbQOuPgjRZAnyQ/Mxu0pS5qtZiyU2RkTnU4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442304; c=relaxed/simple;
	bh=kG0V+A0XD3vYLFfqsb3MVX9KgiOaGk9ZgE+CUb0lYYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qnzbhz8BCZ2O6hG8YKl9Qi0G7Kua5z1IYd8RRZpZ+k2qjQVeaLh3mYjc7h12bfPlaoNIfePdnIX+Hjdmh991CARowtvz3P59hMXC4TbGfGqh8yr0DEz0c+DMih9REbokTpG/eWdcy3LeSxy/mHvPnOvtm3CIsim/TShPPgxYZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuOVa+dM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuOVa+dM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487214ad2bso436846b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442293; x=1786047093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHhFvDLdT6/nmSmrERMl9Q942exbwnTVnKlPTxRQFfM=;
        b=XuOVa+dMzlyDnn1BPSEEkX8oQBMdZwJU3JHkj7ujkeimyVzNW4XtIL0ta4GZOCF5WQ
         TqoPWfhu3/KDNjOZuh6sgU45OT2fh6REyZTbi9wdDzAm9GPFSdN63bpGnNu68Q5ekCsG
         VXXAmaXJncYUeWavSekd2+APgLcqTC21lnBfWVigp3euL/NYsJeU8+5+dV41bWusPaUQ
         qfp0hlMBpS72XQd9F4YNNdLna/zgBC5qAlUEXq8EAPy9OYQtlrtJOG7k/Erv/PcdZvL8
         F0Z8s+vUf1qeQvqOvenlNMgXdVph70GggaKYJY16laaBcroDHt+CDCx+dVaubKYGXfRK
         k5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442293; x=1786047093;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHhFvDLdT6/nmSmrERMl9Q942exbwnTVnKlPTxRQFfM=;
        b=Q2YamFlo1xGSf9e6JaQthNDDNIQaWKs3tdrTOxnDPflBnFueFqlpPAVfrIbDc4Kb4g
         LLmcfJW+hRbuhoxh3Y6dnvWy0nojd/wnyLFdOu+F37g520bpFW54nsaJbpZz5MDsedgD
         MKW8oM/lkSWOAkVdb2NEXwkZzV8wx3FD5lLYwV8OoaNDkf571bf0y8KWMyeEyqiv09DF
         4+i94PIMWy1KOudWKGt/DmkEtuFRDF+49+VI0MBkOFDAiuX3Gkq2r58ZCg4erM/o3xGG
         VGR+fgnL2TBUcgE5P5SzL1uoyoIs0IdU4DBy/SXkDnV/pvlU0huk7jhckZSSerUFKxLT
         NaiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcoYH0ixwpwHXcL5SZYo42IOqSX4JwL8BNTL7uBO3QpE8SK2Kz/UW9jX9D9XjBFW/0oXolIralbyqMwwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DNC6S6dwjKJ/M6ArPa1Uh+nv85q5/8CfqFrfAQgqWSZgH8Tl
	eYxICPldjEfkpbewENJKy202/OdzSg7XAvVZOc4P9b8XMemNw/rwOist
X-Gm-Gg: AR+sD1386FXMFr87aG5JFVXxGnFW4NvVZRqohGDP8PdlC4yGjXE6Pg1MHkTUMB9oaHB
	E1rXJBk5Zs5KJzNSh1sSPt3R+ut3WXhGPhyQD9VcfxlWxCCKX3rKNr9n9IV/LaD4/ucZMG4W16U
	6XxDVyHgO3HAj8RNfmtkSJR97RbptNwc01HNFbtF1aWFV4AYdn31KDOwNDEeI6x3w6s2hjE8jIg
	84ZDlovQsaJGopXy2etVCrf+U0hmThjIWUTtMCEhb5BZhmGvmfQuhSU6KOhIhExUlCJHgTuijRM
	F+5Iik5KEVAvvzvVu31UVgENiYCrtF6hBNq1OJtiPO7bpjbsXD0BgdvTxkGGe+wRwqOtUjfVliP
	jWqoY3in8w3wKH8Fi0zz+4xPK1nP0SYspUi6SiqSmvB4Bk1ZKbe1ix/Ja6huwRs7BiWMHfnp3IX
	5lCMUY0WrT6DNGBPM58f/+B87zxGSw6Idcf27HFDtBWhbE+/fQN+rx3W+GZNKnC3mCLmwos/23i
	j3u6831/C6VH7+ENV0Rw/TPRL0Bz+TtZ9Oi8OmqB0Y=
X-Received: by 2002:a05:6a00:1150:b0:845:d284:9e0a with SMTP id d2e1a72fcca58-84ebc425164mr3944086b3a.49.1785442293425;
        Thu, 30 Jul 2026 13:11:33 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:32 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH 0/6] Remove support for Windows Server 2012/2012R2 & Win8/Win8.1 versions of Hyper-V
Date: Thu, 30 Jul 2026 13:11:17 -0700
Message-Id: <20260730201123.1767-1-mhklinux@outlook.com>
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
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  33 ++---
 drivers/hv/channel_mgmt.c                 |   4 -
 drivers/hv/connection.c                   |   8 +-
 drivers/hv/hv.c                           |   4 -
 drivers/hv/hv_balloon.c                   |  36 +++---
 drivers/hv/hv_snapshot.c                  |   5 -
 drivers/hv/vmbus_drv.c                    |  10 +-
 drivers/net/hyperv/netvsc.c               |  20 +--
 drivers/scsi/storvsc_drv.c                |  53 ++------
 include/clocksource/hyperv_timer.h        |   6 -
 include/linux/hyperv.h                    |   5 +-
 net/vmw_vsock/hyperv_transport.c          |   3 -
 15 files changed, 76 insertions(+), 282 deletions(-)

-- 
2.25.1

