Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EB35CB7C;
	Sun, 13 Sep 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341779; cv=none; b=R6100a3iCqeHpi3z7N+1RoCJ2Dxb/2tl3DKgAZiB0bsTtLaJYgd/K0C1atcK086EGNASRnsnkn0pXZguvPp8KMZMFRqeintbQH2SLO6jiqzxKHkI8ka5MMaz1IISPycpPICHNs1wBaLaSg9S24C5kz0nbd8V5x0Iw3lW4bu7D7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341779; c=relaxed/simple;
	bh=Bxm9Dp+4gv6Rihz7eb8LzTishHNKgkXVgOvsjUNVdMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSxGbqg+EL4TpWwkaEJlKroNDdbqlTcZA/72jJgKlUh4NdZ4WLXTd7WutQdH2+MlmW4ZkVgdJFLDjpnRw+0MFj4pD8AITekQCAb/XZRvAjFP2XdCohU0ZYvkUFO3JKKx9wrxGeWjYOLY3lLo3A1Di1Rc8k6VQJaFZWlsVsctXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lap2MDI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lap2MDI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775361F000FF;
	Sun, 13 Sep 2026 23:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341777;
	bh=n9zpuNq15UQ+NUy8+jnOae7Bh+4oxlFew9tIKSYYuNc=;
	h=From:To:Cc:Subject:Date;
	b=lap2MDI1X/ct/OSMhIGOi+Yy0iJwHvEat6NOfaLrdqJKOpqeWPteF1YjIDBrvlh1y
	 tafWvle/KFjih4aqdX6dK8ZyTZdjw1fpKTkNmCXM3013QAPZSr5htZ6fzzuagv2pL+
	 0HmtaXqty4LYnfNScQK5Zs7kK4XvYgFkhZCBEEud2P+ztBlhxj6GLMG5KEj99/7rU9
	 F6M8/dGW9OygPkSHq4Fpixl/XzSlxNM5doDBVLf3PphBZxuu0rblEj9x2WpDbS/vRK
	 k/uZK/SjVuJNu7+N6mjJilrDgHUWu6a9lcmsGtljQBTKl5NGrGZIGMYoYbg0KlGcD0
	 Uup2WXuPec2YQ==
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
Subject: [PATCH v2] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Date: Sun, 13 Sep 2026 16:22:54 -0700
Message-ID: <20260913232255.2801797-1-wei.liu@kernel.org>
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
I found this in our internal tree, massaged the code and commit message,
and posted it.

v2: fix a compilation error
---
 drivers/pci/controller/pci-hyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 89816a2bd7cd..bb4e6ca4ac1c 100644
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
+
 	} else {
 		dev_err(dev, "Attempt to read beyond a function's config space.\n");
 	}
-- 
2.53.0

