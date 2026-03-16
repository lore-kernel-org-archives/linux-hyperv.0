Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD0339872;
	Mon, 16 Mar 2026 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695277; cv=none; b=U5vDC2Ii5qZYdLvx6kNiqJL5Yg+h6khvSvb1txgrzdb4hK6Ef0zCzOJbdwhUtRrRwTnUSDhATA8t0WMlaIPOktPKLWg5kCYTRxs8DoHi/F6jT1HIoS0ZdUFLSWwM9QGGerKzeF82Bijew0A3RDBlSC/4CeEVconsgQowVzqh67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695277; c=relaxed/simple;
	bh=P/UG987yHReEP8oJdcFpRyx7r3eECV1dKKdvUgtEggI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZXmMAMMBl1ElvmpX0HPEhdx0vSIC9B3zzomXVjadecVilbyMbpiji/dfroduLdYlNv96DIqO9QCcZ1/sOew/NnrOeb9Q89iol1H8tK47Ryg61wKeljkGFdN+LRP7J22O95LmCIERyhgwFJGOMW9DBvbZjuNH40NKKcBKWZ0qdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id CA58B20B6F01; Mon, 16 Mar 2026 14:07:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA58B20B6F01
From: Long Li <longli@microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Long Li <longli@microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: hv: Set default NUMA node to 0 for devices without affinity info
Date: Mon, 16 Mar 2026 14:07:42 -0700
Message-ID: <20260316210742.1240128-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hv_pci_assign_numa_node() processes a device that does not have
HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
virtual_numa_node, the device NUMA node is left unset. On x86_64,
the uninitialized default happens to be 0, but on ARM64 it is
NUMA_NO_NODE (-1).

Tests show that when no NUMA information is available from the Hyper-V
host, devices perform best when assigned to node 0. With NUMA_NO_NODE
the kernel may spread work across NUMA nodes, which degrades
performance on Hyper-V, particularly for high-throughput devices like
MANA.

Always set the device NUMA node to 0 before the conditional NUMA
affinity check, so that devices get a performant default when the host
provides no NUMA information, and behavior is consistent on both
x86_64 and ARM64.

Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
Signed-off-by: Long Li <longli@microsoft.com>
---
Changes in v2:
- Rewrite commit message to focus on performance as the primary
  motivation: NUMA_NO_NODE causes the kernel to spread work across
  NUMA nodes, degrading performance on Hyper-V

 drivers/pci/controller/pci-hyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2c7a406b4ba8..38a790f642a1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2485,6 +2485,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 		if (!hv_dev)
 			continue;
 
+		/*
+		 * If the Hyper-V host doesn't provide a NUMA node for the
+		 * device, default to node 0. With NUMA_NO_NODE the kernel
+		 * may spread work across NUMA nodes, which degrades
+		 * performance on Hyper-V.
+		 */
+		set_dev_node(&dev->dev, 0);
+
 		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
 		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
 			/*
-- 
2.43.0

