Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCE3B895D;
	Wed,  9 Sep 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936313; cv=none; b=a0PY2C73ztWrsUegwLBlEVxvO2U8Oj41ke/BQTquoIYua6k23XMpxOP2nkEdV/S2osy0Ud3Wpr+cX0VAZ0U8qbcOJEx5slD+jDWbeiFfBTVEhn/5mgdIXF8hIokEKw5v6dG36yHIW14RhAHYNuBa27Un+1dDjPfjCo6wkmSlc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936313; c=relaxed/simple;
	bh=/DLIok3k4tdCoOMkF2K/QrJWNryia6Ild8zWY6ve8M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfF5R01r2ahQzDSU6dJC4lkvaypxCaYVciC0bxGYNaCX4YXdYYFiuNOKZUB1Si+If325IeOyXILIyJkZQWR32QJKCbk+KSVLbM+sBf9lk7vXTDklJR5Dgy13pOy+Wpr0I5vEGFPKYhT2kK0/YmAcPYM8cxKa0F4XjHRM9UyckNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p/81C5N0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p/81C5N0"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3D7220B712B;
	Tue,  8 Sep 2026 23:44:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3D7220B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788936271;
	bh=vKHuFOw8t4T9qpNBzxIJe+5gzUOU1w5bceovfgKqwGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/81C5N0Nhb4PASLj2y38DpLCycOVHsXzvYXVoy+C9heCL77FlV2FBK67UJyIpUhA
	 Z/H+GUgqQJ6QzQSGdt5CW8hlUULng9CBp/ttGnI8INXMgc0EAhjGIjcnwXhIApzALh
	 gwU1rACPwIWjeDatrhC7Txe7TzHBNjAzBVMTiQGM=
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
Subject: [PATCH v4 1/4] x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
Date: Wed,  9 Sep 2026 06:44:45 +0000
Message-ID: <20260909064448.1004-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909064448.1004-1-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hyper-V root partition vPCI MSI irqchip lost its irq_retrigger()
callback when it was converted to msi_create_parent_irq_domain(). The
callback was present on the original irqchip and was dropped during that
conversion.

On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
the outgoing CPU to a new target. If an interrupt still has its pending bit
set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
new target through the irqchip's irq_retrigger() callback. As the root
partition PCI/MSI chip no longer provides that callback, the pending
interrupt is silently dropped, which can result in lost interrupts, stalls
and "No irq handler for vector" messages during CPU hotplug.

Restore irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
the root partition PCI/MSI irqchip, so that a pending interrupt is resent
on its new target CPU via the parent x86 vector domain.

Fixes: 4691db0704ac ("x86/hyperv: Switch to msi_create_parent_irq_domain()")
Cc: stable@vger.kernel.org
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dca..6d790636c8b95 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -316,6 +316,7 @@ static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 
 	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
+	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
 
 	info->ops->msi_prepare = pci_msi_prepare;
 
-- 
2.43.0

