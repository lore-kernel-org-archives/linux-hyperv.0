Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4322F767
	for <linux-hyperv@vger.kernel.org>; Sat, 17 Oct 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253335; cv=none; b=Z7+yUNbeVGDO3jxlXEqJTtjldb6VpR3au2iMtO3xIfvuh7m9O9OqDAw4oM5o0XQtJPVf6gw2x5h79X7+I11f85tGYfd85wrjG/+sB/qqIEgirFrWOwUOWI8FkeezCWrmFXFreMzXWR0XKkZQKrdAub1oN6Xmni63QV7LM/K+y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253335; c=relaxed/simple;
	bh=DWCmY5z7z4vq4G12qv/hRWrXt2RrydGaFmtxVM/Sg7c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QYph7BVVyzKzgJdJRXpRsPMtgrI0jtfUIZEXpW8Bo83/k0sUxXK37e/hXVh0/C8xyH8he2Kw+JcVcns2F0fA6Bda8GYETGdKQg6FrPNw54wiLu1ZoAYDnTaIvR3Yg5+O+bfxntUpWe54LkRm8ru+8ANDBsxLIU0tPpLc4eKYbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgJ5G8sW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgJ5G8sW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so850780a91.3
        for <linux-hyperv@vger.kernel.org>; Sat, 17 Oct 2026 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792253333; x=1792858133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cUeaEgu4p26tZrZN56rXhHr90NwI8Pog8folKw9Xmw=;
        b=mgJ5G8sWVoZtRbteR6hqdKRBd/svddwH70mq+8vEfAJ5233Yqs5fX0++rEDG5SVMI3
         1EZUBmYlYJ3S496jqxehDNh1rSfGkAN+4s70eVkWLG9L072BTTl1emeECsQwZyRRildY
         fiiJj1ifqs26OpWFWBZNgoNxG0Bs+XpXNhFFrGEM7nUWROfFAaXz4+NjpnQ99C/2Jemw
         O2ddVXxuhSLkWIv/G41/jhX3bfbPm1MjSM9te1bR/BMpPB7QW9ZX9hRIPGatcNTJ0wog
         JcOVPdPECqoWiy1Uqe/rSriO6BMj6ybQFCwcAmuTXimIOq/e8kRQBo3Dp1VfiysdjQn2
         goKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253333; x=1792858133;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cUeaEgu4p26tZrZN56rXhHr90NwI8Pog8folKw9Xmw=;
        b=QbUxuWhW9qVXQvtDvnf2aP1d3HOm7JoNTelxnbGuATLVr1esV7Zx87jaVyWX03qD3U
         jq3VHJZL2mx/EYCHFg2kBwwDnvEJtqoYfJiCkXxt9ikQw6pWfrodZtVofUgxMhk2uNuL
         NHZr4wHxe0J1HBAm8/u0RBN3aj8kYyzSzHWE/2GmvAMLEKRLbksSg3JN+WfERUnaGT5Q
         xuqw/GwAl9HYKJtYmru640XoOeQdqv16znivy3pe4qUDymSgssq7DXciMk4lM1xEXGjf
         AsqCCLoVrd24iish9NlBiw+MfL5hUGbDNxn7sDETzEUQ6PVl89waGtg4NwHeMpchI/fD
         ZrWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMvsZ4zGGh/LN/LOwNPN91nxdWEpIwp5pNIC250rJes6tHFhxBFvY/0woE+9R6m5g04MWmD+SOuz8DRaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlH/Bzexb5jH4cB1CHcmdGcECWqfSmQ/lA9moBoFhl0S9pa/GM
	pz8y9g02EzF35h0WU76Z50gjobs2rAGSL/GM18GkaPV5vDMg3IQnnYa/
X-Gm-Gg: AYBFou0nOuHarOOqW53dEHQjrRRaCse/rvX2QJt4Gg58F/TB6ME6lK/wRHJT74L9D6I
	BZbpu0I4OpdzIbZDUK/ZWsyM3EGmVZrMx1TCCnPquCzfrvhA9rqRPln7hhcGsVHk+S3bJRa78DT
	ArGozztVmHYZ7ZNihfUQWJBxnJpuf+FAeMfVKj3aMQqeRcRSVcQ/IDqsF4Q0NQoTbSbT2YzjoKs
	RgH4C+fwy4Insj2KnyI+vi8ea7QjDHM4jLlfLY4ske4BUPHHWt9vFX5oERGlJ84iiA0QGzChyLp
	bPvNzsSOTLdRb2awTR93LyxE6voZAle+Hu1xoD4mgMjABt7iQAGJfA89LaU58reb1GJaI0tUzGV
	dptlVZvnvT+Bw2wu2LmkdoyWna3pNC4oO0eAKX0D9AOM0RGKz6q8byDjtStzq/74GF9TjNEs1+i
	aJo0cWcCZNb7oSF7eGlAO7vpIWg0nFyGSPMpCh9TAiqXB2axaVZwdsWoMr5RtBb6jhUD1ufKzv2
	QOf20MpdI5LMAbTtUM1Wqnz4afJ9JG+YBJAmAb43R9Vsvx8YTWrGqdezjtshKXa
X-Received: by 2002:a17:90b:4ac6:b0:3ac:9e76:aa97 with SMTP id 98e67ed59e1d1-3acee277119mr2806327a91.6.1792253332865;
        Sat, 17 Oct 2026 09:08:52 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc49c263asm8349666a91.17.2026.10.17.09.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:08:52 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation: hyperv: Update information on guest CPU offlining
Date: Sat, 17 Oct 2026 09:08:48 -0700
Message-Id: <20261017160848.14730-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Hyper-V Overview documentation, remove the out-of-date reference
to explicitly reassigning VMBus channel interrupts before taking a
guest CPU offline. Instead, reference the VMBus documentation, which
is already up-to-date on this topic.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 Documentation/virt/hyperv/overview.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
index 77408a89d1a4..63489f73a299 100644
--- a/Documentation/virt/hyperv/overview.rst
+++ b/Documentation/virt/hyperv/overview.rst
@@ -132,11 +132,11 @@ Starting in Windows Server 2022 Hyper-V, the ACPI tables reflect
 only the CPUs actually present in the VM, so Linux does not report
 any hot-add CPUs.
 
-A Linux guest CPU may be taken offline using the normal Linux
-mechanisms, provided no VMBus channel interrupts are assigned to
-the CPU.  See the section on VMBus Interrupts for more details
-on how VMBus channel interrupts can be re-assigned to permit
-taking a CPU offline.
+A Linux guest CPU may be taken offline, and subsequently brought
+back online, using the normal Linux mechanisms. See the "VMBus
+Interrupts" section of Documentation/virt/hyperv/vmbus.rst
+documentation for how VMBus channel interrupts are automatically
+re-assigned if necessary when taking a CPU offline.
 
 32-bit and 64-bit
 -----------------
-- 
2.25.1

