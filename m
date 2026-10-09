Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A964EB84C
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567636; cv=none; b=nL40zFBZZ8j2JMmeTrLWe3Mj91t80dQSF1eCgTGlM3m0527zQUkLGaucO5JTTMlFxtGZW/iyQf6ZbzW3Y/gCucbdyO6xRJGSfeMJEmx9a/LhES/BSSM54zckH7NmfvKHZZy4LSQSxCIsieg+3PyVF8Us5AtxIENfzOYndfCGtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567636; c=relaxed/simple;
	bh=k8aejIH4girCnHlnsmhW0AOY4LYP8I4Mq1RNU11YCWM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kvQXbDy9BBFf4Scur4B7rKQa0gL5REU9mdPcD1x6CEdTcEZh74mVwhL54ed5sRUclwdGN0PP33ms8So1cCHAfZ78FMqGjgnXakPeAMPfPKmU5Pt90IoKXHEwjR/m9M/gz1+RSe2UFpHCf95T74qtlodURMXGVx9K9FC2M7bqEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9zSOP7C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9zSOP7C"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab066bef7dso1341411a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Oct 2026 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791567634; x=1792172434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxguw1uDTuEJffZkA0RjIlXZRSyCjRzPKT3u+yYZHzQ=;
        b=m9zSOP7CMCUmZNzkXqoKyJQSj4cgqFc+K9oLqhVhIKCpUKHbfOpaiVIVZU03Ek7z2c
         jLJBGmvZzX9kx2YXQKAonZhFNlLmXecOA6xfxJarHDvdn7Y9a+A+jpLwdynMME6Ig9jd
         CKWQF9hnaTYzEQE51THglUpxluX897guBh1wRfkDUy2FFTBM/dLRPeogGwjPSluNoozm
         V4wIgDO3WEnEa1dveaZynoahNmHWYSujlUaGkpPczuC08kphQOWbcBZxVzc0OmBnC6qt
         v7Bq0yPUCUM3JnZeBInv2WN4/sJ7x/OzHvL9n36YrkgEcNhU0Bm+ioZxzY8D3sFI6uau
         /lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567634; x=1792172434;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxguw1uDTuEJffZkA0RjIlXZRSyCjRzPKT3u+yYZHzQ=;
        b=OO8k5aKu3Ntylo4GgsDr6y/56pP9aorU4dTkaVmujHIDUSQmbj0VYPR7mpkCAdQpq2
         cuB9IjEDT024SjQwMjxNl5J6gsZv58OCAvRRUBELfi9Qab3+8g8ZDbPBLOenDBPPiUfh
         dsCLWxEhIXWchNYKrVHrGHlovYsjDZtOMYRjAjJ4UgAMeA08N6km/FzIbjcEsN0TxuzP
         R+WNDBgIzkMpjn7HzhxtMJZvnl8Ht60dFIC0bB2We36nE7Vh7NC1vd90KvMrO3HF641v
         JHTywBurQy9HiX0qrY1If+P6pL1uz2kSkTZ/TiO1vngZX3RQETUmSxz6Y2ECw1mqZG7b
         LO/A==
X-Forwarded-Encrypted: i=1; AKwUvByxPt3q4WX0MB0XRN4EXkr1rtuIC0ZV9HljG7SkJlCWy/9jL3xpwK3d+FVl/+cJAoGvNaIZRJtmwQvMbOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu8+pzsvdLVLCRgTcMm8qXYJigWDehjT3s6Oc0ciQKqXEy6U/y
	4+mKuDC8vQ/rzG0iVvUleGP3lHLpLoVpEdg1EsMEnpg5/u5IqR66Hdds
X-Gm-Gg: AYBFou127FAEVKZoMUPUihFmNAXMBdSso88P/onZhsyVFJrjPYW86lD+UHWcnEX7B4A
	w5b89Jax4hj2BvUp1g1+gfpgEBIlewfTkIQkHN+K039fGk7wehqV2uqi7vPJ9qiRJdhYjZB2Jgb
	n+6GYCTHwvrOhC2SA/JQZL17/rxO2BtMNHd8z0HRFr2iaI94CHczIyYFN7qPXuq0Yk0xmkezpz6
	m02am4LJivtIsSrfJZijnUqzhR7/sgzG3OMp98h221qAPDHPCpGVrBAra/9jXNl2GGK75qkznbD
	m4/W6B5YXhycHa7vgY6YUHjEBpdoQ0Da6exizc+qqWugYezlsjVcaCfcd4MEMrkqsbS7OQ0oI+G
	LSPkuSVnEOzheows4oEjsYv1OgAwCr0ZsvSKObIfRi0YLh+8cowGK2oFv+WS2dcUb3c8yY9s34M
	hNLx7WTBvlyAkKC1BSNHnAUO0VzrHqjmeRmqYtNYdQDsxY4h+UlO5QAoFQ1Pr+Iuje0TwcomXcG
	H3AwUJ49ZD2qHgXUSPLegFmBQE2GJp7pM+vvx2CmoTcRyC80LznnBvD0jx/TAoP
X-Received: by 2002:a17:90b:224e:b0:3ab:1323:1012 with SMTP id 98e67ed59e1d1-3ab3a32ff26mr2282751a91.1.1791567634272;
        Fri, 09 Oct 2026 10:40:34 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab338676besm2726448a91.1.2026.10.09.10.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:40:33 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/1] Documentation: hyperv: Remove support for guests on Hyper-V 2012/2012R2
Date: Fri,  9 Oct 2026 10:40:07 -0700
Message-Id: <20261009174007.6745-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for running Linux guests on Windows Server 2012/2012 R2 Hyper-V
hosts and Windows 8/8.1 hosts has been removed, which includes removing
support for operating Hyper-V synthetic timers in other than Direct Mode.
Update the documentation to reflect these removals.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes since v1:
* Updated the netvsc.rst network driver documentation [Naman Jain]
* My "below the line" comment in v1 wrong. It said that removal of WS2012
  support was going into 7.4. But it is actually already in 7.3. So
  ideally these doc changes would go into 7.3 as well.

 .../device_drivers/ethernet/microsoft/netvsc.rst   | 14 +++++++-------
 Documentation/virt/hyperv/clocks.rst               |  8 ++------
 Documentation/virt/hyperv/overview.rst             |  6 +++---
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
index 616f808e885b..0d464706a59a 100644
--- a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+++ b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
@@ -7,8 +7,9 @@ Hyper-V network driver
 Compatibility
 =============
 
-This driver is compatible with Windows Server 2012 R2, 2016 and
-Windows 10.
+This driver supports Linux guests running on Windows Server 2016 Hyper-V
+and later, and Windows 10 and later. Support for running as a guest on
+earlier versions of Hyper-V has been removed from Linux.
 
 Features
 ========
@@ -16,9 +17,8 @@ Features
 Checksum offload
 ----------------
   The netvsc driver supports checksum offload as long as the
-  Hyper-V host version does. Windows Server 2016 and Azure
-  support checksum offload for TCP and UDP for both IPv4 and
-  IPv6. Windows Server 2012 only supports checksum offload for TCP.
+  Hyper-V host version does. Windows Server 2016 Hyper-V and later, and
+  Azure, support checksum offload for TCP and UDP for both IPv4 and IPv6.
 
 Receive Side Scaling
 --------------------
@@ -58,8 +58,8 @@ Large Receive Offload (LRO), or Receive Side Coalescing (RSC)
 -------------------------------------------------------------
   The driver supports LRO/RSC in the vSwitch feature. It reduces the per packet
   processing overhead by coalescing multiple TCP segments when possible. The
-  feature is enabled by default on VMs running on Windows Server 2019 and
-  later. It may be changed by ethtool command::
+  feature is enabled by default on VMs running on Windows Server 2019 Hyper-V
+  and later. It may be changed by ethtool command::
 
 	ethtool -K eth0 lro on
 	ethtool -K eth0 lro off
diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
index 176043265803..9527e6073654 100644
--- a/Documentation/virt/hyperv/clocks.rst
+++ b/Documentation/virt/hyperv/clocks.rst
@@ -64,12 +64,8 @@ applying the scale and offset to get the constant 10 MHz clock.
 
 Linux clockevents are based on Hyper-V synthetic timer 0 (stimer0).
 While Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
-timer 0. In older versions of Hyper-V, an interrupt from stimer0
-results in a VMBus control message that is demultiplexed by
-vmbus_isr() as described in the Documentation/virt/hyperv/vmbus.rst
-documentation. In newer versions of Hyper-V, stimer0 interrupts can
-be mapped to an architectural interrupt, which is referred to as
-"Direct Mode". Linux prefers to use Direct Mode when available. Since
+timer 0. stimer0 is operated in what Hyper-V calls "Direct Mode"
+where timer interrupts are mapped to an architectural interrupt. Since
 x86/x64 doesn't support per-CPU interrupts, Direct Mode statically
 allocates an x86 interrupt vector (HYPERV_STIMER0_VECTOR) across all CPUs
 and explicitly codes it to call the stimer0 interrupt handler. Hence
diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
index 77408a89d1a4..c4c262b77aa3 100644
--- a/Documentation/virt/hyperv/overview.rst
+++ b/Documentation/virt/hyperv/overview.rst
@@ -157,9 +157,9 @@ when accessing data shared with Hyper-V.
 Versioning
 ----------
 Current Linux kernels operate correctly with older versions of
-Hyper-V back to Windows Server 2012 Hyper-V. Support for running
-on the original Hyper-V release in Windows Server 2008/2008 R2
-has been removed.
+Hyper-V back to Windows Server 2016 Hyper-V and Windows 10. Support for
+running on Windows Server 2012/2012 R2, Windows Server 2008/2008 R2,
+and Windows 8.1 and earlier has been removed.
 
 A Linux guest on Hyper-V outputs in dmesg the version of Hyper-V
 it is running on.  This version is in the form of a Windows build
-- 
2.25.1

