Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5274749EA;
	Fri, 24 Jul 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934532; cv=none; b=A873TKC2BW3B1KArPBgLevoN9c0zqWj6VIxhVLhiWPGldJXia7KcQThkOwnxS7svMqPXvIpjvJ+61AHybLAExbqQfODm+0ffjY057UL5edUNx2BiXlwmlrDLbZn/5Lceen1KaLLPj9magx9TZ9ez6BBWECKdh0b9icyYPiop/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934532; c=relaxed/simple;
	bh=kA2PC3Yq4aekJ0LSwKqPo/9+f9rdtXchnZdxif8T4sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJbzK2cb9Y6N3z0hw/KTvDEXUZFzWgWFc/M9nS2uJadTTdMFBU8NAGEh/tWBK8Fix/SGlvjqmo09O5oR/j+sGvXXxyokrAbgZ2q43AP37MJ4ETSxwHZTRlcZCQbuAvANRTMf7xNDjHX0wrC4zzYJtEWkyTr8oo3ZFviRQ+W+dsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrDkVLPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrDkVLPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E7F1F00A3A;
	Fri, 24 Jul 2026 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934529;
	bh=zZdyILNKSNSq+eVOw31HS9NlAG8NhPjrh34aSPFRWxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NrDkVLPWcmPUV1XG6oYrGspHTjjsgk/RuDnCuRV9iT0yeTbIOH1fs7s3cLqVQt3Y1
	 pwfCQpRaK92vWC9lAcWt6BjS+pXV2BxS8vsmmZJdacgUn/iz6wrIKV0aje+0vWwQle
	 kXR2AZhdfscW9iWeZVIwHBgo2CuKC8MZjirHXdRC9yCCbBUF1OvNVdQ3He3HjNH7ug
	 mIg9jU0nbFgr9bADiAyKW+u2CFphePfblF4lTzQ4JgSKrc3o2N0cMxsSCSpULzLX9P
	 n0vmKp33VumdTzseffPAFRkftCp4RKLdW9moGRW0z8sIxD7Fa+5ejk2s2CSa6X2wYv
	 pROA1+DDz6AXQ==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	linux-pci@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
Date: Fri, 24 Jul 2026 16:08:43 -0700
Message-ID: <20260724230844.3259741-3-wei.liu@kernel.org>
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

Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for projected
PCI functions. Negotiate the new protocol version and issue the request
through the vPCI VMBus channel from the PCI controller reset callback.

Use the existing VMBus response path. Return -ENOTTY when the host reports
STATUS_NOT_SUPPORTED so PCI core may try another reset method.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 Documentation/virt/hyperv/vpci.rst  |  2 +-
 drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

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
index cfc8fa403dad..d3c0fd5e1d8e 100644
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
 
@@ -1397,10 +1401,66 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int hv_pcifront_reset(struct pci_dev *pdev, bool probe)
+{
+	struct hv_pcibus_device *hbus =
+		container_of(pdev->bus->sysdata, struct hv_pcibus_device, sysdata);
+	struct pci_child_message reset = {};
+	struct hv_pci_compl comp_pkt;
+	struct pci_packet pkt = {
+		.completion_func = hv_pci_generic_compl,
+		.compl_ctxt = &comp_pkt,
+	};
+	enum hv_pcibus_state state;
+	int ret;
+
+	/* Device reset was added in vPCI protocol version 1.5. */
+	if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_5)
+		return -ENOTTY;
+
+	/* Hyper-V exposes projected functions directly on the root bus. */
+	if (!pci_is_root_bus(pdev->bus))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
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
+	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
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
 	.write = hv_pcifront_write_config,
+	.reset = hv_pcifront_reset,
 };
 
 /*
@@ -1996,6 +2056,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		break;
 
 	case PCI_PROTOCOL_VERSION_1_4:
+	case PCI_PROTOCOL_VERSION_1_5:
 		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
 					cpu,
 					hpdev->desc.win_slot.slot,
-- 
2.53.0

