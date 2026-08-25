Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2201F3D56;
	Tue, 25 Aug 2026 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635143; cv=none; b=A25gYvUtU8hgUjMqN/7qsuhC88XZYyJSQW6oJaST8wKFItuGFLtZdsohc+Ih/nV3fhE09bd3iDnwbcf8KLigVkrbSXdftaJ+Pi6Oe8qfczDFZvsxw7kUfqBW7diTVrFOdkavGi2VozDICmIxWrivLtBNRbaFlYJQEFwmjWdqDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635143; c=relaxed/simple;
	bh=8DgmtUn3Fzm43q42Nhr/eVs7RwM+IyYFXBcQi5BHGRQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fhsAiuDrr7oQiqbvDGGWL3dFP99tumDS+J9rBk0hoKoGMX0pzilzaBDgTgNFITPqA1ScAJI2SnGzIZBhhiHW4aiCpkK5B2Tep0w0kBNVbKnWxK32UzeSz5KQ7jvv9rkS8Gc5ieKVTzV8P7so6faCHbTMFPPzquRrhFFRzhVW9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hp/57e7r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hp/57e7r"
Received: from sahil.mshome.net (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id C429E20B7166;
	Mon, 24 Aug 2026 22:18:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C429E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787635110;
	bh=9BxmoeNKcrVz0BFb+VjuMoWpZF9NlmX83HbgkVBiwLo=;
	h=From:To:Subject:Date:From;
	b=hp/57e7raKygHgltk2moRgCuREsWghbZtRTUF/8W6GZv63FdgfP3apiV1P8By1NVd
	 6OklWSrVc0XiBrwqV3ory43WUdxTsBwgNDZUA4+/tc/xdHIXKwymXUoOFXzyGVAzub
	 D9DnjfdbOegiUhlSI9X3byQSQlnC/5PExSHReiBs=
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
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
Date: Mon, 24 Aug 2026 22:17:00 -0700
Message-ID: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
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
Add a periodic warning in wait_for_response() when the wait exceeds
a timeout so that such a hang is visible in the guest's kernel log
and can be correlated with host-side state.

Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
---
This was sent earlier upstream [1]
[1] https://lore.kernel.org/linux-hyperv/20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com/
---
 drivers/pci/controller/pci-hyperv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..c4fba0039164 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1040,11 +1040,18 @@ static void put_pcichild(struct hv_pci_dev *hpdev)

 /*
  * There is no good way to get notified from vmbus_onoffer_rescind(),
- * so let's use polling here, since this is not a hot path.
+ * so let's use polling here, since this is not a hot path. If
+ * wait_for_response() has been polling for PCI_RESPONSE_HANG_TIMEOUT_SEC
+ * without either a rescind or completion, add a periodic warning.
  */
+#define PCI_RESPONSE_HANG_TIMEOUT_SEC 300
+
 static int wait_for_response(struct hv_device *hdev,
 			     struct completion *comp)
 {
+	unsigned long delay = secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
+	u64 timeout = get_jiffies_64() + delay;
+
 	while (true) {
 		if (hdev->channel->rescind) {
 			dev_warn_once(&hdev->device, "The device is gone.\n");
@@ -1053,6 +1060,11 @@ static int wait_for_response(struct hv_device *hdev,

 		if (wait_for_completion_timeout(comp, HZ / 10))
 			break;
+
+		if (time_after64(get_jiffies_64(), timeout)) {
+			dev_warn(&hdev->device, "PCI stuck waiting for response.\n");
+			timeout = get_jiffies_64() + delay;
+		}
 	}

 	return 0;
--
2.53.0
