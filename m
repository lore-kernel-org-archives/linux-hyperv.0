Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891F4EA38E;
	Fri,  9 Oct 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560442; cv=none; b=tzN2ZU4TTyrBbSdNfNPlAhPB2W2sCnKlr0jplrWr/XuKlYOGf4BipHS+mLzP5P5jENU0CVtgw8ABnvDl+HtWrJbvgFsTz/APrzPC1gXx+849BeDuaEpZ4JMRXDTR9KDGyP2pbnbCrVTLiaSv3se4bvdSEcTxNyMJF3riYpTraO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560442; c=relaxed/simple;
	bh=5Vq6IrczwMUOvnUlXtS8IFHOzGnqSb2ysDfVsCAyk4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jkw5FtFX3PMsiGgMj5cMTIfNMYiarsvCjqs3hK4z8xFDhP/3gp10uKo7dZrHO9nt9uGh5SyNwRlRYywePYXMpjIiZIynMfcu4F/GMmOnUkXhbA3l5Tk4o4hGmGrEWujt44bmFVmqeeAXyWUJAmt4bIP22QCcGO7IYZoyWnlEm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8ZUYKz1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8ZUYKz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791560438; x=1823096438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Vq6IrczwMUOvnUlXtS8IFHOzGnqSb2ysDfVsCAyk4M=;
  b=A8ZUYKz1+9bnZ6VwvaywCtTTx2FJplkG1vlVJuiveyZbQyxtXt1UCgAk
   N49A28++3JFhD0cgf2YtA1VIAI36zbaACXYV+8SmQbFFppVeJ0FJIuRTv
   DXJAvehJJGRg03fvNFEwfUQ2dbI7NiK8pGHI+qzzKTXY1rS9ezINl/IfE
   II9yGgAqBS+SuQq7LsTiMP+bFpi3N44DRGsYXb53mEB5Q2bes9kWn8FgP
   HF947P0xJdYq/SMNDt0Kt/BJp6p41zKY3kHX4FGa99wJGHDO17s6L0xt9
   NzmFZ91EFenrkZu4oCBNX1T+HbPyMoru9EtqHvCLe217HhGUC29jh2gdp
   w==;
X-CSE-ConnectionGUID: PSTrZqNGTpyhB4FfI26QSg==
X-CSE-MsgGUID: xrUemD0GQg+NW7wDPZNMXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="255197"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="255197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:40:37 -0700
X-CSE-ConnectionGUID: jrdAMVPYRl+JroZ+T3j0MA==
X-CSE-MsgGUID: DvmFJIAEQ/Wlq1GF6Uzamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="674637"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by fmviesa008.fm.intel.com with ESMTP; 09 Oct 2026 08:40:35 -0700
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
Subject: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V guests on Intel hosts
Date: Fri,  9 Oct 2026 08:40:32 -0700
Message-ID: <20261009154034.82321-1-pavel.e.popov@intel.com>
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

Pavel Popov (2):
  PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
  PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts

 drivers/pci/p2pdma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
-- 
2.53.0

