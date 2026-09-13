Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708C13D53C;
	Sun, 13 Sep 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337443; cv=none; b=iZiFAN07lDz5nsM5ZFjJ18C2Mapdkwew9EtpM2hp8jqUcVhvNAl/0qyNX4w/rS+LOaLjE2/4fFKLi5NlNn1YC296D+zAf/6XYnWwG4+ZZADhJyCDnGcitK9902YgHoj+ZPmHoO0hlTeSL3xFMFE2YQ6rbZl7NV6alSrZxx49blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337443; c=relaxed/simple;
	bh=LTPLLIeS0+D2RaTjFS+1qjbprC26WwrDqg95BbuxxmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAPz6I18zG/Z6bXiFoKOtDivsp4UOAh+L9Mon0GwZA3oCIbrgO3dcPUmj0hUza35HowPX81J1ql2ThDKfCJM0xJ0qRRukSxXpWIT3ykP947XOtRWBtjl5mCEEdWgPcpGvPKJz1YPYRcnKGumNrbrVVRVMaUohYeCa1ZoCGKIFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8L8k+v8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8L8k+v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E842A1F000FF;
	Sun, 13 Sep 2026 22:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337442;
	bh=18JxE81RzevAWU2z5BMCT0UMQT5Jq3ap9E/IOTFJ3yA=;
	h=From:To:Cc:Subject:Date;
	b=g8L8k+v82hptJhrVekOtWSCyP93UvwhVG/yStGX1ehaghaa2XWcCx+h5froTedah2
	 ZroQBcZXpsx4XkQ1aFNcosnkOEa2dRTbFAIWbiVfQI7We3iH5zeaXJyVgou1RAZWPv
	 Ef+qcmG+ENxYgx6yySJkASPXK1FK7yvaCUrB9q0/z5oVcYiI0TxQBIuVoqsO8DjnOg
	 hp+r30E61qzKsL9VR1S9ImR0x7czh6m37gGv2utVrG/EcHJ0/RNO/t0qUXb4mA7VZy
	 y25gNDgW0p8d6JVPkt5PCs2p+HxIBm14Ncb8pedxxHW3itVmeKhvJ58jf40xr4NqNE
	 Oi6Y62XxkXS1g==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	anirudh@anirudhrb.com,
	schakrabarti@linux.microsoft.com,
	Mukesh R <mrathor@linux.microsoft.com>,
	Asher Kariv <askariv@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Date: Sun, 13 Sep 2026 15:10:39 -0700
Message-ID: <20260913221039.2218950-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh R <mrathor@linux.microsoft.com>

Hyper-V Discrete Device Assignment (DDA) does not support legacy (INTX)
interrupts. When PCI_INTERRUPT_PIN is read, the pci-hyperv controller,
which captures configuration space accesses, returns 0 to the caller.

However, the current code only captures 8bit read access, thus 16bit/32bit
are missed, forwarded to the host/HW, and may yield a non zero value.

This fix addresses this issue, and makes sure that PCI_INTERRUPT_PIN is
hardwired to 0, while the other bytes, are those returned by the host/HW.

Signed-off-by: Asher Kariv <askariv@microsoft.com>
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 89816a2bd7cd..e6db82413add 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1240,6 +1240,16 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 			mb();
 		}
 		spin_unlock_irqrestore(&hbus->config_lock, flags);
+
+		/*
+		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0, since it
+		 * may be read using a 32bit read, which is skipped by the
+		 * above emulation.
+		 */
+		if (where <= PCI_INTERRUPT_PIN &&
+		    PCI_INTERRUPT_PIN < (where + size))
+			*((char *)val + PCI_INTERRUPT_PIN - where) = 0;
+		}
 	} else {
 		dev_err(dev, "Attempt to read beyond a function's config space.\n");
 	}
-- 
2.53.0

