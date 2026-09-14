Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1243BDCF;
	Mon, 14 Sep 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382376; cv=none; b=KAS/mVkFpib3VuwuHcufJvpMb0PBSUeVMAJ/2XSFDpTPHl+HE5q7Unhbwr9afSF6Wrht8FJVMSJgPRIThbm2BqPVV9Zp5BWECN/y2y7xM+sH9UFXaoqTiXdP+8MYwDRDv7yZGYbWQRzSHwOfw6Fn8O7yhFlWyP2fwuzuvPMIgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382376; c=relaxed/simple;
	bh=uiEwpESSEf6K317QC8zFK098k+uBNO31qhp39aI7Rdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iJ4+I/tD4vSPHXIWFswcfwK0LlYS5+ePII6gHDmuVT9jcynXIom+eUlBqKfg+jY5rq/MMFrIpkMhOGIa9B6ptnHV7ZWaXzD6x1qwZDcFL/b4G2R16R1aWLXWXHheyDiOt91WJvmwsYm1OcKKF/8yQxgAWe+IpHAX7/NgdbyFNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CwhBIL8B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CwhBIL8B"
Received: from sahil.mshome.net (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 96C7720B7168;
	Mon, 14 Sep 2026 03:38:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96C7720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789382330;
	bh=dzKLLKoA1p3nbE8nDQTDt6uZ8N8K8Fx3g/Oash20Dhc=;
	h=From:To:Subject:Date:From;
	b=CwhBIL8Bmn4E1uRzknLFwv4nZ7GIVDhLz5lj+8aY4PEUq2ScEMjj51gMThnjYbeXt
	 S2W+bPfYJhQKj1EhkU9mNnJmaFmzsYi/POrlZ3LZM1KK4JZ8xKk3SeZaMa2MlCqYgc
	 KE6tOpi8nbbSqPI6zPkvEVnMkxkwgfonjISxkOqc=
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	namjain@linux.microsoft.com,
	mhklinux@outlook.com,
	hamzamahfooz@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI: hv: Warn when wait_for_response() waits indefinitely
Date: Mon, 14 Sep 2026 03:39:09 -0700
Message-ID: <20260914103918.3125157-1-sahilchandna@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A guest can wait indefinitely in wait_for_response() for the host to
send either a rescind message or a packet completion. If the
host does not send either, the guest can remain blocked with no
diagnostic indicating a reason.
This was observed during a guest kernel upgrade in which the
host-side application handling the PCI channel faulted, causing the
guest to never receive the completion request.
Add a warning in wait_for_response() when the wait exceeds
a timeout so that such a hang is visible in the guest's kernel log
and can be correlated with host-side state.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
---
Changes since v3:
- Change counter name
- Add reviewed-by tag
Link to v3 - https://lore.kernel.org/all/20260908113009.3005964-1-sahilchandna@linux.microsoft.com/

Changes since v2:
- Add counter based timeout instead of introducing another timer
Link to v2: https://lore.kernel.org/all/20260902115854.2629164-1-sahilchandna@linux.microsoft.com/

Changes since v1:
- Removed periodic warning to one time warning in 2 minutes
- Include vmbus relid and stuck PCI msg.
Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
 drivers/pci/controller/pci-hyperv.c | 46 ++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 89816a2bd7cd..4311c7ed4570 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1040,19 +1040,38 @@ static void put_pcichild(struct hv_pci_dev *hpdev)

 /*
  * There is no good way to get notified from vmbus_onoffer_rescind(),
- * so let's use polling here, since this is not a hot path.
+ * so let's use polling here, since this is not a hot path. If
+ * wait_for_response() has been polling for 2 minutes
+ * without either a rescind or completion, add a warning.
  */
+#define PCI_RESPONSE_WARN_POLL_COUNT 1200
+
 static int wait_for_response(struct hv_device *hdev,
-			     struct completion *comp)
+			     struct completion *comp,
+			     const char *msg_type)
 {
+	u64 counter = 0;
+
 	while (true) {
 		if (hdev->channel->rescind) {
 			dev_warn_once(&hdev->device, "The device is gone.\n");
 			return -ENODEV;
 		}

-		if (wait_for_completion_timeout(comp, HZ / 10))
+		counter++;
+
+		if (wait_for_completion_timeout(comp, HZ / 10)) {
+			if (counter > PCI_RESPONSE_WARN_POLL_COUNT)
+				dev_warn(&hdev->device,
+					 "Late %s completion arrived.\n", msg_type);
 			break;
+		}
+
+		if (counter == PCI_RESPONSE_WARN_POLL_COUNT) {
+			dev_err(&hdev->device,
+				"%s stuck waiting for response, relid = %u\n",
+				msg_type, hdev->channel->offermsg.child_relid);
+		}
 	}

 	return 0;
@@ -1518,7 +1537,8 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	if (ret)
 		return ret;

-	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
+	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event,
+				"PCI_READ_BLOCK");
 	if (ret)
 		return ret;

@@ -1607,7 +1627,8 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	if (ret)
 		return ret;

-	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
+	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
+				"PCI_WRITE_BLOCK");
 	if (ret)
 		return ret;

@@ -2624,7 +2645,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	if (ret)
 		goto error;

-	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
+	if (wait_for_response(hbus->hdev, &comp_pkt.host_event,
+			      "PCI_QUERY_RESOURCE_REQUIREMENTS"))
 		goto error;

 	hpdev->desc = *desc;
@@ -3256,7 +3278,8 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 				(unsigned long)pkt, VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (!ret)
-			ret = wait_for_response(hdev, &comp_pkt.host_event);
+			ret = wait_for_response(hdev, &comp_pkt.host_event,
+						"PCI_QUERY_PROTOCOL_VERSION");

 		if (ret) {
 			dev_err(&hdev->device,
@@ -3476,7 +3499,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (!ret)
-		ret = wait_for_response(hdev, &comp_pkt.host_event);
+		ret = wait_for_response(hdev, &comp_pkt.host_event,
+					"PCI_BUS_D0ENTRY");

 	if (ret)
 		goto exit;
@@ -3553,7 +3577,8 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
 			       0, VM_PKT_DATA_INBAND, 0);
 	if (!ret)
-		ret = wait_for_response(hdev, &comp);
+		ret = wait_for_response(hdev, &comp,
+					"PCI_QUERY_BUS_RELATIONS");

 	/*
 	 * In the case of fast device addition/removal, it's possible that
@@ -3644,7 +3669,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 				VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (!ret)
-			ret = wait_for_response(hdev, &comp_pkt.host_event);
+			ret = wait_for_response(hdev, &comp_pkt.host_event,
+						"PCI_RESOURCE_ASSIGNED");
 		if (ret)
 			break;

--
2.53.0

