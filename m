Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7530567F;
	Fri, 16 Oct 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190047; cv=none; b=VEVpwONNA6mnTs7St9O0p/sf/+tHdt35vXmCQtYmoSsOue3z6YiRGT6Ktps1QeKD9acaJZUvRwvTtiQ+C4XeQ3Y88GRTvZKVUcIPuA8MNNRzlH9VIbhVdVV6n/rVQiu/cc39j4+cYztze0vtGUMQU5ibD2rHRLgjyeSL0t2T3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190047; c=relaxed/simple;
	bh=Mxb6wqWlv0WnnJOs2re86WJp343rLPat+VsK8u6sAgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbwWvv+BEirv1WZ8xlf0SJkD8RCsszLgDd8XPQQQCQe67opwlTre9Et7qSXZQu0EtneshgGsz0YcHPjCIeMaqRc83HrKW2WepZ4dkWEMA1jeifhtx3fsWZswMvjmFLRbviwukLLDVTNw924gaTIWCyaKR2RHGiU4Zp5rn5TOgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pdf2iLiF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pdf2iLiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792190045; x=1823726045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mxb6wqWlv0WnnJOs2re86WJp343rLPat+VsK8u6sAgM=;
  b=Pdf2iLiFuKJNOMZ2nA/1USYg98L7gmgeXR4FfRrDapRg+icsJWI/O2O1
   yt2r4otrVwfikKnr7vG/hvdi6yhFPa7gYIzF92SYQZWRB2zLbPANFLSrN
   OVHBAGui2e/2G2D+3P03W6e7Qc3dtjpX7m5ucxrxeqicbastpx5IHl+2s
   h9RSjU1neAb4i3JOlumE59s/56sKX6kTWAvNCkYml1aAb3dovjc8FpBsk
   mU5pPZafy2NdcYDXTeH2lOzOsYlREcTiSUF3ffDLkOuLbWWURQ6DjYY7H
   GAncmaGLsSXmAMlSs+eTGvGllDJr1jZeW/6LE0PMjcVFm4tU3y6p4H/b0
   Q==;
X-CSE-ConnectionGUID: qIT87T6BRgqSAJL3+DykkQ==
X-CSE-MsgGUID: DY9LRgrlRKaL5KmYBEEw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="990183"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="990183"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:34:04 -0700
X-CSE-ConnectionGUID: rhFrZNNET3Oumb4D9wK9Jg==
X-CSE-MsgGUID: aLrTlDjMRReIoSVNUS/uog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2025030"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 16 Oct 2026 15:34:03 -0700
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
Subject: [PATCH v2 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests on Intel hosts
Date: Fri, 16 Oct 2026 15:34:00 -0700
Message-ID: <20261016223402.19991-1-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMware and Hyper-V expose passthrough devices to guest VMs without an
explicit host bridge device. Consequently, host_bridge_whitelist()
cannot automatically identify the underlying host bridge structure,
causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
P2PDMA support in virtualized environments on Intel hosts, this series
introduces hypervisor_supports_p2pdma().

Although alternative P2PDMA mechanisms are in development [1], their
adoption timeline in hypervisors remains uncertain. This solution
addresses the immediate need to support both new and existing
hypervisor deployments.

The patches are organized by hypervisor for clarity. While the primary
focus is VMware, a corresponding Hyper-V patch addresses the same
pattern and is included for maintainer consideration.

[1] https://lore.kernel.org/r/20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com

Changes in v2:
- Replace the Skylake-and-newer threshold with an explicit list of Intel
  Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
  Gunthorpe)
- Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
  (Logan Gunthorpe)
- Rebased on current mainline

v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com

Pavel Popov (2):
  PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
  PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts

 drivers/pci/p2pdma.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)


base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.53.0

