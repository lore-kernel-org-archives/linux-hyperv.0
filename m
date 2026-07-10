Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E25388374;
	Fri, 10 Jul 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711674; cv=none; b=FgTZl09KPTLLM96q4aTd3MsqTlO4a0fN2HK1i3suOOFm5QPCOTHZ6iXPbqRpWFYNvggK4L2D/BMFR9pBoDhhD669nihJp3EdQODFJ9LRcW+3Kf0Qg7QlBnxQtAFrQIr+cHywdEm5oT5+ZoxV/vlPTDwcdT7cvKVdlmRmrr/RC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711674; c=relaxed/simple;
	bh=UWj/0xJ3E/s9fNNFWLVQr/YscRyFgXX/OvTPMf1Fvbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuzPd9fVFbr0ZBVxDFjQdTSJRquuOFcCCdy5xETLwAVVvRnggPpcRhAuismm14LKvouqYWXZKYBHgRPNCzrtY2LKtAx4k6D7umOQaiUXQmtwQCn9Gh42rwwMUizNeW9t8tk5WAWjlp+NQk0vY2luiXmxLS1iAUMOZ1L3H6oVIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VBl1erQH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VBl1erQH"
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 74B1720B7169; Fri, 10 Jul 2026 12:27:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74B1720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783711665;
	bh=CIGcZUacPy7ZKSLfX1pZyU4Ol+FGeuAdAMX6DIN/vCs=;
	h=From:To:Cc:Subject:Date:From;
	b=VBl1erQHAaEaduadQeljAY3y0Qs58udnTl6bE2Rf79pvfmWf7HNX0zjcsbvJBn84U
	 NjvcI6UA0MLnuEeAHbrRWQjfpH9u4eCW2tJrrQ7vsC/vLXc8+w62YAmpcQJUJnE5s9
	 l6jBSjr/aOTQxJkY75WJrCzbgu8+tY/UrBhz5Sgw=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next v4] net: mana: Add handler for sriov configure
Date: Fri, 10 Jul 2026 12:27:29 -0700
Message-ID: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyang Zhang <haiyangz@microsoft.com>

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v4:
  Removed unnecessary pci_disable_sriov() from mana_gd_shutdown() as
  suggested by AI review.

v3:
  Updated sriov disabling paths suggested by Paolo Abeni

v2:
  No longer change VF autoprobe as discussed with Leon Romanovsky and Bjorn Helgaas.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef3b77229c1..a38d4bb74621 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2456,6 +2456,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	pci_disable_sriov(pdev);
+
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, false);
 
@@ -2525,6 +2527,27 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int err = 0;
+
+	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
+
+	if (numvfs > 0) {
+		err = pci_enable_sriov(pdev, numvfs);
+	} else {
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				 "Cannot disable SR-IOV while VFs are assigned\n");
+			return -EPERM;
+		}
+
+		pci_disable_sriov(pdev);
+	}
+
+	return err ? err : numvfs;
+}
+
 static const struct pci_device_id mana_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF2_DEVICE_ID) },
@@ -2540,6 +2563,7 @@ static struct pci_driver mana_driver = {
 	.suspend	= mana_gd_suspend,
 	.resume		= mana_gd_resume,
 	.shutdown	= mana_gd_shutdown,
+	.sriov_configure = mana_sriov_configure,
 };
 
 static int __init mana_driver_init(void)
-- 
2.34.1

