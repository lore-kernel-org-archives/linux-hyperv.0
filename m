Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2052EC0A2;
	Mon,  7 Sep 2026 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763934; cv=none; b=RpiudiLhB5dcdkPo+uXx8IJ39hzr8VTqjBaAokt5W8Ge6byPQPdDkN1IphaFKQKF6YXi6ys3gZ9TBho0TT4F90tOpFFlYQfxB3QyIU9OY928mWaaEFKg0qRqSNKvKv5ekV0teH2B/H9CB+aDUvT/Cn0r+TOuK22Rwz9PsYDOayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763934; c=relaxed/simple;
	bh=0tbKc9fZhKvoTnOKxwtOQaa2+oMH40JwveDwxJpUM1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6pDiPxl6ND0J3ybJ69ccx9uOGSe5zCUYR3HC3cXFL6HEF7boU/VbAfhX+JrkVpFnIMOLdwQEh6mV7JhPpUIIuMqLAhF2fAzw/Al05P4JAvjKzY/ueg1Jws/EHpJnfZDssp6bMIa8bBk89vCyiqv5Sx/8wujd//NpHtOHwMtg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aETJPblr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aETJPblr"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id ECEDF20B710C;
	Sun,  6 Sep 2026 23:51:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECEDF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788763893;
	bh=E4c7wIrlFU3ULdF2/N81BPKnHb8lv3UruDQAdVdOzLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aETJPblrODw/dZpUUqVs3rsgFqLEzTlKpgEOWQxGDs1u41pgApn3sSBgfzQc2WkSt
	 C8fGTrCx2s1jkFXNn22J5RSRCN1edQl7oLdFRJicocXKoB0tpxdTo6pU8cVyQe8kac
	 0MAnD7hGhnvCp48WxM4Ft6lrqQyoZyH7rziaDZsM=
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Nam Cao <namcao@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Jiri Wiesner <jwiesner@suse.de>,
	Daniel J Blueman <daniel@quora.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger inits
Date: Mon,  7 Sep 2026 06:51:29 +0000
Message-ID: <20260907065129.269262-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907065129.269262-1-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fixup_irqs() and the generic resend path (try_retrigger()) now both
falling back to irq_chip_retrigger_hierarchy(), installing it as the
irq_retrigger() callback on the outermost domain chips is no longer
required. The hierarchy walk reaches the x86 vector domain's
apic_retrigger_irq() for all of these stacked domain chips.

Remove the now redundant irq_retrigger() initializations from the outermost
domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
msi_set_affinity() is the only site that invoked the outermost chip's
irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
the x86_init_dev_msi_info() initialization can be dropped as well.

No functional change intended.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c         | 1 -
 arch/x86/kernel/apic/io_apic.c      | 2 --
 arch/x86/kernel/apic/msi.c          | 4 +---
 arch/x86/kernel/hpet.c              | 1 -
 drivers/iommu/amd/init.c            | 1 -
 drivers/pci/controller/pci-hyperv.c | 1 -
 6 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 1e273d7d6c5b3..b3ad50a874dca 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -304,7 +304,6 @@ static struct irq_chip hv_pci_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 };
 
 static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
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
index 40726dfef2733..a19e1faf98750 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2471,7 +2471,6 @@ static struct irq_chip intcapxt_controller = {
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

