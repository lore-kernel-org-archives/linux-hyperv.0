Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419D43B3CE;
	Fri, 16 Oct 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190049; cv=none; b=ueP61oqH+ELVl6p6FgSpG4YBcmc+pk/UbVh+a8+vdsjAmWUhkc1VOcMuulV7jsbDFJ8kLGc4dynW2uhYM2yQUIKrqkSSauV6T5LNfft+srL88o3tO5mtcmutBlOw6g6EzUlNKmG14X4TvHFxpduDSltupSRlA2lJX8JtTA1Xqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190049; c=relaxed/simple;
	bh=CTytsslJzG1s2o0/5DaFwtKTH+dRJi6mvygS88PE2WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYPi2XiAHgz87X641A4WEb91K3rw/M5LQOVtXIOqpH/f2eiQswWaQVhyP+UIbvavbipz2uLiJhhagbkZ6WdvMp2om8a471gkoa4dxN7fiKP4nJn3iyrWB2ca5FbVWToB9rreF1l62E7uQc3B8zw7okqsjqXzSZDCEOZb4Qgs6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzT/eomu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzT/eomu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792190048; x=1823726048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CTytsslJzG1s2o0/5DaFwtKTH+dRJi6mvygS88PE2WI=;
  b=AzT/eomuvof4C+B6lTRAw8AsnBk6P7z5aCf31/BDoJeS5iGYZ2Zh93tn
   vlpBGWY9AIw93cp8t4kwuxVKtYxnavOPKniBsz7FpiwJWqLLVH91xUFfr
   B47d0bbgquCmKjcrF3dUDogML0+pUTeV2rKtu+kpab8n/5UoMDDCW9ewM
   hglfbytb07GCqTdVrEb3oUpvaY2YHkaBSLud7JVyZLosB15FpwCuB5tiJ
   Wz5/MbUgWXWt6o0f1ymLe2Q5v08WDxJB3/Dz8YGvcV6A76KjmsTy2zEzu
   3Hk+2SDb/vFVlp6P5cNReXF5s8ejXpEqwxDAmlOC5NG8n+eFHsylG3t71
   A==;
X-CSE-ConnectionGUID: +426ZF82TzmRvAmaIKWR1g==
X-CSE-MsgGUID: JrkIFH+2Tim/96mfsYjrUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="990202"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="990202"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:34:08 -0700
X-CSE-ConnectionGUID: oQXIKqugTgCyLwyJ/sCMmw==
X-CSE-MsgGUID: 1L26IghdQAK9w1Tc0FV5ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2025037"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 16 Oct 2026 15:34:06 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: pavel.e.popov@intel.com,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Leon Romanovsky <leonro@nvidia.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts
Date: Fri, 16 Oct 2026 15:34:02 -0700
Message-ID: <20261016223402.19991-3-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016223402.19991-1-pavel.e.popov@intel.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
Hyper-V guests, each passthrough device appears in a PCI domain of its
own without a host bridge device. Consequently, P2PDMA checks evaluate
endpoint Device IDs against the host bridge whitelist, causing P2PDMA
requests to fail regardless of host support.

This affects discrete devices such as GPUs, NICs and NVMe drives.

The P2PDMA host bridge check does not work in a Hyper-V guest. Apply
the same bypass as for VMware, on the same Intel Xeon generations.

Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
cards in a Linux guest on Windows Server 2025 (Emerald Rapids host).

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1b4886d4f9be..9d643dd41008 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -557,7 +557,8 @@ static const struct x86_cpu_id hypervisor_p2pdma_cpu_ids[] = {
 static bool hypervisor_supports_p2pdma(void)
 {
 	/* Hypervisor hides host topology, allow p2pdma on whitelisted CPUs */
-	if (hypervisor_is_type(X86_HYPER_VMWARE))
+	if (hypervisor_is_type(X86_HYPER_VMWARE) ||
+	    hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
 
 	return false;
-- 
2.53.0

