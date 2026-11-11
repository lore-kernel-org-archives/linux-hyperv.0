Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440687;
	b=Xv9JOeYsJWaMlQooQTSS7phO0jaJfs82yViDnMYOUzGF7rTlSTBUozjpfWpPXTs8HBhn
	 Nd/hunwy6bt/qfsLuiAjoKAFOtWr0tGOJ/SCWuZ+BF2Gc3j2jiH8ug06Rk+sT8hOLLVaT
	 YLUM5KzhMsVqv7CkapjECV9z2/Sr4kfKxQ24ckGamJo/oD8ajrPwL4o+tcfsEMGfV/Fl5
	 LP4N40oyGDNPHzUdF1oXhV6rp8HQyxt3xxzUhcsipprcn9RU0AlPckfz6G5a8L5gAZHv0
	 fVLnm4Y4bJuvNP3wLAwkkMlXa9dHLomppBLlY3pVxDA7DA8wSSrcr4JJ2lcQbtFLDcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=F+hpD5oKz8DhBUhMCDg8cpPx7HHT0ysLtBnCzcrLx/w=;
	b=n2PniC9knXaFK3kd6RHZSJv1m+rBLIQC+X2r6zEut420IFyNbN8jA/RwFRNFEAQ7/5kL
	 MSRcGCY3tT0dP+qW0VMlEpW74bKwJCO8PnUn0L6tXmiHWg6jTpKdHkkg4U/eUIXOZGbSb
	 c7aCVXMCi4SdSjjzeMu9ibgGWsvtzTOSVDdkQaW65OHEFfpJs3+UiFIuejR1uaIo75A99
	 sw7SYsrbtvJXqnUaVs9q3cHG4lt8eI/OdLsHOiN+7dgnQCAx30VsEIK9+wAJv1Skwsm/q
	 GUkKawLfAfgI2M9yaWb4rbElg7AQylQVflRCoetWW9t6mAx/qYv826vYJ1v+QUQEewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sun5rfkv;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA1606A896;
	Wed, 11 Nov 2026 23:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBA1606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sun5rfkv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794440683; x=1825976683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NkynmwKmg68YtKZcHXmKG0/Pz8+cWue8h0Nn9YQOq6s=;
  b=Sun5rfkvwsa4uccAaIZZK8WfgPP7pR+wa4LH9q3LpI37pyggOyGq0zG+
   z9DpPJlbm2eFxC7NvHAeRSvkTaMo0jiHAWEfzSM4S0Cg6QwCOxmio/2Rz
   omQKT9O2YyFfbO29PoCQbSXlCLn68kiRiKwEsdBtfhsVnegF7GhZcmh9R
   1AsqTZCc0lTUD3nytS4WsFoilIMZpiilbdbs7PRYYNEI85bXWUKR56oQC
   k0vuKFuCb9XMkMx9efWTcT86ISg9UjBGCt8wzuTLh3Q8W9D5BSP+0K3lk
   6ngPDEVTmbU2C9t7A6vpKP14p8VIeT5XxbY230ca4fNGze5i9s26mABAD
   w==;
X-CSE-ConnectionGUID: q85AP+CkR6GLVnIIr/Hs7w==
X-CSE-MsgGUID: raGNISldQDyZbf0AL4D0cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099087"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099087"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:44:41 -0800
X-CSE-ConnectionGUID: dDufl5CrQf6tpy8cJs0v6A==
X-CSE-MsgGUID: VQEaZRZdSOaDggau79h6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10241284"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 15:44:40 -0800
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Date: Wed, 11 Nov 2026 16:44:36 -0700
Message-ID: <20261111234439.4098-1-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
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

VMware and Hyper-V expose passthrough devices to guest VMs without an
explicit host bridge device. Consequently, host_bridge_whitelist()
cannot automatically identify the underlying host bridge structure,
causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
P2PDMA on Intel hosts, this series extends cpu_supports_p2pdma(), which
so far covers AMD Zen and newer, with an explicit list of Intel Xeon
server generations.

Patch 1 adds a generic <asm/cpu_device_id.h>, so that generic code can
include it without #ifdef CONFIG_X86.
Patch 2 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma(); this
is the v4 1/2 patch, unchanged.
Patch 3 is the v4 2/2 patch with Logan's Reviewed-by carried over; the
only change is in the includes.

Arnd, if 1/3 looks OK to you, could it go through the PCI tree
together with 2/3 and 3/3?

The other users of <asm/cpu_device_id.h> and <asm/intel-family.h>
under #ifdef CONFIG_X86 (ACPI, cpufreq, i915, amdgpu, tpm, ccp,
platform/x86) are converted in a follow-up series on top of this one.

Based on mainline (7.4-rc2+). Built with x86_64 and arm64
allmodconfig, each patch separately.

Changes in v5:
- Add 1/3, a generic <asm/cpu_device_id.h>, so the include no longer
  needs #ifdef CONFIG_X86 (Leon Romanovsky)
- Drop the <asm/intel-family.h> include, <asm/cpu_device_id.h>
  includes it on x86

Changes in v4:
- Add 1/2, moving the CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
  (Logan Gunthorpe, Leon Romanovsky)
- Keep the #ifdef around the asm/ includes, as these headers exist
  only on x86 (Bjorn Helgaas)

Changes in v3:
- Drop the hypervisor check and move the Xeon list into
  cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
  Gunthorpe and Leon Romanovsky [1]
- Fold the VMware and Hyper-V patches into one, as the check no longer
  depends on the hypervisor

Changes in v2:
- Replace the Skylake-and-newer threshold with an explicit list of Intel
  Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
  Gunthorpe)
- Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
  (Logan Gunthorpe)
- Rebased on current mainline

[1] https://lore.kernel.org/r/20261016153147.GC219304@unreal

v4: https://lore.kernel.org/r/20261020173736.81755-1-pavel.e.popov@intel.com
v3: https://lore.kernel.org/r/20261020151305.65218-1-pavel.e.popov@intel.com
v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com

Pavel Popov (3):
  asm-generic: Add <asm-generic/cpu_device_id.h>
  PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
  PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs

 drivers/pci/p2pdma.c                | 30 +++++++++++++++++++++++++++--
 include/asm-generic/Kbuild          |  1 +
 include/asm-generic/cpu_device_id.h |  5 +++++
 3 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-generic/cpu_device_id.h


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.54.0

