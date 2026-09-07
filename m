Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BA15350B;
	Mon,  7 Sep 2026 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760089; cv=none; b=Tspd9qjI1LJCEJBbXSOZ2DefSe0+CKTw9PaaDWSnruwAAHRKBD4AItHnCGJzyLP8R0wGLQtz8gdMh7QEEGXnaSlWhjs942AVh6RL+P5vZsQDNEdClLGp2XTlfMZfvahKOetnSOtmr+d1Kdt+UkqgnyQW5eFUQGYPSBqQMwmUL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760089; c=relaxed/simple;
	bh=EnkT3PfpjHgbAy/MZsLCiXVsssiJqparqDSUJtwxkE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgRZG/FO58Lt04QvfsZJdOg47oYZFfmKHs21rMAlN6P+wEgapJkthhJraNf5r7N+35mOkhwSC/h47UKHB4AVqO022uLypIJ2uZPtysP7tsFSUEJD4zW7JXJjiSM0rEVSFq0QTs5usqvovaTU5DtmBiVYaOsY4dsaAav2IKVTVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h3gVHoAl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h3gVHoAl"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2AAB20B710C;
	Sun,  6 Sep 2026 22:47:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2AAB20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788760043;
	bh=xDNwdLh8JmVBsFDeugXrEX6DXh99FNRMDhih3my7cI8=;
	h=From:To:Cc:Subject:Date:From;
	b=h3gVHoAlefu72DM1BT66euAJxyhOchcKwFQIdFGDLtzpa5622qW8O3oXnTy26ms7R
	 WJRrsWNdsLdRgCYTUjSfJX6PtNwCZRIBx7g+RXUSJvWC4nKUKr/oLJRQmelvb4WsJe
	 3E0hBvUbqGa2L8IRu3Dp194hMYCh1SX6zVBUAAPs=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Date: Mon,  7 Sep 2026 05:47:42 +0000
Message-ID: <20260907054742.235389-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Hyper-V guests each virtual PCI bus is enumerated by its own
hv_pci_probe() call. The probe performs several synchronous host
request/response exchanges while negotiating the protocol, querying bus
relations, entering D0, and reporting allocated resources. These waits
are latency-bound rather than CPU-bound.

hv_pci registers as an ordinary VMBus driver, so driver_register() walks
matching vPCI buses and probes them sequentially while the driver's
initcall runs. On guests that expose several devices, each through its
own vPCI bus, this serialization adds the host round-trip latencies to
device initialization.

Each bus is described by its own struct hv_pcibus_device, so
independent buses can be probed concurrently. Request asynchronous
probing via PROBE_PREFER_ASYNCHRONOUS, causing the driver core to
schedule matching buses for asynchronous probe work.

On an Azure Standard_L32s_v3 guest with five vPCI targets (four NVMe
controllers and one Mellanox VF), Linux 7.2.3 was tested with one warm-up
and three measured boots per variant. The median interval from the first
hv_pci_probe() entry to the last return decreased from 2847.968 ms to
2786.709 ms, a 61.259 ms (2.15%) improvement.

Co-developed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---

Previous discussion around this change:
https://lore.kernel.org/all/20230420024037.5921-7-decui@microsoft.com/

Skipping removal of pci_rescan_remove_lock, due to possible
synchronization problems associated with this lock removal. Also, with
my current setup, I was not able to see much improvements with this
change, so keeping it for later. Asynchronous probing change is not
dependent on this.

---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 89816a2bd7cd3..056d379b3cee4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv = {
 	.remove		= hv_pci_remove,
 	.suspend	= hv_pci_suspend,
 	.resume		= hv_pci_resume,
+	.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static void __exit exit_hv_pci_drv(void)
-- 
2.43.0

