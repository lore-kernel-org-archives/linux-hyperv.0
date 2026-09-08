Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E574BCADC;
	Tue,  8 Sep 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867031; cv=none; b=ILRVl2aVEUu2uQuoSIW/6MEM0N55lZSBNkrzYZNzr3l9cYuaYM65/1wMixkca2XP5GRcvh2/6tcqDn3PnCg688jsF3W3IDAroPpGfILRpXIw3nF9co1OpzmUNU/Nz962uF0T5VceZdfSG1Fasng/VHPkO6dKaV/sjkuLympxrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867031; c=relaxed/simple;
	bh=Ay8pFY6Von/u+7sbCqK+9uCgDSeE1cuiGZedB8gaMqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nKFQ35m+MkttKZfKnWLkp6Ff44RlYmW7XsB+NjupqZBvbNH1tfgVWu4z8Jph/GKU7CqAb+sKBmnHgiZCtvbQWTz3gSKoak6mHm7RcnJ74ZZ6MZcO+W6rndubKj8txdxq1f74VTeobAbiIzRRxpzEJsOnKWgI+w+wX3cry/0XUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G/pw3QcZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G/pw3QcZ"
Received: from sahil.mshome.net (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id E818920B7128;
	Tue,  8 Sep 2026 04:29:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E818920B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788866980;
	bh=uOapS0IgUvTjqexlIhF5LIne+9HLwLBjWTm6WhdXXKw=;
	h=From:To:Subject:Date:From;
	b=G/pw3QcZr6XKQQlu90qxqirugKnMbYjT4Vh77i829FiARqVn/9KLa7YkdNNKewi0q
	 77Qv+aaaRdRafouRl1IhAzwnVRacrp2OjuB+Yhf8TflRBD2EaP1yhOCkkJQCN9Ghzx
	 SX8eWppa1d9VZ1caICCZXRnd+39MZLkN0JWDe+3U=
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
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
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com
Subject: [PATCH v3] PCI: hv: Warn when wait_for_response() waits indefinitely
Date: Tue,  8 Sep 2026 04:30:06 -0700
Message-ID: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
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
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
---
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
index 89816a2bd7cd..bd07402c47ed 100644
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
+#define PCI_RESPONSE_HANG_TICKS 1200
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
+			if (counter > PCI_RESPONSE_HANG_TICKS)
+				dev_warn(&hdev->device,
+					 "Late %s completion arrived.\n", msg_type);
 			break;
+		}
+
+		if (counter == PCI_RESPONSE_HANG_TICKS) {
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

