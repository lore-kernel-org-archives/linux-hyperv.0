Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8543B499;
	Fri, 24 Jul 2026 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934529; cv=none; b=otNI23MgkQ/R+mbtwzX8VPgEXXwmmBLukjybJYuq1rm4+DOxnzU4WRniB9aK8B/XFK01uR5NqycpXUf1AdyZ84XG+aF2sYB5Gqxi2VEeAg4osZ870vYXu7X5bZxoxBX9Lh/wxnUjNhSacWzeOwhV7+gYfSGEmFfMnL8ovSFNk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934529; c=relaxed/simple;
	bh=SV06N2nKHs8uJhLgHQ0sG7yV56nlnGE4yC5KuqA5Imo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4WHIf/HlLiotavoyKgp/UnJ0bEJRoBk1x0hU7RaM3uvnLIUrnaEXEKh5iWiLhsNvKWyvaN+MwlvUjQ32W5euQzoaBEXU+tQFmfiJwI6w8E0HEnNwFFrVmKto89hci8Yz9oIpOZq9NRzgqYsFcb9Y3p3H5KbRN4qACYHRUrxMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqsaG5Hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqsaG5Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976BE1F000E9;
	Fri, 24 Jul 2026 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934527;
	bh=fdTG922/AU2yfgsQeXsPRKU6WqnYJB/qR273Uh/rXAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqsaG5HmwMMIVk66vdf5FNK0PP8H7VxyIZTNhs919VFBTwIf80aVu9dLvxDWnl2x2
	 lCs40Qa6VAWhBsajwcYHZM0ABaL6IGrtupcSpJMPeDsJOqx6OX7orf/gBO/ut/YkkY
	 Rqwf41NtSnfBcBVcXiza8qQnOLQ+HJJMAohxnN6x2AIxGsptvzsQvbM7PoZzgoZ/8R
	 Qv3UkwegL3eTbXVg0xnKu7CsVO4599nHL2w0HGTJUq0AIiqkH3EPh5Hps4HFFymHED
	 FjI71uPbIZg9pjTu6GMutoFXvajCKVglxIMNyQoBtZB29KqIFvFfksVHFiosu7+2Mb
	 hRTYkdgCphqyw==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	linux-pci@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 1/2] PCI: Add controller reset method
Date: Fri, 24 Jul 2026 16:08:42 -0700
Message-ID: <20260724230844.3259741-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724230844.3259741-1-wei.liu@kernel.org>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Some PCI controllers provide a function reset mechanism that is not
advertised in PCI configuration space. Allow them to expose it through an
optional pci_ops callback.

Add the controller reset method to the standard reset_method interface.
Prefer FLR and AF FLR by default, and use the controller operation before
PM and bus reset fallbacks.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/pci.c   | 22 ++++++++++++++++++++++
 include/linux/pci.h |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..4e55da202cad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4962,6 +4962,27 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return rc;
 }
 
+static int pci_controller_reset(struct pci_dev *dev, bool probe)
+{
+	int rc;
+
+	if (!dev->bus->ops->reset)
+		return -ENOTTY;
+
+	if (probe)
+		return dev->bus->ops->reset(dev, probe);
+
+	rc = pci_dev_reset_iommu_prepare(dev);
+	if (rc) {
+		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = dev->bus->ops->reset(dev, probe);
+	pci_dev_reset_iommu_done(dev);
+	return rc;
+}
+
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
@@ -5094,6 +5115,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ pci_controller_reset, .name = "controller" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..d7759ee70670 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
@@ -875,6 +875,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*reset)(struct pci_dev *dev, bool probe);
 };
 
 /*
-- 
2.53.0

