Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51AB381B1C;
	Sat, 17 Oct 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195211; cv=none; b=IMSCGl7rt6D9IWIZ9h85oIJaeCSN6JB5kxX2keQucAVioenejRXXQOrc3H093c+Ud0c6lMXJKpN3fBf24hb0q0eJz+p+SKY2m0uXaa+lXfaRz3SSU3EoT495PJ4Y/DZdg79Q9Ya73+hR4xyYllG/pQZm4YMyX4xWJINOJNzLWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195211; c=relaxed/simple;
	bh=9xDY8RJxMnbDzlivRKIo9yR1vRznPmY5J8sWs5iLWd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB7Wn8POr6t4+Rd0aGIYeqCtL1qUWZTiDkA/hoRw8nMZ6VDzxNpc+XU0RX7W6fzaqImCJtN7o2Gt6XjjgNeo75EEiz1eez9sxjafq3ZI+WqjXhE0tW27RPEtO4JGxOWFoy8vJIQ0kCfcTF68ukLMciA8c0rc2cj8W/FFshXP9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ogijTMZc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ogijTMZc"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 8A62720B7168; Fri, 16 Oct 2026 17:00:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A62720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792195204;
	bh=ibhrdaDiErzJvlxjxB5JJub8TppCWT7KleXCU2bg3eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogijTMZcO/0ALxKv13Ohj+MKuj45OFTZ0nU3H0mCwu8YSnLeZLFt1WaEkrUxdOo9C
	 pKneCHDhuAq0xFa8Ki+qiXMJcLiYCAGAfWZAjmXPsAKXLny3xBf2s3eeepZdZocaTg
	 k6WWRKSLPK9vFCrvmZZTqMJB8RNpT6s8+9S6glHg=
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
Subject: [PATCH 2/2] PCI: hv: add vPCI device reset support
Date: Fri, 16 Oct 2026 19:59:40 -0400
Message-ID: <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for
projected PCI functions. Negotiate the new protocol version and, when it
is in use, implement the pci_host_bridge::reset_root_port() callback by
issuing the request through the vPCI VMBus channel.

Hyper-V has no Root Ports and exposes projected functions directly on
the root bus, so PCI core uses the callback for the "bus" reset method
of a function that is the only one on its vPCI bus.

Use the existing VMBus response path. Return -ENOTTY when the host
reports STATUS_NOT_SUPPORTED so PCI core may try another reset method.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 Documentation/virt/hyperv/vpci.rst  |  2 +-
 drivers/pci/controller/pci-hyperv.c | 54 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/hyperv/vpci.rst b/Documentation/virt/hyperv/vpci.rst
index b65b2126ede3..6bfee7225c14 100644
--- a/Documentation/virt/hyperv/vpci.rst
+++ b/Documentation/virt/hyperv/vpci.rst
@@ -65,7 +65,7 @@ exchange messages with the vPCI VSP for the purpose of setting
 up and configuring the vPCI device in Linux.  Once the device
 is fully configured in Linux as a PCI device, the VMBus
 channel is used only if Linux changes the vCPU to be interrupted
-in the guest, or if the vPCI device is removed from
+in the guest, or if the vPCI device is reset or removed from
 the VM while the VM is running.  The ongoing operation of the
 device happens directly between the Linux device driver for
 the device and the hardware, with VMBus and the VMBus channel
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 85d826f8f68d..790bf533a7e3 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -68,6 +68,7 @@ enum pci_protocol_version_t {
 	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
 	PCI_PROTOCOL_VERSION_1_3 = PCI_MAKE_VERSION(1, 3),	/* Vibranium */
 	PCI_PROTOCOL_VERSION_1_4 = PCI_MAKE_VERSION(1, 4),	/* WS2022 */
+	PCI_PROTOCOL_VERSION_1_5 = PCI_MAKE_VERSION(1, 5),	/* GE, device reset */
 };
 
 #define CPU_AFFINITY_ALL	-1ULL
@@ -77,6 +78,7 @@ enum pci_protocol_version_t {
  * first.
  */
 static enum pci_protocol_version_t pci_protocol_versions[] = {
+	PCI_PROTOCOL_VERSION_1_5,
 	PCI_PROTOCOL_VERSION_1_4,
 	PCI_PROTOCOL_VERSION_1_3,
 	PCI_PROTOCOL_VERSION_1_2,
@@ -90,6 +92,7 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
 #define MAX_SUPPORTED_MSI_MESSAGES 0x400
 
 #define STATUS_REVISION_MISMATCH 0xC0000059
+#define STATUS_NOT_SUPPORTED     0xC00000BB
 
 /* space for 32bit serial number as string */
 #define SLOT_NAME_SIZE 11
@@ -136,6 +139,7 @@ enum pci_message_type {
 	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
 	PCI_RESOURCES_ASSIGNED3         = PCI_MESSAGE_BASE + 0x1A,
 	PCI_CREATE_INTERRUPT_MESSAGE3   = PCI_MESSAGE_BASE + 0x1B,
+	PCI_RESET_DEVICE                = PCI_MESSAGE_BASE + 0x1C,
 	PCI_MESSAGE_MAXIMUM
 };
 
@@ -1416,6 +1420,52 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int hv_pci_reset_device(struct pci_host_bridge *bridge,
+			       struct pci_dev *pdev)
+{
+	struct hv_pcibus_device *hbus =
+		container_of(bridge->sysdata, struct hv_pcibus_device, sysdata);
+	struct pci_child_message reset = {};
+	struct hv_pci_compl comp_pkt;
+	struct pci_packet pkt = {
+		.completion_func = hv_pci_generic_compl,
+		.compl_ctxt = &comp_pkt,
+	};
+	enum hv_pcibus_state state;
+	int ret;
+
+	/* Do not take state_lock: eject holds it while removing/locking pdev. */
+	state = READ_ONCE(hbus->state);
+	if (state != hv_pcibus_probed && state != hv_pcibus_installed)
+		return -ENODEV;
+
+	init_completion(&comp_pkt.host_event);
+	reset.message_type.type = PCI_RESET_DEVICE;
+	reset.wslot.slot = devfn_to_wslot(pdev->devfn);
+
+	ret = vmbus_sendpacket(hbus->hdev->channel, &reset, sizeof(reset),
+			       (unsigned long)&pkt, VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (ret)
+		return ret;
+
+	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
+				"PCI_RESET_DEVICE");
+	if (ret)
+		return ret;
+
+	if (comp_pkt.completion_status == STATUS_NOT_SUPPORTED)
+		return -ENOTTY;
+
+	if (comp_pkt.completion_status) {
+		pci_err(pdev, "Hyper-V device reset failed: %#x\n",
+			comp_pkt.completion_status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* PCIe operations */
 static struct pci_ops hv_pcifront_ops = {
 	.read  = hv_pcifront_read_config,
@@ -2017,6 +2067,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_4:
+	case PCI_PROTOCOL_VERSION_1_5:
 		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
 					cpu,
 					hpdev->desc.win_slot.slot,
@@ -2546,6 +2597,9 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 	bridge->sysdata = &hbus->sysdata;
 	bridge->ops = &hv_pcifront_ops;
 
+	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_5)
+		bridge->reset_root_port = hv_pci_reset_device;
+
 	error = pci_scan_root_bus_bridge(bridge);
 	if (error)
 		return error;
-- 
2.56.0

