Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517859;
	b=1X1CuS0IOolVyLjGVzIUYNYL2UKUlgOBA5BI908Cuk4q2yDQt8AgpVZePDwPiTaNQgpu
	 3p+aqy8vJwDStMXH74KWm0KL2y0bT68Fu5Itd11BxRXdyhG2O5+7hS9Lan2uejWqd46xZ
	 ld+XH7Y57Xl77SbORiVrKYHGflRor2PWq3/5GtKT6Yyivxv3RlgNnOva6Mo3EOaCmg4Fe
	 93+dMdxowhpU2yOPDtVmLzNoU5eDrvubxUb60isERUzaA7QiF9xfLHLerVccH+vyQGa8j
	 H7CJbXBmi4p02StQ4eu00hb66CEFX87N1pkc4iVlj1Ab0YORv17MLCaMVIVTAyNPe/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aWpvGCBjv6cbyfecm3gUFBX3cE1gs/duG1Fz5GDSBvk=;
	b=3DU5NklN09xQFLtw+G77j04+cO9neXayNOEdlryEa7Y6g7V9p31C00u8wmaM/3Oc/6wG
	 q3Lxb4KD4A5rsue3JzEVmK82+C+fM8NoMaVF65EMlRz2s4K/y9aTUuGt6AXKYWKeY2TpZ
	 V9sTytniS9AEjgURBqdyiIRc+fMRJf9w6rPQo3teQUQ/tKfAQz+Y5g55tyYKvAidZ2K/q
	 Kz3Yl+42/J2eppntPHBbkxcULjPE9Ja3urBuxvlkn5iyz9E2jGpSAA1lw6S7gk2hYuTq2
	 AF7/Iu5pwABJ+cOABFQvU7I709Vm+c4borpdUdXuEcHEDA+xVYX6gHR5OPVx6tbd7Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UINqjWPe;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5960A380B;
	Tue, 20 Oct 2026 17:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB5960A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UINqjWPe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792517857; x=1824053857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d0uxtmac76n5lDX6EvHTzDit2NJCHOZnoAdKI+C/xLI=;
  b=UINqjWPeErrncO+c6yeBVVoPprLcEeX19Ofcf9WBJk9ODuNxYTd0pNH8
   fSYsxMbU7J+u7b7dlgebYHrHP2Qllme8Cx/gEry368DHgz2IJCYEKCU2a
   fZPYUice9+Zj1CINikg1L4DdFL1ZV52F1vdZVMOuNINt4afWPSTk8ZYtl
   djOzKq5tUvHaSSl95qUaWhL8Qeo6XRX27Nku6Tzkku1u4Su64IlRQ6ez9
   v6133izjGE1jxvdrXfX2f+TYdGI6/yLk8WO1x/LRjbACRnkiYzRNWWEsa
   wCshmXFQ+TUs5xfkOWz+N4VFKnqaxNrxLuzQbUHLAS9FtvgFoXIeroKbF
   Q==;
X-CSE-ConnectionGUID: yr6BnLlZTiez+MhaxeBssQ==
X-CSE-MsgGUID: NhCjUaEZS/mwarWkP0A6lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1240967"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1240967"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:37 -0700
X-CSE-ConnectionGUID: iaeqaN3ASWqnnElD8NQGsQ==
X-CSE-MsgGUID: d0kpV3bFQoO7qtRKs5ajkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2875807"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2026 10:37:36 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Date: Tue, 20 Oct 2026 10:37:34 -0700
Message-ID: <20261020173736.81755-1-pavel.e.popov@intel.com>
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

Patch 1 moves the CONFIG_X86 #ifdef out of cpu_supports_p2pdma().
Patch 2 is the v3 patch rebased on it, with Logan's Reviewed-by carried
over; the Xeon list and the check are unchanged.

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

v3: https://lore.kernel.org/r/20261020151305.65218-1-pavel.e.popov@intel.com
v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com

Pavel Popov (2):
  PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
  PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs

 drivers/pci/p2pdma.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

