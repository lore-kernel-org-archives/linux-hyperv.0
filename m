Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278A34F48D;
	Thu, 12 Mar 2026 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354866; cv=none; b=rBS88hghwUQSYkKE3qQ9ahAkOfYyeCgzhBfXGh83RO8e5IoMo+NdyxDGB6f1EUWyUnPDtUc2h6tnebwRdKVQIQaJVhFT6sA/reS7FxZvYKzvCAs5FflZWyb7bcJAP9cZRKkv6dH+FjemWK7dH5YKBOG8QTZpLKaCGOcMxtdr+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354866; c=relaxed/simple;
	bh=9Ohx+IU3CTjmUrrLYBv7odjTrZ7menK5l3wSc/Sybts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3unxRt608oRmEZSKUdX9/UaKDCZXlyc4tyUfitAozOHkKEI0V1pU/U7De6Bp9qY5+RzWuCVht2RbK9YSSkz7P0967RmtPvvhFi6TuU9u+HiOciAXZIAnq4J4V2usQnU63N+GoeJva65Fz1PR2lZuBao5VeEYL39wc+8zfcepzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id BCCE220B710C; Thu, 12 Mar 2026 15:34:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCCE220B710C
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
Subject: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without affinity info
Date: Thu, 12 Mar 2026 15:32:44 -0700
Message-ID: <20260312223244.1006305-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Hyper-V PCI device does not have
HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
virtual_numa_node, hv_pci_assign_numa_node() leaves the device
NUMA node unset. On x86_64, the default NUMA node happens to be
0, but on ARM64 it is NUMA_NO_NODE (-1), leading to inconsistent
behavior across architectures.

In Azure, when no NUMA information is available from the host,
devices perform best when assigned to node 0. Set the device NUMA
node to 0 unconditionally before the conditional NUMA affinity
check, so that devices always get a valid default and behavior is
consistent on both x86_64 and ARM64.

Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2c7a406b4ba8..5c03b6e4cdab 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2485,6 +2485,9 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 		if (!hv_dev)
 			continue;
 
+		/* Default to node 0 for consistent behavior across architectures */
+		set_dev_node(&dev->dev, 0);
+
 		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
 		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
 			/*
-- 
2.43.0

