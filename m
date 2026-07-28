Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37F43CE5C;
	Tue, 28 Jul 2026 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246695; cv=none; b=QE48/v3DxZFT2JDAMxaaLdYO3pVrQPgZrNQaWxjktpy1kvYG2/gcy8Js4vMUXC2Y5RZYLoKWyTqzN03ANm5++lz0T/UFaEUQV4R9yaPwMdpr1W3770kt1wVR9DZOCYQUzHTh/uwAtsClvhSii5ug0SYkypqV8g4554ma+Z/lIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246695; c=relaxed/simple;
	bh=5XfQmj805/XmiwOZ8dqmwgSoMzSq/PTJ7qFVAPkLUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCcH+GIk94hYzsQE0x/PAJ52oXItkSgR7wiM/sqcmcRxRrSiPkwwf1aZTLLmxDYG2SJ+RVwnQ0DsBP+6rSvlB6x9I7+U6BS7jcfhK7k7X/0f/JutnzYAjZP2J+bkdmrQMZ9Pk6YgzFc8B8L04tgxUYLtTI609R90QiTv8hLkfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eQcWfq3x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eQcWfq3x"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF14220B7168;
	Tue, 28 Jul 2026 06:51:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF14220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785246677;
	bh=x+f3kT6JGkrjwjmkavcLs41l6RxRSv37aRvm486yieA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQcWfq3xcHHAfAgO0vzNOBIGMS1bwdXHHnmRtUKeigkPvyaxDZdh+SUODqx9pzufI
	 m3DAynjmqGEEHgHk0KQKbKNZN5OMgVmkIyEPGM38bHDTRdLwga0BXYTD8pG1v8Ch61
	 gHlNWziInYFbMxi9WMTTHQXcKYHc27c2hV/87Umc=
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: x86@kernel.org,
	Jake Oshins <jakeo@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Tue, 28 Jul 2026 13:51:15 +0000
Message-ID: <20260728135117.2888175-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728135117.2888175-1-namjain@linux.microsoft.com>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.

On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
the outgoing CPU to a new target. If an interrupt still has its pending bit
set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
new target through the irqchip's irq_retrigger() callback. As the Hyper-V
PCI/MSI chip does not provide that callback, the pending interrupt is
silently dropped, which can result in lost interrupts, stalls and "No irq
handler for vector" messages during CPU hotplug.

Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on its
new target CPU via the parent x86 vector domain.

Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Cc: stable@vger.kernel.org
Suggested-by: Long Li <longli@microsoft.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad6..89816a2bd7cd3 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
 	info->ops->msi_prepare = hv_msi_prepare;
 
 	chip->irq_set_affinity = irq_chip_set_affinity_parent;
+	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
 
 	if (IS_ENABLED(CONFIG_X86))
 		chip->flags |= IRQCHIP_MOVE_DEFERRED;
-- 
2.43.0

