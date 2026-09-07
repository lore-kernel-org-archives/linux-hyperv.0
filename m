Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12E400E0D;
	Mon,  7 Sep 2026 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763916; cv=none; b=A9MBfkPn9fSGqCae3CxbOptrfS7Ts+MhdfWJEYx3wYZ7ZPHXe4PTMX8fGnfXC/x7K9CfnIvYD2BFqD0IA3MKLZ1UGacZYkqg0m53syjxGOcd0zQ9fxskav8hCVXI+y9+8WCyj2BtNNBTr4Ayb2V94VKne4Yq5vxLfsRye3zr/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763916; c=relaxed/simple;
	bh=scDfxyhNg1bG79fwu6qx21uFWXyGYIjw4uigagAZxBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMpw+CNRD+oFKs5FO1aq3PpBDp/LPfEH5NnXe2TN0AKonkk4StCQuEB1aQ23j92rXo22XjaXZpF+kjTm2JSd09HQbr5z9K75IphGN1neGmAAGI39hB+E0zWaijlEZC40+gVp8MbV70AZtokg+/J/qc5POsf/xpn4hHyCoopp2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LSvcmFN1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LSvcmFN1"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C88920B7129;
	Sun,  6 Sep 2026 23:51:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C88920B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788763874;
	bh=kwT1ACYBFBE0L6UHReIYgcjonQdxzEfTZoRpDkWPd7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSvcmFN1tatrDZPNQrB/lmid695ocnAeP+m9i/dbMsKpruBmXoaSvofS0YkcwNnaE
	 1FIHeelSKFsY8Pssto3RI56QMvKapdznrUwchtbEeX17quGtiqGdaYnjKscZq11DcF
	 a01SSKX9L7S516IfUG25FYZWx6JBV7BTgtLCds7w=
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
Subject: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
Date: Mon,  7 Sep 2026 06:51:27 +0000
Message-ID: <20260907065129.269262-2-namjain@linux.microsoft.com>
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
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dca..1e273d7d6c5b3 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -304,6 +304,7 @@ static struct irq_chip hv_pci_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 };
 
 static bool hv_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
-- 
2.43.0

