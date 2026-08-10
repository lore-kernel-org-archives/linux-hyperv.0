Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528943A7F70;
	Mon, 10 Aug 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352868; cv=none; b=ONiwSDBAdFGKni9aWVz5VJnsk0oHQ7e8VGM+bDiLc/gcw4ZFFCF0UQK17F0O/Wj54q8GBB+6/7+6Ly7NCfUs0Yzs80d/mlQK7Tv/k/KpvWLAEmgs79byUy/lbiNzG6rO46I9a6P2LFpLJsC+VB2k4/5FzGuTI3NmyYOOsY3VXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352868; c=relaxed/simple;
	bh=dq/A2v5+etrksRvi7qmuduZ/iZcd5D3k4Vz3TrAHijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6CIRly+BOHD1+F4AcS8vuS3wWmXd+beUTNeFcCWfn1LC80gLoUFN2oa52Qfh2bNooT0GXi0KYBiTNeH8o4j863A8/uY3CxYMELdhzdxyyvMWtyGEIMqpwE1cOMQ5BHR6vjTZ2nNACWLP9ApWTUF7BTPsmbhLGhK5PoRH3zEM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mv6MNBpM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mv6MNBpM"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95E3520B7167;
	Mon, 10 Aug 2026 02:07:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95E3520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786352843;
	bh=96bTBIBFEOW1MixlLS37u+fHUKwiZbfrMXUEqQ5FKdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mv6MNBpMGh49OBoBNSZrTktPX2/sHn0UFTqSMpYPOimrzS7Wgt6jY/kcb9651YdU/
	 SBwec8CmDhESP2bUTPgSEDi2NrEMcObDPDxap5qTCYiByXJ+WrIaHOG6shjl0HSGAy
	 JKcfZriaGEt6wkTRFizUN147xudxZBjWKtSu2qMo=
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant irq_retrigger inits
Date: Mon, 10 Aug 2026 09:07:15 +0000
Message-ID: <20260810090716.2325295-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810090716.2325295-1-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fixup_irqs() now using irq_chip_retrigger_hierarchy() and the generic
resend path (try_retrigger()) already falling back to it, installing
irq_chip_retrigger_hierarchy() as the irq_retrigger() callback on the
outermost domain chips is no longer required. The hierarchy walk reaches
the x86 vector domain's apic_retrigger_irq() for all of these stacked
domain chips.

Remove the now redundant irq_retrigger() initializations from the outermost
domain interrupt chips.
msi_set_affinity() is the only site that invoked the outermost chip's
irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
the x86_init_dev_msi_info() initialization can be dropped as well.

No functional change intended.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/apic/io_apic.c      | 2 --
 arch/x86/kernel/apic/msi.c          | 4 +---
 arch/x86/kernel/hpet.c              | 1 -
 drivers/iommu/amd/init.c            | 1 -
 drivers/pci/controller/pci-hyperv.c | 1 -
 5 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7d7175d012288..18f49a251f23b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1857,7 +1857,6 @@ static struct irq_chip ioapic_chip __read_mostly = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= ioapic_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
@@ -1871,7 +1870,6 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_AFFINITY_PRE_STARTUP,
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db3..aad2f15eb2176 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * IRR.
 	 */
 	if (lapic_vector_set_in_irr(cfg->vector))
-		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+		irq_chip_retrigger_hierarchy(irqd);
 
 	return ret;
 }
@@ -246,7 +246,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	info->ops->msi_prepare		= x86_msi_prepare;
 
 	info->chip->irq_ack		= irq_chip_ack_parent;
-	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
 	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
 					   IRQCHIP_AFFINITY_PRE_STARTUP;
 
@@ -313,7 +312,6 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_mask		= dmar_msi_mask,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8dc7b710e1250..2bb7a6f466af3 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -509,7 +509,6 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.irq_mask = hpet_msi_mask,
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = msi_domain_set_affinity,
-	.irq_retrigger = irq_chip_retrigger_hierarchy,
 	.irq_write_msi_msg = hpet_msi_write_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
 };
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ea3377e61aa5c..0c362e86a09d9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2468,7 +2468,6 @@ static struct irq_chip intcapxt_controller = {
 	.irq_unmask		= intcapxt_unmask_irq,
 	.irq_mask		= intcapxt_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity       = intcapxt_set_affinity,
 	.irq_set_wake		= intcapxt_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 89816a2bd7cd3..cfc8fa403dad6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2119,7 +2119,6 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
 	info->ops->msi_prepare = hv_msi_prepare;
 
 	chip->irq_set_affinity = irq_chip_set_affinity_parent;
-	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
 
 	if (IS_ENABLED(CONFIG_X86))
 		chip->flags |= IRQCHIP_MOVE_DEFERRED;
-- 
2.43.0

