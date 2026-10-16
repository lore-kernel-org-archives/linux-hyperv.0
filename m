Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F3381B1C;
	Sat, 17 Oct 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195209; cv=none; b=bEyIL47kUrxntjPURVAPKqeTKBpU3YdT7S6RKpOTlP/nrpJhZSAYLyMH6T3g+XPVY8qpAg2D++d2iRGMnZD+0iF/4seQqhTvKuJl7lOd+JyrhSfSgGgKN3RYpPfaESNOLNyKKwNWslx8WXSgwSfda8W0ShSFllu1j68L1XxZyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195209; c=relaxed/simple;
	bh=s3e3vclUqMHCWeTSPseyjYzU8YzgptMgUxOyzOGGBj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lm1n7Pj9GdvDj27hdQRULXivU4rr2HHfo8a0mgVmGmgRsaOyhxlvGpseZrfHMMiVXq1qPGygMWsyQJiBb1xME790xbLJv2QGcsXBSGl7VF77wY/8/VxBXYPMfzQNdLyBG3quYMBSswlDml0Pv6Ovu0EINE3B7iQ81UyUCrjD1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dbvJzdPI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dbvJzdPI"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 4CC1220B7167; Fri, 16 Oct 2026 17:00:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CC1220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792195202;
	bh=moVtecY2Bt+NuCIdpO9sPe1Rj+Ksh5GzDLFLl3q1sQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=dbvJzdPIuV9rPImu/MqwF8oP4X8uYWFvSaOSWx2lVIqyNnVLUnliPTc9/M8PAHoI0
	 pnQlf3WOgchKIyXps2xaP3Rq+UuUkEw2q4yfo2e0FhLyGJfchlozJ82vtRqrd8QX8U
	 SOgxO10DxO/4rx9zQeANaUuhJSYIh4cMekl/89DY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 1/2] PCI: use reset_root_port() for bus reset of devices on a root bus
Date: Fri, 16 Oct 2026 19:59:39 -0400
Message-ID: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "bus" reset method resets a device by asserting Secondary Bus Reset
on its upstream bridge, so it is not available for a device on a root
bus, which has no upstream bridge.

Some platforms have no Root Ports and expose PCI devices directly on a
root bus, e.g., Hyper-V vPCI places each assigned PCI function directly
on the root bus of a virtual host bridge. Such a device has no reset
method at all if it supports neither FLR nor PM reset, even if the
platform is able to reset it.

pci_host_bridge::reset_root_port() already allows a host bridge to reset
a device on a root bus in a platform-specific way, so far only in place
of a Secondary Bus Reset by a Root Port. Use it for the "bus" reset
method of a device that is the only device on a root bus, and wait for
the device to become ready afterwards, as is done for other reset
methods.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/pci/pci.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8cc6a89130b5..fd4e958d6b99 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4924,18 +4924,46 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
+static int pci_root_bus_reset(struct pci_dev *dev, bool probe)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int rc;
+
+	/*
+	 * Bridges, e.g., Root Ports, are not eligible.  Check the header type
+	 * because dev->subordinate is not set up yet when the reset methods
+	 * are probed during enumeration.
+	 */
+	if (pci_is_bridge(dev) || !host->reset_root_port)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = host->reset_root_port(host, dev);
+	if (rc)
+		return rc;
+
+	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+}
+
 static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *pdev;
 
-	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
-	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+	if (dev->subordinate || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
 		return -ENOTTY;
 
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
 		if (pdev != dev)
 			return -ENOTTY;
 
+	if (pci_is_root_bus(dev->bus))
+		return pci_root_bus_reset(dev, probe);
+
+	if (!dev->bus->self)
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.56.0

