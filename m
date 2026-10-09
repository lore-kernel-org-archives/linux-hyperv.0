Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C549B5A5;
	Fri,  9 Oct 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560444; cv=none; b=N/J0QJdm+bYCW77UR1Q9UHPk9c1HxCobzvxdUp/zyWdoo0fRjIYxIJIuK7vass+6D7uPuElR+CsEtOvxFKMoRcRz5IXoULBli2I+5h7dYkRJKta4yiiaZNOw/X+O2V1acaYMqkTvZwCS5+m/MSJ2p7OhvLP6LfG0DA3INxyavBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560444; c=relaxed/simple;
	bh=xDO7qD54OsQFBXMb97LDRMKNs/yw61kjibS2wSJ0aa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fciTQS8QYlqLfuxRQXkez7uUtK6eChW0mKaTQh3ctM9jqv6pdA6nKMsIfYLJvv1O2+Jp5OmEdxiXl4j1KDbOwiV2w+ozCl7Zfx/Sqj1NAn/oFa6Z8gYr/6oKUMk51LNeluIB3okIUxZCGLtyyNDnHxt9BU8XDML0zK2svxUJN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPGoQW3N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPGoQW3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791560442; x=1823096442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDO7qD54OsQFBXMb97LDRMKNs/yw61kjibS2wSJ0aa4=;
  b=fPGoQW3NKcoTFV2uLcjChIZ+pxyuAX08PgrcL1d64prTMnGJ9JUciOlG
   z1ImvCPdi6J0oU5zPtrBcD9ZEAvpe9UXekz0jJRf/RRuXMo+VRHGC746V
   P9Gc5hbi3oCAiac/8XPUIOjFvA8MDqgyKzp3HVtbi4BJUZ6eDw5+9g8Zf
   0QVk9M8vzVXuFccm6aE1CYtRXrhGFFx1JoGzzTycQi0jGhg76f+8AGr77
   SLbo/47izjP35GwppV5mQe0YGxsLAjFt27iEjeqXrtEmACvODohyKbEpq
   zGlRYAqfUDebHV89wgZvOpdq7DK5K8nmyspdPXTXgSf7VRnzNgaI6cjHA
   Q==;
X-CSE-ConnectionGUID: /IeOi9y2Tt6G/nste+l7qQ==
X-CSE-MsgGUID: Qs53cJLKS9al/PgYzB+paQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="255210"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="255210"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 08:40:37 -0700
X-CSE-ConnectionGUID: 2Zld83KMQvygvX3rUSMSQA==
X-CSE-MsgGUID: bQnCytHEQQWjLOqyzhe3Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="674650"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by fmviesa008.fm.intel.com with ESMTP; 09 Oct 2026 08:40:37 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: pavel.e.popov@intel.com,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Jim Chow <jim.chow@broadcom.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts
Date: Fri,  9 Oct 2026 08:40:34 -0700
Message-ID: <20261009154034.82321-3-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009154034.82321-1-pavel.e.popov@intel.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
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

The P2PDMA host bridge check does not work in a Hyper-V guest. Bypass it
on Intel hosts under Hyper-V, starting with Skylake-SP, the first Xeon
Scalable generation. Xeon Scalable introduced UPI and is whitelisted for
P2PDMA without restrictions. AMD Zen and newer are already covered by
cpu_supports_p2pdma(), so the bypass is implemented for Intel hosts only.

Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
cards in a Linux guest on Windows Server 2025 (Emerald Rapids host).

Reviewed-by: Jim Chow <jim.chow@broadcom.com>
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d96f44d0738a..76fadfbc1814 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -544,7 +544,8 @@ static bool hypervisor_supports_p2pdma(void)
 	/* Hypervisor hides host topology, allow p2pdma on Skylake and newer */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vfm >= INTEL_SKYLAKE_X &&
-	    hypervisor_is_type(X86_HYPER_VMWARE))
+	    (hypervisor_is_type(X86_HYPER_VMWARE) ||
+	     hypervisor_is_type(X86_HYPER_MS_HYPERV)))
 		return true;
 #endif
 
-- 
2.53.0

