Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBF36A364;
	Fri, 28 Aug 2026 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952258; cv=none; b=Jetlurq0dLow6d/xD/hBxIzKzI2Z1PpqW6GToJrjxfr2LvyTeGDxw8yYlP0aVpn495+7EO5zYZr3X+V09fbjBkIRmMDR9R9OEcQeFNCSdGUiHuFV4Yc9n73TW1vgy/WTe2fgTd/gnJrSVbRiLy7AS3ckOQxRkKlQAJ9zLCg+iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952258; c=relaxed/simple;
	bh=khsePphpghxx00y1hn1YuBpJNWFSJZh9he/T1ccyMYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNoBXW6krCYG1Gq1oq9vDfpT68GFS6MuHAkxXMGSNO/0kBChNWnHR1GntAFuMEGc/3ITIH5gCXgmtMpz2m1wsRAkr2yUB34M/NkFIuvefKlYlvJCk5ojR2rEQqtAciDZPlfAiRAUFZspvZ/7xJCvHfArbkWTpdDBxri1EGLFxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 1CC4420B7167; Fri, 28 Aug 2026 14:23:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CC4420B7167
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Advertise the SR-IOV capability for CoCo VMs
Date: Fri, 28 Aug 2026 14:23:25 -0700
Message-ID: <20260828212325.2309515-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This basically reverts the Feb 2021 change:
commit 96854bbda24f ("hv_netvsc: Restrict configurations on isolated guests")

In Feb 2021, PCI device assignment for CoCo VMs on Hyper-V was not
supported: if the host offered a PCI VF NIC device to the VM, the VM
couldn't handle it properly, so the 2021 commit was made to tell the host
"I'm unable to handle SR-IOV NICs, so please don't offer a VF to me".
If the host offers a VF NIC to the VM anyway, the change to
netvsc_receive_inband() ignores the VF NIC.

Since Mar 2023, the VM is able to support PCI device assignment due to
commit 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs")
and related commits, so hv_netvsc can functionally work with a VF NIC, but
we haven't advertised the SR-IOV capability because the MANA NIC driver
(drivers/net/ethernet/microsoft/mana/) hadn't been hardened, so a
malicious MANA NIC might be able to attack the VM.

Recently, we have finished hardening the MANA driver, so we can safely
use the MANA NIC in a CoCo VM now. Note: currently the MANA driver in a
CoCo VM still uses bounce buffering (i.e. shared decrypted memory)
for DMA. In the future, it will be able to use private encrypted
memory for DMA with the help of TDISP.

Now, advertises the SR-IOV capability for CoCo VMs.

Note: for MANA to work properly for CoCo VMs, the following earlier
commits are also required:
commit 2e2a83b4998a ("net: mana: Validate the packet length reported by the NIC")
commit c72a0f09c57f ("net: mana: Sync page pool RX frags for CPU")

Note: the host might offer a VF NIC device that's not MANA -- in that
case, if the corresponding VF NIC driver isn't hardened for CoCo VMs,
the driver should be blacklisted in CoCo VMs.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 5cd084e5696c..fc6548b16c91 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -625,10 +625,7 @@ static int negotiate_nvsp_ver(struct hv_device *device,
 	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q = 1;
 
 	if (nvsp_ver >= NVSP_PROTOCOL_VERSION_5) {
-		if (hv_is_isolation_supported())
-			netdev_info(ndev, "SR-IOV not advertised by guests on the host supporting isolation\n");
-		else
-			init_packet->msg.v2_msg.send_ndis_config.capability.sriov = 1;
+		init_packet->msg.v2_msg.send_ndis_config.capability.sriov = 1;
 
 		/* Teaming bit is needed to receive link speed updates */
 		init_packet->msg.v2_msg.send_ndis_config.capability.teaming = 1;
@@ -1665,10 +1662,7 @@ static void netvsc_receive_inband(struct net_device *ndev,
 		break;
 
 	case NVSP_MSG4_TYPE_SEND_VF_ASSOCIATION:
-		if (hv_is_isolation_supported())
-			netdev_err(ndev, "Ignore VF_ASSOCIATION msg from the host supporting isolation\n");
-		else
-			netvsc_send_vf(ndev, nvmsg, msglen);
+		netvsc_send_vf(ndev, nvmsg, msglen);
 		break;
 	}
 }
-- 
2.34.1

